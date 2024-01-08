IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0022]
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
---- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
---- Modified by Tấn Phú on 28/01/2019: Cast ExchangeRate về kiểu money, lấy điều kiện DivisionID IN ('@@@',@DivisionID)
---- Modified by Kim Thư on 30/01/2019: Tạo bảng tạm thay thế view AV500 - cải thiện tốc độ
---- Modified by Kim Thư on 22/04/2019: Điều chỉnh thử tự where theo Index5_AT9000 để cải thiện tốc độ
---- Modified by Huỳnh Thử on 18/08/2020: Merge Code: MEKIO và MTE -- Tách Store
---- Modified by Huỳnh Thử on 30/09/2020: Tính tý giá BD theo số tài khỏan Ngân Hàng
---- Modified by Huỳnh Thử on 12/11/2020: Bổ sung In TransactionType T00
---- Modified by Đức Tuyên on 13/11/2022: Điều chỉnh lấy tỷ giá theo đơn vị dùng chung AT1004
-- <Example>
---- EXEC [AP0022] 'GS', 'VND', '2015-12-21', '111'
CREATE PROCEDURE [dbo].[AP0022] 
(
    @DivisionID    AS NVARCHAR(50),
    @CurrencyID    NVARCHAR(50),
    @VoucherDate  AS DATETIME,
	@AccountID AS NVarchar(50),
	@BankAccountID AS NVarchar(50),
	@FormID AS NVARCHAR(50)
)
AS


DECLARE 	@Operator AS INT, @ERDecimal AS INT
DECLARE 	@SumDebitCA AS DECIMAL(28,8) , 
			@SumDebitOA AS  DECIMAL(28,8),
			@SumCreditCA AS  DECIMAL(28,8), 
			@SumCreditOA AS  DECIMAL(28,8)
DECLARE 	@MethodID AS VARCHAR(20),
			@ExchangeRate AS MONEY,
			@CustomerName INT

SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex
IF(@CustomerName = 50 OR @CustomerName = 115)
BEGIN
	EXEC AP0022_MK @DivisionID, @CurrencyID, @VoucherDate,@AccountID
END 
SELECT TOP 1 @Operator=Operator, 
			@ERDecimal = ExchangeRateDecimal,
			@MethodID = Method
FROM 	AT1004 with (nolock)
WHERE 	CurrencyID = @CurrencyID 

IF @CurrencyID ='' 
BEGIN
	SELECT CAST ( 0 AS MONEY ) As ExchangeRate
	Return
END


SELECT		TOP 1 @ExchangeRate = ExchangeRate
FROM		AT1012 with (nolock)
WHERE		CurrencyID = @CurrencyID
			AND DATEDIFF(dd, ExchangeDate, @VoucherDate) >= 0
ORDER BY	DATEDIFF(dd, ExchangeDate, @VoucherDate)

SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 with(nolock) WHERE CurrencyID = @CurrencyID AND DivisionID IN ('@@@',@DivisionID)), 0)
 
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
		AND ISNULL(DebitAccountID,'') <> ''
 		AND DebitAccountID = @AccountID 
		AND CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN '' ELSE CurrencyID END = CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN '' ELSE @CurrencyID END -- Gọi từ màn hình AF0103 thì bỏ điều kiện CurrencyID
		AND CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN DebitBankAccountID ELSE '' END = CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN @BankAccountID ELSE '' END   -- Gọi từ màn hình AF0062 thì bỏ điều kiện DebitBankAccountID
 		AND TransactionTypeID in ('T21', 'T22' , 'T10','T16', 'T09', 'T19', 'T00') 
		AND	EXISTS (SELECT TOP 1 1 FROM AT1005 
							WHERE AT1005.GroupID = 'G01' AND (AT9000.CreditAccountID = AT1005.AccountID OR AT9000.DebitAccountID = AT1005.AccountID))

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
		AND ISNULL(CreditAccountID,'') <> ''
		AND CreditAccountID = @AccountID 	
		AND CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN '' ELSE CurrencyID END = CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN '' ELSE @CurrencyID END -- Gọi từ màn hình AF0103 thì bỏ điều kiện CurrencyID
		AND CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN CreditBankAccountID ELSE '' END = CASE WHEN ISNULL(@FormID,'') = 'AF0103' THEN @BankAccountID ELSE '' END  -- Gọi từ màn hình AF0062 thì bỏ điều kiện CreditBankAccountID
		AND TransactionTypeID in ('T21', 'T22' , 'T10','T16', 'T09', 'T19', 'T00') 
		AND	EXISTS (SELECT TOP 1 1 FROM AT1005 
							WHERE AT1005.GroupID = 'G01' AND (AT9000.CreditAccountID = AT1005.AccountID OR AT9000.DebitAccountID = AT1005.AccountID))




SELECT 	@SumDebitCA = IsNull(SUM(SignAmount),0), 
 		@SumDebitOA=IsNull(SUM(OSignAmount),0) 
FROM 	#AV5000 
WHERE 	D_C =  'D'
 	
		 	
SELECT 	@SumCreditCA = IsNull(SUM(SignAmount),0), 
 	@SumCreditOA=IsNull(SUM(OSignAmount),0) 
FROM 	#AV5000
WHERE 	D_C =  'C'	 
	

				
IF @Operator = 0 -- Ty gia nhan 
 	SELECT (
	CASE WHEN @SumDebitOA + @SumCreditOA <>0 THEN 
		CAST (ROUND((@SumDebitCA + @SumCreditCA)/(@SumDebitOA + @SumCreditOA),@ERDecimal)  AS MONEY ) 
	ELSE @ExchangeRate 
	END
	) AS ExchangeRate 
ELSE 
 	SELECT (
	CASE WHEN @SumDebitCA + @SumCreditCA <>0 THEN 
		CAST (ROUND((@SumDebitOA + @SumCreditOA)/(@SumDebitCA + @SumCreditCA),@ERDecimal)  AS MONEY )
	ELSE @ExchangeRate 
	END
	) AS ExchangeRate
 		
	

 		




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
