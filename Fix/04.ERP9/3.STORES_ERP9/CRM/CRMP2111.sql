IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load MASter nghiệp vụ Dự toán
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on: 11/02/2020
---- Update by: Đình Ly on: 10/12/2020
---- Update by: Trọng Kiên on: 08/01/2021
---- Update by: Kiều Nga on: 19/03/2022 : Fix lỗi convert Length, Width, Height
---- Update by: Kiều Nga on: 18/10/2022 : Lấy thêm cột TotalProfitCost,TotalAmount
---- Update by: Nhật Quang	on: 06/01/2023 : HIPC Lấy thêm cột PriceListID
---- Update by: Nhật Quang	on: 20/03/2023 : HIPC Lấy thêm cột TotalSetupTime
---- Update by: Văn Tài		on: 26/06/2023 : Điều chỉnh biến @query_HIPC = ''
---- Update by: Minh Dũng on 14/11/2023: Bổ sung detail customize NKC
-- <Example>
/*
	EXEC CRMP2111 'DTI', '2977ed14-c8b7-478f-abf8-ede2ff241a94', 'b964c015-c496-494b-8cb8-33818d32a7ca', 'PBG'
*/

CREATE PROCEDURE CRMP2111
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMASter VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql Nvarchar(max) ='', 
		@Swhere  Nvarchar(max) = '',
		@query AS NVARCHAR(MAX)='',
	    @cols AS NVARCHAR(MAX)= '',
		@Level INT = 0,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = '',
		@Ssql1 Nvarchar(max) ='',
		@FormatQuantity INT = 0,
		@FormatConvert INT = 0,
		@FormatPercent INT = 0,
		@FormatUnit INT = 0,
		@query_HIPC AS NVARCHAR(MAX)=''

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

IF ((SELECT CustomerName FROM CustomerIndex) = 166)
BEGIN
	SET @FormatQuantity = (SELECT QuantityDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatConvert = (SELECT ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatPercent = (SELECT PercentDecimal FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatUnit = (SELECT UnitCostDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')

IF ISNULL(@Type, '') = 'DT' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),CRMT2110.APKMaster_9000)= '''+@APKMASter+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMASter = @APKMASter
END
ELSE 
BEGIN
	SET @Swhere = @Swhere + 'AND CRMT2110.APK = '''+@APK+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN CRMT2110 ON OOT9001.APKMASter = CRMT2110.APKMaster_9000  WHERE CRMT2110.APK = @APK
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
	SET @sSQLJon = @sSQLJon+ '
					LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMASter,OOT1.DivisionID,OOT1.Status,
						HT14.FullName AS ApprovePerson'+@s+'Name, 
					OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
					OOT1.Note ApprovePerson'+@s+'Note
					FROM OOT9001 OOT1 WITH (NOLOCK)
					INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (''@@@'',OOT1.DivisionID) AND HT14.EmployeeID=OOT1.ApprovePersonID
					LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMASter=''Status''
					WHERE OOT1.Level='+STR(@i)+')APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMASter=OOT90.APK'
	SET @i = @i + 1		
END	

SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM 
(
	SELECT 'I03_'+ CRMT2112.AnaID AS AnaID
	FROM CRMT2112 WITH (NOLOCK)
	INNER JOIN CRMT2110 WITH (NOLOCK) ON CRMT2112.APKMASter = CRMT2110.APK
	WHERE CONVERT(VARCHAR(50),APKMASter) = @APK OR CONVERT(VARCHAR(50),CRMT2110.APKMASter_9000) = @APKMASter
) AS tmp

SELECT @cols = substring(@cols, 0, len(@cols))

SET @query = @query +'LEFT JOIN (SELECT * from 
(
	SELECT CRMT2112.APKMASter AS APKCRMT2112 ,''I03_''+ CRMT2112.AnaID AS AnaID,CRMT2112.[Value] 
	FROM CRMT2112 WITH (NOLOCK)
	INNER JOIN CRMT2110 WITH (NOLOCK) ON CRMT2112.APKMASter = CRMT2110.APK
	WHERE CONVERT(VARCHAR(50),APKMASter)= '''+@APK+''' OR CONVERT(VARCHAR(50),CRMT2110.APKMASter_9000) = '''+@APKMASter+'''
) src	
PIVOT 
(
	MAX(Value) FOR AnaID in (' + @cols + ')
) piv) AS P ON P.APKCRMT2112 = CRMT2110.APK'

