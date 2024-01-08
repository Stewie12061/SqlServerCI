IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0404]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0404]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- 	Created by Nguyen Van Nhan, Date 15/11/2003
----- 	Purpose: Xoa but toan giai tru cong no phai tra
---- Modified on 11/10/2011 by Le Thi Thu Hien : Xoa but toan chenh lech No tu CreditObjectID -> ObjectID
---- Modified on 20/01/2016 by Phuong Thao: Bo sung xoa but toan chenh lech khong tham gia giai tru (theo cach sinh moi TT200)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Phương Thảo on 26/06/2016: Chỉnh sửa trường hợp giải  trừ do ứng trước (TT200) thì không xóa khi bỏ giải trừ
---- Modified by Phương Thảo on 26/06/2017: Fix lỗi Kết dữ liệu chênh lệch tỷ giá (giải trừ tự động khi làm phiếu chi)
/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [28/07/2010]
'********************************************/


CREATE PROCEDURE [dbo].[AP0404] 
		@DivisionID nvarchar(50), 
		@VoucherID nvarchar(50),
		@BatchID AS nvarchar(50),
		@TableID AS  nvarchar(50),
		@ObjectID nvarchar(50),
		@CurrencyID nvarchar(50),
		@AccountID nvarchar(50),
		@D_C AS nvarchar(1),  ---- 'D' neu la o phieu PS NO
							--- 'C' neu la phat sinh co
		@ExchangeRate AS Decimal(28,8) = 1

 AS

DECLARE @CorVoucherID AS nvarchar(50),
		@CorBatchID AS nvarchar(50),
		@CorTableID AS nvarchar(50),
		@OriginalAmount AS decimal (28,8),
		@GivedOriginalAmount AS decimal (28,8),
		@Cor_cur AS cursor


