IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0303]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0303]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----- 	Created by Nguyen Van Nhan, Date 13/11/2003
----- 	Purpose: Xoa but toan giai tru cong no phai thu.
-----	Last Updated by Nguyen Van Nhan, Date 31/07/2004
-----        Edit by: Dang Le Bao Quynh; Date 25/06/2008
-----	Purpose: Xoa but toan chenh lech No tu CreditObjectID -> ObjectID
----- Modified by Phương Thảo on 15/01/2016: Xóa dữ liệu chênh lệch (nhưng ko tham gia giải trừ) - theo TT200
----- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
----- Modified by Văn Minh on 10/12/2019: Bổ sung xóa phiếu chênh lệch - Nợ khi giải trừ công nợ cho Song Bình
----- Modified by Văn Minh on 18/03/2020: Bổ sung xóa phiếu chênh lệch - Có khi giải trừ công nợ cho Song Bình

------ Created by Hoàng Vũ on 09/03/2016: Customize cho hoàng trần (thiết có check vào tự động giải trừ công nợ khi kế thừa hóa đơn: nếu kế thừa từ hóa đơn bàn bán hàng theo bộ thì phải thực hiện được chức năng giải trừ công nợ phải thu) thực hiện bỏ giải trừ
/********************************************
'* Edited by: [GS] [Tố Oanh] [28/07/2010]
'********************************************/
/*
exec AP0303 @DivisionID=N'HT',@VoucherID=N'AVd5b4dcd3-71ff-4653-8b33-03ad1fe27497',@BatchID=N'AB257ca785-3ecd-489e-bdb9-cb2784c0ffea',
@TableID=N'AT1326',@ObjectID=N'VUTESTX01',@CurrencyID=N'VND',@AccountID=N'1311',@D_C=N'D', @ExchangeRate=1

*/


CREATE PROCEDURE [dbo].[AP0303] @DivisionID nvarchar(50), 
				  @VoucherID nvarchar(50),
				  @BatchID as nvarchar(50),
				  @TableID as  nvarchar(50),
				  @ObjectID nvarchar(50),
				  @CurrencyID nvarchar(50),
				  @AccountID nvarchar(50),
				  @D_C as nvarchar(1),  ---- 'D' neu la o phieu PS NO
							--- 'C' neu la phat sinh co
				  @ExchangeRate As Decimal(28,8) = 1

 AS
Declare @CorVoucherID as nvarchar(50),
	@CorBatchID as nvarchar(50),
	@CorTableID as nvarchar(50),
	@OriginalAmount as decimal (28,8),
	@GivedOriginalAmount as decimal (28,8),
	@CustomerName INT,
	@SaveVoucherID as nvarchar(50),
	@Cor_cur as cursor
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 51 --- Customize Hoàng trần
	EXEC AP0303_HT @DivisionID, @VoucherID, @BatchID, @TableID, @ObjectID, @CurrencyID, @AccountID, @D_C, @ExchangeRate

