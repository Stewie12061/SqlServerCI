IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP20007') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP20007
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIF2003 Danh sách kết quả thực hiện KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 25/02/2019 by Bảo Anh
--- Modified on
-- <Example> EXEC KPIP20007 'NTY', '', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP20007
( 
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
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT
)

AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
SET @sWhere = ''
SET @OrderBy = ' M.CreateUserID DESC, M.EmployeeID '

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
	
IF Isnull(@UserID, '') != ''
	SET @sWhere = @sWhere + ' AND (M.CreateUserID in (N'''+@UserID+''' ) OR M.ConfirmUserID in (N'''+@UserID+''' ))'	

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID, M.EmployeeID, D.FullName as EmployeeName, M.EvaluationPhaseID, E.FromDate
				, E.ToDate, M.EvaluationSetID, F.EvaluationSetName, M.DepartmentID
				, M.DutyID, M.TitleID, M.ConfirmUserID, M.TotalPerformPoint, M.TotalPerformPercent,M.DeleteFlg
				, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			INTO #TempKPIT20003
			FROM KPIT20003 M WITH (NOLOCK)
			INNER JOIN AT1103 D WITH (NOLOCK) ON M.EmployeeID = D.EmployeeID
			LEFT JOIN KPIT10601 E WITH (NOLOCK) ON M.DivisionID = E.DivisionID AND M.EvaluationPhaseID = E.EvaluationPhaseID
			LEFT JOIN KPIT10701 F WITH (NOLOCK) ON M.DivisionID = F.DivisionID AND M.EvaluationSetID = F.EvaluationSetID
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(EmployeeID) From #TempKPIT20003 WITH (NOLOCK)

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
					, M.TotalPerformPoint, M.TotalPerformPercent					
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT20003 M WITH (NOLOCK) LEFT JOIN AT1102 D1 WITH (NOLOCK) on M.DepartmentID = D1.DepartmentID
				LEFT JOIN HT1102 D2 WITH (NOLOCK) on M.DivisionID = D2.DivisionID AND M.DutyID = D2.DutyID
				LEFT JOIN HT1106 D3 WITH (NOLOCK) on M.DivisionID = D3.DivisionID AND M.TitleID = D3.TitleID
				LEFT JOIN KPIT10601 D4 WITH (NOLOCK) on M.DivisionID = D4.DivisionID AND M.EvaluationPhaseID = D4.EvaluationPhaseID
				LEFT JOIN HT1400 D5 WITH (NOLOCK) on M.DivisionID = D5.DivisionID AND M.ConfirmUserID = D5.EmployeeID
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
			'
EXEC (@sSQL)




