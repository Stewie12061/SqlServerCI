IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LAVOGETSALES_SAVI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LAVOGETSALES_SAVI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Đức Thông on 31/08/2020: Viết lại báo cáo doanh số cho SAVI
--	EXEC LAVOGETSALES_SAVI 'SV0', 'asoftadmin', '2014-12-25 11:57:25.213', '2015-12-25 11:57:25.213', '', '%'	
--	Modified by Đức Thông on 01/10/2020: Lấy doanh số, doanh thu trong hóa đơn bán hàng
--	Modified by Đức Thông on 12/10/2020: Tách phần lấy doanh thu, doanh số ra 2 bảng tránh trường hợp doanh số bị dup do AT9000 tách dòng
--	Modified by Hoài Phong on 12/03/2021: bỏ lấy user trong table AT0083 đi vì trường hợp double  user báo cáo sai
--  Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE LAVOGETSALES_SAVI (
	@DivisionID VARCHAR(50)
	,@user_id VARCHAR(50)
	,@from_date DATETIME
	,@to_date DATETIME
	,@route_id VARCHAR(50)
	,@customer_id VARCHAR(50)
	)
AS
DECLARE @sSQL NVARCHAR(MAX)
	,@sSQL1 NVARCHAR(1000) = ''

IF (
		ISNULL(@from_date, '') <> ''
		AND ISNULL(@to_date, '') <> ''
		)
	SET @sSQL1 = 'AND CONVERT(VARCHAR, AP01.order_created_date, 112) BETWEEN ''' + CONVERT(VARCHAR, @from_date, 112) + ''' AND ''' + CONVERT(VARCHAR, @to_date, 112) + ''' '
ELSE IF (
		ISNULL(@from_date, '') = ''
		AND ISNULL(@to_date, '') <> ''
		)
	SET @sSQL1 = 'AND CONVERT(VARCHAR, AP01.order_created_date, 112) <= ''' + CONVERT(VARCHAR, @to_date, 112) + ''' '
ELSE IF (
		ISNULL(@from_date, '') <> ''
		AND ISNULL(@to_date, '') = ''
		)
	SET @sSQL1 = 'AND CONVERT(VARCHAR, AP01.order_created_date, 112) >= ''' + CONVERT(VARCHAR, @from_date, 112) + ''' '

IF ISNULL(@route_id, '') <> ''
	SET @sSQL1 = @sSQL1 + '
	AND AP01.route_id = ''' + @route_id + ''''

IF (ISNULL(@customer_id, '') = '')
BEGIN
	SET @customer_id = '%'
END

SET @sSQL = '
	SELECT order_id, order_no, SUM(sale_value) OVER() sale_total_value, SUM(revenue_value) OVER() revenue_total_value, A.*
	FROM
	(
		SELECT [user_id], order_id, order_no,
			B.sale_value AS sale_value,
			SUM(A90.ConvertedAmount) AS revenue_value, AP01.note,
			AP01.customer_id, A02.ObjectName as customer_name, 
			AP01.VoucherNo AS voucher_no,
			AP01.order_created_date
		FROM APT0001 AP01 WITH (NOLOCK)
		LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = AP01.DivisionID AND O02.AppInheritOrderID = AP01.order_id AND O02.ReAPK = AP01.APK
		LEFT JOIN AT9000 A90 WITH (NOLOCK) ON A90.DivisionID = O02.DivisionID AND A90.OTransactionID = O02.TransactionID AND A90.TableID = ''AT9000''
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = AP01.customer_id
		LEFT JOIN AT0083 A83 WITH (NOLOCK) ON AP01.user_id = A83.LstInheritUserID
		LEFT JOIN (
					SELECT SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount, 0)) AS sale_value,
						order_id AS order_id1
				FROM APT0001 AP01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = AP01.DivisionID AND O02.AppInheritOrderID = AP01.order_id AND O02.ReAPK = AP01.APK
				LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = AP01.customer_id				
				WHERE AP01.DivisionID = ''' + @DivisionID + '''
					AND (AP01.[user_id] = ''' + @user_id + ''')
					AND AP01.customer_id LIKE ''' + ISNULL(@customer_id, '%') + '''
					' + @sSQL1 + 
			'
					
				GROUP BY order_id
				
		) B ON AP01.order_id = B.order_id1
		WHERE AP01.DivisionID = ''' + @DivisionID + '''
			AND (AP01.[user_id] = ''' + @user_id + '''
			OR A83.UserID = ''' + @user_id + ''')
			AND AP01.customer_id LIKE ''' + ISNULL(@customer_id, '%') + '''
			' + @sSQL1 + 
	'
			
		GROUP BY [user_id], order_id, order_no, AP01.note, AP01.customer_id, A02.ObjectName, AP01.VoucherNo, B.sale_value, order_created_date
	)A
	ORDER BY A.order_created_date desc
	'

EXEC (@sSQL)

PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
