IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2193]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2193]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn Milestone
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 02/01/2019
-- <Example>
/*
	EXEC OOP2193 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2193] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ProjectID NVARCHAR(250),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.CreateDate, M.MilestoneID'

IF ISNULL(@ProjectID, '') != ''
	SET @sWhere = @sWhere + ' AND M.ProjectID LIKE N''%'+@ProjectID+'%''  '


IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.MilestoneID LIKE N''%' + @TxtSearch + '%'' 
				OR M.MilestoneName LIKE N''%' + @TxtSearch + '%'' 
				OR O1.Description LIKE N''%' + @TxtSearch + '%''  
				OR O2.StatusName LIKE N''%' + @TxtSearch + '%''
				OR O3.ProjectName LIKE N''%' + @TxtSearch + '%''
				OR M.TimeRequest LIKE N''%' + @TxtSearch + '%'' 
				OR M.DeadlineRequest LIKE N''%' + @TxtSearch + '%'')'


SET @sSQL = '
		SELECT M.APK, M.DivisionID
			, M.MilestoneID
			, M.MilestoneName
			, M.StatusID
			, O2.StatusName AS StatusName
			, O1.Description AS TypeOfMilestone
			, M.TimeRequest
			, M.DeadlineRequest
			, M.ProjectID
			, O3.ProjectName AS ProjectName
			, M.CreateDate
		INTO #TemOOT2190
		FROM OOT2190 M WITH (NOLOCK)
			LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = M.TypeOfMilestone AND O1.CodeMaster = ''OOF2210.TypeOfRelease''
			LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON M.StatusID = O2.StatusID
			LEFT JOIN OOT2100 O3 WITH (NOLOCK) ON O3.ProjectID = M.ProjectID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2190 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID
			, M.MilestoneID
			, M.MilestoneName
			, M.StatusID
			, M.StatusName
			, M.TypeOfMilestone
			, M.TimeRequest
			, M.DeadlineRequest
			, M.ProjectName
			, M.CreateDate
		FROM #TemOOT2190 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
