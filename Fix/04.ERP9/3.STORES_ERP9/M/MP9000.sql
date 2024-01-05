IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-----
----- Created by: Phan thanh Hoàng Vũ, date: 13/02/2015
----- Purpose: Kiem tra rang buoc du lieu cho phep Sua, Xoa
----- Modified by Tiểu Mai on 02/03/2016: Bổ sung kiểm tra cho Kết quả sản xuất (CustomizeIndex = 57 - ANGEL)
----- Modify on 15/03/2016 by Bảo Anh: Kiểm tra khi xóa kế hoạch dự tính sản xuất (Angel)
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
----- Exec MP9000 'AS', 3, 2014, '5cc3ac96-d147-4142-b7de-04952d4e65b9','MT2007', 1

CREATE PROCEDURE [dbo].[MP9000] 	@DivisionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@VoucherID nvarchar(50),
				@TableName  nvarchar(50),
				@IsEdit tinyint   ----  =0  la Xoa,  = 1 la Sua

AS

Declare @Status as tinyint, --- 1: Khong cho xoa, sua:    2--- co canh bao nhung  cho xoa cho sua; --3: Cho sua mot phan thoi
		@EngMessage as nvarchar(250),
		@VieMessage as nvarchar(250),
		@NumberSuggest INT,
		@ApportionID NVARCHAR(50)

Select @Status =0, 	@EngMessage ='',	 @VieMessage=''

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

If @TableName =  'MT2007'  and @IsEdit = 1
BEGIN
			IF @CustomerName = 43 --SECOIN
			BEGIN
	
					If exists (	Select top 1 1 
								From MT0810 M WITH (NOLOCK) inner join MT1001 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
								Where InheritVoucherID = @VoucherID
							  )
					Begin
							Set @Status =3
							Set @VieMessage ='MFML000274'
							Set @EngMessage =''
							Goto EndMess
					End 
					If exists (	Select top 1 1 
								From AT2006 M WITH (NOLOCK) inner join AT2007 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
								Where InheritVoucherID = @VoucherID
							  )
					Begin
							Set @Status =3
							Set @VieMessage ='MFML000273'
							Set @EngMessage =''
							Goto EndMess
					End
				
		
			END -----IF @CustomerName = 43 --SECOIN
			
END

If @TableName =  'MT2007'  and @IsEdit = 0
BEGIN
			IF @CustomerName = 43 --SECOIN
			BEGIN
					If exists (	Select top 1 1 
								From MT0810 M WITH (NOLOCK) inner join MT1001 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
								Where InheritVoucherID = @VoucherID
							  )
					Begin
							Set @Status =1
							Set @VieMessage ='MFML000280'
							Set @EngMessage =''
							Goto EndMess
					End 
			END -----IF @CustomerName = 43 --SECOIN
			
END

If @TableName =  'MT0810'  and @IsEdit = 0
BEGIN
			IF @CustomerName = 57 --- ANGEL
			BEGIN
					If exists (	Select top 1 1 
								From MT0810 WITH (NOLOCK)
								LEFT JOIN AT2006 WITH (NOLOCK) on MT0810.DivisionID = AT2006.DivisionID and MT0810.VoucherID = AT2006.VoucherID
								Where AT2006.DivisionID = @DivisionID
									AND MT0810.VoucherID = @VoucherID
									AND AT2006.IsProduct = 1
									AND MT0810.TableID = 'AT2006'
							  )
					Begin
							Set @Status =1
							Set @VieMessage ='MFML000285'
							Set @EngMessage =''
							Goto EndMess
					End 
			END -----IF @CustomerName = 57 - ANGEL
			
END

If @TableName =  'MT0810'  and @IsEdit = 1
BEGIN
			IF @CustomerName = 57 --- ANGEL
			BEGIN
					If exists (	Select top 1 1 
								From MT0810 WITH (NOLOCK)
								LEFT JOIN AT2006 WITH (NOLOCK) on MT0810.DivisionID = AT2006.DivisionID and MT0810.VoucherID = AT2006.VoucherID
								Where AT2006.DivisionID = @DivisionID
									AND MT0810.VoucherID = @VoucherID
									AND AT2006.IsProduct = 1
									AND MT0810.TableID = 'AT2006'
							  )
					Begin
							Set @Status =1
							Set @VieMessage ='MFML000285'
							Set @EngMessage =''
							Goto EndMess
					End 
			END -----IF @CustomerName = 57 - ANGEL
			
END

If @TableName = 'MT0169'
BEGIN
	If exists (Select top 1 1 From MT0170  WITH (NOLOCK)
				Inner join WT0096 WITH (NOLOCK) On WT0096.DivisionID = MT0170.DivisionID And WT0096.InheritTableID = 'MT0170' And WT0096.InheritTransactionID = MT0170.TransactionID
				Where MT0170.DivisionID = @DivisionID and MT0170.VoucherID = @VoucherID)
	Begin
		Select @Status = 1, 
		@VieMessage = 'MFML000288',
		@EngMessage = 'This voucher is inheritted to make export request. You can not edit or delete it'	
	End
END

IF @TableName = 'MT0176' ---- Kiểm tra bỏ duyệt Đề nghị định mức của An Phát
BEGIN
	SET @ApportionID = (SELECT DISTINCT InheritApportionID FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID )
	SET @NumberSuggest = (SELECT MAX(NumberSuggest) FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND InheritApportionID = @ApportionID)
	IF EXISTS (SELECT TOP 1 1 FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND NumberSuggest < @NumberSuggest)
	BEGIN
		SET @Status = 1
		SET @VieMessage = 'MFML000295'
		SET @EngMessage = ''
	END
END

EndMess:
	Select @Status as Status, @EngMessage as EngMessage, @VieMessage as VieMessage




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
