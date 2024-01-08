IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0163]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0163]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load grid danh sách hóa đơn lập từ app mobile (OF0137)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: by Thanh Sơn on 24/12/2014
---- Modified on 04/09/2015 by Huỳnh Tấn Phú: Thay thế câu select lồng bằng left join
---- Modified on 12/04/2016 by Kim Vu: Rename move tu LAVO len chuan 8.1
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Thông on 31/07/2020: Chỉ được kế thừa những đơn hàng đã duyệt trên app
---- Modified by Đức Thông on 08/08/2020: Updated: Bỏ filter đơn hàng theo @SaleEmployeeID
----									  Updated: Filter ngày đơn hàng theo ngày thay vì theo ngày giờ
---- Modified by Đức Thông on 12/08/2020: Lấy số chứng từ lên master kế thừa đơn hàng
---- Modified by Nhựt Trường on 04/01/2021: Bổ sung thêm điều kiện DivisionID khi join bảng.
---- Modified by Nhật Thanh on 18/02/2022: So sánh không so điều kiện giờ
---- Modified by Nhật Thanh on 21/02/2022: Bổ sung ngày tạo đơn hàng cho angel
---- Modified by Nhật Thanh on 22/02/2022: Tách trường hợp load cho angel
---- Modified by Nhật Thanh on 04/03/2022: [ANGEL] lấy diễn giải bằng ghi chú 1 của đối tượng trong at1202
---- Modified by Nhật Thanh on 29/03/2022: [ANGEL] lấy diễn giải bằng diễn giải đơn hàng app
---- Modified by Nhật Quang on 03/01/2023: Bổ sung lấy trường fullname từ bảng AT1103 và thêm DivisionID @@@
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
  OP0163 'LG','ASOFTADMIN', '%', '%', '2014-12-24 00:00:06.157', '2014-12-24 11:56:06.157'

*/
CREATE PROCEDURE OP0163
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@SaleEmployeeID VARCHAR(50),
	@ObjectID VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
DECLARE @CustomerName as INT;
SELECT @CustomerName = CustomerName FROM CustomerIndex

-- Khách hàng ANGEL
IF @CustomerName = 57
BEGIN
SELECT order_id OrderID,  order_no OrderNo, order_created_date OrderDate, customer_id ObjectID, A02.ObjectName,
	A01.[user_id] SaleEmployeeID, A03.UserName SaleEmployeeName, A01.[priority] ImpactLevelID, VoucherNo,
	CASE WHEN ISNULL(A01.[priority],0) = 0 THEN N'Bình thường'
		    WHEN ISNULL(A01.[priority],0) = 1 THEN N'Khẩn 1'
		    WHEN ISNULL(A01.[priority],0) = 2 THEN N'Khẩn 2'
		    WHEN ISNULL(A01.[priority],0) = 3 THEN N'Khẩn 3'
		    END AS ImpactLevelName,A01.Note Notes, A01.discount_percent DiscountPercent,
		    A01.discount_money DiscountAmount, A01.CreateDate
FROM APT0001 A01 WITH (NOLOCK)
LEFT JOIN AT1405 A03 WITH (NOLOCK) ON A03.DivisionID = A01.DivisionID AND A03.UserID = A01.[user_id]
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (@DivisionID, '@@@') AND A02.ObjectID = A01.customer_id
LEFT JOIN OT2002 OT20 WITH (NOLOCK) ON OT20.DivisionID = A01.DivisionID AND OT20.AppInheritOrderID = A01.order_id

WHERE A01.DivisionID = @DivisionID
AND OT20.AppInheritOrderID IS NULL

AND A01.[user_id] LIKE ISNULL(@SaleEmployeeID,'%')
AND A01.customer_id LIKE ISNULL(@ObjectID,'%')
AND CONVERT(VARCHAR, A01. order_created_date, 112) BETWEEN CONVERT(VARCHAR, @FromDate, 112) AND CONVERT(VARCHAR, @ToDate, 112)
--AND A01.order_id NOT IN (SELECT ISNULL(AppInheritOrderID, '') FROM OT2002 WHERE OT2002.DivisionID = A01.DivisionID)

GROUP BY order_id, order_no, order_created_date, customer_id, A02.ObjectName, A01.[user_id], A03.UserName, A01.[priority],
		 A01.Note, A01.discount_percent,A01.discount_money, A01.CreateDate,VoucherNo

