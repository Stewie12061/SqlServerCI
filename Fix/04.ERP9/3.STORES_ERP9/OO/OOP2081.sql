IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form OOF2080: thống kê đơn của nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 04/07/2016
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Bảo Thy on 22/06/2017: Lấy thông tin Ca thay đổi của ĐXP
---- Modified by Đình Định on 14/04/2023: NEWTOYO - Danh mục đơn xin phép xuất excel trường hợp không có ngôn ngữ thì lấy vi-VN.
---- Modified by Đình Định on 09/09/2023: NEWTOYO - Bổ sung lấy ca ban đầu cho loại đơn làm thêm giờ DXLTG. 

/*-- <Example>
	OOP2081 @DivisionID='MK',@UserID='ASOFTADMIN',@IsSearch=1, @TranMonth=10, @TranYear=2016,@EmployeeID=null,@EmployeeName=NULL,
	@DepartmentID=NULL,@SectionID=NULL, @SubsectionID=NULL,@ProcessID=NULL,
	@FromDate=NULL,@ToDate=NULL,@Type=NULL, @Status = 2, @IsCheckAll=1, @APKList=NULL
----*/

CREATE PROCEDURE OOP2081
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@IsSearch TINYINT,
	@TranMonth INT,
	@TranYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@EmployeeID VARCHAR(50),
	@EmployeeName NVARCHAR(250),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@Type VARCHAR(50),
	@Status VARCHAR(50),
	@IsCheckAll TINYINT,
	@APKList NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR (MAX) = '',
		@sSQL5 NVARCHAR (MAX) = '',
		@sSQL6 NVARCHAR (MAX) = '',
		@Select NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)='',
		@MaxLevel INT

SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WITH (NOLOCK) WHERE UserID=@UserID
-- Trường hợp không có ngôn ngữ thì lấy vi-VN
IF @LanguageID IS NULL SET @LanguageID = 'vi-VN'

IF @LanguageID = 'vi-VN'
	SET @sSQLLanguage='O99.Description'
ELSE 
	SET @sSQLLanguage='O99.DescriptionE'

SELECT @MaxLevel = MAX([Level]) FROM OOT0010 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND TranMonth=@TranMonth AND TranYear=@TranYear
SELECT @MaxLevel MaxLevel 
       
SET @OrderBy = 'A.EmployeeID,A.Type'

IF @IsCheckAll = 0 SET @sWhere = @sWhere + '
	AND A.APK IN ('''+@APKList+''')'
	
IF @IsSearch = 1
BEGIN
	IF @EmployeeID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.EmployeeID,'''') LIKE ''%'+@EmployeeID+'%'' '
	IF @EmployeeName IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.EmployeeName,'''') LIKE N''%'+@EmployeeName+'%'' '
	IF @Type IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.Type,'''') LIKE ''%'+@Type+'%'' '
	IF @Status IS NOT NULL AND @Status <>'%' SET @sWhere = @sWhere + '
	AND ISNULL(A.[Status],0) = '+@Status+' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.SectionID,'''') LIKE ''%'+@SectionID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.SubsectionID,'''') LIKE ''%'+@SubsectionID+'%'' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(A.ProcessID,'''') LIKE ''%'+@ProcessID+'%'' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND ISNULL(CONVERT(VARCHAR(10), A.BeginDate, 112),'''+CONVERT(VARCHAR(10), @FromDate, 112)+''') BETWEEN '''+ISNULL(CONVERT(VARCHAR(10), @FromDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR(10), @ToDate, 112),'')+'''
	AND ISNULL(CONVERT(VARCHAR(10), A.EndDate, 112),'''+CONVERT(VARCHAR(10), @FromDate, 112)+''') BETWEEN '''+ISNULL(CONVERT(VARCHAR(10), @FromDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR(10), @ToDate, 112),'')+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, A.BeginDate,120), 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,ISNULL(A.EndDate,'''+CONVERT(VARCHAR(10),@ToDate,126)+'''),120), 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
END

