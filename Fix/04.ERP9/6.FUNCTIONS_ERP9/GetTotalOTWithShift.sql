IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[GETTOTALOTWITHSHIFT]') AND XTYPE IN (N'FN', N'IF', N'TF'))
	DROP FUNCTION [GETTOTALOTWITHSHIFT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính tổng thời gian OT trong 1 khoảng ca.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:	 Bảo Toàn	- 06/06/2020: Lấy tổng thời gian OT
----Modify by:	 Bảo Toàn	- 12/06/2020: Điều chỉnh tính lại theo ngày kế tiếp IsNextDay
----Modify by:	 Bảo Toàn	- 19/06/2020: Điều chỉnh tính lại theo ngày kế tiếp IsNextDay với FromDate
-- <Example>

CREATE function GetTotalOTWithShift
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @FromDate DATETIME,
  @ToDate DATETIME,
  @ShiftID VARCHAR(50) = ''
) 
returns decimal(28,2)
AS 
begin
	----------Data default test
	--DECLARE @DivisionID varchar(50)= 'MA'
	--DECLARE @FromDate varchar(50)= '2020-06-19 22:00:00'
	--DECLARE @ToDate varchar(50)= '2020-06-20 06:00:00'
	--DECLARE @ShiftID varchar(50)= 'OT_CA09'
	--------------------------
	DECLARE @TotalTime DECIMAL(28,8) = 0
			,@DateTypeID VARCHAR(50)=N''
			,@DatePartDw int = 1
			,@IsOverTime int = 1 -- là công OT
			,@FreeMinute int = 0 -- Khoảng cách giữa 2 nghỉ giữa các CA
			,@TotalOT decimal(28,2) = 0
			,@MinDateInShift datetime = NULL
			,@MaxDateInShift datetime = NULL
	DECLARE @tbl_Shift table (Orders int identity(1,1), FromDate datetime, ToDate datetime)
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
					And HT1021.DateTypeID =@DateTypeID
					AND HT1021.IsOvertime = @IsOverTime
	
	-- Xác định thời gian nghỉ (free) trong khoảng ca
	Select @FreeMinute = SUM(DATEDIFF(MINUTE,t1.ToDate, t2.FromDate))
	from @tbl_Shift t1
		inner join @tbl_Shift t2 on t1.Orders + 1 = t2.Orders
	where t1.ToDate >= @FromDate AND t2.FromDate <= @ToDate

	
	-- Xác định khoảng thời gian CA, cập nhật lại TỪ ngày nếu không thuộc khoảng CA
	SELECT @MinDateInShift =  Min(t1.FromDate )
	from @tbl_Shift t1		
	where t1.ToDate >= @FromDate 
	IF DATEDIFF(MINUTE, @FromDate, @MinDateInShift) > 0
	BEGIN		
		SET @FromDate = @MinDateInShift
	END 
	
	-- Xác định khoảng thời gian CA, cập nhật lại ĐẾN ngày nếu không thuộc khoảng CA
	select @MaxDateInShift = MAX(t1.ToDate)
	from @tbl_Shift t1		

	IF DATEDIFF(MINUTE, @ToDate, @MaxDateInShift) < 0
	BEGIN		
		SET @ToDate = @MaxDateInShift
	END 

	SET @TotalOT = DATEDIFF(MINUTE, @FromDate, @ToDate) - ISNULL(@FreeMinute,0)	
	--SELECT CASE WHEN @TotalOT / 60 < 0 THEN 0 ELSE  @TotalOT / 60 END
	RETURN CASE WHEN @TotalOT / 60 < 0 THEN 0 ELSE  @TotalOT / 60 END
end





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
