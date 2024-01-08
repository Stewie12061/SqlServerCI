IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0380_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0380_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo/Cảnh báo theo dõi chế độ con nhỏ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM/ Báo cáo/ Theo dõi chế độ con nhỏ
---- 
-- <History>
---- Create on 07/01/2016 by Trương Ngọc Phương Thảo
---- Modified on 
-- <Example>
----  EXEC HP0380_MK 'MK', 0, 2, 2016, 2, 2016, '2016-02-05', '2016-02-06', '%', '%', '%', '%', 0
CREATE PROCEDURE HP0380_MK	
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

DECLARE @sSQL1 VARCHAR(MAX) ='',
		@sWhere VARCHAR(MAX),
		@TimeConvert decimal(28, 8),
		@TableHT2401 Varchar(50),
		@sTranMonth Varchar(2),
		@MaxTranMonth Int,
		@MaxTranYear Int

SELECT TOP 1 @MaxTranMonth = TranMonth, @MaxTranYear = TranYear
FROM HT9999
ORDER BY  TranYear desc, TranMonth desc

SELECT @sTranMonth = CASE WHEN @MaxTranMonth >9 THEN Convert(Varchar(2),@MaxTranMonth) ELSE '0'+Convert(Varchar(1),@MaxTranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@MaxTranYear)
END
ELSE
BEGIN
	SET	@TableHT2401 = 'HT2401'
END

SELECT TOP 1 @TimeConvert = TimeConvert
FROM HT0000
WHERE DivisionID = @DivisionID

--IF  @IsPeriod = 0 AND @Type=1
--BEGIN
--	SET @sSQL1 = 'AND SUM(AbsentAmount) < 0'
--	SET @sWhere = (SELECT @sSQL1)
--END

CREATE TABLE #HP0380_MK_HT1414 (EmployeeID VARCHAR(50), DivisionID VARCHAR(50), EmployeeName NVARCHAR(250), DepartmentID VARCHAR(50), DepartmentName NVARCHAR(50),
							BeginDate DATETIME, EndDate DATETIME, AbsentHour DECIMAL(28,8), LeaveAbsentHour DECIMAL(28,8), RemainAbsentHour DECIMAL(28,8),
							Birthday DATETIME, TitleName NVARCHAR(250))

IF @IsPeriod = 0
BEGIN
	SET @FromDate =  CAST(CAST(@FromYear AS varchar) + '/' + CAST(@FromMonth AS varchar) + '/' + '1' AS DATETIME)
	--CONVERT(Datetime,'01'+'/'+CONVERT(VARCHAR(2),@FromMonth)+'/'+CONVERT(VARCHAR(4),@FromYear),113) 
	SET @ToDate = EOMONTH(CAST(CAST(@ToYear AS varchar) + '/' + CAST(@ToMonth AS varchar) + '/' + '1' AS DATETIME))
END

--SELECT @FromDate fromdate, @ToDate todate

