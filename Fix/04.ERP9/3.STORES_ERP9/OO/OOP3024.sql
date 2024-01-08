IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo NewCommer
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 23/03/2016
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 /*-- <Example>
 	OOP3024 @DivisionID='MK',@FromDate = '2016-03-01 10:08:03.077', @ToDate= '2016-03-28 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3024
(
 @DivisionID VARCHAR(50), 
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50)
) 
AS
BEGIN WITH TEMP AS 
(----Dữ liệu thay đồi trong khoảng thời gian lọc	
 SELECT HT43.DivisionID, HT43.EmployeeID, CONVERT(date,ISNULL(HT43.WorkDate,@ToDate)) WorkDate,
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, 
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as IsMaleName, DATEDIFF(yy,Birthday,GETDATE()) Age ,HT40.DepartmentID, ISNULL(SalaryLevel,'') SalaryLevel, 
TitleID, EducationLevelID, CONVERT(date,ISNULL(HT43.LeaveDate,@ToDate)) LeaveDate,MAX(ISNULL(HT43.LastModifyDate,@ToDate)) LastModifyDate
 FROM HT1403_CT HT43 
LEFT JOIN   HT1400_CT HT40 ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
WHERE HT43.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT43.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND CONVERT(DATE,ISNULL(HT43.WorkDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
 GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,SalaryLevel,Birthday,WorkDate,
 TitleID,LeaveDate,EducationLevelID,HT43.LastModifyDate,IsMale

UNION ALL
	
SELECT HT43.DivisionID, HT43.EmployeeID, CONVERT(date,ISNULL(HT43.WorkDate,@ToDate)) WorkDate,
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, 
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as IsMaleName,  DATEDIFF(yy,Birthday,GETDATE()) Age ,HT40.DepartmentID, ISNULL(SalaryLevel,'') SalaryLevel, 
TitleID, EducationLevelID, CONVERT(date,ISNULL(HT43.LeaveDate,@ToDate)) LeaveDate,ISNULL(HT43.LastModifyDate,@ToDate) LastModifyDate
 FROM HT1403_CT HT43 
LEFT JOIN   HT1400_CT HT40 ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
INNER JOIN (SELECT MAX(ISNULL(LastModifyDate,@ToDate)) LastModifyDate,EmployeeID 
            FROM HT1403_CT
            WHERE CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate, @ToDate)) < CONVERT(DATE,@FromDate)
            GROUP BY EmployeeID
		)A ON A.EmployeeID= HT43.EmployeeID AND A.LastModifyDate=HT43.LastModifyDate
WHERE HT43.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT43.WorkDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
 GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,SalaryLevel,Birthday,WorkDate,
 TitleID,LeaveDate,EducationLevelID,HT43.LastModifyDate,IsMale
)

SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T.EmployeeID) AS [No],T.EmployeeID, ISNULL(T.WorkDate,'') WorkDate, T.EmployeeName, T.IsMaleName, T.Age, 
A11.DepartmentName,T.SalaryLevel,TitleName, ISNULL(EducationLevelName,'')  EducationLevelName, ISNULL(T.LeaveDate,'') LeaveDate
FROM TEMP T
LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID 
LEFT JOIN HT1106 ON HT1106.DivisionID = T.DivisionID AND HT1106.TitleID = T.TitleID
LEFT JOIN HT1005 ON HT1005.DivisionID = T.DivisionID AND HT1005.EducationLevelID = T.EducationLevelID
INNER JOIN (SELECT MAX(LastModifyDate) LastModifyDate,EmployeeID 
            FROM TEMP
            GROUP BY EmployeeID
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
ORDER BY WorkDate
END 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
