IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'PAP20003') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE PAP20003
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form PAF2000 Danh sách đánh giá năng lực (PAR20001)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 05/09/2017
-- <Example> EXEC PAP20003 'AS', '', '', '', '', '', '', '', '', '', '', ''

CREATE PROCEDURE PAP20003 ( 
  @DivisionID VARCHAR(50),  
  @DivisionIDList NVARCHAR(2000), 
  @EmployeeID nvarchar(50),
  @EmployeeName nvarchar(250),
  @DepartmentID nvarchar(50),
  @DutyID nvarchar(50),
  @TitleID nvarchar(50),
  @EvaluationPhaseID nvarchar(50),
  @EvaluationKitID nvarchar(50),
  @ConfirmUserID nvarchar(50),
  @ConditionAppraisalSelfID nvarchar(max), --đánh giá năng lực
  @UserID  VARCHAR(50)
  )
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
	SET @sWhere = ''
	
		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''') and M.DeleteFlg = 0 '
	Else 
		SET @sWhere = @sWhere + ' AND M.DivisionID = N'''+@DivisionID+''' and M.DeleteFlg = 0 '
	
	IF Isnull(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EmployeeID, '''') LIKE N''%'+@EmployeeID+'%'' '
	
	IF Isnull(@EmployeeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D.FullName, '''') LIKE N''%'+@EmployeeName+'%'' '

	IF Isnull(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DepartmentID, '''') LIKE N''%'+@DepartmentID+'%'' '

	IF Isnull(@DutyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DutyID, '''') LIKE N''%'+@DutyID+'%'' '

	IF Isnull(@TitleID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TitleID, '''') LIKE N''%'+@TitleID+'%'' '

	IF Isnull(@EvaluationPhaseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationPhaseID, '''') LIKE N''%'+@EvaluationPhaseID+'%'' '
		
	IF Isnull(@EvaluationKitID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationKitID, '''') LIKE N''%'+@EvaluationKitID+'%'' '
	
	IF Isnull(@ConditionAppraisalSelfID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ConfirmUserID,M.CreateUserID) in (N'''+@ConditionAppraisalSelfID+''' )'

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, D6.DivisionName, M.EmployeeID, D.FullName as EmployeeName, M.EvaluationPhaseID, D4.EvaluationPhaseName, M.FromDate
					, M.ToDate, M.EvaluationKitID, M.EvaluationKitName, M.DepartmentID, D1.DepartmentName, M.DutyID, D2.DutyName
					, M.TitleID, D3.TitleName, M.Note, M.ConfirmUserID, D5.FullName as ConfirmUserName, M.ConfirmComments, M.TotalPerformPoint
					, M.TotalReevaluatedPoint, M.TotalUnifiedPoint, M.DeleteFlg, M.CreateUserID
					, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM PAT20001 M With (NOLOCK) Inner join AT1103 D With (NOLOCK) ON M.EmployeeID = D.EmployeeID
										  Left join AT1102 D1 With (NOLOCK) on M.DepartmentID = D1.DepartmentID
										  Left join HT1102 D2 With (NOLOCK) on M.DutyID = D2.DutyID
										  Left join HT1106 D3 With (NOLOCK) on M.TitleID = D3.TitleID
										  Left join KPIT10601 D4 With (NOLOCK) on M.EvaluationPhaseID = D4.EvaluationPhaseID
										  Left join AT1103 D5 With (NOLOCK) on M.ConfirmUserID = D5.EmployeeID
										  Left join AT1101 D6 With (NOLOCK) on M.DivisionID = D6.DivisionID
			WHERE M.DeleteFlg = 0 '+@sWhere+'
			Order by M.CreateUserID DESC, M.EmployeeID
			'
EXEC (@sSQL)
PRINT (@sSQL)


