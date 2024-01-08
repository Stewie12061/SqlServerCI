IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90151]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Load màn hình chọn Yêu cầu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 30/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
-- <Example>
/*

	exec CRMP90151 @DivisionID=N'AS',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10'
	, @ConditionRequestID=N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'

*/

 CREATE PROCEDURE CRMP90151 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionRequestID NVARCHAR (MAX),
	 @ProjectID NVARCHAR(250),
	 @requestCustomerID NVARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@sSQLPermission NVARCHAR(MAX)
DECLARE @CustomerName INT
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

	SET @sWhere = '1=1'
	SET @TotalRow = ''
	SET @OrderBy = ' A.CreateDate DESC'
	SET @ConditionRequestID = REPLACE(@ConditionRequestID,'''','')

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF ISNULL(@ProjectID, '') != ''
	SET @sWhere = @sWhere + ' AND A.ProjectID LIKE N''%'+@ProjectID+'%''  '

	IF ISNULL(@requestCustomerID, '') != ''
	SET @sWhere = @sWhere + ' AND A.RequestCustomerID NOT IN (' + @requestCustomerID +')'

	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (A.RequestSubject LIKE N''%'+@TxtSearch+'%'' 
							OR A.RequestDescription LIKE N''%'+@TxtSearch+'%'' 
							OR A.TimeRequest LIKE N''%'+@TxtSearch+'%'' 
							OR A.DeadlineRequest LIKE N''%'+@TxtSearch+'%'' 
							OR B.Description LIKE N''%'+@TxtSearch + '%''
							OR O1.ProjectName LIKE N''%'+@TxtSearch + '%''
							OR A.RequestCustomerID LIKE N''%'+@TxtSearch + '%''
							OR C1.Description LIKE N''%'+@TxtSearch + '%''  
							OR A.AssignedToUserID LIKE N''%'+@TxtSearch+'%'')'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionCRMT20801'') IS NOT NULL DROP TABLE #PermissionCRMT20801
								
							SELECT Value
							INTO #PermissionCRMT20801
							FROM STRINGSPLIT(''' + ISNULL(@ConditionRequestID, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterRequestCustomerAPK'') IS NOT NULL DROP TABLE #FilterRequestCustomerAPK

							SELECT DISTINCT A.APK
							INTO #FilterRequestCustomerAPK
							FROM CRMT20801 A WITH (NOLOCK)
								LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A.ProjectID 
								LEFT JOIN OOT2101 O2 WITH (NOLOCK) ON O2.RelatedToID = A.ProjectID
								LEFT JOIN OOT2103 O3 WITH (NOLOCK) ON O3.RelatedToID = A.ProjectID
								LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = O2.DepartmentID
								LEFT JOIN AT1103 A1 WITH (NOLOCK) ON  A1.EmployeeID = A.AssignedToUserID
								LEFT JOIN CRMT20501 C07 WITH (NOLOCK) ON C07.OpportunityID = A.OpportunityID
								LEFT JOIN CRMT0099 B  WITH (NOLOCK) On A.RequestStatus = B.ID and B.CodeMaster =''CRMT00000003''
								LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.ID = A.TypeOfRequest AND C1.CodeMaster = ''CRMF2080.TypeOfRequest''
								INNER JOIN #PermissionCRMT20801 T1 ON T1.Value IN (A.AssignedToUserID, A.CreateUserID,
																				O1.LeaderID, A2.ContactPerson, O3.UserID, O1.CreateUserID)
							WHERE A.DivisionID = '''+@DivisionID+''' AND '+@sWhere+' '

	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, A.RequestID, A.RequestSubject, A.DivisionID
							, A.RequestDescription
							, A.TimeRequest
							, A.DeadlineRequest
							, A.FeedbackDescription
							, A.PriorityID, B.Description as RequestStatus
							, A.AssignedToUserID
							, A.RelatedToTypeID, A.APK
							, A.MilestoneID
							, A.ProjectID
							, O1.ProjectName AS ProjectName
							, A.RequestCustomerID
							, C1.Description AS TypeOfRequest
				FROM CRMT20801 A WITH (NOLOCK)
				Left join CRMT0099 B  WITH (NOLOCK) On A.RequestStatus = B.ID and B.CodeMaster =''CRMT00000003''
				LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A.ProjectID
				LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.ID = A.TypeOfRequest AND C1.CodeMaster = ''CRMF2080.TypeOfRequest''
				WHERE A.DivisionID = '''+@DivisionID+''' AND  '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQLPermission + @sSQL)
	Print (@sSQLPermission + @sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
