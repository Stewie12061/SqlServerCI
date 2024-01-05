IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'PAP10201') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE PAP10201
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form PAP10201 Danh muc thiết lập bảng đánh giá năng lực từng vị tri
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 31/08/2017
-- <Example> EXEC PAP10201 'AS', '', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE PAP10201 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @DepartmentID nvarchar(50),
		  @EvaluationPhaseID nvarchar(50),
		  @EvaluationKitID nvarchar(50),
		  @EvaluationKitName nvarchar(50),
		  @DutyID nvarchar(50),
		  @TitleID nvarchar(50),
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
	SET @OrderBy = ' M.CreateDate DESC, M.EvaluationKitID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '
	
	IF Isnull(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DepartmentID,'''') LIKE N''%'+@DepartmentID+'%'''

	IF Isnull(@EvaluationPhaseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationPhaseID,'''') LIKE N''%'+@EvaluationPhaseID+'%'''

	IF Isnull(@EvaluationKitID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationKitID, '''') LIKE N''%'+@EvaluationKitID+'%'' '
	
	IF Isnull(@EvaluationKitName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationKitName, '''') LIKE N''%'+@EvaluationKitName+'%'' '
	
	IF Isnull(@DutyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DutyID, '''') LIKE N''%'+@DutyID+'%'' '
	
	IF Isnull(@TitleID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TitleID, '''') LIKE N''%'+@TitleID+'%'''

	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'''
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'''

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, M.EvaluationKitID, M.EvaluationKitName
					, M.EvaluationPhaseID
					, M.DepartmentID, M.DutyID, M.TitleID, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					into #TempPAT10201
			FROM PAT10201 M With (NOLOCK) 
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(EvaluationKitID) From #TempPAT10201 With (NOLOCK) 

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.EvaluationKitID, M.EvaluationKitName
					, M.EvaluationPhaseID, K1.EvaluationPhaseName
					, M.DepartmentID, D1.DepartmentName, M.DutyID, D2.DutyName
					, M.TitleID, D6.TitleName
					, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempPAT10201 M With (NOLOCK) Left join AT1102 D1 With (NOLOCK) on M.DepartmentID = D1.DepartmentID
								  Left join HT1102 D2 With (NOLOCK) on M.DutyID = D2.DutyID
								  Left join HT1106 D6 With (NOLOCK) on M.TitleID = D6.TitleID
								  Left join KPIT10601 K1 With (NOLOCK) on M.EvaluationPhaseID = K1.EvaluationPhaseID
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)