END
ELSE
-- Khách hàng SAVI
IF @CustomerName = 44
BEGIN
	SELECT order_id OrderID
	, order_no OrderNo
	, order_created_date OrderDate
	, customer_id ObjectID
	, A02.ObjectName
	, A01.[user_id] SaleEmployeeID
	, A03.UserName SaleEmployeeName
	, A01.[priority] ImpactLevelID
	, CASE WHEN ISNULL(A01.[priority],0) = 0 THEN N'Bình thường'
		    WHEN ISNULL(A01.[priority],0) = 1 THEN N'Khẩn 1'
		    WHEN ISNULL(A01.[priority],0) = 2 THEN N'Khẩn 2'
		    WHEN ISNULL(A01.[priority],0) = 3 THEN N'Khẩn 3'
		    END AS ImpactLevelName,A01.note Notes
	, A01.discount_percent DiscountPercent
	, A01.discount_money DiscountAmount
	, A01.VoucherNo
	FROM APT0001 A01 WITH (NOLOCK)
	LEFT JOIN AT1405 A03 WITH (NOLOCK) ON A03.DivisionID = A01.DivisionID AND A03.UserID = A01.[user_id]
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (@DivisionID, '@@@') AND A02.ObjectID = A01.customer_id
	LEFT JOIN OT2002 OT20 WITH (NOLOCK) ON OT20.DivisionID = A01.DivisionID AND OT20.AppInheritOrderID = A01.order_id
	WHERE A01.DivisionID = @DivisionID
	AND OT20.AppInheritOrderID IS NULL
	AND A01.OrderStatus = 1
	--AND A01.[user_id] LIKE ISNULl(@SaleEmployeeID,'%')
	AND A01.customer_id LIKE ISNULl(@ObjectID,'%')
	AND CONVERT(DATE, A01.order_created_date) BETWEEN CONVERT(DATE, @FromDate) AND CONVERT(DATE, @ToDate)
	--AND A01.order_id NOT IN (SELECT ISNULL(AppInheritOrderID, '') FROM OT2002 WHERE OT2002.DivisionID = A01.DivisionID)

	GROUP BY order_id, order_no, order_created_date, customer_id, A02.ObjectName, A01.[user_id], A03.UserName, A01.[priority],
			 A01.note, A01.discount_percent,A01.discount_money, A01.VoucherNo
END
ELSE
BEGIN
	SELECT order_id OrderID
	,  order_no OrderNo
	, order_created_date OrderDate
	, customer_id ObjectID
	, A02.ObjectName
	, A01.[user_id] SaleEmployeeID
	--, A03.AnaName SaleEmployeeName
	, A04.FullName SaleEmployeeName
	, A01.[priority] ImpactLevelID
	, CASE WHEN ISNULL(A01.[priority],0) = 0 THEN N'Bình thường'
		    WHEN ISNULL(A01.[priority],0) = 1 THEN N'Khẩn 1'
		    WHEN ISNULL(A01.[priority],0) = 2 THEN N'Khẩn 2'
		    WHEN ISNULL(A01.[priority],0) = 3 THEN N'Khẩn 3'
		    END AS ImpactLevelName,A01.note Notes
	, A01.discount_percent DiscountPercent
	, A01.discount_money DiscountAmount, A01.CreateDate
	FROM APT0001 A01 WITH (NOLOCK)
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.DivisionID IN (A01.DivisionID,'@@@') AND A03.AnaID = A01.[user_id]
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (@DivisionID, '@@@') AND A02.ObjectID = A01.customer_id
	LEFT JOIN OT2002 OT20 WITH (NOLOCK) ON OT20.DivisionID IN (A01.DivisionID,'@@@') AND OT20.AppInheritOrderID = A01.order_id
	LEFT JOIN AT1103 A04 WITH (NOLOCK) ON A04.DivisionID IN (A01.DivisionID,'@@@') AND A04.EmployeeID = A01.[user_id]

	WHERE A01.DivisionID = @DivisionID
	AND OT20.AppInheritOrderID IS NULL
	--AND A01.[user_id] LIKE ISNULl(@SaleEmployeeID,'%')
	AND A01.customer_id LIKE ISNULl(@ObjectID,'%')
	AND CONVERT(VARCHAR, A01.order_created_date, 112) BETWEEN CONVERT(VARCHAR, @FromDate, 112) AND CONVERT(VARCHAR, @ToDate, 112)
	--AND A01.order_id NOT IN (SELECT ISNULL(AppInheritOrderID, '') FROM OT2002 WHERE OT2002.DivisionID = A01.DivisionID)

	GROUP BY order_id, order_no, order_created_date, customer_id, A02.ObjectName, A01.[user_id], A03.AnaName, A01.[priority],
			 A01.note, A01.discount_percent,A01.discount_money, A01.CreateDate, A04.FullName
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON