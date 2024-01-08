IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2022]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Tính lịch trả nợ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 11/07/2017 by Bảo Anh
----Modify on 25/01/2019: Bổ sung điều chỉnh lịch trả nợ khi điều chỉnh thời gian
----Modify on
-- <Example>
/*  
 EXEC LMP2022 'AS','123','ASOFTADMIN'
*/
----
CREATE PROCEDURE LMP2022 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50),
		@UserID VARCHAR(50),
		@Mode TINYINT = 0,
		@AdjustTime INT =1,
		@AdjustTimeFromDate DATETIME = '',
		@AdjustTimeToDate DATETIME = ''
) 
AS 
DECLARE @VoucherDate DATETIME,--- ngày giải ngân
		@ToDate DATETIME,--- ngày đến hạn
		@OriginalAmount DECIMAL(28,8),--- số tiền giải ngân (NT)
		@ConvertedAmount DECIMAL(28,8),--- số tiền giải ngân (QĐ)
		@NumOfMonths INT,--- Thời gian vay
		@OriginalMethod TINYINT,--- phương thức trả gốc
		@OriginalAccountID VARCHAR(50),--- TK ghi nhận khoản thanh toán gốc
		@OriginalCostTypeID VARCHAR(50),--- loại chi phí ghi nhận khoản thanh toán gốc
		@PaymentOriginalAmount DECIMAL(28,8),	--- số tiền phải trả
		@RateMethod TINYINT, --- Phương thức trả lãi
		@RateAccountID VARCHAR(50), --- TK ghi nhận khoản thanh toán lãi
		@RateCostTypeID VARCHAR(50), --- loại chi phí ghi nhận khoản thanh toán lãi
		@RatePercent DECIMAL(28,8), --- lãi suất
		@RateBy TINYINT, --- 0: theo tháng, 1: theo năm
		@FromDate DATETIME,
		@CurrencyID VARCHAR(50),
		@ExchangeRate DECIMAL(28,8),
		@OriginalDecimals TINYINT,
		@ConvertedDecimals TINYINT,
		@Operator TINYINT
		
SELECT @ConvertedDecimals = ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID

IF @Mode = 1
	BEGIN 
	
		SET @VoucherDate = @AdjustTimeFromDate
		SET @ToDate = @AdjustTimeToDate
		SET @NumOfMonths = @AdjustTime
		SELECT	@OriginalAmount = T21.OriginalAmount, @ConvertedAmount = T21.ConvertedAmount, 
				@OriginalMethod = T21.OriginalMethod, @OriginalAccountID = T21.OriginalAccountID, @OriginalCostTypeID = OriginalCostTypeID,
				@RateMethod = T21.RateMethod, @RateAccountID = T21.RateAccountID, @RateCostTypeID = T21.RateCostTypeID,
				@RatePercent = T21.RatePercent, @RateBy = T21.RateBy, @CurrencyID = T21.CurrencyID, 
				@ExchangeRate = T21.ExchangeRate, @OriginalDecimals = T04.ExchangeRateDecimal, @Operator = T04.Operator
		FROM LMT2021 T21 WITH (NOLOCK)
		LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T21.CurrencyID = T04.CurrencyID
		WHERE T21.DivisionID = @DivisionID
		AND T21.VoucherID = @VoucherID
	END 
ELSE 
	BEGIN 
	
		SELECT	@VoucherDate = T21.VoucherDate, @OriginalAmount = T21.OriginalAmount, @ConvertedAmount = T21.ConvertedAmount, @NumOfMonths = T21.NumOfMonths, @ToDate = T21.ToDate,
				@OriginalMethod = T21.OriginalMethod, @OriginalAccountID = T21.OriginalAccountID, @OriginalCostTypeID = OriginalCostTypeID,
				@RateMethod = T21.RateMethod, @RateAccountID = T21.RateAccountID, @RateCostTypeID = T21.RateCostTypeID,
				@RatePercent = T21.RatePercent, @RateBy = T21.RateBy, @CurrencyID = T21.CurrencyID, 
				@ExchangeRate = T21.ExchangeRate, @OriginalDecimals = T04.ExchangeRateDecimal, @Operator = T04.Operator
		FROM LMT2021 T21 WITH (NOLOCK)
		LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T21.CurrencyID = T04.CurrencyID
		WHERE T21.DivisionID = @DivisionID
		AND T21.VoucherID = @VoucherID

	END
