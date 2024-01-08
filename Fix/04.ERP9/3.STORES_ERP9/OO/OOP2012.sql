IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin master Đơn xin nghỉ phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Bảo Thy, Date: 04/12/2015
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified on 27/12/2018 by Bảo Anh: Gom chung store OOP2013 để load cả dữ liệu master và detail, số cấp duyệt lấy từ OOT9001
---- Modified on 25/02/2019 by Bảo Anh: Bổ sung cột check Xin phép hàng loạt
---- Modified on 04/10/2021 by Văn Tài: Hỗ trợ sắp xếp theo mã nhân viên.

-- <Example>
---- 
/*
  exec OOP2012 @DivisionID=N'MK',@UserID=N'ASOFTADMIN',@APKMaster=N'1245E1AE-EF6F-48E9-AAE6-008DC7E7D485',@tranMonth=8,@TranYear=2016
*/
CREATE PROCEDURE OOP2012
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APKMaster VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@PageNumber INT = NULL,
	@PageSize INT = NULL
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR (MAX) = '',
		@OrderBy NVARCHAR(500),		
		@TotalRow NVARCHAR(50) = ''

SET @OrderBy = ' BT.EmployeeID, BT.FromWorkingDate '
IF @PageNumber IS NULL 
BEGIN
	SET  @sSQL2=''
	SET @TotalRow = 'NULL'	
END
ELSE if @PageNumber = 1 
BEGIN
SET @TotalRow = 'COUNT(*) OVER ()'
SET @sSQL2 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE 
BEGIN
	SET @TotalRow = 'NULL'
	SET @sSQL2 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END