IF ISNULL(@cols, '') <> '' 
BEGIN
	 SET @sSQLJon = @sSQLJon + @query
	 SET @sSQLSL = @sSQLSL+ ',P.*'
END

SET @Ssql = @Ssql + N'
	SELECT DISTINCT CRMT2110.APK
		, CRMT2110.DivisionID
		, CRMT2110.VoucherTypeID
		, CRMT2110.VoucherDate
		, CRMT2110.VoucherNo
		, CRMT2110.InventoryID
		, CRMT2110.SemiProduct
		, A1.InventoryName AS SemiProductName
		, AT1302.InventoryName
		, CRMT2110.ObjectID
		, AT1202.ObjectName
		, CRMT2110.DeliveryAddressName
		, CRMT2110.DeliveryTime
		, CRMT2110.PriceListID
		, CRMT2110.ActualQuantity
		, CRMT2110.S01ID
		, CRMT2110.S02ID
		, CRMT2110.S03ID
		, CRMT2110.S04ID
		, CRMT2110.S05ID
		, CRMT2110.S06ID
		, CRMT2110.S07ID
		, CRMT2110.S08ID
		, CRMT2110.S09ID
		, CRMT2110.S10ID
		, CRMT2110.S11ID
		, CRMT2110.S12ID
		, CRMT2110.S13ID
		, CRMT2110.S14ID
		, CRMT2110.S15ID
		, CRMT2110.S16ID
		, CRMT2110.S17ID
		, CRMT2110.S18ID
		, CRMT2110.S19ID
		, CRMT2110.S20ID
		, CRMT2110.TableInherited
		, CRMT0099.Description AS PaperTypeName
		, T3.UserName AS CreateUserID, CRMT2110.CreateDate, T4.UserName AS LastModifyUserID, CRMT2110.LastModifyDate, CRMT2110.APKMaster_9000
	'+@sSQLSL+'
	'

SET @Ssql1= ' FROM CRMT2110 WITH (NOLOCK)
		LEFT JOIN CRMT2111 WITH (NOLOCK) ON CRMT2110.APK = CRMT2111.APKMASter
		LEFT JOIN AT1302 WITH (NOLOCK) ON CRMT2110.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN (''@@@'',CRMT2110.DivisionID)
		LEFT JOIN AT1302 A1 WITH (NOLOCK) ON CRMT2110.SemiProduct = A1.InventoryID AND A1.DivisionID IN (''@@@'',CRMT2110.DivisionID)
		LEFT JOIN CRMT0099 WITH (NOLOCK) ON CRMT0099.CodeMaster like ''%CRMT00000022%'' AND ISNULL(CRMT0099.Disabled, 0)= 0 AND CRMT0099.ID = CRMT2111.PaperTypeID
		LEFT JOIN AT1202 WITH (NOLOCK) ON CRMT2110.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN (''@@@'',CRMT2110.DivisionID)
		LEFT JOIN AT1405 T3 WITH (NOLOCK) ON CRMT2110.CreateUserID = T3.UserID AND CRMT2110.DivisionID = T3.DivisionID
		LEFT JOIN AT1405 T4 WITH (NOLOCK) ON CRMT2110.LAStModifyUserID = T4.UserID AND CRMT2110.DivisionID = T4.DivisionID
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON CRMT2110.APKMaster_9000 = OOT90.APK
		LEFT JOIN CRMT0099 C1 WITH(NOLOCK) ON C1.ID = CRMT2111.FilmStatus AND C1.CodeMaster =''CRMT00000023''
		LEFT JOIN CRMT0099 C2 WITH(NOLOCK) ON C2.ID = CRMT2111.PrintTypeID AND C2.CodeMaster =''CRMF2111.PrintTypeID''
	'+@sSQLJon+' WHERE CRMT2110.DivisionID = '''+@DivisionID+''' '+@Swhere+''
END
BEGIN
IF @CustomerName = 158 -- Customize cho HIPC
	BEGIN
	SET @query_HIPC = '
		, CRMT2110.OriginalQuantityProduct
		, CRMT2110.PriceListID
		, CRMT2111.ScrapPercent
		, CRMT2111.ScrapAdjustment
		, CRMT2111.SetupTimeBase
		, CRMT2111.TotalAdjustment
		, CRMT2111.AdjustmentPercent
		, CRMT2111.TotalAdjustmentPercent
		, CRMT2111.BoxSize
		, CRMT2111.ShippingFee
		, CRMT2111.TotalShipping
		, CRMT2111.Duty
		, CRMT2111.TotalDuty
		, CRMT2111.TotalDutyPercent
		, CRMT2111.TotalCostDutyPercent
		, CRMT2111.TotalSellingPrice
		, CRMT2111.SetupTimePercent
		, CRMT2111.SetupTime500
		, CRMT2111.PercentAdjustment
		, CRMT2111.Fee
		, CRMT2111.DutyPercent
		, CRMT2111.UpPercent
		, CRMT2111.TotalSetupTime
		, CRMT2110.APK_BomVersion
		'
	END
