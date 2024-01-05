IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Store load dữ liệu cho Danh mục Mẫu công việc (OOF1060)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 27/12/2018 by Vĩnh Tâm
-- <Example> 
CREATE PROCEDURE [dbo].[OOP1060] ( 
  @DivisionID VARCHAR(50),			-- Biến môi trường
  @DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
  @TaskSampleID NVARCHAR(50),
  @TaskSampleName NVARCHAR(50),
  @PriorityID NVARCHAR(10),
  @ExecutionTime NVARCHAR(10),
  @TaskTypeID NVARCHAR(50),
  @Disabled NVARCHAR(10),
  @IsCommon NVARCHAR(10),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
		
SET @TotalRow = ''
SET @OrderBy = ' M.DivisionID, M.TaskSampleID'

-- Check Para DivisionIDList NULL then get DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@TaskSampleID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.TaskSampleID, '''') LIKE N''%' + @TaskSampleID + '%'' '
IF ISNULL(@TaskSampleName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.TaskSampleName, '''') LIKE N''%' + @TaskSampleName + '%'' '
IF ISNULL(@PriorityID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.PriorityID, '''') = ' + @PriorityID
IF ISNULL(@ExecutionTime, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.ExecutionTime, 0) = ' + @ExecutionTime
IF ISNULL(@TaskTypeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.TaskTypeID, '''') = ''' + @TaskTypeID + ''''
IF ISNULL(@Disabled, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled
IF ISNULL(@IsCommon, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon

SET @sSQL = 'SELECT   M.APK, M.DivisionID, M.TaskSampleID, M.TaskSampleName, M.RelatedToTypeID
					, ISNULL(C01.Description, M.PriorityID) AS PriorityID
					, ISNULL(C02.Description, M.TaskTypeID) AS TaskTypeID
					, M.ExecutionTime, K.TargetsName AS TargetTypeID
					, M.Disabled, M.IsCommon, M.CreateDate, M.LastModifyDate
					, ISNULL(C05.Description, M.TaskBlockTypeID) AS TaskBlockTypeID
			INTO #OOT1060
			FROM OOT1060 M WITH (NOLOCK)
				LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = M.PriorityID AND C01.CodeMaster = ''CRMT00000006''
				LEFT JOIN OOT0099 C02 WITH (NOLOCK) ON C02.ID = M.TaskTypeID AND C02.CodeMaster = ''OOF1060.TaskType''
				LEFT JOIN KPIT10501 K WITH (NOLOCK) ON M.TargetTypeID = K.TargetsID
				LEFT JOIN OOT0099 C05 WITH (NOLOCK) ON C05.ID = M.TaskBlockTypeID AND C05.CodeMaster = ''OOF1060.TASKTYPEBLOCK''
			WHERE ' + @sWhere + '

			DECLARE @Count INT
			SELECT @Count = COUNT(TaskSampleID)
			FROM #OOT1060

			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
					, M.APK, M.DivisionID, M.TaskSampleID, M.TaskSampleName, M.RelatedToTypeID
					, M.PriorityID, M.ExecutionTime, M.TaskTypeID, M.Disabled, M.IsCommon
					, M.CreateDate, M.LastModifyDate, M.TargetTypeID, M.TaskBlockTypeID
			FROM #OOT1060 M WITH (NOLOCK)
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQL)
--PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
