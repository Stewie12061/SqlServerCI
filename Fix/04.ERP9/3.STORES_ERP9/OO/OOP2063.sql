IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2063]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xuất Excel: Danh sách bất thường
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 21/06/2016
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modify on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
---- Modify on 21/07/2023 by Kiều Nga: Bổ sung param @Status (Tình trạng)
/*-- <Example>
exec OOP2063 @DivisionID=N'MK',@UserID=N'000054',@TranMonth=6,@TranYear=2016,@IsSearch=1,@EmployeeID=NULL,@UnusualTypeID=NULL,
@DepartmentID=NULL,@SectionID=NULL,@SubsectionID=NULL,@ProcessID=NULL,@FromDate='2016-05-30 00:00:00',@ToDate='2016-06-10 00:00:00', @IsCheckAll=1,
@APKList = null
----*/

CREATE PROCEDURE OOP2063
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@IsSearch BIT,
	@TranMonth INT,
	@TranYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@EmployeeID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@UnusualTypeID VARCHAR(50),
	@IsCheckAll TINYINT,
	@APKList NVARCHAR(MAX),
	@IsCreateNoOT Tinyint = 0,
	@Status TINYINT=0
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@Level INT,
		@LanguageID VARCHAR(50),
		@sSQLLanguage1 NVARCHAR(1000)='',
		@sSQLLanguage2 NVARCHAR(1000)='',
		@sSQLLanguage3 NVARCHAR(1000)=''

CREATE TABLE #OOT2060
(RowNum INT, APK VARCHAR(50), TranMonth INT,TranYear INT,EmployeeID VARCHAR(50),EmployeeName NVARCHAR(250),DepartmentID VARCHAR(50),SectionID VARCHAR(50),
SubsectionID VARCHAR(50),ProcessID VARCHAR(50),DepartmentName NVARCHAR(250), SectionName NVARCHAR(250), SubsectionName NVARCHAR(250), ProcessName NVARCHAR(250), 
[Date] DATETIME, ShiftID VARCHAR(50), BeginTime NVARCHAR(50), EndTime NVARCHAR(50), [Status] TINYINT, StatusName NVARCHAR(250), JugdeUnusualType VARCHAR(50),
JugdeUnusualTypeID NVARCHAR(250), Fact VARCHAR(50), FactName NVARCHAR(250), HandleMethod VARCHAR(50),
IsApproved Tinyint, AbsentDate Datetime, StandardBeginTime Time, StandardEndTime Time)


SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WITH (NOLOCK) WHERE UserID=@UserID
IF @LanguageID='vi-VN' 
BEGIN
	SET @sSQLLanguage1='O99.Description'
	SET @sSQLLanguage2 ='OT11.Description'
	SET @sSQLLanguage3 ='OT12.Description'
END
ELSE 
BEGIN
	SET @sSQLLanguage1='O99.DescriptionE'
	SET @sSQLLanguage2 ='OT11.DescriptionE'
	SET @sSQLLanguage3 ='OT12.DescriptionE'		
END