ELSE 
	BEGIN
	SET @query_HIPC = ''
	END

SET @FormatQuantity = (SELECT QuantityDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatConvert = (SELECT ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatPercent = (SELECT PercentDecimal FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatUnit = (SELECT UnitCostDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')

IF ISNULL(@Type, '') = 'DT' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),CRMT2110.APKMaster_9000)= '''+@APKMASter+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMASter = @APKMASter
END
ELSE 
BEGIN
	SET @Swhere = @Swhere + 'AND CRMT2110.APK = '''+@APK+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN CRMT2110 ON OOT9001.APKMASter = CRMT2110.APKMaster_9000  WHERE CRMT2110.APK = @APK
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
	SET @sSQLJon = @sSQLJon+ '
					LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMASter,OOT1.DivisionID,OOT1.Status,
						HT14.FullName AS ApprovePerson'+@s+'Name, 
					OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
					OOT1.Note ApprovePerson'+@s+'Note
					FROM OOT9001 OOT1 WITH (NOLOCK)
					INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (''@@@'',OOT1.DivisionID) AND HT14.EmployeeID=OOT1.ApprovePersonID
					LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMASter=''Status''
					WHERE OOT1.Level='+STR(@i)+')APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMASter=OOT90.APK'
	SET @i = @i + 1		
END	

SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM 
(
	SELECT 'I03_'+ CRMT2112.AnaID AS AnaID
	FROM CRMT2112 WITH (NOLOCK)
	INNER JOIN CRMT2110 WITH (NOLOCK) ON CRMT2112.APKMASter = CRMT2110.APK
	WHERE CONVERT(VARCHAR(50),APKMASter) = @APK OR CONVERT(VARCHAR(50),CRMT2110.APKMASter_9000) = @APKMASter
) AS tmp

SELECT @cols = substring(@cols, 0, len(@cols))

SET @query = @query +'LEFT JOIN (SELECT * from 
(
	SELECT CRMT2112.APKMASter AS APKCRMT2112 ,''I03_''+ CRMT2112.AnaID AS AnaID,CRMT2112.[Value] 
	FROM CRMT2112 WITH (NOLOCK)
	INNER JOIN CRMT2110 WITH (NOLOCK) ON CRMT2112.APKMASter = CRMT2110.APK
	WHERE CONVERT(VARCHAR(50),APKMASter)= '''+@APK+''' OR CONVERT(VARCHAR(50),CRMT2110.APKMASter_9000) = '''+@APKMASter+'''
) src	
PIVOT 
(
	MAX(Value) FOR AnaID in (' + @cols + ')
) piv) AS P ON P.APKCRMT2112 = CRMT2110.APK'

IF ISNULL(@cols, '') <> '' 
BEGIN
	 SET @sSQLJon = @sSQLJon + @query
	 SET @sSQLSL = @sSQLSL+ ',P.*'
END

