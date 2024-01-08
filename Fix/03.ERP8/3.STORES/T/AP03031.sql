IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP03031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



------ Created by Khanh Van
------ Modify by Phuong Thao on 14/10/2015 : Bo sung giai tru theo ma phan tich (Customize Sieu Thanh)
------ Modify by Phuong Thao on 14/10/2015 : Sinh them dong chenh lech theo TT200
------ Modify by Hoàng Vũ on 09/03/2016 :  Customize cho hoàng trần (thiết có check vào tự động giải trừ công nợ khi kế thừa hóa đơn: nếu kế thừa từ hóa đơn bàn bán hàng theo bộ thì phải thực hiện được chức năng giải trừ công nợ phải thu)
------ Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
------ Modified by Bảo Anh on 17/06/2016: Lấy ngày giải trừ theo ngày chứng từ sau cùng
------ Modified by Đức Thông on 19/11/2020: Nếu tài khoản công nợ không quản lí theo đối tượng thì không cần sinh ra giải trừ công nợ

CREATE PROCEDURE [dbo].[AP03031]	
					@DivisionID nvarchar(50), 
					@AccountID nvarchar(50), 
					@CurrencyID nvarchar(50), 
					@ObjectID nvarchar(50), 			
					@TranYear int, 							
					@GiveupDate AS Datetime,
					@GiveupEmployeeID AS nvarchar(50),
					@UserID AS nvarchar(50),
					@VoucherID nvarchar(50), 
					@BatchID nvarchar(50), 
					@TableID nvarchar(50), 
					@OriginalAmountRemain decimal (28,8),
					@ConvertedAmountRemain decimal (28,8),
					@TVoucherID nvarchar(50), 
					@TBatchID nvarchar(50),
					@Ana01ID Nvarchar(50) = '',
					@Ana02ID Nvarchar(50) = '',
					@Ana03ID Nvarchar(50) = '',
					@Ana04ID Nvarchar(50) = '',
					@Ana05ID Nvarchar(50) = '',
					@Ana06ID Nvarchar(50) = '',
					@Ana07ID Nvarchar(50) = '',
					@Ana08ID Nvarchar(50) = '',
					@Ana09ID Nvarchar(50) = '',
					@Ana10ID Nvarchar(50) = ''
AS			

Declare @GiveUpID nvarchar(50),	
		@CrTableID  AS nvarchar(50),
		@CreditVoucherDate Datetime,
		@TransactionTypeID as nvarchar(50),
		@VatConvertedAmount decimal (28,8),
		@VATOriginalAmount decimal (28,8),
		@Temp as nvarchar(50),
		@IsMultiTax as int,
		@Cor_cur as cursor,
		@VoucherDate Datetime,
		@CustomerName INT,
		--@ExchangeRate as Decimal(28,8),
		@GroupAccountID As Nvarchar(50),
		--@CLTransactionID As NVarchar(50),
		@CLBatchID As NVarchar(50),
		@CLVoucherID As Nvarchar(50),
		@CLAmount As Decimal(28,8),
		@TransactionID As Nvarchar(50),
		@IsObject TINYINT,
		@IsDefaultGiveUpDate tinyint

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 16 --- Customize Sieu Thanh
	EXEC AP03031_ST @DivisionID, @AccountID, @CurrencyID, @ObjectID, @TranYear, @GiveupDate, @GiveupEmployeeID, @UserID, 
					@VoucherID, @BatchID, @TableID, @OriginalAmountRemain, @ConvertedAmountRemain, @TVoucherID, @TBatchID,
					@Ana01ID ,	@Ana02ID ,	@Ana03ID ,	@Ana04ID ,	@Ana05ID ,
					@Ana06ID ,	@Ana07ID ,	@Ana08ID ,	@Ana09ID ,	@Ana10ID 

