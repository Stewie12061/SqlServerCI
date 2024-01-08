IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo resignation
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 16/03/2016
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 /*-- <Example>
 	OOP3025 @DivisionID='MK',@FromDate = '2016-02-01 00:00:00.000', @ToDate= '2016-02-29 00:00:00.000',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 	
 
 ----*/
CREATE PROCEDURE OOP3025
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
----Data Sheet 1
DECLARE @sSQL NVARCHAR(MAX)='',
		@ssSQL NVARCHAR(MAX)='',
		@sSQL1 NVARCHAR(MAX)='',
		@sSQL2 NVARCHAR(MAX)='',
		@sSQL3 NVARCHAR(MAX)=''
SET @ssSQL = N'
DECLARE  @sSQL NVARCHAR(MAX)='''',
		@Column NVARCHAR(MAX)=''''
DECLARE @HT1107 table (DivisionID nvarchar(50), QuitJobID nvarchar(50),QuitJobNo nvarchar(50),QuitJobName NVARCHAR(500))
Insert into @HT1107 (DivisionID, QuitJobID, QuitJobNo,QuitJobName)
Select DivisionID, QuitJobID, (Case when ROW_NUMBER() Over (Order by HT1107.QuitJobID) < 10 then ''P0'' else ''P'' end )+Cast(ROW_NUMBER() Over (Order by HT1107.QuitJobID) as nvarchar(50)) as QuitJobNo  
,QuitJobName
from HT1107
Where DivisionID = '''+@DivisionID+''' and Disabled = 0
Order by HT1107.QuitJobID
CREATE TABLE #OOP3025 (DivisionID varchar(50), EmployeeID VARCHAR(50),WorkDate date,EmployeeName Nvarchar(250),IsMaleName Nvarchar(250),Age int,DepartmentID varchar(50)
,TEAMID varchar(50),Ana04ID varchar(50),Ana05ID varchar(50),SalaryLevel varchar(50),EmployeeStatus varchar(50),QuitJobNo varchar(50),
TitleID varchar(50), EducationLevelID varchar(50),LeaveDate date, QuitJobID varchar(50),LastModifyDate datetime, Notes nvarchar(250),Contract varchar(50))
'