IF @D_C ='D'   ---- Truong hop o ben No bo giai tru ----------------------------------------------------------------
BEGIN
	SET @Cor_cur = Cursor Scroll KeySet FOR 
	SELECT 	CreditVoucherID, CreditBatchID, CreditTableID,  Sum(OriginalAmount)
	FROM	AT0404  WITH (NOLOCK)
	WHERE	DebitVoucherID = @VoucherID  AND
			DebitBatchID = @BatchID AND
			DebitTableID = @TableID AND
			AccountID =@AccountID AND
			ObjectID = @ObjectID AND
			DivisionID =@DivisionID AND
			CurrencyID =@CurrencyID
	GROUP BY CreditVoucherID, CreditBatchID, CreditTableID

	OPEN	@Cor_cur
	FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID,  @CorBatchID,  @CorTableID, @OriginalAmount
	WHILE @@Fetch_Status = 0
	BEGIN	
			SET @GivedOriginalAmount =0

			-- Lay ra so tien giai tru ben doi ung (Ben Co)
			SET @GivedOriginalAmount  = (	SELECT Sum(isnull(OriginalAmount,0)) 
											FROM  AT0404  WITH (NOLOCK)
			                             	WHERE 	DivisionID = @DivisionID AND
													ObjectID = @ObjectID  AND
													CreditVoucherID = @CorVoucherID AND
													CreditBatchID = @CorBatchID AND
													CreditTableID = @CorTableID AND
													AccountID = @AccountID AND
													CurrencyID =  @CurrencyID
										)	
			-- Neu giai tru het thi cap nhat Status cho phieu ben Co = 0
			IF @GivedOriginalAmount = @OriginalAmount	
			UPDATE	AT9000 
			SET		Status = 0
			WHERE 	DivisionID = @DivisionID AND
					VoucherID = @CorVoucherID AND
					BatchID = @CorBatchID AND
					TableID = @CorTableID AND 
					(Case When TransactionTypeID ='T99' then CreditObjectID else ObjectID end) = @ObjectID AND 
					CreditAccountID =@AccountID AND
					CurrencyIDCN = @CurrencyID
		
			-- Xoa phieu chenh lech lien quan (co tham gia giai tru)		
			DELETE	CL 
			FROM	AT9000 CL
			LEFT JOIN AT9000 T22 ON CL.VoucherID = T22.VoucherID AND CL.TransactionID = T22.TransactionID AND T22.TransactionTypeID <> 'T10'
			WHERE	(CL.VoucherID = @CorVoucherID)  AND
					(CL.BatchID = @CorBatchID) AND
					(CL.TableID = @CorTableID) AND
					CL.TransactionTypeID = 'T10' AND
					CL.ObjectID = @ObjectID AND
					CL.DivisionID = @DivisionID AND
					CL.CurrencyID = @CurrencyID AND
					EXISTS (SELECT TOP 1 1 
							FROM AT0404 							
							WHERE AT0404.CreditVoucherID = CL.VoucherID AND AT0404.CreditBatchID = CL.BatchID 
							AND AT0404.DebitTableID = CL.TableID AND CL.TransactionTypeID = 'T10')
					AND ( (ISNULL(CL.ReTransactionID,'') = '' AND Isnull(CL.ReVoucherID,'') = '')
							OR ( (ISNULL(CL.ReTransactionID,'') <> '' OR Isnull(CL.ReVoucherID,'') <> '')
						AND ISNULL(T22.TBatchID,'') <>'')
						)
			

			-- Xoa du lieu phieu chenh lech khong tham gia giai tru (Luu vao phieu Chi) : Sinh ra do lap phieu chi ke thua hoa don				
			DELETE T10 
			FROM	AT9000 T10
			INNER JOIN AT9000 T90 ON T10.ReVoucherID = T90.VoucherID AND T10.ReBatchID = T90.BatchID
			WHERE	T10.ReVoucherID = @VoucherID AND T10.ReBatchID = @BatchID
					AND T10.ReTableID = 'AT9000' AND T10.TransactionTypeID = 'T10'
					AND T10.DivisionID = @DivisionID 
					AND T10.CurrencyID = @CurrencyID
					AND ISNULL(T90.TBatchID,'') <> ''

		FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID ,  @CorBatchID ,  @CorTableID, @OriginalAmount
	End

	Close @Cor_cur



	-- Xoa du lieu bang giai tru
	DELETE	AT0404 
	WHERE 	DebitVoucherID = @VoucherID  AND
			DebitBatchID = @BatchID AND
			DebitTableID = @TableID AND
			AccountID =@AccountID AND
			ObjectID = @ObjectID AND
			DivisionID =@DivisionID AND
			CurrencyID =@CurrencyID

	
	
	--- Cap nhat trang thai	
	UPDATE	AT9000 
	SET		Status = 0
	WHERE 	DivisionID = @DivisionID AND
			VoucherID =@VoucherID AND
			TableID = @TableID AND 
			ObjectID = @ObjectID AND
			BatchID =@BatchID AND
			DebitAccountID =@AccountID AND
			CurrencyIDCN = @CurrencyID
	

	
	
END
IF  @D_C ='C'   ----------------------------- Truong hop o ben Co bo giai tru cong no -------------------------------------------------------------------------------------------------
BEGIN

