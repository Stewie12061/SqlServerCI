IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---WMF3001_BC thông tin mặt hàng tồn kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 22/11/2018
----Updated by: Tiến Thành, Date: 25/04/2023 - [2023/04/IS/0049] - Chỉnh xuất báo cáo bằng tên hãng
----Updated by: Anh Đô, Date: 06/06/2023 - Select thêm cột UnitName
----Updated by: Thanh Lượng, Date: 29/12/2023 - [2023/12/TA/0243]: Bổ sung 20 cột S01 - S20ID (nếu có bật Quy cách).
-- <Example>
---- 
/*<Example>
	EXEC WMP3005 'VF', 'VF'',''AS', 11, 2018, 11, 2018, '2018-11-27 00:00:00', '2018-11-27 00:00:00', 'APPLE'',''B', 'PB'',''NM'',''BBTH', 1
	EXEC WMP3005 @DivisionID, @DivisionList, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @FromWareHouseID, @ToWareHouseID,
	@FromInventoryID, @ToInventoryID, @ListFirmID, @ListVoucherTypeID, @IsDate

*/

CREATE PROCEDURE [WMP3005]
( 
		@DivisionID			NVARCHAR(50),
		@DivisionList		NVARCHAR(MAX),
		@PeriodIDList		NVARCHAR(2000),
		@FromMonth			INT = '',
		@FromYear			INT = '',
		@ToMonth			INT = '',
		@ToYear				INT = '',
		@FromDate			DATETIME,
		@ToDate				DATETIME,
		@FromWareHouseID	NVARCHAR(50) = '',
		@ToWareHouseID		NVARCHAR(50) = '',
		@FromInventoryID	NVARCHAR(50) = '',
		@ToInventoryID		NVARCHAR(50) = '',
		@ListFirmID			VARCHAR(MAX) = '', 	 
		@ListVoucherTypeID	VARCHAR(MAX) = '', 
		@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
		@WareHouseID	    NVARCHAR(MAX) = '',
		@InventoryID	    NVARCHAR(MAX) = '',
		@sqlSelect1			NVARCHAR(MAX) = '',
		@sqlGroupBy1		NVARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@PeriodFrom INT,	
		@PeriodTo INT

SET @PeriodFrom = @FromMonth+@FromYear*100
SET @PeriodTo = @ToMonth+@ToYear*100

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
SET @sqlSelect1 = @sqlSelect1 + ',
ISNULL(V70.S01ID,'''') AS S01ID, ISNULL(V70.S02ID,'''') AS S02ID, ISNULL(V70.S03ID,'''') AS S03ID, ISNULL(V70.S04ID,'''') AS S04ID, 
ISNULL(V70.S05ID,'''') AS S05ID, ISNULL(V70.S06ID,'''') AS S06ID, ISNULL(V70.S07ID,'''') AS S07ID, ISNULL(V70.S08ID,'''') AS S08ID, 
ISNULL(V70.S09ID,'''') AS S09ID, ISNULL(V70.S10ID,'''') AS S10ID, ISNULL(V70.S11ID,'''') AS S11ID, ISNULL(V70.S12ID,'''') AS S12ID, 
ISNULL(V70.S13ID,'''') AS S13ID, ISNULL(V70.S14ID,'''') AS S14ID, ISNULL(V70.S15ID,'''') AS S15ID, ISNULL(V70.S16ID,'''') AS S16ID, 
ISNULL(V70.S17ID,'''') AS S17ID, ISNULL(V70.S18ID,'''') AS S18ID, ISNULL(V70.S19ID,'''') AS S19ID, ISNULL(V70.S20ID,'''') AS S20ID
'
SET @sqlGroupBy1 = @sqlGroupBy1 + ',
ISNULL(V70.S01ID,''''), ISNULL(V70.S02ID,''''), ISNULL(V70.S03ID,''''), ISNULL(V70.S04ID,''''), ISNULL(V70.S05ID,''''), 
ISNULL(V70.S06ID,''''), ISNULL(V70.S07ID,''''), ISNULL(V70.S08ID,''''), ISNULL(V70.S09ID,''''), ISNULL(V70.S10ID,''''),
ISNULL(V70.S11ID,''''), ISNULL(V70.S12ID,''''), ISNULL(V70.S13ID,''''), ISNULL(V70.S14ID,''''), ISNULL(V70.S15ID,''''), 
ISNULL(V70.S16ID,''''), ISNULL(V70.S17ID,''''), ISNULL(V70.S18ID,''''), ISNULL(V70.S19ID,''''), ISNULL(V70.S20ID,'''')'

END

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' AND V70.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' AND V70.DivisionID = '''+@DivisionID+''''

IF ISNULL(@FromWareHouseID,'') <> '' AND ISNULL(@ToWareHouseID,'') <>''
	SET @sWhere = @sWhere + ' AND V70.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''' '

IF ISNULL(@FromInventoryID,'') <> '' AND ISNULL(@ToInventoryID,'') <>''
	SET @sWhere = @sWhere + ' AND V70.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' '

IF ISNULL(@WareHouseID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(V70.WareHouseID, '''') IN (''' + @WareHouseID + ''') '

IF ISNULL(@InventoryID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(V70.InventoryID, '''') IN (''' + @InventoryID + ''') '

----Search theo hãng 
IF ISNULL(@ListFirmID,'') = ''
	SET @sWhere = @sWhere + ' AND (V70.I01ID LIKE ''%'' OR V70.I01ID IS NULL)'
ELSE 
	SET @sWhere = @sWhere + ' AND V70.I01ID IN ('''+@ListFirmID+''') '

IF ISNULL(@ListVoucherTypeID,'') = ''
	SET @sWhere = @sWhere + ' AND (V70.VoucherTypeID LIKE ''%'' OR V70.VoucherTypeID IS NULL)'
ELSE 
	SET @sWhere = @sWhere + ' AND V70.VoucherTypeID IN ('''+@ListVoucherTypeID+''') '


--IF @IsDate = 1
--	BEGIN	
--		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
--			AND CONVERT(VARCHAR(10),V70.VoucherDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
--		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
--			AND CONVERT(VARCHAR(10),V70.VoucherDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
--		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
--			AND CONVERT(VARCHAR(10),V70.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
--	END
--ELSE	
--	BEGIN
--		IF (@FromMonth IS NOT NULL AND @ToMonth IS NULL) SET @sWhere = @sWhere + '
--			AND V70.TranMonth + V70.TranYear * 100 >= '+Ltrim(@PeriodFrom)+''
--		IF (@FromMonth IS NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
--			AND V70.TranMonth + V70.TranYear * 100 <= '+Ltrim(@PeriodTo)+''
--		IF (@FromMonth IS NOT NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
--			AND V70.TranMonth + V70.TranYear * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND '+LTrim(@PeriodTo)+''
--	END	

	IF @IsDate = 1	
	BEGIN

		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),V70.VoucherDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),V70.VoucherDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),V70.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '

	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND (Case When  V70.TranMonth <10 then ''0''+rtrim(ltrim(str(V70.TranMonth)))+''/''
								+ltrim(Rtrim(str(V70.TranYear))) Else rtrim(ltrim(str(V70.TranMonth)))+''/''
								+ltrim(Rtrim(str(V70.TranYear))) End) IN ('''+@PeriodIDList+''')'
	END
		
SET @sSQL = @sSQL +'
SELECT V70.DivisionID, T101.DivisionName, V70.WareHouseID, '''' As WareHouseTypeID, V70.InventoryID, V70.InventoryName, 
V70.I01ID, V70.I02ID, V70.I03ID,
T115.AnaName As Firm, T105.AnaName As ProductTypeID, T005.AnaName As Model,
SUM(V70.SignQuantity) As Quantity, V70.InventoryTypeID, T006.InventoryTypeName, T007.WareHouseName
, V70.UnitName
'+@sqlSelect1+'
FROM AV7000 V70 WITH (NOLOCK)
LEFT JOIN AT1101 T101 WITH (NOLOCK) ON T101.DivisionID = V70.DivisionID
LEFT JOIN AT1015 T115 WITH (NOLOCK) ON V70.I01ID = T115.AnaID AND T115.AnaTypeID = ''I01''
LEFT JOIN AT1015 T105 WITH (NOLOCK) ON V70.I02ID = T105.AnaID AND T105.AnaTypeID = ''I02''
LEFT JOIN AT1015 T005 WITH (NOLOCK) ON V70.I03ID = T005.AnaID AND T005.AnaTypeID = ''I03''
LEFT JOIN AT1301 T006 WITH (NOLOCK) ON V70.InventoryTypeID = T006.InventoryTypeID
LEFT JOIN AT1303 T007 WITH (NOLOCK) ON V70.WareHouseID = T007.WareHouseID
WHERE 1=1 
'+@sWhere+'
GROUP BY V70.DivisionID, T101.DivisionName, V70.WareHouseID, V70.InventoryID, V70.InventoryName, 
V70.I01ID, V70.I02ID, V70.I03ID,
T115.AnaName, T105.AnaName, T005.AnaName, V70.InventoryTypeID, T006.InventoryTypeName, T007.WareHouseName
, V70.UnitName
'+@sqlGroupBy1+'
'

PRINT (@sSQL)
PRINT (@sWhere)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
