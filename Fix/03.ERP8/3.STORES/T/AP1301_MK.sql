IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1301_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1301_MK]
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
---- Modified by Phuong Thao on 20/07/2016: Bổ sung WITH (ROWLOCK) 
/********************************************
'* Edited by: [GS] [Thanh Nguyen] [29/07/2010]
'********************************************/
---- Modified by Phuong Thao on 24/08/2016: Bổ sung làm tròn số lẻ
---- Modified by Huỳnh Thử on 11/07/2020:  Chỉ tính giá những mặt hàng có phát sinh trong kỳ
---- Modified by Huỳnh Thử on 19/08/2020:  Merge Code: MEKIO và MTE
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.


CREATE PROCEDURE [dbo].[AP1301_MK] @DivisionID as nvarchar(50), @TranMonth as int , @TranYear int,
	@FromInventoryID NVARCHAR(50) = '', 
	@ToInventoryID NVARCHAR(50) = ''
 AS

Declare @DeltaAmount as decimal(28,8),
	 @ReTransactionID as nvarchar(50),
	@InventoryID as  nvarchar(50),
	@TransactionID nvarchar(50),
	@Delta_cur as cursor,
	--PHAN LAM TRON SO	
	@UnitCostDecimals  as tinyint, 
	@ConvertedDecimals as tinyint

	-- Mặt hàng trong kỳ
	SELECT DISTINCT InventoryID INTO #InventoryID FROM AT2007 WITH (NOLOCK)
				LEFT JOIN AT2006  WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
				WHERE AT2006.TranMonth = @TranMonth AND AT2006.TranYear = @TranYear
				AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
				AND KindVoucherID IN (2,3,4,6,8) 

Select @UnitCostDecimals = UnitCostDecimals, @ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK) where DivisionID = @DivisionID


SET @Delta_cur = Cursor Scroll KeySet FOR 
	
Select 	AT0114.ReTransactionID, AT0114.InventoryID, AT2007.ConvertedAmount- sum(AT0115.convertedAmount) as DeltaAmount 

From AT0114  WITH (NOLOCK)---	inner join AT1302 WITH (NOLOCK) on AT1302.InventoryID = AT0114.InventoryID and AT1302.DivisionID = AT0114.DivisionID
Inner join AT0115 WITH (NOLOCK) on AT0115.reTransactionID = AT0114.reTransactionID and AT0115.DivisionID = AT0114.DivisionID and AT0115.TranMonth + 100*AT0115.TranYear >= @TranMonth +100*@TranYear
inner join (Select TransactionID, ConvertedAmount, DivisionID From AT2007 WITH (NOLOCK)
			Where 
			--InventoryID between @FromInventoryID and @ToInventoryID
			  InventoryID IN (SELECT InventoryID FROM #InventoryID)
			Union All
			Select TransactionID, ConvertedAmount, DivisionID From AT2017 WITH (NOLOCK)
			Where 
			--InventoryID between @FromInventoryID and @ToInventoryID
			  InventoryID IN (SELECT InventoryID FROM #InventoryID)
	) AT2007 on AT2007.TransactionID =AT0114.reTransactionID and AT2007.DivisionID =AT0114.DivisionID
Where (Select TOP 1 MethodID From AT1302 WITH (NOLOCK) Where DivisionID IN (AT0114.DivisionID,'@@@') and InventoryID = AT0114.InventoryID) = 1
and EndQuantity =0 and AT0114.DivisionID = @DivisionID
and AT0114.ReTranMonth + AT0114.ReTranYear*100 >= @TranMonth + @TranYear*100
and (
		--AT0114.InventoryID between @FromInventoryID and @ToInventoryID
		  AT0114.InventoryID IN (SELECT InventoryID FROM #InventoryID)
)
group by AT0114.ReTransactionID, AT0114.InventoryID, AT0114.ReVoucherNo,ReQuantity, AT0114.UnitPrice,
	AT2007.ConvertedAmount
having AT2007.ConvertedAmount- sum(AT0115.convertedAmount)<>0

OPEN	@Delta_cur
FETCH NEXT FROM @Delta_cur INTO  @ReTransactionID, @InventoryID, @DeltaAmount
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
	Set @TransactionID = null
	Set @TransactionID = (Select top 1 TransactionID From AT0115 WITH (NOLOCK)
							Where ReTransactionID = @ReTransactionID and InventoryID =@InventoryID and
								TranMonth + 100*TranYear >= @TranMonth +100*@TranYear and DivisionID = @DivisionID
				Order by TranYear*100+ TranMonth DESC, ConvertedAmount Desc)

	If @TransactionID is not null
		Begin
			--- Update AT2007
				update AT2007 WITH(ROWLOCK)  
				set 	ConvertedAmount = Round(ConvertedAmount +isnull(@DeltaAmount,0),ISNULL(@ConvertedDecimals,0)),
						OriginalAmount = Round(ConvertedAmount+isnull(@DeltaAmount,0),ISNULL(@ConvertedDecimals,0)),
						UnitPrice = Round((Case when ActualQuantity <>0 then (ConvertedAmount+isnull(@DeltaAmount,0))/ActualQuantity else UnitPrice End),Isnull(@UnitCostDecimals,0))
				Where InventoryID =@InventoryID and 
					TransactionID = @TransactionID and 
					DivisionID = @DivisionID

			--- Update At0115
				update AT0115 	
				set  	ConvertedAmount = Round(ConvertedAmount +isnull(@DeltaAmount,0),ISNULL(@ConvertedDecimals,0))							
				Where InventoryID =@InventoryID and 
					TransactionID = @TransactionID and 
					ReTransactionID = @ReTransactionID and 
					DivisionID = @DivisionID	
		End
							
FETCH NEXT FROM @Delta_cur INTO  @ReTransactionID, @InventoryID, @DeltaAmount
End

Close @Delta_cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
