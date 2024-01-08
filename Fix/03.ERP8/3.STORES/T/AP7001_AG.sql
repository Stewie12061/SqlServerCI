IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7001_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7001_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- Created by Nguyen Van Nhan, Date 13/06/2003
---- Purpose:  Kiem tra co duoc phep xuat kho hay khong.
---- Duoc goi khi AddNew va Edit phieu xuat kho
---- Edit by B.Anh, date 01/06/2010	Sua loi canh bao sai khi dung DVT quy doi (truoc day lay @NewQuantity * @ConversionFactor so sanh voi @EndQuantity_ToNow)
---- Edit by B.Anh, date 11/06/2014	Chỉ lấy lượng tồn tính đến ngày @VoucherDate
---- Modified by Tiểu Mai on 22/02/2016: Bổ sung kiểm tra hàng theo quy cách
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH (NOLOCK)
---- Edit by B.Anh, date 07/03/2017	Lấy lượng tồn tính đến thời điểm hiện tại chứ không lấy đến ngày @VoucherDate
---- Edit by B.Anh, date 07/04/2017	Kiểm tra tồn 2 trường hợp: tính đến hiện tại và tính đến ngày xuất kho
---- Edit by B.Anh, date 19/04/2017	Kiểm tra tồn kho theo vị trí (Chí Thành)
---- Modified by Bảo Thy on 25/07/2017: Bổ sung @ScreenID
---- Edit by B.Anh, date 03/01/2018	Kiểm tra tồn kho an toàn
---- Modified by Kim Thư on 17/9/2018: Đưa tất cả mặt hàng cần kiểm tra vào biến XML (cải thiện tốc độ check tồn kho)
---- Modified by Kim Thư on 23/10/2018: Điều chỉnh insert bảng WT8003 check xuất đích danh
---- Modified by Kim Thư on 25/10/2018: Thay đổi load view AV7000 cải thiện tốc độ
---- Modified by Kim Thư on 20/11/2018: Sửa lỗi  COLLATE SQL_Latin1_General_CP1_CI_AS
---- Modified by Kim Thư on 07/12/2018: Bổ sung ưu tiên báo lỗi tính đến thời điểm hiện tại trước, nếu hiện tại đủ số lượng thì thông báo đến thời điểm voucherdate.
----									Bổ sung cột IsNegativeStock vào bảng báo lỗi -> phân biệt loại message
---- Modified by Kim Thư on 15/03/2019: sửa isnull tính tồn kho
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

/********************************************
'* Edited by: [GS] [Thanh Nguyen] [01/08/2010]
'********************************************/
CREATE PROCEDURE [dbo].[AP7001_AG] 	
		@UserID as nvarchar(50),					
					@DivisionID as nvarchar(50),
					@TranMonth as int,
					@TranYear as int,
					@WareHouseID as nvarchar(50),
					@InventoryID as  nvarchar(50),
					@UnitID as nvarchar(50),
					@ConversionFactor as Decimal(28,8),					
					@IsSource 	tinyint,
					@IsLimitDate	tinyint,
					@CreditAccountID as nvarchar(50),
					@ReOldVoucherID as nvarchar(50),
					@ReOldTransactionID as  nvarchar(50),
					@ReNewVoucherID nvarchar(50),
					@ReNewTransactionID as nvarchar(50),
					@VoucherDate as datetime,
					@OldQuantity	Decimal(28,8),
					@NewQuantity	Decimal(28,8),
					@AllowOverShip as tinyint,
					@MethodID as 	TINYINT,
					@S01ID AS NVARCHAR(50),
					@S02ID AS NVARCHAR(50),
					@S03ID AS NVARCHAR(50),
					@S04ID AS NVARCHAR(50),
					@S05ID AS NVARCHAR(50),
					@S06ID AS NVARCHAR(50),
					@S07ID AS NVARCHAR(50),
					@S08ID AS NVARCHAR(50),
					@S09ID AS NVARCHAR(50),
					@S10ID AS NVARCHAR(50),
					@S11ID AS NVARCHAR(50),
					@S12ID AS NVARCHAR(50),
					@S13ID AS NVARCHAR(50),
					@S14ID AS NVARCHAR(50),
					@S15ID AS NVARCHAR(50),
					@S16ID AS NVARCHAR(50),
					@S17ID AS NVARCHAR(50),
					@S18ID AS NVARCHAR(50),
					@S19ID AS NVARCHAR(50),
					@S20ID AS NVARCHAR(50)
								
 AS

Declare @EndQuantity as Decimal(28,8),
	@Message as nvarchar(250),
	@Status as tinyint,
	@IsNegativeStock as tinyint


Select  @IsNegativeStock = IsNegativeStock From WT0000 WITH (NOLOCK)  Where DefDivisionID =@DivisionID  --- Cho phep xuat kho am hay khong

