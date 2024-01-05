IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo nhân viên nam/nữ
 -- <Return>
 ---- 
 -- <Reference> 
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 14/03/2016
 /*-- <Example>
 	OOP3015 @DivisionID='MK',@FromDate = '2016-02-01 10:08:03.077', @ToDate= '2016-04-20 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@StatusID='3' 
 ----*/
CREATE PROCEDURE OOP3015
( 
 @DivisionID VARCHAR(50), 
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50),
 @StatusID VARCHAR(2)
) 
AS 
CREATE TABLE #Gender (IsMale TINYINT, IsMaleName NVARCHAR(250), IsMaleNameJapan NVARCHAR(250), IsMaleNameE NVARCHAR(250))
INSERT INTO #Gender
VALUES (1, N'Nam', N'男',N'Male'),
	   (0, N'Nữ', N'女',N'Female')


CREATE TABLE #OOP3015 (IsMaleNameJapan NVARCHAR(250), IsMaleName NVARCHAR(250), IsMaleNameE NVARCHAR(250),EmployeeID VARCHAR(50),  [Month] VARCHAR(10),
LastModifyDate DATETIME, IsMale TINYINT)

BEGIN WITH TEMP AS 
(----Dữ liệu thay đồi chức danh trong khoảng thời gian lọc	
 SELECT DivisionID, ReAPK, EmployeeID,ISNULL(convert(varchar(1),IsMale),'') IsMale ,
(Case When IsMale = 1 then N'男' else N'女' End) as IsMaleNameJapan,
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as IsMaleName, (Case When IsMale = 1 then N'Male' else N'Female' End) as IsMaleNameE, MAX(LastModifyDate) LastModifyDate
FROM HT1400_CT
WHERE DivisionID = @DivisionID
	 AND CONVERT(VARCHAR(10),LastModifyDate,112) BETWEEN CONVERT(VARCHAR(10),@FromDate,112) AND CONVERT(VARCHAR(10),@ToDate,112)
	AND ISNULL(DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(EmployeeStatus,'') LIKE ISNULL(@StatusID,'%')
	 AND EmployeeStatus <>9
GROUP BY  DivisionID,EmployeeID ,ReAPK,IsMale

UNION ALL
----Dữ liệu thay đồi chức danh trước khoảng thời gian lọc	
 SELECT DivisionID, ReAPK, HT1400_CT.EmployeeID,ISNULL(convert(varchar(1),IsMale),'') IsMale , (Case When IsMale = 1 then N'男 ' else N'女' End) as IsMaleNameJapan,
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as IsMaleName, (Case When IsMale = 1 then N'Male ' else N'Female' End) as IsMaleNameE, HT1400_CT.LastModifyDate LastModifyDate
FROM HT1400_CT
INNER JOIN (SELECT MAX(LastModifyDate) LastModifyDate,EmployeeID 
            FROM HT1400_CT
            WHERE LastModifyDate < @FromDate
            AND EmployeeStatus <>9
            GROUP BY EmployeeID
		)A ON A.EmployeeID=HT1400_CT.EmployeeID AND A.LastModifyDate=HT1400_CT.LastModifyDate
WHERE  DivisionID =@DivisionID
	AND ISNULL(DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(EmployeeStatus,'') LIKE ISNULL(@StatusID,'%')
	 AND EmployeeStatus <>9 
)
INSERT INTO #OOP3015
SELECT DISTINCT IsMaleNameJapan, IsMaleName, IsMaleNameE, T.EmployeeID,
 LEFT(ISNULL(DATENAME(mm,T.LastModifyDate),''),3)+'-'+RIGHT(ISNULL(CONVERT(VARCHAR(10),YEAR(T.LastModifyDate),112),''),2) [Month],
T.LastModifyDate, T.IsMale
FROM TEMP T
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

CREATE TABLE #OOP3015a (IsMaleNameJapan NVARCHAR(250),IsMaleName NVARCHAR(250),IsMaleNameE NVARCHAR(250),EmployeeID VARCHAR(50), [Month] VARCHAR(50),
LastModifyDate DATETIME, IsMale TINYINT,Fromdate DATETIME,Todate DATETIME)

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3015a
	SELECT DISTINCT '','', '', EmployeeID,LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day),112),2) [Month], LastModifyDate, IsMale,
	(CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate
	FROM #OOP3015 
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END

UPDATE t1
	SET t1.IsMale = t2.IsMale, t1.IsMaleNameJapan = t2.IsMaleNameJapan,t1.IsMaleName = t2.IsMaleName,t1.IsMaleNameE = t2.IsMaleNameE
	FROM #OOP3015a t1
	inner JOIN 	#OOP3015 t2 ON t1.EmployeeID = t2.EmployeeID
	and CONVERT(VARCHAR(10),t2.LastModifyDate,112) <=  CONVERT(VARCHAR(10),t1.ToDate,112)

--Insert những gender ko có nhân viên
DECLARE @Cur CURSOR,
		@IsMale TINYINT,
		@IsMaleName NVARCHAR(250),
		@IsMaleNameJapan NVARCHAR(250), 
		@IsMaleNameE NVARCHAR(250)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT IsMale, IsMaleName , IsMaleNameJapan, IsMaleNameE FROM #Gender

OPEN @Cur
FETCH NEXT FROM @Cur INTO @IsMale,@IsMaleName, @IsMaleNameJapan,@IsMaleNameE
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF @IsMale NOT IN (SELECT IsMale FROM #OOP3015a)
	BEGIN
		INSERT INTO #OOP3015a
		SELECT @IsMaleNameJapan,@IsMaleName,@IsMaleNameE,NULL,LEFT(DATENAME(mm,@ToDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@ToDate),112),2),
		NULL, @IsMale, @FromDate, @ToDate
	END		 
	
FETCH NEXT FROM @Cur INTO @IsMale,@IsMaleName, @IsMaleNameJapan,@IsMaleNameE
END 
Close @Cur	

SELECT * FROM #OOP3015a ORDER BY  MONTH(FromDate),IsMale, EmployeeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
