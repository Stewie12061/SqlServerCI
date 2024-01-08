IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2036]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách tháng trong năm học của học sinh.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/10/2019 by Thành Luân
---- Example: EXEC EDMP2036 @StudentID='0000279', @SchoolYearID=NULL, @DateSpecify=NULL, @FromDate=NULL, @ToDate=NULL

CREATE PROCEDURE EDMP2036
(
	@StudentID VARCHAR(50), -- Mã học sinh.
	@SchoolYearID VARCHAR(50) = NULL, -- Option cho chỉ định năm học để load danh sách tháng trong năm học. Nếu @SchoolYearID = null thì sẽ dùng @DateSpecify để tìm ra tháng trong năm học.
	@DateSpecify DATETIME = NULL, -- Option ngày chỉ định, store dùng ngày này để tìm ra năm học. Nếu @DateSpecify = null thì sẽ lấy năm học hiện tại.
	@FromDate DATETIME = NULL, -- Option cho lọc tháng bắt đầu trong năm học. Nếu @FromDate = null thì sẽ lọc từ ngày bắt đầu trong năm học.
	@ToDate DATETIME = NULL -- Option cho lọc tháng kết thúc trong năm học. Nếu @ToDate = null thì sẽ lọc từ ngày kết thúc trong năm học.
)
AS
BEGIN
	DECLARE @DateInSchoolYear DATETIME = ISNULL(@DateSpecify, GETDATE()),
			@BeginDate DATETIME = @FromDate,
			@EndDate DATETIME = @ToDate,
			@DivisionID VARCHAR(50),
			@RealSchoolYearID VARCHAR(50);

	DECLARE	@Months TABLE (
				DivisionID VARCHAR(50),
				StudentID VARCHAR(50),
				SchoolYearID VARCHAR(50),
				MonthYear NVARCHAR(50),
				TranMonth INT,
				TranYear INT,
				FromDate DATETIME,
				ToDate DATETIME
			);

	-- Gán giá trị cho @DivisionID, @RealSchoolYearID, @BeginDate, @EndDate.
	SELECT TOP(1) @DivisionID = EDMT1040.DivisionID,
				  @RealSchoolYearID = EDMT1040.SchoolYearID,
				  @BeginDate = CASE
								 WHEN @BeginDate IS NULL THEN DateFrom
								 WHEN @BeginDate <= DateFrom THEN DateFrom -- @BeginDate không hợp lệ nên lấy DateFrom.
								 -- Nếu năm và tháng của @BeginDate bằng với năm và tháng của DateFrom thì lấy DateFrom để lấy chính xác ngày bắt đầu trong năm học.
								 WHEN (YEAR(@BeginDate) = YEAR(DateFrom) AND MONTH(@BeginDate) = MONTH(DateFrom)) THEN DateFrom
								 ELSE DATEFROMPARTS(YEAR(@BeginDate), MONTH(@BeginDate), 1) -- Ngày đầu tháng
							   END,
				  @EndDate = CASE
								WHEN @EndDate IS NULL THEN DateTo
								WHEN @EndDate >= DateTo THEN DateTo -- @EndDate không hợp lệ nên lấy DateTo.
								-- Nếu năm và tháng của @@EndDate bằng với năm và tháng của DateTo thì lấy DateTo để lấy chính xác ngày kết thúc trong năm học.
								WHEN (YEAR(@EndDate) = YEAR(DateTo) AND MONTH(@EndDate) = MONTH(DateTo)) THEN DateTo
								ELSE EOMONTH(@EndDate) -- Ngày cuối tháng
							 END
	FROM EDMT1040 WITH(NOLOCK)
	INNER JOIN EDMT2010 WITH(NOLOCK) ON EDMT1040.DivisionID IN (EDMT2010.DivisionID, '@@@')
			   AND EDMT2010.StudentID = @StudentID
			   AND EDMT2010.StatusID IN ('0', '1') -- Trạng thái đang học hoặc học thử.
			   AND ISNULL(EDMT2010.DeleteFlg, 0) = 0
	WHERE (EDMT1040.SchoolYearID = @SchoolYearID OR (@DateInSchoolYear BETWEEN EDMT1040.DateFrom AND EDMT1040.DateTo))
		  AND EDMT1040.Disabled = 0
	
	DECLARE @EndYear INT = YEAR(@EndDate),
			@EndMonth INT = Month(@EndDate),
			@Step INT = 0;

	-- Vòng lập cho đến khi kết thúc năm và tháng theo @EndDate.
	WHILE (YEAR(@BeginDate) < @EndYear OR (YEAR(@BeginDate) = @EndYear AND MONTH(@BeginDate) <= @EndMonth))
	BEGIN
		DECLARE @BeginMonth INT = MONTH(@BeginDate),
				@BeginYear INT = YEAR(@BeginDate);
		
		INSERT INTO @Months(DivisionID, StudentID, SchoolYearID, MonthYear, TranMonth, TranYear, FromDate, ToDate)
		VALUES(
				@DivisionID,
				@StudentID,
				@RealSchoolYearID,
				CASE
					WHEN @BeginMonth < 10 THEN '0'+ RTRIM(LTRIM(STR(@BeginMonth))) + '/' + LTRIM(RTRIM(STR(@BeginYear))) 
					ELSE RTRIM(LTRIM(STR(@BeginMonth))) + '/' + LTRIM(RTRIM(STR(@BeginYear)))
				END,
				@BeginMonth,
				@BeginYear,
				-- Nếu step = 0 thì lấy @BeginDate ngược lại lấy ngày đầu trong tháng.
				CASE
					WHEN @Step = 0 THEN @BeginDate
					ELSE DATEFROMPARTS(@BeginYear, @BeginMonth, 1) -- Ngày đầu tháng.
				END,
				CASE
				-- Nếu năm, tháng là cuối cùng thì lấy @EndDate ngược lại lấy ngày cuối tháng.
					WHEN (@BeginYear = @EndYear AND @BeginMonth = @EndMonth) THEN @EndDate
					ELSE EOMONTH(@BeginDate) -- Ngày cuối tháng.
				END
			);

		SET @Step = @Step + 1
		SET @BeginDate = DATEADD(MONTH, 1, @BeginDate) -- Tăng số tháng lên 1 cho @BeginDate.
	END

	SELECT * FROM @Months
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO