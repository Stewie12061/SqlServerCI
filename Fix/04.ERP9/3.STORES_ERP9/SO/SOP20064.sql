IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20064]
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
----Created by Văn Tài on 06/01/2020
----Modified by Văn Tài on 14/01/2020: Điều chỉnh Left Join cho trường hợp mặt hàng không sử dụng quy cách.
----Modified by Văn Tài on 16/01/2020: Điều chỉnh thêm cột Quantity để hiển thị cột số lượng details
----Modified by Văn Tài on 25/02/2020: Fix lỗi không lấy cột S02ID.
-- <Example>
---- 
/*-- <Example>
	exec SOP20062 @DivisionID=N'MTH',@UserID=N'HOCHUY',@PageNumber=1,@PageSize=25,@SOrderID=N'EO/10/2019/0001',
		@Mode=0,@ScreenID=N'',@PriceListID=N'',@CurrencyID=N'',@VoucherDate=N''

----*/

CREATE PROCEDURE SOP20064
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @SOrderID NVARCHAR(MAX),
	 @APKPOT2061 VARCHAR(50),
	 @Mode INT = 0,
	 @ScreenID NVARCHAR(250) ='',
	 @PriceListID NVARCHAR(MAX) = '',
     @CurrencyID NVARCHAR(50) = '',
	 @VoucherDate NVARCHAR(50) = ''
)
AS 
DECLARE @sSQL_01 VARCHAR(MAX) = N'',
		@sSQL_02 VARCHAR(MAX) = N'',
		@sSQL_03 VARCHAR(MAX) = N'',
		@sSQL_04 VARCHAR(MAX) = N'',
		@sSQL_05 VARCHAR(MAX) = N'',
		@sSQL_06 VARCHAR(MAX) = N'',
		@sSQL11 NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@sSQLSL NVARCHAR(MAX) =N'',
		@sSQLSL1 NVARCHAR(MAX) =N'',
	    @sJoin NVARCHAR(MAX) =N'',
		@sSQLSUM NVARCHAR(MAX) = N'',
		@CustomerIndex INT =-1,
		@RequestPrice  NVARCHAR(MAX) =N'',
		@IsConvertedUnit AS TINYINT

