IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo nhân viên đang làm và không làm việc
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 14/03/2016
 /*-- <Example>
 	OOP3014 @DivisionID='MK',@FromDate = '2016-01-01 10:08:03.077', @ToDate= '2016-07-19 19:08:03.077',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@StatusID='%' 
 ----*/
CREATE PROCEDURE OOP3014
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
CREATE TABLE #EmployeeStatus (EmployeeStatus VARCHAR(50), EmployeeStatusName NVARCHAR(250))
INSERT INTO #EmployeeStatus
SELECT ID EmployeeStatus, [Description] EmployeeStatusName FROM AT0099 WHERE CodeMaster = 'AT00000010'
UNION ALL
SELECT  '1', N'NV đang làm'
UNION ALL
SELECT  '2', N'NV thử việc'
UNION ALL
SELECT  '3', N'Tạm nghỉ'
UNION ALL
SELECT  '4', N'CN thời vụ'


SELECT	ISNULL(EmployeeID,'') AS EmployeeID, ISNULL(T.EmployeeName,'') AS EmployeeName, ISNULL(CONVERT(DATE,MAX(T.BeginDate),112),'') AS BeginDate, 
		ISNULL(CONVERT(DATE,MAX(T.EndDate),112),'') AS EndDate, ISNULL([Month],'') AS [Month], 
		MAX(Mode) Mode, MAX([Type]) AS Type
