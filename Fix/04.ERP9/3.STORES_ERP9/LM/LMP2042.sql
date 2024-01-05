IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2042]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Điều chỉnh lịch trả nợ
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
 EXEC LMP2042 'AS','3154c0de-02e7-4987-b97f-6957865e213c','02/01/2017',0,10000,0.5,0,1,'ASOFTADMIN'
*/


CREATE PROCEDURE LMP2042 ( 
        @DivisionID VARCHAR(50),
		@DisburseVoucherID VARCHAR(50),
		@AdjustFromDate DATETIME,
		@AdjustTypeID TINYINT,
		@BeforeOriginalAmount DECIMAL(28,8),
		@AdjustRate DECIMAL(28,8),
		@RateBy TINYINT, --- 0: theo tháng; 1: theo năm
		@ExchangeRate DECIMAL(28,8),
		@UserID VARCHAR(50),
		@AdjustTime INT = 1,
		@AdjustTimeFromDate DATETIME = '',
		@AdjustTimeToDate DATETIME = ''
) 
AS 
DECLARE @DisToDate DATETIME,
		@ToDate DATETIME,--- ngày điều chỉnh cuối
		@OriginalAmount DECIMAL(28,8),--- số tiền giải ngân (NT)
		@PaymentOriginalAmount DECIMAL(28,8),	--- số tiền phải trả
		@RateMethod TINYINT, --- Phương thức trả lãi
		@FromDate DATETIME,
		@OriginalDecimals TINYINT,
		@ConvertedDecimals TINYINT,
		@RemainOAmount DECIMAL(28,8),	--- Số tiền gốc còn lại chưa thanh toán
		@OAmountEachMonth DECIMAL(28,8),	--- Số tiền gốc phải trả hàng tháng theo lịch trả nợ
		@i INT,
		@PrePaymentAmount DECIMAL(28,8),	--- Số tiền đã trả trước 1 phần ứng với 1 khoản thanh toán gốc
		@Operator TINYINT
	
SET @PrePaymentAmount = 0
SELECT @ConvertedDecimals = ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID

SELECT	@OriginalAmount = T21.OriginalAmount, @DisToDate = T21.ToDate,
		@RateMethod = T21.RateMethod, @OriginalDecimals = T04.ExchangeRateDecimal,
		@Operator = T04.Operator
FROM LMT2021 T21 WITH (NOLOCK)
LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T21.CurrencyID = T04.CurrencyID
WHERE T21.DivisionID = @DivisionID
AND T21.VoucherID = @DisburseVoucherID

IF @AdjustTypeID = 0	--- thay đổi lãi suất
BEGIN
	IF @RateBy = 1 --- lãi suất theo năm
		SET @AdjustRate = CONVERT(DECIMAL(28,8),@AdjustRate)/12

	IF @RateMethod = 0 --- Dựa trên dư nợ ban đầu
	BEGIN
		SET @PaymentOriginalAmount = CONVERT(DECIMAL(28,8),@OriginalAmount)*CONVERT(DECIMAL(28,8),@AdjustRate)/100

		UPDATE LMT2022 SET	PaymentOriginalAmount = ROUND(@PaymentOriginalAmount, @OriginalDecimals),
							PaymentConvertedAmount = CASE WHEN @Operator = 0 THEN ROUND(@PaymentOriginalAmount*@ExchangeRate, @ConvertedDecimals) ELSE ROUND(@PaymentOriginalAmount/@ExchangeRate, @ConvertedDecimals) END,
							LastModifyUserID = @UserID, LastModifyDate = getdate()
		WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentDate >= @AdjustFromDate
		AND PaymentType = 1 AND ISNULL(IsNotPayment,0) = 0

	END
	ELSE --- Dựa trên dư nợ giảm dần
	BEGIN
		--- Lấy ngày trả nợ gần nhất tính từ ngày điều chỉnh
		SELECT TOP 1 @FromDate = PaymentDate
		FROM LMT2022 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentType = 1 And PaymentDate >= @AdjustFromDate
		ORDER BY PaymentDate

		--- Lấy Số tiền gốc còn lại chưa thanh toán
		SET @RemainOAmount = @OriginalAmount - (Select SUM(ActualOriginalAmount) FROM LMT2031 Where DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID
													And PaymentType = 0	And ActualDate < @FromDate)

		--- Lấy số tiền gốc phải thanh toán hàng tháng
		SELECT TOP 1 @OAmountEachMonth = PaymentOriginalAmount
		FROM LMT2022 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentType = 0
		ORDER BY PaymentDate

		SET @i = 0

		WHILE @FromDate <= @ToDate
		BEGIN
			SET @RemainOAmount = @RemainOAmount - @OAmountEachMonth * @i

			UPDATE LMT2022 SET	PaymentOriginalAmount = ROUND(@RemainOAmount*@AdjustRate/100, @OriginalDecimals),
								PaymentConvertedAmount = CASE WHEN @Operator = 0 THEN ROUND(@RemainOAmount*@AdjustRate*@ExchangeRate/100, @ConvertedDecimals) ELSE ROUND((@RemainOAmount*@AdjustRate/100)/@ExchangeRate, @ConvertedDecimals) END,
								LastModifyUserID = @UserID, LastModifyDate = getdate()
			WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentDate = @FromDate
			AND PaymentType = 1 AND ISNULL(IsNotPayment,0) = 0

			SET @i = @i + 1
			SET @FromDate = DATEADD(m,1,@FromDate)
		END
	END
