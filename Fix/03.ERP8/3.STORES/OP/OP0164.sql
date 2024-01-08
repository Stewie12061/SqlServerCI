IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0164]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0164]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load grid chi tiết hóa đơn lập từ app mobile (OF0137)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: by Thanh Sơn on 24/12/2014
---- Modified on 12/04/2016 by Kim Vu: Rename move tu LAVO len chuan 8.1
---- Modified by Tiểu Mai on 0707/2016: Bổ sung trường
---- Modify on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modify on 07/08/2020 by Văn Tài: [SAVI] Tách lấy dữ liệu cho Ana01ID, chữa rõ tại sao lúc trước lấy user_id cho Ana01ID.
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Thông on 08/10/2020 : Bổ sung chiết khẩu cho thành tiền
---- Modified by Nhật Thanh on 21/02/2022: Bổ sung ngày tạo đơn hàng cho angel
---- Modified by Nhật Thanh on 21/02/2022: Tách trường hợp load dữ liệu cho angel
---- Modified by Nhật Quang on 12/01/2023: Lấy thêm trường IsProInventoryID
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
  OP0164 'KC','ASOFTADMIN', '1C0536FD-5B6E-4F93-B157-130347A69C60'
*/
CREATE PROCEDURE OP0164
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@OrderIDList NVARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@CustomerName as int
    
SELECT @CustomerName = CustomerName FROM CustomerIndex

-- Khách hàng ANGEL
IF @CustomerName = 57
	BEGIN
		SET @sSQL = 'SELECT A01.APK
		, A01.order_id OrderID
		, A01.product_id InventoryID
		, A02.InventoryName
		, A01.unit UnitID
		, A04.UnitName
		, A01.quantity OrderQuantity
		, Ana01ID AS Ana01ID
		, Ana02ID AS Ana02ID
		, Ana03ID AS Ana03ID
		, A01.note Notes
		, A01.discount_percent DiscountPercent
		, (A01.discount_percent * A01.SalePrice * A01.quantity /100) AS DiscountAmount
		, A01.PriceListID
		, A01.SalePrice
		, A01.VATPercent
		, A02.VATGroupID
		, A01.customer_id ObjectID
		, A03.ObjectName
		, A01.order_created_date OrderDate
		, A01.SalePrice * A01.quantity - A01.discount_percent * A01.SalePrice * A01.quantity / 100 AS OriginalAmount
		, A01.VoucherNo, A01.CreateDate as AppOCreateDate
		FROM APT0001 A01 WITH (NOLOCK)
			LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A01.unit
			LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', A01.DivisionID) AND A02.InventoryID = A01.product_id
			LEFT JOIN AT1202 A03 WITH (NOLOCK) ON A03.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A03.ObjectID = A01.customer_id
		WHERE A01.DivisionID = '''+@DivisionID+'''
		AND A01.order_id IN ('''+@OrderIDList+''')
		ORDER BY A01.order_id,A01.Orders'
	END
ELSE
-- Khách hàng SAVI
IF @CustomerName = 44
	BEGIN
		SET @sSQL = 'SELECT A01.APK
		, A01.order_id OrderID
		, A01.product_id InventoryID
		, A02.InventoryName
		, A01.unit UnitID
		, A04.UnitName
		, A01.quantity OrderQuantity
		, '''' AS Ana01ID
		, A01.note Notes
		, A01.discount_percent DiscountPercent
		, (A01.discount_percent * A01.SalePrice * A01.quantity /100) AS DiscountAmount
		, A01.PriceListID
		, A01.SalePrice
		, A01.VATPercent
		, A02.VATGroupID
		, A01.customer_id ObjectID
		, A03.ObjectName
		, A01.order_created_date OrderDate
		, A01.SalePrice * A01.quantity - A01.discount_percent * A01.SalePrice * A01.quantity / 100 AS OriginalAmount
		, A01.VoucherNo
		FROM APT0001 A01 WITH (NOLOCK)
			LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A01.unit
			LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', A01.DivisionID) AND A02.InventoryID = A01.product_id
			LEFT JOIN AT1202 A03 WITH (NOLOCK) ON A03.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A03.ObjectID = A01.customer_id
		WHERE A01.DivisionID = '''+@DivisionID+'''
		AND A01.order_id IN ('''+@OrderIDList+''')
		ORDER BY A01.order_id,A01.Orders'
	END
ELSE
	BEGIN
		SET @sSQL = 'SELECT A01.APK
			, A01.order_id OrderID
			, A01.product_id InventoryID
			, A02.InventoryName
			, A01.unit UnitID
			, A04.UnitName
			, A01.quantity OrderQuantity
			, A01.user_id Ana01ID
			, A01.note Notes
			, A01.discount_percent DiscountPercent
			, (A01.discount_percent * A01.SalePrice * A01.quantity /100) AS DiscountAmount
			, A01.PriceListID
			, A01.SalePrice
			, A01.VATPercent
			, A02.VATGroupID
			, A01.customer_id ObjectID
			, A03.ObjectName
			, A01.order_created_date OrderDate
			, A01.SalePrice * A01.quantity - A01.discount_percent * A01.SalePrice * A01.quantity / 100 AS OriginalAmount
			, A01.VoucherNo
			, ISNULL(A01.IsProInventoryID,0) AS IsProInventoryID
			FROM APT0001 A01 WITH (NOLOCK)
				LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A01.unit
				LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', A01.DivisionID) AND A02.InventoryID = A01.product_id
				LEFT JOIN AT1202 A03 WITH (NOLOCK) ON A03.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A03.ObjectID = A01.customer_id
			WHERE A01.DivisionID = '''+@DivisionID+'''
			AND A01.order_id IN ('''+@OrderIDList+''')
			ORDER BY A01.order_id,A01.Orders'
END

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO