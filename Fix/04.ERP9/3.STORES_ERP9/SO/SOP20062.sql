IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Detail: màn hình Kế thừa đơn hàng gia công
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Học Huy on 20/11/2019
----Modified by Trọng Kiên on 31/12/2020: Bổ sung load Ghi chú 01 của lưới
----Modified by Lê Hoàng on 07/05/2021 : Bổ sung thêm trường Tên tình trạng
----Modified by Hoài Thanh on 23/09/2022: Bổ sung thêm trường số lượng tồn kho (InventoryQuantity)
----Modified by Đức Tuyên on 21/02/2023: Bổ sung thêm trường Mã phân tích (Số PO).
----Modified by Tiến Thành, Date: 04/04/2023 - Bổ sung giảm só lượng trên Grid sau khi kế thừa đơn hàng
----Modified by Đức Tuyên on 11/04/2023: Bổ sung Ẩn các đơn đã kế thừa hết sô lượng - Hiển thị đúng số lượng chưa kế thừa.
----Modified by Tiến Thành, Date: 19/04/2023 - Chỉnh sửa: Giảm só lượng trên Grid sau khi kế thừa - Đổi bảng AV7000 qua bảng AT2007 
----Modified by Đức Tuyên on 20/04/2023: Chỉnh sửa ẩn các đơn đã kế thừa hết số lượng.
----Modified by Tiến Thành on 24/04/2023: [2023/03/IS/0049] Bổ sung chỉnh sửa ẩn các mặt hàng đã kế thừa hết số lượng..
----Modified by Anh Đô on 25/04/2023: Bổ sung các cột InheritedQuantity, AvailableQuantity; Fix lỗi lặp dòng
----Modified by Đức Tuyên on 17/08/2023: Bổ sung hiển thị mã phân tích mặt hàng customize INNOTEK.
----Modified by Đức Tuyên on 23/11/2023: Bổ sung quy cách + đơn vị tính quy đổi.
----Modified by Viết Toàn on 13/12/2023: Chỉnh sửa: Số lượng kế thừa và số lượng sẵn sàng (Customize NKC)
----Modified by Hương Nhung on 28/12/2023: Chỉnh sửa: Kế thừa TK có, TK nợ (Customize NKC)
----Modified by Viết Toàn on 03/01/2023: Chỉnh sửa: tk nợ/có lấy sai tên và mã
-- <Example>
---- 
/*-- <Example>
	exec SOP20062 @DivisionID=N'MTH',@UserID=N'HOCHUY',@PageNumber=1,@PageSize=25,@SOrderID=N'EO/10/2019/0001',
		@Mode=0,@ScreenID=N'',@PriceListID=N'',@CurrencyID=N'',@VoucherDate=N''

----*/

CREATE PROCEDURE SOP20062
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @SOrderID NVARCHAR(MAX),
	 @Mode INT = 0,
	 @ScreenID NVARCHAR(250) ='',
	 @PriceListID NVARCHAR(MAX) = '',
     @CurrencyID NVARCHAR(50) = '',
	 @VoucherDate NVARCHAR(50) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',		
		@sSelect NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@sSQL3 NVARCHAR(MAX) =N'',
	    @sJoin NVARCHAR(MAX) =N'',
		@CustomerIndex INT =-1,
		@RequestPrice  NVARCHAR(MAX) =N'',
		@IsConvertedUnit AS TINYINT

