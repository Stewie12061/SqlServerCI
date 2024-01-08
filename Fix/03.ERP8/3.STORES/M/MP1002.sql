IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)     
DROP PROCEDURE [DBO].[MP1002]  
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO  

--- Create by: Dang Le Bao Quynh; date 08/07/2010
--- Purpose: Xuat detail cho phieu xuat kho tu dong
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

CREATE PROCEDURE MP1002
	@DivisionID as varchar(50), @TranMonth as int, @TranYear as int,
	@VoucherID as varchar(50), @exVoucherID as varchar(50), @WareHouseID varchar(50), @InventoryTypeID as varchar(50), 
	@PeriodID as varchar(50), @ApportionID as varchar(50), @DebitAccountID as varchar(50), 
	@QuantityDecimals as tinyint
AS

DECLARE
	@ProductID as varchar(50),
	@Quantity as decimal(28,8),
	@MaterialID as varchar(50),
	@UnitID as varchar(50),
	@QuantityUnit as decimal(28,8),
	@CreditAccountID as varchar(50),
	@Orders as int,
	@TransactionID as varchar(50), 
	@cur as cursor

Set @Orders = 1
Set @cur = cursor static for

Select MT16.ProductID, MT16.MaterialID , AT14.UnitID, AT14.AccountID, MT10.Quantity, isnull(MT16.QuantityUnit,0)
From MT1603 MT16 WITH (NOLOCK)
Inner Join
(Select MT1001.DivisionID, MT1001.VoucherID, MT1001.ProductID, sum(isnull(Quantity,0)) as Quantity 
From MT1001 WITH (NOLOCK)
Where DivisionID = @DivisionID
Group By  MT1001.DivisionID, MT1001.VoucherID, MT1001.ProductID
) MT10
On MT16.ProductID = MT10.ProductID and MT16.DivisionID = @DivisionID
Inner Join AT1302 AT13 WITH (NOLOCK) On MT10.ProductID = AT13.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@')
Inner Join AT1302 AT14 WITH (NOLOCK) On MT16.MaterialID = AT14.InventoryID AND AT14.DivisionID IN (MT16.DivisionID,'@@@')
Where MT16.ExpenseID = 'COST001' And MT16.ApportionID = @ApportionID 
And MT10.VoucherID = @VoucherID And Case When @InventoryTypeID = 'VL' Then AT13.I04ID Else  AT13.I05ID End = @WareHouseID
And  AT14.InventoryTypeID = @InventoryTypeID

Open @cur
Fetch Next From @cur Into @ProductID, @MaterialID, @UnitID, @CreditAccountID, @Quantity, @QuantityUnit
While @@Fetch_Status = 0
Begin
	EXEC AP0000 @DivisionID,@TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'

	Insert Into AT2007
		(TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, 
		TranMonth, TranYear, DivisionID, CurrencyID, ExchangeRate, 
		DebitAccountID,CreditAccountID, Orders, PeriodID, ProductID)
	Values 
		(@TransactionID, @exVoucherID, @MaterialID, @UnitID, Round(@Quantity*@QuantityUnit,@QuantityDecimals),
		@TranMonth, @TranYear, @DivisionID, 'VND', 1,
		@DebitAccountID,@CreditAccountID, @Orders, @PeriodID, @ProductID)

	Set @Orders = @Orders + 1
	Fetch Next From @cur Into @ProductID, @MaterialID, @UnitID, @CreditAccountID, @Quantity, @QuantityUnit
End

Close @cur
  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
