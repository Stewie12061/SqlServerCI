IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1063]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn mẫu công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 13/11/2019
-- Modified by: Hoài Bảo Date 30/03/2022 - Bổ sung load Description cho mẫu công việc 
-- <Example>
/*
	EXEC OOP1063 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP1063] (
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

SET @sWhere = 'O1.CodeMaster = ''OOF1060.TaskType'' AND ISNULL(M.Disabled, 0) = 0'
SET @OrderBy = 'M.CreateDate'

IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + 'AND (M.TaskSampleID LIKE N''%' + @TxtSearch + '%'' 
							 OR M.TaskSampleName LIKE N''%' + @TxtSearch + '%''
							 OR M.ExecutionTime LIKE N''%' + @TxtSearch + '%''
							 OR O1.Description LIKE N''%' + @TxtSearch + '%'')'

IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT M.APK, M.DivisionID
			 , M.TaskSampleID
			 , M.TaskSampleName
			 , M.ExecutionTime
			 , M.PriorityID
			 , M.TaskTypeID
			 , M.TargetTypeID			 
			 , O1.[Description] AS TaskTypeName
			 , M.[Description]
			 , M.CreateDate 
		INTO #TemOOT1063
		FROM OOT1060 M WITH (NOLOCK)
			INNER JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = M.TaskTypeID
		WHERE ' + @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''',''@@@'')
			
		DECLARE @count INT
		SELECT @count = COUNT(TaskSampleID) FROM #TemOOT1063 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID
			, M.TaskSampleID
			, M.TaskSampleName	
			, M.ExecutionTime
			, M.TaskTypeName
			, M.Description 
			, M.PriorityID
			, M.TaskTypeID
			, M.TargetTypeID
			, M.CreateDate 
		FROM #TemOOT1063 M
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
