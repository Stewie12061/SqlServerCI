IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0022_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0022_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Lấy tỷ giá bình quân gia quyền di động theo TT200
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> Phiếu Chi/ Phiếu Chi qua NH
---- 
-- <History>
---- Create on 11/01/2016 by Trương Ngọc Phương Thảo
---- 
---- Modified on 15/9/2016: Bổ sung lấy tỷ giá xấp xỉ (TT53)
---- Modified on 18/08/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE
-- <Example>
---- EXEC [AP0022] 'GS', 'VND', '2015-12-21', '111'
CREATE PROCEDURE [dbo].[AP0022_MK] 
(
    @DivisionID    AS NVARCHAR(50),
    @CurrencyID    NVARCHAR(50),
    @VoucherDate  AS DATETIME,
	@AccountID AS NVarchar(50)
)
AS

DECLARE 	@Operator AS INT, @ERDecimal AS INT, @AVRType AS TINYINT
DECLARE 	@SumDebitCA AS DECIMAL(28,8) , @SumDebitOA AS  DECIMAL(28,8),
			@SumCreditCA AS  DECIMAL(28,8), @SumCreditOA AS  DECIMAL(28,8)
DECLARE 	@MethodID AS VARCHAR(20),
			@ExchangeRate AS DECIMAL(28,8),
			@ApproximateExRate AS DECIMAL(28,8)


SELECT TOP 1 @Operator=Operator, 
			@ERDecimal = ExchangeRateDecimal,
			@MethodID = Method,
			@AVRType = AVRType
FROM 	AT1004 with(nolock)
WHERE 	CurrencyID = @CurrencyID 

IF @CurrencyID ='' 
BEGIN
	SELECT CAST ( 0 AS MONEY ) As ExchangeRate
	Return
END


SELECT		TOP 1 @ExchangeRate = ExchangeRate
FROM		AT1012 with(nolock)
WHERE		CurrencyID = @CurrencyID
			AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
			AND DivisionID = @DivisionID
ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)

SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 with(nolock) WHERE CurrencyID = @CurrencyID AND DivisionID = @DivisionID), 0)
   
---- Lấy tỷ giá xấp xỉ
IF(@MethodID =  1 AND  Isnull(@AVRType,0) = 0)
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0 AND IsDefault = 1) 
	BEGIN
		SELECT		TOP 1 @ApproximateExRate = ApproximateExRate
		FROM		AT1012 with(nolock)
		WHERE		CurrencyID = @CurrencyID
					AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
					AND DivisionID = @DivisionID
					AND IsDefault = 1
		ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)
	END
	ELSE
	BEGIN
		SELECT		TOP 1 @ApproximateExRate = ApproximateExRate
		FROM		AT1012 with(nolock)
		WHERE		CurrencyID = @CurrencyID
					AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
					AND DivisionID = @DivisionID					
		ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)
	END
	SELECT  COALESCE(@ApproximateExRate,@ExchangeRate,0) AS ExchangeRate
END
ELSE

 
-- Thay thế view AV500 - cải thiện tốc độ
SELECT 		DivisionID, VoucherID, VoucherDate, VoucherNo,TranMonth, TranYear,
		CurrencyID ,
		CreditAccountID AS AccountID, 
		'D' AS D_C, 
		isnull(DebitAccountID,'') as DebitAccountID, 
		CreditAccountID,
		(ConvertedAmount) AS SignAmount, OriginalAmount AS OSignAmount
INTO #AV5000		
FROM		AT9000 WITH (NOLOCK)
WHERE		DivisionID = @DivisionID  
		AND VoucherDate <=@VoucherDate 
		AND CurrencyID = @CurrencyID
		AND ISNULL(DebitAccountID,'') <> ''
 		AND DebitAccountID = @AccountID 
 		

UNION ALL
SELECT 	DivisionID, VoucherID, VoucherDate, VoucherNo,TranMonth, TranYear,
		CurrencyID ,
		CreditAccountID AS AccountID, 
		'C' AS D_C, 
		isnull(DebitAccountID,'') as DebitAccountID, 
		CreditAccountID,
		(ConvertedAmount)*-1 AS SignAmount, OriginalAmount*-1 as OSignAmount
FROM		AT9000 WITH (NOLOCK)
WHERE		DivisionID = @DivisionID  
		AND VoucherDate <=@VoucherDate 
		AND CurrencyID = @CurrencyID   
		AND ISNULL(CreditAccountID,'') <> ''
 		AND CreditAccountID = @AccountID 

---- Lấy tỷ giá BQGQ di động
IF(@MethodID =  1 AND  Isnull(@AVRType,0) = 1)
BEGIN
	SELECT 	@SumDebitCA = IsNull(SUM(SignAmount),0), 
 			@SumDebitOA=IsNull(SUM(OSignAmount),0) 
	FROM 	#AV5000 
	WHERE 	VoucherDate <=@VoucherDate 
 		AND DebitAccountID = @AccountID 
 		AND CurrencyID = @CurrencyID 
 		AND D_C =  'D'
 		AND DivisionID = @DivisionID
		 	
	SELECT 	@SumCreditCA = IsNull(SUM(SignAmount),0), 
 		@SumCreditOA=IsNull(SUM(OSignAmount),0) 
	FROM 	#AV5000 
	WHERE 	VoucherDate <=@VoucherDate  
 		AND CreditAccountID = @AccountID 
 		AND CurrencyID = @CurrencyID 
 		AND D_C =  'C'
		AND DivisionID = @DivisionID

				
	IF @Operator = 0 -- Ty gia nhan 
 		SELECT (CASE WHEN @SumDebitOA + @SumCreditOA <>0 THEN ROUND((@SumDebitCA + @SumCreditCA)/(@SumDebitOA + @SumCreditOA),@ERDecimal) ELSE @ExchangeRate END) AS ExchangeRate 
	ELSE 
 		SELECT (CASE WHEN @SumDebitCA + @SumCreditCA <>0 THEN ROUND((@SumDebitOA + @SumCreditOA)/(@SumDebitCA + @SumCreditCA),@ERDecimal) ELSE @ExchangeRate END) AS ExchangeRate
 		
END	
	
	



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