SET @Customerindex = (SELECT CustomerName FROM CustomerIndex)
SET @OrderBy = 'T1.VoucherNo, T2.InventoryID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@Mode,0) = 0
	BEGIN 
		SET @sSQL_01 = N'
		SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate DESC, ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow,
			T1.APK APKMaster,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.OrderQuantity AS Quantity,
			T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount, 
			T2.UnitID, T04.UnitName, T2.Notes, 
			T2.Ana01ID, T11.AnaName AS Ana01Name, T2.Ana02ID, T21.AnaName AS Ana02Name,
			T2.Ana03ID, T31.AnaName AS Ana03Name, T2.Ana04ID, T41.AnaName AS Ana04Name,
			T2.Ana05ID, T51.AnaName AS Ana05Name, T2.Ana06ID, T61.AnaName AS Ana06Name, 
			T2.Ana07ID, T71.AnaName AS Ana07Name, T2.Ana08ID, T81.AnaName AS Ana08Name, 
			T2.Ana09ID, T91.AnaName AS Ana09Name, T2.Ana10ID, T10.AnaName AS Ana10Name
			, T89.S01ID AS S01Name
			, T89.S02ID AS S02Name
			, T89.S03ID AS S03Name
			, T89.S04ID AS S04Name
			, T89.S05ID AS S05Name
			, T89.S06ID AS S06Name
			, T89.S07ID AS S07Name
			, T89.S08ID AS S08Name
			, T89.S09ID AS S09Name
			, T89.S10ID AS S10Name
			, T89.S11ID AS S11Name
			, T89.S12ID AS S12Name
			, T89.S13ID AS S13Name
			, T89.S14ID AS S14Name
			, T89.S15ID AS S15Name
			, T89.S16ID AS S16Name
			, T89.S17ID AS S17Name
			, T89.S18ID AS S18Name
			, T89.S19ID AS S19Name
			, T89.S20ID AS S20Name
			, T02.Specification 
			'
		SET @sSQL_02 = ', ISNULL(T2.OrderQuantity, 0) 
				- ISNULL(( SELECT SUM(ISNULL(T62.Quantity, 0))
					FROM POT2062 T62 WITH(NOLOCK)
					INNER JOIN POT2061 T61 WITH(NOLOCK) ON T61.DivisionID = T62.DivisionID
												AND T61.APK = T62.APKMaster
					LEFT JOIN OT8899 T89 WITH(NOLOCK) ON T89.DivisionID = T62.DivisionID
															AND T89.VoucherID = T62.SOrderID
															AND ISNULL(T89.TransactionID, '''') = ISNULL(T62.InheritTransactionID, '''')
															AND ISNULL(T89.S01ID, '''') = ISNULL(T62.S01ID, '''')
															AND ISNULL(T89.S02ID, '''') = ISNULL(T62.S02ID, '''')
															AND ISNULL(T89.S03ID, '''') = ISNULL(T62.S03ID, '''')
															AND ISNULL(T89.S04ID, '''') = ISNULL(T62.S04ID, '''')
															AND ISNULL(T89.S05ID, '''') = ISNULL(T62.S05ID, '''')
															AND ISNULL(T89.S06ID, '''') = ISNULL(T62.S06ID, '''')
															AND ISNULL(T89.S07ID, '''') = ISNULL(T62.S07ID, '''')
															AND ISNULL(T89.S08ID, '''') = ISNULL(T62.S08ID, '''')
															AND ISNULL(T89.S09ID, '''') = ISNULL(T62.S09ID, '''')
															AND ISNULL(T89.S10ID, '''') = ISNULL(T62.S10ID, '''')
															AND ISNULL(T89.S11ID, '''') = ISNULL(T62.S11ID, '''')
															AND ISNULL(T89.S12ID, '''') = ISNULL(T62.S12ID, '''')
															AND ISNULL(T89.S13ID, '''') = ISNULL(T62.S13ID, '''')
															AND ISNULL(T89.S14ID, '''') = ISNULL(T62.S14ID, '''')
															AND ISNULL(T89.S15ID, '''') = ISNULL(T62.S15ID, '''')
															AND ISNULL(T89.S16ID, '''') = ISNULL(T62.S16ID, '''')
															AND ISNULL(T89.S17ID, '''') = ISNULL(T62.S17ID, '''')
															AND ISNULL(T89.S18ID, '''') = ISNULL(T62.S18ID, '''')
															AND ISNULL(T89.S19ID, '''') = ISNULL(T62.S19ID, '''')
															AND ISNULL(T89.S20ID, '''') = ISNULL(T62.S20ID, '''')
					WHERE T62.DivisionID = T1.DivisionID
							AND T61.DeleteFlag = 0
							AND T62.SOrderID = T2.SOrderID
							AND T62.InheritTransactionID = T2.TransactionID '
									+ CASE WHEN ISNULL(@APKPOT2061, '') = '' 
										   THEN '' 
										   ELSE ' AND T61.APK <> N''' + @APKPOT2061 + '''' 
										   END
			+ ' ), 0) AS RemainQuantity '

		SET @sSQL_03 = N'
			, T1.CurrencyID
			, T05.ObjectName AS ObjectName
			, T2.Orders ' + @sSQLSL + @sSQLSL1 + '
		FROM OT2001 T1 WITH(NOLOCK)
			INNER JOIN OT2002 T2 WITH(NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
			LEFT JOIN OT8899 T89 WITH(NOLOCK) ON T89.DivisionID = T2.DivisionID AND T89.TransactionID = T2.TransactionID
			LEFT JOIN AT1302 T02 WITH(NOLOCK) ON T02.InventoryID = T2.InventoryID
			LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T2.UnitID = T04.UnitID
			LEFT JOIN AT1202 T05 WITH(NOLOCK) ON T1.ObjectID = T05.ObjectID
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
			' 
		SET @sSQL_04 = @sJoin + '
		WHERE T1.DivisionID = '''+@DivisionID+''' 
			AND T2.SOrderID IN (
					SELECT ISNULL(SOrderID, '''') 
					FROM OT2001 WITH(NOLOCK) 
					WHERE VoucherNo IN ('''+@SOrderID+''')
				)
			AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') 
			'
		SET @sSQL_05 = N' AND ISNULL(T2.OrderQuantity, 0) 
				- ISNULL(( SELECT SUM(ISNULL(T62.Quantity, 0))
					FROM POT2062 T62 WITH(NOLOCK)
					INNER JOIN POT2061 T61 WITH(NOLOCK) ON T61.DivisionID = T62.DivisionID
												AND T61.APK = T62.APKMaster
					LEFT JOIN OT8899 T89 WITH(NOLOCK) ON T89.DivisionID = T62.DivisionID
															AND T89.VoucherID = T62.SOrderID
															AND ISNULL(T89.TransactionID, '''') = ISNULL(T62.InheritTransactionID, '''')
															AND ISNULL(T89.S01ID, '''') = ISNULL(T62.S01ID, '''')
															AND ISNULL(T89.S02ID, '''') = ISNULL(T62.S02ID, '''')
															AND ISNULL(T89.S03ID, '''') = ISNULL(T62.S03ID, '''')
															AND ISNULL(T89.S04ID, '''') = ISNULL(T62.S04ID, '''')
															AND ISNULL(T89.S05ID, '''') = ISNULL(T62.S05ID, '''')
															AND ISNULL(T89.S06ID, '''') = ISNULL(T62.S06ID, '''')
															AND ISNULL(T89.S07ID, '''') = ISNULL(T62.S07ID, '''')
															AND ISNULL(T89.S08ID, '''') = ISNULL(T62.S08ID, '''')
															AND ISNULL(T89.S09ID, '''') = ISNULL(T62.S09ID, '''')
															AND ISNULL(T89.S10ID, '''') = ISNULL(T62.S10ID, '''')
															AND ISNULL(T89.S11ID, '''') = ISNULL(T62.S11ID, '''')
															AND ISNULL(T89.S12ID, '''') = ISNULL(T62.S12ID, '''')
															AND ISNULL(T89.S13ID, '''') = ISNULL(T62.S13ID, '''')
															AND ISNULL(T89.S14ID, '''') = ISNULL(T62.S14ID, '''')
															AND ISNULL(T89.S15ID, '''') = ISNULL(T62.S15ID, '''')
															AND ISNULL(T89.S16ID, '''') = ISNULL(T62.S16ID, '''')
															AND ISNULL(T89.S17ID, '''') = ISNULL(T62.S17ID, '''')
															AND ISNULL(T89.S18ID, '''') = ISNULL(T62.S18ID, '''')
															AND ISNULL(T89.S19ID, '''') = ISNULL(T62.S19ID, '''')
															AND ISNULL(T89.S20ID, '''') = ISNULL(T62.S20ID, '''')
					WHERE T62.DivisionID = T1.DivisionID
							AND T61.DeleteFlag = 0
							AND T62.SOrderID = T2.SOrderID
							AND T62.InheritTransactionID = T2.TransactionID 
							'
									+ CASE WHEN ISNULL(@APKPOT2061, '') = '' 
										   THEN '' 
										   ELSE ' AND T61.APK <> N''' + @APKPOT2061 + '''' 
										   END
			+ ' ), 0) > 0
			'	
		SET @sSQL_06 = @sWhere + '
		GROUP BY T1.APK,
			T2.APK, T1.DivisionID, T1.SOrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,
			T2.TransactionID, T2.SOrderID, T2.InventoryID, InventoryName, T1.ObjectID,
			T2.OrderQuantity, T2.SalePrice, T2.OriginalAmount, T2.ConvertedAmount,
			T2.UnitID, T04.UnitName, T2.Notes,
			T2.Ana01ID, T11.AnaName, T2.Ana02ID, T21.AnaName,
			T2.Ana03ID, T31.AnaName, T2.Ana04ID, T41.AnaName,
			T2.Ana05ID, T51.AnaName, T2.Ana06ID, T61.AnaName,
			T2.Ana07ID, T71.AnaName, T2.Ana08ID, T81.AnaName,
			T2.Ana09ID, T91.AnaName, T2.Ana10ID, T10.AnaName
			, T89.S01ID
			, T89.S02ID
			, T89.S03ID
			, T89.S04ID
			, T89.S05ID
			, T89.S06ID
			, T89.S07ID
			, T89.S08ID
			, T89.S09ID
			, T89.S10ID
			, T89.S11ID
			, T89.S12ID
			, T89.S13ID
			, T89.S14ID
			, T89.S15ID
			, T89.S16ID
			, T89.S17ID
			, T89.S18ID
			, T89.S19ID
			, T89.S20ID
			, T2.OrderQuantity ,T02.Specification, T2.Orders,
			T1.CurrencyID, T05.ObjectName
			'
			+@sSQLSL +' ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	END

PRINT (@sSQL11)
PRINT(@sSQL_01)
PRINT(@sSQL_02) 
PRINT(@sSQL_03) 
PRINT(@sSQL_04) 
PRINT(@sSQL_05) 
PRINT(@sSQL_06) 
PRINT(@sSQL2  )
EXEC (@sSQL11 + @sSQL_01 + @sSQL_02 + @sSQL_03 + @sSQL_04 + @sSQL_05 + @sSQL_06 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
