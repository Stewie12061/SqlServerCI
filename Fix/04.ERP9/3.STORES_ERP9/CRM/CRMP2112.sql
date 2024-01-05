IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load dữ liệu Details phiếu Dự toán.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga on 05/05/2017
----Created by: Đìnhh Ly on 10/12/2020
----Modify by: Đình Hòa on 23/04/2021
----Modify by: Đình Hòa on 05/07/2021 : Bổ sung load ghi chú NoteDetail
----Modify by: Nhật Quang on 07/01/2023 : Bổ sung customer HIPC
----Modify by: Nhật Quang on 23/03/2023 : HIPC Bổ sung thêm trường OrderNo
----Modify by: Đức Tuyên on 06/04/2023 : HIPC Bổ sung thêm trường và sắp xếp
----Modify by: Minh Dũng on 14/11/2023 : NKC Bổ sung lấy data.
-- <Example>
----    EXEC CRMP2112 'MT','2977ed14-c8b7-478f-abf8-ede2ff241a94','b964c015-c496-494b-8cb8-33818d32a7ca','DT'
----
CREATE PROCEDURE CRMP2112
( 
	@DivisionID nvarchar(50),
	@APK nvarchar(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode INT = 0, ---- 0 Edit, 1 view
	@PageNumber INT = 1,
	@PageSize INT = 25
) 
AS 

DECLARE @sSQL NVARCHAR (MAX) ='',
		@sSQL1 NVARCHAR (MAX) ='',
		@sSQL2 NVARCHAR (MAX) ='',
		@sWhere NVARCHAR(MAX) ='',
		@TotalRow VARCHAR(50) ='',
		@OrderBy NVARCHAR(500) ='',
		@query_HIPC AS NVARCHAR(MAX)='',
		@query_NKC AS NVARCHAR(MAX)= '',
		@join_NKC AS NVARCHAR(MAX)= ''

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

SET @query_HIPC = ''

IF @CustomerName = 158 -- Customize cho HIPC
	BEGIN
		SET @query_HIPC = '
			 , CRMT2114.NoteDetail
			 , CRMT2114.OriginalInventoryID
			 , CRMT2114.OriginalQuantity
			 , Convert(Decimal(28,8), CRMT2114.OriginalQuantityLoss) AS OriginalQuantityLoss
			 , CRMT2114.NormsType
			 , CRMT2114.NormsTypeID
			 , CRMT2114.SetupTime
			 , CRMT2114.LossValue
			 , CRMT2114.LossAmount
			 , CRMT2114.OrderNo
			 , CRMT2114.MaterialGroupID
			 , CRMT2114.NodeOrder AS NodeOrders
			 '
	
		SET @TotalRow = ' COUNT(*) OVER ()' 

		SET @Swhere = @Swhere + ' AND ( CONVERT(VARCHAR(50),CRMT2114.APKMaster)= '''+@APK+''' OR CONVERT(VARCHAR(50),CRMT2114.APKMaster_9000)= '''+@APKMaster+''')'

		SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY CRMT2114.NormsType, CRMT2114.PhaseOrder, CRMT2114.PhaseID) AS RowNum, '+@TotalRow+' AS TotalRow
					, CRMT2114.APK
					, CRMT2114.DivisionID
					, CRMT2114.APKMaster
					, CRMT2114.KindSuppliers
					--, AT1015.AnaName as KindSupplierName
					, CRMT2114.MaterialID as InventoryID
					, CRMT2114.MaterialID
					, AT1302.InventoryName as MaterialName
					, CRMT2114.UnitID,AT1304.UnitName
					, CRMT2114.Quantity
					, Convert(Decimal(28,8), CRMT2114.QuantityLoss) AS QuantityLoss
					, IIF(CRMT2114.UnitPrice = 0, NULL, CRMT2114.UnitPrice) AS UnitPrice
					, CRMT2114.Amount
					--, MT2120.RoutingID
					, CRMT2114.PhaseOrder 
					, CRMT2114.PhaseID, AT0126.PhaseName
					, CRMT2114.DisplayName, MT93.Description AS DisplayMember
					, CRMT2114.GluingTypeID, C94.Description AS GluingTypeName
					, CRMT2114.DisplayName, IIF(CRMT2114.QuantityRunWave = 0, NULL, CRMT2114.QuantityRunWave) AS QuantityRunWave, UnitSizeID, MT99.Description AS UnitSizeName
					, CRMT2114.PrintTypeID, C91.Description AS PrintTypeName, CRMT2114.RunWavePaper, IIF(CRMT2114.SplitSheets = 0, NULL, CRMT2114.SplitSheets) AS SplitSheets
					, CRMT2114.RunPaperID, C92.Description AS RunPaperName, CRMT2114.MoldStatusID, C93.Description AS MoldStatusName
					, IIF(CRMT2114.Size = 0, NULL, CRMT2114.Size) AS Size , IIF(CRMT2114.Cut = 0, NULL, CRMT2114.Cut) AS Cut
					, IIF(CRMT2114.Child = 0, NULL, CRMT2114.Child) AS Child, CRMT2114.MoldDate, IIF(CRMT2114.AmountLoss = 0, NULL, CRMT2114.AmountLoss) AS AmountLoss
					, IIF(CRMT2114.PercentLoss = 0, NULL, CRMT2114.PercentLoss) AS PercentLoss
					, CRMT2114.MoldID, CRMT2114.MoldStatusID, CRMT2114.MoldDate, IIF(CRMT2114.Gsm = 0, NULL, CRMT2114.Gsm) AS Gsm
					, IIF(CRMT2114.Sheets = 0, NULL, CRMT2114.Sheets) AS Sheets, IIF(CRMT2114.Ram = 0, NULL, CRMT2114.Ram) AS Ram
					, IIF(CRMT2114.Kg = 0, NULL, CRMT2114.Kg) AS Kg, IIF(CRMT2114.M2 = 0, NULL, CRMT2114.M2) AS M2
					, CRMT2114.S01ID,CRMT2114.S02ID,CRMT2114.S03ID,CRMT2114.S04ID,CRMT2114.S05ID,CRMT2114.S06ID,CRMT2114.S07ID,CRMT2114.S08ID,CRMT2114.S09ID,CRMT2114.S10ID
					, CRMT2114.S11ID,CRMT2114.S12ID,CRMT2114.S13ID,CRMT2114.S14ID,CRMT2114.S15ID,CRMT2114.S16ID,CRMT2114.S17ID,CRMT2114.S18ID,CRMT2114.S19ID,CRMT2114.S20ID
					, A011.StandardName As S01Name,A021.StandardName As S02Name,A031.StandardName As S03Name,A041.StandardName As S04Name,A051.StandardName As S05Name
					, A061.StandardName As S06Name,A071.StandardName As S07Name,A081.StandardName As S08Name,A091.StandardName As S09Name,A101.StandardName As S10Name
					, A111.StandardName As S11Name,A121.StandardName As S12Name,A131.StandardName As S13Name,A141.StandardName As S14Name,A151.StandardName As S15Name
					, A161.StandardName As S16Name,A171.StandardName As S17Name,A181.StandardName As S18Name,A191.StandardName As S19Name,A201.StandardName As S20Name
				'+@query_HIPC+''
		SET @sSQL1 = N'
			FROM CRMT2114 WITH(NOLOCK)
				--LEFT JOIN CRMT2110 WITH (NOLOCK) ON CONVERT(VARCHAR(50),CRMT2110.APK) = CRMT2114.APKMaster
				--LEFT JOIN MT2120 WITH (NOLOCK) ON MT2120.NodeID = CRMT2110.InventoryID
				LEFT JOIN AT0126 WITH (NOLOCK) ON AT0126.PhaseID = CRMT2114.PhaseID
				LEFT JOIN CRMT0099 C91 WITH (NOLOCK) ON C91.ID = CRMT2114.PrintTypeID AND C91.CodeMaster = ''CRMF2111.PrintType'' AND ISNULL(C91.Disabled, 0)= 0
				LEFT JOIN CRMT0099 C92 WITH (NOLOCK) ON C92.ID = CRMT2114.RunPaperID AND C92.CodeMaster = ''CRMF2111.RunPaper'' AND ISNULL(C92.Disabled, 0)= 0
				LEFT JOIN CRMT0099 C93 WITH (NOLOCK) ON C93.ID = CRMT2114.MoldStatusID AND C93.CodeMaster = ''CRMF2111.Status'' AND ISNULL(C93.Disabled, 0)= 0
				LEFT JOIN CRMT0099 C94 WITH (NOLOCK) ON C94.ID = CRMT2114.GluingTypeID AND C94.CodeMaster = ''GluingType'' AND ISNULL(C94.Disabled, 0)= 0
				LEFT JOIN AT1015 WITH (NOLOCK) ON CRMT2114.KindSuppliers = AT1015.AnaID AND AnaTypeID IN (''I02'',''I03'') AND AT1015.DivisionID IN (''@@@'',CRMT2114.DivisionID)
				
		
				LEFT JOIN AT1302 WITH (NOLOCK) ON CRMT2114.MaterialID = AT1302.InventoryID  AND AT1302.DivisionID IN (''@@@'',CRMT2114.DivisionID)
				LEFT JOIN AT1304 WITH (NOLOCK) ON CRMT2114.UnitID = AT1304.UnitID AND AT1304.DivisionID IN (''@@@'',CRMT2114.DivisionID)
				LEFT JOIN MT0099 MT93 WITH (NOLOCK) ON MT93.ID = CRMT2114.DisplayName AND ISNULL(MT93.Disabled, 0)= 0 AND MT93.CodeMaster = ''DisplayName''
				LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = CRMT2114.UnitSizeID AND MT99.CodeMaster = ''UnitSize'' AND ISNULL(MT99.Disabled, 0)= 0
				LEFT JOIN AT0128 A011 WITH (NOLOCK) ON A011.StandardID = CRMT2114.S01ID AND A011.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A011.StandardTypeID=''S01''
				LEFT JOIN AT0128 A021 WITH (NOLOCK) ON A021.StandardID = CRMT2114.S02ID AND A021.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A021.StandardTypeID=''S02''
				LEFT JOIN AT0128 A031 WITH (NOLOCK) ON A031.StandardID = CRMT2114.S03ID AND A031.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A031.StandardTypeID=''S03''
				LEFT JOIN AT0128 A041 WITH (NOLOCK) ON A041.StandardID = CRMT2114.S04ID AND A041.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A041.StandardTypeID=''S04''
				LEFT JOIN AT0128 A051 WITH (NOLOCK) ON A051.StandardID = CRMT2114.S05ID AND A051.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A051.StandardTypeID=''S05''
				LEFT JOIN AT0128 A061 WITH (NOLOCK) ON A061.StandardID = CRMT2114.S06ID AND A061.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A061.StandardTypeID=''S06''
				LEFT JOIN AT0128 A071 WITH (NOLOCK) ON A071.StandardID = CRMT2114.S07ID AND A071.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A071.StandardTypeID=''S07'''
		SET @sSQL2 = N'	
				LEFT JOIN AT0128 A081 WITH (NOLOCK) ON A081.StandardID = CRMT2114.S08ID AND A081.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A081.StandardTypeID=''S08''
				LEFT JOIN AT0128 A091 WITH (NOLOCK) ON A091.StandardID = CRMT2114.S09ID AND A091.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A091.StandardTypeID=''S09''
				LEFT JOIN AT0128 A101 WITH (NOLOCK) ON A101.StandardID = CRMT2114.S10ID AND A101.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A101.StandardTypeID=''S10''
				LEFT JOIN AT0128 A111 WITH (NOLOCK) ON A111.StandardID = CRMT2114.S11ID AND A111.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A111.StandardTypeID=''S11''
				LEFT JOIN AT0128 A121 WITH (NOLOCK) ON A121.StandardID = CRMT2114.S12ID AND A121.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A121.StandardTypeID=''S12''
				LEFT JOIN AT0128 A131 WITH (NOLOCK) ON A131.StandardID = CRMT2114.S13ID AND A131.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A131.StandardTypeID=''S13''
				LEFT JOIN AT0128 A141 WITH (NOLOCK) ON A141.StandardID = CRMT2114.S14ID AND A141.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A141.StandardTypeID=''S14''
				LEFT JOIN AT0128 A151 WITH (NOLOCK) ON A151.StandardID = CRMT2114.S15ID AND A151.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A151.StandardTypeID=''S15''
				LEFT JOIN AT0128 A161 WITH (NOLOCK) ON A161.StandardID = CRMT2114.S16ID AND A161.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A161.StandardTypeID=''S16''
				LEFT JOIN AT0128 A171 WITH (NOLOCK) ON A171.StandardID = CRMT2114.S17ID AND A171.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A171.StandardTypeID=''S17''
				LEFT JOIN AT0128 A181 WITH (NOLOCK) ON A181.StandardID = CRMT2114.S18ID AND A181.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A181.StandardTypeID=''S18''
				LEFT JOIN AT0128 A191 WITH (NOLOCK) ON A191.StandardID = CRMT2114.S19ID AND A191.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A191.StandardTypeID=''S19''
				LEFT JOIN AT0128 A201 WITH (NOLOCK) ON A201.StandardID = CRMT2114.S20ID AND A201.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A201.StandardTypeID=''S20''
			WHERE CRMT2114.DivisionID = '''+@DivisionID+''' '+@Swhere+'
							ORDER BY CRMT2114.OrderNo'

		IF @Mode = 1
		BEGIN
			SET @sSQL2 = @sSQL2+N'
			 --,CRMT2114.NormsType, CRMT2114.PhaseOrder, CRMT2114.PhaseID
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		END

	END
ELSE IF @CustomerName = 166 -- NKC
BEGIN
	SET @query_NKC = '
		, CRMT2114.UnitPriceAverage
		, CRMT2114.NodeID
		, CRMT2114.DisplayName as MaterialName
	'

	SET @join_NKC = ''


SET @TotalRow = ' COUNT(*) OVER ()' 

	SET @Swhere = @Swhere + ' AND ( CONVERT(VARCHAR(50),CRMT2114.APKMaster)= '''+@APKMaster+''' OR CONVERT(VARCHAR(50),CRMT2114.APKMaster_9000)= '''+@APKMaster+''')'

	SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (ORDER BY CRMT2114.DisplayName) AS RowNum, '+@TotalRow+' AS TotalRow
			 '+@query_NKC+'
			 , CRMT2114.APK
			 , CRMT2114.DivisionID
			 , CRMT2114.APKMaster
			 , CRMT2114.KindSuppliers
			 , AT1015.AnaName as KindSupplierName
			 , CRMT2114.MaterialID as InventoryID
			 --, AT1302.InventoryName as MaterialName
			 , CRMT2114.UnitID,AT1304.UnitName
			 , CRMT2114.Quantity
			 , MT2123.QuantitativeValue
			 , IIF(CRMT2114.UnitPrice = 0, NULL, CRMT2114.UnitPrice) AS UnitPrice
			 , CRMT2114.Amount
			 , MT2120.RoutingID, CRMT2114.PhaseOrder 
			 , CRMT2114.PhaseID, AT0126.PhaseName
			 , CRMT2114.DisplayName, MT93.Description AS DisplayMember
			 , CRMT2114.GluingTypeID, C94.Description AS GluingTypeName
			 , CRMT2114.DisplayName, IIF(CRMT2114.QuantityRunWave = 0, NULL, CRMT2114.QuantityRunWave) AS QuantityRunWave, UnitSizeID, MT99.Description AS UnitSizeName
			 , CRMT2114.PrintTypeID, C91.Description AS PrintTypeName, CRMT2114.RunWavePaper, IIF(CRMT2114.SplitSheets = 0, NULL, CRMT2114.SplitSheets) AS SplitSheets
			 , CRMT2114.RunPaperID, C92.Description AS RunPaperName, CRMT2114.MoldStatusID, C93.Description AS MoldStatusName
			 , IIF(CRMT2114.Size = 0, NULL, CRMT2114.Size) AS Size , IIF(CRMT2114.Cut = 0, NULL, CRMT2114.Cut) AS Cut
			 , IIF(CRMT2114.Child = 0, NULL, CRMT2114.Child) AS Child, CRMT2114.MoldDate, IIF(CRMT2114.AmountLoss = 0, NULL, CRMT2114.AmountLoss) AS AmountLoss
			 , IIF(CRMT2114.PercentLoss = 0, NULL, CRMT2114.PercentLoss) AS PercentLoss
			 , CRMT2114.MoldID, CRMT2114.MoldStatusID, CRMT2114.MoldDate, IIF(CRMT2114.Gsm = 0, NULL, CRMT2114.Gsm) AS Gsm
			 , IIF(CRMT2114.Sheets = 0, NULL, CRMT2114.Sheets) AS Sheets, IIF(CRMT2114.Ram = 0, NULL, CRMT2114.Ram) AS Ram
			 , IIF(CRMT2114.Kg = 0, NULL, CRMT2114.Kg) AS Kg, IIF(CRMT2114.M2 = 0, NULL, CRMT2114.M2) AS M2
			 , CRMT2114.S01ID,CRMT2114.S02ID,CRMT2114.S03ID,CRMT2114.S04ID,CRMT2114.S05ID,CRMT2114.S06ID,CRMT2114.S07ID,CRMT2114.S08ID,CRMT2114.S09ID,CRMT2114.S10ID
			 , CRMT2114.S11ID,CRMT2114.S12ID,CRMT2114.S13ID,CRMT2114.S14ID,CRMT2114.S15ID,CRMT2114.S16ID,CRMT2114.S17ID,CRMT2114.S18ID,CRMT2114.S19ID,CRMT2114.S20ID
			 , A011.StandardName As S01Name,A021.StandardName As S02Name,A031.StandardName As S03Name,A041.StandardName As S04Name,A051.StandardName As S05Name
			 , A061.StandardName As S06Name,A071.StandardName As S07Name,A081.StandardName As S08Name,A091.StandardName As S09Name,A101.StandardName As S10Name
			 , A111.StandardName As S11Name,A121.StandardName As S12Name,A131.StandardName As S13Name,A141.StandardName As S14Name,A151.StandardName As S15Name
			 , A161.StandardName As S16Name,A171.StandardName As S17Name,A181.StandardName As S18Name,A191.StandardName As S19Name,A201.StandardName As S20Name

		FROM CRMT2114 WITH(NOLOCK)
			LEFT JOIN CRMT2110 WITH (NOLOCK) ON CONVERT(VARCHAR(50),CRMT2110.APK) = '''+@APKMaster+'''
			LEFT JOIN MT2122 WITH (NOLOCK) ON MT2122.APK = CRMT2110.APK_BomVersion
			LEFT JOIN MT2123 WITH (NOLOCK) ON MT2123.NodeID = CRMT2114.NodeID and MT2123.APKMaster = MT2122.APK and MT2123.NodeTypeId = 2
			LEFT JOIN MT2120 WITH (NOLOCK) ON MT2120.NodeID = CRMT2110.InventoryID
			LEFT JOIN AT0126 WITH (NOLOCK) ON AT0126.PhaseID = CRMT2114.PhaseID
			LEFT JOIN CRMT0099 C91 WITH (NOLOCK) ON C91.ID = CRMT2114.PrintTypeID AND C91.CodeMaster = ''CRMF2111.PrintType'' AND ISNULL(C91.Disabled, 0)= 0
			LEFT JOIN CRMT0099 C92 WITH (NOLOCK) ON C92.ID = CRMT2114.RunPaperID AND C92.CodeMaster = ''CRMF2111.RunPaper'' AND ISNULL(C92.Disabled, 0)= 0
			LEFT JOIN CRMT0099 C93 WITH (NOLOCK) ON C93.ID = CRMT2114.MoldStatusID AND C93.CodeMaster = ''CRMF2111.Status'' AND ISNULL(C93.Disabled, 0)= 0
			LEFT JOIN CRMT0099 C94 WITH (NOLOCK) ON C94.ID = CRMT2114.GluingTypeID AND C94.CodeMaster = ''GluingType'' AND ISNULL(C94.Disabled, 0)= 0
			LEFT JOIN AT1015 WITH (NOLOCK) ON CRMT2114.KindSuppliers = AT1015.AnaID AND AnaTypeID IN (''I02'',''I03'') AND AT1015.DivisionID IN (''@@@'',CRMT2114.DivisionID)
			'
	SET @sSQL1 = N'	
			--LEFT JOIN AT1302 WITH (NOLOCK) ON CRMT2114.InventoryID = AT1302.InventoryID  AND AT1302.DivisionID IN (''@@@'',CRMT2114.DivisionID)
			LEFT JOIN AT1304 WITH (NOLOCK) ON CRMT2114.UnitID = AT1304.UnitID AND AT1304.DivisionID IN (''@@@'',CRMT2114.DivisionID)
			LEFT JOIN MT0099 MT93 WITH (NOLOCK) ON MT93.ID = CRMT2114.DisplayName AND ISNULL(MT93.Disabled, 0)= 0 AND MT93.CodeMaster = ''DisplayName''
			LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = CRMT2114.UnitSizeID AND MT99.CodeMaster = ''UnitSize'' AND ISNULL(MT99.Disabled, 0)= 0
			LEFT JOIN AT0128 A011 WITH (NOLOCK) ON A011.StandardID = CRMT2114.S01ID AND A011.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A011.StandardTypeID=''S01''
			LEFT JOIN AT0128 A021 WITH (NOLOCK) ON A021.StandardID = CRMT2114.S02ID AND A021.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A021.StandardTypeID=''S02''
			LEFT JOIN AT0128 A031 WITH (NOLOCK) ON A031.StandardID = CRMT2114.S03ID AND A031.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A031.StandardTypeID=''S03''
			LEFT JOIN AT0128 A041 WITH (NOLOCK) ON A041.StandardID = CRMT2114.S04ID AND A041.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A041.StandardTypeID=''S04''
			LEFT JOIN AT0128 A051 WITH (NOLOCK) ON A051.StandardID = CRMT2114.S05ID AND A051.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A051.StandardTypeID=''S05''
			LEFT JOIN AT0128 A061 WITH (NOLOCK) ON A061.StandardID = CRMT2114.S06ID AND A061.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A061.StandardTypeID=''S06''
			LEFT JOIN AT0128 A071 WITH (NOLOCK) ON A071.StandardID = CRMT2114.S07ID AND A071.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A071.StandardTypeID=''S07''
			LEFT JOIN AT0128 A081 WITH (NOLOCK) ON A081.StandardID = CRMT2114.S08ID AND A081.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A081.StandardTypeID=''S08''
			LEFT JOIN AT0128 A091 WITH (NOLOCK) ON A091.StandardID = CRMT2114.S09ID AND A091.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A091.StandardTypeID=''S09''
			LEFT JOIN AT0128 A101 WITH (NOLOCK) ON A101.StandardID = CRMT2114.S10ID AND A101.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A101.StandardTypeID=''S10''
			LEFT JOIN AT0128 A111 WITH (NOLOCK) ON A111.StandardID = CRMT2114.S11ID AND A111.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A111.StandardTypeID=''S11''
			LEFT JOIN AT0128 A121 WITH (NOLOCK) ON A121.StandardID = CRMT2114.S12ID AND A121.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A121.StandardTypeID=''S12''
			LEFT JOIN AT0128 A131 WITH (NOLOCK) ON A131.StandardID = CRMT2114.S13ID AND A131.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A131.StandardTypeID=''S13''
			LEFT JOIN AT0128 A141 WITH (NOLOCK) ON A141.StandardID = CRMT2114.S14ID AND A141.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A141.StandardTypeID=''S14''
			LEFT JOIN AT0128 A151 WITH (NOLOCK) ON A151.StandardID = CRMT2114.S15ID AND A151.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A151.StandardTypeID=''S15''
			LEFT JOIN AT0128 A161 WITH (NOLOCK) ON A161.StandardID = CRMT2114.S16ID AND A161.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A161.StandardTypeID=''S16''
			LEFT JOIN AT0128 A171 WITH (NOLOCK) ON A171.StandardID = CRMT2114.S17ID AND A171.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A171.StandardTypeID=''S17''
			LEFT JOIN AT0128 A181 WITH (NOLOCK) ON A181.StandardID = CRMT2114.S18ID AND A181.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A181.StandardTypeID=''S18''
			LEFT JOIN AT0128 A191 WITH (NOLOCK) ON A191.StandardID = CRMT2114.S19ID AND A191.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A191.StandardTypeID=''S19''
			LEFT JOIN AT0128 A201 WITH (NOLOCK) ON A201.StandardID = CRMT2114.S20ID AND A201.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A201.StandardTypeID=''S20''
		WHERE CRMT2114.DivisionID = '''+@DivisionID+''' '+@Swhere+''

	IF @Mode = 1
	BEGIN
		SET @sSQL1 = @sSQL1+N'
		ORDER BY CRMT2114.DisplayName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

END
ELSE
BEGIN

SET @TotalRow = ' COUNT(*) OVER ()' 

	SET @Swhere = @Swhere + ' AND ( CONVERT(VARCHAR(50),CRMT2114.APKMaster)= '''+@APK+''' OR CONVERT(VARCHAR(50),CRMT2114.APKMaster_9000)= '''+@APKMaster+''')'

	SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (ORDER BY CRMT2114.PhaseOrder, CRMT2114.PhaseID) AS RowNum, '+@TotalRow+' AS TotalRow
			 , CRMT2114.APK
			 , CRMT2114.DivisionID
			 , CRMT2114.APKMaster
			 , CRMT2114.KindSuppliers
			 , AT1015.AnaName as KindSupplierName
			 , CRMT2114.MaterialID as InventoryID
			 , AT1302.InventoryName as MaterialName
			 , CRMT2114.UnitID,AT1304.UnitName
			 , CRMT2114.Quantity
			 , IIF(CRMT2114.UnitPrice = 0, NULL, CRMT2114.UnitPrice) AS UnitPrice
			 , CRMT2114.Amount
			 , MT2120.RoutingID, CRMT2114.PhaseOrder 
			 , CRMT2114.PhaseID, AT0126.PhaseName
			 , CRMT2114.DisplayName, MT93.Description AS DisplayMember
			 , CRMT2114.GluingTypeID, C94.Description AS GluingTypeName
			 , CRMT2114.DisplayName, IIF(CRMT2114.QuantityRunWave = 0, NULL, CRMT2114.QuantityRunWave) AS QuantityRunWave, UnitSizeID, MT99.Description AS UnitSizeName
			 , CRMT2114.PrintTypeID, C91.Description AS PrintTypeName, CRMT2114.RunWavePaper, IIF(CRMT2114.SplitSheets = 0, NULL, CRMT2114.SplitSheets) AS SplitSheets
			 , CRMT2114.RunPaperID, C92.Description AS RunPaperName, CRMT2114.MoldStatusID, C93.Description AS MoldStatusName
			 , IIF(CRMT2114.Size = 0, NULL, CRMT2114.Size) AS Size , IIF(CRMT2114.Cut = 0, NULL, CRMT2114.Cut) AS Cut
			 , IIF(CRMT2114.Child = 0, NULL, CRMT2114.Child) AS Child, CRMT2114.MoldDate, IIF(CRMT2114.AmountLoss = 0, NULL, CRMT2114.AmountLoss) AS AmountLoss
			 , IIF(CRMT2114.PercentLoss = 0, NULL, CRMT2114.PercentLoss) AS PercentLoss
			 , CRMT2114.MoldID, CRMT2114.MoldStatusID, CRMT2114.MoldDate, IIF(CRMT2114.Gsm = 0, NULL, CRMT2114.Gsm) AS Gsm
			 , IIF(CRMT2114.Sheets = 0, NULL, CRMT2114.Sheets) AS Sheets, IIF(CRMT2114.Ram = 0, NULL, CRMT2114.Ram) AS Ram
			 , IIF(CRMT2114.Kg = 0, NULL, CRMT2114.Kg) AS Kg, IIF(CRMT2114.M2 = 0, NULL, CRMT2114.M2) AS M2
			 , CRMT2114.S01ID,CRMT2114.S02ID,CRMT2114.S03ID,CRMT2114.S04ID,CRMT2114.S05ID,CRMT2114.S06ID,CRMT2114.S07ID,CRMT2114.S08ID,CRMT2114.S09ID,CRMT2114.S10ID
			 , CRMT2114.S11ID,CRMT2114.S12ID,CRMT2114.S13ID,CRMT2114.S14ID,CRMT2114.S15ID,CRMT2114.S16ID,CRMT2114.S17ID,CRMT2114.S18ID,CRMT2114.S19ID,CRMT2114.S20ID
			 , A011.StandardName As S01Name,A021.StandardName As S02Name,A031.StandardName As S03Name,A041.StandardName As S04Name,A051.StandardName As S05Name
			 , A061.StandardName As S06Name,A071.StandardName As S07Name,A081.StandardName As S08Name,A091.StandardName As S09Name,A101.StandardName As S10Name
			 , A111.StandardName As S11Name,A121.StandardName As S12Name,A131.StandardName As S13Name,A141.StandardName As S14Name,A151.StandardName As S15Name
			 , A161.StandardName As S16Name,A171.StandardName As S17Name,A181.StandardName As S18Name,A191.StandardName As S19Name,A201.StandardName As S20Name

		FROM CRMT2114 WITH(NOLOCK)
			LEFT JOIN CRMT2110 WITH (NOLOCK) ON CONVERT(VARCHAR(50),CRMT2110.APK) = '''+@APK+'''
			LEFT JOIN MT2120 WITH (NOLOCK) ON MT2120.NodeID = CRMT2110.InventoryID
			LEFT JOIN AT0126 WITH (NOLOCK) ON AT0126.PhaseID = CRMT2114.PhaseID
			LEFT JOIN CRMT0099 C91 WITH (NOLOCK) ON C91.ID = CRMT2114.PrintTypeID AND C91.CodeMaster = ''CRMF2111.PrintType'' AND ISNULL(C91.Disabled, 0)= 0
			LEFT JOIN CRMT0099 C92 WITH (NOLOCK) ON C92.ID = CRMT2114.RunPaperID AND C92.CodeMaster = ''CRMF2111.RunPaper'' AND ISNULL(C92.Disabled, 0)= 0
			LEFT JOIN CRMT0099 C93 WITH (NOLOCK) ON C93.ID = CRMT2114.MoldStatusID AND C93.CodeMaster = ''CRMF2111.Status'' AND ISNULL(C93.Disabled, 0)= 0
			LEFT JOIN CRMT0099 C94 WITH (NOLOCK) ON C94.ID = CRMT2114.GluingTypeID AND C94.CodeMaster = ''GluingType'' AND ISNULL(C94.Disabled, 0)= 0
			LEFT JOIN AT1015 WITH (NOLOCK) ON CRMT2114.KindSuppliers = AT1015.AnaID AND AnaTypeID IN (''I02'',''I03'') AND AT1015.DivisionID IN (''@@@'',CRMT2114.DivisionID)
			'
	SET @sSQL1 = N'	
			LEFT JOIN AT1302 WITH (NOLOCK) ON CRMT2114.MaterialID = AT1302.InventoryID  AND AT1302.DivisionID IN (''@@@'',CRMT2114.DivisionID)
			LEFT JOIN AT1304 WITH (NOLOCK) ON CRMT2114.UnitID = AT1304.UnitID AND AT1304.DivisionID IN (''@@@'',CRMT2114.DivisionID)
			LEFT JOIN MT0099 MT93 WITH (NOLOCK) ON MT93.ID = CRMT2114.DisplayName AND ISNULL(MT93.Disabled, 0)= 0 AND MT93.CodeMaster = ''DisplayName''
			LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = CRMT2114.UnitSizeID AND MT99.CodeMaster = ''UnitSize'' AND ISNULL(MT99.Disabled, 0)= 0
			LEFT JOIN AT0128 A011 WITH (NOLOCK) ON A011.StandardID = CRMT2114.S01ID AND A011.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A011.StandardTypeID=''S01''
			LEFT JOIN AT0128 A021 WITH (NOLOCK) ON A021.StandardID = CRMT2114.S02ID AND A021.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A021.StandardTypeID=''S02''
			LEFT JOIN AT0128 A031 WITH (NOLOCK) ON A031.StandardID = CRMT2114.S03ID AND A031.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A031.StandardTypeID=''S03''
			LEFT JOIN AT0128 A041 WITH (NOLOCK) ON A041.StandardID = CRMT2114.S04ID AND A041.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A041.StandardTypeID=''S04''
			LEFT JOIN AT0128 A051 WITH (NOLOCK) ON A051.StandardID = CRMT2114.S05ID AND A051.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A051.StandardTypeID=''S05''
			LEFT JOIN AT0128 A061 WITH (NOLOCK) ON A061.StandardID = CRMT2114.S06ID AND A061.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A061.StandardTypeID=''S06''
			LEFT JOIN AT0128 A071 WITH (NOLOCK) ON A071.StandardID = CRMT2114.S07ID AND A071.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A071.StandardTypeID=''S07''
			LEFT JOIN AT0128 A081 WITH (NOLOCK) ON A081.StandardID = CRMT2114.S08ID AND A081.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A081.StandardTypeID=''S08''
			LEFT JOIN AT0128 A091 WITH (NOLOCK) ON A091.StandardID = CRMT2114.S09ID AND A091.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A091.StandardTypeID=''S09''
			LEFT JOIN AT0128 A101 WITH (NOLOCK) ON A101.StandardID = CRMT2114.S10ID AND A101.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A101.StandardTypeID=''S10''
			LEFT JOIN AT0128 A111 WITH (NOLOCK) ON A111.StandardID = CRMT2114.S11ID AND A111.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A111.StandardTypeID=''S11''
			LEFT JOIN AT0128 A121 WITH (NOLOCK) ON A121.StandardID = CRMT2114.S12ID AND A121.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A121.StandardTypeID=''S12''
			LEFT JOIN AT0128 A131 WITH (NOLOCK) ON A131.StandardID = CRMT2114.S13ID AND A131.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A131.StandardTypeID=''S13''
			LEFT JOIN AT0128 A141 WITH (NOLOCK) ON A141.StandardID = CRMT2114.S14ID AND A141.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A141.StandardTypeID=''S14''
			LEFT JOIN AT0128 A151 WITH (NOLOCK) ON A151.StandardID = CRMT2114.S15ID AND A151.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A151.StandardTypeID=''S15''
			LEFT JOIN AT0128 A161 WITH (NOLOCK) ON A161.StandardID = CRMT2114.S16ID AND A161.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A161.StandardTypeID=''S16''
			LEFT JOIN AT0128 A171 WITH (NOLOCK) ON A171.StandardID = CRMT2114.S17ID AND A171.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A171.StandardTypeID=''S17''
			LEFT JOIN AT0128 A181 WITH (NOLOCK) ON A181.StandardID = CRMT2114.S18ID AND A181.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A181.StandardTypeID=''S18''
			LEFT JOIN AT0128 A191 WITH (NOLOCK) ON A191.StandardID = CRMT2114.S19ID AND A191.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A191.StandardTypeID=''S19''
			LEFT JOIN AT0128 A201 WITH (NOLOCK) ON A201.StandardID = CRMT2114.S20ID AND A201.DivisionID IN (''@@@'',CRMT2114.DivisionID) AND A201.StandardTypeID=''S20''
		WHERE CRMT2114.DivisionID = '''+@DivisionID+''' '+@Swhere+''

	IF @Mode = 1
	BEGIN
		SET @sSQL1 = @sSQL1+N'
		ORDER BY CRMT2114.PhaseOrder, CRMT2114.PhaseID
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

END

EXEC (@sSQL +@sSQL1 +@sSQL2)
print @sSQL
print @sSQL1
print @sSQL2




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
