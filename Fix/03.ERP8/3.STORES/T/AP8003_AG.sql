IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8003_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8003_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Kiem tra truoc khi xuat kho Mat hang xuat dich danh
----- Created by Nguyen Van Nhan,Date 18/06/2003
---- Edit by B.Anh, date 01/06/2010	Sua loi canh bao sai khi dung DVT quy doi

/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/

CREATE PROCEDURE [dbo].[AP8003_AG] 	@UserID as nvarchar(50),					
					@DivisionID as nvarchar(50),
					@TranMonth as int,
					@TranYear as int, 
					@WareHouseID as nvarchar(50),
					@InventoryID  as nvarchar(50),
					@UnitID  as nvarchar(50), 
					@ConversionFactor as decimal(28,8),	
					@CreditAccountID as nvarchar(50),
					@ReOldVoucherID  as nvarchar(50), 
					@ReOldTransactionID  as nvarchar(50), 
					@ReNewVoucherID as nvarchar(50), 
					@ReNewTransactionID as nvarchar(50), 
					@OldQuantity  as decimal(28,8),
					@NewQuantity as decimal(28,8)
			

	
AS


Declare @EndQuantity as Decimal(28,8),
	@Status as tinyint ,
	@Message as nvarchar(250) 

	
	Delete AT8003
	
Set Nocount on 
If @ReOldVoucherID = @ReNewVoucherID and @ReOldTransactionID = @ReNewTransactionID
           Begin
	Insert AT8003 (DivisionID, ReVoucherID, ReTransactionID,  NewQuantity, OldQuantity )
	Values (@DivisionID, @ReNewVoucherID,  @ReNewTransactionID,  @NewQuantity, @OldQuantity  )	
	
	Set @EndQuantity =		 Isnull((Select sum(EndQuantity) From AT0114
					Where 	DivisionID =@DivisionID and
						WareHouseID =@WareHouseID and
							InventoryID = @InventoryID and
								ReVoucherID =@ReNewVoucherID and
											ReTransactionID =@ReNewTransactionID),0)
	End
Else
	Begin		--- Truong hop Edit chon lai phieu nhap khac voi phieu truoc do
		Insert AT8003 (DivisionID, ReVoucherID, ReTransactionID,  NewQuantity, OldQuantity )
		Values (@DivisionID, @ReNewVoucherID,  @ReNewTransactionID,  @NewQuantity, 0  )	
		Set @EndQuantity = 	 Isnull((Select sum(EndQuantity) From AT0114
						Where 	DivisionID =@DivisionID and
							WareHouseID =@WareHouseID and
							InventoryID = @InventoryID and
							ReVoucherID = @ReNewVoucherID and
							ReTransactionID =@ReNewTransactionID),0)			
	End

Select @NewQuantity = sum(NewQuantity) , 
	@EndQuantity  = @EndQuantity + sum(OldQuantity) 
From AT8003 Where ReVoucherID = @ReNewVoucherID and ReTransactionID   =@ReNewTransactionID and DivisionID =@DivisionID


If @NewQuantity > @EndQuantity
	Begin
		Set @Status =1
		Set @Message =N'WFML000138'
		Insert AT7777 (DivisionID, UserID, Status, Message, Value1, Value2, Value3)
		Values (@DivisionID, @UserID, @Status, @Message ,ltrim(str(@EndQuantity)), ltrim(str(@NewQuantity)), @InventoryID )
	End	
Else
	Begin
		Set @Status =0 
		Set @Message =''
		Insert AT7777 (DivisionID, UserID, Status, Message)
		Values (@DivisionID, @UserID, @Status, @Message)
	End

Set Nocount Off