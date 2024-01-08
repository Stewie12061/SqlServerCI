IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP04041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP04041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created by Khanh Van
------ Modified by Phương Thảo on 20/01/2016: Sinh them dong but toan chenh lech theo TT200
------ Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
------ Modified by Bảo Anh on 17/06/2016: Lấy ngày giải trừ theo ngày chứng từ sau cùng
------ Modified by Phương Thảo on 01/08/2016: Chỉnh sửa đoạn update nếu phiếu giải trừ là phiếu tổng hợp (xử lý lấy creditobjectid)
------ Modified by Đức Thông on 19/11/2020: Bổ sung check tài khoản không quản lí đối tượng thì không thực hiện giải trừ
------ Modified by Đức Thông on 08/12/2020: Lấy đối tượng có của phiếu giải trừ là đối tượng nợ của phiếu kế thừa

CREATE PROCEDURE [dbo].[AP04041]	 
					@DivisionID nvarchar(50), 
					@AccountID nvarchar(50), 
					@CurrencyID nvarchar(50), 
					@ObjectID nvarchar(50), 			
					@TranYear int, 							
					@GiveupDate as Datetime,
					@GiveupEmployeeID as nvarchar(50),
					@UserID as nvarchar(50),
					@VoucherID nvarchar(50), 
					@BatchID nvarchar(50), 
					@TableID nvarchar(50), 
					@OriginalAmountRemain decimal(28,8),
					@ConvertedAmountRemain decimal(28,8),
					@TVoucherID nvarchar(50), 
					@TBatchID nvarchar(50)

 AS			

Declare @GiveUpID nvarchar(50),	
	@VoucherDate Datetime,
	@DeTableID  as nvarchar(50),
	@TransactionTypeID as nvarchar(50),
	@Cor_cur as cursor,
	@DebitVoucherDate Datetime,
	@ExchangeRate as Decimal(28,8),
	@GroupAccountID As Nvarchar(50),
	@CLTransactionID As NVarchar(50),
	@CLBatchID As NVarchar(50),
	@CLVoucherID As Nvarchar(50),
	@CLAmount As Decimal(28,8),
	@TransactionID As Nvarchar(50),
	@IsDefaultGiveUpDate tinyint,
	@IsObject TINYINT
		
Set @DeTableID =''

Select top 1  @DebitVoucherDate = voucherdate, @DeTableID = TableID from AT9000 WITH (NOLOCK) where VoucherID =@VoucherID and DivisionID = @DivisionID and BatchID=@BatchID

SELECT	@GroupAccountID = GroupID, @IsObject = IsObject
FROM	AT1005 WITH (NOLOCK)
WHERE	AccountID = @AccountID

IF @IsObject = 0
	RETURN

SELECT @ExchangeRate = ExchangeRate, @TransactionID = TransactionID
FROM	AT9000 WITH (NOLOCK)
WHERE	VoucherID = @VoucherID AND ReBatchID = @BatchID and DivisionID = @DivisionID
		--and	OriginalAmountCN = @OriginalAmountRemain and ConvertedAmount = @ConvertedAmountRemain	

SELECT @IsDefaultGiveUpDate = Isnull(IsDefaultGiveUpDate,0) FROM AT0000 WHERE DefDivisionID = @DivisionID
	
--IF @IsDefaultGiveUpDate = 1
--BEGIN
	SELECT @GiveupDate = max(VoucherDate)
	FROM AT9000
	WHERE DivisionID = @DivisionID AND (VoucherID = @TVoucherID Or VoucherID = @VoucherID)
--END
--select @GroupAccountID

