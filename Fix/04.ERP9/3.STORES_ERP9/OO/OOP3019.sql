IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo phân loại nhân viên nghỉ việc theo chức danh
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 16/03/2016
 /*-- <Example>
 	OOP3019 @DivisionID='MK',@FromDate = '2016-01-01 10:08:03.077', @ToDate= '2016-03-28 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3019
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
CREATE TABLE #QuitJob (QuitJobID VARCHAR(50), QuitJobName NVARCHAR(250))
INSERT INTO #QuitJob
SELECT QuitJobID, QuitJobName FROM HT1107 WHERE DivisionID = @DivisionID AND [Disabled] = 0

CREATE TABLE #OOP3019 (EmployeeID VARCHAR(50),  [Month] VARCHAR(10),QuitJobID VARCHAR(50),
  QuitJobName NVARCHAR(250), QuitJobNameE NVARCHAR(250),LastModifyDate DATETIME)

BEGIN WITH TEMP AS
(
----Dữ liệu thay đồi chức danh trong khoảng thời gian lọc	
select HT1403_CT.DivisionID, HT1403_CT.ReAPK, HT1403_CT.EmployeeID,HT1403_CT.QuitJobID, LeaveDate,Max(ISNULL(HT1403_CT.LastModifyDate,@ToDate)) LastModifyDate
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK AND HT1403_CT.EmployeeID = HT40.EmployeeID
WHERE HT1403_CT.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LeaveDate,@ToDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(HT1403_CT.EmployeeStatus,1) = 9 OR  ISNULL(HT40.EmployeeStatus,1) = 9 
GROUP BY  HT1403_CT.DivisionID,HT1403_CT.EmployeeID ,HT1403_CT.ReAPK, HT1403_CT.QuitJobID,LeaveDate

UNION ALL
----Dữ liệu thay đồi chức danh trước khoảng thời gian lọc	
SELECT   HT1403_CT.DivisionID, HT1403_CT.ReAPK, HT1403_CT.EmployeeID,HT1403_CT.QuitJobID, LeaveDate,ISNULL(HT1403_CT.LastModifyDate,@ToDate) LastModifyDate
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
	 AND ISNULL(HT1403_CT.EmployeeStatus,1) = 9 OR  ISNULL(HT40.EmployeeStatus,1) = 9 
) 
INSERT INTO #OOP3019
SELECT  distinct T.EmployeeID, 
 LEFT(ISNULL(DATENAME(mm,T.LeaveDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LeaveDate),112),''),2) [Month], 
 T.QuitJobID, QuitJobName, '' QuitJobNameE, T.LastModifyDate
FROM TEMP T
	LEFT JOIN #QuitJob  ON #QuitJob.QuitJobID = T.QuitJobID 
	INNER JOIN (SELECT MAX(T1.LastModifyDate) LastModifyDate,T1.EmployeeID 
            FROM TEMP T1
            LEFT JOIN TEMP T2 ON T1.EmployeeID = T2.EmployeeID
            WHERE DATENAME(mm,T1.LastModifyDate) = DATENAME(mm,T2.LastModifyDate)
            GROUP BY T1.EmployeeID,T2.LastModifyDate
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
ORDER BY QuitJobName
END

------
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3019a (EmployeeID VARCHAR(50),[Month] VARCHAR(50),QuitJobID VARCHAR(50), QuitJobName NVARCHAR(250),QuitJobNameE NVARCHAR(250),LastModifyDate DATETIME,
Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3019a
	SELECT DISTINCT EmployeeID,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day)),2) [Month], NULL, NULL,'',LastModifyDate,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate
	FROM #OOP3019 
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END


UPDATE t1
	SET t1.QuitJobID = t2.QuitJobID, t1.QuitJobName = t2.QuitJobName
	FROM #OOP3019a t1
	inner JOIN 	#OOP3019 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(DATE,t2.LastModifyDate) <=  CONVERT(DATE,t1.ToDate)
----insert những lý do nghỉ việc ngoài #OOP0319
DECLARE @Cur CURSOR,
		@ID VARCHAR(50),
		@Name NVARCHAR(250)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT QuitJobID, QuitJobName
FROM #QuitJob

OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @Name
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF @ID NOT IN (SELECT QuitJobID FROM #OOP3019)
	BEGIN
		INSERT INTO #OOP3019a
		VALUES ( NULL, LEFT(DATENAME(mm,@FromDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@FromDate),112),2), @ID, @Name, '',NULL, @FromDate, @ToDate)

	END
			 	
FETCH NEXT FROM @Cur INTO  @ID, @Name
END 
Close @Cur	

SELECT * FROM #OOP3019a ORDER BY MONTH(FromDate), EmployeeID, QuitJobID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