SET @sSQL ='
SELECT	OOT00.APK, OOT90.DivisionID, A051.UserName CreateUserName, OOT00.TranMonth, OOT00.TranYear, OOT00.ID, OOT00.[Description],
		OOT00.DepartmentID, OOT00.SectionID,
		A11.DepartmentName, A12.TeamName SectionName,
		--O90.Description AS StatusName,--- Trang thai duyet cua don
		ISNULL(OOT21.ApproveLevel,0) AS ApproveLevel, ISNULL(OOT21.ApprovingLevel,0) AS ApprovingLevel,
		ISNULL(OOT90.Level, 0) AS Level, OOT90.ApprovePersonID,
		Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) 
						+ '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As ApprovePersonName,
		OOT90.Status AS ApprovePersonStatus, O99.Description ApprovePersonStatusName, OOT90.Note AS ApprovePersonNote,
		OOT00.CreateUserID +'' - ''+ A051.UserName CreateUserID, OOT00.CreateDate, 
		OOT00.LastModifyUserID +'' - ''+ A052.UserName LastModifyUserID, OOT00.LastModifyDate,

		OOT21.APK AS APKDetail, OOT21.EmployeeID,
		Ltrim(RTrim(isnull(HT15.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT15.MiddleName,''''))) 
						+ '' '' + LTrim(RTrim(Isnull(HT15.FirstName,''''))) As EmployeeName,
		OOT21.Reason, OOT21.AbsentTypeID, OOT1000.Description AS AbsentTypeName,
		OOT21.ShiftID, OOT21.OldShiftID,
		OOT21.LeaveFromDate, OOT21.LeaveToDate, OOT21.TotalTime, OOT21.Status AS DetailStatus, O91.Description AS DetailStatusName,--- Trang thai duyet cua tung nhan vien
		OOT21.Note, OOT21.DeleteFlag,
		0.0 OffsetTime, 0.0 AS TimeAllowance,0.0 OvertTime,0.0 OvertTimeNN,0.0 OvertTimeCompany, 0 AS FormStatus,
		OOT21.FromWorkingDate, OOT21.ToWorkingDate, OOT21.IsNextDay, ISNULL(OOT21.IsValid,0) AS IsValid, ISNULL(OOT21.TotalDay,0) AS TotalDay,
		OOT21.IsSeri
INTO #OOT2010	
FROM OOT2010 OOT21 WITH (NOLOCK)
INNER JOIN OOT9000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = '''+@DivisionID+''' AND OOT00.Type=''DXP'' AND OOT00.APK = ''' + @APKMaster + ''' AND OOT21.DivisionID = OOT00.DivisionID AND OOT21.APKMaster = OOT00.APK
LEFT JOIN OOT9001 OOT90 WITH (NOLOCK) ON OOT21.DivisionID = OOT90.DivisionID AND OOT21.APK = OOT90.APKDetail
LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=OOT00.DepartmentID 
LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT00.DivisionID AND A12.TeamID=OOT00.SectionID AND OOT00.DepartmentID = A12.DepartmentID
LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID=OOT90.DivisionID AND HT14.EmployeeID=OOT90.ApprovePersonID
LEFT JOIN HT1400 HT15 WITH (NOLOCK) ON HT15.DivisionID=OOT21.DivisionID AND HT15.EmployeeID=OOT21.EmployeeID
LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT90.Status,0) AND O99.CodeMaster=''Status''
--LEFT JOIN OOT0099 O90 WITH (NOLOCK) ON O90.ID1=ISNULL(OOT00.Status,0) AND O90.CodeMaster=''Status''
LEFT JOIN OOT0099 O91 WITH (NOLOCK) ON O91.ID1=ISNULL(OOT21.Status,0) AND O91.CodeMaster=''Status''
LEFT JOIN AT1405 A051 WITH (NOLOCK) ON A051.UserID = OOT00.CreateUserID
LEFT JOIN AT1405 A052 WITH (NOLOCK) ON A052.UserID = OOT00.LastModifyUserID
LEFT JOIN OOT1000 WITH (NOLOCK) ON OOT1000.DivisionID=OOT21.DivisionID AND OOT21.AbsentTypeID=OOT1000.AbsentTypeID
'

SET @sSQL1='
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, BT.*
FROM
(
SELECT	APK, DivisionID, CreateUserName, TranMonth, TranYear, ID, Description, DepartmentID, SectionID, DepartmentName, SectionName,		
		ApproveLevel, ApprovingLevel, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,
		APKDetail, EmployeeID, EmployeeName, Reason, AbsentTypeID, AbsentTypeName, ShiftID, OldShiftID,
		LeaveFromDate, LeaveToDate, TotalTime, DetailStatus, DetailStatusName, Note, DeleteFlag, OffsetTime, TimeAllowance, OvertTime,
		OvertTimeCompany, FormStatus, FromWorkingDate, ToWorkingDate, IsNextDay, IsValid, IsSeri, TotalDay,
		
		MAX(CASE WHEN Level = 1 THEN ApprovePersonID ELSE NULL END) AS ApprovePerson01ID,
		MAX(CASE WHEN Level = 1 THEN ApprovePersonID ELSE NULL END) AS ApprovePerson01,
		MAX(CASE WHEN Level = 1 THEN ApprovePersonName ELSE NULL END) AS ApprovePerson01Name,
		MAX(CASE WHEN Level = 1 THEN ApprovePersonStatus ELSE NULL END) AS ApprovePerson01Status,
		MAX(CASE WHEN Level = 1 THEN ApprovePersonStatusName ELSE NULL END) AS ApprovePerson01StatusName,
		MAX(CASE WHEN Level = 1 THEN ApprovePersonNote ELSE NULL END) AS ApprovePerson01Notes,
		
		MAX(CASE WHEN Level = 2 THEN ApprovePersonID ELSE NULL END) AS ApprovePerson02ID,
		MAX(CASE WHEN Level = 2 THEN ApprovePersonID ELSE NULL END) AS ApprovePerson02,
		MAX(CASE WHEN Level = 2 THEN ApprovePersonName ELSE NULL END) AS ApprovePerson02Name,
		MAX(CASE WHEN Level = 2 THEN ApprovePersonStatus ELSE NULL END) AS ApprovePerson02Status,
		MAX(CASE WHEN Level = 2 THEN ApprovePersonStatusName ELSE NULL END) AS ApprovePerson02StatusName,
		MAX(CASE WHEN Level = 2 THEN ApprovePersonNote ELSE NULL END) AS ApprovePerson02Notes,
		
		MAX(CASE WHEN Level = 3 THEN ApprovePersonID ELSE NULL END) AS ApprovePerson03ID,
		MAX(CASE WHEN Level = 3 THEN ApprovePersonID ELSE NULL END) AS ApprovePerson03,
		MAX(CASE WHEN Level = 3 THEN ApprovePersonName ELSE NULL END) AS ApprovePerson03Name,
		MAX(CASE WHEN Level = 3 THEN ApprovePersonStatus ELSE NULL END) AS ApprovePerson03Status,
		MAX(CASE WHEN Level = 3 THEN ApprovePersonStatusName ELSE NULL END) AS ApprovePerson03StatusName,
		MAX(CASE WHEN Level = 3 THEN ApprovePersonNote ELSE NULL END) AS ApprovePerson03Notes
FROM #OOT2010
GROUP BY APK, DivisionID, CreateUserName, TranMonth, TranYear, ID, Description, DepartmentID, SectionID, DepartmentName, SectionName,
		ApproveLevel, ApprovingLevel, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,
		APKDetail, EmployeeID, EmployeeName, Reason, AbsentTypeID, AbsentTypeName, ShiftID, OldShiftID,
		LeaveFromDate, LeaveToDate, TotalTime, DetailStatus, DetailStatusName, Note, DeleteFlag, OffsetTime, TimeAllowance, OvertTime,
		OvertTimeCompany, FormStatus, FromWorkingDate, ToWorkingDate, IsNextDay, IsValid, IsSeri, TotalDay
)BT
		
ORDER BY '+@OrderBy+' '+@sSQL2
	
EXEC (@sSQL+@sSQL1)
--PRINT(@sSQL)
--PRINT(@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO