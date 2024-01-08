IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2210]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2210]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRMF2210: Load Grid/In hồ sơ nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 14/11/2023
-- <Example>
---- 
/*-- <Example>
	exec HRMP2210 @DivisionID=N'BBA-SI',@DivisionList=NULL,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1
	,@EmployeeID=NULL,@IsMale=N'',@Mode=0,@IsPeriod=0,@PeriodList=N'',@FromDate='2023-11-23 00:00:00'
	,@ToDate='2023-11-23 00:00:00'

----*/

CREATE PROCEDURE HRMP2210
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @EmployeeID VARCHAR(50),
	 @EmployeeName VARCHAR(250),
	 @DepartmentID VARCHAR(MAX),
	 @DutyID VARCHAR(MAX),--bs4
	 @EmployeeStatus VARCHAR(50),
	 @IsMale VARCHAR(MAX),
	 @Mode TINYINT, 
	 @Language VARCHAR(50),
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@sSQL1 NVARCHAR (MAX)=N''

SET @OrderBy = 'HT14.EmployeeID DESC'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HT14.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HT14.DivisionID = '''+@DivisionID+''' '


IF  @IsSearch = 1 OR @Mode = 1
BEGIN
	
	IF ISNULL(@EmployeeID,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HT14.EmployeeID LIKE ''%'+@EmployeeID+'%'' '
    IF ISNULL(@EmployeeName,'') <> ''
		IF @Language <> 'vi-VN'
			SET @sWhere = @sWhere + '
				AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT14.FirstName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT14.LastName,''''))),''  '','' ''))) LIKE N''%'+@EmployeeName+'%'' '
		ELSE
			SET @sWhere = @sWhere + '
				AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT14.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT14.FirstName,''''))),''  '','' ''))) LIKE N''%'+@EmployeeName+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HT43.DepartmentID IN ('''+ @DepartmentID +''') '
    IF ISNULL(@DutyID,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HT43.DutyID IN ('''+ @DutyID +''') '

	IF ISNULL(@EmployeeStatus,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HT43.EmployeeStatus IN ('''+ @EmployeeStatus +''') '

	IF ISNULL(@IsMale,'') <> '' 
		SET @sWhere = @sWhere + '
			AND HT14.IsMale IN ('''+ @IsMale +''') '
	
	
	IF @IsPeriod = 1
	BEGIN
		SET @sWhere = @sWhere + 'AND FORMAT(HT14.CreateDate, ''MM/yyyy'') IN ('''+ @PeriodList +''') '
	END
	ELSE
	BEGIN
		IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, HT14.CreateDate, 112) >= '''+ CONVERT(VARCHAR, @FromDate, 112) +''' '
		ELSE IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, HT14.CreateDate, 112) <= '''+ CONVERT(VARCHAR, @ToDate, 112) +''' '
		ELSE IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, HT14.CreateDate, 112) 
			BETWEEN '''+ CONVERT(VARCHAR, @FromDate, 112) +''' AND '''+ CONVERT(VARCHAR, @ToDate, 112) +''' '
	END
END

BEGIN --Load Tên ứng viên (EmployeeName) theo ngôn ngữ
	IF @Language <> 'vi-VN'
		SET @sSQL1 = N'LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT14.FirstName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT14.LastName,''''))),''  '','' ''))) AS EmployeeName '
	ELSE
		SET @sSQL1 = N'LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT14.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT14.FirstName,''''))),''  '','' ''))) AS EmployeeName '
END
SET @sWhere = @sWhere + ' AND ISNULL(HT14.DeleteFlg,0) = 0 '
IF ISNULL(@Mode,0) = 0 ---Load form
	BEGIN
		SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
				HT14.APK, HT14.DivisionID, HT14.EmployeeID,
				HT14.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT14.CreateUserID) CreateUserID, HT14.CreateDate, 
				HT14.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT14.LastModifyUserID) LastModifyUserID, HT14.LastModifyDate,
				 ' + @sSQL1 + '
				, HT91.Description AS IsMaleName
				, HT43.DepartmentID AS DepartmentID1,  AT02.DepartmentName AS DepartmentID
				, HT43.DutyID AS DutyID
				, HT92.Description AS EmployeeStatus
			FROM HT1400 HT14 WITH (NOLOCK)
			LEFT JOIN HT0099 HT91 WITH (NOLOCK) ON HT91.ID = HT14.IsMale AND HT91.CodeMaster = ''IsMale'' AND HT91.Disabled = 0
			LEFT JOIN HT1403 HT43 WITH (NOLOCK) ON HT43.DivisionID = HT14.DivisionID AND HT43.EmployeeID = HT14.EmployeeID
			LEFT JOIN HT0099 HT92 WITH (NOLOCK) ON HT92.ID = HT43.EmployeeStatus AND HT92.CodeMaster =''EmployeeStatus''
			LEFT JOIN AT1102 AT02 WITH (NOLOCK) ON AT02.DepartmentID = HT43.DepartmentID	
			WHERE '+@sWhere +'
			ORDER BY '+@OrderBy+'

			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END
ELSE
	BEGIN ---@Mode = 1: In
		SET @sSQL = N'
			SELECT HT14.DivisionID, AT1101.DivisionName, HT14.EmployeeID
				  ' + @sSQL1 + ' 
			FROM HT1400  HT14 WITH (NOLOCK)
				LEFT JOIN AT1101 WITH (NOLOCK) ON HT14.DivisionID = AT1101.DivisionID
			WHERE '+@sWhere +'
			ORDER BY '+@OrderBy+'
			'
END
PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
