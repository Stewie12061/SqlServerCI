IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2115]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2115]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid: màn hình kế thừa dự trù chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Đình Hòa on 26/04/2021
-- <Example>
---- 
/*-- <Example>
	CRMP2115 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @EstimateID = 'sfasdf'
	CRMP2115 @DivisionID, @UserID, @PageNumber, @PageSize, @MOrderID

----*/

CREATE PROCEDURE CRMP2115
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @APK VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'', 
		@CodeNew NVARCHAR(100) = N'Mới',
		@CodeOld NVARCHAR(100) = N'Cũ'


SET @OrderBy = 'D1.APK'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF (ISNULL(@APK, '') <> '')
BEGIN
	SET @sWhere = @sWhere + '  AND D1.APKMaster =  '''+ @APK +  ''''
END

SET @sSQL = @sSQL + N'
SELECT DISTINCT D1.APK, D1.PhaseID, D2.PhaseName, D1.DisplayName ,D3.Description AS DisplayMember, D1.KindSuppliers, D4.AnaName, D1.MaterialID, D5.InventoryName AS MaterialName, D1.Size, D1.Cut, D1.Child
, D1.UnitSizeID, D6.Description AS UnitSizeName, D1.PrintTypeID, D7.Description AS PrintTypeName, D1.RunPaperID, D8.Description AS RunPaperName, D1.RunWavePaper, D1.MoldID, D1.MoldStatusID 
, CASE WHEN D1.MoldStatusID = ''0'' THEN N''' +@CodeOld + ''' WHEN D1.MoldStatusID = ''1'' THEN N''' +@CodeNew + ''' ELSE N'''' END MoldStatusName, D1.MoldDate
INTO #CRMT2104
FROM CRMT2104 D1 WITH(NOLOCK) 
LEFT JOIN MT2131 D2 WITH(NOLOCK) ON D1.PhaseID = D2.PhaseID
LEFT JOIN MT0099 D3 WITH(NOLOCK) ON D1.DisplayName = D3.ID AND D3.CodeMaster = ''DisplayName''
LEFT JOIN AT1015 D4 WITH(NOLOCK) ON D1.KindSuppliers = D4.AnaID
LEFT JOIN AT1302 D5 WITH(NOLOCK) ON D1.MaterialID = D5.InventoryID
LEFT JOIN MT0099 D6 WITH(NOLOCK) ON D1.UnitSizeID = D6.ID AND D6.CodeMaster = ''UnitSize''
LEFT JOIN CRMT0099 D7 WITH(NOLOCK) ON D1.PrintTypeID = D7.ID AND D7.CodeMaster = ''CRMF2111.PrintType''
LEFT JOIN CRMT0099 D8 WITH(NOLOCK) ON D1.PrintTypeID = D8.ID AND D8.CodeMaster = ''CRMF2111.RunPaper''
WHERE D1.DivisionID = '''+@DivisionID+''' '
 +@sWhere +'
'
SET @sSQL1 = @sSQL1 + ' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #CRMT2104 D1
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

print @sSQL 
print @sSQL1
EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
