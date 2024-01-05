IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo phân loại nhân viên nghỉ việc theo bộ phận
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 16/03/2016
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 /*-- <Example>
 	OOP3017 @DivisionID='MK', @FromDate = '2016-01-01 00:00:00.000', @ToDate= '2016-03-28 00:00:00.000',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%' 
 ----*/
CREATE PROCEDURE OOP3017
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
CREATE TABLE #Department (AnaID VARCHAR(50), AnaName NVARCHAR(250))
INSERT INTO #Department
SELECT DepartmentID, DepartmentName FROM AT1102 WHERE DivisionID in (@DivisionID,'@@@') AND [Disabled] = 0

CREATE TABLE #OOP3017 (EmployeeID VARCHAR(50),  [Month] VARCHAR(10),
  DepartmentID VARCHAR(50),DepartmentName NVARCHAR(250),Column1 Nvarchar(250), LastModifyDate DATETIME)

BEGIN WITH TEMP AS
(
----Dữ liệu thay đồi bộ phận trong khoảng thời gian lọc	
select HT1403_CT.DivisionID, HT1403_CT.ReAPK, HT1403_CT.EmployeeID,HT1403_CT.DepartmentID, LeaveDate,Max(ISNULL(HT1403_CT.LastModifyDate,@ToDate)) LastModifyDate
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK AND HT1403_CT.EmployeeID = HT40.EmployeeID
WHERE HT1403_CT.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LeaveDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND HT1403_CT.EmployeeStatus = 9 
GROUP BY  HT1403_CT.DivisionID,HT1403_CT.EmployeeID ,HT1403_CT.ReAPK, HT1403_CT.DepartmentID,LeaveDate

UNION ALL
----Dữ liệu thay đồi bộ phận trước khoảng thời gian lọc	
SELECT   HT1403_CT.DivisionID, HT1403_CT.ReAPK, HT1403_CT.EmployeeID,HT1403_CT.DepartmentID, LeaveDate,ISNULL(HT1403_CT.LastModifyDate,@ToDate) LastModifyDate
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK AND HT1403_CT.EmployeeID = HT40.EmployeeID
INNER JOIN (SELECT MAX(ISNULL(HT1403_CT.LastModifyDate,@ToDate)) LastModifyDate,EmployeeID 
            FROM HT1403_CT
            WHERE CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate,@ToDate)) < CONVERT(DATE,@FromDate) AND HT1403_CT.EmployeeStatus =9
            GROUP BY EmployeeID
		)A ON A.EmployeeID=HT1403_CT.EmployeeID AND A.LastModifyDate=HT1403_CT.LastModifyDate
WHERE  HT1403_CT.DivisionID = @DivisionID
	  AND CONVERT(DATE,ISNULL(HT1403_CT.LeaveDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND HT1403_CT.EmployeeStatus = 9
) 
INSERT INTO #OOP3017
SELECT distinct T.EmployeeID, 
 LEFT(ISNULL(DATENAME(mm,T.LeaveDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LeaveDate),112),''),2) [Month],
 DepartmentID, AnaName DepartmentName, '' [Column],T.LastmodifyDate
FROM TEMP T
LEFT JOIN #Department ON #Department.AnaID=DepartmentID
INNER JOIN (SELECT MAX(T1.LastModifyDate) LastModifyDate,T1.EmployeeID 
            FROM TEMP T1
            LEFT JOIN TEMP T2 ON T1.EmployeeID = T2.EmployeeID
            WHERE DATENAME(mm,T1.LastModifyDate) = DATENAME(mm,T2.LastModifyDate)
            GROUP BY T1.EmployeeID,T2.LastModifyDate
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
ORDER BY EmployeeID
END

------
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3017a (EmployeeID VARCHAR(50), [Month] VARCHAR(50),DepartmentID VARCHAR(50), DepartmentName NVARCHAR(250), Column1 NVARCHAR(250),LastModifyDate DATETIME,
Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3017a
	SELECT DISTINCT EmployeeID,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day),112),2) [Month], NULL, NULL,'' Column1, LastModifyDate,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate
	FROM #OOP3017
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END


UPDATE t1
	SET t1.DepartmentID = t2.DepartmentID, t1.DepartmentName = t2.DepartmentName
	FROM #OOP3017a t1
	inner JOIN 	#OOP3017 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(VARCHAR(10),t2.LastModifyDate,112) <=  CONVERT(VARCHAR(10),t1.ToDate,112)

----insert những bộ phận không có nhân viên nghỉ việc
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
	IF @Department_ID NOT IN (SELECT DepartmentID FROM #OOP3017)
	BEGIN
		INSERT INTO #OOP3017a
		VALUES (NULL, LEFT(DATENAME(mm,@FromDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@FromDate),112),2),
		@Department_ID, @Department_Name,'', @ToDate,  @FromDate, @ToDate)

	END
			 	
FETCH NEXT FROM @Cur INTO  @Department_ID, @Department_Name
END 
Close @Cur	

SELECT * FROM #OOP3017a ORDER BY MONTH(FromDate), EmployeeID, DepartmentID



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
