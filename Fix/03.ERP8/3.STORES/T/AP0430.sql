IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0430]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0430]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Ket chuyen phan bo doanh thu hay chi phi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Create by Kiều Nga on 19/04/2022
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP0430] 
			@DivisionID AS nvarchar(50),
			@TranMonth AS int,
			@TranYear AS int,
			@D_C AS nvarchar(50), 
			@UserID AS nvarchar(50),
			@JobIDInput AS nvarchar(50) 

AS
Declare @Job_cur AS cursor,
		@DebitAccountID AS nvarchar(50),
		@CreditAccountID AS nvarchar(50),
		@OriginalAmount AS decimal(28,8),
		@ConvertedAmount AS decimal(28,8),
		@VoucherNo AS nvarchar(50),
		@VoucherTypeID AS nvarchar(50),
		@BDescription AS nvarchar(250),
		@VoucherDate AS Datetime,
		@Ana01ID AS nvarchar(50),
		@Ana02ID  AS nvarchar(50),
		@Ana03ID  AS nvarchar(50),
		@Ana04ID  AS nvarchar(50),
		@Ana05ID  AS nvarchar(50),
		@ObjectID AS nvarchar(50),
		@SerialNo AS nvarchar(50), 
		@InvoiceNo AS nvarchar(50),
		@InvoiceDate AS nvarchar(50),
		@PeriodID  AS nvarchar(50),
		@BaseCurrencyID AS nvarchar(50),
		@CurrencyID AS nvarchar(50),
		@ExchangeRate AS decimal(28,8),
		@TransactionID AS nvarchar(50),
		@VoucherID  AS nvarchar(50),
		@JobID AS nvarchar(50),
		@AdvanceID AS nvarchar(50)
	
Set @BaseCurrencyID = (Select Top 1 BaseCurrencyID From AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
Set @BaseCurrencyID = isnull(@BaseCurrencyID,'VND')

-------------->> FORMAT số lẻ
DECLARE @OriginalDecimal AS int,
        @ConvertedDecimal AS int  
           
SELECT @OriginalDecimal = ExchangeRateDecimal FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND DivisionID = @DivisionID	
SET @OriginalDecimal = CASE WHEN ISNULL(@OriginalDecimal,'') = ''  THEN 0 ELSE @OriginalDecimal END

SELECT @ConvertedDecimal = (SELECT TOP 1 ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @ConvertedDecimal = ISNULL(@ConvertedDecimal,0)

-----------------<< FORMAT số lẻ


SET @Job_cur = Cursor Scroll KeySet FOR 

	SELECT 	AT0422.DebitAccountID, AT0422.CreditAccountID, AT0422.DepOriginalAmount, AT0422.DepAmount, 
			AT0422.VoucherNo, AT0422.VoucherTypeID, AT0422.Description, AT0422.VoucherDate,
			AT0422.Ana01ID, AT0422.Ana02ID, AT0422.Ana03ID, AT0422.Ana04ID,  AT0422.Ana05ID,  AT0422.ObjectID, 
			AT0422.SerialNo, AT0422.InvoiceNo, AT0422.InvoiceDate, AT0422.JobID , AT0422.PeriodID, 
			AT0422.CurrencyID, AT0422.ExchangeRate      
	FROM	AT0422 WITH (NOLOCK)
	INNER JOIN AT0421  WITH (NOLOCK)
		ON	AT0421.JobID = AT0422.JobID 
			AND AT0421.DivisionID = AT0422.DivisionID
	WHERE	AT0422.DivisionID = @DivisionID and
			AT0422.TranMonth = @TranMonth and
			AT0422.TranYear = @TranYear  and
			AT0422.Status =0  and
			AT0422.D_C = @D_C and AT0422.JobID Like @JobIDInput
		
OPEN	@Job_cur
FETCH NEXT FROM @Job_cur INTO	@DebitAccountID, @CreditAccountID, @OriginalAmount, @ConvertedAmount,
								@VoucherNo, @VoucherTypeID, @BDescription, @VoucherDate,
								@Ana01ID,  @Ana02ID, @Ana03ID ,@Ana04ID,	@Ana05ID,
								@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate, @JobID, @PeriodID, 
								@CurrencyID, @ExchangeRate 
								  
SELECT @OriginalDecimal = ExchangeRateDecimal FROM AT1004 WITH (NOLOCK) WHERE CurrencyID = @CurrencyID AND DivisionID = @DivisionID
SET @OriginalDecimal = CASE WHEN ISNULL(@OriginalDecimal,'') = ''  THEN 0 ELSE @OriginalDecimal END
		   
WHILE @@Fetch_Status = 0
---Print ' khoan tien: '+str(@ConvertedAmount)	

	Begin	
	Exec AP0000 @DivisionID, @VoucherID  OUTPUT, 'AT9000', 'AD', @TranYear ,'',15, 3, 0, '-'
	Exec AP0000 @DivisionID, @TransactionID  OUTPUT, 'AT9000', 'AC', @TranYear ,'',15, 3, 0, '-'
		If @D_C = 'C' -----Ket chuyen Doanh thu
			Begin
			
				INSERT AT9000 	(TransactionID, TableID, BatchID, VoucherID, TDescription, BDescription, VDescription,
						CurrencyID, CurrencyIDCN, ExchangeRate, ExchangeRateCN, VoucherDate, VoucherTypeID, VoucherNo,
						TransactionTypeID, TranMOnth, TranYear, DivisionID,
						DebitAccountID, CreditAccountID, 
						Ana01ID, Ana02ID, Ana03ID,
						Ana04ID,	Ana05ID,ObjectID,Serial, InvoiceNo, InvoiceDate,
						OriginalAmount, ConvertedAmount, 
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
			
				VALUES 	( @TransactionID, 'AT0422', @VoucherID, @VoucherID, @BDescription, @BDescription, @BDescription,
						isnull(@CurrencyID,@BaseCurrencyID), isnull(@CurrencyID,@BaseCurrencyID), isnull(@ExchangeRate,1), isnull(@ExchangeRate,1) , @VoucherDate, @VoucherTypeID, @VoucherNo,
						'T28', @TranMonth, @TranYear, @DivisionID,  --- But toan phan bo chi phi
						@DebitAccountID, @CreditAccountID, 
						@Ana01ID,@Ana02ID,@Ana03ID, @Ana04ID,	@Ana05ID,
						@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate,            
						ROUND(isnull(@OriginalAmount,@ConvertedAmount), @OriginalDecimal), ROUND(@ConvertedAmount, @ConvertedDecimal), 
						GetDate(), @UserID, GetDate(), @UserID)

				UPDATE AT0422 SET TransactionID = @TransactionID WHERE JobID = @JobID AND DivisionID = @DivisionID

			End
		Else -----Ket chuyen chi phi
			Begin
				INSERT AT9000 	(TransactionID, TableID, BatchID, VoucherID, TDescription, BDescription, VDescription,
						CurrencyID, CurrencyIDCN, ExchangeRate, ExchangeRateCN, VoucherDate, VoucherTypeID, VoucherNo,
						TransactionTypeID, TranMOnth, TranYear, DivisionID,
						DebitAccountID, CreditAccountID, 
						Ana01ID, Ana02ID, Ana03ID, Ana04ID,	Ana05ID,
						ObjectID,Serial, InvoiceNo, InvoiceDate, PeriodID,
						OriginalAmount, ConvertedAmount, 
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
			
				VALUES 	( @TransactionID, 'AT0422', @VoucherID, @VoucherID, @BDescription, @BDescription, @BDescription,
						isnull(@CurrencyID,@BaseCurrencyID), isnull(@CurrencyID,@BaseCurrencyID), isnull(@ExchangeRate,1), isnull(@ExchangeRate,1), @VoucherDate, @VoucherTypeID, @VoucherNo,
						'T38', @TranMonth, @TranYear, @DivisionID,  --- But toan phan bo chi phi
						@DebitAccountID, @CreditAccountID, 
						@Ana01ID,   @Ana02ID,  @Ana03ID,@Ana04ID,	@Ana05ID,
						@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate, @PeriodID,             
						ROUND(isnull(@OriginalAmount,@ConvertedAmount), @OriginalDecimal) , ROUND(@ConvertedAmount, @ConvertedDecimal), 
						GetDate(), @UserID, GetDate(), @UserID)

				UPDATE AT0422 SET TransactionID = @TransactionID WHERE JobID = @JobID AND DivisionID = @DivisionID
				
				--- kết chuyển chi phí tạm ứng sang HRM
				IF @CreditAccountID = (SELECT TOP 1 AdvanceAccountID FROM HT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
				BEGIN
					EXEC AP0000  @DivisionID, @AdvanceID  OUTPUT, 'HT2500', 'AT', @TranYear, '', 15, 3, 0, ''
					INSERT INTO HT2500 (DivisionID,AdvanceID,DepartmentID,TeamID,EmployeeID,TranMonth,TranYear,AdvanceDate,AdvanceAmount,
										Description,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,IsTranfer)
					VALUES (@DivisionID,@AdvanceID,
							(Select DepartmentID From HT1403 WITH (NOLOCK) Where DivisionID = @DivisionID And EmployeeID = @ObjectID),
							(Select TeamID From HT1403 WITH (NOLOCK) Where DivisionID = @DivisionID And EmployeeID = @ObjectID),
							@ObjectID,@TranMonth,@TranYear,@VoucherDate,ROUND(@ConvertedAmount, @ConvertedDecimal),
							@BDescription,@UserID,GETDATE(),@UserID,GETDATE(),1)
							
					UPDATE AT0422 SET AdvanceID = @AdvanceID WHERE JobID = @JobID AND DivisionID = @DivisionID
				END
			End
			
---Print @TransactionID
					
	FETCH NEXT FROM @Job_cur INTO  @DebitAccountID, @CreditAccountID, @OriginalAmount, @ConvertedAmount,
		@VoucherNo, @VoucherTypeID, @BDescription, @VoucherDate,
		@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID, @Ana05ID,@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate, @JobID, @PeriodID, @CurrencyID, @ExchangeRate           
		
	End
CLOSE @Job_cur


UPDATE AT0422 
SET  Status =1
WHERE TranMonth = @TranMonth and
	TranYear = @TranYear and
	DivisionID =@DivisionID and
	AT0422.D_C = @D_C and JobID like @JobIDInput

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