Set @IsNegativeStock = isnull(@IsNegativeStock,0)

Set Nocount on
Delete AT7777 Where UserID =@UserID AND DivisionID = @DivisionID

If  @IsSource<>0 or @IsLimitDate<>0 or @MethodID = 3
	--- Xuat dich danh, theo Lo - ngay het han

		Exec AP8003 @UserID,  @DivisionID,@TranMonth,@TranYear, @WareHouseID,@InventoryID,
					@UnitID, @ConversionFactor,	@CreditAccountID,
					@ReOldVoucherID, @ReOldTransactionID, 
					@ReNewVoucherID, @ReNewTransactionID,
					@OldQuantity, @NewQuantity

Else

	Begin
	/*
		Set @EndQuantity =@OldQuantity + Isnull( (Select EndQuantity From AT2008 Where DivisionID =@DivisionID and
										TranMOnth =@TranMonth and
										TranYear =@TranYear and
										InventoryID =@InventoryID and 
										InventoryAccountID = @CreditAccountID and
										WareHouseID =@WareHouseID), 0)
	*/
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		Set @EndQuantity =@OldQuantity + Isnull((Select SUM(SignQuantity) From AV7002 Where DivisionID = @DivisionID											
											AND InventoryID =@InventoryID 
											AND InventoryAccountID = @CreditAccountID
											AND WareHouseID =@WareHouseID
											AND VoucherDate <= @VoucherDate
											AND ISNULL(S01ID,'') = ISNULL(@S01ID,'')
											AND ISNULL(S02ID,'') = ISNULL(@S02ID,'')
											AND ISNULL(S03ID,'') = ISNULL(@S03ID,'')
											AND ISNULL(S04ID,'') = ISNULL(@S04ID,'')
											AND ISNULL(S05ID,'') = ISNULL(@S05ID,'')
											AND ISNULL(S06ID,'') = ISNULL(@S06ID,'')
											AND ISNULL(S07ID,'') = ISNULL(@S07ID,'')
											AND ISNULL(S08ID,'') = ISNULL(@S08ID,'')
											AND ISNULL(S09ID,'') = ISNULL(@S09ID,'')
											AND ISNULL(S10ID,'') = ISNULL(@S10ID,'')
											AND ISNULL(S11ID,'') = ISNULL(@S11ID,'')
											AND ISNULL(S12ID,'') = ISNULL(@S12ID,'')
											AND ISNULL(S13ID,'') = ISNULL(@S13ID,'')
											AND ISNULL(S14ID,'') = ISNULL(@S14ID,'')
											AND ISNULL(S15ID,'') = ISNULL(@S15ID,'')
											AND ISNULL(S16ID,'') = ISNULL(@S16ID,'')
											AND ISNULL(S17ID,'') = ISNULL(@S17ID,'')
											AND ISNULL(S18ID,'') = ISNULL(@S18ID,'')
											AND ISNULL(S19ID,'') = ISNULL(@S19ID,'')
											AND ISNULL(S20ID,'') = ISNULL(@S20ID,'')),0)
	ELSE 
		--Set @EndQuantity =@OldQuantity + Isnull((Select SUM(SignQuantity) From AV7000 Where DivisionID = @DivisionID											
		--									and InventoryID =@InventoryID 
		--									and InventoryAccountID = @CreditAccountID
		--									and WareHouseID =@WareHouseID
		--									and VoucherDate <= @VoucherDate),0)
		Set @EndQuantity =@OldQuantity + Isnull( (Select top 1 EndQuantity From AT2008 Where DivisionID =@DivisionID and										
													InventoryID =@InventoryID and 
													InventoryAccountID = @CreditAccountID and
													WareHouseID =@WareHouseID
													Order by TranMonth + TranYear*12 DESC), 0)
														
	If @NewQuantity > @EndQuantity and  @IsNegativeStock=0 
		Begin
			Set @Status =1
			Set @Message =N'WFML000132'
            Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2)
			Values (@UserID, @Status, @Message, @DivisionID,@InventoryID,@WareHouseID )
		End
	else If @NewQuantity > @EndQuantity and  @IsNegativeStock=1
		Begin
			Set @Status =2
			Set @Message =N'WFML000133'
            Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2)
			Values (@UserID, @Status, @Message, @DivisionID,@InventoryID,@WareHouseID )
		End		
	Else
		Begin
			Set @Status =0 
			Set @Message =''
            Insert AT7777 (UserID, Status, Message, DivisionID)
			Values (@UserID, @Status, @Message, @DivisionID)
		End
	
		

	End			

Set Nocount off
Select * from AT7777 Where UserID =@UserID  and DivisionID =@DivisionID




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO