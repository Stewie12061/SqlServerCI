IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo working list
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 17/03/2016
 ----Modified by Bảo Thy on 08/09/2016: Thông tin Khối, Phòng lấy từ danh mục Phòng ban, Tổ nhóm
 ----Modified by Vĩnh Tâm on 26/10/2020: Cập nhật tên bảng tạm để tránh xảy ra lỗi trùng bảng tạm khi chạy fix
 /*-- <Example>
 	OOP3023 @DivisionID='MK',@FromDate = '2016-10-01', @ToDate= '2016-10-31',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3023
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
CREATE TABLE  #TableMode (EmployeeID VARCHAR(50),  Mode VARCHAR(50),EmployeeStatusName Nvarchar(250), [Type] NVARCHAR(250), [Month] VARCHAR(50),
E_WorkingType NVARCHAR(250),FromDate DATETIME, ToDate DATETIME
)
INSERT #TableMode
EXEC OOP3014 @DivisionID,@FromDate, @ToDate,@DepartmentID, @SectionID,@SubsectionID,@ProcessID,@StatusID='%'

select * from #TableMode order by employeeid
----Dữ liệu thay đồi trong khoảng thời gian lọc	

SELECT 
FromDate, MAX(ISNULL(HT40.LastModifyDate, @ToDate)) LastModifyDate, HT40.DivisionID, HT40.EmployeeID, 
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, 
ISNULL(HT40.DepartmentID,'') AS DepartmentID, 
ISNULL(HT40.TEAMID, '') AS TeamID, ISNULL(HT40.Ana04ID, '') AS Ana04ID,ISNULL(HT40.Ana05ID,'') AS Ana05ID,
(CASE Mode WHEN  'MT' THEN 'MT'
	WHEN 'LT' THEN 'LT'
	WHEN  'WW' THEN 'WW'
	WHEN  'TO' THEN 'TO' ELSE '0' END) AS Inactive, (CASE Mode WHEN  'PR' THEN 'PR' WHEN 'CR' THEN 'CR' ELSE '0' END) PRCR,
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as Sex
INTO #HT1400_CT
FROM  HT1400_CT HT40 
LEFT JOIN #TableMode ON HT40.EmployeeID = #TableMode.EmployeeID
WHERE HT40.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT40.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
	 --AND FromDate <= @ToDate
	 AND HT40.EmployeeStatus IN (0, 1, 2) AND HT40.Operation <> 1
 GROUP BY HT40.DivisionID,HT40.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName, Mode,IsMale, HT40.DepartmentID,HT40.TEAMID,HT40.Ana04ID,HT40.Ana05ID,FromDate

--SELECT 
--FromDate, HT40.DivisionID, HT40.EmployeeID, 
--Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, 
--HT40.DepartmentID, 
--'' AS TEAMID, '' AS Ana04ID,'' AS Ana05ID, '' AS TitleID, NULL AS WorkDate,
--(CASE Mode WHEN  'MT' THEN 'MT'
--	WHEN 'LT' THEN 'LT'
--	WHEN  'WW' THEN 'WW'
--	WHEN  'TO' THEN 'TO' ELSE '0' END) AS Inactive, (CASE Mode WHEN  'PR' THEN 'PR' WHEN 'CR' THEN 'CR' ELSE '0' END) PRCR,
--(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as Sex, '' AS EducationLevelID,
--MAX(ISNULL(HT40.LastModifyDate, @ToDate)) LastModifyDate, 1 AS Original
--INTO #TempOOP3023_1
--FROM  HT1400_CT HT40 
----LEFT JOIN HT1403_CT  ON HT1403_CT.ReAPK = HT40.ReAPK AND HT40.EmployeeID = HT1403_CT.EmployeeID AND HT1403_CT.Operation IN (2, 3) AND HT40.Operation IN (2, 3)
----LEFT JOIN HT1401_CT HT41 ON HT40.ReAPK = HT41.ReAPK AND HT40.EmployeeID = HT41.EmployeeID AND HT41.Operation IN (2, 3) AND HT40.Operation IN (2, 3)
--LEFT JOIN #TableMode ON HT40.EmployeeID = #TableMode.EmployeeID
--WHERE HT40.DivisionID = @DivisionID
--	 AND CONVERT(DATE,ISNULL(HT40.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
--	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
--	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
--	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
--	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
--	 AND FromDate <= @ToDate
--	 AND HT40.EmployeeStatus IN (0, 1, 2) --OR  HT1403_CT.EmployeeStatus IN (0, 1, 2) 
-- GROUP BY HT40.DivisionID,HT40.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName, Mode,IsMale, HT40.DepartmentID,FromDate
 --EducationLevelID,TitleID,
 --HT1403_CT.WorkDate,

 select * from #HT1400_CT order by employeeid
 -----Trước khoảng thời gian lọc
 SELECT HT40.DivisionID, HT40.EmployeeID, 
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, HT40.DepartmentID, 
HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID, TitleID,WorkDate,
(CASE Mode WHEN  'MT' THEN 'MT'
	WHEN 'LT' THEN 'LT'
	WHEN 'WW' THEN 'WW'
	WHEN 'TO' THEN 'TO' ELSE '0' END) AS Inactive, (CASE Mode WHEN  'PR' THEN 'PR' WHEN 'CR' THEN 'CR' ELSE '0' END) PRCR,
 (Case When IsMale = 1 then N'Nam' else N'Nữ' End) as Sex, EducationLevelID,
MAX(ISNULL(HT40.LastModifyDate, @ToDate)) LastModifyDate
INTO #TempOOP3023_2
FROM  HT1400_CT HT40 
LEFT JOIN   HT1403_CT  ON HT1403_CT.ReAPK = HT40.ReAPK AND HT40.EmployeeID = HT1403_CT.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT40.ReAPK = HT41.ReAPK AND HT40.EmployeeID = HT41.EmployeeID
LEFT JOIN #TableMode ON HT40.EmployeeID = #TableMode.EmployeeID
WHERE HT40.DivisionID = @DivisionID
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
	 AND FromDate < @ToDate
	 AND HT40.EmployeeStatus IN (0, 1, 2) OR  HT1403_CT.EmployeeStatus IN (0, 1, 2) 
 GROUP BY HT40.DivisionID,HT40.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID,HT40.Ana04ID,HT40.Ana05ID, Mode,
 IsMale, EducationLevelID,TitleID,WorkDate

 
INSERT INTO #TempOOP3023_1 (EmployeeID, Original)
SELECT DISTINCT EmployeeID,0 FROM #TempOOP3023_2
WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TempOOP3023_1 WHERE #TempOOP3023_1.EmployeeID = #TempOOP3023_2.EmployeeID)

UPDATE T1
SET T1.DivisionID = T2.DivisionID,
	T1.EmployeeName = T2.EmployeeName,
	T1.DepartmentID = T2.DepartmentID,
	T1.TEAMID = T2.TEAMID,
	T1.TitleID = T2.TitleID,
	T1.WorkDate = T2.WorkDate,
	T1.Ana04ID = T2.Ana04ID,
	T1.Ana05ID = T2.Ana05ID,
	T1.Inactive = T2.Inactive,
	T1.PRCR = T2.PRCR,
	T1.Sex = T2.Sex,
	T1.EducationLevelID = T2.EducationLevelID,
	T1.LastModifyDate = T2.LastModifyDate
FROM #TempOOP3023_1 T1
LEFT JOIN #TempOOP3023_2 T2 ON T1.EmployeeID = T2.EmployeeID
LEFT JOIN 
(	SELECT MAX(LastModifyDate) LastModifyDate,EmployeeID 
	FROM #TempOOP3023_2 
	GROUP BY EmployeeID
) T3 ON T1.EmployeeID = T3.EmployeeID 
WHERE ISNULL(Original,0) <> 1
AND T2.LastModifyDate = T3.LastModifyDate

SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T.EmployeeID) AS RowNum,T.EmployeeID, T.EmployeeName,WorkDate,A11.DepartmentName,A12.TeamName AS SectionName,
 A13.AnaName AS SubsectionName, A14.AnaName AS ProcessName,TitleName, Inactive, PRCR,'' TerminatePlan,T.Sex, EducationLevelName,T.LastModifyDate
FROM #TempOOP3023_1 T
LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DivisionID = T.DivisionID AND A11.DepartmentID=T.DepartmentID 
LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A11.DivisionID = T.DivisionID AND A12.TeamID=T.TEAMID AND A12.DepartmentID = T.DepartmentID 
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A11.DivisionID = T.DivisionID AND A13.AnaID=T.Ana04ID AND A13.AnaTypeID='A04'
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A11.DivisionID = T.DivisionID AND A14.AnaID=T.Ana05ID AND A14.AnaTypeID='A05'
LEFT JOIN HT1005 WITH (NOLOCK) ON HT1005.DivisionID = T.DivisionID AND HT1005.EducationLevelID = T.EducationLevelID
LEFT JOIN HT1106 WITH (NOLOCK) ON HT1106.DivisionID = T.DivisionID AND HT1106.TitleID = T.TitleID

DROP TABLE #TempOOP3023_1
DROP TABLE #TempOOP3023_2
DROP TABLE #TableMode

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
