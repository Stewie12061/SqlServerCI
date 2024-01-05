IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2140: Duyệt Kế hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kim Thư, Date: 16/08/2018
-- <Example>
---- 
/*-- <Example>
	HRMP2140 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	@RecruitPlanID=NULL,@DepartmentID=NULL,@DutyID='LD',@FromDate=NULL,@ToDate='2017-08-30',@StatusID=0, @CreateUserID='NV01'

	EXEC HRMP2140 @DivisionID,@UserID,@PageNumber,@PageSize, @RecruitPlanID, @DepartmentID, @DutyID,@FromDate,@ToDate, @StatusID, @CreateUserID
----*/

CREATE PROCEDURE HRMP2140
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @RecruitPlanID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @StatusID VARCHAR(1),
	 @CreateUserID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'T1.DepartmentID, T1.RecruitPlanID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2000.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2000.DivisionID = '''+@DivisionID+''' '

IF ISNULL(@RecruitPlanID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT2000.RecruitPlanID LIKE ''%'+@RecruitPlanID+'%'' '
IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT2000.DepartmentID LIKE N''%'+@DepartmentID+'%'' '
IF ISNULL(@DutyID,'') <> '' 
BEGIN
	SET @sWhere = @sWhere + ' AND HRMT2001.DutyID LIKE ''%'+@DutyID+'%'' '
END

IF ISNULL(@StatusID,'') <> '' SET @sWhere = @sWhere + N'
AND HRMT2000.Status = '''+@StatusID+''''
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.FromDate,120), 120) >= '''+CONVERT(VARCHAR(10),@FromDate,120)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.ToDate,120), 120) <= '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.FromDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''' 
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.ToDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '


SET @sSQL = N'
SELECT DISTINCT HRMT2000.APK, HRMT2000.DivisionID, HRMT2000.RecruitPlanID, HRMT2000.Description, HRMT2000.DepartmentID, AT1102.DepartmentName,
	HRMT2000.FromDate, HRMT2000.ToDate,
	HRMT2000.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2000.CreateUserID) CreateUserID, HRMT2000.CreateDate, 
	HRMT2000.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2000.LastModifyUserID) LastModifyUserID, HRMT2000.LastModifyDate,
	HRMT2000.Status AS StatusID, HT0099.Description AS StatusName , AT1103.FullName AS CreateUserName,

	CASE WHEN ISNULL(Status1,'''')='''' THEN 0 ELSE
		CASE WHEN ISNULL(Status1,'''')<>'''' AND ISNULL(Status2,'''')='''' THEN 1 ELSE
		CASE WHEN ISNULL(Status2,'''')<>'''' AND ISNULL(Status3,'''')='''' THEN 2 ELSE
		CASE WHEN ISNULL(Status3,'''')<>'''' AND ISNULL(Status4,'''')='''' THEN 3 ELSE
		CASE WHEN ISNULL(Status4,'''')<>'''' AND ISNULL(Status5,'''')='''' THEN 4 ELSE
		CASE WHEN ISNULL(Status5,'''')<>'''' THEN 5
	END END END END END END AS NumOfApprove ,

	CASE WHEN ISNULL(Status1,'''')='''' THEN '''' ELSE
		CASE WHEN ISNULL(Status1,'''')<>'''' AND ISNULL(Status2,'''')='''' THEN ISNULL(Approver1,'''') ELSE
		CASE WHEN ISNULL(Status2,'''')<>'''' AND ISNULL(Status3,'''')='''' THEN ISNULL(Approver2,'''') ELSE
		CASE WHEN ISNULL(Status3,'''')<>'''' AND ISNULL(Status4,'''')='''' THEN ISNULL(Approver3,'''') ELSE
		CASE WHEN ISNULL(Status4,'''')<>'''' AND ISNULL(Status5,'''')='''' THEN ISNULL(Approver4,'''') ELSE
		CASE WHEN ISNULL(Status5,'''')<>'''' THEN ISNULL(Approver5,'''')
	END END END END END END AS BeEmployeeID,
	
	CASE WHEN ISNULL(Status1,'''')='''' THEN ISNULL(Approver1,'''') ELSE
		CASE WHEN ISNULL(Status1,'''')<>'''' AND ISNULL(Status2,'''')='''' THEN ISNULL(Approver2,'''') ELSE
		CASE WHEN ISNULL(Status2,'''')<>'''' AND ISNULL(Status3,'''')='''' THEN ISNULL(Approver3,'''') ELSE
		CASE WHEN ISNULL(Status3,'''')<>'''' AND ISNULL(Status4,'''')='''' THEN ISNULL(Approver4,'''') ELSE
		CASE WHEN ISNULL(Status4,'''')<>'''' AND ISNULL(Status5,'''')='''' THEN ISNULL(Approver5,'''') 
	END END END END END AS AfEmployeeID
	 
INTO #HRMP2140
FROM HRMT2000 WITH (NOLOCK)
LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2000.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT2000.Status = HT0099.ID AND HT0099.CodeMaster = ''Status''
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.DivisionID in (HRMT2000.DivisionID,''@@@'') AND HRMT2000.CreateUserID = AT1103.EmployeeID
WHERE '+@sWhere +'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, T1.*
FROM #HRMP2140 T1 
WHERE T1.AfEmployeeID = '''+@UserID+'''
AND ISNULL(T1.StatusID,0) = 0
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