SET @Customerindex = (SELECT CustomerName FROM CustomerIndex)
SET @OrderBy = 'T1.VoucherNo, T2.InventoryID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF (@Customerindex = 151)
BEGIN
	IF ISNULL(@Mode,0) = 1
	BEGIN 
	SET @sSQL = @sSQL + N'
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, T2.IsProInventoryID,
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name,
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name,
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,    
			T02.Specification,T2.Orders'
	SET @sSQL1 = @sSQL1 + N'
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON T2.DivisionID = O99.DivisionID AND T2.TransactionID = O99.TransactionID        
			'+@sJoin+''
	SET @sSQL2 = @sSQL2 + N'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN (
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') 
			'+@sWhere +'
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName,
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName,
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName,
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName,
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, 
			T2.OrderQuantity ,T02.Specification,T2.Orders, T2.IsProInventoryID
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE 
	BEGIN
	SET @sSQL = @sSQL + N'
		---Danh sach sản phẩm đã được kế thừa---
		SELECT OT02_DHB.APK, OT02_DHB.SOrderID, OT02_DSX.OrderQuantity AS InheritTotalQuantity, OT02_DSX.InheritTransactionID 
		INTO #InheritDSX
		FROM OT2002 OT02_DHB WITH (NOLOCK)
					LEFT JOIN 
					(SELECT OT02.InheritTransactionID, SUM(ISNULL(OT02.OrderQuantity, 0)) AS OrderQuantity FROM OT2002 OT02 WITH (NOLOCK)
						WHERE OT02.DivisionID = '''+ @DivisionID + '''
								AND OT02.InheritTableID = N''OT2002''
								AND OT02.InheritTransactionID IS NOT NULL
						GROUP BY OT02.InheritTransactionID
					)  OT02_DSX ON  OT02_DSX.InheritTransactionID = OT02_DHB.TransactionID
							
		WHERE OT02_DHB.SOrderID IN ( SELECT ISNULL(SOrderID, '''') FROM OT2001 WITH(NOLOCK) WHERE VoucherNo IN ('''+@SOrderID+'''))
			AND ISNULL(OT02_DHB.InheritTableID, '''') <> N''OT2002''
			AND ISNULL(OT02_DHB.InheritTransactionID, '''') = ''''
			AND OT02_DSX.InheritTransactionID IS NOT NULL

		---OT2001---
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.SalePrice, T2.IsProInventoryID,
			(ISNULL(T2.OrderQuantity,0) - ISNULL(A07.ActualQuantity,0) - ISNULL(DSX.InheritTotalQuantity, 0)) AS OrderQuantity, 
			(ISNULL(T2.OrderQuantity,0) - ISNULL(A07.ActualQuantity,0)) * T2.SalePrice AS OriginalAmount, 
			(ISNULL(T2.OrderQuantity,0) - ISNULL(A07.ActualQuantity,0)) * T2.SalePrice AS ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes, T2.Notes01,
		    T02.AccountID as CreditAccountName,
			T02.PrimeCostAccountID as DebitAccountName,
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name, 
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name, 
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name,
			T2.nvarchar01, T2.nvarchar02, T2.nvarchar03, T2.nvarchar04, T2.nvarchar05,
            T2.nvarchar06, T2.nvarchar07, T2.nvarchar08, T2.nvarchar09, T2.nvarchar10,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,    
			T02.Specification, T2.Orders'
	SET @sSQL1 = @sSQL1 + N'
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON T2.DivisionID = O99.DivisionID AND T2.TransactionID = O99.TransactionID        
			LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
			LEFT JOIN AT2007 A07 WITH(NOLOCK) ON A07.InheritTransactionID = T2.TransactionID AND A07.DivisionID = T2.DivisionID AND A07.InventoryID = T2.InventoryID    
			LEFT JOIN #InheritDSX DSX WITH(NOLOCK) ON DSX.InheritTransactionID = T2.TransactionID
			'+@sJoin+''

	SET @sSQL2 = @sSQL2 + N'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN 
				(
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.OrderQuantity > ISNULL(DSX.InheritTotalQuantity, 0)
			'+@sWhere +'
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, T2.Notes01,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, 
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName, 
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,
			T2.nvarchar01, T2.nvarchar02, T2.nvarchar03, T2.nvarchar04, T2.nvarchar05,
            T2.nvarchar06, T2.nvarchar07, T2.nvarchar08, T2.nvarchar09, T2.nvarchar10,T02.AccountID,T02.PrimeCostAccountID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, 
			T2.OrderQuantity ,T02.Specification,T2.Orders, DSX.InheritTotalQuantity, A07.ActualQuantity, T2.IsProInventoryID
		HAVING (ISNULL(T2.OrderQuantity,0) - ISNULL(A07.ActualQuantity,0)) > 0
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
END
ELSE IF (@Customerindex = 161)
BEGIN
	IF ISNULL(@Mode,0) = 1
	BEGIN 
	SET @sSQL = @sSQL + N'
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, T2.IsProInventoryID,
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name,
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name,
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,    
			T02.Specification,T2.Orders
			, T02.I01ID, AT01.AnaName As I01Name, T02.I02ID, AT02.AnaName As I02Name, T02.I03ID, AT03.AnaName As I03Name,T02.I04ID, AT04.AnaName As I04Name, T02.I05ID, AT05.AnaName As I05Name
			, T02.I06ID, AT06.AnaName As I06Name, T02.I07ID, AT07.AnaName As I07Name, T02.I08ID, AT08.AnaName As I08Name,T02.I09ID, AT09.AnaName As I09Name , T02.I10ID, AT10.AnaName As I10Name'
	SET @sSQL1 = @sSQL1 + N'
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = T02.I01ID AND AT01.AnaTypeID = ''I01''
			LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = T02.I02ID AND AT02.AnaTypeID = ''I02''
			LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = T02.I03ID AND AT03.AnaTypeID = ''I03''
			LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = T02.I04ID AND AT04.AnaTypeID = ''I04''
			LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = T02.I05ID AND AT05.AnaTypeID = ''I05''
			LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = T02.I06ID AND AT06.AnaTypeID = ''I06''
			LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = T02.I07ID AND AT07.AnaTypeID = ''I07''
			LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = T02.I08ID AND AT08.AnaTypeID = ''I08''
			LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = T02.I09ID AND AT09.AnaTypeID = ''I09''
			LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = T02.I10ID AND AT10.AnaTypeID = ''I10''
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON T2.DivisionID = O99.DivisionID AND T2.TransactionID = O99.TransactionID        
			'+@sJoin+''
	SET @sSQL2 = @sSQL2 + N'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN (
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') 
			'+@sWhere +'
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName,
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName,
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName,
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName,
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, 
			T2.OrderQuantity ,T02.Specification,T2.Orders
			, T02.I01ID, AT01.AnaName, T02.I02ID, AT02.AnaName, T02.I03ID, AT03.AnaName,T02.I04ID, AT04.AnaName, T02.I05ID, AT05.AnaName
			, T02.I06ID, AT06.AnaName, T02.I07ID, AT07.AnaName, T02.I08ID, AT08.AnaName,T02.I09ID, AT09.AnaName, T02.I10ID, AT10.AnaName, T2.IsProInventoryID
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE 
	BEGIN
	SET @sSQL = @sSQL + N'
		---Danh sach sản phẩm đã được kế thừa---
		SELECT OT02_DHB.APK, OT02_DHB.SOrderID, OT02_DSX.OrderQuantity AS InheritTotalQuantity, OT02_DSX.InheritTransactionID 
		INTO #InheritDSX
		FROM OT2002 OT02_DHB WITH (NOLOCK)
					LEFT JOIN 
					(SELECT OT02.InheritTransactionID, SUM(ISNULL(OT02.OrderQuantity, 0)) AS OrderQuantity FROM OT2002 OT02 WITH (NOLOCK)
						WHERE OT02.DivisionID = '''+ @DivisionID + '''
								AND OT02.InheritTableID = N''OT2002''
								AND OT02.InheritTransactionID IS NOT NULL
						GROUP BY OT02.InheritTransactionID
					)  OT02_DSX ON  OT02_DSX.InheritTransactionID = OT02_DHB.TransactionID
							
		WHERE OT02_DHB.SOrderID IN ( SELECT ISNULL(SOrderID, '''') FROM OT2001 WITH(NOLOCK) WHERE VoucherNo IN ('''+@SOrderID+'''))
			AND ISNULL(OT02_DHB.InheritTableID, '''') <> N''OT2002''
			AND ISNULL(OT02_DHB.InheritTransactionID, '''') = ''''
			AND OT02_DSX.InheritTransactionID IS NOT NULL

		---OT2001---
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.SalePrice, T2.IsProInventoryID,
			ISNULL(T2.OrderQuantity, 0) AS OrderQuantity,
			(ISNULL(T2.OrderQuantity,0) - SUM(ISNULL(A07.ActualQuantity,0))) * T2.SalePrice AS OriginalAmount,
			(ISNULL(T2.OrderQuantity,0) - SUM(ISNULL(A07.ActualQuantity,0))) * T2.SalePrice * T1.ExchangeRate AS ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes, T2.Notes01,
			T02.AccountID as CreditAccountName,
            T02.PrimeCostAccountID as DebitAccountName,
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name, 
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name, 
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name,
			T2.nvarchar01, T2.nvarchar02, T2.nvarchar03, T2.nvarchar04, T2.nvarchar05,
            T2.nvarchar06, T2.nvarchar07, T2.nvarchar08, T2.nvarchar09, T2.nvarchar10,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,    
			T02.Specification, T2.Orders, 
			(Select ISNULL(SUM(ISNULL(SignQuantity, 0)), 0) AS Quantity 
						FROM AV7000 
						WHERE AV7000.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7000.InventoryID = T2.InventoryID
			) AS InventoryQuantity
			, SUM(ISNULL(A07.ActualQuantity, 0)) AS InheritedQuantity
			, ISNULL(T2.OrderQuantity, 0) - SUM(ISNULL(A07.ActualQuantity, 0)) AS AvailableQuantity
			, T02.I01ID, AT01.AnaName As I01Name, T02.I02ID, AT02.AnaName As I02Name, T02.I03ID, AT03.AnaName As I03Name,T02.I04ID, AT04.AnaName As I04Name, T02.I05ID, AT05.AnaName As I05Name
			, T02.I06ID, AT06.AnaName As I06Name, T02.I07ID, AT07.AnaName As I07Name, T02.I08ID, AT08.AnaName As I08Name,T02.I09ID, AT09.AnaName As I09Name , T02.I10ID, AT10.AnaName As I10Name'
	SET @sSQL1 = @sSQL1 + N'
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = T02.I01ID AND AT01.AnaTypeID = ''I01''
			LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = T02.I02ID AND AT02.AnaTypeID = ''I02''
			LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = T02.I03ID AND AT03.AnaTypeID = ''I03''
			LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = T02.I04ID AND AT04.AnaTypeID = ''I04''
			LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = T02.I05ID AND AT05.AnaTypeID = ''I05''
			LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = T02.I06ID AND AT06.AnaTypeID = ''I06''
			LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = T02.I07ID AND AT07.AnaTypeID = ''I07''
			LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = T02.I08ID AND AT08.AnaTypeID = ''I08''
			LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = T02.I09ID AND AT09.AnaTypeID = ''I09''
			LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = T02.I10ID AND AT10.AnaTypeID = ''I10''
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON T2.DivisionID = O99.DivisionID AND T2.TransactionID = O99.TransactionID        
			LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
			LEFT JOIN AT2007 A07 WITH(NOLOCK) ON A07.SOrderID = T2.SOrderID AND A07.DivisionID = T2.DivisionID AND A07.InventoryID = T2.InventoryID    
			LEFT JOIN #InheritDSX DSX WITH(NOLOCK) ON DSX.InheritTransactionID = T2.TransactionID
			'+@sJoin+''

	SET @sSQL2 = @sSQL2 + N'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN 
				(
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.OrderQuantity > ISNULL(DSX.InheritTotalQuantity, 0)
			'+@sWhere +'
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, T2.Notes01,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, 
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName, 
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,
			T2.nvarchar01, T2.nvarchar02, T2.nvarchar03, T2.nvarchar04, T2.nvarchar05,
            T2.nvarchar06, T2.nvarchar07, T2.nvarchar08, T2.nvarchar09, T2.nvarchar10,T02.AccountID,T02.PrimeCostAccountID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, 
			T2.OrderQuantity ,T02.Specification,T2.Orders, DSX.InheritTotalQuantity, T1.ExchangeRate
			, T02.I01ID, AT01.AnaName, T02.I02ID, AT02.AnaName, T02.I03ID, AT03.AnaName,T02.I04ID, AT04.AnaName, T02.I05ID, AT05.AnaName
			, T02.I06ID, AT06.AnaName, T02.I07ID, AT07.AnaName, T02.I08ID, AT08.AnaName,T02.I09ID, AT09.AnaName, T02.I10ID, AT10.AnaName, T2.IsProInventoryID
		HAVING (ISNULL(T2.OrderQuantity,0) - SUM(ISNULL(A07.ActualQuantity,0))) > 0
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
END
ELSE
BEGIN
	IF @Customerindex = 166
	BEGIN
		SET @sJoin = @sJoin + '
			LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.InheritTransactionID = CONVERT(VARCHAR(50), T2.APK) AND W96.DivisionID = T2.DivisionID
		'
		SET @sSelect = @sSelect + '
			, SUM(ISNULL(W96.ActualQuantity, 0)) AS InheritedQuantity
			, ISNULL(T2.OrderQuantity, 0) - SUM(ISNULL(W96.ActualQuantity, 0)) AS AvailableQuantity
		'
	END
	ELSE
		SET @sSelect = @sSelect + '
			, SUM(ISNULL(A07.ActualQuantity, 0)) AS InheritedQuantity
			, ISNULL(T2.OrderQuantity, 0) - SUM(ISNULL(A07.ActualQuantity, 0)) AS AvailableQuantity
		'

	IF ISNULL(@Mode,0) = 1
	BEGIN 
	SET @sSQL = @sSQL + N'
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, T2.IsProInventoryID,
			T02.AccountID AS DebitAccountID, A01.AccountName as CreditAccountName,
            T02.PrimeCostAccountID AS CreditAccountID, A02.AccountName DebitAccountName,
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name,
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name,
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,    
			T02.Specification,T2.Orders'
	SET @sSQL1 = @sSQL1 + N'
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON T2.DivisionID = O99.DivisionID AND T2.TransactionID = O99.TransactionID
			LEFT JOIN AT1005 A01 WITH (NOLOCK) ON T02.AccountID = A01.AccountID AND A01.DivisionID IN (T02.DivisionID, ''@@@'')
			LEFT JOIN AT1005 A02 WITH (NOLOCK) ON T02.PrimeCostAccountID = A02.AccountID AND A02.DivisionID IN (T02.DivisionID, ''@@@'')
			'+@sJoin+''
	SET @sSQL2 = @sSQL2 + N'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN (
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') 
			'+@sWhere +'
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName,
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName,
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName,
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName,
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, 
			T2.OrderQuantity ,T02.Specification,T2.Orders, T2.IsProInventoryID, T02.AccountID, T02.PrimeCostAccountID, A01.AccountName, A02.AccountName
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE 
	BEGIN
	SET @sSQL = @sSQL + N'
		---Danh sach sản phẩm đã được kế thừa---
		SELECT OT02_DHB.APK, OT02_DHB.SOrderID, OT02_DSX.OrderQuantity AS InheritTotalQuantity, OT02_DSX.InheritTransactionID 
		INTO #InheritDSX
		FROM OT2002 OT02_DHB WITH (NOLOCK)
					LEFT JOIN 
					(SELECT OT02.InheritTransactionID, SUM(ISNULL(OT02.OrderQuantity, 0)) AS OrderQuantity FROM OT2002 OT02 WITH (NOLOCK)
						WHERE OT02.DivisionID = '''+ @DivisionID + '''
								AND OT02.InheritTableID = N''OT2002''
								AND OT02.InheritTransactionID IS NOT NULL
						GROUP BY OT02.InheritTransactionID
					)  OT02_DSX ON  OT02_DSX.InheritTransactionID = OT02_DHB.TransactionID
							
		WHERE OT02_DHB.SOrderID IN ( SELECT ISNULL(SOrderID, '''') FROM OT2001 WITH(NOLOCK) WHERE VoucherNo IN ('''+@SOrderID+'''))
			AND ISNULL(OT02_DHB.InheritTableID, '''') <> N''OT2002''
			AND ISNULL(OT02_DHB.InheritTransactionID, '''') = ''''
			AND OT02_DSX.InheritTransactionID IS NOT NULL

		---OT2001---
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.SalePrice, T2.IsProInventoryID,
			ISNULL(T2.OrderQuantity, 0) AS OrderQuantity,
			(ISNULL(T2.OrderQuantity,0) - SUM(ISNULL(A07.ActualQuantity,0))) * T2.SalePrice AS OriginalAmount,
			(ISNULL(T2.OrderQuantity,0) - SUM(ISNULL(A07.ActualQuantity,0))) * T2.SalePrice * T1.ExchangeRate AS ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes, T2.Notes01,
			T02.AccountID AS DebitAccountID, A01.AccountName AS DebitAccountName,
			T02.PrimeCostAccountID AS CreditAccountID, A02.AccountName AS CreditAccountName,
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name, 
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name, 
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name,
			T2.nvarchar01, T2.nvarchar02, T2.nvarchar03, T2.nvarchar04, T2.nvarchar05,
            T2.nvarchar06, T2.nvarchar07, T2.nvarchar08, T2.nvarchar09, T2.nvarchar10,T02.AccountID,T02.PrimeCostAccountID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,    
			T2.Parameter01, T2.Parameter02, T2.Parameter03, T2.Parameter04, T2.Parameter05, T2.ConvertedQuantity, T2.ConvertedSalePrice,
			T2.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes,
			T02.Specification, T2.Orders, 
			(Select ISNULL(SUM(ISNULL(SignQuantity, 0)), 0) AS Quantity 
						FROM AV7000 
						WHERE AV7000.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7000.InventoryID = T2.InventoryID
			) AS InventoryQuantity
			' + @sSelect
	SET @sSQL1 = @sSQL1 + N'
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1011 T11 WITH(NOLOCK) ON T11.AnaID = T2.Ana01ID AND T11.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T21 WITH(NOLOCK) ON T21.AnaID = T2.Ana02ID AND T21.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T31 WITH(NOLOCK) ON T31.AnaID = T2.Ana03ID AND T31.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T41 WITH(NOLOCK) ON T41.AnaID = T2.Ana04ID AND T41.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T51 WITH(NOLOCK) ON T51.AnaID = T2.Ana05ID AND T51.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T61 WITH(NOLOCK) ON T61.AnaID = T2.Ana06ID AND T61.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T71 WITH(NOLOCK) ON T71.AnaID = T2.Ana07ID AND T71.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T81 WITH(NOLOCK) ON T81.AnaID = T2.Ana08ID AND T81.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T91 WITH(NOLOCK) ON T91.AnaID = T2.Ana09ID AND T91.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T10 WITH(NOLOCK) ON T10.AnaID = T2.Ana10ID AND T10.AnaTypeID = ''A10''
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON T2.DivisionID = O99.DivisionID AND T2.TransactionID = O99.TransactionID        
			LEFT JOIN POT2022 T22 WITH(NOLOCK) ON T22.InheritAPKDetail = T2.APK AND T22.DivisionID = T2.DivisionID AND IsSelectPrice = 1
			LEFT JOIN AT2007 A07 WITH(NOLOCK) ON A07.SOrderID = T2.SOrderID AND A07.DivisionID = T2.DivisionID AND A07.InventoryID = T2.InventoryID    
			LEFT JOIN #InheritDSX DSX WITH(NOLOCK) ON DSX.InheritTransactionID = T2.TransactionID
			LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (T2.DivisionID, ''@@@'') 
												AND WQ09.InventoryID = T2.InventoryID
												AND WQ09.ConvertedUnitID = T2.ConvertedUnitID
												--AND (WQ09.S01ID = O99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(O99.S01ID, '''')))
												--AND (WQ09.S02ID = O99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(O99.S02ID, '''')))
												--AND (WQ09.S03ID = O99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(O99.S03ID, '''')))
												--AND (WQ09.S04ID = O99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(O99.S04ID, '''')))
												--AND (WQ09.S05ID = O99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(O99.S05ID, '''')))
												--AND (WQ09.S06ID = O99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(O99.S06ID, '''')))
												--AND (WQ09.S07ID = O99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(O99.S07ID, '''')))
												--AND (WQ09.S08ID = O99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(O99.S08ID, '''')))
												--AND (WQ09.S09ID = O99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(O99.S09ID, '''')))
												--AND (WQ09.S10ID = O99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(O99.S10ID, '''')))
												--AND (WQ09.S11ID = O99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(O99.S11ID, '''')))
												--AND (WQ09.S12ID = O99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(O99.S12ID, '''')))
												--AND (WQ09.S13ID = O99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(O99.S13ID, '''')))
												--AND (WQ09.S14ID = O99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(O99.S14ID, '''')))
												--AND (WQ09.S15ID = O99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(O99.S15ID, '''')))
												--AND (WQ09.S16ID = O99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(O99.S16ID, '''')))
												--AND (WQ09.S17ID = O99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(O99.S17ID, '''')))
												--AND (WQ09.S18ID = O99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(O99.S18ID, '''')))
												--AND (WQ09.S19ID = O99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(O99.S19ID, '''')))
												--AND (WQ09.S20ID = O99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(O99.S20ID, '''')))
			LEFT JOIN AT1005 A01 WITH (NOLOCK) ON T02.AccountID = A01.AccountID AND A01.DivisionID IN (T02.DivisionID, ''@@@'')
			LEFT JOIN AT1005 A02 WITH (NOLOCK) ON T02.PrimeCostAccountID = A02.AccountID AND A02.DivisionID IN (T02.DivisionID, ''@@@'')
			'+@sJoin+''

	SET @sSQL2 = @sSQL2 + N'
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN 
				(
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.OrderQuantity > ISNULL(DSX.InheritTotalQuantity, 0)
			'+@sWhere +'
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, T2.Notes01,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName, 
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName, 
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName, 
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName, 
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName,
			T2.nvarchar01, T2.nvarchar02, T2.nvarchar03, T2.nvarchar04, T2.nvarchar05,
            T2.nvarchar06, T2.nvarchar07, T2.nvarchar08, T2.nvarchar09, T2.nvarchar10,T02.AccountID,T02.PrimeCostAccountID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,        
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, 
			T2.Parameter01, T2.Parameter02, T2.Parameter03, T2.Parameter04, T2.Parameter05, T2.ConvertedQuantity, T2.ConvertedSalePrice,
			T2.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes,
			T2.OrderQuantity ,T02.Specification,T2.Orders, DSX.InheritTotalQuantity, T1.ExchangeRate, T2.IsProInventoryID, A01.AccountName, A02.AccountName
		HAVING (ISNULL(T2.OrderQuantity,0) - SUM(ISNULL(A07.ActualQuantity,0))) > 0
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
END


--PRINT (@sSQL)
--PRINT (@sSQL1)
--PRINT (@sSQL2)
--PRINT (@sSQL3)
EXEC (@sSQL + @sSQL1 + @sSQL2 +@sSQL3)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
