IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- trả ra ca danh sách ca của nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Bảo Thy, Date: 05/07/2016
--- Modify on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
/*-- <Example>
	OOP2015 @DivisionID='MK', @UserID='000110', @FromDate='2016-06-01 00:00:00.000', @ToDate='2016-06-20 00:00:00.000', @TranMonth=6,
	@TranYear=2016,@EmployeeID='000322'
----*/

CREATE PROCEDURE OOP2015
(
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @FromDate Date,
  @ToDate Date,
  @TranMonth INT,
  @TranYear INT,
  @EmployeeID VARCHAR(MAX)
  
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)='',
		@FromDay INT,
		@FromMonth INT,
		@ToDay INT,
		@ToMonth INT

SET @FromDay = DATEPART(d,@FromDate)
SET @FromMonth = DATEPART(m,@FromDate)
SET @ToDay = DATEPART(d,@ToDate)
SET @ToMonth = DATEPART(m,@ToDate)

CREATE TABLE #Shift (DivisionID VARCHAR(50), EmployeeID VARCHAR(50), ShiftID VARCHAR(50))

DECLARE @i INT, @sDay VARCHAR(10),@ColDay VARCHAR(10)

SELECT @i = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @FromDate

WHILE @i <= (SELECT DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @ToDate)
		BEGIN
			
			IF @i < 10 SET @sDay = '0' + CONVERT(NVARCHAR, @i)
			ELSE SET @sDay = CONVERT(NVARCHAR, @i)

			SET @ColDay = 'D'+@sDay

			SELECT @sSQL = '
			INSERT INTO #Shift (DivisionID, EmployeeID, ShiftID) --, BeginTime, EndTime	)
			SELECT	T1.DivisionID, T1.EmployeeID, '+@ColDay+' AS ShiftID
			FROM	HT1025 T1
			--LEFT JOIN HT1020 T2 ON T1.DivisionID = T2.DivisionID AND '+@ColDay+' = T2.ShiftID
			WHERE  T1.DivisionID='''+@DivisionID+'''		
				AND T1.TranMonth='+STR(@TranMonth)+'
				AND T1.TranYear='+STR(@TranYear)+'	
				AND EmployeeID = '''+@EmployeeID+'''	
			'
			--Print @sSQL
			EXEC (@sSQL)

			SET @i = @i + 1

		END

SELECT DISTINCT #Shift.*, ShiftName FROM #Shift
LEFT JOIN HT1020 ON #Shift.ShiftID = HT1020.ShiftID
ORDER BY #Shift.ShiftID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