DELETE LMT2022 WHERE DivisionID = @DivisionID AND DisburseVoucherID = @VoucherID

IF @RateBy = 1 --- lãi suất theo năm
	SET @RatePercent = CONVERT(DECIMAL(28,8),@RatePercent)/12

--- 1. Tính tiền gốc
IF @OriginalMethod = 0 --- gốc chia đều mỗi tháng
BEGIN 
	SET @FromDate = DATEADD(m,1,@VoucherDate)
	SET @PaymentOriginalAmount = CONVERT(DECIMAL(28,8),@OriginalAmount)/@NumOfMonths

	WHILE @FromDate <= @ToDate
	BEGIN
		INSERT INTO LMT2022 (DivisionID, TransactionID, DisburseVoucherID, Description, PaymentDate, TranMonth, TranYear,
							CurrencyID, ExchangeRate,
							PaymentName, PaymentOriginalAmount, PaymentConvertedAmount, PaymentAccountID, CostTypeID,
							PaymentType, RelatedToTypeID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES (@DivisionID, newid(), @VoucherID, NULL, @FromDate, Month(@FromDate), Year(@FromDate), @CurrencyID, @ExchangeRate,
				N'Nợ gốc đến hạn', ROUND(@PaymentOriginalAmount, @OriginalDecimals), 
				CASE WHEN @Operator = 0 THEN ROUND(@PaymentOriginalAmount*@ExchangeRate, @ConvertedDecimals) ELSE ROUND(@PaymentOriginalAmount/@ExchangeRate, @ConvertedDecimals) END, 
				@OriginalAccountID, @OriginalCostTypeID,
				0, 6, @UserID, getdate(), @UserID, getdate())

		SET @FromDate = DATEADD(m,1,@FromDate)
	END

	--- Làm tròn
	Declare @ODelta DECIMAL(28,8),
			@CDelta DECIMAL(28,8),
			@TransactionID VARCHAR(50)

	SET @ODelta = @OriginalAmount - (Select SUM(PaymentOriginalAmount) From LMT2022 WITH (NOLOCK) Where DivisionID = @DivisionID
											And DisburseVoucherID = @VoucherID And PaymentType = 0)

	SET @CDelta = @ConvertedAmount - (Select SUM(PaymentConvertedAmount) From LMT2022 WITH (NOLOCK) Where DivisionID = @DivisionID
	And DisburseVoucherID = @VoucherID And PaymentType = 0)

	IF @ODelta <> 0	--- làm tròn tiền nguyên tệ
	BEGIN
	
		SELECT TOP 1 @TransactionID = TransactionID
		FROM LMT2022 WITH (NOLOCK) Where DivisionID = @DivisionID And DisburseVoucherID = @VoucherID And PaymentType = 0
		ORDER BY PaymentOriginalAmount DESC

		UPDATE LMT2022
		SET PaymentOriginalAmount = PaymentOriginalAmount + @ODelta
		WHERE DivisionID = @DivisionID And DisburseVoucherID = @VoucherID And TransactionID = @TransactionID
	END

	IF @CDelta <> 0	--- làm tròn tiền quy đổi
	BEGIN
	
		SET @TransactionID = ''
		SELECT TOP 1 @TransactionID = TransactionID
		FROM LMT2022 WITH (NOLOCK) Where DivisionID = @DivisionID And DisburseVoucherID = @VoucherID And PaymentType = 0
		ORDER BY PaymentConvertedAmount DESC

		UPDATE LMT2022
		SET PaymentConvertedAmount = PaymentConvertedAmount + @CDelta
		WHERE DivisionID = @DivisionID And DisburseVoucherID = @VoucherID And TransactionID = @TransactionID
	END
END
ELSE --- trả 1 lần cuối kỳ
BEGIN

	SET @PaymentOriginalAmount = @OriginalAmount
	INSERT INTO LMT2022 (DivisionID, TransactionID, DisburseVoucherID, Description, PaymentDate, TranMonth, TranYear,
						CurrencyID, ExchangeRate,
						PaymentName, PaymentOriginalAmount, PaymentConvertedAmount, PaymentAccountID, CostTypeID,
						PaymentType, RelatedToTypeID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, newid(), @VoucherID, NULL, @ToDate, Month(@ToDate), Year(@ToDate), @CurrencyID, @ExchangeRate,
			N'Nợ gốc đến hạn', ROUND(@PaymentOriginalAmount, @OriginalDecimals), 
			CASE WHEN @Operator = 0 THEN ROUND(@PaymentOriginalAmount*@ExchangeRate, @ConvertedDecimals) ELSE ROUND(@PaymentOriginalAmount/@ExchangeRate, @ConvertedDecimals) END, 
			@OriginalAccountID, @OriginalCostTypeID,
			0, 6, @UserID, getdate(), @UserID, getdate())
END

--- 2. Tính tiền lãi    
IF @RateMethod = 0 --- Dựa trên dư nợ ban đầu
BEGIN

	SET @FromDate = DATEADD(m,1,@VoucherDate)
	SET @PaymentOriginalAmount = CONVERT(DECIMAL(28,8),@OriginalAmount)*CONVERT(DECIMAL(28,8),@RatePercent)/100

	WHILE @FromDate <= @ToDate
	BEGIN
		INSERT INTO LMT2022 (DivisionID, TransactionID, DisburseVoucherID, Description, PaymentDate, TranMonth, TranYear, CurrencyID, ExchangeRate,
							PaymentName, PaymentOriginalAmount, PaymentConvertedAmount, PaymentAccountID, CostTypeID,
							PaymentType, RelatedToTypeID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES (@DivisionID, newid(), @VoucherID, NULL, @FromDate, Month(@FromDate), Year(@FromDate), @CurrencyID, @ExchangeRate,
				N'Lãi vay đến hạn', ROUND(@PaymentOriginalAmount, @OriginalDecimals), 
				CASE WHEN @Operator = 0 THEN ROUND(@PaymentOriginalAmount*@ExchangeRate, @ConvertedDecimals) ELSE ROUND(@PaymentOriginalAmount/@ExchangeRate, @ConvertedDecimals) END, 
				@RateAccountID, @RateCostTypeID,
				1, 6, @UserID, getdate(), @UserID, getdate())

		SET @FromDate = DATEADD(m,1,@FromDate)
	END
END
ELSE --- Dựa trên dư nợ giảm dần
BEGIN
	SET @FromDate = DATEADD(m,1,@VoucherDate)
	WHILE @FromDate <= @ToDate
	BEGIN
		INSERT INTO LMT2022 (DivisionID, TransactionID, DisburseVoucherID, Description, PaymentDate, TranMonth, TranYear, CurrencyID, ExchangeRate,
							PaymentName, PaymentOriginalAmount, PaymentAccountID, CostTypeID, PaymentType, RelatedToTypeID,
							CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES (@DivisionID, newid(), @VoucherID, NULL, @FromDate, Month(@FromDate), Year(@FromDate), @CurrencyID, @ExchangeRate,
				N'Lãi vay đến hạn',
				ROUND(((@OriginalAmount - ISNULL((Select SUM(PaymentOriginalAmount) From LMT2022 WITH (NOLOCK) Where DivisionID = @DivisionID
											And DisburseVoucherID = @VoucherID And PaymentType = 0 And PaymentDate < @FromDate
										),0))*@RatePercent/100
										), @OriginalDecimals), @RateAccountID, @RateCostTypeID, 1, 6,
				@UserID, getdate(), @UserID, getdate())

		SET @FromDate = DATEADD(m,1,@FromDate)
	END

	--select * from LMT2022 where DisburseVoucherID = @VoucherID order by PaymentType, TranYear, TranMonth

	UPDATE LMT2022 SET PaymentConvertedAmount = CASE WHEN @Operator = 0 THEN ROUND(PaymentOriginalAmount*@ExchangeRate, @ConvertedDecimals) ELSE ROUND(PaymentOriginalAmount/@ExchangeRate, @ConvertedDecimals) END 
	WHERE DivisionID = @DivisionID And DisburseVoucherID = @VoucherID And PaymentType = 1

	--select * from LMT2022 where DisburseVoucherID = @VoucherID order by PaymentType, TranYear, TranMonth
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