SET @sSQL = N'
INSERT INTO #OOP3025
SELECT *
FROM
(
----Dữ liệu thay đồi chức danh trong khoảng thời gian lọc	
SELECT DISTINCT HT43.DivisionID, HT43.EmployeeID,CONVERT(date,ISNULL(HT43.WorkDate,SignDate))  WorkDate,
Ltrim(RTrim(isnull(HT40.LastName,'''')))+ ''''+ LTrim(RTrim(isnull(HT40.MiddleName,''''))) + ''''+ LTrim(RTrim(Isnull(HT40.FirstName,''''))) AS EmployeeName, 
(Case When IsMale = 1 then N''Nam'' else N''Nữ'' End) as IsMaleName, (DATEDIFF(yyyy,Birthday,GETDATE())) Age ,HT40.DepartmentID, HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,
ISNULL(SalaryLevel,'''') SalaryLevel,HT43.EmployeeStatus,
 HT17.QuitJobNo,
HT43.TitleID, EducationLevelID, CONVERT(DATE,ISNULL(HT43.LeaveDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) LeaveDate, HT43.QuitJobID, 
MAX(ISNULL(HT43.LastModifyDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) LastModifyDate, HT43.Notes,
( CASE DATEDIFF(yyyy,MAX(ISNULL(HT43.WorkDate,SignDate)),EOMONTH('''+CONVERT(VARCHAR(50),@ToDate,120)+''' )) 
        WHEN 0 THEN CONVERT(VARCHAR(2),(DATEDIFF(mm,MAX(ISNULL(HT43.WorkDate,SignDate)),EOMONTH('''+CONVERT(VARCHAR(50),@ToDate,120)+''' )))) + ''M''
		ELSE CONVERT(VARCHAR(2),(DATEDIFF(yyyy,ISNULL(MAX(HT43.WorkDate),SignDate),EOMONTH('''+CONVERT(VARCHAR(50),@ToDate,120)+''' )))) END) [Contract]
 FROM HT1403_CT HT43 
 LEFT JOIN @HT1107 as HT17 ON HT17.DivisionID = HT43.DivisionID AND HT17.QuitJobID = HT43.QuitJobID
LEFT JOIN HT1400_CT HT40  ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
LEFT JOIN HT1360 ON HT43.DivisionID = HT1360.DivisionID AND HT43.EmployeeID =HT1360.EmployeeID
WHERE HT43.DivisionID = '''+@DivisionID+'''
	 AND CONVERT(DATE,ISNULL(HT43.LastModifyDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) BETWEEN CONVERT(DATE,'''+CONVERT(VARCHAR(50),@FromDate,120)+''') AND CONVERT(DATE,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')
	 AND  CONVERT(DATE,ISNULL(HT43.LeaveDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) BETWEEN  CONVERT(DATE,'''+CONVERT(VARCHAR(50),@FromDate,120)+''') AND CONVERT(DATE,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')
	 AND ISNULL(HT40.DepartmentID,'''') Like ISNULL('''+@DepartmentID+''',''%'') 
	 AND ISNULL(HT40.TEAMID,'''') LIKE ISNULL('''+@SectionID+''',''%'') 
	 AND ISNULL(HT40.Ana04ID,'''') LIKE ISNULL('''+@SubsectionID+''',''%'')
	 AND ISNULL(HT40.Ana05ID,'''') LIKE ISNULL('''+@ProcessID+''',''%'') 
	 AND ISNULL(HT43.EmployeeStatus,1) = 9 OR ISNULL(HT40.EmployeeStatus,1) = 9
 GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,SalaryLevel,Birthday,HT43.WorkDate,
 HT43.TitleID,LeaveDate,EducationLevelID,HT43.LastModifyDate,IsMale,HT17.QuitJobNo,HT43.QuitJobID,HT43.Notes,HT43.EmployeeStatus,SignDate
 '
SET @sSQL3 =N'
UNION ALL
----Dữ liệu thay đồi chức danh trước khoảng thời gian lọc	
SELECT DISTINCT HT43.DivisionID, HT43.EmployeeID,CONVERT(date,ISNULL(HT43.WorkDate,SignDate))  WorkDate,
Ltrim(RTrim(isnull(HT40.LastName,'''')))+ ''''+ LTrim(RTrim(isnull(HT40.MiddleName,''''))) + ''''+ LTrim(RTrim(Isnull(HT40.FirstName,''''))) AS EmployeeName, 
(Case When IsMale = 1 then N''Nam'' else N''Nữ'' End) as IsMaleName, DATEDIFF(yyyy,Birthday,GETDATE()) Age ,HT40.DepartmentID, HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,
ISNULL(SalaryLevel,'''') SalaryLevel, HT43.EmployeeStatus,
 HT17.QuitJobNo,
HT43.TitleID, EducationLevelID, CONVERT(date,ISNULL(HT43.LeaveDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) LeaveDate, HT43.QuitJobID, ISNULL(HT43.LastModifyDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''') LastModifyDate,HT43.Notes,
( CASE DATEDIFF(yyyy,MAX(ISNULL(HT43.WorkDate,SignDate)),EOMONTH('''+CONVERT(VARCHAR(50),@ToDate,120)+''' )) 
        WHEN 0 THEN CONVERT(VARCHAR(2),(DATEDIFF(mm,MAX(ISNULL(HT43.WorkDate,SignDate)),EOMONTH('''+CONVERT(VARCHAR(50),@ToDate,120)+''' )))) + ''M''
		ELSE CONVERT(VARCHAR(2),(DATEDIFF(yyyy,MAX(ISNULL(HT43.WorkDate,SignDate)),EOMONTH('''+CONVERT(VARCHAR(50),@ToDate,120)+''' )))) END) [Contract]
 FROM HT1403_CT HT43 
LEFT JOIN @HT1107 as HT17 ON HT17.DivisionID = HT43.DivisionID AND HT17.QuitJobID = HT43.QuitJobID
LEFT JOIN HT1400_CT HT40  ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
LEFT JOIN HT1360 ON HT43.DivisionID = HT1360.DivisionID AND HT43.EmployeeID =HT1360.EmployeeID 
INNER JOIN (SELECT MAX(ISNULL(LastModifyDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) LastModifyDate,EmployeeID 
            FROM HT1403_CT
            WHERE CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate, '''+CONVERT(VARCHAR(50),@ToDate,120)+''')) < CONVERT(DATE,'''+CONVERT(VARCHAR(50),@FromDate,120)+''') AND HT1403_CT.EmployeeStatus = 9 
            GROUP BY EmployeeID
		)A ON A.EmployeeID=HT43.EmployeeID AND A.LastModifyDate=HT43.LastModifyDate
WHERE HT43.DivisionID = '''+@DivisionID+'''
	 AND  CONVERT(DATE,ISNULL(HT43.LeaveDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) BETWEEN  CONVERT(DATE,'''+CONVERT(VARCHAR(50),@FromDate,120)+''') AND CONVERT(DATE,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')
	 AND ISNULL(HT40.DepartmentID,'''') Like ISNULL('''+@DepartmentID+''',''%'') 
	 AND ISNULL(HT40.TEAMID,'''') LIKE ISNULL('''+@SectionID+''',''%'') 
	 AND ISNULL(HT40.Ana04ID,'''') LIKE ISNULL('''+@SubsectionID+''',''%'')
	 AND ISNULL(HT40.Ana05ID,'''') LIKE ISNULL('''+@ProcessID+''',''%'') 
	 AND ISNULL(HT43.EmployeeStatus,1) = 9 OR ISNULL(HT40.EmployeeStatus,1) = 9
 GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,SalaryLevel,Birthday,HT43.WorkDate,
HT43.TitleID,LeaveDate,EducationLevelID,HT43.LastModifyDate,IsMale,HT17.QuitJobNo,HT43.QuitJobID,HT43.Notes,HT43.EmployeeStatus,SignDate
)B '
SET @sSQL1 ='

SET @Column= (SELECT  ''[''+REPLACE(SUBSTRING((SELECT QuitJobNo+'','' FROM @HT1107
                                               GROUP BY QuitJobNo
	ORDER BY QuitJobNo  FOR XML PATH('''')),1,LEN((SELECT QuitJobNo+'','' FROM @HT1107
												GROUP BY QuitJobNo
	                                            ORDER BY QuitJobNo FOR XML PATH('''')))-1),'','',''],['')+'']'') '
SET @sSQL2 ='

SET @sSQL = ''
SELECT * FROM
(
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T.EmployeeID) AS STT,T.EmployeeID, T.EmployeeName, T.IsMaleName, WorkDate, '''''''' CT, Age,
	ISNULL(A11.DepartmentName,'''''''') AS DepartmentName,[Contract],'''''''' [29],
	ISNULL(A12.TeamName,'''''''') AS SectionName, ISNULL(A13.AnaName,'''''''') AS SubsectionName, ISNULL(A14.AnaName,'''''''') AS ProcessName,
	ISNULL(TitleName,'''''''') TitleName,EducationLevelName,LeaveDate,SalaryLevel,ISNULL(T.Notes,'''''''') Notes,QuitJobID, QuitJobNo
	FROM #OOP3025 T
	LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID 
	LEFT JOIN HT1101 A12 ON A11.DivisionID = T.DivisionID AND A12.TeamID=T.TEAMID
	LEFT JOIN AT1011 A13 ON A13.AnaID=T.Ana04ID AND A13.AnaTypeID=''''A04''''
	LEFT JOIN AT1011 A14 ON A14.AnaID=T.Ana05ID AND A14.AnaTypeID=''''A05''''
	LEFT JOIN HT1005 ON HT1005.DivisionID = T.DivisionID AND HT1005.EducationLevelID = T.EducationLevelID
	LEFT JOIN HT1106 ON HT1106.DivisionID = T.DivisionID AND HT1106.TitleID = T.TitleID
	INNER JOIN (SELECT MAX(ISNULL(LastModifyDate,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')) LastModifyDate,EmployeeID 
				FROM HT1403_CT
				WHERE ISNULL(EmployeeStatus,1) = 9 
				GROUP BY EmployeeID
			)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
	WHERE T.DivisionID = '''''+@DivisionID+'''''
	 AND ( CONVERT(DATE,ISNULL(T.LastModifyDate,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')) BETWEEN CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@FromDate,120)+''''') AND CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')
	 OR CONVERT(DATE,ISNULL(T.LastModifyDate,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')) < CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@FromDate,120)+''''' ))
	 AND CONVERT(DATE,T.LeaveDate) BETWEEN CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@FromDate,120)+''''') AND CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')
	 AND ISNULL(T.DepartmentID,'''''''') Like ISNULL('''''+@DepartmentID+''''',''''%'''') 
	 AND ISNULL(T.TEAMID,'''''''') LIKE ISNULL('''''+@SectionID+''''',''''%'''') 
	 AND ISNULL(T.Ana04ID,'''''''') LIKE ISNULL('''''+@SubsectionID+''''',''''%'''')
	 AND ISNULL(T.Ana05ID,'''''''') LIKE ISNULL('''''+@ProcessID+''''',''''%'''') 
	 AND T.EmployeeStatus = 9
) P
PIVOT
(
COUNT (P.QuitJobID)
FOR P.QuitJobNo IN
(''+ @Column+'' )
) AS pvt

''
EXEC (@sSQL)

'

EXEC (@ssSQL+@sSQL+@sSQL3+@sSQL1+@sSQL2)

--PRINT (@ssSQL)
--PRINT (@sSQL)
--PRINT (@sSQL3)
--PRINT (@sSQL1)
--PRINT (@sSQL2)


SELECT QuitJobName FROM HT1107 
ORDER BY QuitJobID 

----Data Sheet 2
--BEGIN WITH TEMP AS 
SELECT *
INTO #TEMP
FROM
(----Dữ liệu thay đồi trong khoảng thời gian lọc	
 SELECT DISTINCT HT43.DivisionID, HT43.EmployeeID,CONVERT(date,ISNULL(HT43.WorkDate, SignDate))  WorkDate,
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, 
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as IsMaleName, STR(DATEDIFF(yy,Birthday,GETDATE())) Age ,HT40.DepartmentID, HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,
ISNULL(SalaryLevel,'') SalaryLevel,HT43.EmployeeStatus,
HT43.TitleID, EducationLevelID, CONVERT(DATE,ISNULL(HT43.LeaveDate, @ToDate)) LeaveDate, HT43.QuitJobID, MAX(ISNULL(HT43.LastModifyDate, @ToDate)) LastModifyDate, HT43.Notes,
( CASE DATEDIFF(yy,ISNULL(HT43.WorkDate,SignDate),EOMONTH(@ToDate)) 
        WHEN 0 THEN CONVERT(VARCHAR(2),(DATEDIFF(mm,ISNULL(HT43.WorkDate,SignDate),EOMONTH(@ToDate)))) + 'M'
		ELSE CONVERT(VARCHAR(2),(DATEDIFF(yyyy,ISNULL(HT43.WorkDate,SignDate),EOMONTH(@ToDate)))) END) [Contract]
FROM HT1403_CT HT43 
LEFT JOIN HT1400_CT HT40  ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
LEFT JOIN HT1360 ON HT43.DivisionID = HT1360.DivisionID AND HT43.EmployeeID =HT1360.EmployeeID 
WHERE HT43.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT43.LastModifyDate,@ToDAte))BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND CONVERT(DATE,ISNULL(HT43.LeaveDate,@ToDAte)) BETWEEN  CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(HT43.EmployeeStatus,1) = 9 OR ISNULL(HT40.EmployeeStatus,1) = 9
GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,SalaryLevel,Birthday,HT43.WorkDate,
 HT43.TitleID,LeaveDate,EducationLevelID,HT40.LastModifyDate,IsMale,HT43.QuitJobID,HT43.Notes,HT43.EmployeeStatus,SignDate
 
UNION ALL
	
SELECT DISTINCT HT43.DivisionID, HT43.EmployeeID,CONVERT(date,ISNULL(HT43.WorkDate, SignDate))  WorkDate,
Ltrim(RTrim(isnull(HT40.LastName,'')))+ ''+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ''+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName, 
(Case When IsMale = 1 then N'Nam' else N'Nữ' End) as IsMaleName, DATEDIFF(yy,Birthday,GETDATE()) Age ,HT40.DepartmentID, HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,
ISNULL(SalaryLevel,'') SalaryLevel, HT43.EmployeeStatus,
HT43.TitleID, EducationLevelID, CONVERT(date,ISNULL(HT43.LeaveDate, @ToDate)) LeaveDate, HT43.QuitJobID, MAX(ISNULL(HT43.LastModifyDate, @ToDate)) LastModifyDate,HT43.Notes,
( CASE DATEDIFF(yy,ISNULL(HT43.WorkDate,SignDate),EOMONTH(@ToDate)) 
        WHEN 0 THEN CONVERT(VARCHAR(2),(DATEDIFF(mm,ISNULL(HT43.WorkDate,SignDate),EOMONTH(@ToDate)))) + 'M'
		ELSE CONVERT(VARCHAR(2),(DATEDIFF(yyyy,ISNULL(HT43.WorkDate,SignDate),EOMONTH(@ToDate)))) END) [Contract]
FROM HT1403_CT HT43 
LEFT JOIN HT1400_CT HT40  ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
LEFT JOIN HT1360 ON HT43.DivisionID = HT1360.DivisionID AND HT43.EmployeeID =HT1360.EmployeeID 
INNER JOIN (SELECT MAX(ISNULL(LastModifyDate,@ToDate)) LastModifyDate,EmployeeID 
            FROM HT1403_CT
            WHERE CONVERT(DATE,ISNULL(HT1403_CT.LastModifyDate, @ToDate)) < CONVERT(DATE,@FromDate) AND HT1403_CT.EmployeeStatus = 9 
            GROUP BY EmployeeID
		)A ON A.EmployeeID=HT43.EmployeeID AND A.LastModifyDate=HT43.LastModifyDate
WHERE HT43.DivisionID = @DivisionID
	 AND CONVERT(DATE,ISNULL(HT43.LeaveDate,@ToDAte)) BETWEEN  CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%') 
	 AND ISNULL(HT43.EmployeeStatus,1) = 9 OR ISNULL(HT40.EmployeeStatus,1) = 9
GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,SalaryLevel,Birthday,HT43.WorkDate,
 HT43.TitleID,LeaveDate,EducationLevelID,HT40.LastModifyDate,IsMale,HT43.QuitJobID,HT43.Notes,HT43.EmployeeStatus,SignDate
)B


SELECT BT.*, HT1107.QuitJobID, QuitJobName
FROM HT1107
RIGHT JOIN 
(SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T.EmployeeID) AS STT,T.DivisionID, T.EmployeeID, T.EmployeeName, T.IsMaleName, WorkDate, '' CT, Age,
	ISNULL(A11.DepartmentName,'') AS DepartmentName,[Contract],'' [29],
	ISNULL(A12.TeamName,'') AS SectionName, ISNULL(A13.AnaName,'') AS SubsectionName, ISNULL(A14.AnaName,'') AS ProcessName,
	ISNULL(TitleName,'') TitleName,EducationLevelName,LeaveDate,SalaryLevel,ISNULL(T.Notes,'') Notes,T.QuitJobID
	FROM #TEMP T
	LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID 
	LEFT JOIN HT1101 A12 ON A11.DivisionID = T.DivisionID AND A12.TeamID=T.TEAMID
	LEFT JOIN AT1011 A13 ON A13.AnaID=T.Ana04ID AND A13.AnaTypeID='A04'
	LEFT JOIN AT1011 A14 ON A14.AnaID=T.Ana05ID AND A14.AnaTypeID='A05'
	LEFT JOIN HT1005 ON HT1005.DivisionID = T.DivisionID AND HT1005.EducationLevelID = T.EducationLevelID
	LEFT JOIN HT1106 ON HT1106.DivisionID = T.DivisionID AND HT1106.TitleID = T.TitleID
	INNER JOIN (SELECT MAX(ISNULL(LastModifyDate,@ToDate)) LastModifyDate,EmployeeID 
				FROM HT1403_CT
				WHERE ISNULL(EmployeeStatus,1) = 9 
				GROUP BY EmployeeID
			)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
	)BT
ON HT1107.DivisionID = BT.DivisionID AND HT1107.QuitJobID = BT.QuitJobID
 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
