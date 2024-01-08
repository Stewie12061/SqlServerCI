IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Detail cho màn hình SOF2008 - kế thừa đơn hàng App
-- <History>
---- Create on 19/10/2023 by Hoàng Long
---- Modified on 27/11/2023 by Hoàng Long - [2023/11/IS/0197] - Fix lỗi SO/SOF2001 – Chưa kế thừa đủ thông tin từ đơn hàng bán
---- Modified on 28/11/2023 by Hoàng Long - [2023/11/IS/0196] - Fix lỗi SO/SOF2001 - Kế thừa đơn hàng bán app chưa lấy được thông tin nhóm kinh doanh, NVKD
---- Modified on 30/11/2023 by Hoàng Long - [2023/11/IS/0214] - Fix lỗi SO/SOF2001 – Lỗi đúp dữ liệu số lượng mặt hàng
---- Modified on 26/12/2023 by Nhật Thanh - Bổ sung lấy giá quy cách
---- Modified on 27/12/2023 by Hoàng Long - [2023/12/IS/0283] - Fix lỗi SO/SOF2001 – Hiển thị thông tin đơn hàng App
-- <Example>

CREATE PROCEDURE [dbo].[SOP20082] 	
	@DivisionID NVARCHAR(50),
	@ListVoucherNo NVARCHAR(MAX),
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@ScreenID VARCHAR(50) = ''
AS
DECLARE @sSQL1 NVARCHAR(MAX),
		@TotalRow VARCHAR(50)

BEGIN
	-- Kế thừa từ màn hình đơn hàng APP
	SET @TotalRow = ''
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @ListVoucherNo = ISNULL(@ListVoucherNo,'')

	-- Load dữ liệu cho Detail cho lưới
		BEGIN
			SET @sSQL1 = '
			SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY P.VoucherNo ) AS RowNum, COUNT(*) OVER () AS TotalRow,* 
			FROM(
				SELECT DISTINCT A01.DivisionID, A01.product_id as InventoryID , A02.InventoryName, (ISNULL(A01.quantity,0) - SUM(ISNULL(OT22.OrderQuantity,0))) as ConvertedQuantity, A03.UnitID,A03.UnitName, A01.Orders, A01.PriceListID, A01.SalePrice as ConvertedSalePrice, A02.VATGroupID, A05.VATGroupName, A01.VATPercent, A01.VoucherNo, A01.IsProInventoryID,A01.ReceiveAmount,A01.IsReceiveAmount,A01.order_created_date,A01.discount_percent as DiscountPercent, A01.discount_money as DiscountAmount, A01.S01ID, A01.S02ID, A01.S03ID, A01.S04ID, A01.Ana01ID, A01.Ana02ID, A01.Ana03ID, A01.Ana04ID, A01.Ana05ID, A35_1.UnitPrice as SUnitPrice01, A35_2.UnitPrice as SUnitPrice02, A35_3.UnitPrice as SUnitPrice03, A35_4.UnitPrice as SUnitPrice04,
				  A07.AnaID as Ana06ID, A07.AnaName as Ana06Name,
				  CASE WHEN A01.user_id <> A01.customer_id THEN A08.AnaID ELSE NULL END AS Ana07ID,
				  CASE WHEN A01.user_id <> A01.customer_id THEN A08.AnaName ELSE NULL END AS Ana07Name,
				  A09.AnaID as Ana09ID, A09.AnaName as Ana09Name,
				  A01.order_id
				FROM APT0001 A01
				LEFT JOIN AT1302 A02 ON A02.InventoryID = A01.product_id
				LEFT JOIN AT1304 A03 on A01.unit = A03.UnitID
				LEFT JOIN AT1202 A04 ON A04.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A04.ObjectID= A01.AnaDivisionID
				LEFT JOIN AT1010 A05 ON A05.VATGroupID = A02.VATGroupID
				LEFT JOIN CIT1180 A06 ON A06.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND
				(
					(A01.user_id = A01.customer_id AND A06.DealerID = A01.customer_id)
					OR
					(A01.user_id <> A01.customer_id AND A06.SaleID = A01.user_id AND A06.DealerID = A01.customer_id)
				)
				INNER JOIN AT1011 A07 ON A07.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A07.AnaTypeID=''A06'' AND A07.AnaID = A06.SUPID 
				INNER JOIN AT1011 A08 ON A08.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A08.AnaTypeID=''A07'' AND A08.AnaID = A06.SaleID
				INNER JOIN AT1011 A09  ON A09.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A09.AnaTypeID=''A09'' AND A09.AnaID = A01.AnaDivisionID
				LEFT JOIN AT0135 A35_1 ON A35_1.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A35_1.PriceID = A01.PriceListID AND A35_1.InventoryID = A01.product_id AND A35_1.StandardID = A01.S01ID and A35_1.StandardTypeID = ''S01''
				LEFT JOIN AT0135 A35_2 ON A35_2.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A35_2.PriceID = A01.PriceListID AND A35_2.InventoryID = A01.product_id AND A35_2.StandardID = A01.S02ID and A35_2.StandardTypeID = ''S02''
				LEFT JOIN AT0135 A35_3 ON A35_3.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A35_3.PriceID = A01.PriceListID AND A35_3.InventoryID = A01.product_id AND A35_3.StandardID = A01.S03ID and A35_3.StandardTypeID = ''S03''
				LEFT JOIN AT0135 A35_4 ON A35_4.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A35_4.PriceID = A01.PriceListID AND A35_4.InventoryID = A01.product_id AND A35_4.StandardID = A01.S04ID and A35_4.StandardTypeID = ''S04''
				LEFT JOIN OT2002 OT22 ON OT22.DivisionID = A01.DivisionID AND OT22.InheritTableID = ''APT0001'' 
				AND OT22.InheritVoucherID = A01.product_id AND OT22.InheritTransactionID = A01.order_id
				WHERE A01.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND A01.VoucherNo IN ('''+ @ListVoucherNo +''')
				GROUP BY  A01.DivisionID, A01.product_id , A02.InventoryName, A01.quantity, A03.UnitID,A03.UnitName, A01.Orders, A01.PriceListID, A01.SalePrice, A02.VATGroupID, A05.VATGroupName, A01.VATPercent, A01.VoucherNo, A01.IsProInventoryID,A01.ReceiveAmount,A01.IsReceiveAmount,A01.order_created_date,A01.discount_percent, A01.discount_money , A01.S01ID, A01.S02ID, A01.S03ID, A01.S04ID, A01.Ana01ID, A01.Ana02ID, A01.Ana03ID, A01.Ana04ID, A01.Ana05ID, A35_1.UnitPrice , A35_2.UnitPrice , A35_3.UnitPrice , A35_4.UnitPrice,A07.AnaID , A07.AnaName ,
				  A08.AnaID , A08.AnaName ,
				  A09.AnaID , A09.AnaName ,
				  A01.order_id,OT22.OrderQuantity,A01.user_id,A01.customer_id
				HAVING ISNULL(A01.quantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) > 0
			) as P 
			ORDER BY P.order_created_date DESC
			OFFSET          0 ROWS
			FETCH NEXT         25 ROWS ONLY 
			'
		END


	EXEC (@sSQL1) 
	PRINT (@sSQL1)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
