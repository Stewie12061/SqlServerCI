IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo nhân viên theo trình độ học vấn
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 15/03/2016
 /*-- <Example>
 	OOP3016 @DivisionID='MK',@FromDate = '2016-01-02 10:08:03.077', @ToDate= '2016-04-20 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@EducationLevelID='%' 
 ----*/
CREATE PROCEDURE OOP3016
( 
 @DivisionID VARCHAR(50), 
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50),
 @EducationLevelID VARCHAR(50)
) 
AS 
CREATE TABLE #EducationLevel (EducationLevelID VARCHAR(50), EducationLevelName NVARCHAR(250))
INSERT INTO #EducationLevel
SELECT EducationLevelID, EducationLevelName FROM HT1005 WHERE DivisionID = @DivisionID AND [Disabled] = 0

--CREATE TABLE #OOP3016 (Column1 Nvarchar(250), EmployeeID VARCHAR(50),  [Month] VARCHAR(10),EducationLevelID VARCHAR(50), EducationLevelName NVARCHAR(250),
--LastModifyDate DATETIME)
  
BEGIN WITH TEMP AS 
(
----Dữ liệu thay đồi chức danh trong khoảng thời gian lọc	
SELECT HT1401_CT.DivisionID, HT1401_CT.EmployeeID,EducationLevelID, Max(ISNULL(HT1401_CT.LastModifyDate,@ToDate)) LastModifyDate
FROM HT1401_CT
LEFT JOIN HT1400_CT ON HT1401_CT.ReAPK = HT1400_CT.ReAPK AND HT1401_CT.EmployeeID = HT1400_CT.EmployeeID
LEFT JOIN HT1403_CT ON HT1401_CT.ReAPK = HT1403_CT.ReAPK AND HT1401_CT.EmployeeID = HT1403_CT.EmployeeID
WHERE HT1401_CT.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT1401_CT.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT1400_CT.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT1400_CT.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT1400_CT.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT1400_CT.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(EducationLevelID,'') LIKE ISNULL(@EducationLevelID,'%')
	 AND (ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9) OR ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9) )
GROUP BY HT1401_CT.DivisionID,HT1401_CT.EmployeeID,EducationLevelID, HT1401_CT.LastModifyDate

UNION ALL
----Dữ liệu thay đồi chức danh trước khoảng thời gian lọc	
SELECT HT1401_CT.DivisionID,HT1401_CT.EmployeeID,EducationLevelID,ISNULL(HT1401_CT.LastModifyDate,@ToDate) LastModifyDate
FROM HT1401_CT
LEFT JOIN HT1400_CT ON HT1401_CT.ReAPK = HT1400_CT.ReAPK AND HT1401_CT.EmployeeID = HT1400_CT.EmployeeID
LEFT JOIN HT1403_CT ON HT1401_CT.ReAPK = HT1403_CT.ReAPK AND HT1401_CT.EmployeeID = HT1403_CT.EmployeeID
INNER JOIN (SELECT MAX(ISNULL(HT1401_CT.LastModifyDate,@ToDate)) LastModifyDate,EmployeeID 
            FROM HT1401_CT
            WHERE CONVERT(DATE,ISNULL(HT1401_CT.LastModifyDate,@ToDate)) < CONVERT(DATE,@FromDate) 
            GROUP BY EmployeeID
		)A ON HT1401_CT.EmployeeID=A.EmployeeID AND HT1401_CT.LastModifyDate=A.LastModifyDate
WHERE  HT1401_CT.DivisionID =@DivisionID
	AND ISNULL(HT1400_CT.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT1400_CT.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT1400_CT.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT1400_CT.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(EducationLevelID,'') LIKE ISNULL(@EducationLevelID,'%')
	AND (ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9) OR ISNULL(HT1400_CT.EmployeeStatus,1) NOT IN (3,9) ) 
)

SELECT  DISTINCT '' Column1, T.EmployeeID,  LEFT(ISNULL(DATENAME(mm,T.LastModifyDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LastModifyDate)),''),2) [Month],
T.EducationLevelID , EducationLevelName, T.LastModifyDate
INTO #OOP3016
FROM TEMP T
LEFT JOIN #EducationLevel ON #EducationLevel.EducationLevelID = T.EducationLevelID
INNER JOIN (SELECT MAX(T1.LastModifyDate) LastModifyDate,T1.EmployeeID 
            FROM TEMP T1
            LEFT JOIN TEMP T2 ON T1.EmployeeID = T2.EmployeeID
            WHERE DATENAME(mm,T1.LastModifyDate) = DATENAME(mm,T2.LastModifyDate)
            GROUP BY T1.EmployeeID,T2.LastModifyDate
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
ORDER BY [Month]

END

--------
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3016a (Column1 NVARCHAR(250),EmployeeID VARCHAR(50), [Month] VARCHAR(50),EducationLevelID VARCHAR(50),EducationLevelName NVARCHAR(250), LastModifyDate DATETIME,
Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3016a
	SELECT DISTINCT Column1, EmployeeID,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day)),2) , NULL , NULL ,
	LastModifyDate,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) , 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) 
	FROM #OOP3016 
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END


UPDATE t1
	SET t1.EducationLevelID = t2.EducationLevelID, t1.EducationLevelName = t2.EducationLevelName
	FROM #OOP3016a t1
	inner JOIN 	#OOP3016 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(DATE,t2.LastModifyDate) <=  CONVERT(DATE,t1.ToDate)

------insert những trình độ học vấn không có nhân viên
DECLARE @Cur CURSOR,
		@ID VARCHAR(50),
		@Name NVARCHAR(250)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT EducationLevelID, EducationLevelName
FROM #EducationLevel

OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @Name
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF @Name NOT IN (SELECT DISTINCT EducationLevelName FROM #OOP3016a)
	BEGIN
		INSERT INTO #OOP3016a
		VALUES ('', NULL,  LEFT(DATENAME(mm,@FromDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@FromDate)),2),@ID, @Name,NULL, @FromDate, @ToDate)

	END
			 	
FETCH NEXT FROM @Cur INTO @ID, @Name
END 
Close @Cur	

SELECT * FROM #OOP3016a ORDER BY MONTH(FromDate), EmployeeID, EducationLevelID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
