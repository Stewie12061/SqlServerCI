IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2113]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2113]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load dữ liệu cho màn hình chọn phiếu Yêu cầu khách hàng.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on 17/01/2020
---- Modified by: Đình Ly on 02/01/2021
---- Modified by: Trọng Kiên on 04/01/2021
---- Modified by: ĐÌnh Hòa on 07/01/2021 : Bổ sung load thêm các trường của phiếu yêu cầu khách hàng
-- <Example>
/*
	EXEC OOP2110 'KY', '', '', '', N'', N'', N'', N'', N'', N'', N'', 2, N'', N'', 1, 10
*/
CREATE PROCEDURE CRMP2113
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@IsDate TINYINT, --0:Datetime; 1:Period
	@Periods NVARCHAR(MAX),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@VoucherNo VARCHAR(50),
	@InventoryID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@FormatQuantity INT = 0

SET @FormatQuantity = (SELECT QuantityDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')

SET @sWhere = @sWhere + N'T1.DeleteFlg =0 AND T1.DivisionID  ='''+@DivisionID+''''

IF ISNULL(@VoucherNo,'')<> ''
	SET @sWhere = @sWhere + N'AND T1.VoucherNo LIKE ''%' +@VoucherNo+'%'''

IF ISNULL(@InventoryID,'')<> ''
	SET @sWhere = @sWhere + N'AND T2.InventoryID LIKE ''%' +@InventoryID+'%'''

IF @IsDate = 0 
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), T1.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
ELSE 
	SET @sWhere = @sWhere + ' AND (Case When  T1.TranMonth <10 then ''0''+rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) 
								ELSE rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) End) IN ('''+@Periods+''')'

SET @sSQL = @sSQL + N'
	SELECT ROW_NUMBER() OVER (ORDER BY T1.VoucherDate DESC ,T1.VoucherNo) AS RowNum
		, COUNT(*) OVER () As TotalRow
		, T1.VoucherNo
		, T1.VoucherDate
		, T1.ObjectID
		, T5.ObjectName
		, T2.InventoryID
		, T3.InventoryName
		, T4.InventoryTypeID
		, T4.InventoryTypeName
		, T2.MarketID
		, T1.DeliveryAddress
		, T2.PaperTypeID
		, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), T2.ActualQuantity) AS ActualQuantity
		, T2.[Length]
		, T2.CutSize
		, T2.PrintSize
		, T2.Width
		, T2.Height
		, T2.LengthPaper
		, T2.WidthPaper
		, T2.SideColor1 AS IsSideColor1
		, T2.SideColor2 AS IsSideColor2
		, T2.ColorPrint01 AS SideColor1
		, T2.ColorPrint02 AS SideColor2
		, T2.Pack
		, T2.InvenPrintSheet
		, T2.InvenMold
		, T2.OffsetPaper
		, T6.InventoryName AS OffsetPaperName
		, T2.PrintNumber
		, T2.FilmDate
		, T2.StatusFilm
		, T2.StatusMold
		, T2.LengthFilm
		, T2.WidthFilm
		, T2.PaymentID
		, T1.APK
		, T2.DeliveryTime, T2.FileName, T2.ProductQuality, T2.SampleContent, T2.ColorSample
	FROM CRMT2100 T1 WITH (NOLOCK)
		LEFT JOIN CRMT2101 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
		LEFT JOIN AT1302 T3 WITH (NOLOCK) ON T3.InventoryID = T2.InventoryID AND T2.DivisionID = T3.DivisionID And T3.Disabled =0
		LEFT JOIN AT1301 T4 WITH (NOLOCK) ON T4.InventoryTypeID = T3.InventoryTypeID AND T3.DivisionID = T4.DivisionID And T4.Disabled =0
		LEFT JOIN AT1202 T5 WITH (NOLOCK) ON T5.ObjectID = T1.ObjectID AND T1.DivisionID = T5.DivisionID And T5.Disabled =0
		LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T6.InventoryID = T2.OffsetPaper AND T2.DivisionID = T6.DivisionID And T6.Disabled =0
	WHERE '+@sWhere

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
