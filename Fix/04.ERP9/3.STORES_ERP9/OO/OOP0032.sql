IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--	Lấy số ngày làm việc trong khoảng thời gian chỉ định
-- <Param>
-- <Return>
-- <Reference>
-- <History>
--	Created by: Vĩnh Tâm, Date: 03/07/2019
-- <Example>
--	OOP0032 @DivisionID = 'KY', @StartDate = '2019-04-01', @EndDate = '2019-04-30'

CREATE PROCEDURE [dbo].[OOP0032] (
	@DivisionID VARCHAR(50),
	@StartDate NVARCHAR(20),
	@EndDate NVARCHAR(20)
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
		@DayOfWeek INT,
		@NumberWorkDay INT = 0

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
		WHERE O1.FromDate <= @StartDateConvert AND O1.FromDate <= @EndDateConvert
			AND O1.ToDate >= @StartDateConvert AND O1.ToDate >= @EndDateConvert

		-- Khi ngày đang xét thuộc ngày nghỉ đặc biệt của công ty thì bỏ qua
		IF (@ExistData = 1)
		BEGIN
			--PRINT('		HOLIDAY: ' + CONVERT(NVARCHAR(20), @StartDateLoop, 111))
			SET @StartDateLoop = DATEADD(DAY, 1, @StartDateLoop)
			CONTINUE
		END
		SET @NumberWorkDay = @NumberWorkDay + 1
		--PRINT(CAST(@NumberWorkDay AS VARCHAR(5)) + '.WORKING: ' + CONVERT(NVARCHAR(20), @StartDateLoop, 111))
		SET @StartDateLoop = DATEADD(DAY, 1, @StartDateLoop);
	END
	SELECT @NumberWorkDay AS NumberWorkDay
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
