IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2080]
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
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Tấn Phú on 29/08/2017: Trường hợp người dùng khong chọn ngôn ngữ trong thông tin cá nhân thì dữ liệu không load lên -> đã sửa lại default là vi-VN
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 19/04/2021 by Huỳnh Thử: Cập nhật phân quyền
/*-- <Example>
	OOP2080 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=6000,@IsSearch=1, @TranMonth=6, @TranYear=2016,@EmployeeID='001489',@EmployeeName=NULL,
	@DepartmentID=NULL,@SectionID=NULL, @SubsectionID=NULL,@ProcessID=NULL,
	@FromDate='2016-09-01',@ToDate='2016-09-30',@Type=NULL, @Status = null
----*/

CREATE PROCEDURE OOP2080
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
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
	@ConditionPermissionCatalogID VARCHAR(MAX) 
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR (MAX) = '',
		@sSQL3 NVARCHAR (MAX) = '',
		@sSQL4 NVARCHAR (MAX) = '',
		@sSQL5 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)=''
		
SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WHERE UserID=@UserID

-- Truong hop userid chua bao gio cap nhat ngon ngu thi hien tai dang bi null nen se lay default la vi-VN
IF @LanguageID IS NULL SET @LanguageID='vi-VN'

IF @LanguageID='vi-VN'
SET @sSQLLanguage='O99.Description'
ELSE SET @sSQLLanguage='O99.DescriptionE'

      
SET @OrderBy = 'OOT90.ID,A.EmployeeID,A.Type,A.BeginDate,A.EndDate'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(1) OVER ()' ELSE SET @TotalRow = 'NULL'
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

IF Isnull(@ConditionPermissionCatalogID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OOT90.CreateUserID,'''') in (N'''+@ConditionPermissionCatalogID+''' )'


SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, OOT90.ID, A.*, OOT90.CreateUserID, HV1400.FullName AS CreateUserName
FROM 
(
---- Load đơn xin phép
	SELECT OOT20.DivisionID, OOT20.APK,OOT20.APKMaster,OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
	OOT90.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	LeaveFromDate AS BeginDate, LeaveToDate AS EndDate, 
	CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	 '+@sSQLLanguage+' StatusName, ''DXP'' AS [Type], 
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin nghỉ phép' +''' ELSE N''' + N'休暇申請届け' +''' END AS TypeName
	FROM OOT2010 OOT20 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DivisionID = OOT20.DivisionID AND A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.DivisionID = OOT20.DivisionID AND A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.DivisionID = OOT20.DivisionID AND A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT20.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status'' 
	WHERE OOT20.DivisionID = '''+@DivisionID+''' '

SET @sSQL1 = N'	
UNION ALL
---- Load đơn ra ngoài
	SELECT OOT20.DivisionID, OOT20.APK, OOT20.APKMaster, OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As FullName, 
	OOT90.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	GoFromDate AS BeginDate, GoToDate AS EndDate, 
	CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	'+@sSQLLanguage+' StatusName, ''DXRN'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin ra ngoài' +''' ELSE N''' + N'外出申請届け' +''' END AS TypeName
	FROM OOT2020 OOT20 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT20.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status''
	WHERE OOT20.DivisionID = '''+@DivisionID+''' '
	
SET @sSQL2 = N'
	
UNION ALL
---- Load đơn xin OT
	SELECT OOT20.DivisionID, OOT20.APK, OOT20.APKMaster, OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName,  
	OOT90.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	WorkFromDate AS BeginDate, WorkToDate AS EndDate,
	CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	'+@sSQLLanguage+' StatusName, ''DXLTG'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin làm thêm giờ' +''' ELSE N''' + N'残業申請届け' +'''  END AS TypeName
	FROM OOT2030 OOT20 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT20.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 =CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status'' 
	WHERE OOT20.DivisionID = '''+@DivisionID+''' '

SET @sSQL3 = N'
UNION ALL	
---- Load đơn xin BSQT
	SELECT OOT20.DivisionID, OOT20.APK, OOT20.APKMaster,OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
	OOT90.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	[Date] AS BeginDate, [Date] AS EndDate,
	CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	'+@sSQLLanguage+' StatusName, ''DXBSQT'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN  N'''+N'Đơn xin BSQT - '+''' + CASE WHEN InOut =0 THEN N''Vào'' ELSE N''Ra'' END 
	ELSE N''' + N'打刻データー訂正申請届け - ' +''' + CASE WHEN InOut =0 THEN N'''+N'N入力'+''' ELSE N'''+ N'N出力'+''' END END AS TypeName
	FROM OOT2040 OOT20 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT20.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status'' 
	WHERE OOT20.DivisionID = '''+@DivisionID+''' '
	
SET @sSQL4 = N'
	
UNION ALL	
---- Load đơn xin Đổi ca
	SELECT OOT20.DivisionID, OOT20.APK, OOT20.APKMaster, OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
	OOT90.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	ChangeFromDate AS BeginDate, ChangeToDate AS EndDate,
	CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AS [Status],
	'+@sSQLLanguage+' StatusName, ''DXDC'' AS [Type],
	CASE WHEN '''+@LanguageID+''' = ''vi-VN'' THEN N''' + N'Đơn xin đổi ca' +''' ELSE N''' + N'シフト変更申請届け' +''' END AS TypeName
	FROM OOT2070 OOT20 WITH (NOLOCK)
	LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID 
	LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HT14.TeamID AND HT14.DepartmentID = A12.DepartmentID
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT20.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = CASE WHEN OOT90.Status =1 AND OOT20.[Status] =1 THEN OOT20.[Status]
		WHEN OOT90.Status =1 AND OOT20.[Status] = 0 THEN 2
		WHEN OOT90.Status = 2 THEN 2
		WHEN OOT90.Status = 0 THEN 0 END AND O99.CodeMaster = ''Status''
	WHERE OOT20.DivisionID = '''+@DivisionID+'''
)A
LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON A.APKMaster = OOT90.APK
LEFT JOIN HV1400 ON A.DivisionID = HV1400.DivisionID AND OOT90.CreateuserID = HV1400.EmployeeID
WHERE 1=1
--OOT90.TranMonth = '+STR(@TranMonth)+'
--AND OOT90.TranYear = '+STR(@TranYear)+'
'+@sWhere+'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY' 

EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL4)


PRINT(@sSQL)
PRINT(@sSQL1)
PRINT(@sSQL2)
PRINT(@sSQL3)
PRINT(@sSQL4)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON

