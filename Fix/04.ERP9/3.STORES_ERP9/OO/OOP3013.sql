IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo nhân viên sản xuất và nhân viên gián tiếp
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 17/03/2016
 /*-- <Example>
 	OOP3013 @DivisionID='MK',@FromDate = '2016-01-01 10:08:03.077', @ToDate= '2016-03-24 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3013
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
CREATE TABLE #Target (TargetID VARCHAR(50), TargetName NVARCHAR(250))
INSERT INTO #Target
SELECT TargetID, TargetName FROM HT1014 WHERE DivisionID = @DivisionID AND TargetTypeID = 'T05'

CREATE TABLE #OOP3013 (EmployeeID VARCHAR(50), Target05ID VARCHAR(50),TargetName NVARCHAR(250),[Month] VARCHAR(10),LastModifyDate DATETIME)
  
BEGIN WITH TEMP AS 
(----Dữ liệu thay đồi trong khoảng thời gian lọc	
 SELECT HT1403_CT.DivisionID, HT1403_CT.ReAPK, HT1403_CT.EmployeeID, Target05ID, MAX(ISNULL(HT1403_CT.LastModifyDate,@FromDate)) LastModifyDate
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK AND HT1403_CT.EmployeeID = HT40.EmployeeID
WHERE HT1403_CT.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate,@FromDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
	 AND ISNULL(HT1403_CT.EmployeeStatus,1) <> 9 OR ISNULL(HT40.EmployeeStatus,1) <>9
GROUP BY  HT1403_CT.DivisionID,HT1403_CT.EmployeeID ,HT1403_CT.ReAPK,Target05ID

UNION ALL
----Dữ liệu thay đồi trước khoảng thời gian lọc	
SELECT DISTINCT HT1403_CT.DivisionID, HT1403_CT.ReAPK, HT1403_CT.EmployeeID, Target05ID, ISNULL(HT1403_CT.LastModifyDate,@FromDate) LastModifyDate
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK AND HT1403_CT.EmployeeID = HT40.EmployeeID
INNER JOIN (SELECT MAX(ISNULL(HT1403_CT.LastModifyDate,@FromDate)) LastModifyDate,EmployeeID 
            FROM HT1403_CT
            WHERE CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate,@FromDate))  < CONVERT(DATE,@FromDate) 
            AND ISNULL(HT1403_CT.EmployeeStatus,1) <> 9
            GROUP BY EmployeeID
		)A ON A.EmployeeID= HT1403_CT.EmployeeID AND A.LastModifyDate=HT1403_CT.LastModifyDate
WHERE  HT1403_CT.DivisionID =@DivisionID
	AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
	 AND ISNULL(HT1403_CT.EmployeeStatus,1) <> 9 OR ISNULL(HT40.EmployeeStatus,1) <>9
)

INSERT INTO #OOP3013
SELECT  T.EmployeeID, Target05ID, TargetName,
 LEFT(ISNULL(DATENAME(mm,T.LastModifyDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LastModifyDate)),''),2) [Month],
T.LastModifyDate
FROM TEMP T
LEFT JOIN HT1014 ON T.DivisionID = HT1014.DivisionID and HT1014.TargetID = T.Target05ID AND TargetTypeID = 'T05'
INNER JOIN (SELECT MAX(T1.LastModifyDate) LastModifyDate,T1.EmployeeID 
            FROM TEMP T1
            LEFT JOIN TEMP T2 ON T1.EmployeeID = T2.EmployeeID
            WHERE DATENAME(mm,T1.LastModifyDate) = DATENAME(mm,T2.LastModifyDate)
            GROUP BY T1.EmployeeID,T2.LastModifyDate
		)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
WHERE ISNULL(Target05ID,'') <> ''
END

------
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3013a (EmployeeID VARCHAR(50), Target05ID VARCHAR(50), TargetName NVARCHAR(250),[Month] VARCHAR(50), LastModifyDate DATETIME,
Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3013a
	SELECT DISTINCT EmployeeID, NULL, NULL,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day)),2) [Month], LastModifyDate,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate
	FROM #OOP3013 
	ORDER BY EmployeeID
	SET @Day=DATEADD(MONTH,1,@Day)
END

UPDATE t1
	SET t1.Target05ID = t2.Target05ID, t1.TargetName = t2.TargetName
	FROM #OOP3013a t1
	inner JOIN 	#OOP3013 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(VARCHAR(10),t2.LastModifyDate,112) <=  CONVERT(VARCHAR(10),t1.ToDate,112)
	
----insert những chức danh không có nhân viên đảm nhận
DECLARE @Cur CURSOR,
		@ID VARCHAR(50),
		@Name NVARCHAR(250)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT TargetID, TargetName
FROM #Target

OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @Name
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF @ID NOT IN (SELECT DISTINCT ISNULL(Target05ID,'') FROM #OOP3013a)
	BEGIN
		INSERT INTO #OOP3013a
		VALUES( NULL, @ID, @Name, LEFT(DATENAME(mm,@ToDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@ToDate),112),2),NULL, @FromDate, @ToDate)
	END
			 	
FETCH NEXT FROM @Cur INTO @ID, @Name
END 
Close @Cur	

SELECT * FROM #OOP3013a ORDER BY MONTH(FromDate), EmployeeID,Target05ID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