INTO #OOP3014	 		
FROM 
(
SELECT  HT14.DivisionID, HT14.EmployeeID, (CASE WHEN ISNULL(HT14.EmployeeMode,'') <> '' THEN HT14.EmployeeMode ELSE HT14.EmployeeStatus END) AS Mode,
		Ltrim(RTrim(isnull(HT40.LastName,'')))+ ' '+ LTrim(RTrim(isnull(HT40.MiddleName,''))) + ' '+ LTrim(RTrim(Isnull(HT40.FirstName,''))) AS EmployeeName,
		CONVERT(DATE,ISNULL(HT14.BeginDate,Workdate),112) AS BeginDate, CONVERT(DATE,ISNULL(HT14.EndDate,'9999/12/31'),112) AS EndDate,
		CONVERT(VARCHAR(2),MONTH(ISNULL(HT14.EndDate,'9999/12/31')))+'/'+ CONVERT(VARCHAR(4),YEAR(ISNULL(HT14.EndDate,'9999/12/31'))) as [Month],
		(CASE WHEN (HT14.EmployeeStatus IN (1,4) AND ISNULL(HT14.EmployeeMode,'') IN ('', 'PR', 'CR')) THEN N'Active 実働'
			  WHEN (HT14.EmployeeStatus = 3 AND ISNULL(HT14.EmployeeMode,'') IN ('MT', 'LT', 'WW','TO')) THEN N'Inactive 不在' END) [Type]	
FROM HT1414 HT14
LEFT JOIN HT1400 HT40 ON HT14.DivisionID = HT40.DivisionID AND HT14.EmployeeID = HT40.EmployeeID
LEFT JOIN HT1403 HT43 ON HT14.DivisionID = HT43.DivisionID AND HT14.EmployeeID = HT43.EmployeeID
WHERE  HT14.DivisionID = @DivisionID
	 AND (
	 	(CONVERT(VARCHAR(10),ISNULL(HT14.BeginDate,Workdate),112) BETWEEN CONVERT(VARCHAR(10),@FromDate,112) AND CONVERT(VARCHAR(10),@ToDate,112)
			OR CONVERT(VARCHAR(10),ISNULL(HT14.EndDate,'9999/12/31'),112) BETWEEN CONVERT(VARCHAR(10),@FromDate,112) AND CONVERT(VARCHAR(10),@ToDate,112) )
		OR (CONVERT(VARCHAR(10),@FromDate,112) BETWEEN CONVERT(VARCHAR(10),ISNULL(HT14.BeginDate,Workdate),112) AND CONVERT(VARCHAR(10),ISNULL(HT14.EndDate,'9999/12/31'),112)
			AND CONVERT(VARCHAR(10),@ToDate,112) BETWEEN CONVERT(VARCHAR(10),ISNULL(HT14.BeginDate,Workdate),112) AND CONVERT(VARCHAR(10),ISNULL(HT14.EndDate,'9999/12/31'),112))
	 OR	((CONVERT(VARCHAR(10),ISNULL(HT14.BeginDate,Workdate),112) BETWEEN CONVERT(VARCHAR(10),@FromDate,112) AND CONVERT(VARCHAR(10),@ToDate,112)
			AND CONVERT(VARCHAR(10),ISNULL(HT14.EndDate,'9999/12/31'),112) BETWEEN CONVERT(VARCHAR(10),@FromDate,112) AND CONVERT(VARCHAR(10),@ToDate,112) ))
		)
	 AND ISNULL(HT40.DepartmentID,'') Like ISNULL(@DepartmentID,'%') 
	 AND ISNULL(HT40.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
	 AND ISNULL(HT40.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
	 AND ISNULL(HT40.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
	 AND ISNULL(HT14.EmployeeStatus,'') LIKE ISNULL(@StatusID,'%')
	 AND HT14.EmployeeStatus <> 9
)T
LEFT JOIN #EmployeeStatus A ON T.Mode = A.EmployeeStatus
GROUP BY  T.EmployeeID, T.EmployeeName, Month
order by EmployeeID, Mode desc

----
DECLARE @Day DATETIME = @FromDate

CREATE TABLE #OOP3014a (EmployeeID VARCHAR(50), FromDate DATETIME, ToDate DATETIME, Mode VARCHAR(50), [Month] VARCHAR(50),[Type] NVARCHAR(250))

WHILE MONTH(@Day) <= MONTH(@ToDate)
BEGIN
	INSERT INTO #OOP3014a
	SELECT DISTINCT EmployeeID, (CASE WHEN MONTH(@FromDate)=MONTH(@Day) THEN  @FromDate ELSE DATEADD(mm, DATEDIFF(mm, 0, @Day), 0) END) FromDate, 
	(CASE WHEN MONTH(@ToDate)=MONTH(@Day) THEN @ToDate ELSE CONVERT(DATETIME,EOMONTH(@Day),112) END) ToDate,
	'' Mode, LEFT(DATENAME(mm,@Day),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@Day),112),2) [Month],'' [Type]
	FROM HT1414 HT14
	ORDER BY EmployeeID
	
	SET @Day=DATEADD(MONTH,1,@Day)
END
--select * from #OOP3014 where EmployeeID = '000009'
--select * from #OOP3014a where EmployeeID = '000009'

--select * 
--into #OOP3014B
--from #OOP3014
--order by EmployeeID, Mode desc

----Update
	UPDATE t1
	SET t1.Mode = t2.Mode, t1.[Type] = t2.[Type]
	FROM #OOP3014a t1
	inner JOIN 	#OOP3014 t2 ON t1.EmployeeID = t2.EmployeeID
	and (t1.FromDate BETWEEN t2.BeginDate AND t2.EndDate
	OR t1.ToDate BETWEEN t2.BeginDate AND t2.EndDate)

----Insert những chế độ không có nhân viên
DECLARE @Cur CURSOR,
		@EmployeeStatus VARCHAR(50),
		@EmployeeStatusName NVARCHAR(250)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT EmployeeStatus, EmployeeStatusName
FROM #EmployeeStatus

OPEN @Cur
FETCH NEXT FROM @Cur INTO @EmployeeStatus, @EmployeeStatusName
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF @EmployeeStatus NOT IN (SELECT Mode FROM #OOP3014)
	BEGIN
		INSERT INTO #OOP3014a ([Month], Mode ,EmployeeID,FromDate,ToDate,[Type])
		VALUES( LEFT(DATENAME(mm,@FromDate),3)+'-'+RIGHT(CONVERT(VARCHAR(10),YEAR(@FromDate),112),2), @EmployeeStatus, NULL,@FromDate,@ToDate,
		(CASE WHEN (@EmployeeStatus IN ('1','2','4','PR', 'CR')) THEN N'Active 実働'
		 WHEN (@EmployeeStatus IN ('3','MT', 'LT', 'WW','TO')) THEN N'Inactive 不在' END) 
		 )
	END

FETCH NEXT FROM @Cur INTO @EmployeeStatus, @EmployeeStatusName
END 
Close @Cur

SELECT EmployeeID, Mode, EmployeeStatusName, [Type], [Month],
(CASE Mode WHEN '1' THEN N'実働人員'
		   WHEN '2' THEN N'試用人員'
		   WHEN '4' THEN N'短期人員'
		   WHEN 'MT' THEN N'産休人員'
		   WHEN 'LT' THEN N'長期休暇'
		   WHEN 'WW' THEN N'自宅退勤'
		   WHEN 'TO' THEN N'実習生'
		   WHEN 'PR' THEN N'妊娠人員'
		   WHEN 'CR' THEN N'育児人員' END ) E_WorkingType,FromDate,ToDate
FROM #OOP3014a
LEFT JOIN #EmployeeStatus ON #OOP3014a.Mode = #EmployeeStatus.EmployeeStatus 
ORDER BY MONTH(FromDate), EmployeeID,Mode


SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