CREATE TABLE #OOP2081 ( ID VARCHAR(50), DivisionID VARCHAR(50), APK VARCHAR(50), APKMaster VARCHAR(50), EmployeeID VARCHAR(50), EmployeeName NVARCHAR(250), DepartmentID VARCHAR(50),
DepartmentName NVARCHAR(250), TeamID VARCHAR(50), TeamName NVARCHAR(250), SubsectionID VARCHAR(50), SubsectionName NVARCHAR(250), ProcessID VARCHAR(50), ProcessName NVARCHAR(250), 
BeginDate DATETIME, EndDate DATETIME, [Status] TINYINT, StatusName NVARCHAR(250), [Type] VARCHAR(50), TypeName NVARCHAR(250), AbsentTypeID VARCHAR(50), AbsentTypeName NVARCHAR(250),
ShiftOT VARCHAR(50), ChangedShift NVARCHAR(250), ActualInTime DATETIME, ActualOutTime DATETIME, InTime DATETIME,OutTime DATETIME,TotalTime DECIMAL(28,2),Reason NVARCHAR(250),
ShiftID VARCHAR(10),CreateDate DATETIME, CreateUserID VARCHAR(50),CreateUserName NVARCHAR(250),ApprovedDate DATETIME)

SET @sSQL = N'
SELECT  OOT90.ID, A.*,  OOT90.CreateDate, OOT90.CreateUserID,
Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) As CreateUserName,
CASE WHEN ISNULL(OOT90.[Status],0) <> 0 THEN OOT90.lastmodifyDate ELSE NULL END AS ApprovedDate
FROM 
(
---- Load đơn xin phép
	SELECT OOT10.DivisionID, OOT10.APK,OOT10.APKMaster, OOT10.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
	HT14.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	LeaveFromDate AS BeginDate, LeaveToDate AS EndDate, 
	CASE WHEN OOT90.Status =1 AND OOT10.[Status] =1 THEN OOT10.[Status]
		WHEN OOT90.Status =1 AND OOT10.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	 CASE WHEN '''+@LanguageID+'''=''vi-VN'' THEN O99.Description ELSE O99.DescriptionE END AS StatusName, ''DXP'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin nghỉ phép' +''' ELSE N''' + N'休暇申請届け' +''' END AS TypeName
	,OOT10.AbsentTypeID, CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN OOT1000.Description ELSE OOT1000.DescriptionE END AS AbsentTypeName, 
	''''  AS ShiftOT, OOT10.ShiftID AS ChangedShift, NULL AS ActualInTime, NULL AS ActualOutTime,NULL AS InTime, NULL AS OutTime, OOT10.TotalTime, OOT10.Reason,'''' AS ShiftID
	FROM OOT2010 OOT10 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = OOT10.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT10.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT1000 ON OOT1000.DivisionID=OOT10.DivisionID AND OOT10.AbsentTypeID=OOT1000.AbsentTypeID
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT10.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT10.[Status] =1 THEN OOT10.[Status]
		WHEN OOT90.Status =1 AND OOT10.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END
		 AND O99.CodeMaster = ''Status''
	WHERE OOT10.DivisionID = '''+@DivisionID+''' '
	
SET @sSQL5 ='
	
UNION ALL
---- Load đơn ra ngoài
	SELECT OOT20.DivisionID, OOT20.APK, OOT20.APKMaster, OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As FullName, 
	HT14.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	GoFromDate AS BeginDate, GoToDate AS EndDate, 
	CASE WHEN OOT90.Status <> 2 AND OOT20.[Status] = 1 THEN OOT20.[Status]
		WHEN OOT90.Status <> 2 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2 END AS [Status],
	 CASE WHEN '''+@LanguageID+'''=''vi-VN'' THEN O99.Description ELSE O99.DescriptionE END AS StatusName, ''DXRN'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin ra ngoài' +''' ELSE N''' + N'外出申請届け' +''' END AS TypeName
	,'''' AS AbsentTypeID,'''' AS AbsentTypeName, ''''  AS ShiftOT,'''' AS ChangedShift, NULL AS ActualInTime, NULL AS ActualOutTime
	,NULL AS InTime, NULL AS OutTime, NULL AS TotalTime, OOT20.Reason,'''' AS ShiftID
	FROM OOT2020 OOT20 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT20.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status <> 2 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status <> 2 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2 END AND O99.CodeMaster = ''Status''
	WHERE OOT20.DivisionID = '''+@DivisionID+''' '
	
SET @sSQL1 = N'
	
UNION ALL
---- Load đơn xin OT
	SELECT OOT30.DivisionID, OOT30.APK, OOT30.APKMaster, OOT30.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName,  
	HT14.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	WorkFromDate AS BeginDate, WorkToDate AS EndDate,
	CASE WHEN OOT90.Status =1 AND OOT30.[Status] =1 THEN OOT30.[Status]
		WHEN OOT90.Status =1 AND OOT30.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	  CASE WHEN '''+@LanguageID+'''=''vi-VN'' THEN O99.Description ELSE O99.DescriptionE END AS StatusName, ''DXLTG'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin làm thêm giờ' +''' ELSE N''' + N'残業申請届け' +'''  END AS TypeName
	,'''' AS AbsentTypeID,'''' AS AbsentTypeName, OOT30.ShiftID AS ShiftOT, '''' AS ChangedShift, NULL AS ActualInTime, NULL AS ActualOutTime
	,NULL AS InTime, NULL AS OutTime, OOT30.TotalTime, OOT30.Reason,'''' AS ShiftID
	FROM OOT2030 OOT30 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT30.DivisionID AND HT14.EmployeeID = OOT30.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT30.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT30.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT30.[Status] =1 THEN OOT30.[Status]
		WHEN OOT90.Status =1 AND OOT30.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status''
	WHERE OOT30.DivisionID = '''+@DivisionID+''' '
	
SET @sSQL6 ='
UNION ALL	
---- Load đơn xin BSQT
	SELECT OOT40.DivisionID, OOT40.APK, OOT40.APKMaster,OOT40.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
	HT14.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	OOT40.[Date] AS BeginDate, NULL AS EndDate, 
	CASE WHEN OOT90.Status =1 AND OOT40.[Status] =1 THEN OOT40.[Status]
		WHEN OOT90.Status =1 AND OOT40.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	 CASE WHEN '''+@LanguageID+'''=''vi-VN'' THEN O99.Description ELSE O99.DescriptionE END AS StatusName, ''DXBSQT'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN  N'''+N'Bổ sung quẹt thẻ'+''' 
	ELSE N''' + N'打刻データー訂正申請届け'+''' END AS TypeName 
	,'''' AS AbsentTypeID,'''' AS AbsentTypeName, ''''  AS ShiftOT,'''' AS ChangedShift,
	CASE WHEN HT2406.IOCode = 0 THEN HT2406.AbsentTime END AS ActualInTime, CASE WHEN HT2406.IOCode = 1 THEN HT2406.AbsentTime END AS ActualOutTime,
	CASE WHEN OOT40.InOut = 0 THEN OOT40.[Date] END AS InTime, CASE WHEN OOT40.InOut = 1 THEN OOT40.[Date] END AS OutTime, NULL AS TotalTime, OOT40.Reason,'''' AS ShiftID
	FROM OOT2040 OOT40 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT40.DivisionID AND HT14.EmployeeID = OOT40.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT40.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN HT1407 WITH (NOLOCK) ON OOT40.DivisionID = HT1407.DivisionID AND OOT40.EmployeeID = HT1407.EmployeeID
	LEFT JOIN HT2406 WITH (NOLOCK) ON OOT40.DivisionID = HT2406.DivisionID AND HT1407.AbsentCardNo = HT2406.AbsentCardNo AND OOT40.[Date] = HT2406.AbsentDate AND HT2406.TranMonth = '+STR(@TranMonth)+' AND HT2406.TranYear = '+STR(@TranYear)+'
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT40.[Status] =1 THEN OOT40.[Status]
		WHEN OOT90.Status =1 AND OOT40.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status''
	WHERE OOT40.DivisionID = '''+@DivisionID+''' '
	
SET @sSQL2 = N'
	
UNION ALL	
---- Load đơn xin Đổi ca
	SELECT OOT70.DivisionID, OOT70.APK, OOT70.APKMaster, OOT70.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
	HT14.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	ChangeFromDate AS BeginDate, ChangeToDate AS EndDate,
	CASE WHEN OOT90.Status =1 AND OOT70.[Status] =1 THEN OOT70.[Status]
		WHEN OOT90.Status =1 AND OOT70.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	  CASE WHEN '''+@LanguageID+'''=''vi-VN'' THEN O99.Description ELSE O99.DescriptionE END AS StatusName, ''DXDC'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin đổi ca' +''' ELSE N''' + N'シフト変更申請届け' +''' END AS TypeName
	,'''' AS AbsentTypeID,'''' AS AbsentTypeName, ''''  AS ShiftOT,OOT70.ShiftID AS ChangedShift, NULL AS ActualInTime, NULL AS ActualOutTime
	,NULL AS InTime, NULL AS OutTime, NULL AS TotalTime, '''' AS Reason,'''' AS ShiftID
	FROM OOT2070 OOT70 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT70.DivisionID AND HT14.EmployeeID = OOT70.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT70.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT70.[Status] =1 THEN OOT70.[Status]
		WHEN OOT90.Status =1 AND OOT70.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END
		 AND O99.CodeMaster = ''Status''
	WHERE OOT70.DivisionID = '''+@DivisionID+'''
)A
LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON A.APKMaster = OOT90.APK
LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.DivisionID = A.DivisionID AND HT1400.EmployeeID = OOT90.CreateUserID
WHERE 1=1 
--OOT90.TranMonth = '+STR(@TranMonth)+'
--AND OOT90.TranYear = '+STR(@TranYear)+'
'+@sWhere+'
ORDER BY '+@OrderBy+' 

