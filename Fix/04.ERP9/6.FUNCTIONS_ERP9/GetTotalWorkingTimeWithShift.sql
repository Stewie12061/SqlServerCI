IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[GetTotalWorkingTimeWithShift]') AND XTYPE IN (N'FN', N'IF', N'TF'))
	DROP FUNCTION [GetTotalWorkingTimeWithShift]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính [công làm việc thường] trong 1 khoảng ca không tính giờ nghỉ.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:	 Văn Tài	- 30/06/2022: Lấy tổng thời gian làm việc.
-- <Example>

CREATE function GetTotalWorkingTimeWithShift
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @FromDate DATETIME,
  @ToDate DATETIME,
  @ShiftID VARCHAR(50) = ''
) 
RETURNS DECIMAL(28,2)
AS 
BEGIN
	----------Data default test
	--DECLARE @DivisionID varchar(50)= 'MT'
	--DECLARE @FromDate DATETIME = '2022-06-07 10:00:00'
	--DECLARE @ToDate DATETIME = '2022-06-07 17:00:00'
	--DECLARE @ShiftID varchar(50)= 'CHC'
	--------------------------

	DECLARE @TotalTime DECIMAL(28,8) = 0
			, @DateTypeID VARCHAR(50)=N''
			, @DatePartDw int = 1
			, @IsOverTime int = 0 -- 0: Công thường | 1: công OT
			, @FreeMinute int = 0 -- Khoảng cách giữa 2 nghỉ giữa các CA
			, @TotalOT decimal(28,2) = 0
			, @MinDateInShift datetime = NULL
			, @MaxDateInShift datetime = NULL
			, @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))
			, @AbsentTypeID VARCHAR(50) = NULL -- Mã loại công nhật khai báo theo từng db khách hàng.

	-- *******************************************************************
	IF (@CustomerIndex = 92) -- Minh Trị, cùng index ASOFT.
	BEGIN
		SET @AbsentTypeID = 'N.CNT'
	END
	-- *******************************************************************

	DECLARE @tbl_Shift table (Orders int identity(1,1), FromDate DATETIME, ToDate DATETIME)
	--Xác định thứ (DateTypeID) từ ngày

	SET @DatePartDw = DATEPART(dw , @FromDate)
	SELECT @DateTypeID = CASE 
		WHEN @DatePartDw = 1 THEN 'SUN'
		WHEN @DatePartDw = 2 THEN 'MON'
		WHEN @DatePartDw = 3 THEN 'TUE'
		WHEN @DatePartDw = 4 THEN 'WED'
		WHEN @DatePartDw = 5 THEN 'THU'
		WHEN @DatePartDw = 6 THEN 'FRI'
		WHEN @DatePartDw = 7 THEN 'SAT'
		ELSE ''
	END

	--Get CA làm việc trong khoảng thời gian xin phép
	INSERT INTO @tbl_Shift(FromDate,ToDate)
	Select DISTINCT DATEADD(day, DATEDIFF(day,0, @FromDate), HT1021.FromMinute) AS  FromDate
					, CASE 
						WHEN IsNextDay = 1
						THEN DATEADD(day, DATEDIFF(day,-1, @FromDate), HT1021.ToMinute)
						ELSE
							DATEADD(day, DATEDIFF(day,0, @FromDate), HT1021.ToMinute) 
						END as ToDate 
			  From HT1021 WITH (NOLOCK) 
			  where 1 = 1
					and HT1021.DivisionID = @DivisionID
					and HT1021.ShiftID = @ShiftID
					And HT1021.DateTypeID = @DateTypeID
					AND HT1021.IsOvertime = @IsOverTime
					AND HT1021.AbsentTypeID = @AbsentTypeID
	
	-- Xác định thời gian nghỉ (free) trong khoảng ca
	SELECT @FreeMinute = DATEDIFF(MINUTE,t1.ToDate, t2.FromDate)
	FROM @tbl_Shift t1
	INNER JOIN @tbl_Shift t2 ON t1.Orders + 1 = t2.Orders
	WHERE t1.ToDate >= @FromDate 
			AND t2.FromDate <=  @ToDate

	-- TEST
	--SELECT @FreeMinute
	--SELECT @ToDate
	
	-- Xác định khoảng thời gian CA, cập nhật lại TỪ ngày nếu không thuộc khoảng CA
	SELECT @MinDateInShift =  MIN(t1.FromDate)
	FROM @tbl_Shift t1		
	WHERE t1.ToDate >= @FromDate 
	IF DATEDIFF(MINUTE, @FromDate, @MinDateInShift) > 0
	BEGIN		
		SET @FromDate = @MinDateInShift
	END 
	
	-- Xác định khoảng thời gian CA, cập nhật lại ĐẾN ngày nếu không thuộc khoảng CA
	SELECT @MaxDateInShift = MAX(t1.ToDate)
	FROM @tbl_Shift t1		

	IF DATEDIFF(MINUTE, @ToDate, @MaxDateInShift) < 0
	BEGIN		
		SET @ToDate = @MaxDateInShift
	END 

	SET @TotalOT = DATEDIFF(MINUTE, @FromDate, @ToDate) - ISNULL(@FreeMinute,0)	
	
	--SELECT * FROM @tbl_Shift
	--SELECT @FreeMinute
	--SELECT DATEDIFF(MINUTE, @FromDate, @ToDate)

	RETURN CASE WHEN @TotalOT / 60 < 0 THEN 0 ELSE  @TotalOT / 60 END

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