SET @Ssql = @Ssql + N'
	SELECT DISTINCT CRMT2110.APK
		, CRMT2110.DivisionID
		, CRMT2110.VoucherTypeID
		, CRMT2110.VoucherDate
		, CRMT2110.VoucherNo
		, CRMT2110.InventoryID
		, CRMT2110.SemiProduct
		'+@query_HIPC+'
		, A1.InventoryName AS SemiProductName
		, AT1302.InventoryName
		, CRMT2110.ObjectID
		, AT1202.ObjectName
		, CRMT2110.DeliveryAddressName
		, CRMT2110.DeliveryTime
		, CRMT2111.APKMInherited
		, CRMT2111.APKDInherited
		, CRMT2111.PaperTypeID
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.OffsetQuantity) AS OffsetQuantity
		, CRMT2110.TableInherited
		, CRMT0099.Description AS PaperTypeName
		, CRMT2111.FilmDate, CRMT2111.FilmStatus, C1.Description AS FilmStatusName, CRMT2111.FileName
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.ActualQuantity) AS ActualQuantity
		, CRMT2111.Length,CASE WHEN ISNULL(CRMT2111.Length,'''') <>'''' THEN CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'),CRMT2111.Length) ELSE 0 END AS LengthView
		, CRMT2111.Width,CASE WHEN ISNULL(CRMT2111.Width,'''') <>'''' THEN CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.Width) ELSE 0 END AS WidthView
		, CRMT2111.Height,CASE WHEN ISNULL(CRMT2111.Height,'''') <>''''  THEN CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.Height) ELSE 0 END AS HeightView
		, CRMT2111.PrintNumber, CRMT2111.SideColor1, CRMT2111.ColorPrint01, CRMT2111.SideColor2, CRMT2111.ColorPrint02
		, CRMT2111.ContentSampleDate, CRMT2111.ColorSampleDate, CRMT2111.MTSignedSampleDate
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.FileLength) AS FileLength
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.FileWidth) AS FileWidth
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.FileSum) AS FileSum, CRMT2111.Include, CRMT2111.FileUnitID 
		, CRMT2111.PrintTypeID, C2.Description AS PrintTypeName, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.AmountLoss) AS AmountLoss
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatPercent))+'), CRMT2111.PercentLoss) AS PercentLoss, CRMT2111.Notes
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatPercent))+'), CRMT2111.TotalVariableFee) AS TotalVariableFee
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatConvert))+'), CRMT2111.PercentCost) AS PercentCost
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatPercent))+'), CRMT2111.Cost) AS Cost
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatConvert))+'), CRMT2111.PercentProfit) AS PercentProfit
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatPercent))+'), CRMT2111.Profit) AS Profit
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatUnit))+'), CRMT2111.InvenUnitPrice) AS InvenUnitPrice
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatUnit))+'), CRMT2111.SquareMetersPrice) AS SquareMetersPrice
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatPercent))+'), CRMT2111.ExchangeRate) AS ExchangeRate
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatConvert))+'), CRMT2111.TotalProfitCost) AS TotalProfitCost
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatConvert))+'), CRMT2111.TotalAmount) AS TotalAmount
		, CRMT2111.CurrencyID
		, T3.UserName AS CreateUserID, CRMT2110.CreateDate, T4.UserName AS LastModifyUserID, CRMT2110.LastModifyDate, CRMT2110.APKMaster_9000
	'+@sSQLSL+'
	'

SET @Ssql1= ' FROM CRMT2110 WITH (NOLOCK)
		LEFT JOIN CRMT2111 WITH (NOLOCK) ON CRMT2110.APK = CRMT2111.APKMASter
		LEFT JOIN AT1302 WITH (NOLOCK) ON CRMT2110.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN (''@@@'',CRMT2110.DivisionID)
		LEFT JOIN AT1302 A1 WITH (NOLOCK) ON CRMT2110.SemiProduct = A1.InventoryID AND A1.DivisionID IN (''@@@'',CRMT2110.DivisionID)
		LEFT JOIN CRMT0099 WITH (NOLOCK) ON CRMT0099.CodeMaster like ''%CRMT00000022%'' AND ISNULL(CRMT0099.Disabled, 0)= 0 AND CRMT0099.ID = CRMT2111.PaperTypeID
		LEFT JOIN AT1202 WITH (NOLOCK) ON CRMT2110.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN (''@@@'',CRMT2110.DivisionID)
		LEFT JOIN AT1405 T3 WITH (NOLOCK) ON CRMT2110.CreateUserID = T3.UserID AND CRMT2110.DivisionID = T3.DivisionID
		LEFT JOIN AT1405 T4 WITH (NOLOCK) ON CRMT2110.LAStModifyUserID = T4.UserID AND CRMT2110.DivisionID = T4.DivisionID
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON CRMT2110.APKMaster_9000 = OOT90.APK
		LEFT JOIN CRMT0099 C1 WITH(NOLOCK) ON C1.ID = CRMT2111.FilmStatus AND C1.CodeMaster =''CRMT00000023''
		LEFT JOIN CRMT0099 C2 WITH(NOLOCK) ON C2.ID = CRMT2111.PrintTypeID AND C2.CodeMaster =''CRMF2111.PrintTypeID''
	'+@sSQLJon+' WHERE CRMT2110.DivisionID = '''+@DivisionID+''' '+@Swhere+''
END

PRINT (@Ssql)
PRINT (@Ssql1)

EXEC (@Ssql +@Ssql1)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
