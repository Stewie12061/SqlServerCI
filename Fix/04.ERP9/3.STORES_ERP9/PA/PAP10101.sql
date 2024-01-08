IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'PAP10101') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE PAP10101
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form PAP10101 Danh muc năng lực - PAF1010
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 28/08/2017
----Edited by: hoàng vũ, Date: 06/10/2017 Chỉnh sửa năng lực từ bảng master thành master-Detail, quản lý theo kỳ
-- <Example> EXEC PAP10101 'AS', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE PAP10101 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @DepartmentID nvarchar(50),
		  @EvaluationPhaseID nvarchar(50),
		  @AppraisalGroupID nvarchar(50),
		  @AppraisalID nvarchar(50),
		  @AppraisalName nvarchar(50),
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
		
	SET @sWhere = ' 1 = 1 '
	SET @OrderBy = ' M.CreateDate DESC, M.AppraisalID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND D.DivisionID IN ('''+@DivisionIDList+''', ''@@@'') '
		
	IF Isnull(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D.DepartmentID,'''') LIKE N''%'+@DepartmentID+'%''  '

	IF Isnull(@EvaluationPhaseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D.EvaluationPhaseID,'''') LIKE N''%'+@EvaluationPhaseID+'%''  '

	IF Isnull(@AppraisalGroupID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D.AppraisalGroupID, '''') LIKE N''%'+@AppraisalGroupID+'%'' '

	IF Isnull(@AppraisalID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AppraisalID, '''') LIKE N''%'+@AppraisalID+'%'' '
	
	IF Isnull(@AppraisalName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AppraisalName, '''') LIKE N''%'+@AppraisalName+'%'' '
	
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' 
			SELECT Distinct M.APK, M.AppraisalID, M.AppraisalName, M.Note, M.IsCommon, M.Disabled, M.OrderNo
					, M.CreateUserID, M.LastModifyUserID, M.CreateDate, M.LastModifyDate
					 into #TempPAT10101
			FROM PAT10101 M With (NOLOCK) Left join PAT10103 D With (NOLOCK) on M.APK = D.APKMaster
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(AppraisalID) From #TempPAT10101 With (NOLOCK)

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, M.AppraisalID, M.AppraisalName, M.Note, M.IsCommon, M.Disabled, M.OrderNo
					, M.CreateUserID, M.LastModifyUserID, M.CreateDate, M.LastModifyDate
			FROM #TempPAT10101 M With (NOLOCK)
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)


