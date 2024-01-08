IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0528]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0528]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính tổng thời gian dừng máy (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 20/11/2017
----Modified by on
-- <Example>
---- 
/*-- <Example>	
EXEC [HP0528] @DivisionID = 'NTY', @MachineID = 'CONEBO1', @TranMonth = 10, @TranYear = 2017, @Date = '2017-10-01', @FromTime = '11:30:00', @ToTime = '12:30:00'
	
----*/
CREATE PROCEDURE HP0528
( 
	 @DivisionID VARCHAR(50),
	 @MachineID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @Date DATETIME,
	 @FromTime VARCHAR(50),
	 @ToTime VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',        
		@TotalTime DECIMAL(28,8) = 0,
		@ShiftDay VARCHAR(3) = '',
		@EmployeeID VARCHAR(50),
		@StandardFromTime VARCHAR(50),
		@StandardToTime VARCHAR(50),
		@ShitfID NVARCHAR(50)

SET @ShiftDay = 'D'+CASE WHEN DAY(@Date) < 10 THEN '0'+LTRIM(DAY(@Date)) ELSE LTRIM(DAY(@Date)) END

SELECT @EmployeeID = MAX(EmployeeID)
FROM HT1113 T1 WITH (NOLOCK)
WHERE T1.DivisionID = @DivisionID
AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
AND T1.MachineID = @MachineID

SET @sSQL = '
SELECT @ShitfID = '+@ShiftDay+' FROM HT1025 WITH (NOLOCK)
WHERE DivisionID='''+@DivisionID +'''
AND EmployeeID= '''+@EmployeeID +'''
AND TranMonth + TranYear*100 = '+STR(@TranMonth+@TranYear*100)+''
														
EXEC sp_executesql @sSQL,N'@ShitfID VARCHAR(50) OUTPUT',@ShitfID=@ShitfID OUTPUT

SELECT @StandardFromTime = FromBreakTime, @StandardToTime = ToBreakTime
FROM HT1020 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND ShiftID = @ShitfID

SET @TotalTime = CASE WHEN @ToTime < @StandardFromTime OR @FromTime > @StandardToTime THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,@FromTime,@ToTime))/60
					  WHEN (@StandardFromTime BETWEEN @FromTime AND @ToTime) AND (@StandardToTime BETWEEN @FromTime AND @ToTime)
						THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,@FromTime,@ToTime))/60 - CONVERT(DECIMAL(28,8),DATEDIFF(mi,@StandardFromTime,@StandardToTime))/60
					  WHEN (@StandardFromTime BETWEEN @FromTime AND @ToTime) AND @StandardToTime > @ToTime
						THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,@FromTime,@ToTime))/60 - CONVERT(DECIMAL(28,8),DATEDIFF(mi,@StandardFromTime,@ToTime))/60
					  WHEN (@StandardToTime BETWEEN @FromTime AND @ToTime) AND @StandardFromTime < @FromTime
						THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,@FromTime,@ToTime))/60 - CONVERT(DECIMAL(28,8),DATEDIFF(mi,@FromTime,@StandardToTime))/60
END

SELECT CONVERT(DATETIME,@StandardFromTime,120) AS StandardFromTime, CONVERT(DATETIME,@StandardToTime,120) AS StandardToTime, CASE WHEN @TotalTime <= 0 THEN 0 ELSE @TotalTime END AS TotalTime
			
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
