IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2106]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2106]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn dự án
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 27/06/2019
-- <Example>
/*
	EXEC OOP2106 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2106] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.ProjectID'

IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.ProjectID LIKE N''%' + @TxtSearch + '%'' 
				OR M.ProjectType LIKE N''%' + @TxtSearch + '%'' 
				OR M.ProjectName LIKE N''%' + @TxtSearch + '%'' 
				OR M.ProjectSampleID LIKE N''%' + @TxtSearch + '%'' 
				OR M.StartDate LIKE N''%' + @TxtSearch + '%''
				OR M.ProjectDescription LIKE N''%' + @TxtSearch + '%'' )'

IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT M.APK, M.DivisionID
			, M.ProjectID
			, M.ProjectName
			, M.StartDate
			, M.EndDate	
			, M.ProjectType
		INTO #TemOOT2100
		FROM OOT2100 M WITH (NOLOCK)
		WHERE ' + @sWhere + ' AND M.DivisionID = ''' + @DivisionID + ''' 
			
		DECLARE @count INT
		SELECT @count = COUNT(ProjectID) FROM #TemOOT2100 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID
			, M.ProjectID 
			, M.ProjectName
			, M.StartDate
			, M.EndDate
			, M.ProjectType
		FROM #TemOOT2100 M
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
