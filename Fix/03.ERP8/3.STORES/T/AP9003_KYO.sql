IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP9003_KYO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP9003_KYO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






------ 	Created by Dang Tieu Mai, Date 27/06/2016
-----	Purpose: Phan bo chi phi Customize cho KOYO (CustomizeIndex = 52)

/*
 exec AP9003 @Divisionid=N'KVC',@Frommonth=6,@Fromyear=2016,@Tomonth=6,@Toyear=2016,@Accountid=N'6321',@Coraccountid=N'1111',@Groupid=N'G06',
 @Voucherdate='2016-06-27 13:57:55.870',@Vouchertypeid=N'CT',@Voucherno=N'CT/06/16/001',@Employeeid=N'',@Description=N'test',@Coefficientid=N'HSPB001',
 @Userid=N'ASOFTADMIN',@Ana02id=N'',@Ana03id=N''

 */


CREATE PROCEDURE [dbo].[AP9003_KYO]		@DivisionID NVARCHAR(50),
					@FromMonth INT,
					@FromYear INT,
					@ToMonth INT,
					@ToYear INT,
					@AccountID  NVARCHAR(50),
					@CorAccountID  NVARCHAR(50),
					@GroupID  NVARCHAR(50),
					@VoucherDate DATETIME,
					@VoucherTypeID  NVARCHAR(50),
					@VoucherNo  NVARCHAR(50),
					@EmployeeID  NVARCHAR(50),
					@Description  NVARCHAR(250),
					@CoefficientID  NVARCHAR(50),
					@UserID  NVARCHAR(50),
					@Ana02ID  AS NVARCHAR(50), 
					@Ana03ID  AS NVARCHAR(50)	

AS
DECLARE @TranMonth AS INT,
	@TranYear AS INT,
	@DebitAccountID  NVARCHAR(50),
	@CreditAccountID NVARCHAR(50),
	@ConvertedAmount DECIMAL(28,8),
	@CurrencyID NVARCHAR(50),
	@AT9001_cur AS CURSOR ,
	@Ana_cur AS CURSOR,
	@AnaID AS NVARCHAR(50),
	@TotalValues AS DECIMAL(28,8),
	@CoValues AS MONEY,
	@NewTransactionID AS NVARCHAR(50),
	@NewVoucherID AS NVARCHAR(50),
	@CYear NVARCHAR(20),
	@NewBatchID AS NVARCHAR(50),
	@ConvertedDecimals AS INT,
	@TotalAmount AS DECIMAL(28,8),
	@DeltaAmount AS DECIMAL(28,8),
	@TransactionID AS NVARCHAR(50)

--Neu tong he so = 0 thi thoat
IF (SELECT SUM(ISNULL(RatioDecimal,0)) FROM AT0323 WITH (NOLOCK) WHERE  ApportionID =@CoefficientID AND DivisionID = @DivisionID) = 0 RETURN

	---@Ana03ID as  nvarchar(20)
SELECT @CurrencyID =  BaseCurrencyID,  @ConvertedDecimals =ConvertedDecimals  FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID
SET @CurrencyID= ISNULL(@CurrencyID,'VND')
SET @ConvertedDecimals =ISNULL(@ConvertedDecimals,0)
	