ELSE IF @CustomerName = 51 --- Customize Hoàng trần
	EXEC AP03031_HT @DivisionID, @AccountID, @CurrencyID, @ObjectID, @TranYear, @GiveupDate, @GiveupEmployeeID, @UserID, 
					@VoucherID, @BatchID, @TableID, @OriginalAmountRemain, @ConvertedAmountRemain, @TVoucherID, @TBatchID,
					@Ana01ID ,	@Ana02ID ,	@Ana03ID ,	@Ana04ID ,	@Ana05ID ,
					@Ana06ID ,	@Ana07ID ,	@Ana08ID ,	@Ana09ID ,	@Ana10ID

Else
BEGIN
	SET @CrTableID =''

	SELECT @IsDefaultGiveUpDate = Isnull(IsDefaultGiveUpDate,0) FROM AT0000 WHERE DefDivisionID = @DivisionID
	
	--IF @IsDefaultGiveUpDate = 1
	--BEGIN
		SELECT @GiveupDate = max(VoucherDate)
		FROM AT9000
		WHERE DivisionID = @DivisionID AND (VoucherID = @TVoucherID Or VoucherID = @VoucherID)
	--END

	SELECT	@GroupAccountID = GroupID, @IsObject = IsObject
	FROM	AT1005 WITH (NOLOCK)
	WHERE	AccountID = @AccountID

	IF @IsObject = 0
		RETURN
	
	Select top 1  @CreditVoucherDate = voucherdate, @CrTableID = TableID from AT9000 WITH (NOLOCK) where VoucherID =@VoucherID and DivisionID = @DivisionID and BatchID=@BatchID
	Select @IsMultiTax = MAX(ISNULL(IsMultiTax,0)) from AT9000 WITH (NOLOCK) where DivisionID=@DivisionID and VoucherID = @VoucherID	
	IF ISNULL(@TVoucherID,'') <>''	and ISNULL(@TBatchID,'')<>'' and @GroupAccountID = 'G03'
	BEGIN
		SELECT  	@VoucherDate = VoucherDate
		FROM	AT9000 WITH (NOLOCK)	 
		Where VoucherID =@TVoucherID and DivisionID = @DivisionID 

		SET @Cor_cur = Cursor Scroll KeySet FOR 
		SELECT top 1(select top 1 TransactionTypeID From AT9000 a WITH (NOLOCK) where a.VoucherID=b.TVoucherID and a.DivisionID=b.DivisionID)
		FROM AT9000 b WITH (NOLOCK)
		Where VoucherID = @VoucherID and DivisionID = @DivisionID and BatchID=@BatchID and isnull(b.TvoucherID,'')<>''
		Group by b.TVoucherID, b.DivisionID, TransactionTypeID
		OPEN	@Cor_cur
		FETCH NEXT FROM @Cor_cur INTO   @TransactionTypeID
		WHILE @@Fetch_Status = 0
		BEGIN
		DECLARE @Month datetime = MONTH(GETDATE())
		Exec AP0000  @DivisionID, @GiveUpID  OUTPUT, 'AT0303', 'G', @Month ,@TranYear,18, 3, 0, '-'
		
		If @TransactionTypeID in ('T01','T21')
		Begin
		INSERT AT0303 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
						ObjectID, AccountID, CurrencyID, 
						DebitVoucherID, DebitBatchID, DebitTableID,
						CreditVoucherID, CreditBatchID, CreditTableID,
						OriginalAmount ,ConvertedAmount, DebitVoucherDate, CreditVoucherDate,
						CreateDate, CreateUseID, LastModifyDate, LastModifyUserID)

		VALUES (	@GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
					@ObjectID, @AccountID, @CurrencyID,
					@VoucherID, @BatchID, @CrTableID,
					@TVoucherID, @TBatchID, @TableID,
					@OriginalAmountRemain , @ConvertedAmountRemain, @CreditVoucherDate, @VoucherDate,
					getdate(), @UserID, getdate(), @UserID)
					
				UPDATE	AT9000 
				SET		Status = 1
				WHERE 	DivisionID = @DivisionID AND VoucherID =@TVoucherID AND	
						BatchID =@TBatchID AND TableID = @TableID AND 
						ObjectID = @ObjectID				
						AND CurrencyIDCN = @CurrencyID AND Status = 0
						
				UPDATE	AT9000 
				SET		Status = 1
				WHERE 	DivisionID = @DivisionID AND VoucherID = @VoucherID AND	
						BatchID =@BatchID AND TableID = @CrTableID AND 
						ObjectID  = @ObjectID 
						AND CurrencyIDCN = @CurrencyID AND Status = 0
					
		End
		Else -- @TransactionTypeID in ('T01','T21')
		Begin
			If @IsMultiTax <>1 
			Begin
				INSERT AT0303 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
						ObjectID, AccountID, CurrencyID, DebitVoucherID, DebitBatchID, DebitTableID,
						CreditVoucherID, CreditBatchID, CreditTableID,
						OriginalAmount ,ConvertedAmount, DebitVoucherDate, CreditVoucherDate,
						CreateDate, CreateUseID, LastModifyDate, LastModifyUserID)

				VALUES (	@GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
					@ObjectID, @AccountID, @CurrencyID, 
					@TVoucherID, @TBatchID, @TableID,
					@VoucherID, @BatchID, @CrTableID,
					@OriginalAmountRemain , @ConvertedAmountRemain, @VoucherDate, @CreditVoucherDate,
					getdate(), @UserID, getdate(), @UserID)

				IF EXISTS (SELECT TOP 1 1 FROM	AT9000 WITH (NOLOCK)
						WHERE	ReBatchID = @BatchID AND ReVoucherID = @VoucherID 
								AND CurrencyID = @CurrencyID AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
								AND CreditAccountID = @AccountID)
				BEGIN
					SELECT	@CLBatchID = BatchID, @CLVoucherID = VoucherID, @CLAmount = ConvertedAmount
					FROM	AT9000 WITH (NOLOCK)
					WHERE	ReVoucherID = @VoucherID  AND ReBatchID = @BatchID
							AND CurrencyID = @CurrencyID AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
							AND CreditAccountID = @AccountID 

					--select @CLVoucherID, @CLBatchID

					Exec AP0000  @DivisionID, @GiveUpID  OUTPUT, 'AT0303', 'G', @TranYear ,'',18, 3, 0, '-'
						

					INSERT AT0303 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
									ObjectID, AccountID, CurrencyID, 
									DebitVoucherID, DebitBatchID, DebitTableID,
									CreditVoucherID, CreditBatchID, CreditTableID,
									OriginalAmount ,ConvertedAmount, DebitVoucherDate, CreditVoucherDate,
									CreateDate, CreateUseID, LastModifyDate, LastModifyUserID)

					VALUES (	@GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
								@ObjectID, @AccountID, @CurrencyID, 
								@TVoucherID, @TBatchID, @TableID,
								@CLVoucherID, @CLBatchID, 'AT9000',							
								0 , @CLAmount, @VoucherDate, @CreditVoucherDate,
								getdate(), @UserID, getdate(), @UserID)
		
					UPDATE AT9000
					SET		Status = 1
					WHERE	BatchID = @CLBatchID AND VoucherID = @CLVoucherID
							AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
				END												
					
			End
			Else -- @IsMultiTax <>1 
			Begin
				Set @VATOriginalAmount = (Select top 1 VATOriginalAmount from AT9000 WITH (NOLOCK) where DivisionID =@DivisionID and VoucherID =@VoucherID and BatchID = @BatchID and OriginalAmount =@OriginalAmountRemain)
				Set @VatConvertedAmount = (Select top 1 VatConvertedAmount from AT9000 WITH (NOLOCK) where DivisionID =@DivisionID and VoucherID =@VoucherID and BatchID = @BatchID and ConvertedAmount =@ConvertedAmountRemain)	
				Set @Temp = (Select top 1 TransactionTypeID from AT9000 WITH (NOLOCK) where DivisionID =@DivisionID and VoucherID =@VoucherID and BatchID = @BatchID and ConvertedAmount =@ConvertedAmountRemain)
				If	@Temp <>'T34'
				Begin
					INSERT AT0303 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
							ObjectID, AccountID, CurrencyID, DebitVoucherID, DebitBatchID, DebitTableID,
							CreditVoucherID, CreditBatchID, CreditTableID,
							OriginalAmount ,ConvertedAmount, DebitVoucherDate, CreditVoucherDate,
							CreateDate, CreateUseID, LastModifyDate, LastModifyUserID)

					VALUES (	@GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
						@ObjectID, @AccountID, @CurrencyID, 
						@TVoucherID, @TBatchID, @TableID,
						@VoucherID, @BatchID, @CrTableID,
						@OriginalAmountRemain+@VATOriginalAmount , @ConvertedAmountRemain+@VatConvertedAmount, @VoucherDate, @CreditVoucherDate,
						getdate(), @UserID, getdate(), @UserID)		
					
					IF EXISTS (SELECT TOP 1 1 FROM	AT9000 WITH (NOLOCK)
						WHERE	ReBatchID = @BatchID AND ReVoucherID = @VoucherID 
								AND CurrencyID = @CurrencyID AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
								AND CreditAccountID = @AccountID)
					BEGIN
						SELECT	@CLBatchID = BatchID, @CLVoucherID = VoucherID, @CLAmount = ConvertedAmount
						FROM	AT9000 WITH (NOLOCK)
						WHERE	ReVoucherID = @VoucherID  AND ReBatchID = @BatchID
								AND CurrencyID = @CurrencyID AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
								AND CreditAccountID = @AccountID 

						--select @CLVoucherID, @CLBatchID

						Exec AP0000  @DivisionID, @GiveUpID  OUTPUT, 'AT0303', 'G', @TranYear ,'',18, 3, 0, '-'
						

						INSERT AT0303 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
										ObjectID, AccountID, CurrencyID, 
										DebitVoucherID, DebitBatchID, DebitTableID,
										CreditVoucherID, CreditBatchID, CreditTableID,
										OriginalAmount ,ConvertedAmount, DebitVoucherDate, CreditVoucherDate,
										CreateDate, CreateUseID, LastModifyDate, LastModifyUserID)

						VALUES (	@GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
									@ObjectID, @AccountID, @CurrencyID, 
									@TVoucherID, @TBatchID, @TableID,
									@CLVoucherID, @CLBatchID, 'AT9000',								
									0 , @CLAmount, @VoucherDate, @CreditVoucherDate,
									getdate(), @UserID, getdate(), @UserID)
		
						UPDATE AT9000
						SET		Status = 1
						WHERE	BatchID = @CLBatchID AND VoucherID = @CLVoucherID
								AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
					END			
				End
			End
				UPDATE	AT9000 
				SET		Status = 1
				WHERE 	DivisionID = @DivisionID AND VoucherID =@TVoucherID AND	
						BatchID =@TBatchID AND TableID = @TableID AND 
						(Case when TransactionTypeID <>'T99' then ObjectID Else CreditObjectID End) = @ObjectID							
						AND CurrencyIDCN = @CurrencyID AND Status = 0
						
				UPDATE	AT9000 
				SET		Status = 1
				WHERE 	DivisionID = @DivisionID AND VoucherID = @VoucherID AND	
						BatchID =@BatchID AND TableID = @CrTableID AND 
						(Case when TransactionTypeID <>'T99' then ObjectID Else CreditObjectID End) = @ObjectID 
						AND CurrencyIDCN = @CurrencyID AND Status = 0
				
				
		End
			
		FETCH NEXT FROM @Cor_cur INTO  @TransactionTypeID
		End
		Close @Cor_cur
						
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO