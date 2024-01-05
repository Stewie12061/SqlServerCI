IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load danh sách nhân viên bất thường
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 18/02/2016
 ---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 /*-- <Example>
 	OOP3003 @FromDate = '2016-06-01', @ToDate= '2016-06-30',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3003
( 
 @FromDate Date,
 @ToDate Date,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50)
)
AS

SELECT ROW_NUMBER() OVER (ORDER BY HV1400.DepartmentID,OOT26.EmployeeID) AS STT, OOT26.EmployeeID, HV1400.FullName EmployeeName, HV1400.DepartmentID, HV1400.DepartmentName, 
 		ISNULL(TEAMID,'') SectionID, HV1400.TeamName SectionName, ISNULL(Ana04ID,'') SubsectionID, A13.AnaName SubsectionName,
 		ISNULL(Ana05ID,'') ProcessID, A14.AnaName ProcessName, 
		STUFF(( SELECT ', ' + convert(varchar,OOT2060.[Date],103)
				 FROM OOT2060 
				WHERE OOT2060.EmployeeID = OOT26.EmployeeID
				AND CONVERT(DATE,OOT2060.[Date]) BETWEEN @FromDate AND @ToDate
		        GROUP BY OOT2060.[Date]
				ORDER BY OOT2060.[Date]
		FOR XML PATH('')),1,1,'') UnusualDate, COUNT(OOT26.EmployeeID) as Times
FROM OOT2060 OOT26
LEFT JOIN HV1400 ON OOT26.EmployeeID = HV1400.EmployeeID
--LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HV1400.DepartmentID 
--LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = HV1400.DivisionID AND A12.TeamID=HV1400.TeamID
LEFT JOIN AT1011 A13 ON A13.AnaID=HV1400.Ana04ID AND A13.AnaTypeID='A04'
LEFT JOIN AT1011 A14 ON A14.AnaID=HV1400.Ana05ID AND A14.AnaTypeID='A05'
WHERE HV1400.StatusID IN (0,1,2,4)
 AND HV1400.DepartmentID  LIKE ISNULL(@DepartmentID,'%')
 AND ISNULL(HV1400.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
 AND ISNULL(HV1400.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
 AND ISNULL(HV1400.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
 AND CONVERT(DATE,OOT26.[Date]) BETWEEN @FromDate AND @ToDate
GROUP BY HV1400.DepartmentID,OOT26.EmployeeID, FullName, TEAMID, Ana04ID, Ana05ID,HV1400.DepartmentName, HV1400.TeamName,  A13.AnaName, A14.AnaName
ORDER BY STT

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO