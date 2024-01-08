IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP0306]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP0306]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




------ Created by Trung Dung, Date 02/05/2013
------ Updated by Văn Minh, Date 27/02/2020 : Bổ sung thêm DebitVoucherDate và CreditVoucherDate
-----  Purpose: Tu dong giai tru but toan tong hop chenh lech thanh toan

CREATE PROCEDURE BP0306 	
					@DivisionID varchar(20),
					@TranMonth as int,
					@TranYear as int,		
					@GiveVoucherID varchar(200),		
					@GiveBatchID 	 varchar(200),		
					@GiveTableID 	 varchar(20),		
					@VoucherID as varchar(200),
					@BacthID as varchar(200),
					@AccountID as varchar(20),
					@ObjectID as varchar(20),
					@CurrencyID as varchar(20),
					@DebitAccountID as varchar(20),
					@CreditAccountID  as varchar(20),
					@OriginalAmount as money,
					@ConvertedAmount as money,
					@UserID as varchar(20)
					

 AS
Declare @GiveUpID as varchar(20),
		@cksOriginalAmount bit,
		@CustomerIndex int,
		@DebitVoucherDate datetime,
		@CreditVoucherDate datetime

Exec AP0000  @DivisionID,@GiveUpID  OUTPUT, 'AT0303', 'G', @TranYear , @TranMonth,18, 3, 0, '-'

Select @CustomerIndex = CustomerName from CustomerIndex

IF @CustomerIndex = 110
BEGIN
	IF  	@CreditAccountID = @AccountID
	BEGIN
		SET @DebitVoucherDate = (SELECT TOP 1 VoucherDate FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @GiveVoucherID)
		SET @CreditVoucherDate = (SELECT TOP 1 VoucherDate FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID)
	END
	ELSE
	BEGIN
		SET @DebitVoucherDate = (SELECT TOP 1 VoucherDate FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID)
		SET @CreditVoucherDate = (SELECT TOP 1 VoucherDate FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @GiveVoucherID)
	END
END

IF @OriginalAmount < 0
BEGIN
	SET @cksOriginalAmount = 1
	SET @OriginalAmount = @OriginalAmount * -1
	SET @ConvertedAmount = @ConvertedAmount * -1
END


If  	@CreditAccountID = @AccountID
	Insert AT0303 (GiveUpID, GiveUpDate, GiveUpEmployeeID, DivisionID, ObjectID, AccountID, CurrencyID, 
		DebitVoucherID, DebitBatchID, DebitTableID, CreditVoucherID, CreditBatchID, CreditTableID, 
		OriginalAmount, ConvertedAmount, IsExrateDiff, CreateDate, CreateUseID, LastModifyUserID, LastModifyDate,DebitVoucherDate,CreditVoucherDate)
	Values  (@GiveUpID, getdate(), null, @DivisionID, @ObjectID, @AccountID, @CurrencyID,
		@GiveVoucherID, @GiveBatchID, @GiveTableID, @VoucherID, @BacthID, 'AT9000',
		@OriginalAmount, @ConvertedAmount, 0, getdate(), @UserID, @UserID, getDate(),@DebitVoucherDate,@CreditVoucherDate)
Else
	Insert AT0303 (GiveUpID, GiveUpDate, GiveUpEmployeeID, DivisionID, ObjectID, AccountID, CurrencyID, 
		DebitVoucherID, DebitBatchID, DebitTableID, CreditVoucherID, CreditBatchID, CreditTableID, 
		OriginalAmount, ConvertedAmount, IsExrateDiff, CreateDate, CreateUseID, LastModifyUserID, LastModifyDate,DebitVoucherDate,CreditVoucherDate)
	Values  (@GiveUpID, getdate(), null, @DivisionID, @ObjectID, @AccountID, @CurrencyID,
		 @VoucherID, @BacthID, 'AT9000',@GiveVoucherID, @GiveBatchID, @GiveTableID,
		@OriginalAmount, @ConvertedAmount, 0, getdate(), @UserID, @UserID, getDate(),@DebitVoucherDate,@CreditVoucherDate)

IF @cksOriginalAmount = 1 AND @CustomerIndex = 110 --Customize ri�ng cho Song B�nh
BEGIN
		Update AT9000 set Status = 1
		Where VoucherID = @VoucherID and TransactionTypeID='T99' AND DivisionID = @DivisionID
END
ELSE
BEGIN
		Update AT9000 set Status = 1
		Where VoucherID = @VoucherID and TransactionTypeID='T99' AND DivisionID = @DivisionID
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
