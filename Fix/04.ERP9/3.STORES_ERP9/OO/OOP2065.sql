IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OOP2065]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2065]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xóa dữ liệu của đơn xin phép sau khi từ chối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 27/10/2016
---- Modified by Phương Thảo on 28/06/2017: Bổ sung xử lý kết chuyển công trừ lương theo quy định thiết lập (ASOFT)
/*-- <Example>
EXEC OOP2065 'MK',N'J2278',6,2016,'EB45FC56-6655-41CA-B8FD-002E8D4BD0B9',1
----*/

CREATE PROCEDURE OOP2065
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @Status TINYINT 
) 
AS 

DECLARE
		@Cur CURSOR,
		@APK VARCHAR(50),
		@LeaveFromDate DATETIME,
		@LeaveToDate DATETIME,
		@TotalTime DECIMAL,
		@EmployeeID VARCHAR(50),
		@Col VARCHAR(3),
		@FromDay INT,
		@ToDay INT,
		@FromMonth INT,
		@ToMonth INT,
		@FromYear INT,
		@ToYear INT,
		@iMonthTotal INT,
		@iYear INT,
		@iDay INT ,
		@AbsentTypeID VARCHAR(50),
		@BeginTimePre DATETIME,
		@EndTimePre DATETIME,
		@iMonthLast INT,
		@OldShiftID VARCHAR(50),
		@ShiftID VARCHAR(50),
		@sSQL NVARCHAR(MAX)='',
		@sSQL1 NVARCHAR(MAX)=''

IF EXISTS (SELECT TOP 1 1 FROM OOT0000 WHERE DivisionID = @DivisionID)
BEGIN
	DECLARE @AccumulateAbsentAmount Decimal(28,8) = 0,
	@HMaxPerMonth decimal(28, 8), @HMaxPerTime decimal(28, 8), @TMaxPerMonth int, @NoSalaryAbsentID nvarchar (50), @MinusSalaryAbsentID nvarchar (50)

	SELECT	@HMaxPerMonth = HMaxPerMonth, @HMaxPerTime = HMaxPerTime, @TMaxPerMonth = TMaxPerMonth, 
			@NoSalaryAbsentID = NoSalaryAbsentID, @MinusSalaryAbsentID = MinusSalaryAbsentID
	FROM OOT0000
	WHERE DivisionID = @DivisionID
		
	SELECT	ROW_NUMBER() OVER(PARTITION BY T1.EmployeeID ORDER BY T1.EmployeeID, OT90.LastModifyDate) AS OrderNum,
			T1.APK, T1.EmployeeID, T1.TotalTime, Convert(Decimal(28,8),0) AS AccumulateAmount
	INTO #OOP2062_OOT2010_DTVS
	FROM OOT2010 T1
	INNER JOIN OOT9000 OT90 ON T1.APKMaster = OT90.APK AND T1.DivisionID = OT90.DivisionID
	WHERE EXISTS (SELECT TOP 1 1 FROM OOT2010 T2
				INNER JOIN OOT9000 T3 ON T2.APKMaster = T3.APK AND T2.DivisionID = T3.DivisionID
				WHERE T2.DivisionID= @DivisionID
				AND T2.APKMaster=@APKMaster
				AND ISNULL(T2.[Status],0)=1 AND T1.EmployeeID = T2.EmployeeID AND OT90.TranMonth = T3.TranMonth AND OT90.TranYear = T3.TranYear
				AND T2.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WHERE IsDTVS = 1)
				)	
		  AND T1.DivisionID = @DivisionID
		  AND T1.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WHERE IsDTVS = 1)
		  AND T1.Status = 1 AND OT90.Status = 1
		  AND (T1.APKMaster <> @APKMaster AND T1.IsValid = 1 OR T1.APKMaster = @APKMaster )
	ORDER BY OT90.LastModifyDate	

	UPDATE T1
	SET @AccumulateAbsentAmount= @AccumulateAbsentAmount+ T1.TotalTime,
		T1.AccumulateAmount = @AccumulateAbsentAmount
	FROM #OOP2062_OOT2010_DTVS T1	


	--select *
	--FROM OOT2010 T1
	--LEFT JOIN #OOP2062_OOT2010_DTVS T2 ON T1.APK = T2.APK
	--WHERE ISNULL(T2.AccumulateAmount,0) <= @HMaxPerMonth AND ISNULL(T1.TotalTime,0) <= @HMaxPerTime
	--and Isnull(OrderNum,0) <= @TMaxPerMonth
	--AND T1.DivisionID= @DivisionID
	--AND T1.APKMaster=@APKMaster
	--AND ISNULL(T1.[Status],0)=1 
	--AND T1.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WHERE IsDTVS = 1)

	UPDATE T1
	SET T1.IsValid = 1
	FROM OOT2010 T1
	LEFT JOIN #OOP2062_OOT2010_DTVS T2 ON T1.APK = T2.APK
	WHERE ISNULL(T2.AccumulateAmount,0) <= @HMaxPerMonth AND ISNULL(T1.TotalTime,0) <= @HMaxPerTime
	and Isnull(OrderNum,0) <= @TMaxPerMonth
	AND T1.DivisionID= @DivisionID
	AND T1.APKMaster=@APKMaster
	AND ISNULL(T1.[Status],0)=1 
	AND T1.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WHERE IsDTVS = 1)

