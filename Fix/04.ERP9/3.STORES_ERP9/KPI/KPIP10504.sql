IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10504]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP10504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Export excel danh mục chỉ tiêu KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
---- Create on 28/03/2020 by Đình Ly
---- Modified on 23/04/2020 by Đình Ly
---- Bổ sung dữ liệu detail danh mục chỉ tiêu KPI khi Export excel
-- <Example> 


CREATE PROCEDURE KPIP10504
 ( 
    @DivisionID VARCHAR(50),  
	@DivisionIDList NVARCHAR(2000), 
    @DepartmentID nvarchar(50),
	@TargetsID nvarchar(50),
	@TargetsName nvarchar(50),
	@EvaluationPhaseID nvarchar(50),
	@TargetsGroupID nvarchar(50),
	@UnitKpiName nvarchar(50),
	@FrequencyName nvarchar(50),
	@SourceName nvarchar(50),
	@Categorize nvarchar(50),
	@IsCommon nvarchar(100),
	@Disabled nvarchar(100),
	@UserID  VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
		
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'K.TaskSampleID'
		
	SET @sWhere = ' 1 = 1 '
	SET @OrderBy = ' K.CreateDate DESC, K.TargetsID '

	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND K5.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
	
	IF ISNULL(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K5.DepartmentID, '''') LIKE N''%' + @DepartmentID + '%'' '

	IF ISNULL(@TargetsID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.TargetsID, '''') LIKE N''%' + @TargetsID + '%'' '
	
	IF ISNULL(@TargetsName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.TargetsName, '''') LIKE N''%' + @TargetsName + '%'' '
	
	IF ISNULL(@EvaluationPhaseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K5.EvaluationPhaseID, '''') LIKE N''%' + @EvaluationPhaseID + '%'' '

	IF ISNULL(@TargetsGroupID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K5.TargetsGroupID, '''') LIKE N''%' + @TargetsGroupID + '%'' '
	
	IF ISNULL(@UnitKpiName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.UnitKpiID, '''') LIKE N''%' + @UnitKpiName + '%'' '
	
	IF ISNULL(@FrequencyName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.FrequencyID, '''') LIKE N''%' + @FrequencyName + '%'' '
	
	IF ISNULL(@SourceName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.SourceID, '''') LIKE N''%' + @SourceName + '%'' '
	
	IF ISNULL(@Categorize, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.Categorize, '''') LIKE N''%' + @Categorize + '%'' '
	
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.IsCommon,'''') LIKE N''%' + @IsCommon + '%'' '
	
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.Disabled,'''') LIKE N''%' + @Disabled + '%'' '

SET @sSQL = 'SELECT Distinct K.APK
				, K.TargetsID
				, K.TargetsName
				, K.UnitKpiID
				, K3.UnitKpiName
				, K.FrequencyID
				, K2.Description as FrequencyName
				, K.SourceID
				, K4.SourceName
				, K.OrderNo
				, K.Categorize
				, K1.Description AS CategorizeName
				, K.FormulaName
				, K.Note
				, K.IsCommon
				, K.Disabled
				, K.CreateUserID
				, K.CreateDate
				, K.LastModifyUserID
				, K.LastModifyDate
				, ISNULL(A1.DivisionName,'''') AS DivisionID
				, A2.DepartmentName AS DepartmentID
				, A3.TargetsGroupName AS TargetsGroupID
				, K5.Percentage, K5.Revenue, K5.GoalLimit
			INTO #TempKPIT10501
			FROM KPIT10501 K WITH (NOLOCK)
				LEFT JOIN AT0099 K1 WITH (NOLOCK) ON K.Categorize = K1.ID AND K1.CodeMaster =''AT00000041''
				LEFT JOIN AT0099 K2 WITH (NOLOCK) ON K.FrequencyID = K2.ID AND K2.CodeMaster =''AT00000042''
				LEFT JOIN KPIT10401 K3 WITH (NOLOCK) ON K.UnitKpiID = K3.UnitKpiID 
				LEFT JOIN KPIT10301 K4 WITH (NOLOCK) ON K.SourceID = K4.SourceID 
				LEFT JOIN KPIT10502 K5 WITH (NOLOCK) ON K5.APKMaster = K.APK
				LEFT JOIN AT1101 A1 WITH (NOLOCK) ON A1.DivisionID = K5.DivisionID
				LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = K5.DepartmentID
				LEFT JOIN KPIT10101 A3 WITH (NOLOCK) on A3.TargetsGroupID = K5.TargetsGroupID
			WHERE '+@sWhere+'

			SELECT K.APK
				, K.TargetsID
				, K.TargetsName
				, K.UnitKpiID
				, K.UnitKpiName
				, K.FrequencyID
				, K.FrequencyName
				, K.SourceID
				, K.SourceName
				, K.OrderNo
				, K.Categorize
				, K.CategorizeName
				, K.FormulaName
				, K.Note
				, K.IsCommon
				, K.Disabled
				, K.CreateUserID
				, K.CreateDate
				, K.LastModifyUserID
				, K.LastModifyDate
				, K.DivisionID
				, K.DepartmentID
				, K.TargetsGroupID
				, K.Percentage
				, K.Revenue
				, K.GoalLimit
			FROM #TempKPIT10501 K WITH (NOLOCK) 
			ORDER BY '+@OrderBy+''
EXEC (@sSQL)
PRINT(@sSQL)












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
