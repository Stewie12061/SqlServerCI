IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Minh Thuy and Van Nhan.
---- Created Date 26/06/2006
--- Purpose: Lam tron phan tinhgia xuat kho FIFO
---- Edit by Nguyen Quoc Huy, Date 30/10/2006
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 20/04/2017: Bổ sung 20 quy cách (TUNGTEX)
---- Modified by Bảo Thy on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 12/06/2020: Làm tròn Phiếu xuất của phiếu nhập (VCNB)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- <Example> EXEC AP1301 'HT',11,2016
/********************************************
'* Edited by: [GS] [Thanh Nguyen] [29/07/2010]
'********************************************/

CREATE PROCEDURE [dbo].[AP1301] @DivisionID as nvarchar(50), @TranMonth as int , @TranYear int
 AS

Declare @DeltaAmount as decimal(28,8),
	 @ReTransactionID as nvarchar(50),
	@InventoryID as  nvarchar(50),
	@TransactionID nvarchar(50),
	@TransactionID1 nvarchar(50),
	@Delta_cur as cursor,
	@S01ID VARCHAR(50),
	@S02ID VARCHAR(50),
    @S03ID VARCHAR(50),
    @S04ID VARCHAR(50),
    @S05ID VARCHAR(50),
    @S06ID VARCHAR(50),
    @S07ID VARCHAR(50),
    @S08ID VARCHAR(50),
    @S09ID VARCHAR(50),
    @S10ID VARCHAR(50),
    @S11ID VARCHAR(50),
    @S12ID VARCHAR(50),
    @S13ID VARCHAR(50),
    @S14ID VARCHAR(50),
    @S15ID VARCHAR(50),
    @S16ID VARCHAR(50),
    @S17ID VARCHAR(50),
    @S18ID VARCHAR(50),
    @S19ID VARCHAR(50),
    @S20ID VARCHAR(50)

SET @Delta_cur = Cursor Scroll KeySet FOR 
	
Select 	AT0114.ReTransactionID, AT0114.InventoryID, AT2007.ConvertedAmount- sum(AT0115.convertedAmount) as DeltaAmount, ISNULL(AT0114.S01ID,'') AS S01ID, 
ISNULL(AT0114.S02ID,'') AS S02ID, ISNULL(AT0114.S03ID,'') AS S03ID, ISNULL(AT0114.S04ID,'') AS S04ID, ISNULL(AT0114.S05ID,'') AS S05ID, ISNULL(AT0114.S06ID,'') AS S06ID, 
ISNULL(AT0114.S07ID,'') AS S07ID, ISNULL(AT0114.S08ID,'') AS S08ID, ISNULL(AT0114.S09ID,'') AS S09ID, ISNULL(AT0114.S10ID,'') AS S10ID, ISNULL(AT0114.S11ID,'') AS S11ID, 
ISNULL(AT0114.S12ID,'') AS S12ID, ISNULL(AT0114.S13ID,'') AS S13ID, ISNULL(AT0114.S14ID,'') AS S14ID, ISNULL(AT0114.S15ID,'') AS S15ID, ISNULL(AT0114.S16ID,'') AS S16ID, 
ISNULL(AT0114.S17ID,'') AS S17ID, ISNULL(AT0114.S18ID,'') AS S18ID, ISNULL(AT0114.S19ID,'') AS S19ID, ISNULL(AT0114.S20ID,'') AS S20ID

From AT0114  WITH (NOLOCK)	inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT0114.DivisionID,'@@@') AND AT1302.InventoryID = AT0114.InventoryID
		inner join (Select TransactionID, ConvertedAmount, DivisionID From AT2007 WITH (NOLOCK)
				Union All
				Select TransactionID, ConvertedAmount, DivisionID From AT2017 WITH (NOLOCK)
			) AT2007 on AT2007.TransactionID =AT0114.reTransactionID and AT2007.DivisionID =AT0114.DivisionID
		right join AT0115 WITH (NOLOCK) on AT0115.reTransactionID = AT0114.reTransactionID and AT0115.DivisionID = AT0114.DivisionID
Where MethodID =1 and EndQuantity =0 and AT0114.DivisionID = @DivisionID
group by AT0114.ReTransactionID, AT0114.InventoryID, AT0114.ReVoucherNo,ReQuantity, AT0114.UnitPrice,
	AT2007.ConvertedAmount, ISNULL(AT0114.S01ID,''), 