------ Part I:  Phan bo phat sinh No
SET @AT9001_cur = CURSOR SCROLL KEYSET FOR 	
	SELECT  	TranMonth ,  TranYear,     AccountID  AS DebitAccountID,            
		CorAccountID AS CreditAccountID,         SUM(ConvertedAmount) AS ConvertedAmount
	
	FROM 	AV9001 
	WHERE 	D_C ='D'   AND --- Phat sinh No
		GroupID = @GroupID AND ISNULL(Ana02ID,'') =ISNULL(@Ana02ID,'') AND  ISNULL(Ana03ID,'') = ISNULL(@Ana03ID,'') AND 
		AccountID = @AccountID AND 
		CorAccountID = @CorAccountID AND
		DivisionID = @DivisionID AND
		TableID <>'AT9001' AND
		(TranMonth + 100*TranYear BETWEEN @FromMonth +100*@FromYear AND  @ToMonth +100*@ToYear)
	GROUP BY TranMonth ,  TranYear,    AccountID , CorAccountID 

	OPEN	@AT9001_cur
	FETCH NEXT FROM @AT9001_cur INTO  @TranMonth, @TranYear, @DebitAccountID, @CreditAccountID, @ConvertedAmount
	WHILE @@Fetch_Status = 0
		BEGIN	
			SET @CYear = LTRIM(RTRIM(STR(@TranYear)))
			EXEC AP0000 @DivisionID, @NewVoucherID  OUTPUT, 'AT9001', 'AV', @CYear ,'',15, 3, 0, '-'
			WHILE EXISTS (SELECT TOP 1 1 FROM AT9001 WITH (NOLOCK) WHERE VoucherID = @NewVoucherID)
					BEGIN
					SET @NewVoucherID = NEWID()								
					END
			SET @TotalValues =0 
			SET @TotalValues = ( SELECT SUM(RatioDecimal) FROM AT0323 WITH (NOLOCK) WHERE  ApportionID =@CoefficientID)

			SET @Ana_cur = CURSOR SCROLL KEYSET FOR 
				SELECT DepartmentID, RatioDecimal FROM AT0323 WITH (NOLOCK) WHERE ApportionID =@CoefficientID
				OPEN @Ana_cur
			 	FETCH NEXT FROM @Ana_cur INTO  @AnaID, @CoValues
				WHILE @@Fetch_Status = 0
					BEGIN
					If  (@CoValues*@ConvertedAmount)/@TotalValues <>0
					   Begin
						Exec AP0000 @DivisionID, @NewTransactionID  OUTPUT, 'AT9001', 'AT', @CYear ,'',15, 3, 0, '-'
						While Exists (Select top 1 1 From AT9001 WITH (NOLOCK) Where TransactionID = @NewTransactionID)
							Begin
								SET @NewTransactionID = NEWID()
								
							End
						Insert AT9001 (TransactionID,  DivisionID,    TranMonth, TranYear,   VoucherID,  BatchID, 
								 VoucherTypeID,        VoucherNo,  DebitAccountID,       CreditAccountID,      CurrencyID,
							           	OriginalAmount,        ConvertedAmount ,      Description,    Ana01ID,  Ana02ID, Ana03ID,             ExchangeRate ,
							  	 VoucherDate , CoefficientID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
						Values	(@NewTransactionID,  @DivisionID,    @TranMonth, @TranYear,   @NewVoucherID,  @NewBatchID,
								 @VoucherTypeID,        @VoucherNo,  @DebitAccountID,       @CreditAccountID,      @CurrencyID,
							           	round( (@CoValues*@ConvertedAmount)/@TotalValues ,  @ConvertedDecimals),      round( (@CoValues*@ConvertedAmount)/@TotalValues ,  @ConvertedDecimals),         @Description,    @AnaID,   
								 @Ana02ID, @Ana03ID,        1 ,
							  	@VoucherDate, @CoefficientID, @UserID, GETDATE(), @UserID, GETDATE())
					End	
					---- Xu ly lam tron
						
					
					
					FETCH NEXT FROM @Ana_cur INTO  @AnaID, @CoValues

					End
				Close @Ana_cur
			---- Xu ly lam tron ---  	
			Set 	@TotalAmount =0
			Set @TotalAmount = (Select sum(ConvertedAmount) From AT9001 WITH (NOLOCK)
								 Where 	DivisionID = @DivisionID and 
									TranMonth =@TranMonth and
									 TranYear =@TranYear and
									CoefficientID = @CoefficientID and
									DebitAccountID = @DebitAccountID and
									CreditAccountID = @CreditAccountID and
									 isnull(Ana02ID,'') =isnull(@Ana02ID,'') and  isnull(Ana03ID,'') = isnull(@Ana03ID,'')  )
						
					Set @DeltaAmount = @ConvertedAmount - @TotalAmount
					If @DeltaAmount<>0 
						Begin
							set @TransactionID =''
							set @TransactionID = (Select top 1  TransactionID From AT9001  WITH (NOLOCK)
										 Where 	DivisionID = @DivisionID and TranMonth =@TranMonth and TranYear =@TranYear and
										CoefficientID = @CoefficientID and
										DebitAccountID = @DebitAccountID and
										CreditAccountID = @CreditAccountID
										Order by ConvertedAmount  Desc ) 
							if @TransactionID<>''
								Update AT9001 Set 	ConvertedAmount = ConvertedAmount +@DeltaAmount,
											OriginalAmount =OriginalAmount +@DeltaAmount
								Where TransactionID = @TransactionID

						End
		    FETCH NEXT FROM @AT9001_cur INTO  @TranMonth, @TranYear, @DebitAccountID, @CreditAccountID, @ConvertedAmount
		End

	
	Close @AT9001_cur
	
	
----- Part II: 	Phan bo phat sinh Co


SET @AT9001_cur = Cursor Scroll KeySet FOR 	
	Select  	TranMonth ,  TranYear,   CorAccountID as DebitAccountID,            
		  AccountID  as CreditAccountID,         
		Sum(ConvertedAmount) as ConvertedAmount
	From 	AV9001
	Where 	D_C ='C'   and --- Phat sinh No
		GroupID = @GroupID and	
		AccountID = @AccountID and 
		CorAccountID = @CorAccountID and
		DivisionID = @DivisionID and
		TableID <>'AT9001' and 
		(TranMonth + 100*TranYear Between @FromMonth +100*@FromYear and  @ToMonth +100*@ToYear)
	Group by TranMonth ,  TranYear,    AccountID , CorAccountID 

	OPEN	@AT9001_cur
	FETCH NEXT FROM @AT9001_cur INTO  @TranMonth, @TranYear, @DebitAccountID, @CreditAccountID, @ConvertedAmount

	WHILE @@Fetch_Status = 0
		Begin	
		  
			Set @CYear = ltrim(Rtrim(str(@TranYear)))
			Exec AP0000  @DivisionID, @NewVoucherID  OUTPUT, 'AT9001', 'AV', @CYear ,'',15, 3, 0, '-'
			While Exists (Select top 1 1 From AT9001 WITH (NOLOCK) Where VoucherID = @NewVoucherID)
					Begin
					Exec AP0000 @DivisionID, @NewVoucherID  OUTPUT, 'AT9001', 'AV', @CYear ,'',15, 3, 0, '-'
							
					End
			Set @TotalValues =0 
			Set @TotalValues = ( Select Sum(RatioDecimal) From AT0323 WITH (NOLOCK) Where  ApportionID =@CoefficientID)
			
			SET @Ana_cur = Cursor Scroll KeySet FOR 
				Select DepartmentID, RatioDecimal From AT0323 WITH (NOLOCK) Where ApportionID =@CoefficientID
				OPEN @Ana_cur
			 	FETCH NEXT FROM @Ana_cur INTO  @AnaID, @CoValues
				WHILE @@Fetch_Status = 0
					Begin
					  If  (@CoValues*@ConvertedAmount)/@TotalValues <>0
				 	    Begin
						Exec AP0000 @DivisionID, @NewTransactionID  OUTPUT, 'AT9001', 'AT', @CYear ,'',15, 3, 0, '-'
						While Exists (Select top 1 1 From AT9001 WITH (NOLOCK) Where TransactionID = @NewTransactionID)
							Begin
								Exec AP0000 @DivisionID, @NewTransactionID  OUTPUT, 'AT9001', 'AT', @CYear ,'',15, 3, 0, '-'
								
							End
						Insert AT9001 (TransactionID,  DivisionID,    TranMonth, TranYear,   VoucherID,  BatchID, 
								 VoucherTypeID,        VoucherNo,  DebitAccountID,       CreditAccountID,      CurrencyID,
							           	OriginalAmount,        ConvertedAmount ,      Description,    Ana01ID,              ExchangeRate ,
							  	 VoucherDate , CoefficientID)
						Values	(@NewTransactionID,  @DivisionID,    @TranMonth, @TranYear,   @NewVoucherID,  @NewBatchID,
								 @VoucherTypeID,        @VoucherNo,  @DebitAccountID,       @CreditAccountID,      @CurrencyID,
							           	round( (@CoValues*@ConvertedAmount)/@TotalValues ,  @ConvertedDecimals),   round( (@CoValues*@ConvertedAmount)/@TotalValues ,  @ConvertedDecimals),         @Description,    @AnaID,              1 ,
							  	@VoucherDate, @CoefficientID)
					End
		
					FETCH NEXT FROM @Ana_cur INTO  @AnaID, @CoValues
					End
				Close @Ana_cur
			---- Cap nhat trang thai phieu da duoc cap nhat
			Update AT9000 Set IsAudit = 1 
			Where TranMonth =  @TranMonth and TranYear =@TranYear and DebitAccountID =@DebitAccountID and CreditAccountID = @CreditAccountID  and  Isnull(Ana01ID,'') =''

		    FETCH NEXT FROM @AT9001_cur INTO  @TranMonth, @TranYear, @DebitAccountID, @CreditAccountID, @ConvertedAmount
		End
	
	Close @AT9001_cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
