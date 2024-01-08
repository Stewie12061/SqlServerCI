IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0409]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0409]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In báo cáo theo dõi phép năm mẫu 2 (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 17/01/2017
----Modified on 14/10/2019 by Học Huy: (79) Sửa câu Where TeamID bằng rỗng hoặc null, (180) Sửa TranMonth BETWEEN tháng hiện tại thành tháng 1
----Modified on 02/12/2023 by Đình Định: APT - Lấy chấm công tháng lên báo cáo phép năm.
-- <Example>
---- EXEC HP0409 'MK', '2016-12-31', 'M000000', 'MA10000'',''MA30000'',''MA40000'',''MA20000'',''MA50000', '000224'',''000250'',''000291'',''000303'',''000312'',''000327'',''000341'
/*-- <Example>

----*/

CREATE PROCEDURE HP0409
( 
	@DivisionID VARCHAR(50),
	@ReportDate DATETIME,
	@ListDepartmentID NVARCHAR(MAX),
	@ListTeamID NVARCHAR(MAX),
	@ListEmployeeID NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @MethodVacationID NVARCHAR(50),
        @EmployeeID NVARCHAR(50),
        @DaysPrevMonth DECIMAL(28,8),
        @DaysPrevYear DECIMAL(28,8),
        @IsManagaVacation TINYINT,
        @VacationDay DECIMAL(28,8),
        @SeniorityID NVARCHAR(50),
        @FromValues DECIMAL(28,8),
        @ToValues DECIMAL(28,8),
		@TranMonth INT,
        @Cur CURSOR,
		@CustomerName INT = (SELECT CustomerName FROM CustomerIndex WITH(NOLOCK))

SELECT TOP 1 @TranMonth = ISNULL(MIN(TranMonth),1) 
FROM HT2803 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TranYear = YEAR(@ReportDate)     

--- Tạo table lưu phép năm trước, trong năm, thâm niên
DECLARE @AddDays DECIMAL(28,8), @VacSeniorDays DECIMAL(28,8), @Days DECIMAL(28,8)
CREATE TABLE #HP0409_1 (DivisionID NVARCHAR(50), EmployeeID NVARCHAR(50), DayPreYear DECIMAL(28,8), 
	AddDays DECIMAL(28,8), VacSeniorDays DECIMAL(28,8), FromValues DECIMAL(28,8), ToValues DECIMAL(28,8))

IF ISNULL(@ListEmployeeID,'') = ''
	SET @sWhere = @sWhere + ' 
		AND H03.EmployeeID LIKE ''%'' '
ELSE 
	SET @sWhere = @sWhere + ' 
		AND H03.EmployeeID IN ('''+@ListEmployeeID+''') '
	
IF ISNULL(@ListDepartmentID,'') = ''
	SET @sWhere = @sWhere + ' 
		AND DepartmentID LIKE ''%'' '
ELSE 
	SET @sWhere = @sWhere + ' 
		AND DepartmentID IN ('''+@ListDepartmentID+''') '
	
IF ISNULL(@ListTeamID,'') = ''
	SET @sWhere = @sWhere + ' 
		AND (TeamID LIKE ''%'' OR TeamID IS NULL) '
ELSE 
	SET @sWhere = @sWhere + ' 
		AND TeamID IN ('''+@ListTeamID+''') '

SET @sSQL = '
	SELECT H03.MethodVacationID, H27.SeniorityID, H03.EmployeeID, H29.IsManagaVacation, H03.DaysPrevMonth, H03.DaysPrevYear
	FROM HT2803 H03 WITH (NOLOCK) 
		LEFT JOIN HV1400 WITH (NOLOCK) ON HV1400.DivisionID = H03.DivisionID AND HV1400.EmployeeID = H03.EmployeeID
		LEFT JOIN HT1029 H29 WITH (NOLOCK) ON H29.DivisionID = H03.DivisionID AND H29.MethodVacationID = H03.MethodVacationID
		LEFT JOIN HT1027 H27 WITH (NOLOCK) ON H27.DivisionID = H29.DivisionID AND H27.SeniorityID = H29.SeniorityID
		LEFT JOIN HT1028 H28 WITH (NOLOCK) ON H28.DivisionID = H27.DivisionID AND H28.SeniorityID = H27.SeniorityID
	WHERE H03.DivisionID = '''+@DivisionID+''' 
		AND H03.TranMonth = ' + CONVERT(NVARCHAR(5),@TranMonth) + ' 
		AND H03.TranYear = ' + CONVERT(NVARCHAR(5),YEAR(@ReportDate)) + 
		@sWhere

--PRINT @sSQL
IF EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'HV0409')
BEGIN 
	DROP VIEW HV0409
END 
	EXEC (' CREATE VIEW HV0409 AS ' + @sSQL)

