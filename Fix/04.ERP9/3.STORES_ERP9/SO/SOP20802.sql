IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20802]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20802]
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
----Updated by: Đức Tuyên on: 25/07/2023: Xử lý nghiệp vụ thông tin sản xuất - bỏ InheritAPKMaster, InheritAPKDetail (MAITHU)
----Updated by: Viết Toàn on: 04/08/2023: Lấy phương pháp in theo CRMT2111.PrintTypeID
----Updated by: Viết Toàn on: 31/08/2023: Lấy thông tin duyệt theo phiếu (bỏ mặc định là chờ duyệt)
-- <Example>
----    EXEC SOP20802 'MT','2977ed14-c8b7-478f-abf8-ede2ff241a94','b964c015-c496-494b-8cb8-33818d32a7ca','TTSX'
----
CREATE PROCEDURE SOP20802
( 
	@DivisionID nvarchar(50),
	@APK nvarchar(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@IsView INT = 1
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
			, S88.DivisionID
			, S88.Orders
			, S80.InventoryID					AS ProductID
			, S88.SemiProduct
			, S88.PaperTypeID
			, MT92.[Description]				AS PaperTypeName
			, AT02.InventoryName				AS SemiProductName
			, S80.APKInherit					AS SOrderID
			, S88.APKMInherited
			, S88.APKDInherited
			, S88.[Length]
			, S88.[Width]
			, S88.[Height]
			, S88.PrintNumber		
			, S88.SideColor1
			, CASE WHEN ' + CAST(@IsView AS VARCHAR(1)) + ' = 1 
						THEN (SELECT STUFF(
					   (SELECT '','' + A.InventoryName
							FROM (
								SELECT InventoryName FROM AT1302
								WHERE InventoryID IN (SELECT [Name] FROM SplitString(S88.ColorPrint01	, '',''))
							) AS A
        
							FOR XML PATH('''')), 1, 1, ''''
						))
					ELSE S88.ColorPrint01 END AS ColorPrint01	
			, S88.SideColor2		
			, CASE WHEN ' + CAST(@IsView AS VARCHAR(1)) + ' = 1 
						THEN (SELECT STUFF(
					   (SELECT '','' + A.InventoryName
							FROM (
								SELECT InventoryName FROM AT1302
								WHERE InventoryID IN (SELECT [Name] FROM SplitString(S88.ColorPrint02	, '',''))
							) AS A
        
							FOR XML PATH('''')), 1, 1, ''''
						))
					ELSE S88.ColorPrint02 END AS ColorPrint02	
			, S88.ActualQuantity
			, S88.OffsetQuantity		
			, S88.FilmDate			
			, S88.FilmStatus
			, (CASE WHEN S88.FilmStatus IS NULL THEN NULL
					WHEN ISNULL(S88.FilmStatus, 0) = 0 THEN N''Cũ''
					ELSE N''Mới''
					END) AS FilmStatusName
			, S88.PrintTypeID		
			, C2.[Description]					AS PrintTypeName
			, S88.AmountLoss
			, S88.PercentLoss	
			, S88.Notes				
			, S88.TotalVariableFee	
			, S88.PercentCost		
			, S88.Cost				
			, S88.PercentProfit		
			, S88.Profit			
			, S88.InvenUnitPrice	
			, S88.SquareMetersPrice	
			, S88.ExchangeRate		
			, S88.CurrencyID		
			, S88.[FileName]		
			, S88.ContentSampleDate	
			, S88.ColorSampleDate	
			, S88.MTSignedSampleDate
			, S88.FileLength		
			, S88.FileWidth			
			, S88.FileSum			
			, S88.[Include]			
			, S88.FileUnitID		
			, OT93.[Description]				AS FileUnitName
			, S88.ApproveCutRollStatusID		AS ApproveCutRollStatusID
			, OT91.[Description]				AS ApproveCutRollStatusName
			, S88.ApproveWaveStatusID			AS ApproveWaveStatusID
			, OT92.[Description]				AS ApproveWaveStatusName
			--- Du toan
			, S80.InheritAPKMaster				AS VoucherID
			, MT10.VoucherNo					AS VoucherNo
			, MT22.Version						AS BOMVersion
		FROM SOT2081 S88
		INNER JOIN SOT2080 S80 WITH (NOLOCK) ON S80.DivisionID = S88.DivisionID AND S80.APK = S88.APKMaster
		LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', ''' + @DivisionID +  ''') AND AT02.InventoryID = S88.SemiProduct
		LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = ''Status'' AND ISNULL(OT91.[Disabled], 0) = 0 AND OT91.ID1 = S88.ApproveCutRollStatusID
		LEFT JOIN OOT0099 OT92 WITH (NOLOCK) ON OT92.CodeMaster = ''Status'' AND ISNULL(OT92.[Disabled], 0) = 0 AND OT92.ID1 = S88.ApproveWaveStatusID
		LEFT JOIN OOT0099 OT93 WITH (NOLOCK) ON OT93.CodeMaster = ''Status'' AND ISNULL(OT93.[Disabled], 0) = 0 AND OT93.ID1 = S88.FileUnitID
		LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = ''CRMF2111.PrintTypeID'' AND ISNULL(C2.[Disabled], 0) = 0 AND C2.ID = S88.PrintTypeID
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster = ''UnitSize'' AND ISNULL(MT91.[Disabled], 0) = 0 AND MT91.ID = S88.FileUnitID
		LEFT JOIN CRMT0099 MT92 WITH (NOLOCK) ON MT92.CodeMaster = ''CRMT00000022'' AND ISNULL(MT92.[Disabled], 0) = 0 AND MT92.ID = S88.PaperTypeID
		LEFT JOIN CRMT2110 MT10 WITH (NOLOCK) ON MT10.DivisionID = S88.DivisionID AND MT10.APK = S80.InheritAPKMaster
		OUTER APPLY
		(
			SELECT TOP 1 MT22.Version
			FROM MT2123 MT23 WITH (NOLOCK)
			INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = MT23.DivisionID AND MT22.APK = MT23.APK_2120
			WHERE MT23.DivisionID = S88.DivisionID AND MT23.APK = S88.APKDInherited
		) MT22
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
