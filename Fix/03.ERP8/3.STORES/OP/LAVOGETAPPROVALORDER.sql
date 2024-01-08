IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LAVOGETAPPROVALORDER]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LAVOGETAPPROVALORDER]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







--	LAVOGETAPPROVALORDER 'LV','nv0005', '2015-05-01 00:00:00.000','2015-05-31 00:00:00.000', '', '%', ''
---- Modified by Đức Thông on 08/08/2020: Chỉnh sửa lấy danh sách đơn hàng duyệt theo các user quản lí
---- Modified by Đức Thông on 10/08/2020: Lấy thêm đơn hàng của user trưởng nhóm
---- Modified by Đức Thông on 11/08/2020: Lấy thêm trạng thái đơn hàng trên APP đã được kế thừa hay chưa
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE LAVOGETAPPROVALORDER
(
	@DivisionID VARCHAR(50),
	@user_id VARCHAR(50),
	@from_date DATETIME,
	@to_date DATETIME,
	@route_id VARCHAR(50),
	@customer_id VARCHAR(50),
	@order_status VARCHAR(50),
	@inherit_status VARCHAR(50)
)
AS


DECLARE @sSQL NVARCHAR(MAX), @sWhere NVARCHAR(1000) = ''

IF ISNULL(@customer_id, '') <> '' AND @customer_id <> '%' SET @sWhere =  @sWhere + '
AND A01.customer_id LIKE '''+@customer_id+''' '
 
IF ISNULL(@order_status, '') <> ''  SET @sWhere =  @sWhere + '
AND A01.OrderStatus = '''+@order_status+''' '

IF ISNULL(@inherit_status, '') <> ''  
BEGIN
	IF ISNULL(@inherit_status, '') = '0' -- Đã kế thừa
		SET @sWhere =  @sWhere + ' AND ISNULL(O02.ReAPK, '''') <> '''''
	ELSE
		SET @sWhere =  @sWhere + ' AND ISNULL(O02.ReAPK, '''') = '''''

END
	 
IF ISNULL(@route_id,'') <> ''  SET @sWhere= @sWhere + '
AND A01.route_id LIKE '''+@route_id+''' '
 
SET @sSQL =N' 
SELECT DISTINCT A01.[user_id], A01.order_id, A01.order_no, A02.ObjectName customer_name, A01.order_created_date, MAX(A01.DeliveryStatus) AS DeliveryStatus,
   A01.OrderStatus as order_status, A01.VoucherNo, CASE WHEN ISNULL(O02.ReAPK, '''') = '''' THEN N''Chưa kế thừa'' ELSE N''Đã kế thừa'' END AS InheritStatus
FROM APT0001 A01
	LEFT JOIN OT2002 O02 ON A01.APK = UPPER(O02.ReAPK)
	INNER JOIN AT0083 ON AT0083.UserID = ''' + @user_id + ''' AND (A01.user_id = AT0083.LstInheritUserID OR A01.user_id = ''' + @user_id + ''')
	LEFT JOIN AT1202 A02 ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A01.customer_id
WHERE A01.DivisionID = '''+@DivisionID + '''' + @sWhere+
'
AND CONVERT(VARCHAR, A01.order_created_date, 112) BETWEEN '''+CONVERT(VARCHAR, @from_date, 112)+''' AND '''+ CONVERT(VARCHAR, @to_date, 112) +

'''
GROUP BY A01.[user_id], A01.order_id, A01.order_no, A02.ObjectName, A01.order_created_date, A01.OrderStatus, A01.VoucherNo, O02.ReAPK
'
EXEC (@sSQL)
PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