SET @Cur = CURSOR SCROLL KEYSET FOR 
SELECT MethodVacationID, SeniorityID, EmployeeID, IsManagaVacation, DaysPrevMonth, DaysPrevYear
FROM HV0409
OPEN @Cur
	FETCH NEXT FROM @Cur INTO  @MethodVacationID, @SeniorityID, @EmployeeID, @IsManagaVacation, @DaysPrevMonth, @DaysPrevYear

	WHILE @@FETCH_STATUS = 0 
		BEGIN
    		DECLARE @Month INT 
    		SELECT @Month = MAX(ISNULL(TranMonth,0)) 
			FROM HT2803 WITH (NOLOCK) 
			WHERE DivisionID = @DivisionID 
				AND EmployeeID = @EmployeeID 
				AND TranYear = YEAR(@ReportDate) 
				AND IsAdded = 1
    	
    		SET @Days = ROUND(@VacationDay/12,0)
    		SELECT @VacationDay = VacationDay 
			FROM HT1029 WITH (NOLOCK) 
			WHERE DivisionID = @DivisionID 
				AND MethodVacationID = @MethodVacationID
    	
    		IF @Month <> 12
    			BEGIN 
    				SET @AddDays = @Days * @Month
    			END
    		ELSE 
    			BEGIN
    				SET @AddDays = @VacationDay
    			END
    	
    		SELECT @VacSeniorDays = MAX(ISNULL(VacSeniorDays,0)) 
			FROM HT2803 WITH (NOLOCK) 
			WHERE DivisionID = @DivisionID 
				AND EmployeeID = @EmployeeID 
				AND TranYear = YEAR(@ReportDate) 
				AND TranMonth BETWEEN 1 AND 12

    		SELECT TOP 1 @FromValues = FromValues, @ToValues = ToValues 
			FROM HT1028 WITH (NOLOCK) 
			WHERE DivisionID = @DivisionID 
				AND SeniorityID = @SeniorityID 
				AND @VacSeniorDays = VacSeniorDays
    	
    		IF NOT EXISTS (SELECT TOP 1 1 FROM #HP0409_1 WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
    		INSERT INTO #HP0409_1 (DivisionID, EmployeeID, DayPreYear, AddDays, VacSeniorDays, FromValues, ToValues)
    		VALUES (@DivisionID, @EmployeeID, @DaysPrevYear, @AddDays, @VacSeniorDays, @FromValues, @ToValues)
    	
			FETCH NEXT FROM @Cur INTO @MethodVacationID, @SeniorityID, @EmployeeID, @IsManagaVacation, @DaysPrevMonth, @DaysPrevYear
		END 

CLOSE @Cur

---------- Lấy số ngày công phép
CREATE TABLE #HP0409_2 (DivisionID NVARCHAR(50), EmployeeID NVARCHAR(50), TranMonth INT, TranYear INT, 
	AbsentTypeID NVARCHAR(50), IsAnnualLeave TINYINT, DaysSpent DECIMAL(28,8) )

INSERT INTO #HP0409_2(DivisionID, EmployeeID, TranMonth, TranYear, AbsentTypeID, IsAnnualLeave, DaysSpent)
SELECT H02.DivisionID, H02.EmployeeID, H02.TranMonth, H02.TranYear, H02.AbsentTypeID, H13.IsAnnualLeave,
	   SUM(CASE WHEN H13.UnitID = 'H' THEN ISNULL((AbsentAmount/8),0) ELSE ISNULL(AbsentAmount,0) END) AS DaysSpent
FROM HT2402 H02 WITH (NOLOCK)
	LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H02.DivisionID AND H13.AbsentTypeID = H02.AbsentTypeID
WHERE H13.TypeID = 'P' AND H13.IsMonth = 1 
	AND TranMonth BETWEEN 1 AND MONTH(@ReportDate) 
	AND TranYear = YEAR(@ReportDate)
GROUP BY H02.DivisionID, H02.EmployeeID, H02.TranMonth, H02.TranYear, H02.AbsentTypeID, H13.IsAnnualLeave

DECLARE @AbsentDate DATETIME, @AbsentTypeID NVARCHAR(MAX), @DayIndex INT 
CREATE TABLE #HP0409_3 (DivisionID NVARCHAR(50), EmployeeID NVARCHAR(50),DayIndex INT, AbsentTypeID NVARCHAR(500))

IF @CustomerName = 27 
	BEGIN
		SET @sSQL1 = '
		 	SELECT DISTINCT H03.EmployeeID, OT20.LeaveFromDate AS AbsentDate, H03.AbsentTypeID
			  FROM HT2402 H03 WITH (NOLOCK) 
			  LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H03.DivisionID AND H13.AbsentTypeID = H03.AbsentTypeID
			  LEFT JOIN OOT2010 OT20 WITH (NOLOCK) ON H03.DivisionID = OT20.DivisionID AND OT20.EmployeeID = H03.EmployeeID
			WHERE H03.DivisionID  = ''' + @DivisionID + ''' 
			   AND H13.TypeID = ''P''  AND H13.IsMonth = 1 
			   AND H03.TranMonth BETWEEN 1 AND ' + CONVERT(NVARCHAR(5),MONTH(@ReportDate)) + '
			   AND TranYear = ' + CONVERT(NVARCHAR(5),YEAR(@ReportDate)) + 
			 	@sWhere
	END
