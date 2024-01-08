IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo Oversea Staff
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 17/03/2016
 ----Modified by Bảo Thy on 08/09/2016: Thông tin Khối, Phòng lấy từ danh mục Phòng ban, Tổ nhóm
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 ---- Modified by Vĩnh Tâm on 26/10/2020: Cập nhật tên bảng tạm để tránh xảy ra lỗi trùng bảng tạm khi chạy fix
 /*-- <Example>
 	OOP3022 @DivisionID='MK',@FromDate = '2016-10-01', @ToDate= '2016-10-31',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3022
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
--SELECT * from HT1400_CT Order by employeeid
--SELECT * from HT1403_CT Order by employeeid

---- Trong thời gian lọc
SELECT DISTINCT HT40.DivisionID, HT40.EmployeeID, 
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ' '+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ' '+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, HT40.DepartmentID, 
HT40.TEAMID, HT1403_CT.TitleID, HT40.Notes, MAX(ISNULL(HT1403_CT.LastModifyDate, @ToDate)) LastModifyDate,CountryID, 1 AS Original
INTO #TempOOP3022_1
FROM  HT1400_CT HT40 
LEFT JOIN   HT1403_CT  ON HT1403_CT.ReAPK = HT40.ReAPK AND HT40.EmployeeID = HT1403_CT.EmployeeID
WHERE HT40.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
 AND HT1403_CT.Operation <> 4
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
 GROUP BY HT40.DivisionID,HT40.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID,HT1403_CT.TitleID,HT40.Notes,CountryID
 --,HT1403_CT.Operation



---- Trước thời gian lọc
SELECT DISTINCT HT40.DivisionID,  HT40.EmployeeID, 
Ltrim(RTrim(isnull(HT40.LastName,' ')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ' '+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, HT40.DepartmentID, 
HT40.TEAMID, HT1403_CT.TitleID, HT40.Notes,MAX(HT1403_CT.LastModifyDate) LastModifyDate ,CountryID
INTO #TempOOP3022_2
FROM  HT1400_CT HT40 
LEFT JOIN   HT1403_CT  ON HT1403_CT.ReAPK = HT40.ReAPK AND HT40.EmployeeID = HT1403_CT.EmployeeID
WHERE HT40.DivisionID = @DivisionID
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND HT1403_CT.LastModifyDate < @FromDate 
	 AND HT1403_CT.Operation <> 4
GROUP BY HT40.DivisionID,HT40.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID,HT1403_CT.TitleID,HT40.Notes,CountryID


INSERT INTO #TempOOP3022_1 (EmployeeID, Original)
SELECT DISTINCT EmployeeID,0 FROM #TempOOP3022_2
WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TempOOP3022_1 WHERE #TempOOP3022_1.EmployeeID = #TempOOP3022_2.EmployeeID)


UPDATE T1
SET T1.DivisionID = T2.DivisionID,
	T1.EmployeeName = T2.EmployeeName,
	T1.DepartmentID = T2.DepartmentID,
	T1.TEAMID = T2.TEAMID,
	T1.TitleID = T2.TitleID,
	T1.Notes = T2.Notes,
	T1.LastModifyDate = T2.LastModifyDate,
	T1.CountryID = T2.CountryID
FROM #TempOOP3022_1 T1
LEFT JOIN #TempOOP3022_2 T2 ON T1.EmployeeID = T2.EmployeeID
LEFT JOIN 
(SELECT MAX(LastModifyDate) LastModifyDate,EmployeeID 
FROM #TempOOP3022_2 
GROUP BY EmployeeID) T3 ON T1.EmployeeID = T3.EmployeeID 
WHERE ISNULL(Original,0) <> 1
AND T2.LastModifyDate = T3.LastModifyDate

SELECT T.*,A11.DepartmentName AS DepartmentName, TitleName FROM #TempOOP3022_1 T
LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID
LEFT JOIN HT1106 HT16 ON HT16.TitleID = T.TitleID 
WHERE T.CountryID <> 'VN'
ORDER BY employeeid

DROP TABLE #TempOOP3022_1
DROP TABLE #TempOOP3022_2

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
