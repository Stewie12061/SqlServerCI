IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP7001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)     
DROP PROCEDURE [DBO].[BP7001]  
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO  
 
--- Created by B.Anh	Date: 08/12/2010
--- Purpose: Canh bao khi xuat seri
----Modify by: Lê Thanh Lượng, Date: 19/10/2023: Bổ sung N'' tránh lỗi buộc nhập params không cần thiết.
CREATE PROCEDURE BP7001		@DivisionID as varchar(50),
					@VoucherDate as datetime,
					@InventoryID as varchar(50) =N'',
					@SeriNo as varchar(50),
					@WareHouseID as varchar(50) =N''
AS	

Declare @EndQuantity as int,
	@Status as tinyint,
	@Message as varchar(250),
	@IsNegativeStock as tinyint

	Set @Status =0
	Set @Message =''

	Select TOP 1 @IsNegativeStock = IsNegativeStock From WT0000 WITH (NOLOCK) Where DefDivisionID = @DivisionID --- Cho phep xuat kho am hay khong
	Set @IsNegativeStock = isnull(@IsNegativeStock,0)

	Select @EndQuantity = SUM(SignQuantity) from BV7000 Where DivisionID = @DivisionID And SeriNo = @SeriNo and CONVERT(VARCHAR(20),VoucherDate,101) <= CONVERT(VARCHAR(20),@VoucherDate,101)

	IF Isnull(@EndQuantity,0) = 0 and @IsNegativeStock=0
	Begin
		Set @Status =1
		Set @Message ='WFML000248'
		Goto EndMess
	End

	ELSE IF Isnull(@EndQuantity,0) = 0 and @IsNegativeStock <> 0
	Begin
		Set @Status =2
		Set @Message ='WFML000249'
		Goto EndMess
	End

EndMess:
	Select @Status as Status, @Message as Message
  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