IF ISNULL(@TVoucherID,'') <>''	and ISNULL(@TBatchID,'')<>'' and @GroupAccountID = 'G04'
Begin
	SELECT  	@VoucherDate = VoucherDate
	FROM	AT9000	 
	Where VoucherID =@TVoucherID and DivisionID = @DivisionID 

	SET @Cor_cur = Cursor Scroll KeySet FOR 		 
	SELECT  top 1 (select top 1 TransactionTypeID From AT9000 a WITH (NOLOCK) where a.VoucherID=b.TVoucherID and a.DivisionID=b.DivisionID)
	FROM AT9000 b WITH (NOLOCK)
	Where VoucherID = @VoucherID and DivisionID = @DivisionID and BatchID=@BatchID and isnull(b.TvoucherID,'')<>''
	Group by b.TVoucherID, b.DivisionID, TransactionTypeID
	OPEN	@Cor_cur
	FETCH NEXT FROM @Cor_cur INTO   @TransactionTypeID
	WHILE @@Fetch_Status = 0
	BEGIN
		Exec AP0000 @DivisionID, @GiveUpID  OUTPUT, 'AT0404', 'G', @TranYear ,'',18, 3, 0, '-'
		If @TransactionTypeID in ('T02','T22')
		Begin
		--select 'aaaaaaaaaaa'
		Insert AT0404 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
						ObjectID, AccountID, CurrencyID,
						DebitVoucherID, DebitBatchID, DebitTableID,
						CreditVoucherID, CreditBatchID, CreditTableID,
						OriginalAmount ,ConvertedAmount, CreateDate, CreateUserID, 
						LastModifyDate, LastModifyUserID,DebitVoucherDate, CreditVoucherDate)

		Values ( @GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
					@ObjectID, @AccountID, @CurrencyID, @TVoucherID, @TBatchID, @TableID,
				@VoucherID, @BatchID, @DeTableID,@OriginalAmountRemain , @ConvertedAmountRemain,
				getdate(), @UserID, getdate(), @UserID,@VoucherDate,@DebitVoucherDate) 
	
		
		Update AT9000 
		Set Status = 1 
		Where 	DivisionID = @DivisionID and VoucherID =@TVoucherID and	
				BatchID =@TBatchID and TableID = @TableID and 
				(Case when TransactionTypeID ='T99' then CreditObjectID Else ObjectID End) = @ObjectID and 
				CurrencyIDCN = @CurrencyID 

		Update AT9000 
		Set Status = 1   
		Where 	DivisionID = @DivisionID and VoucherID =@VoucherID and	
				BatchID =@BatchID and TableID = @DeTableID and 
				(Case when TransactionTypeID ='T99' then CreditObjectID Else ObjectID End)   = @ObjectID and 
							CurrencyIDCN = @CurrencyID 
		End
		Else--@TransactionTypeID not in ('T02','T22')
		Begin
		Insert AT0404 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
						ObjectID, AccountID, CurrencyID,
						DebitVoucherID, DebitBatchID, DebitTableID,
						CreditVoucherID, CreditBatchID, CreditTableID,
						OriginalAmount ,ConvertedAmount, CreateDate, CreateUserID, 
						LastModifyDate, LastModifyUserID,DebitVoucherDate, CreditVoucherDate)

		Values ( @GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
				@ObjectID, @AccountID, @CurrencyID, 
				@VoucherID, @BatchID, @DeTableID,
				@TVoucherID, @TBatchID, @TableID,@OriginalAmountRemain , @ConvertedAmountRemain,
				getdate(), @UserID, getdate(), @UserID,@DebitVoucherDate,@VoucherDate) 
	
	
		IF EXISTS (SELECT TOP 1 1 FROM	AT9000 WITH (NOLOCK)
					WHERE	BatchID = @BatchID AND VoucherID = @VoucherID AND TransactionID = @TransactionID
							AND CurrencyID = @CurrencyID AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
							AND DebitAccountID = @AccountID)
		--select @VoucherID,@BatchID
		BEGIN


			SELECT	@CLBatchID = BatchID, @CLVoucherID = VoucherID, @CLTransactionID = TransactionID, @CLAmount = ConvertedAmount
			FROM	AT9000
			WHERE	VoucherID = @VoucherID  AND BatchID = @BatchID AND TransactionID = @TransactionID
					AND CurrencyID = @CurrencyID AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
					AND DebitAccountID = @AccountID 
			--select @VoucherID,@BatchID
			--select @CLVoucherID, @CLBatchID

			Exec AP0000 @DivisionID, @GiveUpID  OUTPUT, 'AT0404', 'G', @TranYear ,'',18, 3, 0, '-'

			INSERT AT0404 	(GiveUpID,  GiveUpDate, GiveUpEmployeeID, DivisionID,
							ObjectID, AccountID, CurrencyID, 
							DebitVoucherID, DebitBatchID, DebitTableID,
							CreditVoucherID, CreditBatchID, CreditTableID,
							OriginalAmount ,ConvertedAmount, CreateDate, CreateUserID, 
							LastModifyDate, LastModifyUserID,DebitVoucherDate, CreditVoucherDate)

			VALUES (	@GiveUpID,  @GiveUpDate, @GiveUpEmployeeID, @DivisionID,
						@ObjectID, @AccountID, @CurrencyID, 
						@CLVoucherID, @CLBatchID, 'AT9000',
						@TVoucherID, @TBatchID, @TableID,0 , @CLAmount,
						getdate(), @UserID, getdate(), @UserID,@VoucherDate,@DebitVoucherDate) 

			UPDATE AT9000
			SET		Status = 1
			WHERE	BatchID = @CLBatchID AND VoucherID = @CLVoucherID AND TransactionID = @CLTransactionID
					AND TransactionTypeID = 'T10' and DivisionID = @DivisionID
		END


		-- Update phiếu gốc
		Update AT9000 
		Set Status = 1 
		Where 	DivisionID = @DivisionID
				AND VoucherID =@TVoucherID
				AND	BatchID =@TBatchID
				AND TableID = @TableID
				AND 
				--ObjectID = @ObjectID and 
				CreditObjectID = @ObjectID and 
				CurrencyIDCN = @CurrencyID 
		
		-- Update phiếu kế thừa
		Update AT9000 
		Set Status = 1   
		Where 	DivisionID = @DivisionID and VoucherID =@VoucherID and	
				BatchID =@BatchID and TableID = @DeTableID and 
				--ObjectID  = @ObjectID and 
				ObjectID = @ObjectID and 
				CurrencyIDCN = @CurrencyID 

		End
				FETCH NEXT FROM @Cor_cur INTO  @TransactionTypeID
	END
Close @Cor_cur
End	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
