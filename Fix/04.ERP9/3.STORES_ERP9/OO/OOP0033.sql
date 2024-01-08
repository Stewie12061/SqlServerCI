IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--	Lấy danh sách các ngày làm việc trong khoảng thời gian chỉ định
-- <Param>
-- <Return>
-- <Reference>
-- <History>
--	Created by: Vĩnh Tâm, Date: 23/04/2020
-- <Example>
--	OOP0033 @DivisionID = 'DTI', @StartDate = '2020-04-01', @EndDate = '2020-04-30'

CREATE PROCEDURE [dbo].[OOP0033] (
	@DivisionID VARCHAR(50),
	@StartDate VARCHAR(20),
	@EndDate VARCHAR(20)
)
AS
BEGIN
DECLARE @StartDateConvert NVARCHAR(20),
		@EndDateConvert NVARCHAR(20),
		@CurrentStartDate DATETIME,
		@CurrentEndDate DATETIME,
		@StartDateLoop DATETIME,
		@EndDateLoop DATETIME,
		@ExistData INT,
		@DayOfWeek INT

CREATE TABLE #TableWorkDate (
	WorkDate DATETIME,
	BeginTime VARCHAR(10),
	EndTime VARCHAR(10)
)

SET @StartDateConvert = CAST(@StartDate AS DATETIME)
SET @EndDateConvert = CAST(@EndDate AS DATETIME)
SET @StartDateLoop = @StartDateConvert
SET @EndDateLoop = @EndDateConvert

WHILE @StartDateLoop <= @EndDateLoop
	BEGIN
		SET @DayOfWeek = DATEPART(DW, @StartDateLoop)
		SET @ExistData = 0
		-- Khi ngày đang xét là ngày Chủ nhật (1) hoặc Thứ Bảy (7)
		IF (@DayOfWeek = 1 OR @DayOfWeek = 7)
		BEGIN
			--PRINT('		WEEKEND: ' + CONVERT(NVARCHAR(20), @StartDateLoop, 111))
			SET @StartDateLoop = DATEADD(DAY, 1, @StartDateLoop);
			CONTINUE
		END

		-- Lấy dữ liệu ngày nghỉ đặc biệt của công ty
		SELECT TOP 1 @ExistData = 1
		FROM OOT0030 O1 WITH (NOLOCK)
			INNER JOIN OOT0031 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
				AND (O2.StartDayOff BETWEEN @StartDateConvert AND @EndDateConvert
				OR O2.EndDayOff BETWEEN @StartDateConvert AND @EndDateConvert)
				AND @StartDateLoop BETWEEN O2.StartDayOff AND O2.EndDayOff
		WHERE @StartDateConvert BETWEEN O1.FromDate AND O1.ToDate
			OR @EndDateConvert BETWEEN O1.FromDate AND O1.ToDate

		-- Khi ngày đang xét thuộc ngày nghỉ đặc biệt của công ty thì bỏ qua
		IF (@ExistData = 1)
		BEGIN
			SET @StartDateLoop = DATEADD(DAY, 1, @StartDateLoop)
			CONTINUE
		END
		INSERT INTO #TableWorkDate (WorkDate)
		VALUES (@StartDateLoop)

		SET @StartDateLoop = DATEADD(DAY, 1, @StartDateLoop);
	END

	UPDATE #TableWorkDate
	SET BeginTime = dbo.ConvertTimestampToTime(O2.BeginTime)
	  , EndTime = dbo.ConvertTimestampToTime(O2.EndTime)
	FROM OOT0030 O1 WITH (NOLOCK)
		INNER JOIN OOT0032 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
		WHERE @StartDateConvert BETWEEN O1.FromDate AND O1.ToDate
			OR @EndDateConvert BETWEEN O1.FromDate AND O1.ToDate

	SELECT * FROM #TableWorkDate
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