ISNULL(AT0114.S02ID,''), ISNULL(AT0114.S03ID,''), ISNULL(AT0114.S04ID,''), ISNULL(AT0114.S05ID,''), ISNULL(AT0114.S06ID,''), 
ISNULL(AT0114.S07ID,''), ISNULL(AT0114.S08ID,''), ISNULL(AT0114.S09ID,''), ISNULL(AT0114.S10ID,''), ISNULL(AT0114.S11ID,''), 
ISNULL(AT0114.S12ID,''), ISNULL(AT0114.S13ID,''), ISNULL(AT0114.S14ID,''), ISNULL(AT0114.S15ID,''), ISNULL(AT0114.S16ID,''), 
ISNULL(AT0114.S17ID,''), ISNULL(AT0114.S18ID,''), ISNULL(AT0114.S19ID,''), ISNULL(AT0114.S20ID,'')
having AT2007.ConvertedAmount- sum(AT0115.convertedAmount)<>0

OPEN	@Delta_cur
FETCH NEXT FROM @Delta_cur INTO  @ReTransactionID, @InventoryID, @DeltaAmount, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
WHILE @@Fetch_Status = 0
Begin
----Print ' INV: '+@InventoryID+' can lam tron: '+str(@DeltaAmount,20,4)
/*
	If  @InventoryID = 'VLNU0006'
	Begin
	print '@ReTransactionID' + @ReTransactionID
	print '@DeltaAmount' + str(@DeltaAmount)
	End
*/
--- Lấy Transaction của phiếu xuất
	Set @TransactionID = null
	Set @TransactionID = (Select top 1 TransactionID From AT0115 WITH (NOLOCK)
							Where ReTransactionID = @ReTransactionID and InventoryID =@InventoryID and
								TranMonth + 100*TranYear >= @TranMonth +100*@TranYear and DivisionID = @DivisionID
								AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
								AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
								AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
								AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
								AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
								AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
								AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
								AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
								AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
								AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
								AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
								AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
								AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
								AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
								AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
								AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
								AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
								AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
								AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
								AND ISNULL(S20ID,'') = isnull(@S20ID,'')
				Order by TranYear*100+ TranMonth DESC,  VoucherDate Desc , TransactionID  Desc)

	If @TransactionID is not null
		BEGIN
			-- Câu Select để test
			--SELECT AT2006.WareHouseID2,AT2006.WareHouseID,AT2007.TransactionID,* FROM AT2007
			--	LEFT JOIN AT2006 ON AT2006.VoucherID = AT2007.VoucherID
			--	LEFT JOIN WT8899 ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID
			--	Where AT2007.InventoryID =@InventoryID and 
			--		AT2007.TransactionID = @TransactionID 
			--		AND AT2007.DivisionID = @DivisionID
			--		AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
			--		AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
			--		AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
			--		AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
			--		AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
			--		AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
			--		AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
			--		AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
			--		AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
			--		AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
			--		AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
			--		AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
			--		AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
			--		AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
			--		AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
			--		AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
			--		AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
			--		AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
			--		AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
			--		AND ISNULL(S20ID,'') = isnull(@S20ID,'')
					
			--- cập nhật làm tròn phiếu xuất
			--- Update AT2007
				update AT2007 
				set 	ConvertedAmount = ConvertedAmount +isnull(@DeltaAmount,0),
						OriginalAmount =ConvertedAmount+isnull(@DeltaAmount,0),
						UnitPrice = (Case when ActualQuantity <>0 then (ConvertedAmount+isnull(@DeltaAmount,0))/ActualQuantity else UnitPrice End)
				FROM AT2007
				LEFT JOIN WT8899 ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID
				Where AT2007.InventoryID =@InventoryID and 
					AT2007.TransactionID = @TransactionID and 
					AT2007.DivisionID = @DivisionID
					AND ISNULL(WT8899.S01ID,'') = Isnull(@S01ID,'')  
					AND ISNULL(WT8899.S02ID,'') = isnull(@S02ID,'') 
					AND ISNULL(WT8899.S03ID,'') = isnull(@S03ID,'') 
					AND ISNULL(WT8899.S04ID,'') = isnull(@S04ID,'') 
					AND ISNULL(WT8899.S05ID,'') = isnull(@S05ID,'')  
					AND ISNULL(WT8899.S06ID,'') = isnull(@S06ID,'') 
					AND ISNULL(WT8899.S07ID,'') = isnull(@S07ID,'') 
					AND ISNULL(WT8899.S08ID,'') = isnull(@S08ID,'') 
					AND ISNULL(WT8899.S09ID,'') = isnull(@S09ID,'') 
					AND ISNULL(WT8899.S10ID,'') = isnull(@S10ID,'') 
					AND ISNULL(WT8899.S11ID,'') = isnull(@S11ID,'')  
					AND ISNULL(WT8899.S12ID,'') = isnull(@S12ID,'') 
					AND ISNULL(WT8899.S13ID,'') = isnull(@S13ID,'') 
					AND ISNULL(WT8899.S14ID,'') = isnull(@S14ID,'') 
					AND ISNULL(WT8899.S15ID,'') = isnull(@S15ID,'') 
					AND ISNULL(WT8899.S16ID,'') = isnull(@S16ID,'') 
					AND ISNULL(WT8899.S17ID,'') = isnull(@S17ID,'') 
					AND ISNULL(WT8899.S18ID,'') = isnull(@S18ID,'') 
					AND ISNULL(WT8899.S19ID,'') = isnull(@S19ID,'') 
					AND ISNULL(WT8899.S20ID,'') = isnull(@S20ID,'')
					-- Cập nhật làm tròn phiếu xuất
			--- Update At0115
				update AT0115 	set  	ConvertedAmount = ConvertedAmount +isnull(@DeltaAmount,0)							
				Where InventoryID =@InventoryID and 
					TransactionID = @TransactionID and 
					ReTransactionID = @ReTransactionID and 
					DivisionID = @DivisionID
					AND ISNULL(S01ID,'') = Isnull(@S01ID,'')
					AND ISNULL(S02ID,'') = isnull(@S02ID,'')
					AND ISNULL(S03ID,'') = isnull(@S03ID,'')
					AND ISNULL(S04ID,'') = isnull(@S04ID,'')
					AND ISNULL(S05ID,'') = isnull(@S05ID,'')
					AND ISNULL(S06ID,'') = isnull(@S06ID,'')
					AND ISNULL(S07ID,'') = isnull(@S07ID,'')
					AND ISNULL(S08ID,'') = isnull(@S08ID,'')
					AND ISNULL(S09ID,'') = isnull(@S09ID,'')
					AND ISNULL(S10ID,'') = isnull(@S10ID,'')
					AND ISNULL(S11ID,'') = isnull(@S11ID,'')
					AND ISNULL(S12ID,'') = isnull(@S12ID,'')
					AND ISNULL(S13ID,'') = isnull(@S13ID,'')
					AND ISNULL(S14ID,'') = isnull(@S14ID,'')
					AND ISNULL(S15ID,'') = isnull(@S15ID,'')
					AND ISNULL(S16ID,'') = isnull(@S16ID,'')
					AND ISNULL(S17ID,'') = isnull(@S17ID,'')
					AND ISNULL(S18ID,'') = isnull(@S18ID,'')
					AND ISNULL(S19ID,'') = isnull(@S19ID,'')
					AND ISNULL(S20ID,'') = isnull(@S20ID,'')	

					-- Lấy transaction phiếu xuất của phiếu nhập(VCNB)
				Set @TransactionID1 = (Select top 1 TransactionID From AT0115 WITH (NOLOCK)
							Where ReTransactionID = @TransactionID and InventoryID =@InventoryID and
								AT0115.TranMonth + 100*AT0115.TranYear >= @TranMonth +100*@TranYear and AT0115.DivisionID = @DivisionID
								AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
								AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
								AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
								AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
								AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
								AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
								AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
								AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
								AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
								AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
								AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
								AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
								AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
								AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
								AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
								AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
								AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
								AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
								AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
								AND ISNULL(S20ID,'') = isnull(@S20ID,'')
				Order by ConvertedAmount DESC,AT0115.TranYear*100+ AT0115.TranMonth DESC,  AT0115.VoucherDate Desc , TransactionID  Desc)

					--- cập nhật làm tròn phiếu xuất của phiếu nhập (VCNB)
				update AT2007 
				set 	ConvertedAmount = ConvertedAmount +isnull(@DeltaAmount,0),
						OriginalAmount =ConvertedAmount+isnull(@DeltaAmount,0),
						UnitPrice = (Case when ActualQuantity <>0 then (ConvertedAmount+isnull(@DeltaAmount,0))/ActualQuantity else UnitPrice End)
				FROM AT2007
				LEFT JOIN AT2006 ON AT2006.VoucherID = AT2007.VoucherID
				LEFT JOIN WT8899 ON AT2007.DivisionID = WT8899.DivisionID AND AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID
				Where AT2007.InventoryID =@InventoryID and 
					AT2007.TransactionID = @TransactionID1
					AND AT2007.DivisionID = @DivisionID
					AND ISNULL(WT8899.S01ID,'') = Isnull(@S01ID,'')  
					AND ISNULL(WT8899.S02ID,'') = isnull(@S02ID,'') 
					AND ISNULL(WT8899.S03ID,'') = isnull(@S03ID,'') 
					AND ISNULL(WT8899.S04ID,'') = isnull(@S04ID,'') 
					AND ISNULL(WT8899.S05ID,'') = isnull(@S05ID,'')  
					AND ISNULL(WT8899.S06ID,'') = isnull(@S06ID,'') 
					AND ISNULL(WT8899.S07ID,'') = isnull(@S07ID,'') 
					AND ISNULL(WT8899.S08ID,'') = isnull(@S08ID,'') 
					AND ISNULL(WT8899.S09ID,'') = isnull(@S09ID,'') 
					AND ISNULL(WT8899.S10ID,'') = isnull(@S10ID,'') 
					AND ISNULL(WT8899.S11ID,'') = isnull(@S11ID,'')  
					AND ISNULL(WT8899.S12ID,'') = isnull(@S12ID,'') 
					AND ISNULL(WT8899.S13ID,'') = isnull(@S13ID,'') 
					AND ISNULL(WT8899.S14ID,'') = isnull(@S14ID,'') 
					AND ISNULL(WT8899.S15ID,'') = isnull(@S15ID,'') 
					AND ISNULL(WT8899.S16ID,'') = isnull(@S16ID,'') 
					AND ISNULL(WT8899.S17ID,'') = isnull(@S17ID,'') 
					AND ISNULL(WT8899.S18ID,'') = isnull(@S18ID,'') 
					AND ISNULL(WT8899.S19ID,'') = isnull(@S19ID,'') 
					AND ISNULL(WT8899.S20ID,'') = isnull(@S20ID,'')
					--- cập nhật làm tròn phiếu xuất của phiếu nhập (VCNB)
				update AT0115 	set  	ConvertedAmount = ConvertedAmount +isnull(@DeltaAmount,0)							
				Where InventoryID =@InventoryID and 
					TransactionID = @TransactionID1 and 
					ReTransactionID = @TransactionID and 
					DivisionID = @DivisionID
					AND ISNULL(S01ID,'') = Isnull(@S01ID,'')
					AND ISNULL(S02ID,'') = isnull(@S02ID,'')
					AND ISNULL(S03ID,'') = isnull(@S03ID,'')
					AND ISNULL(S04ID,'') = isnull(@S04ID,'')
					AND ISNULL(S05ID,'') = isnull(@S05ID,'')
					AND ISNULL(S06ID,'') = isnull(@S06ID,'')
					AND ISNULL(S07ID,'') = isnull(@S07ID,'')
					AND ISNULL(S08ID,'') = isnull(@S08ID,'')
					AND ISNULL(S09ID,'') = isnull(@S09ID,'')
					AND ISNULL(S10ID,'') = isnull(@S10ID,'')
					AND ISNULL(S11ID,'') = isnull(@S11ID,'')
					AND ISNULL(S12ID,'') = isnull(@S12ID,'')
					AND ISNULL(S13ID,'') = isnull(@S13ID,'')
					AND ISNULL(S14ID,'') = isnull(@S14ID,'')
					AND ISNULL(S15ID,'') = isnull(@S15ID,'')
					AND ISNULL(S16ID,'') = isnull(@S16ID,'')
					AND ISNULL(S17ID,'') = isnull(@S17ID,'')
					AND ISNULL(S18ID,'') = isnull(@S18ID,'')
					AND ISNULL(S19ID,'') = isnull(@S19ID,'')
					AND ISNULL(S20ID,'') = isnull(@S20ID,'')
		End
							
FETCH NEXT FROM @Delta_cur INTO  @ReTransactionID, @InventoryID, @DeltaAmount, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
End

Close @Delta_cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
