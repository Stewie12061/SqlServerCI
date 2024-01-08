IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo phân loại nhân viên theo bộ phận
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 14/03/2016
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 ---- Modified by Vĩnh Tâm on 26/10/2020: Cập nhật tên bảng tạm để tránh xảy ra lỗi trùng bảng tạm khi chạy fix
 /*-- <Example>
 	OOP3012 @DivisionID='MK', @FromDate = '2016-03-01 00:00:00.000', @ToDate= '2016-04-24 00:00:00.000',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@CountryID='%' 
 ----*/
CREATE PROCEDURE OOP3012
( 
 @DivisionID VARCHAR(50),
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50),
 @CountryID VARCHAR(50)
)
AS
CREATE TABLE #Department (AnaID VARCHAR(50), AnaName NVARCHAR(250))
INSERT INTO #Department
SELECT DepartmentID, DepartmentName FROM AT1102 WHERE DivisionID in (@DivisionID,'@@@') AND [Disabled] = 0


CREATE TABLE #OOP3012 (Column1 Nvarchar(250), EmployeeID VARCHAR(50),  [Month] VARCHAR(10),
  DepartmentID VARCHAR(50),DepartmentName NVARCHAR(250),LastModifyDate DATETIME)

 
SELECT DISTINCT HT1400_CT.DivisionID, EmployeeID,DepartmentID, ISNULL(LastModifyDate,@ToDate) LastModifyDate, CountryID
INTO #TempOOP3012_1
FROM HT1400_CT
WHERE DivisionID = @DivisionID
	 --AND CONVERT(DATE,ISNULL(MAX(LastModifyDate),@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(CountryID,'') LIKE ISNULL(@CountryID,'%')
	 AND ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9)
GROUP BY  DivisionID,EmployeeID , DepartmentID,CountryID,LastModifyDate
HAVING CONVERT(DATE,ISNULL(MAX(LastModifyDate),@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
 
 
SELECT DISTINCT HT1400_CT.DivisionID, HT1400_CT.EmployeeID,HT1400_CT.DepartmentID, HT1400_CT.LastModifyDate LastModifyDate, HT1400_CT.CountryID
INTO #TempOOP3012_2
FROM HT1400_CT
INNER JOIN (SELECT ISNULL( MAX(LastModifyDate),@FromDate) LastModifyDate,EmployeeID 
            FROM HT1400_CT
            WHERE CONVERT(DATE,ISNULL(LastModifyDate,@ToDate)) < CONVERT(DATE,@FromDate)
            AND HT1400_CT.EmployeeStatus NOT IN (3,9)
            GROUP BY EmployeeID
		)A ON A.EmployeeID=HT1400_CT.EmployeeID AND A.LastModifyDate=HT1400_CT.LastModifyDate
WHERE  HT1400_CT.DivisionID =@DivisionID
	AND ISNULL(HT1400_CT.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT1400_CT.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT1400_CT.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT1400_CT.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(HT1400_CT.CountryID,'') LIKE ISNULL(@CountryID,'%')
	 AND ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9)
	 AND NOT EXISTS (SELECT TOP 1 1 FROM #TempOOP3012_1 WHERE #TempOOP3012_1.EmployeeID = HT1400_CT.EmployeeID AND  #TempOOP3012_1.DepartmentID = HT1400_CT.DepartmentID)
 
 
--BEGIN WITH TEMP AS
--(----Dữ liệu thay đồi bộ phận trong khoảng thời gian lọc	
--SELECT DISTINCT HT1400_CT.DivisionID, EmployeeID,DepartmentID, ISNULL(LastModifyDate,@ToDate) LastModifyDate, CountryID
--FROM HT1400_CT
--WHERE DivisionID = @DivisionID
--	 --AND CONVERT(DATE,ISNULL(MAX(LastModifyDate),@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
--	AND ISNULL(DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
--	 AND ISNULL(TEAMID,'') LIKE ISNULL(@SectionID,'%') 
--	 AND ISNULL(Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
--	 AND ISNULL(Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
--	 AND ISNULL(CountryID,'') LIKE ISNULL(@CountryID,'%')
--	 AND ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9)
--GROUP BY  DivisionID,EmployeeID , DepartmentID,CountryID,LastModifyDate
--HAVING CONVERT(DATE,ISNULL(MAX(LastModifyDate),@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)

--UNION ALL
------Dữ liệu thay đồi bộ phận trước khoảng thời gian lọc	
--SELECT DISTINCT HT1400_CT.DivisionID, HT1400_CT.EmployeeID,DepartmentID, HT1400_CT.LastModifyDate LastModifyDate, CountryID
--FROM HT1400_CT
--INNER JOIN (SELECT ISNULL( MAX(LastModifyDate),@FromDate) LastModifyDate,EmployeeID 
--            FROM HT1400_CT
--            WHERE CONVERT(DATE,ISNULL(LastModifyDate,@ToDate)) < CONVERT(DATE,@FromDate)
--            AND HT1400_CT.EmployeeStatus NOT IN (3,9)
--            GROUP BY EmployeeID
--		)A ON A.EmployeeID=HT1400_CT.EmployeeID AND A.LastModifyDate=HT1400_CT.LastModifyDate
--WHERE  DivisionID =@DivisionID
--	AND ISNULL(DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
--	 AND ISNULL(TEAMID,'') LIKE ISNULL(@SectionID,'%') 
--	 AND ISNULL(Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
--	 AND ISNULL(Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
--	 AND ISNULL(CountryID,'') LIKE ISNULL(@CountryID,'%')
--	 AND ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9)
--) 

INSERT INTO #OOP3012

SELECT DISTINCT '' Column1, T.EmployeeID, 
 LEFT(ISNULL(DATENAME(mm,T.LastModifyDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LastModifyDate)),''),2) [Month],
 T.DepartmentID,  A11.DepartmentName,T.LastmodifyDate
FROM #TempOOP3012_1 T
LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID
INNER JOIN (SELECT MAX(T1.LastModifyDate) LastModifyDate,T1.EmployeeID 
            FROM #TempOOP3012_1 T1
            LEFT JOIN #TempOOP3012_1 T2 ON T1.EmployeeID = T2.EmployeeID
            WHERE DATENAME(mm,T1.LastModifyDate) = DATENAME(mm,T2.LastModifyDate)
            GROUP BY T1.EmployeeID,T1.LastModifyDate
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate = T.LastModifyDate
		
UNION ALL

SELECT DISTINCT '' Column1, T.EmployeeID, 
 LEFT(ISNULL(DATENAME(mm,T.LastModifyDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LastModifyDate)),''),2) [Month],
 T.DepartmentID,  A11.DepartmentName,T.LastmodifyDate
FROM #TempOOP3012_2 T
LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID 
INNER JOIN (SELECT MAX(T1.LastModifyDate) LastModifyDate,T1.EmployeeID 
            FROM #TempOOP3012_2 T1
            LEFT JOIN #TempOOP3012_2 T2 ON T1.EmployeeID = T2.EmployeeID
            WHERE DATENAME(mm,T1.LastModifyDate) = DATENAME(mm,T2.LastModifyDate)
            GROUP BY T1.EmployeeID,T1.LastModifyDate
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate = T.LastModifyDate	
ORDER BY [Month]
--END

------
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3012a (Column1 NVARCHAR(250),EmployeeID VARCHAR(50), [Month] VARCHAR(50),DepartmentID VARCHAR(50), DepartmentName NVARCHAR(250),--LastModifyDate DATETIME,
Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3012a
	SELECT DISTINCT '' Column1, EmployeeID,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day),112),2) [Month], NULL, NULL,--LastModifyDate,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate
	FROM #OOP3012 
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END

UPDATE t1
	SET t1.DepartmentID = t2.DepartmentID, t1.DepartmentName = t2.DepartmentName
	FROM #OOP3012a t1
	inner JOIN 	#OOP3012 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(VARCHAR(10),t2.LastModifyDate,112) <=  CONVERT(VARCHAR(10),t1.ToDate,112)
----insert những bộ phận không có nhân viên
DECLARE @Cur CURSOR,
		@Department_ID VARCHAR(50),
		@Department_Name NVARCHAR(250)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT AnaID, AnaName
FROM #Department

OPEN @Cur
FETCH NEXT FROM @Cur INTO @Department_ID, @Department_Name
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF @Department_ID NOT IN (SELECT DISTINCT DepartmentID FROM #OOP3012a)
	BEGIN
		INSERT INTO #OOP3012a
		VALUES ( '', NULL, LEFT(DATENAME(mm,@ToDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@ToDate),112),2), @Department_ID, @Department_Name, @FromDate, @ToDate)
	END
			 	
FETCH NEXT FROM @Cur INTO  @Department_ID, @Department_Name
END 
Close @Cur	

SELECT * FROM #OOP3012a ORDER BY MONTH(FromDate), EmployeeID, DepartmentID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO