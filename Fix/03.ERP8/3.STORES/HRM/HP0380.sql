IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0380]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0380]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo theo dõi chế độ con nhỏ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM/ Báo cáo/ Theo dõi chế độ con nhỏ
---- 
-- <History>
---- Create on 07/01/2016 by Trương Ngọc Phương Thảo
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
---- Modified on 10/09/2020 by Nhựt Trường: tách store cho customer Meiko.
-- <Example>
----  EXEC HP0380 'MK', 0, 1, 2016, 1, 2016, '2016-04-05', '2016-04-05', '%', '%', '%', '%'--, 1
CREATE PROCEDURE HP0380	
(
	@DivisionID Nvarchar(50),
	@IsPeriod Tinyint, -- 0: kỳ, 1: Ngày	
	@FromMonth int,
	@FromYear int,
	@ToMonth int,
	@ToYear int,
	@FromDate datetime,	
	@ToDate datetime,
	@DepartmentID NVarchar(50),
	@TeamID Nvarchar(50),
	@SectionID Nvarchar(50),
	@ProcessID Nvarchar(50),
	@Type TINYINT = 0 --0: Báo cáo, 1: cảnh báo
)
AS
SET NOCOUNT ON

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 50 ---- Customize Meiko
BEGIN
	EXEC HP0380_MK @DivisionID, @IsPeriod, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @DepartmentID, @TeamID, @SectionID, @ProcessID, @Type
END
ELSE
BEGIN	

DECLARE @sSQL1 VARCHAR(MAX) ='',
		@sWhere VARCHAR(MAX),
		@TimeConvert decimal(28, 8)

SELECT TOP 1 @TimeConvert = TimeConvert
FROM HT0000
WHERE DivisionID = @DivisionID

--IF  @IsPeriod = 0 AND @Type=1
--BEGIN
--	SET @sSQL1 = 'AND SUM(AbsentAmount) < 0'
--	SET @sWhere = (SELECT @sSQL1)
--END


IF @IsPeriod = 0
BEGIN
	SET @FromDate = CONVERT(Datetime,'1'+'/'+STR(@FromMonth)+'/'+STR(@FromYear)) 
	SET @ToDate = CONVERT(Datetime,'1'+'/'+STR(@FromMonth)+'/'+STR(@FromYear)) 
	SET @ToDate = DATEADD(mm,DATEDIFF(mm,0,@ToDate)+1,0)
END


SELECT T1.EmployeeID, T1.DivisionID, 
		Ltrim(RTrim(isnull(T2.LastName,'')))+ ' ' + LTrim(RTrim(isnull(T2.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(T2.FirstName,''))) As FullName,
		T2.DepartmentID, 
		Convert(NVarchar(250),'') AS DepartmentName,
		T1.BeginDate, T1.EndDate,
		Convert(decimal(28, 8),0) AS AbsentHour,
		Convert(decimal(28, 8),0) AS LeaveAbsentHour,
		Convert(decimal(28, 8),0) AS RemainAbsentHour
INTO	#HP0380_HT1414
FROM	HT1414 T1
LEFT JOIN HT1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
WHERE T1.BeginDate BETWEEN @FromDate AND @ToDate AND T1.EmployeeMode = 'CR' 
AND T2.DepartmentID = @DepartmentID AND T2.TeamID = @TeamID AND T2.[Ana04ID] = @SectionID AND T2.[Ana05ID] = @ProcessID

-- Update ten Khoi: DepartmentName
Update	T1
set		T1.DepartmentName = T2.DepartmentName
from	#HP0380_HT1414 T1
inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID 

UPDATE	A
SET		A.AbsentHour = B.AbsentHour,
		A.LeaveAbsentHour = B.LeaveAbsentHour		
FROM #HP0380_HT1414 A
LEFT JOIN

(SELECT T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate ,
		SUM(CASE WHEN ISNULL(AbsentAmount,0) > 0 THEN 
												CASE WHEN T2.UnitID = 'H' THEN AbsentAmount ELSE AbsentAmount/@TimeConvert END  ELSE 0 END) AS AbsentHour, 
		SUM(CASE WHEN ISNULL(AbsentAmount,0) < 0 THEN
												 CASE WHEN T2.UnitID = 'H' THEN (-1) * AbsentAmount ELSE (-1)* AbsentAmount/@TimeConvert END ELSE 0 END) AS LeaveAbsentHour 
FROM HT2401 T1
LEFT JOIN HT1013 T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
LEFT JOIN #HP0380_HT1414 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID AND T1.AbsentDate BETWEEN T3.BeginDate AND T3.EndDate 
WHERE T2.TypeID = 'CN' 
GROUP BY T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate
HAVING (@Type = 0 OR (@Type = 1 AND SUM(AbsentAmount) < 0))
) B ON A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.BeginDate = B.BeginDate AND A.EndDate = B.EndDate 


UPDATE	A
SET		A.RemainAbsentHour = A.AbsentHour - A.LeaveAbsentHour
FROM #HP0380_HT1414 A

SELECT * FROM #HP0380_HT1414
DROP TABLE #HP0380_HT1414

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

