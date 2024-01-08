IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3026]
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
 	OOP3026 @DivisionID='MK',@FromDate = '2016-02-01 09:38:40.130', @ToDate= '2016-02-29 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3026
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
DECLARE @sSQL NVARCHAR(MAX)='''',
		@ssSQL NVARCHAR(MAX)='''',
		@sSQL1 NVARCHAR(MAX)='''',
		@sSQL2 NVARCHAR(MAX)=''''

SET @ssSQL = N'
DECLARE  @sSQL NVARCHAR(MAX)='''',
		@Column NVARCHAR(MAX)
DECLARE @HT1107 table (DivisionID nvarchar(50), QuitJobID nvarchar(50),QuitJobNo nvarchar(50),QuitJobName NVARCHAR(500))

Insert into @HT1107 (DivisionID, QuitJobID, QuitJobNo,QuitJobName)
Select DivisionID, QuitJobID, (Case when ROW_NUMBER() Over (Order by HT1107.QuitJobID) < 10 then ''P0'' else ''P'' end )+Cast(ROW_NUMBER() Over (Order by HT1107.QuitJobID) as nvarchar(50)) as QuitJobNo  
,QuitJobName
from HT1107
Where DivisionID = '''+@DivisionID+''' and Disabled = 0
Order by HT1107.QuitJobID'		

SET @sSQL = N'
SELECT *
INTO #OOP3026
FROM
(
----Dữ liệu thay đồi chức danh trong khoảng thời gian lọc	
SELECT HT43.DivisionID, HT43.EmployeeID,CONVERT(date,ISNULL(HT43.WorkDate,SignDate))  WorkDate,  CONVERT(DATE,ISNULL(HT43.LeaveDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) LeaveDate,
Ltrim(RTrim(isnull(HT40.LastName,'''')))+ ''''+ LTrim(RTrim(isnull(HT40.MiddleName,''''))) + ''''+ LTrim(RTrim(Isnull(HT40.FirstName,''''))) AS EmployeeName, 
(Case When IsMale = 1 then ''Nam'' else ''Nữ'' End) as IsMaleName, HT40.DepartmentID, HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,
HT17.QuitJobNo,HT43.EmployeeStatus,
HT43.TitleID, HT43.QuitJobID, MAX(ISNULL(HT43.LastModifyDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''')) LastModifyDate
FROM HT1403_CT HT43
LEFT JOIN @HT1107 as HT17 ON HT17.DivisionID = HT43.DivisionID AND HT17.QuitJobID = HT43.QuitJobID
LEFT JOIN HT1400_CT HT40  ON HT43.ReAPK = HT40.ReAPK AND HT43.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1401_CT HT41 ON HT43.ReAPK = HT41.ReAPK AND HT43.EmployeeID = HT41.EmployeeID
LEFT JOIN HT1360 ON HT43.DivisionID = HT1360.DivisionID AND HT43.EmployeeID =HT1360.EmployeeID
 GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,Birthday,HT43.WorkDate,
 SignDate,HT43.TitleID,LeaveDate,HT40.LastModifyDate,IsMale,HT17.QuitJobNo,HT43.QuitJobID,HT43.EmployeeStatus

UNION ALL
----Dữ liệu thay đồi chức danh trước khoảng thời gian lọc	
SELECT HT43.DivisionID, HT43.EmployeeID,CONVERT(date,ISNULL(HT43.WorkDate,SignDate))  WorkDate,  CONVERT(DATE,HT43.LeaveDate) LeaveDate,
Ltrim(RTrim(isnull(HT40.LastName,'''')))+ ''''+ LTrim(RTrim(isnull(HT40.MiddleName,''''))) + ''''+ LTrim(RTrim(Isnull(HT40.FirstName,''''))) AS EmployeeName, 
(Case When IsMale = 1 then ''Nam'' else ''Nữ'' End) as IsMaleName, HT40.DepartmentID, HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,
 HT17.QuitJobNo,HT43.EmployeeStatus,
HT43.TitleID, HT43.QuitJobID, ISNULL(HT43.LastModifyDate,'''+CONVERT(VARCHAR(50),@ToDate,120)+''') LastModifyDate
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
 GROUP BY HT43.DivisionID,HT43.EmployeeID,HT40.LastName,HT40.MiddleName, HT40.FirstName,HT40.DepartmentID,HT40.TEAMID, HT40.Ana04ID,HT40.Ana05ID,Birthday,HT43.WorkDate,
 SignDate,HT43.TitleID,LeaveDate,HT43.LastModifyDate,IsMale,HT17.QuitJobNo,HT43.QuitJobID,HT43.EmployeeStatus
)B '
SET @sSQL1 ='

SET @Column= (SELECT  ''[''+REPLACE(SUBSTRING((SELECT QuitJobNo+'','' FROM #OOP3026
                                               GROUP BY QuitJobNo
	ORDER BY QuitJobNo  FOR XML PATH('''')),1,LEN((SELECT QuitJobNo+'','' FROM #OOP3026
												GROUP BY QuitJobNo
	                                            ORDER BY QuitJobNo FOR XML PATH('''')))-1),'','',''],['')+'']'') '
SET @sSQL2 ='
SET @sSQL = ''
SELECT * FROM
(
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T.EmployeeID) AS STT,T.EmployeeID, T.EmployeeName,
	'''''''' HearingDate, '''''''' ReasonE, '''''''' ReasonJP, '''''''' Notes,T.IsMaleName,  WorkDate,LeaveDate,'''''''' CT,
	ISNULL(A11.DepartmentName,'''''''') AS DepartmentName,
	ISNULL(A12.TeamName,'''''''') AS SectionName, ISNULL(A13.AnaName,'''''''') AS SubsectionName, ISNULL(A14.AnaName,'''''''') AS ProcessName,
	ISNULL(TitleName,'''''''') TitleName, ISNULL(TitleNameE,'''''''') TitleNameE, '''''''' Object, QuitJobID, QuitJobNo
	FROM #OOP3026 T
	LEFT JOIN AT1102 A11 ON A11.DepartmentID=T.DepartmentID 
	LEFT JOIN HT1101 A12 ON A11.DivisionID = T.DivisionID AND A12.TeamID=T.TEAMID
	LEFT JOIN AT1011 A13 ON A13.AnaID=T.Ana04ID AND A13.AnaTypeID=''''A04''''
	LEFT JOIN AT1011 A14 ON A14.AnaID=T.Ana05ID AND A14.AnaTypeID=''''A05''''
	LEFT JOIN HT1106 ON HT1106.DivisionID = T.DivisionID AND HT1106.TitleID = T.TitleID
	INNER JOIN (SELECT MAX(ISNULL(LastModifyDate,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')) LastModifyDate,EmployeeID 
				FROM HT1403_CT
				WHERE ISNULL(EmployeeStatus,1) = 9 
				GROUP BY EmployeeID
			)A ON A.EmployeeID=T.EmployeeID AND A.LastModifyDate=T.LastModifyDate
	WHERE T.DivisionID = '''''+@DivisionID+'''''
	  AND ( CONVERT(DATE,T.LeaveDate) BETWEEN  CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@FromDate,120)+''''') AND CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')
	 OR CONVERT(DATE,T.LastModifyDate) < CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@FromDate,120)+''''') )
	 AND CONVERT(DATE,T.LeaveDate) BETWEEN  CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@FromDate,120)+''''') AND CONVERT(DATE,'''''+CONVERT(VARCHAR(50),@ToDate,120)+''''')
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
) AS pvt''
PRINT (@sSQL)
EXEC (@sSQL)
'

--PRINT (@ssSQL)
--PRINT (@sSQL)
--PRINT (@sSQL1)
--PRINT (@sSQL2)
EXEC (@ssSQL+@sSQL+@sSQL1+@sSQL2)
 
SELECT QuitJobName FROM HT1107 
ORDER BY QuitJobID 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

