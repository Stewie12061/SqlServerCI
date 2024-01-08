IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[LAVOGETSALES_MP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LAVOGETSALES_MP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Hải Long.
---- Created Date Sunday 20/12/2016
---- Purpose: Tra cứu doanh số (Customize: Mạnh Phương)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

--	LAVOGETSALES_MP 'ANG', 'asoftadmin', '2014-12-25 11:57:25.213', '2015-12-25 11:57:25.213', 'T.001', '%'

CREATE PROCEDURE LAVOGETSALES_MP
(
	@DivisionID VARCHAR(50),
	@user_id VARCHAR(50),
	@from_date DATETIME,
	@to_date DATETIME,
	@route_id VARCHAR(50),
	@customer_id VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX), 
@sSQL1 NVARCHAR(1000) = '',
@sSQL2 NVARCHAR(1000) = ''

IF (ISNULL(@from_date, '') <> '' AND ISNULL(@to_date, '') <> '')
	SET @sSQL1 = 'AND CONVERT(VARCHAR, AP01.order_created_date, 112) BETWEEN '''+CONVERT(VARCHAR, @from_date, 112)+''' AND '''+CONVERT(VARCHAR, @to_date, 112)+''' '
ELSE IF (ISNULL(@from_date, '') = '' AND ISNULL(@to_date, '') <> '')
		SET @sSQL1 = 'AND CONVERT(VARCHAR, AP01.order_created_date, 112) <= '''+CONVERT(VARCHAR, @to_date, 112)+''' '
	ELSE IF (ISNULL(@from_date, '') <> '' AND ISNULL(@to_date, '') = '')
		SET @sSQL1 = 'AND CONVERT(VARCHAR, AP01.order_created_date, 112) >= '''+CONVERT(VARCHAR, @from_date, 112)+''' '

IF ISNULL(@route_id,'')<> ''  SET @sSQL1=@sSQL1 + '
AND AP01.route_id = '''+@route_id+''''	

IF(ISNULL(@customer_id, '') = '')
begin 
	set @customer_id = '%'
END

SET @user_id = LTRIM(RTRIM(@user_id))
IF EXISTS (SELECT AT0010.UserID FROM AT0010 WITH (NOLOCK) WHERE AT0010.DivisionID = @DivisionID AND AdminUserID = @user_id)
BEGIN
	SET @sSQL2 = '
	SELECT '''+@user_id+''' AS UserID UNION ALL SELECT AT0010.UserID FROM AT0010 WITH (NOLOCK) WHERE AT0010.DivisionID = '''+@DivisionID+''' AND AdminUserID = '''+@user_id+''''  	
END
ELSE
BEGIN
	SET @sSQL2 = 'SELECT '''+@user_id+''' AS UserID'       		
END


--PRINT @sSQL2

SET @sSQL = '
SELECT order_id, order_no, SUM(sale_value) OVER() sale_total_value, SUM(revenue_value) OVER() revenue_total_value, A.*
FROM
(
	SELECT [user_id], order_id, order_no,
		SUM(ISNULL(O02.ConvertedAmount,0)) sale_value,
		SUM(ISNULL(A90.ConvertedAmount,0)) revenue_value, AP01.note,
		AP01.customer_id, A02.ObjectName as customer_name
	FROM APT0001 AP01 WITH (NOLOCK)
	LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = AP01.DivisionID AND O02.AppInheritOrderID = AP01.order_id AND O02.ReAPK = AP01.APK
	LEFT JOIN AT9000 A90 WITH (NOLOCK) ON A90.DivisionID = O02.DivisionID AND A90.OTransactionID = O02.TransactionID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = AP01.customer_id
	WHERE AP01.DivisionID = '''+@DivisionID+'''
	AND AP01.[user_id] IN ('+@sSQL2+')
	AND AP01.customer_id LIKE '''+ISNULL(@customer_id, '%')+'''
	'+@sSQL1+'
	GROUP BY [user_id], order_id, order_no, AP01.note, AP01.customer_id, A02.ObjectName
)A
ORDER BY A.order_no
'

EXEC (@sSQL)
PRINT (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