IF(@Type = 0) --Báo cáo
BEGIN
	INSERT INTO	#HP0380_MK_HT1414 (EmployeeID, DivisionID, EmployeeName, DepartmentID, DepartmentName, BeginDate, EndDate, AbsentHour, LeaveAbsentHour, RemainAbsentHour)
	
	SELECT T1.EmployeeID, T1.DivisionID, 
			Ltrim(RTrim(isnull(T2.LastName,'')))+ ' ' + LTrim(RTrim(isnull(T2.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(T2.FirstName,''))) As FullName,
			T2.DepartmentID, 
			Convert(NVarchar(250),'') AS DepartmentName,
			T1.BeginDate, T1.EndDate,
			Convert(decimal(28, 8),0) AS AbsentHour,
			Convert(decimal(28, 8),0) AS LeaveAbsentHour,
			Convert(decimal(28, 8),0) AS RemainAbsentHour
	FROM	HT1414 T1
	LEFT JOIN HT1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	WHERE (@FromDate  BETWEEN T1.BeginDate AND T1.EndDate
			OR @ToDate  BETWEEN T1.BeginDate AND T1.EndDate)
	AND T1.EmployeeMode = 'CR' 
	AND T2.DepartmentID LIKE @DepartmentID AND T2.TeamID LIKE @TeamID AND T2.[Ana04ID] LIKE @SectionID AND T2.[Ana05ID] LIKE @ProcessID
	
	-- Update ten Khoi: DepartmentName
	Update	T1
	set		T1.DepartmentName = T2.DepartmentName
	from	#HP0380_MK_HT1414 T1
	inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID and T1.DivisionID = T2.DivisionID

	SET @sSQL1 = '
	UPDATE	A
	SET		A.AbsentHour = B.AbsentHour,
			A.LeaveAbsentHour = B.LeaveAbsentHour		
	FROM #HP0380_MK_HT1414 A
	LEFT JOIN
		(SELECT T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate ,
				SUM(CASE WHEN ISNULL(AbsentAmount,0) > 0 THEN 
														CASE WHEN T2.UnitID = ''H'' THEN AbsentAmount ELSE AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END  ELSE 0 END) AS AbsentHour, 
				SUM(CASE WHEN ISNULL(AbsentAmount,0) < 0 THEN
														 CASE WHEN T2.UnitID = ''H'' THEN (-1) * AbsentAmount ELSE (-1)* AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END ELSE 0 END) AS LeaveAbsentHour 
		FROM HT2401 T1
		LEFT JOIN HT1013 T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
		LEFT JOIN #HP0380_MK_HT1414 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID AND T1.AbsentDate BETWEEN T3.BeginDate AND T3.EndDate 
		WHERE T2.TypeID = ''CN'' 
		GROUP BY T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate			
	) B ON A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.BeginDate = B.BeginDate AND A.EndDate = B.EndDate 
	'	
END
ELSE
BEGIN -- (@Type = 1 : Cảnh báo)
	INSERT INTO	#HP0380_MK_HT1414 (EmployeeID, DivisionID, EmployeeName, DepartmentID, DepartmentName, BeginDate, EndDate, AbsentHour, LeaveAbsentHour, RemainAbsentHour,
								Birthday, TitleName )
	
	SELECT T1.EmployeeID, T1.DivisionID, 
			Ltrim(RTrim(isnull(T2.LastName,'')))+ ' ' + LTrim(RTrim(isnull(T2.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(T2.FirstName,''))) As EmployeeName,
			T2.DepartmentID, 
			Convert(NVarchar(250),'') AS DepartmentName,
			T1.BeginDate, T1.EndDate,
			Convert(decimal(28, 8),0) AS AbsentHour,
			Convert(decimal(28, 8),0) AS LeaveAbsentHour,
			Convert(decimal(28, 8),0) AS RemainAbsentHour,
			T2.Birthday, T4.TitleName
	FROM	HT1414 T1
	LEFT JOIN HT1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	LEFT JOIN HT1403 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID
	LEFT JOIN HT1106 T4 ON T1.DivisionID = T4.DivisionID AND T3.DutyID = T4.TitleID
	WHERE GETDATE() BETWEEN T1.BeginDate AND T1.EndDate
	AND T1.EmployeeMode = 'CR' 
	AND T2.DepartmentID LIKE @DepartmentID AND T2.TeamID LIKE @TeamID AND T2.[Ana04ID] LIKE @SectionID AND T2.[Ana05ID] LIKE @ProcessID
	
	-- Update ten Khoi: DepartmentName
	Update	T1
	set		T1.DepartmentName = T2.DepartmentName
	from	#HP0380_MK_HT1414 T1
	inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID and T1.DivisionID = T2.DivisionID

	SET @sSQL1 = '
	
	UPDATE	A
	SET		A.AbsentHour = B.AbsentHour,
			A.LeaveAbsentHour = B.LeaveAbsentHour		
	FROM #HP0380_MK_HT1414 A
	LEFT JOIN
	(
	SELECT	EmployeeID, DivisionID, BeginDate, EndDate, 
			SUM(AbsentHour) as AbsentHour, SUM(LeaveAbsentHour) AS LeaveAbsentHour
	FROM
		(SELECT T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate ,
				SUM(CASE WHEN ISNULL(AbsentAmount,0) > 0 THEN 
														CASE WHEN T2.UnitID = ''H'' THEN AbsentAmount ELSE AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END  ELSE 0 END) AS AbsentHour, 
				SUM(CASE WHEN ISNULL(AbsentAmount,0) < 0 THEN
														 CASE WHEN T2.UnitID = ''H'' THEN (-1) * AbsentAmount ELSE (-1)* AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END ELSE 0 END) AS LeaveAbsentHour 
		FROM HT2401 T1
		LEFT JOIN HT1013 T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
		LEFT JOIN #HP0380_MK_HT1414 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID AND T1.AbsentDate BETWEEN T3.BeginDate AND T3.EndDate 
		WHERE T2.TypeID = ''CN'' AND TranMonth + TranYear*100 <> '+STR(@MaxTranMonth+@MaxTranYear*100)+'
		GROUP BY T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate			
		UNION ALL
		SELECT T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate ,
				SUM(CASE WHEN ISNULL(AbsentAmount,0) > 0 THEN 
														CASE WHEN T2.UnitID = ''H'' THEN AbsentAmount ELSE AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END  ELSE 0 END) AS AbsentHour, 
				SUM(CASE WHEN ISNULL(AbsentAmount,0) < 0 THEN
														 CASE WHEN T2.UnitID = ''H'' THEN (-1) * AbsentAmount ELSE (-1)* AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END ELSE 0 END) AS LeaveAbsentHour 
		FROM '+@TableHT2401+' T1
		LEFT JOIN HT1013 T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
		LEFT JOIN #HP0380_MK_HT1414 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID AND T1.AbsentDate BETWEEN T3.BeginDate AND T3.EndDate 
		WHERE T2.TypeID = ''CN'' 
		GROUP BY T1.EmployeeID, T1.DivisionID, T3.BeginDate, T3.EndDate			
		) T
	GROUP BY T.EmployeeID, T.DivisionID, T.BeginDate, T.EndDate			
	HAVING SUM(AbsentHour) - SUM(LeaveAbsentHour) < 0				
	) B ON A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.BeginDate = B.BeginDate AND A.EndDate = B.EndDate 

	'
	
END
--Print @sSQL1
EXEC(@sSQL1)

UPDATE	A
SET		A.RemainAbsentHour = A.AbsentHour - A.LeaveAbsentHour
FROM #HP0380_MK_HT1414 A

IF @Type = 0
	SELECT *, EmployeeName AS FullName FROM #HP0380_MK_HT1414 ORDER BY EmployeeID
ELSE 
	SELECT * FROM #HP0380_MK_HT1414 WHERE RemainAbsentHour < 0 ORDER BY EmployeeID

DROP TABLE #HP0380_MK_HT1414


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
