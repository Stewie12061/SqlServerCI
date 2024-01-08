IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1704]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1704]
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
--- Create by Thuy Tuyen on 29/12/2006
---
---- Last Edit Thuy Tuyen 05/03/2007
---- Edit by Dang Le Bao Quynh on 27/04/2007 : Hieu chinh lai cach chuyen phan bo theo chi tiet doi tuong
---- Edit by Nguyen Quoc Huy, Date 20/08/2008 (Them doi tuong THCP)
---- Edit by Dang Le Bao Quynh Date 04/11/2008 : Bo sung phan bo theo nguyen te
---- Modified on 04/01/2012 by Lê Thị Thu Hiền : Bổ sung format số lẻ
---- Modified on 24/03/2014 by Bảo Anh: Kết chuyển phân bổ tạm ứng sang HRM
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ, tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kiều Nga on 29/09/2022: Fix lỗi cập nhật TransactionID vào bảng AT1704
---- Modified by Kiều Nga on 19/10/2022: Fix lỗi không kết chuyển MPT 6 - 10
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP1704] 
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
		@Ana06ID  AS nvarchar(50),
		@Ana07ID  AS nvarchar(50),
		@Ana08ID  AS nvarchar(50),
		@Ana09ID  AS nvarchar(50),
		@Ana10ID  AS nvarchar(50),
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

	SELECT 	AT1704.DebitAccountID, AT1704.CreditAccountID, AT1704.DepOriginalAmount, AT1704.DepAmount, 
			AT1704.VoucherNo, AT1704.VoucherTypeID, AT1704.Description, AT1704.VoucherDate,
			AT1704.Ana01ID, AT1704.Ana02ID, AT1704.Ana03ID, AT1704.Ana04ID,  AT1704.Ana05ID,
			AT1704.Ana06ID, AT1704.Ana07ID, AT1704.Ana08ID, AT1704.Ana09ID, AT1704.Ana10ID, AT1704.ObjectID, 
			AT1704.SerialNo, AT1704.InvoiceNo, AT1704.InvoiceDate, AT1704.JobID , AT1704.PeriodID, 
			AT1704.CurrencyID, AT1704.ExchangeRate      
	FROM	AT1704 WITH (NOLOCK)
	INNER JOIN AT1703  WITH (NOLOCK)
		ON	AT1703.JobID = AT1704.JobID 
			AND AT1703.DivisionID = AT1704.DivisionID
	WHERE	AT1704.DivisionID = @DivisionID and
			AT1704.TranMonth = @TranMonth and
			AT1704.TranYear = @TranYear  and
			AT1704.Status =0  and
			AT1704.D_C = @D_C and AT1704.JobID Like @JobIDInput
		
OPEN	@Job_cur
FETCH NEXT FROM @Job_cur INTO	@DebitAccountID, @CreditAccountID, @OriginalAmount, @ConvertedAmount,
								@VoucherNo, @VoucherTypeID, @BDescription, @VoucherDate,
								@Ana01ID,  @Ana02ID, @Ana03ID ,@Ana04ID,	@Ana05ID,
								@Ana06ID,  @Ana07ID, @Ana08ID,@Ana09ID,@Ana10ID, 
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
						Ana04ID, Ana05ID, Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID, 
						ObjectID,Serial, InvoiceNo, InvoiceDate,
						OriginalAmount, ConvertedAmount, 
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
			
				VALUES 	( @TransactionID, 'AT1704', @VoucherID, @VoucherID, @BDescription, @BDescription, @BDescription,
						isnull(@CurrencyID,@BaseCurrencyID), isnull(@CurrencyID,@BaseCurrencyID), isnull(@ExchangeRate,1), isnull(@ExchangeRate,1) , @VoucherDate, @VoucherTypeID, @VoucherNo,
						'T28', @TranMonth, @TranYear, @DivisionID,  --- But toan phan bo chi phi
						@DebitAccountID, @CreditAccountID, 
						@Ana01ID,@Ana02ID,@Ana03ID, @Ana04ID,@Ana05ID,@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID, 
						@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate,            
						ROUND(isnull(@OriginalAmount,@ConvertedAmount), @OriginalDecimal), ROUND(@ConvertedAmount, @ConvertedDecimal), 
						GetDate(), @UserID, GetDate(), @UserID)

				UPDATE AT1704 SET TransactionID = @TransactionID WHERE JobID = @JobID AND DivisionID = @DivisionID AND TranMonth =@TranMonth AND TranYear =@TranYear AND D_C = @D_C

			End
		Else -----Ket chuyen chi phi
			Begin
				INSERT AT9000 	(TransactionID, TableID, BatchID, VoucherID, TDescription, BDescription, VDescription,
						CurrencyID, CurrencyIDCN, ExchangeRate, ExchangeRateCN, VoucherDate, VoucherTypeID, VoucherNo,
						TransactionTypeID, TranMOnth, TranYear, DivisionID,
						DebitAccountID, CreditAccountID, 
						Ana01ID, Ana02ID, Ana03ID, Ana04ID,	Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID, 
						ObjectID,Serial, InvoiceNo, InvoiceDate, PeriodID,
						OriginalAmount, ConvertedAmount, 
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
			
				VALUES 	( @TransactionID, 'AT1704', @VoucherID, @VoucherID, @BDescription, @BDescription, @BDescription,
						isnull(@CurrencyID,@BaseCurrencyID), isnull(@CurrencyID,@BaseCurrencyID), isnull(@ExchangeRate,1), isnull(@ExchangeRate,1), @VoucherDate, @VoucherTypeID, @VoucherNo,
						'T38', @TranMonth, @TranYear, @DivisionID,  --- But toan phan bo chi phi
						@DebitAccountID, @CreditAccountID, 
						@Ana01ID,   @Ana02ID,  @Ana03ID,@Ana04ID,	@Ana05ID,@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID, 
						@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate, @PeriodID,             
						ROUND(isnull(@OriginalAmount,@ConvertedAmount), @OriginalDecimal) , ROUND(@ConvertedAmount, @ConvertedDecimal), 
						GetDate(), @UserID, GetDate(), @UserID)

				UPDATE AT1704 SET TransactionID = @TransactionID WHERE JobID = @JobID AND DivisionID = @DivisionID AND TranMonth =@TranMonth AND TranYear =@TranYear AND D_C = @D_C
				
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
							
					UPDATE AT1704 SET AdvanceID = @AdvanceID WHERE JobID = @JobID AND DivisionID = @DivisionID AND TranMonth =@TranMonth AND TranYear =@TranYear AND D_C = @D_C
				END
			End
			
---Print @TransactionID
					
	FETCH NEXT FROM @Job_cur INTO  @DebitAccountID, @CreditAccountID, @OriginalAmount, @ConvertedAmount,
		@VoucherNo, @VoucherTypeID, @BDescription, @VoucherDate,
		@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID, @Ana05ID,@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID,
		@ObjectID,@SerialNo, @InvoiceNo, @InvoiceDate, @JobID, @PeriodID, @CurrencyID, @ExchangeRate           
		
	End
CLOSE @Job_cur


UPDATE AT1704 
SET  Status =1
WHERE TranMonth = @TranMonth and
	TranYear = @TranYear and
	DivisionID =@DivisionID and
	AT1704.D_C = @D_C and JobID like @JobIDInput

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