END

IF @AdjustTypeID = 1	--- trả gốc trước hạn
	BEGIN
		--- Tính lại tiền lãi nếu trả lãi theo dư nợ giảm dần
		IF @RateMethod = 1 --- Lãi dựa trên dư nợ giảm dần
		BEGIN
			--- Lấy ngày bắt đầu điều chỉnh
			SELECT TOP 1 @FromDate = PaymentDate 
			FROM LMT2022 WITH (NOLOCK)
			WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentType = 1 And PaymentDate >= @AdjustFromDate
			ORDER BY PaymentDate

			--- Lấy ngày và số tiền của khoản thanh toán đã trả trước 1 phần
			SELECT TOP 1 @ToDate = T22.PaymentDate, @PrePaymentAmount = T31.ActualOriginalAmount
			FROM LMT2022 T22 WITH (NOLOCK)
			INNER JOIN (Select DivisionID, PaymentPlanTransactionID, ActualOriginalAmount
						From LMT2031 WITH (NOLOCK) Where DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentType = 0 And IsPrePayment = 1
						) T31 ON T31.DivisionID = T22.DivisionID And T31.PaymentPlanTransactionID = T22.TransactionID
			WHERE T22.DivisionID = @DivisionID And T22.DisburseVoucherID = @DisburseVoucherID And T22.PaymentType = 0
			AND T22.PaymentOriginalAmount - ISNULL(T31.ActualOriginalAmount,0) > 0

			--- Lấy Số tiền gốc còn lại chưa thanh toán
			SET @RemainOAmount = @OriginalAmount - (Select SUM(ActualOriginalAmount) FROM LMT2031 Where DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID
														And PaymentType = 0	And ActualDate < @FromDate) - Isnull(@BeforeOriginalAmount,0)

			--- Lấy số tiền gốc phải thanh toán hàng tháng
			SELECT TOP 1 @OAmountEachMonth = PaymentOriginalAmount
			FROM LMT2022 WITH (NOLOCK)
			WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentType = 0
			ORDER BY PaymentDate

			SET @i = 0

			WHILE @FromDate < @ToDate
			BEGIN
				SET @RemainOAmount = @RemainOAmount - @OAmountEachMonth * @i

				UPDATE LMT2022 SET	PaymentOriginalAmount = ROUND(@RemainOAmount*@AdjustRate/100, @OriginalDecimals),
									PaymentConvertedAmount = CASE WHEN @Operator = 0 THEN ROUND(@RemainOAmount*@AdjustRate*@ExchangeRate/100, @ConvertedDecimals) ELSE ROUND((@RemainOAmount*@AdjustRate/100)/@ExchangeRate, @ConvertedDecimals) END,
									LastModifyUserID = @UserID, LastModifyDate = getdate()
				WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentDate = @FromDate AND PaymentType = 1
				AND IsNotPayment = 0

				SET @i = @i + 1
				SET @FromDate = DATEADD(m,1,@FromDate)
			END

			--- Update tiền lãi cho ngày @ToDate (ngày đã trả trước 1 phần)
			IF @ToDate IS NOT NULL
			BEGIN
				SET @RemainOAmount = @RemainOAmount - ISNULL(@PrePaymentAmount,0)
				UPDATE LMT2022 SET	PaymentOriginalAmount = ROUND(@RemainOAmount*@AdjustRate/100, @OriginalDecimals),
									PaymentConvertedAmount = CASE WHEN @Operator = 0 THEN ROUND(@RemainOAmount*@AdjustRate*@ExchangeRate/100, @ConvertedDecimals) ELSE ROUND((@RemainOAmount*@AdjustRate/100)/@ExchangeRate, @ConvertedDecimals) END,
									LastModifyUserID = @UserID, LastModifyDate = getdate()
				FROM LMT2022
				WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentDate = @ToDate AND PaymentType = 1
				AND IsNotPayment = 0
			END
		END
	END
IF @AdjustTypeID = 2
	BEGIN

	DELETE LMT2022 WHERE DisburseVoucherID = @DisburseVoucherID AND DivisionID = @DivisionID

	EXEC LMP2022 @DivisionID = @DivisionID, @VoucherID = @DisburseVoucherID, @UserID = @UserID, @Mode = 1, @AdjustTime = @AdjustTime, @AdjustTimeFromDate = @AdjustTimeFromDate, @AdjustTimeToDate = @AdjustTimeToDate

	END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