'
--PRINT(@sSQL)
--PRINT(@sSQL5)
--PRINT(@sSQL1)
--PRINT(@sSQL6)
--PRINT(@sSQL2)

INSERT INTO #OOP2081
EXEC (@sSQL+@sSQL5+@sSQL1+@sSQL6+@sSQL2)

------Lấy ca hiện tại
DECLARE @Cur CURSOR ,
		@EmployeeIDCur VARCHAR(10),
		@Date DATE 
CREATE TABLE #Shift (ShiftID VARCHAR(50), EmployeeID VARCHAR(50), [Date] DATE, IsNextDay TINYINT,FromWorkingDate DATETIME, ToWorkingDate DATETIME )

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT distinct EmployeeID, CONVERT(DATE,ISNULL(BeginDate,InTime),120), [Type] FROM #OOP2081

OPEN @Cur
FETCH NEXT FROM @Cur INTO @EmployeeIDCur, @Date, @Type
WHILE @@FETCH_STATUS = 0
BEGIN

	INSERT INTO #Shift
	EXEC OOP2034 @DivisionID, @UserID, @Date, @EmployeeIDCur, @Type

FETCH NEXT FROM @Cur INTO @EmployeeIDCur, @Date, @Type
END
Close @Cur 

UPDATE T1
SET T1.ShiftID =  T2.ShiftID
FROM #OOP2081 T1
LEFT JOIN #Shift T2 ON T1.EmployeeID = T2.EmployeeID AND CONVERT(DATE,ISNULL(T1.BeginDate,T1.InTime),120) = T2.[Date]

