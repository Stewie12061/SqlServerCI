IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'RangeWeekInMonth' AND [TYPE] = 'TF')
	DROP FUNCTION RangeWeekInMonth
GO
-- <Summary>
---- Trả ra các tuần của 1 tháng trong năm (Tính theo ngày bắt đầu và ngày kết thúc năm từ bảng AT1101)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Viết Toàn on 23/08/2023
-- <Example>
CREATE FUNCTION [dbo].RangeWeekInMonth
(
    @Month INT, @Year INT
)
RETURNS @RESULT TABLE(WeekName VARCHAR(MAX))
AS
BEGIN     
	 DECLARE @StartDate DATETIME = CAST((SELECT TOP 1 CONCAT(@Year, '-', MONTH(StartDate), '-01') FROM AT1101 ORDER BY BeginYear) AS DATETIME),
			 @EndDate DATETIME = CAST((SELECT TOP 1 CONCAT(BeginYear, '-', MONTH(EndDate), '-', DAY(EndDate)) FROM AT1101 ORDER BY BeginYear) AS DATETIME),
			 @NumWeek INT, -- Số tuần chênh lệch từ tuần đầu tiên của năm -> tuần đầu tiên của tháng tính theo thời gian bắt đầu và kết thúc của khách hàng (Từ bảng AT1101)
			 @NumWeek1 INT, -- Số tuần 
			 @Pointer INT = 0,
			 @Next INT = 0,
			 @tmpMonth INT  =0,
			 @tmpEndWeekLastMonth INT = 0,
			 @tmpBeginWeek4 INT = 0,
			 @tmpYear INT =0,
			 @tmpEndWeek4 INT = 0,
			 @tmpLastWeekForCurrentYear INT = 0,
			 @tmpClr INT = 0

	IF @Month >= 1 AND @Month <= 12
	BEGIN
		--INSERT INTO @RESULT VALUES (CONVERT(VARCHAR(50),@StartDate)) Return
		SET @tmpYear = @Year
		
		SET @Year = IIF(@Month < MONTH(@StartDate), YEAR(@StartDate) + 1, YEAR(@StartDate))
		--INSERT INTO @RESULT VALUES (CONVERT(VARCHAR(50),@tmpYear)) Return

		DECLARE 
				@BeginWeek1 INT = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, @StartDate),0)), -- Tuần bắt đầu của tháng đầu tiên
				@EndWeek1 INT = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,@StartDate)+1, 0))), -- Tuần kết thúc của tháng đầu tiên
				@BeginWeek3 INT = DATEPART(WW, CONCAT(@Year,'-12-01')),-- Tuần bắt đầu của tháng 12
				@EndWeek3 INT = DATEPART(WW, CONCAT(@Year, '-12-31')), -- Tuần kết thúc của tháng 12
				@BeginWeek4 INT = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, CONCAT(@Year, '-', @Month, '-01')),0)),-- Tuần bắt đầu của tháng truyền vào
				@EndWeek4 INT = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@Year, '-', @Month, '-01'))+1, 0))), -- Tuần kết thúc của tháng truyền vào CONCAT(IIF(@Month < 4, @Year + 1, @Year), '-', @Month, '-01')),
				@EndWeekLastMonth INT = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@Year, '-', IIF(@Month <> 1, @Month - 1, 12), '-01'))+1, 0)))	

		SET @NumWeek = @BeginWeek1 - 1 -- Số tuần tính từ tuần đầu tiên của năm -> Tuần bắt đầu của tháng đầu tiên 

		IF (@Month >= MONTH(@StartDate))
		BEGIN
			SET @BeginWeek4 = @BeginWeek4 - @NumWeek
			SET @EndWeek4 = @EndWeek4 - @NumWeek
		END


		SET @tmpMonth = @Month
		SET @tmpEndWeekLastMonth = @EndWeekLastMonth
		SET @tmpBeginWeek4 = @BeginWeek4
		SET @tmpEndWeek4 = @EndWeek4


		IF (@tmpMonth >= MONTH(@StartDate) AND @tmpYear = @Year)
		BEGIN

			SET @tmpEndWeekLastMonth = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@Year, '-', IIF(@tmpMonth <> 1, @tmpMonth - 1, 12), '-01'))+1, 0)))
			SET @tmpBeginWeek4 = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, CONCAT(@Year, '-', @tmpMonth, '-01')),0))

			IF ((@tmpEndWeekLastMonth != @tmpBeginWeek4) AND (MONTH(@StartDate) <> @tmpMonth)AND DATEPART(W, DATEADD(mm, DATEDIFF(mm, 0, CONCAT(@tmpYear, '-', @tmpMonth, '-01')),0)) = 1)
			BEGIN
				SET @BeginWeek4 = @BeginWeek4 -1
			END

			IF ( datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-', IIF(@tmpMonth <> 1, @tmpMonth, 12), '-01'))+1, 0)) AS NVARCHAR(50))) = 1)
			BEGIN
				SET @Next = @Next -1
			END

			WHILE @BeginWeek4 <= @EndWeek4 + @Next
			BEGIN
				INSERT @RESULT VALUES(@BeginWeek4 + @Pointer) 
				SET @BeginWeek4 = @BeginWeek4 + 1 
			END
		END
		ELSE
		BEGIN
			SET @tmpMonth = 12
			SET @tmpEndWeekLastMonth = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-', IIF(@tmpMonth <> 1, @tmpMonth - 1, 12), '-01'))+1, 0)))
			SET @tmpBeginWeek4 = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, CONCAT(@tmpYear, '-', @tmpMonth, '-01')),0)) - @NumWeek
			SET @tmpEndWeek4 = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-', @tmpMonth, '-01'))+1, 0))) - @NumWeek

			SET @tmpEndWeekLastMonth = DATEPART(WW, DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@Year, '-', IIF(@tmpMonth <> 1, @tmpMonth - 1, 12), '-01'))+1, 0)))
			SET @tmpBeginWeek4 = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, CONCAT(@Year, '-', @tmpMonth, '-01')),0))

			SET @tmpClr = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, CONCAT(@tmpYear, '-', 12, '-01')),0))  - @NumWeek

			WHILE @tmpClr <= @tmpEndWeek4
			BEGIN
				SET @tmpLastWeekForCurrentYear = @tmpClr + @Pointer
				SET @tmpClr = @tmpClr + 1
			END

			-- Ngày cuối cùng của tháng 12 không phải là ngày chủ nhật thì và tháng hiện tại là tháng 1: trừ 1 tuần (Vì chưa hết tuần hiện tại khi qua năm mới)
			IF (datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@Year, '-', IIF(@tmpMonth <> 1, @tmpMonth - 1, 12), '-01'))+1, 0)) AS NVARCHAR(50))) != 1 AND @Month =1)
			BEGIN
				SET @tmpLastWeekForCurrentYear = @tmpLastWeekForCurrentYear - 1
			END
			-- Ngày cuối cùng của tháng 12 không phải là ngày chủ nhật thì và tháng hiện tại không phải là tháng 1: trừ 1 tuần (Vì chưa hết tuần hiện tại khi qua năm mới)
			IF (datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@Year, '-', IIF(@tmpMonth <> 1, @tmpMonth - 1, 12), '-01'))+1, 0)) AS NVARCHAR(50))) != 1 AND @Month !=1)
			BEGIN
				SET @tmpLastWeekForCurrentYear = @tmpLastWeekForCurrentYear - 1
				IF ( datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-',@Month, '-01'))+1, 0)) AS NVARCHAR(50))) != 1)
				BEGIN
					SET @BeginWeek4 = @BeginWeek4 -1
				END
			END

			SET @Next = 0
			SET @Pointer =0 


			--INSERT INTO @RESULT VALUES (CONVERT(VARCHAR(50),@BeginWeek4)) Return

			-- Ngày cuối cùng của tháng trước là ngày chủ nhật thì: tăng tuần thêm 1
			IF ((@tmpEndWeekLastMonth = @tmpBeginWeek4) AND (MONTH(@StartDate) <> @Month)AND datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-', IIF(@Month <> 1, @Month - 1, 12), '-01'))+1, 0)) AS NVARCHAR(50))) = 1)
			BEGIN
				SET @Next = @Next + 1
			END
			ELSE-- Ngày kết thúc của tháng hiện tại là ngày chủ nhật
			IF ( datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-',@Month, '-01'))+1, 0)) AS NVARCHAR(50))) = 1)
			BEGIN
				SET @Next = @Next -1
			END
			-- Ngày bắt đầu của tháng hiện tại là ngày chủ nhật
			IF (datepart(W,CONCAT(@tmpYear, '-',@Month, '-01')) = 1)
			BEGIN
				SET @Next = @Next +1
			END

			--INSERT INTO @RESULT VALUES (CONVERT(VARCHAR(50),datepart(W,CAST(DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,CONCAT(@tmpYear, '-',@Month, '-01'))+1, 0)) AS NVARCHAR(50))))) Return


			WHILE @BeginWeek4 <= @EndWeek4 + @Next
			BEGIN
				INSERT @RESULT VALUES((@BeginWeek4 + @Pointer) + @tmpLastWeekForCurrentYear) 
				SET @BeginWeek4 = @BeginWeek4 + 1 
			END
		END



		RETURN
	END
	RETURN
END