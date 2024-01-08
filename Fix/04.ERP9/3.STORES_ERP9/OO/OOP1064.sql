IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Export excel danh mục Mẫu công việc (OOF1060)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 27/03/2020 by Đình Ly
-- <Example> 
CREATE PROCEDURE OOP1064
 ( 
    @DivisionID VARCHAR(50),  
	@DivisionIDList NVARCHAR(2000), 
    @TaskSampleID NVARCHAR(50),
    @TaskSampleName NVARCHAR(250),
	@TaskTypeID NVARCHAR(250),
	@PriorityID NVARCHAR(250),
	@ExecutionTime NVARCHAR(250),
	@IsCommon NVARCHAR(100),
	@Disabled NVARCHAR(100),
	@UserID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @TotalRow = ''
	SET @OrderBy = 'M.TaskSampleID'

	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
	Else 
		SET @sWhere = ' M.DivisionID = '''+ @DivisionID + ''' '
		
	IF ISNULL(@TaskSampleID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TaskSampleID, '''') LIKE N''%' + @TaskSampleID + '%'' '

	IF ISNULL(@TaskSampleName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TaskSampleName, '''') LIKE N''%' + @TaskSampleName + '%''  '

	IF ISNULL(@TaskTypeID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.TaskTypeID, '''') LIKE N''%' + @TaskTypeID + '%'' '

	IF ISNULL(@PriorityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.PriorityID, '''') = ' + @PriorityID

	IF ISNULL(@ExecutionTime, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ExecutionTime, 0) = ' + @ExecutionTime

	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') LIKE N''%'+ @IsCommon + '%'' '

	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') LIKE N''%'+ @Disabled + '%'' '

SET @sSQL = 'SELECT M.APK
				  , M.DivisionID
				  , M.TaskSampleID
				  , M.TaskSampleName
				  , M.RelatedToTypeID
				  , ISNULL(C01.Description, M.PriorityID) AS PriorityID
				  , ISNULL(C02.Description, M.TaskTypeID) AS TaskTypeID
				  , M.ExecutionTime, K.TargetsName AS TargetTypeID
				  , M.IsCommon
				  , M.Disabled
				  , M.CreateUserID
				  , M.CreateDate
				  , M.LastModifyUserID
				  , M.LastModifyDate
			INTO #OOT1060
			FROM OOT1060 M WITH (NOLOCK)
				LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = M.PriorityID AND C01.CodeMaster = ''CRMT00000006''
				LEFT JOIN OOT0099 C02 WITH (NOLOCK) ON C02.ID = M.TaskTypeID AND C02.CodeMaster = ''OOF1060.TaskType''
				LEFT JOIN KPIT10501 K WITH (NOLOCK) ON M.TargetTypeID = K.TargetsID
			WHERE ' + @sWhere + '

			SELECT M.APK
				 , M.DivisionID
				 , M.TaskSampleID
				 , M.TaskSampleName
				 , M.RelatedToTypeID
				 , M.PriorityID
				 , M.ExecutionTime
				 , M.TaskTypeID
				 , M.IsCommon
				 , M.Disabled
				 , M.CreateUserID
				 , M.CreateDate
				 , M.LastModifyUserID
				 , M.LastModifyDate
				 , M.TargetTypeID
			FROM #OOT1060 M WITH (NOLOCK)
			ORDER BY '+@OrderBy+''
EXEC (@sSQL)
--PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
