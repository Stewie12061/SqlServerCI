IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP10201') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP10201
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIP10201 Danh muc từ điển chỉ tiêu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 11/08/2017
-- <Example> EXEC KPIP10201 'AS', '', '', '', '', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP10201 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @TargetsDictionaryID nvarchar(50),
		  @TargetsDictionaryName nvarchar(50),
		  @TargetsGroupID nvarchar(50),
		  @UnitKpiID nvarchar(50),
		  @ClassificationID nvarchar(50),
		  @FrequencyID nvarchar(50),
		  @SourceID nvarchar(50),
		  @Categorize nvarchar(50),
		  @Note nvarchar(250),
		  @IsCommon nvarchar(100),
		  @Disabled nvarchar(100),
		  @UserID  VARCHAR(50),
		  @PageNumber INT,
		  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateDate DESC, M.TargetsDictionaryID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '
		
	IF Isnull(@TargetsDictionaryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsDictionaryID, '''') LIKE N''%'+@TargetsDictionaryID+'%'' '
	IF Isnull(@TargetsDictionaryName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsDictionaryName, '''') LIKE N''%'+@TargetsDictionaryName+'%'' '
	IF Isnull(@TargetsGroupID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsGroupID, '''') LIKE N''%'+@TargetsGroupID+'%'' '
	IF Isnull(@UnitKpiID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.UnitKpiID, '''') LIKE N''%'+@UnitKpiID+'%'' '
	IF Isnull(@ClassificationID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ClassificationID, '''') LIKE N''%'+@ClassificationID+'%'' '
	IF Isnull(@FrequencyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FrequencyID, '''') LIKE N''%'+@FrequencyID+'%'' '
	IF Isnull(@SourceID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SourceID, '''') LIKE N''%'+@SourceID+'%'' '
	IF Isnull(@Categorize, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Categorize, '''') LIKE N''%'+@Categorize+'%'' '
	IF Isnull(@Note, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Note,'''') LIKE N''%'+@Note+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, M.ClassificationID, M.TargetsDictionaryID, M.TargetsDictionaryName
					, M.TargetsGroupID, M.UnitKpiID, M.FormulaName, M.FrequencyID, M.SourceID, M.Note
					, M.Categorize, M.Percentage, M.Revenue, M.GoalLimit, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					 into #TempKPIT10201
			FROM KPIT10201 M With (NOLOCK) 
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(TargetsDictionaryID) From #TempKPIT10201

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.ClassificationID, A993.Description as ClassificationName, M.TargetsDictionaryID, M.TargetsDictionaryName
					, M.TargetsGroupID, K1.TargetsGroupName
					, M.UnitKpiID, M.FormulaName
					, M.FrequencyID, A992.Description as FrequencyName
					, M.SourceID, K3.SourceName, M.Note
					, M.Categorize, A991.Description as CategorizeName, M.Percentage, M.Revenue, M.GoalLimit, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT10201 M Left join AT0099 A991 With (NoLock) on M.Categorize = A991.ID and A991.CodeMaster =''AT00000041''
								  Left join AT0099 A992 With (NoLock) on M.FrequencyID = A992.ID and A992.CodeMaster =''AT00000042''
								  Left join AT0099 A993 With (NoLock) on M.ClassificationID = A993.ID and A993.CodeMaster =''AT00000043''
								  Left join KPIT10101 K1 With (NoLock) on M.TargetsGroupID = K1.TargetsGroupID
								  Left join KPIT10301 K3 With (NoLock) on M.SourceID = K3.SourceID

			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)


