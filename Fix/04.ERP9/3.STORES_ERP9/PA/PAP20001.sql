IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'PAP20001') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE PAP20001
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form PAF2000 Danh sách đánh giá năng lực
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 05/09/2017
--- Modified on 21/02/2019 by Bảo Anh: Chỉ load danh sách bảng đánh giá có chênh lệch điểm khi click vào cảnh báo chênh lệch điểm đánh giá
-- <Example> EXEC PAP20001 'AS', '', '', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE PAP20001 ( 
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
  @ConditionAppraisalSelfID nvarchar(max), --đánh giá năng lực (Biến môi trường: AppraisalSelfID)
  @UserID  VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @IsFromWarning TINYINT = 0	--- @IsFromWarning = 1: chỉ load các bảng đánh giá có chênh lệch điểm liên quan đến User đăng nhập
  )
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateUserID DESC, M.EmployeeID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''') and M.DeleteFlg = 0 '
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+@DivisionID+''' and M.DeleteFlg = 0 '
	
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

	IF Isnull(@ConfirmUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ConfirmUserID, '''') LIKE N''%'+@ConfirmUserID+'%'' '

	
	IF Isnull(@ConditionAppraisalSelfID, '') != ''
		SET @sWhere = @sWhere + ' AND ( ISNULL(M.ConfirmUserID, '''') in (N'''+@ConditionAppraisalSelfID+''' )
									   OR ISNULL(M.CreateUserID, '''') in (N'''+@ConditionAppraisalSelfID+''' )
									   ) '

IF @IsFromWarning = 1
BEGIN
	DECLARE @AppraisalWarningMarks INT

	SELECT @AppraisalWarningMarks = ISNULL(AppraisalWarningMarks,0)	FROM HT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID

	SELECT DISTINCT K1.APK
	INTO #List
	FROM PAT20001 K1 WITH (NOLOCK)
	LEFT JOIN PAT20002 K2 WITH (NOLOCK) ON K1.DivisionID = K2.DivisionID AND K1.APK = K2.APKMaster
	WHERE K1.DivisionID = @DivisionID AND (K1.ConfirmUserID = @UserID OR K1.EmployeeID = @UserID)
	AND K2.Reevaluated IS NOT NULL AND ISNULL(K1.DeleteFlg,0) = 0
	AND ABS(ISNULL(K2.PerformPoint,0) - ISNULL(K2.ReevaluatedPoint,0)) > @AppraisalWarningMarks
END	

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, M.EmployeeID, D.FullName as EmployeeName, M.EvaluationPhaseID, M.FromDate
					, M.ToDate, M.EvaluationKitID, M.EvaluationKitName, M.DepartmentID, M.DutyID
					, M.TitleID, M.Note, M.ConfirmUserID, M.ConfirmComments, M.TotalPerformPoint
					, M.TotalReevaluatedPoint, M.TotalUnifiedPoint, M.DeleteFlg, M.CreateUserID
					, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					into #TempPAT20001
			FROM PAT20001 M With (NOLOCK) Inner join AT1103 D With (NOLOCK) ON M.EmployeeID = D.EmployeeID'

IF @IsFromWarning = 1
	SET @sSQL = @sSQL+'
	INNER JOIN #List ON M.APK = #List.APK'

SET @sSQL = @sSQL+'
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(EmployeeID) From #TempPAT20001 With (NOLOCK)

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID, M.EmployeeID, M.EmployeeName, M.EvaluationPhaseID, D4.EvaluationPhaseName, M.FromDate
					, M.ToDate, M.EvaluationKitID, M.EvaluationKitName, M.DepartmentID, D1.DepartmentName, M.DutyID, D2.DutyName
					, M.TitleID, D3.TitleName, M.Note, M.ConfirmUserID, D5.FullName as ConfirmUserName, M.ConfirmComments, M.TotalPerformPoint
					, M.TotalReevaluatedPoint, M.TotalUnifiedPoint, M.DeleteFlg, M.CreateUserID
					, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempPAT20001 M With (NOLOCK) Left join AT1102 D1 With (NOLOCK) on M.DepartmentID = D1.DepartmentID
								  Left join HT1102 D2 With (NOLOCK) on M.DutyID = D2.DutyID
								  Left join HT1106 D3 With (NOLOCK) on M.TitleID = D3.TitleID
								  Left join KPIT10601 D4 With (NOLOCK) on M.EvaluationPhaseID = D4.EvaluationPhaseID
								  Left join AT1103 D5 With (NOLOCK) on M.ConfirmUserID = D5.EmployeeID
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
			'
EXEC (@sSQL)