ELSE
	BEGIN
		SET @sSQL1 = '
			SELECT H03.EmployeeID, H03.AbsentDate, H03.AbsentTypeID
			  FROM HT2401 H03 WITH (NOLOCK) 
			  LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = H03.DivisionID AND H13.AbsentTypeID = H03.AbsentTypeID
			 WHERE H03.DivisionID  = ''' + @DivisionID + ''' 
			   AND H13.TypeID = ''P'' 
			   AND H13.IsMonth = 0 
			   AND H03.TranMonth BETWEEN 1 AND ' + CONVERT(NVARCHAR(5),MONTH(@ReportDate)) + '
			   AND TranYear = ' + CONVERT(NVARCHAR(5),YEAR(@ReportDate)) + 
			 	@sWhere
	END

PRINT @sSQL1
IF EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'HV0409_1')
BEGIN 
	DROP VIEW HV0409_1
END 
EXEC (' CREATE VIEW HV0409_1 AS ' + @sSQL1)		
		
SET @Cur = CURSOR SCROLL KEYSET FOR 
SELECT EmployeeID, AbsentDate, AbsentTypeID
FROM HV0409_1

OPEN @Cur
FETCH NEXT FROM @Cur INTO @EmployeeID, @AbsentDate, @AbsentTypeID  
	WHILE @@FETCH_STATUS = 0 
    BEGIN
    	SET @DayIndex = 0
    	SELECT @DayIndex = DATEPART(DAYOFYEAR, @AbsentDate)

    	IF NOT EXISTS 
		(
			SELECT TOP 1 1 
			FROM #HP0409_3 
			WHERE DivisionID = @DivisionID 
				AND EmployeeID = @EmployeeID 
				AND DayIndex = @DayIndex
		)
    	BEGIN 
    		INSERT INTO #HP0409_3 (DivisionID, EmployeeID, DayIndex, AbsentTypeID)
    		VALUES (@DivisionID, @EmployeeID, @DayIndex, @AbsentTypeID)
    	END 
    	ELSE 
    	BEGIN
    		UPDATE #HP0409_3
    		SET AbsentTypeID = AbsentTypeID + ';' + @AbsentTypeID
    		WHERE DivisionID = @DivisionID AND  EmployeeID = @EmployeeID AND DayIndex = @DayIndex
    	END
		FETCH NEXT FROM @Cur INTO @EmployeeID, @AbsentDate, @AbsentTypeID  
    END 
CLOSE @Cur

IF NOT EXISTS (SELECT TOP 1 1 FROM #HP0409_3)
BEGIN
	SELECT 1 AS [DayIndex]
	INTO HP0409_4
END
ELSE 
	SELECT DISTINCT DayIndex 
	INTO HP0409_4
	FROM #HP0409_3

DECLARE @sSQL2 NVARCHAR(MAX) = '', @sSQL3 NVARCHAR(MAX) = ''

IF EXISTS (SELECT TOP 1 1 FROM HP0409_4)
BEGIN

	SELECT @sSQL2 = @sSQL2 +
	'
	SELECT	T.*, HV1400.FullName, HV1400.WorkDate, HV1400.MobiPhone, HV1400.DepartmentName, HV1400.DutyName, HV1400.ImageID
	
	FROM	
	(
		SELECT	H03.*
		FROM #HP0409_3 H03
	) P
	PIVOT
	(
		MAX(AbsentTypeID) FOR DayIndex IN ('
			SELECT	@sSQL3 = @sSQL3 + CASE WHEN @sSQL3 <> '' THEN ',' ELSE '' END + '['+CONVERT(NVARCHAR(5),DayIndex)+']'
			FROM	HP0409_4
			ORDER BY DayIndex
			SELECT	@sSQL3 = @sSQL3 +')
	) AS T
	LEFT JOIN HV1400 WITH (NOLOCK) ON HV1400.DivisionID = T.DivisionID AND HV1400.EmployeeID = T.EmployeeID	'
END
PRINT @sSQL2
PRINT @sSQL3 
EXEC (@sSQL2+@sSQL3)

DROP TABLE HP0409_4

SELECT H01.*, H02.TranMonth, H02.TranYear, H02.AbsentTypeID, HT1013.AbsentName, H02.IsAnnualLeave, H02.DaysSpent
FROM #HP0409_1 H01
	LEFT JOIN #HP0409_2 H02 ON H02.DivisionID = H01.DivisionID AND H02.EmployeeID = H01.EmployeeID
	LEFT JOIN HT1013 WITH (NOLOCK) ON HT1013.DivisionID = H02.DivisionID AND HT1013.AbsentTypeID = H02.AbsentTypeID
ORDER BY H02.AbsentTypeID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
