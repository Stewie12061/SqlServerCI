IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo Inactive
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 17/03/2016
 ----Modified by Bảo Thy on 08/09/2016: Thông tin Khối, Phòng lấy từ danh mục Phòng ban, Tổ nhóm
 /*-- <Example>
 	OOP3021 @DivisionID='MK',@UserID='ASOFTADMIN',@FromDate = '2016-04-14 10:08:03.077', @ToDate= '2016-12-31 19:08:03.077',@DepartmentID ='A000000', @SectionID = null,
 	@SubsectionID = null,@ProcessID = null
 ----*/
CREATE PROCEDURE OOP3021
(
 @DivisionID VARCHAR(50),
 @UserID VARCHAR(50),
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50)
) 
AS
----Dữ liệu thay đồi trong khoảng thời gian lọc	
 SELECT Distinct  ROW_NUMBER() OVER (ORDER BY HT14.EmployeeID) AS [No], HT14.DivisionID, HT14.EmployeeID, HT14.EmployeeMode,
T2.FullName AS EmployeeName, T2.DepartmentName, T2.DutyID AS TitleID, T2.TEAMID, T2.Ana04ID, T2.Ana05ID, CONVERT(DATE, HT14.BeginDate,120) BeginDate, CONVERT(DATE, HT14.EndDate,120) EndDate,ISNULL(CONVERT(DATE,LeaveDate,120),CONVERT(DATE,LeaveToDate,120)) LeaveDate,
MAX(ISNULL(T2.LastModifyDate,@ToDate)) LastModifyDate,
ISNULL(T2.DepartmentName,'') AS DepartmentName,ISNULL(T2.TeamName,'') AS SectionName, 
ISNULL(T3.AnaName,'') AS SubsectionName, ISNULL(T4.AnaName,'') AS ProcessName, ISNULL(DutyName,'') TitleName
FROM HT1414 HT14
LEFT JOIN HV1400 T2 WITH (NOLOCK) ON HT14.DivisionID = T2.DivisionID AND HT14.EmployeeID = T2.EmployeeID
LEFT JOIN AT1011 T3 WITH (NOLOCK) ON HT14.DivisionID = T3.DivisionID AND T2.Ana04ID = T3.AnaID AND T3.AnaTypeID = 'A04'
LEFT JOIN AT1011 T4 WITH (NOLOCK) ON HT14.DivisionID = T4.DivisionID AND T2.Ana04ID = T4.AnaID AND T4.AnaTypeID = 'A05'
WHERE HT14.DivisionID = @DivisionID
	 AND ( (CONVERT(DATE,HT14.BeginDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
			OR CONVERT(DATE,HT14.EndDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate) )
		OR (CONVERT(DATE,@FromDate) BETWEEN CONVERT(DATE,HT14.BeginDate) AND CONVERT(DATE,HT14.EndDate)
			OR CONVERT(DATE,@ToDate) BETWEEN CONVERT(DATE,HT14.BeginDate) AND CONVERT(DATE,HT14.EndDate))
		OR ((CONVERT(DATE,HT14.BeginDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
			AND CONVERT(DATE,HT14.EndDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate) ))
		)
	 AND ISNULL(T2.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(T2.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(T2.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(T2.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
	 AND ISNULL(HT14.EmployeeMode,'') <> ''
	 AND T2.EmployeeStatus in (0,1,2)
 GROUP BY HT14.EmployeeMode, HT14.DivisionID, HT14.EmployeeID, T2.Fullname,T2.DepartmentID,T2.TEAMID,T2.Ana04ID,T2.Ana05ID, 
T2.DutyID,LeaveDate,HT14.BeginDate,HT14.EndDate,LeaveToDate,T2.DepartmentName,T2.TeamName,T3.AnaName,T4.AnaName,DutyName
ORDER BY [No]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
