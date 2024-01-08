IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1506_PL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1506_PL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Store customize Phúc Long
----- Kết chuyển khấu hao TSCĐ sang kế toán (kết chuyển dạng chi tiết từng dòng khấu hao)
----- Created on 03/06/2021 by Nhựt Trường

CREATE PROCEDURE [dbo].[AP1506_PL]
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @UserID NVARCHAR(50) 
AS

DECLARE 
    @Asset_cur CURSOR, 
    @DebitAccountID NVARCHAR(50), 
    @CreditAccountID NVARCHAR(50), 
    @ConvertedAmount DECIMAL(28,8), 
    @VoucherNo NVARCHAR(50), 
    @VoucherTypeID NVARCHAR(50), 
    @BDescription NVARCHAR(250), 
    @VoucherDate DATETIME, 
    @Ana01ID NVARCHAR(50), 
    @Ana02ID NVARCHAR(50), 
    @Ana03ID NVARCHAR(50), 
    @Ana04ID NVARCHAR(50), 
    @Ana05ID NVARCHAR(50), 
    @ObjectID NVARCHAR(50), 
    @PeriodID NVARCHAR(50), 
    @CurrencyID NVARCHAR(50), 
    @TransactionID NVARCHAR(50), 
    @VoucherID NVARCHAR(50),
	@CustomerName INT

SET @CurrencyID = (SELECT TOP 1 BaseCurrencyID FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @CurrencyID = ISNULL(@CurrencyID, 'VND')

EXEC AP0000 @DivisionID, @VoucherID OUTPUT, 'AT9000', 'AV', @TranYear, '', 15, 3, 0, '-'

SET @Asset_cur = CURSOR SCROLL KEYSET FOR 
SELECT DebitAccountID, 
	CreditAccountID, 
	DepAmount AS ConvertedAmount, 
	VoucherNo, 
	VoucherTypeID, 
	BDescription, 
	VoucherDate,
	Ana01ID, 
	Ana02ID, 
	Ana03ID, 
	Ana04ID, 
	Ana05ID, 
	ObjectID, 
	PeriodID 
FROM AT1504 WITH (NOLOCK)
WHERE DivisionID = @DivisionID 
	AND TranMonth = @TranMonth 
	AND TranYear = @TranYear 
	AND Status = 0

OPEN @Asset_cur
FETCH NEXT FROM @Asset_cur INTO @DebitAccountID, @CreditAccountID, @ConvertedAmount, @VoucherNo, @VoucherTypeID, @BDescription, @VoucherDate, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @ObjectID, @PeriodID 

WHILE @@Fetch_Status = 0
	BEGIN 

		EXEC AP0000 @DivisionID, @TransactionID OUTPUT, 'AT1504', 'AT', @TranYear, '', 15, 3, 0, '-'

		INSERT AT9000 (TransactionID, TableID, BatchID, VoucherID, TDescription, BDescription, VDescription, CurrencyID, ExchangeRate, VoucherDate, VoucherTypeID, VoucherNo, TransactionTypeID, TranMOnth, TranYear, DivisionID, DebitAccountID, CreditAccountID, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, PeriodID, OriginalAmount, ConvertedAmount, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
		VALUES (@TransactionID, 'AT1504', @VoucherID, @VoucherID, @BDescription, @BDescription, @BDescription, @CurrencyID, 1, @VoucherDate, @VoucherTypeID, @VoucherNo, 'T08', @TranMonth, @TranYear, @DivisionID, @DebitAccountID, @CreditAccountID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @PeriodID, @ConvertedAmount, @ConvertedAmount, GETDATE(), @UserID, GETDATE(), @UserID)
       
		FETCH NEXT FROM @Asset_cur INTO @DebitAccountID, @CreditAccountID, @ConvertedAmount, @VoucherNo, @VoucherTypeID, @BDescription, @VoucherDate, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @ObjectID, @PeriodID 
	END
CLOSE @Asset_cur

--------- Cap nhËt bót to¸n khÊu hao ®· ®­îc chuyÓn

UPDATE AT1504 
SET Status = 1
WHERE TranMonth = @TranMonth 
	AND TranYear = @TranYear 
	AND DivisionID = @DivisionID