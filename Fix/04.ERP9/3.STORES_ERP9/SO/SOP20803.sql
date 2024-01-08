IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20803]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20803]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Details NVL Thông tin sản xuất.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đức Tuyên on 25/07/2023
-- <Example>
----    EXEC SOP20803 'MT','2977ed14-c8b7-478f-abf8-ede2ff241a94','b964c015-c496-494b-8cb8-33818d32a7ca','TTSX'
----
CREATE PROCEDURE SOP20803
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
		@sWhere VARCHAR(MAX) ='',
		@TotalRow VARCHAR(50) ='',
		@OrderBy VARCHAR(500) =''
       
IF @PageNumber = 1 SET @TotalRow = ' COUNT(*) OVER ()' 
ELSE SET @TotalRow = 'NULL'

SET @Swhere = '  (CONVERT(VARCHAR(50), S88.APKMaster) = ''' + @APK + ''')'

SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY S88.Orders) AS RowNum, ' + @TotalRow + N' AS TotalRow
				, S88.APK
				, S88.DivisionID
				, S88.APKMaster
				, S88.PhaseID
				, AT26.PhaseName AS PhaseName
				, S88.NodeTypeID
				, MT91.[Description] AS NodeTypeName
				, S88.APKNodeParent
				, S88.TranMonth
				, S88.Tranyear
				, S88.DeleteFlg
				, S88.KindSuppliers
				, S88.MaterialID
				, AT02_1.InventoryName AS MaterialName
				, S88.UnitID
				, AT04.UnitName
				, S88.Quantity
				, S88.UnitPrice
				, S88.Amount
				, S88.PhaseOrder
				, S88.DisplayName
				, MT92.[Description]		AS DisplayMember
				, S88.QuantityRunWave
				, S88.UnitSizeID
				, S88.Size
				, S88.Cut
				, S88.Child
				, S88.PrintTypeID
				, S88.RunPaperID
				, S88.RunWavePaper
				, S88.SplitSheets
				, S88.MoldID
				, S88.MoldStatusID
				, CASE WHEN S88.MoldStatusID = ''1'' THEN N''Mới''
						WHEN S88.MoldStatusID = ''0'' THEN N''Cũ'' 
						ELSE '''' END AS MoldStatusName
				, S88.MoldDate
				, S88.Gsm
				, S88.Sheets
				, S88.Ram
				, S88.Kg
				, S88.M2
				, S88.AmountLoss
				, S88.PercentLoss
				, S88.APKMaster_9000
				, S88.ApproveLevel
				, S88.ApprovingLevel
				, S88.Status
				, S88.S01ID
				, S88.S02ID
				, S88.S03ID
				, S88.S04ID
				, S88.S05ID
				, S88.S06ID
				, S88.S07ID
				, S88.S08ID
				, S88.S09ID
				, S88.S10ID
				, S88.S11ID
				, S88.S12ID
				, S88.S13ID
				, S88.S14ID
				, S88.S15ID
				, S88.S16ID
				, S88.S17ID
				, S88.S18ID
				, S88.S19ID
				, S88.S20ID
				, S88.GluingTypeID
				, CT91.Description			AS GluingTypeName
				, S88.KindOfSuppliersID
				, S88.InventoryID
				, S88.InventoryName
				, S88.APK_SOT2081
				, S88.ProductID
				, S88.SemiProduct
		FROM SOT2082 S88
		INNER JOIN SOT2080 S80 WITH (NOLOCK) ON S80.DivisionID = S88.DivisionID
													AND S80.APK = S88.APKMaster
		LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', ''' + @DivisionID +  ''')
													AND AT02.InventoryID = S88.SemiProduct
		LEFT JOIN AT1302 AT02_1 WITH (NOLOCK) ON AT02_1.InventoryID = S88.MaterialID AND AT02_1.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
		LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = ''Status''
													AND ISNULL(OT91.[Disabled], 0) = 0
													AND OT91.ID1 = ''0''
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster =''StuctureType''
													AND ISNULL(MT91.[Disabled], 0) = 0
													AND MT91.ID = S88.NodeTypeID
		LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON ISNULL(AT26.[Disabled], 0) = 0
													AND AT26.PhaseID = S88.PhaseID
		LEFT JOIN CRMT0099 CT91 WITH (NOLOCK) ON CT91.ID = S88.GluingTypeID 
													AND CT91.CodeMaster = ''GluingType'' 
													AND ISNULL(CT91.Disabled, 0)= 0
		LEFT JOIN MT0099 MT92 WITH (NOLOCK) ON MT92.ID = S88.DisplayName
													AND MT92.CodeMaster = ''DisplayName''
													AND ISNULL(MT92.Disabled, 0) = 0
		LEFT JOIN AT1304 AT04 WITH (NOLOCK) ON S88.UnitID = AT04.UnitID AND AT04.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
		WHERE '
		+ @Swhere
		+ '
		ORDER BY S88.Orders
		 '

IF @Mode = 1
BEGIN
	SET @sSQL2 = @sSQL2 + N'	
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
