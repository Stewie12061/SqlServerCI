IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP20001') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP20001
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIF2000 Danh sách cá nhân tự đánh giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 22/08/2017
----Edited by: hoàng vũ, Date: 05/10/2017 load dữ liệu người đánh giá từ bên HRM
--- Modified on 21/02/2019 by Bảo Anh: Chỉ load danh sách bảng đánh giá có chênh lệch điểm khi click vào cảnh báo chênh lệch điểm đánh giá
-- <Example> EXEC KPIP20001 'AS', '', '', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP20001 ( 
  @DivisionID VARCHAR(50),  
  @DivisionIDList NVARCHAR(2000), 
  @EmployeeID nvarchar(50),
  @EmployeeName nvarchar(250),
  @DepartmentID nvarchar(50),
  @DutyID nvarchar(50),
  @TitleID nvarchar(50),
  @EvaluationPhaseID nvarchar(50),
  @EvaluationSetID nvarchar(50),
  @ConfirmUserID nvarchar(50),
  @ConditionEvaluationSelfID nvarchar(max), --Cá nhân tự đánh giá [Biến môi trường: AssessmentSelfID]
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
		
	IF Isnull(@EvaluationSetID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EvaluationSetID, '''') LIKE N''%'+@EvaluationSetID+'%'' '
	
	IF Isnull(@ConfirmUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ConfirmUserID, '''') LIKE N''%'+@ConfirmUserID+'%'' '
	
	IF Isnull(@ConditionEvaluationSelfID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID in (N'''+@ConditionEvaluationSelfID+''' ) OR M.ConfirmUserID in (N'''+@ConditionEvaluationSelfID+''' ))'

IF @IsFromWarning = 1
BEGIN
	DECLARE @KPIWarningMarks INT

	SELECT @KPIWarningMarks = ISNULL(KPIWarningMarks,0)	FROM HT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID

	SELECT DISTINCT K1.APK
	INTO #List
	FROM KPIT20001 K1 WITH (NOLOCK)
	LEFT JOIN KPIT20002 K2 WITH (NOLOCK) ON K1.DivisionID = K2.DivisionID AND K1.APK = K2.APKMaster
	WHERE K1.DivisionID = @DivisionID AND (K1.ConfirmUserID = @UserID OR K1.EmployeeID = @UserID)
	AND ISNULL(K1.ClassificationReevaluatedPoint,'') <> '' AND ISNULL(K1.DeleteFlg,0) = 0
	AND ABS(ISNULL(K2.PerformPoint,0) - ISNULL(K2.ReevaluatedPoint,0)) > @KPIWarningMarks
END

SET @sSQL = 'SELECT M.APK, M.DivisionID, M.EmployeeID, D.FullName as EmployeeName, M.EvaluationPhaseID, M.FromDate
				, M.ToDate, M.EvaluationSetID, M.EvaluationSetName, M.Note, M.DepartmentID
				, M.DutyID, M.TitleID, M.StrengthPoint, M.WeakPoint, M.EmployeeComments
				, M.EmployeeProposes, M.ConfirmUserID, M.ConfirmDepartmentID, M.ConfirmDutyID
				, M.ConfirmTitleID, M.ConfirmComments, M.TotalPerformPoint, M.TotalReevaluatedPoint
				, M.TotalUnifiedPoint, M.ClassificationPerformPoint, M.ClassificationReevaluatedPoint
				, M.ClassificationUnifiedPoint, M.DeleteFlg
				, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					into #TempKPIT20001
			FROM KPIT20001 M With (NOLOCK) Inner join AT1103 D With (NOLOCK) ON M.EmployeeID = D.EmployeeID'

IF @IsFromWarning = 1
	SET @sSQL = @sSQL+'
	INNER JOIN #List ON M.APK = #List.APK'

SET @sSQL = @sSQL+'
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(EmployeeID) From #TempKPIT20001 With (NOLOCK)

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID
					, M.EmployeeID, M.EmployeeName
					, M.EvaluationSetID, M.EvaluationSetName
					, M.DepartmentID, D1.DepartmentName
					, M.DutyID, D2.DutyName
					, M.TitleID, D3.TitleName
					, M.EvaluationPhaseID, D4.EvaluationPhaseName
					, M.FromDate, M.ToDate
					, M.ConfirmUserID, LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(D5.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(D5.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(D5.FirstName,''''))),'' '','' ''))) AS ConfirmUserName
					, M.Note
					, M.TotalPerformPoint, M.TotalReevaluatedPoint
					, M.TotalUnifiedPoint, M.ClassificationPerformPoint, M.ClassificationReevaluatedPoint
					, M.ClassificationUnifiedPoint
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT20001 M With (NOLOCK) Left join AT1102 D1 With (NOLOCK) on M.DepartmentID = D1.DepartmentID
								  Left join HT1102 D2 With (NOLOCK) on M.DutyID = D2.DutyID
								  Left join HT1106 D3 With (NOLOCK) on M.TitleID = D3.TitleID
								  Left join KPIT10601 D4 With (NOLOCK) on M.EvaluationPhaseID = D4.EvaluationPhaseID
								  Left join HT1400 D5 With (NOLOCK) on M.ConfirmUserID = D5.EmployeeID
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
			'
EXEC (@sSQL)