--select T2.[Date],* from #Shift T2
--select CONVERT(DATE,ISNULL(T1.BeginDate,T1.InTime),120),* from #OOP2081 T1
--------------
SELECT  #OOP2081.*,
Ltrim(RTrim(isnull(HT14.LastName,'')))+ ' ' + LTrim(RTrim(isnull(HT14.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(HT14.FirstName,''))) As ApprovePersonName,
OOT91.[Level]
INTO #T1
FROM #OOP2081
LEFT JOIN OOT9001 OOT91 WITH (NOLOCK) ON #OOP2081.APKMaster = OOT91.APKMaster
LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON OOT91.ApprovePersonID = HT14.EmployeeID

-- SELECT DISTINCT CASE WHEN [Level] < 10 THEN '0'+convert(varchar(2),[Level]) ELSE  convert(varchar(2),[Level]) END as [Level]
SELECT DISTINCT convert(varchar(1),[Level])  as [Level]
INTO #T2
FROM #T1
WHERE ISNULL(#T1.[Level],'') <> ''

declare @sSQL3 Nvarchar(max) = '',
@sSQL4 Nvarchar(max) = ''
	
SELECT @sSQL3 = @sSQL3 +
	'
	SELECT	*
	into #T	
	FROM	
	(
	SELECT	 #T1.*
	FROM	 #T1
	) P
	PIVOT
	(MAX(ApprovePersonName) FOR Level IN ('
	SELECT	@sSQL4 = @sSQL4 + CASE WHEN @sSQL4 <> '' THEN ',' ELSE '' END + '['+''+Level+''+']'
	FROM	#T2
	SELECT	@sSQL4 = @sSQL4 +') ) As T' 
	
	
SELECT @sSQL4 = @sSQL4 + ' 
SELECT ROW_NUMBER() OVER (ORDER BY EmployeeID, Type) AS RowNum, * FROM #T ORDER BY RowNum'

--print @sSQL3
--print @sSQL4

EXEC (@sSQL3+@sSQL4)

--SELECT * FROM #OOP2081 ORDER BY RowNum

DROP TABLE #OOP2081
DROP TABLE #T1
DROP TABLE #T2


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