SET @Cor_cur = Cursor Scroll KeySet FOR 
	SELECT 	DebitVoucherID, DebitBatchID, DebitTableID,  Sum(OriginalAmount)
	FROM	AT0404  WITH (NOLOCK)
	WHERE 	CreditVoucherID = @VoucherID  AND
			CreditBatchID = @BatchID AND
			CreditTableID = @TableID AND
			AccountID =@AccountID AND
			ObjectID = @ObjectID AND
			DivisionID =@DivisionID AND
			CurrencyID =@CurrencyID

	GROUP BY DebitVoucherID, DebitBatchID, DebitTableID  

	OPEN	@Cor_cur
	FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID,  @CorBatchID,  @CorTableID, @OriginalAmount
	WHILE @@Fetch_Status = 0
	BEGIN	
			SET @GivedOriginalAmount =0
			SET @GivedOriginalAmount  = (	SELECT	SUM(ISNULL(OriginalAmount,0)) 
											FROM	AT0404 WITH (NOLOCK) 
			                             	WHERE 	DivisionID = @DivisionID AND
													ObjectID = @ObjectID  AND
													DebitVoucherID = @CorVoucherID AND
													DebitBatchID = @CorBatchID AND
													DebitTableID = @CorTableID AND
													AccountID = @AccountID AND
													CurrencyID =  @CurrencyID)			

			IF @GivedOriginalAmount = @OriginalAmount	
			UPDATE	AT9000 
			SET		Status = 0
			WHERE 	DivisionID = @DivisionID AND
					VoucherID = @CorVoucherID AND
					BatchID = @CorBatchID AND
					TableID = @CorTableID AND 
					ObjectID = @ObjectID AND 
					DebitAccountID =@AccountID AND
					CurrencyIDCN = @CurrencyID

			--select  @CorVoucherID,  @CorBatchID,  @CorTableID, @ObjectID, @DivisionID, @CurrencyID

			-- Xoa phieu chenh lech lien quan (co tham gia giai tru)				

			DELETE	CL 
			FROM	AT9000 CL
			LEFT JOIN AT9000 T22 ON CL.VoucherID = T22.VoucherID AND CL.TransactionID = T22.TransactionID AND T22.TransactionTypeID <> 'T10'
			WHERE	(CL.VoucherID = @CorVoucherID)  AND
					(CL.BatchID = @CorBatchID) AND
					(CL.TableID = @CorTableID) AND
					CL.TransactionTypeID = 'T10' AND
					CL.ObjectID = @ObjectID AND
					CL.DivisionID = @DivisionID AND
					CL.CurrencyID = @CurrencyID AND
					EXISTS (SELECT TOP 1 1 
							FROM AT0404 							
							WHERE AT0404.DebitVoucherID = CL.VoucherID AND AT0404.DebitBatchID = CL.BatchID 
							AND AT0404.DebitTableID = CL.TableID AND CL.TransactionTypeID = 'T10')
					AND ( (ISNULL(CL.ReTransactionID,'') = '' AND Isnull(CL.ReVoucherID,'') = '')
							OR ( (ISNULL(CL.ReTransactionID,'') <> '' OR Isnull(CL.ReVoucherID,'') <> '')
						AND ISNULL(T22.TBatchID,'') <>'')
						)
				
					

			-- Xoa du lieu phieu chenh lech khong tham gia giai tru (Luu vao phieu Chi) : Sinh ra do lap phieu chi ke thua hoa don	

			DELETE T10 
			FROM	AT9000 T10
			INNER JOIN AT9000 T90 ON  T10.ReVoucherID = T90.VoucherID AND T10.ReBatchID = T90.BatchID			
			WHERE	T10.ReVoucherID = @CorVoucherID AND T10.ReBatchID = @CorBatchID
					AND T10.ReTableID = 'AT9000' 
					AND T10.TransactionTypeID = 'T10'
					AND T10.DivisionID = @DivisionID 
					AND T10.CurrencyID = @CurrencyID
					AND ISNULL(T90.TBatchID,'') <> ''
		FETCH NEXT FROM @Cor_cur INTO  @CorVoucherID ,  @CorBatchID ,  @CorTableID, @OriginalAmount
	End

	Close @Cor_cur

	

	DELETE	AT0404
	WHERE 	CreditVoucherID = @VoucherID  AND
			CreditBatchID = @BatchID AND
			CreditTableID = @TableID AND
			AccountID =@AccountID AND
			ObjectID = @ObjectID AND
			DivisionID =@DivisionID AND
			CurrencyID =@CurrencyID

	--- Cap nhat trang thai
	UPDATE	AT9000 
	SET		Status = 0
	WHERE 	DivisionID = @DivisionID AND
			VoucherID =@VoucherID AND
			BatchID =@BatchID AND
			TableID = @TableID AND 
			(Case When TransactionTypeID ='T99' then CreditObjectID else ObjectID end) = @ObjectID AND 
			CreditAccountID =@AccountID AND
			CurrencyIDCN = @CurrencyID


End

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