Else
Begin
	IF(ISNULL(@CurrencyID,'VND') = 'VND')
	BEGIN
		SET @CurrencyID = 'VND'
	END 

	IF @D_C ='D'   ---- Truong ho o ben No bo giai tru ----------------------------------------------------------------
	Begin
		SET @Cor_cur = Cursor Scroll KeySet FOR 
		Select 	CreditVoucherID, CreditBatchID, CreditTableID,  Sum(OriginalAmount)
		From AT0303 WITH (NOLOCK) Where DebitVoucherID = @VoucherID  and
					DebitBatchID = @BatchID and
					DebitTableID = @TableID and
					AccountID =@AccountID and
					ObjectID = @ObjectID and
					DivisionID =@DivisionID and
					CurrencyID =@CurrencyID

		Group by CreditVoucherID, CreditBatchID, CreditTableID

		OPEN	@Cor_cur
		FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID,  @CorBatchID,  @CorTableID, @OriginalAmount
		WHILE @@Fetch_Status = 0
		Begin	

				-- Tìm phiếu CLTG
				IF @CustomerName IN (13)
				BEGIN
					SET @SaveVoucherID = (SELECT DebitVoucherID FROM AT0303 T03 WITH (NOLOCK)
										  LEFT JOIN AT9000 T90 WITH (NOLOCK) ON T90.VoucherID = T03.DebitVoucherID AND T90.BatchID = T03.DebitBatchID
										  WHERE T90.TransactionTypeID = 'T10'
										  AND T03.CreditVoucherID = @CorVoucherID 
										  AND T03.CreditBatchID = @CorBatchID 
										  AND T03.CreditTableID = @CorTableID)
				END

				Set @GivedOriginalAmount =0
				Set @GivedOriginalAmount  = (Select Sum(isnull(OriginalAmount,0)) 
								From  AT0303 WITH (NOLOCK) Where 	DivisionID = @DivisionID and
											ObjectID = @ObjectID  and
											CreditVoucherID = @CorVoucherID and
											CreditBatchID = @CorBatchID and
											CreditTableID = @CorTableID and
											AccountID = @AccountID and
											CurrencyID =  @CurrencyID)	
													
				If @GivedOriginalAmount = @OriginalAmount	
				Update AT9000 Set Status = 0
				Where 	DivisionID = @DivisionID and
					VoucherID = @CorVoucherID and
					BatchID = @CorBatchID and
					TableID = @CorTableID and 
					(Case When TransactionTypeID ='T99' then CreditObjectID else ObjectID end) = @ObjectID and 
					CreditAccountID =@AccountID and
					CurrencyIDCN = @CurrencyID
		
				Delete AT9000 Where (VoucherID = @CorVoucherID or VoucherID = @VoucherID)  and
					(BatchID = @CorBatchID or BatchID = @BatchID) and
					(TableID = @CorTableID or TableID = @TableID) and
					(TransactionTypeID ='T10' OR (TransactionTypeID ='T99' AND IsAutoGen=1)) and
					DivisionID = @DivisionID and
					CurrencyID = @CurrencyID

				-- Xoa du lieu phieu chenh lech khong tham gia giai tru (luu vao phieu Thu)
				DELETE AT9000 
				WHERE	ReVoucherID = @CorVoucherID AND ReBatchID = @CorBatchID
						AND ReTableID = 'AT9000' AND (TransactionTypeID = 'T10' OR (TransactionTypeID = 'T99' AND IsAutoGen = 1))
						AND DivisionID = @DivisionID 
						AND CurrencyID = @CurrencyID

										-- Xoa phieu chenh lech but toan
					IF @CustomerName = 110
					BEGIN
						SET @SaveVoucherID = (Select TOP 1 DebitVoucherID FROM AT0303 WHERE CreditVoucherID = @CorVoucherID AND (ConvertedAmount > 0 AND ConvertedAmount < 1000))
						DELETE AT0303 WHERE DebitVoucherID = @SaveVoucherID  AND											
											ObjectID = @ObjectID AND
											DivisionID = @DivisionID AND
											CurrencyID = @CurrencyID

						DELETE AT9000 WHERE VoucherID = @SaveVoucherID  AND
											DebitAccountID = @AccountID AND
											ObjectID = @ObjectID AND
											DivisionID = @DivisionID AND
											CurrencyID = @CurrencyID AND
											TransactionTypeID = 'T99' AND
											IsAutoGen = 1						
					END

					-- Xóa phiếu chênh lệch tỷ giá
					IF @CustomerName = 13
					BEGIN
						DELETE AT9000 WHERE VoucherID = @SaveVoucherID  AND
										DebitAccountID = @AccountID AND
										TransactionTypeID = 'T10'
						DELETE AT0303 WHERE DebitVoucherID = @SaveVoucherID AND
											AccountID = @AccountID AND
											ObjectID = @ObjectID AND
											CurrencyID = @CurrencyID
					END

			FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID ,  @CorBatchID ,  @CorTableID, @OriginalAmount
		End

		Close @Cor_cur
		
		Delete AT0303 Where DebitVoucherID = @VoucherID  and
			DebitBatchID = @BatchID and
			DebitTableID = @TableID and
			AccountID =@AccountID and
			ObjectID = @ObjectID and
			DivisionID =@DivisionID and
			CurrencyID =@CurrencyID

				--- Cap nhat trang thai
		Update AT9000 Set Status = 0
				Where 	DivisionID = @DivisionID and
					VoucherID =@VoucherID and
					TableID = @TableID and 
					ObjectID = @ObjectID and
					BatchID =@BatchID and
					DebitAccountID =@AccountID and
					CurrencyIDCN = @CurrencyID

	
	End
	IF  @D_C ='C'   ----------------------------- Truong hop o ben Co bo giai tru cong no -------------------------------------------------------------------------------------------------
	Begin

	SET @Cor_cur = Cursor Scroll KeySet FOR 
		Select 	DebitVoucherID, DebitBatchID, DebitTableID,  Sum(OriginalAmount) AS OriginalAmount
		From AT0303 WITH (NOLOCK) Where 	CreditVoucherID = @VoucherID  and
					CreditBatchID = @BatchID and
					CreditTableID = @TableID and
					AccountID =@AccountID and
					ObjectID = @ObjectID and
					DivisionID =@DivisionID and
					CurrencyID =@CurrencyID
		Group by DebitVoucherID, DebitBatchID, DebitTableID  

		OPEN	@Cor_cur
		FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID,  @CorBatchID,  @CorTableID, @OriginalAmount
		WHILE @@Fetch_Status = 0
		Begin	
				-- Tìm phiếu CLTG
				IF @CustomerName IN (13)
				BEGIN
					SET @SaveVoucherID = (SELECT CreditVoucherID FROM AT0303 T03 WITH (NOLOCK)
									  LEFT JOIN AT9000 T90 WITH (NOLOCK) ON T90.VoucherID = T03.CreditVoucherID AND T90.BatchID = T03.CreditBatchID
									  WHERE T90.TransactionTypeID = 'T10'
									  AND T03.DebitVoucherID = @CorVoucherID 
									  AND T03.DebitBatchID = @CorBatchID
									  AND T03.DebitTableID = @CorTableID)
				END

				Set @GivedOriginalAmount =0
				Set @GivedOriginalAmount  = (Select Sum(isnull(OriginalAmount,0)) 
								From  AT0303 WITH (NOLOCK) Where 	DivisionID = @DivisionID and
											ObjectID = @ObjectID  and
											DebitVoucherID = @CorVoucherID and
											DebitBatchID = @CorBatchID and
											DebitTableID = @CorTableID and
											AccountID = @AccountID and
											CurrencyID =  @CurrencyID)			

				If @GivedOriginalAmount = @OriginalAmount	
				Update AT9000 Set Status = 0
				Where 	DivisionID = @DivisionID and
					VoucherID = @CorVoucherID and
					BatchID = @CorBatchID and
					TableID = @CorTableID and 
					ObjectID = @ObjectID and 
					DebitAccountID =@AccountID and
					CurrencyIDCN = @CurrencyID

				Delete AT9000 Where (VoucherID = @CorVoucherID or VoucherID = @VoucherID)  and
					(BatchID = @CorBatchID or BatchID = @BatchID) and
					(TableID = @CorTableID or TableID = @TableID) and
					(TransactionTypeID ='T10' OR (TransactionTypeID ='T99' AND IsAutoGen=1)) and
					ObjectID = @ObjectID and
					DivisionID = @DivisionID and
					CurrencyID = @CurrencyID
			--Print '@CorVoucherID   '+@CorVoucherID

					-- Xoa du lieu phieu chenh lech khong tham gia giai tru (luu vao phieu Thu)
				DELETE AT9000 
				WHERE	ReVoucherID = @CorVoucherID AND ReBatchID = @CorBatchID
						AND ReTableID = 'AT9000' AND (TransactionTypeID = 'T10' OR (TransactionTypeID = 'T99' AND IsAutoGen = 1))
						AND DivisionID = @DivisionID 
						AND CurrencyID = @CurrencyID


					---- Xoa phieu chenh lech but toan
					IF @CustomerName = 110
					BEGIN					
						SET @SaveVoucherID = (Select TOP 1 CreditVoucherID FROM AT0303 WHERE DebitVoucherID = @CorVoucherID AND (ConvertedAmount > 0 AND ConvertedAmount < 1000))
						DELETE AT0303 WHERE CreditVoucherID = @SaveVoucherID  AND											
											ObjectID = @ObjectID AND
											DivisionID = @DivisionID AND
											CurrencyID = @CurrencyID	
													
						DELETE AT9000 WHERE VoucherID =  @SaveVoucherID  AND
										CreditAccountID = @AccountID AND
										ObjectID = @ObjectID AND
										DivisionID = @DivisionID AND
										CurrencyID = @CurrencyID AND
										TransactionTypeID = 'T99' AND
										IsAutoGen = 1										
					END

					-- Xóa phiếu chênh lệch tỷ giá
					IF @CustomerName = 13
					BEGIN
						DELETE AT9000 WHERE VoucherID = @SaveVoucherID  AND
										CreditAccountID = @AccountID AND
										TransactionTypeID = 'T10'
						DELETE AT0303 WHERE CreditVoucherID = @SaveVoucherID AND
											AccountID = @AccountID AND
											ObjectID = @ObjectID AND
											CurrencyID = @CurrencyID
					END

			FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID ,  @CorBatchID ,  @CorTableID, @OriginalAmount
		End

		Close @Cor_cur


		Delete AT0303 Where 	CreditVoucherID = @VoucherID  and
					CreditBatchID = @BatchID and
					CreditTableID = @TableID and
					AccountID =@AccountID and
					ObjectID = @ObjectID and
					DivisionID =@DivisionID and
					CurrencyID =@CurrencyID
		--- Cap nhat trang thai
		Update AT9000 Set Status = 0
				Where 	DivisionID = @DivisionID and
					VoucherID =@VoucherID and
					BatchID =@BatchID and
					TableID = @TableID and 
					(Case When TransactionTypeID ='T99' then CreditObjectID else ObjectID end) = @ObjectID and 
					CreditAccountID =@AccountID and
					CurrencyIDCN = @CurrencyID
	
	End
end






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
