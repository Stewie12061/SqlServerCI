IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo phân loại nhân viên theo chức danh
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 12403/2016
 /*-- <Example>
 	OOP3011 @DivisionID='MK',@FromDate = '2016-01-01 10:08:03.077', @ToDate= '2016-03-28 19:08:03.077',@DepartmentID ='A000000', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@TitleID='%'
 	 
  	OOP3011 @DivisionID='MK',@FromDate = '2016-05-01 00:00:00.000', @ToDate= '2016-05-21 00:00:00.000',@DepartmentID ='C000000', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@TitleID='%' 
 ----*/
CREATE PROCEDURE OOP3011
(
 @DivisionID VARCHAR(50), 
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50),
 @TitleID VARCHAR(50)
) 
AS 
CREATE TABLE #Title (TitleID VARCHAR(50), TitleName NVARCHAR(250), TitleNameE NVARCHAR(250))
INSERT INTO #Title
SELECT TitleID, TitleName, TitleNameE FROM HT1106 WHERE DivisionID = @DivisionID

--CREATE TABLE #OOP3011 (Column1 Nvarchar(250), EmployeeID VARCHAR(50), [Month] VARCHAR(10),
--  TitleID VARCHAR(50),TitleName NVARCHAR(250),TitleNameE NVARCHAR(250), CountryID NVARCHAR(250),LastModifyDate DATETIME)

CREATE TABLE #TEMP (EmployeeID VARCHAR(50), TitleID VARCHAR(50), LastModifyDate DATETIME, CountryID NVARCHAR(250))

INSERT INTO #TEMP (EmployeeID, TitleID, LastModifyDate, CountryID)
----Dữ liệu thay đồi chức danh trong khoảng thời gian lọc	
SELECT DISTINCT HT1403_CT.EmployeeID,TitleID, ISNULL(HT1403_CT.LastModifyDate, @FromDate) LastModifyDate, 
(CASE WHEN CountryID = 'VN' THEN N'ローカル人員　NV người VN' ELSE N'駐在人員　NV người NN ' END) CountryID
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK AND HT1403_CT.EmployeeID = HT40.EmployeeID
WHERE HT1403_CT.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate, @FromDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(TitleID,'') <>'' AND TitleID LIKE ISNULL(@TitleID,'%')
	 AND (ISNULL(HT1403_CT.EmployeeStatus,1) NOT IN (3,9) OR ISNULL(HT40.EmployeeStatus,1) NOT IN (3,9))
GROUP BY  HT1403_CT.EmployeeID ,TitleID,CountryID,HT1403_CT.LastModifyDate
HAVING CONVERT(DATE,ISNULL(MAX(HT1403_CT.LastModifyDate), @FromDate)) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)


INSERT INTO #TEMP (EmployeeID, TitleID, LastModifyDate, CountryID)
------Dữ liệu thay đồi chức danh trước khoảng thời gian lọc	
SELECT DISTINCT HT1403_CT.EmployeeID,TitleID, ISNULL(HT1403_CT.LastModifyDate, @FromDate) LastModifyDate,
(CASE WHEN CountryID = 'VN' THEN N'ローカル人員　NV người VN' ELSE N'駐在人員　NV người NN ' END) CountryID
FROM HT1403_CT
LEFT JOIN HT1400_CT HT40 ON HT1403_CT.ReAPK = HT40.ReAPK 
INNER JOIN (SELECT ISNULL(MAX(HT1403_CT.LastModifyDate), @FromDate) LastModifyDate,EmployeeID 
            FROM HT1403_CT
            WHERE CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate, @FromDate)) < @FromDate
            AND HT1403_CT.EmployeeStatus NOT IN (3,9)
            GROUP BY EmployeeID
		)A ON A.EmployeeID=HT1403_CT.EmployeeID AND A.LastModifyDate=HT1403_CT.LastModifyDate
WHERE  HT1403_CT.DivisionID =@DivisionID
	 AND NOT EXISTS (SELECT TOP 1 1 FROM #TEMP WHERE HT1403_CT.EmployeeID = #TEMP.EmployeeID)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(TitleID,'') <>'' AND TitleID LIKE ISNULL(@TitleID,'%')
	 AND (ISNULL(HT1403_CT.EmployeeStatus,1) NOT IN (3,9) OR ISNULL(HT40.EmployeeStatus,1) NOT IN (3,9))


SELECT '' Column1, LEFT(ISNULL(DATENAME(mm,T.LastModifyDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LastModifyDate)),''),2) [Month], T.*,
TitleName, TitleNameE
INTO #OOP3011
FROM #Temp T 
LEFT JOIN #Title ON #Title.TitleID = T.TitleID 
ORDER BY employeeid

------
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3011a (Column1 NVARCHAR(250),EmployeeID VARCHAR(50), [Month] VARCHAR(50),TitleID VARCHAR(50), TitleName NVARCHAR(250),TitleNameE NVARCHAR(250), CountryID NVARCHAR(250),
LastModifyDate DATETIME, Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3011a
	SELECT DISTINCT '' Column1, EmployeeID,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day)),2) [Month], NULL, NULL,NULL, NULL,LastModifyDate,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate
	FROM #OOP3011 
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END


UPDATE t1
	SET t1.TitleID = t2.TitleID, t1.TitleName = t2.TitleName, t1.TitleNameE = t2.TitleNameE, t1.CountryID = t2.CountryID
	FROM #OOP3011a t1
	inner JOIN 	#OOP3011 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(DATE,t2.LastModifyDate) <=  CONVERT(DATE,t1.ToDate)

----insert những chức danh không có nhân viên đảm nhận
DECLARE @Cur CURSOR,
		@ID VARCHAR(50),
		@Name NVARCHAR(250),
		@NameE NVARCHAR(250)
SET @Day=@FromDate
 
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT TitleID, TitleName,TitleNameE
FROM #Title

OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @Name, @NameE
WHILE @@FETCH_STATUS = 0
BEGIN
		IF @ID NOT IN (SELECT DISTINCT ISNULL(TitleID,'') FROM #OOP3011a)
		BEGIN	
				INSERT INTO #OOP3011a
				VALUES( '', NULL, LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day)),2), @ID, @Name,@NameE, N'ローカル人員　NV người VN', NULL, @Day, @ToDate)
				
				INSERT INTO #OOP3011a
				VALUES( '', NULL, LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day)),2), @ID, @Name,@NameE, N'駐在人員　NV người NN ', NULL, @Day, @ToDate)
		END

FETCH NEXT FROM @Cur INTO @ID, @Name,@NameE
END 
Close @Cur	

SELECT * FROM #OOP3011a ORDER BY MONTH(FromDate),EmployeeID, TiTleName, CountryID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