END

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT APK,EmployeeID,LeaveFromDate,LeaveToDate,TotalTime,
DAY(LeaveFromDate) AS FromDay,DAY(LeaveToDate) AS ToDay,
MONTH(LeaveFromDate) AS FromMonth,MONTH(LeaveToDate) AS ToMonth,
YEAR(LeaveFromDate) AS FromYear,YEAR(LeaveToDate) AS ToYear, AbsentTypeID, ShiftID, OldShiftID
FROM OOT2010 WITH (NOLOCK)
WHERE DivisionID= @DivisionID
AND APKMaster=@APKMaster
AND ISNULL([Status],0) <> 1


OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate,@TotalTime, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear,@ToYear,@AbsentTypeID,@ShiftID, @OldShiftID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @iMonthTotal=@FromMonth
	SET @iYear=@FromYear
	 
	SET @iMonthTotal = @ToMonth + 12 * (@ToYear - @FromYear)
	
	DECLARE @j INT =@FromMonth,@iMonth INT =@FromMonth,@i INT =@FromDay,@s VARCHAR(2)
	--SELECT @iMonthTotal iMonthTotal, @iMonth iMonth, @ToYear, @FromYear
	
	WHILE @iMonth<=@iMonthTotal
	BEGIN
		IF @iMonth <= 12
		SET @iMonthLast =  @iMonth 
		
		IF (@iMonth IN (13,25,37,49,61,73,85))
		BEGIN 
			SET @iMonthLast=1
			SET @iYear=@iYear+1
		END
		ELSE
		IF @iMonth > 13 AND @iMonth NOT IN (13,25,37,49,61,73,85)
		BEGIN
			SET @iMonthLast=@iMonthLast+1
		END
		--select @imonth imonth, @iMonthLast iMonthLast
		IF @iMonthLast = @FromMonth AND @iYear=@FromYear  SET @i=@FromDay
		ELSE SET  @i=1

		IF @iMonthLast = @ToMonth AND @iYear=@ToYear  SET @iDay=@ToDay
		ELSE SET  @iDay=DAY(EOMONTH(CONVERT(date,'01/'+STR(@iMonthLast)+'/'+STR(@iYear),103)))
		
		WHILE @i <= @iDay
		BEGIN
		
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)
			SET @Col = 'D'+@s

			-----Update lại ca cũ cho HT1025
			IF ISNULL(@ShiftID,'') <> '' 
				AND EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonthLast AND TranYear=@iYear)
			BEGIN

				SET @sSQL='UPDATE  HT1025 
							SET D'+@s+'='''+@OldShiftID+''',
								LastModifyUserID = '''+@UserID+''',
								LastModifyDate = GETDATE(),
								Notes = ''''
							WHERE DivisionID='''+@DivisionID+''' 
							AND EmployeeID='''+@EmployeeID +'''
							AND TranMonth='+STR(@iMonthLast)+'
							AND TranYear='+STR(@iYear)+''
				
			END

			IF ISNULL(@ShiftID,'') <> '' 
				AND EXISTS (SELECT TOP 1 1 FROM OOT2000 
							LEFT JOIN OOT9000 ON OOT2000.APKMaster=OOT9000.APK
							WHERE OOT2000.DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonthLast AND TranYear=@iYear)
			BEGIN
				SET @sSQL1=N'UPDATE  T1 
							SET D'+@s+'='''+@OldShiftID+''' ,
								Note = ''''
							FROM OOT2000 T1
							LEFT JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T2.APK = T1.APKMaster
						    WHERE T1.DivisionID='''+@DivisionID+''' 
							AND T1.EmployeeID='''+@EmployeeID +'''
							AND T2.TranMonth='+STR(@iMonthLast)+'
							AND T2.TranYear='+STR(@iYear)+''
			END

			EXEC (@sSQL)
			EXEC (@sSQL1)
			--PRINT (@sSQL)

			SET @i =  @i + 1
			
		END
			
		SET @iMonth=@iMonth+1
	END
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate,@TotalTime, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear,@ToYear,@AbsentTypeID, @ShiftID, @OldShiftID
END 
Close @Cur 

----Xóa chấm công trong HT2401_MK
DELETE HT24
FROM HT2401_MK HT24
INNER JOIN OOT2010 OOT20 WITH (NOLOCK) ON OOT20.DivisionID = HT24.DivisionID AND OOT20.APKMaster = HT24.APKMaster
AND OOT20.APKMaster =@APKMaster 
AND ISNULL(OOT20.Status,0)=0


INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
						TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
						AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT OOT10.APKMaster, OOT10.DivisionID, Convert(Date,LeaveFromDate) AS AbsentDate, OOT10.EmployeeID,
	OT90.TranMonth, HT14.DepartmentID, OT90.TranYear, HT14.TeamID, @MinusSalaryAbsentID,
	OOT10.TotalTime, @UserID, OT90.CreateDate, @UserID, GetDate()
FROM OOT2010 OOT10
INNER JOIN OOT9000 OT90 ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
LEFT JOIN HT2400 HT14 ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = OOT10.EmployeeID 
						AND HT14.TranMonth = OT90.TranMonth AND HT14.TranYear = OT90.TranYear
LEFT JOIN OOT1000 ON OOT10.AbsentTypeID = OOT1000.AbsentTypeID AND OOT10.DivisionID = OOT1000.DivisionID
WHERE OOT10.APKMaster =@APKMaster 
AND ISNULL(OOT10.Status,0)=0
AND ( EXISTS (SELECT TOP 1 1 FROM OOT0000 WHERE DivisionID = @DivisionID) AND ISNULL(OOT10.IsValid,0) = 0
	AND OOT1000.IsDTVS = 1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

