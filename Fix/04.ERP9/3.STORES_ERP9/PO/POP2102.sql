IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load lưới detail cho màn hình xem chi tiết tiến độ nhận hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 06/12/2018 by Đình Ly
-- <Example> 

-- <History>
---- Sửa lại Alias để load lại số lượng hàng đã giao
---- Modified on 30/09/2022 by Đình Định
---- Modified on 17/08/2023 by Đức Tuyên Customize nghiệp vụ tiến độ nhận hàng bổ sung mã phân tích mặt hàng
-----Modified by: Đức Tuyên on 28/11/2023 : Bổ sung quy cách + đơn vị quy đổi.
-- <Example> 

CREATE PROCEDURE [dbo].[POP2102]
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK NVARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N''

IF ((select CustomerName From CustomerIndex) = 161)
BEGIN
	SET @OrderBy = N'O.InventoryID'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sSQL = @sSQL + N'
		SELECT O.InventoryID
			 , A1.InventoryName
			 , O.UnitID
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , CASE 
				WHEN A3.ActualQuantity IS NULL
					THEN 0
				ELSE A3.ActualQuantity
				END	AS ShippedAmount
			 , CASE
				WHEN (O.OrderQuantity - A3.ActualQuantity) IS NULL
					THEN O.OrderQuantity 
				ELSE (O.OrderQuantity - A3.ActualQuantity) 
				END AS RemainedAmount
			 , O.Quantity01, O.Quantity02, O.Quantity03, O.Quantity04, O.Quantity05, O.Quantity06, O.Quantity07, O.Quantity08, O.Quantity09, O.Quantity10
			 , O.Quantity11, O.Quantity12, O.Quantity13, O.Quantity14, O.Quantity15, O.Quantity16, O.Quantity17, O.Quantity18, O.Quantity19, O.Quantity20
			 , O.Quantity21, O.Quantity22, O.Quantity23, O.Quantity24, O.Quantity25, O.Quantity26, O.Quantity27, O.Quantity28, O.Quantity29, O.Quantity30
			 , O2.S01ID, O2.S02ID , O2.S03ID, O2.S04ID, O2.S05ID, O2.S06ID, O2.S07ID, O2.S08ID, O2.S09ID, O2.S10ID 
             , O2.S11ID, O2.S12ID , O2.S13ID, O2.S14ID, O2.S15ID, O2.S16ID, O2.S17ID, O2.S18ID, O2.S19ID, O2.S20ID 
			 , O.I01ID, AT01.AnaName As I01Name, O.I02ID, AT02.AnaName As I02Name, O.I03ID, AT03.AnaName As I03Name,O.I04ID, AT04.AnaName As I04Name, O.I05ID, AT05.AnaName As I05Name
			 , O.I06ID, AT06.AnaName As I06Name, O.I07ID, AT07.AnaName As I07Name, O.I08ID, AT08.AnaName As I08Name,O.I09ID, AT09.AnaName As I09Name , O.I10ID, AT10.AnaName As I10Name
		INTO #TempOT3002
		FROM OT3002 O WITH (NOLOCK)
			LEFT JOIN OT3003 O1 ON CONVERT(NVARCHAR(50), O1.APK) = O.POrderID
			LEFT JOIN AT1302 A1 ON A1.InventoryID = O.InventoryID
			LEFT JOIN (
				SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A3.ActualQuantity
				FROM AT2007 A3 WITH(NOLOCK) 
					LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
				WHERE A4.KindVoucherID IN (2,4,6)
			) AS A3 on O.InventoryID = A3.InventoryID AND O.TransactionID = A3.InheritTransactionID
			LEFT JOIN OT8899 O2 WITH(NOLOCK) ON O2.TransactionID = O.TransactionID
			LEFT JOIN OT3001 O3 WITH(NOLOCK) ON O3.POrderID = O.POrderID			
			LEFT JOIN OT3003 O4 WITH(NOLOCK) ON O4.POrderID = O3.POrderID
			LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = O.I01ID AND AT01.AnaTypeID = ''I01''
			LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = O.I02ID AND AT02.AnaTypeID = ''I02''
			LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = O.I03ID AND AT03.AnaTypeID = ''I03''
			LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = O.I04ID AND AT04.AnaTypeID = ''I04''
			LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = O.I05ID AND AT05.AnaTypeID = ''I05''
			LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = O.I06ID AND AT06.AnaTypeID = ''I06''
			LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = O.I07ID AND AT07.AnaTypeID = ''I07''
			LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = O.I08ID AND AT08.AnaTypeID = ''I08''
			LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = O.I09ID AND AT09.AnaTypeID = ''I09''
			LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = O.I10ID AND AT10.AnaTypeID = ''I10''
		WHERE O4.APK = ''' + @APK + '''
		
		DECLARE @Count INT
		SELECT @Count = COUNT(InventoryID) FROM #TempOT3002

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			 , O.InventoryID
			 , O.InventoryName
			 , O.UnitID
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , O.ShippedAmount
			 , O.RemainedAmount
			 , O.Quantity01, O.Quantity02, O.Quantity03, O.Quantity04, O.Quantity05, O.Quantity06, O.Quantity07, O.Quantity08, O.Quantity09, O.Quantity10
			 , O.Quantity11, O.Quantity12, O.Quantity13, O.Quantity14, O.Quantity15, O.Quantity16, O.Quantity17, O.Quantity18, O.Quantity19, O.Quantity20
			 , O.Quantity21, O.Quantity22, O.Quantity23, O.Quantity24, O.Quantity25, O.Quantity26, O.Quantity27, O.Quantity28, O.Quantity29, O.Quantity30
			 , S01ID, S02ID , S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID 
             , S11ID, S12ID , S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 
			 , O.I01ID, O.I01Name, O.I02ID, O.I02Name, O.I03ID, O.I03Name,O.I04ID, O.I04Name, O.I05ID, O.I05Name
			 , O.I06ID, O.I06Name, O.I07ID, O.I07Name, O.I08ID, O.I08Name,O.I09ID, O.I09Name , O.I10ID, O.I10Name
		FROM #TempOT3002 O
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	PRINT (@sSQL)
END
ELSE
BEGIN
	SET @OrderBy = N'O.InventoryID'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sSQL = @sSQL + N'
		SELECT O.InventoryID
			 , A1.InventoryName
			 , O.UnitID
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , CASE 
				WHEN A3.ActualQuantity IS NULL
					THEN 0
				ELSE A3.ActualQuantity
				END	AS ShippedAmount
			 , CASE
				WHEN (O.OrderQuantity - A3.ActualQuantity) IS NULL
					THEN O.OrderQuantity 
				ELSE (O.OrderQuantity - A3.ActualQuantity) 
				END AS RemainedAmount
			 , O.Quantity01, O.Quantity02, O.Quantity03, O.Quantity04, O.Quantity05, O.Quantity06, O.Quantity07, O.Quantity08, O.Quantity09, O.Quantity10
			 , O.Quantity11, O.Quantity12, O.Quantity13, O.Quantity14, O.Quantity15, O.Quantity16, O.Quantity17, O.Quantity18, O.Quantity19, O.Quantity20
			 , O.Quantity21, O.Quantity22, O.Quantity23, O.Quantity24, O.Quantity25, O.Quantity26, O.Quantity27, O.Quantity28, O.Quantity29, O.Quantity30
			 , O2.S01ID, O2.S02ID , O2.S03ID, O2.S04ID, O2.S05ID, O2.S06ID, O2.S07ID, O2.S08ID, O2.S09ID, O2.S10ID 
			 , O2.S11ID, O2.S12ID , O2.S13ID, O2.S14ID, O2.S15ID, O2.S16ID, O2.S17ID, O2.S18ID, O2.S19ID, O2.S20ID 
		INTO #TempOT3002
		FROM OT3002 O WITH (NOLOCK)
			LEFT JOIN OT3003 O1 ON CONVERT(NVARCHAR(50), O1.APK) = O.POrderID
			LEFT JOIN AT1302 A1 ON A1.InventoryID = O.InventoryID
			LEFT JOIN (
				SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A3.ActualQuantity
				FROM AT2007 A3 WITH(NOLOCK) 
					LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
				WHERE A4.KindVoucherID IN (2,4,6)
			) AS A3 on O.InventoryID = A3.InventoryID AND O.TransactionID = A3.InheritTransactionID
			LEFT JOIN OT8899 O2 WITH(NOLOCK) ON O2.TransactionID = O.TransactionID
			LEFT JOIN OT3001 O3 WITH(NOLOCK) ON O3.POrderID = O.POrderID			
			LEFT JOIN OT3003 O4 WITH(NOLOCK) ON O4.POrderID = O3.POrderID
		WHERE O4.APK = ''' + @APK + '''
		
		DECLARE @Count INT
		SELECT @Count = COUNT(InventoryID) FROM #TempOT3002

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			 , O.InventoryID
			 , O.InventoryName
			 , O.UnitID
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , O.ShippedAmount
			 , O.RemainedAmount
			 , O.Quantity01, O.Quantity02, O.Quantity03, O.Quantity04, O.Quantity05, O.Quantity06, O.Quantity07, O.Quantity08, O.Quantity09, O.Quantity10
			 , O.Quantity11, O.Quantity12, O.Quantity13, O.Quantity14, O.Quantity15, O.Quantity16, O.Quantity17, O.Quantity18, O.Quantity19, O.Quantity20
			 , O.Quantity21, O.Quantity22, O.Quantity23, O.Quantity24, O.Quantity25, O.Quantity26, O.Quantity27, O.Quantity28, O.Quantity29, O.Quantity30
			 , S01ID, S02ID , S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID 
             , S11ID, S12ID , S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 
		FROM #TempOT3002 O
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	PRINT (@sSQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
