IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2084]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2084]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Details Thông tin sản xuất.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly on 10/12/2020
----Updated by: Trọng Kiên on: 14/01/2021: Xử lý trả dữ liệu cho màn hình duyệt
----Updated by: Trọng Kiên on: 19/01/2021: Xử lý trả thứ tự công đoạn đúng theo PhaseOrder
-- <Example>
----    EXEC SOP2084 'MT','2977ed14-c8b7-478f-abf8-ede2ff241a94','b964c015-c496-494b-8cb8-33818d32a7ca','TTSX'
----
CREATE PROCEDURE SOP2084
( 
	@DivisionID nvarchar(50),
	@APK nvarchar(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25
) 
AS 

DECLARE @sSQL NVARCHAR (MAX) ='',
		@sSQL1 NVARCHAR (MAX) ='',
		@sSQL2 NVARCHAR (MAX) ='',
		@sWhere NVARCHAR(MAX) ='',
		@TotalRow VARCHAR(50) ='',
		@OrderBy VARCHAR(500) =''
       
IF @PageNumber = 1 SET @TotalRow = ' COUNT(*) OVER ()' 
ELSE SET @TotalRow = ' COUNT(*) OVER ()'

SET @Swhere = @Swhere + ' AND ( CONVERT(VARCHAR(50),SOT2082.APKMaster)= '''+@APK+''' OR CONVERT(VARCHAR(50),SOT2082.APKMaster_9000)= '''+@APKMaster+''')'

SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY SOT2082.PhaseOrder) AS RowNum, '+@TotalRow+' AS TotalRow
	     , SOT2082.APK
	     , SOT2082.DivisionID
	     , SOT2082.APKMaster
		 , SOT2082.ProductID
		 , SOT2082.SemiProduct
	     , SOT2082.KindSuppliers
	     , AT1015.AnaName AS KindSupplierName
	     , SOT2082.MaterialID AS InventoryID
	     , AT1302.InventoryName AS MaterialName
		 , SOT2082.NodeTypeID	AS NodeTypeID
		 , MT91.[Description]	AS NodeTypeName
	     , SOT2082.UnitID
		 , AT1304.UnitName
	     , SOT2082.Quantity
	     , IIF(SOT2082.UnitPrice = 0, NULL, SOT2082.UnitPrice) AS UnitPrice
	     , SOT2082.Amount
		 , MT2120.RoutingID
		 , SOT2082.PhaseOrder
		 , SOT2082.PhaseID
		 , AT0126.PhaseName
		 , SOT2082.PrintTypeID
		 , C91.Description AS PrintTypeName
		 , SOT2082.RunWavePaper
		 , IIF(SOT2082.SplitSheets = 0, NULL, SOT2082.SplitSheets) AS SplitSheets
		 , SOT2082.RunPaperID
		 , C92.Description AS RunPaperName
		 , SOT2082.MoldStatusID
		 , C93.Description AS MoldStatusName
		 , IIF(SOT2082.Size = 0, NULL, SOT2082.Size) AS Size
		 , IIF(SOT2082.Cut = 0, NULL, SOT2082.Cut) AS Cut
		 , IIF(SOT2082.Child = 0, NULL, SOT2082.Child) AS Child
		 , SOT2082.MoldDate
		 , IIF(SOT2082.AmountLoss = 0, NULL, SOT2082.AmountLoss) AS AmountLoss
		 , IIF(SOT2082.PercentLoss = 0, NULL, SOT2082.PercentLoss) AS PercentLoss
		 , SOT2082.MoldID
		 , SOT2082.MoldStatusID
		 , SOT2082.MoldDate
		 , IIF(SOT2082.Gsm = 0, NULL, SOT2082.Gsm) AS Gsm
		 , IIF(SOT2082.Sheets = 0, NULL, SOT2082.Sheets) AS Sheets
		 , IIF(SOT2082.Ram = 0, NULL, SOT2082.Ram) AS Ram
		 , IIF(SOT2082.Kg = 0, NULL, SOT2082.Kg) AS Kg
		 , IIF(SOT2082.M2 = 0, NULL, SOT2082.M2) AS M2
		 , SOT2082.DisplayName
		 , IIF(SOT2082.QuantityRunWave = 0, NULL, SOT2082.QuantityRunWave) AS QuantityRunWave
		 , SOT2082.UnitSizeID
		 , MT99.Description AS UnitSizeName
		 , SOT2082.DisplayName
		 , MT98.Description AS DisplayMember
		 , SOT2082.GluingTypeID
		 , C94.Description AS GluingTypeName
	     , SOT2082.S01ID, SOT2082.S02ID, SOT2082.S03ID, SOT2082.S04ID, SOT2082.S05ID
		 , SOT2082.S06ID, SOT2082.S07ID, SOT2082.S08ID, SOT2082.S09ID, SOT2082.S10ID
	     , SOT2082.S11ID, SOT2082.S12ID, SOT2082.S13ID, SOT2082.S14ID, SOT2082.S15ID
		 , SOT2082.S16ID, SOT2082.S17ID, SOT2082.S18ID, SOT2082.S19ID, SOT2082.S20ID
	     , A011.StandardName AS S01Name, A021.StandardName AS S02Name, A031.StandardName As S03Name, A041.StandardName AS S04Name, A051.StandardName AS S05Name
	     , A061.StandardName AS S06Name, A071.StandardName AS S07Name, A081.StandardName As S08Name, A091.StandardName AS S09Name, A101.StandardName AS S10Name
	     , A111.StandardName AS S11Name, A121.StandardName AS S12Name, A131.StandardName As S13Name, A141.StandardName AS S14Name, A151.StandardName AS S15Name
	     , A161.StandardName AS S16Name, A171.StandardName AS S17Name, A181.StandardName As S18Name, A191.StandardName AS S19Name, A201.StandardName AS S20Name
		 '
SET @sSQL1 =
	'
	FROM SOT2082 WITH(NOLOCK)
		LEFT JOIN SOT2080 WITH (NOLOCK) ON CONVERT(VARCHAR(50),SOT2080.APK) = '''+@APK+'''
		LEFT JOIN MT2120 WITH (NOLOCK) ON MT2120.NodeID = SOT2080.InventoryID
		LEFT JOIN AT0126 WITH (NOLOCK) ON AT0126.PhaseID = SOT2082.PhaseID
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster =''StuctureType''
												AND ISNULL(MT91.[Disabled], 0) = 0
												AND MT91.ID = SOT2082.NodeTypeID
		LEFT JOIN CRMT0099 C91 WITH (NOLOCK) ON C91.ID = SOT2082.PrintTypeID 
													AND C91.CodeMaster = ''CRMF2111.PrintType'' 
													AND ISNULL(C91.Disabled, 0) = 0
		LEFT JOIN CRMT0099 C92 WITH (NOLOCK) ON C92.ID = SOT2082.RunPaperID 
													AND C92.CodeMaster = ''CRMF2111.RunPaper'' 
													AND ISNULL(C92.Disabled, 0) = 0
		LEFT JOIN CRMT0099 C93 WITH (NOLOCK) ON C93.ID = SOT2082.MoldStatusID 
													AND C93.CodeMaster = ''CRMF2111.Status'' 
													AND ISNULL(C93.Disabled, 0) = 0
		LEFT JOIN AT1015 WITH (NOLOCK) ON SOT2082.KindSuppliers = AT1015.AnaID
													AND AnaTypeID IN (''I02'',''I03'') 
													AND AT1015.DivisionID IN (''@@@'', SOT2082.DivisionID)
		LEFT JOIN AT1302 WITH (NOLOCK) ON SOT2082.MaterialID = AT1302.InventoryID 
													AND AT1302.DivisionID IN (''@@@'', SOT2082.DivisionID)
		LEFT JOIN AT1304 WITH (NOLOCK) ON SOT2082.UnitID = AT1304.UnitID 
													AND AT1304.DivisionID IN (''@@@'', SOT2082.DivisionID) 
		LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = SOT2082.UnitSizeID 
													AND MT99.CodeMaster = ''UnitSize'' 
													AND ISNULL(MT99.Disabled, 0)= 0 
	'
SET @sSQL2 = N'
		LEFT JOIN CRMT0099 C94 WITH (NOLOCK) ON C94.ID = SOT2082.GluingTypeID 
													AND C94.CodeMaster = ''GluingType'' 
													AND ISNULL(C94.Disabled, 0)= 0
		LEFT JOIN MT0099 MT98 WITH (NOLOCK) ON MT98.ID = SOT2082.DisplayName AND MT98.CodeMaster = ''DisplayName'' AND ISNULL(MT98.Disabled, 0)= 0 
		LEFT JOIN AT0128 A011 WITH (NOLOCK) ON A011.StandardID = SOT2082.S01ID AND A011.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A011.StandardTypeID=''S01''
		LEFT JOIN AT0128 A021 WITH (NOLOCK) ON A021.StandardID = SOT2082.S02ID AND A021.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A021.StandardTypeID=''S02''
		LEFT JOIN AT0128 A031 WITH (NOLOCK) ON A031.StandardID = SOT2082.S03ID AND A031.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A031.StandardTypeID=''S03''
		LEFT JOIN AT0128 A041 WITH (NOLOCK) ON A041.StandardID = SOT2082.S04ID AND A041.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A041.StandardTypeID=''S04''
		LEFT JOIN AT0128 A051 WITH (NOLOCK) ON A051.StandardID = SOT2082.S05ID AND A051.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A051.StandardTypeID=''S05''
		LEFT JOIN AT0128 A061 WITH (NOLOCK) ON A061.StandardID = SOT2082.S06ID AND A061.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A061.StandardTypeID=''S06''
		LEFT JOIN AT0128 A071 WITH (NOLOCK) ON A071.StandardID = SOT2082.S07ID AND A071.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A071.StandardTypeID=''S07''
		LEFT JOIN AT0128 A081 WITH (NOLOCK) ON A081.StandardID = SOT2082.S08ID AND A081.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A081.StandardTypeID=''S08''
		LEFT JOIN AT0128 A091 WITH (NOLOCK) ON A091.StandardID = SOT2082.S09ID AND A091.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A091.StandardTypeID=''S09''
		LEFT JOIN AT0128 A101 WITH (NOLOCK) ON A101.StandardID = SOT2082.S10ID AND A101.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A101.StandardTypeID=''S10''
		LEFT JOIN AT0128 A111 WITH (NOLOCK) ON A111.StandardID = SOT2082.S11ID AND A111.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A111.StandardTypeID=''S11''
		LEFT JOIN AT0128 A121 WITH (NOLOCK) ON A121.StandardID = SOT2082.S12ID AND A121.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A121.StandardTypeID=''S12''
		LEFT JOIN AT0128 A131 WITH (NOLOCK) ON A131.StandardID = SOT2082.S13ID AND A131.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A131.StandardTypeID=''S13''
		LEFT JOIN AT0128 A141 WITH (NOLOCK) ON A141.StandardID = SOT2082.S14ID AND A141.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A141.StandardTypeID=''S14''
		LEFT JOIN AT0128 A151 WITH (NOLOCK) ON A151.StandardID = SOT2082.S15ID AND A151.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A151.StandardTypeID=''S15''
		LEFT JOIN AT0128 A161 WITH (NOLOCK) ON A161.StandardID = SOT2082.S16ID AND A161.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A161.StandardTypeID=''S16''
		LEFT JOIN AT0128 A171 WITH (NOLOCK) ON A171.StandardID = SOT2082.S17ID AND A171.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A171.StandardTypeID=''S17''
		LEFT JOIN AT0128 A181 WITH (NOLOCK) ON A181.StandardID = SOT2082.S18ID AND A181.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A181.StandardTypeID=''S18''
		LEFT JOIN AT0128 A191 WITH (NOLOCK) ON A191.StandardID = SOT2082.S19ID AND A191.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A191.StandardTypeID=''S19''
		LEFT JOIN AT0128 A201 WITH (NOLOCK) ON A201.StandardID = SOT2082.S20ID AND A201.DivisionID IN (''@@@'',SOT2082.DivisionID) AND A201.StandardTypeID=''S20''
	WHERE SOT2082.DivisionID = '''+@DivisionID+''' '+@Swhere+' ORDER BY SOT2082.PhaseOrder' 

IF @Mode = 1
BEGIN
	SET @sSQL2 = @sSQL2 + N'
	, SOT2082.CreateDate
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
print @sSQL
print @sSQL1
print @sSQL2
EXEC (@sSQL + @sSQL1 + @sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
