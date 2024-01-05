IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2133]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2133]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load dữ liệu màn hình chọn Công đoạn.
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 13/11/2020
-- <Example>

 CREATE PROCEDURE [dbo].[MP2133] 
 (
	 @DivisionID NVARCHAR(250),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(MAX), @OrderBy NVARCHAR(500), @TotalRow NVARCHAR(50)

SET @sWhere = 'M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
SET @OrderBy = 'M.PhaseID, M.PhaseOrder'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND (M.PhaseID LIKE N''%' + @TxtSearch + '%'' 
							 OR M.PhaseName LIKE N''%' + @TxtSearch + '%'' 
							 OR M.PhaseOrder LIKE N''%' + @TxtSearch + '%'')'
IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT M.APK
			 , M.DivisionID
			 , M.PhaseID
			 , M.PhaseName
			 , M.PhaseOrder
			 , M.Disabled
			 , M.IsCommon INTO #TempAT0126
		FROM AT0126 M WITH (NOLOCK)
		WHERE ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(PhaseID) FROM #TempAT0126
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			 , M.APK
			 , M.DivisionID
			 , M.PhaseID
			 , M.PhaseName
			 , M.PhaseOrder
			 , M.Disabled
			 , M.IsCommon 
		FROM #TempAT0126 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
