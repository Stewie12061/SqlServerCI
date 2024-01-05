IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'PAP10001') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE PAP10001
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form PAP10001 Danh muc từ điển năng lực
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 28/08/2017
-- <Example> EXEC PAP10001 'AS', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE PAP10001 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @AppraisalDictionaryID nvarchar(50),
		  @AppraisalDictionaryName nvarchar(50),
		  @AppraisalGroupID nvarchar(50),
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
	SET @OrderBy = ' M.CreateDate DESC, M.AppraisalDictionaryID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '
		
	IF Isnull(@AppraisalDictionaryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AppraisalDictionaryID, '''') LIKE N''%'+@AppraisalDictionaryID+'%'' '
	IF Isnull(@AppraisalDictionaryName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AppraisalDictionaryName, '''') LIKE N''%'+@AppraisalDictionaryName+'%'' '
	IF Isnull(@AppraisalGroupID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AppraisalGroupID, '''') LIKE N''%'+@AppraisalGroupID+'%'' '
	IF Isnull(@Note, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Note,'''') LIKE N''%'+@Note+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, M.AppraisalDictionaryID, M.AppraisalDictionaryName
					, M.AppraisalGroupID, M.LevelCritical, M.LevelStandardNo, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.LastModifyUserID, M.CreateDate, M.LastModifyDate
					 into #TempPAT10001
			FROM PAT10001 M With (NOLOCK) 
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(AppraisalDictionaryID) From #TempPAT10001

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.AppraisalDictionaryID, M.AppraisalDictionaryName
					, M.AppraisalGroupID, K1.TargetsGroupName as AppraisalGroupName
					, M.Note, M.LevelCritical, M.LevelStandardNo
					, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempPAT10001 M Left join KPIT10101 K1 With (NoLock) on M.AppraisalGroupID = K1.TargetsGroupID
								 

			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)