SET @Level=ISNULL((SELECT TOP 1 LEVEL FROM OOT0010 WITH (NOLOCK) WHERE DivisionID=@DivisionID),0)              
SET @OrderBy = 'EmployeeID,Date'
IF @IsSearch = 1
BEGIN
	IF @EmployeeID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT26.EmployeeID,'''') LIKE ''%'+@EmployeeID+'%'' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.TeamID,'''') LIKE ''%'+@SectionID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.Ana04ID,'''') LIKE ''%'+@SubsectionID+'%'' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.Ana05ID,'''') LIKE ''%'+@ProcessID+'%'' '
	IF @UnusualTypeID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT26.JugdeUnusualType,'''') LIKE ''%'+@UnusualTypeID+'%'' '	
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND ISNULL(CONVERT(VARCHAR, OOT26.WorkingDate, 112),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 112),'')+''' '
	IF ISNULL(@Status,0) = 0 SET @sWhere = @sWhere + '
	AND (ISNULL(OOT26.[Status],0) = '+STR(@Status)+' AND ISNULL(OOT26.HandleMethodID,'''') <> '''' )'
	ELSE IF ISNULL(@Status,0) = 1 SET @sWhere = @sWhere + '
		AND (ISNULL(OOT26.[Status],0) = '+STR(@Status)+' OR ISNULL(OOT26.HandleMethodID,'''') = '''' ) '
END

IF @IsCheckAll = 0 SET @sWhere = @sWhere + '
	AND OOT26.APK IN ('''+@APKList+''')'

SET @sSQL =' 
	INSERT INTO #OOT2060
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, *
	FROM
	(
		SELECT OOT26.APK, OOT26.TranMonth, OOT26.TranYear,
		       OOT26.EmployeeID, HV14.FullName EmployeeName, 
		       HV14.Ana02ID DepartmentID, HV14.Ana03ID SectionID,HV14.Ana04ID SubsectionID, HV14.Ana05ID ProcessID,
		       HV14.DepartmentName,HV14.TeamName SectionName,A13.AnaName SubsectionName,A14.AnaName ProcessName,
		       -- OOT26.[Date], 
			   OOT26.WorkingDate AS Date, NULL As ShiftID,  CONVERT(TIME(0),OOT26.ActBeginTime) BeginTime, CONVERT(TIME(0),OOT26.ActEndTime) EndTime,
			   OOT26.[Status],'+@sSQLLanguage1+' StatusName, OOT26.JugdeUnusualType ,'+@sSQLLanguage3+' JugdeUnusualTypeID, 
		       OOT26.Fact,'+@sSQLLanguage2+' FactName, OOT26.HandleMethodID AS HandleMethod,
			   Convert(Tinyint,0) AS IsApproved,
			   OOT26.[Date] AS AbsentDate, 
			   CONVERT(TIME(0),OOT26.BeginTime) StandardBeginTime, CONVERT(TIME(0),OOT26.EndTime) StandardEndTime
		FROM OOT2060 OOT26 WITH (NOLOCK)
		LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT26.Status,0) AND O99.CodeMaster=''HandleMethod'' 
		LEFT JOIN OOT1010 OT11 WITH (NOLOCK) ON OT11.DivisionID = OOT26.DivisionID AND OT11.[UnusualTypeID] = OOT26.Fact
		LEFT JOIN OOT1010 OT12 WITH (NOLOCK) ON OT12.DivisionID = OOT26.DivisionID AND OT12.[UnusualTypeID] = OOT26.JugdeUnusualType
		LEFT JOIN HV1400 HV14 ON HV14.DivisionID = OOT26.DivisionID AND HV14.EmployeeID = OOT26.EmployeeID 
		--LEFT JOIN AT1102 A11 ON A11.DepartmentID=HV14.DepartmentID 
		--LEFT JOIN HT1101 A12 ON A12.DivisionID = HV14.DivisionID AND A12.TeamID=HV14.TeamID
		LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HV14.Ana04ID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HV14.Ana05ID AND A14.AnaTypeID=''A05''
		--LEFT JOIN OOT9000 OOT90 ON OOT90.DivisionID = OOT26.DivisionID
		--LEFT JOIN AT0010 ON AT0010.DivisionID = OOT90.DivisionID AND AT0010.AdminUserID = '''+@UserID+''' AND AT0010.UserID = OOT90.CreateUserID
		WHERE OOT26.DivisionID='''+@DivisionID+'''
		AND OOT26.TranMonth ='+STR(@TranMonth)+'
		AND OOT26.TranYear ='+STR(@TranYear)+'
		--AND (OOT90.CreateUserID = AT0010.UserID
		--OR  OOT90.CreateUserID = '''+@UserID+''') 
		'+@sWhere+'
	)A 
	
	UPDATE T1
	SET		IsApproved = 1	
	FROM #OOT2060 T1
	WHERE EXISTS (SELECT TOP 1 1 FROM OOT2010 T2 INNER JOIN OOT9000 T3 ON T2.APKMaster = T3.APK 
					WHERE T1.EmployeeID = T2.EmployeeID AND T3.Status = 1 AND T2.Status = 1
					AND  (T1.AbsentDate+Cast(StandardBeginTime as Datetime)) Between LeaveFromDate and LeaveToDate
					AND  (T1.AbsentDate+Cast(StandardEndTime as Datetime)) Between LeaveFromDate and LeaveToDate )
	
	'


EXEC (@sSQL)
--PRINT(@sSQL)

CREATE TABLE #Shift (DivisionID VARCHAR(50), EmployeeID VARCHAR(50), ShiftID VARCHAR(50), AbsentDate DATETIME) 

----- load ca làm việc (trong kỳ)
DECLARE @i INT, @sDay VARCHAR(10),@ColDay VARCHAR(10), @iFromDay DATETIME

--SET @i = Day(@FromDate)
SELECT @i = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @FromDate
SET @iFromDay = @FromDate

WHILE @i <= (SELECT DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @ToDate)
		BEGIN
			
			IF @i < 10 SET @sDay = '0' + CONVERT(NVARCHAR, @i)
			ELSE SET @sDay = CONVERT(NVARCHAR, @i)

			SET @ColDay = 'D'+@sDay

			SELECT @sSQL = '
			INSERT INTO #Shift (DivisionID, EmployeeID, ShiftID, AbsentDate) --, BeginTime, EndTime	)
			SELECT	T1.DivisionID, T1.EmployeeID, '+@ColDay+' AS ShiftID, '''+CONVERT(VARCHAR(10),@iFromDay,120)+''' AS AbsentDate
			--,T2.BeginTime, T2.EndTime			
			FROM	HT1025 T1
			--LEFT JOIN HT1020 T2 ON T1.DivisionID = T2.DivisionID AND '+@ColDay+' = T2.ShiftID
			WHERE  T1.DivisionID='''+@DivisionID+'''		
				AND T1.TranMonth='+STR(@TranMonth)+'
				AND T1.TranYear='+STR(@TranYear)+'		
			'
			--Print @sSQL
			EXEC (@sSQL)
			--SET @iDay = @iDay + 1
			SET @i = @i + 1
			SET @iFromDay = DATEADD(d,1,@iFromDay)
		END


UPDATE T1
SET T1.ShiftID = T2.ShiftID
FROM #OOT2060 T1
LEFT JOIN #Shift T2 ON T1.EmployeeID = T2.EmployeeID AND T1.[Date] = T2.AbsentDate

SET @sSQL1 =' SELECT * FROM #OOT2060   
			  WHERE  1=1 '+CASE WHEN @IsCreateNoOT = 1 THEN ' AND IsApproved = 1 ' ELSE 'AND IsApproved = 0' END +'
			  ORDER BY '+@OrderBy+' '
		
EXEC (@sSQL1)
--PRINT (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

