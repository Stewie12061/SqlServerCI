IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP20101') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP20101
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIF2010 Danh sách tính thưởng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 22/08/2017
-- <Example> EXEC KPIP20101 'AS', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP20101 ( 
  @DivisionID VARCHAR(50),  
  @DivisionIDList NVARCHAR(2000), 
  @EvaluationPhaseID nvarchar(50),
  @DepartmentID nvarchar(50),
  @CreateUserID nvarchar(50),
  @Note  nvarchar(250),
  @ConditionBonusFeatureID nvarchar(max), --tính thưởng KPI (Biến môi trường: BonusFeatureID)
  @UserID  VARCHAR(50),
  @PageNumber INT,
  @PageSize INT)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateUserID DESC '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''') and M.DeleteFlg = 0 '
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+@DivisionID+''' and M.DeleteFlg = 0 '
	
	IF Isnull(@EvaluationPhaseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationPhaseID, '''') LIKE N''%'+@EvaluationPhaseID+'%'' '
	
	IF Isnull(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DepartmentID, '''') LIKE N''%'+@DepartmentID+'%'' '

	IF Isnull(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID, '''') LIKE N''%'+@CreateUserID+'%'' '
		
	IF Isnull(@Note, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Note, '''') LIKE N''%'+@Note+'%'' '
	
	IF Isnull(@ConditionBonusFeatureID, '') != ''
		SET @sWhere = @sWhere + ' AND M.CreateUserID in (N'''+@ConditionBonusFeatureID+''' )'

	

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, M.EvaluationPhaseID, M.DepartmentID, M.Note, M.TotalBonusAmount
					, M.DeleteFlg, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					into #TempKPIT20101
			FROM KPIT20101 M With (NOLOCK)
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(APK) From #TempKPIT20101 With (NOLOCK)

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID
					, M.EvaluationPhaseID, D4.EvaluationPhaseName,D4.FromDate, D4.ToDate
					, M.DepartmentID, D1.DepartmentName
					, M.Note, M.TotalBonusAmount
					, M.DeleteFlg
					, M.CreateUserID, D5.FullName as CreateUserName
					, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT20101 M With (NOLOCK) Left join AT1102 D1 With (NOLOCK) on M.DepartmentID = D1.DepartmentID
								  Left join KPIT10601 D4 With (NOLOCK) on M.EvaluationPhaseID = D4.EvaluationPhaseID
								  Left join AT1103 D5 With (NOLOCK) on M.CreateUserID = D5.EmployeeID
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
			'
EXEC (@sSQL)


