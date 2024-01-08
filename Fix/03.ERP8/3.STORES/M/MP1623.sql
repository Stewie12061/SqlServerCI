IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1623]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP1623]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Created by Hoang Thi Lan
--Date 22/10/2003
--Purpose: TËp hîp chi phÝ nguyªn vËt liÖu (§· tËp hîp chi phÝ)
-- Edit by Quoc Hoai
--Edit by Dang Le Bao Quynh; Date 20/09/2006
--Purpose: Add column SourceNo from MV9000
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [02/08/2010]
'* Edited by : [GS] [Cẩm Loan] [24/12/2010] [Add distinct]
'**************************************************************/
--Edit by : Trong Khanh [10/02/2012] -- Thêm 5 mã phân tích
-- Modified by Tiểu Mai on 22/12/2015: Bổ sung thông tin quy cách hàng hóa
-- Modified by Phương Thảo on 23/03/2016: Bổ sung người lập 
-- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
-- Modified by Tiểu Mai on 18/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
-- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
-- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE PROCEDURE [dbo].[MP1623] @DivisionID as nvarchar(50),@PeriodID as nvarchar(50),@FromMonth as int,@FromYear as int,
	@ToMonth as int,@ToYear as int
as
Declare
	@FromPeriod as int,
	@ToPeriod as int,
	@sSQL as nvarchar(4000), @sSQL1 as nvarchar(MAX)
Set @FromPeriod=@FromMonth+@FromYear*100
Set @ToPeriod=@ToMonth+@ToYear*100
Set @sSQL='
Select distinct  MV9000.VoucherTypeID,
	MV9000.TransactionID,
	MV9000.TableID,
	MV9000.DivisionID,
	MV9000.VoucherNo,
	MV9000.VoucherDate,
	MV9000.DebitAccountID,
	MV9000.CreditAccountID,
	MV9000.CurrencyID,
	MV9000.ExchangeRate,
	MV9000.OriginalAmount,
	MV9000.ConvertedAmount,
	MV9000.ProductID,
	MV9000.InventoryID,
	MV9000.Quantity,
	MV9000.UnitPrice,
	MV9000.PeriodID,
	MT1601.Description as PeriodName,
	MT0699.UserName,
	AT1302_P.InventoryName as ProductName,
	AT1302_M.InventoryName,
	AT1302_M.UnitID as InventoryUnitID,
	AT1302_P.UnitID as ProductUnitID,
	MV9000.VDescription,
	MV9000.TDescription,
	MV9000.Ana01ID,MV9000.Ana02ID,MV9000.Ana03ID,MV9000.Ana04ID,MV9000.Ana05ID,
	MV9000.Ana06ID,MV9000.Ana07ID,MV9000.Ana08ID,MV9000.Ana09ID,MV9000.Ana10ID,
	MV9000.ObjectID,
	MV9000.ExpenseID,	
	MV9000.MaterialTypeID,
	AT1202.ObjectName,
	MV9000.CreateDate,
	MV9000.CreateUserID, 
	MV9000.LastModifyDate,
	MV9000.LastModifyUserID,
	MV9000.SourceNo,
	MT1601.IsDistribute as IsLocked,
	MV9000.EmployeeID
	'
SET @sSQL1 = '
From MV9000 	left join AT1302  AT1302_P WITH (NOLOCK)	on MV9000.ProductID	=	AT1302_P.InventoryID AND AT1302_P.DivisionID IN (MV9000.DivisionID,''@@@'')
		left join AT1302  AT1302_M WITH (NOLOCK)	on MV9000.InventoryID	=	AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MV9000.DivisionID,''@@@'')
		left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND MV9000.ObjectID	= AT1202.ObjectID				
		Inner join Mt1601 WITH (NOLOCK) on MT1601.PeriodID 	= 	MV9000.PeriodID And MV9000.DivisionID	=	MT1601.DivisionID
		left join MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID =	MV9000.MaterialTypeID And MV9000.DivisionID	=	MT0699.DivisionID	'

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL = @sSQL + ',
		MV9000.PS01ID, MV9000.PS02ID, MV9000.PS03ID, MV9000.PS04ID, MV9000.PS05ID, MV9000.PS06ID, MV9000.PS07ID, MV9000.PS08ID, MV9000.PS09ID, MV9000.PS10ID, 
		MV9000.PS11ID, MV9000.PS12ID, MV9000.PS13ID, MV9000.PS14ID, MV9000.PS15ID, MV9000.PS16ID, MV9000.PS17ID, MV9000.PS18ID, MV9000.PS19ID, MV9000.PS20ID,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID'
	SET @sSQL1 = @sSQL1 + '
		LEFT JOIN MT8899 O99 WITH (NOLOCK) on O99.DivisionID = MV9000.DivisionID and O99.VoucherID = MV9000.VoucherID and O99.TransactionID = MV9000.TransactionID and O99.TableID = ''MT9000'''
END

SET @sSQL1 = @sSQL1 + '	
Where MV9000.TranMonth+MV9000.TranYear*100 between '+str(@FromPeriod)+' and '+str(@ToPeriod)+'
	and MV9000.DivisionID='''+@DivisionID+'''
	and MV9000.ExpenseID=''COST001'' 
	and MV9000.PeriodID like '''+@PeriodID+'''
	and IsNull(MV9000.MaterialTypeID,'''') <>''''
 '
--- 	and MT1601.IsForPeriodID = 0

--- print @sSQL
If not exists (Select top 1 1 From SysObjects Where name = 'MV1623' and Xtype ='V')
	Exec ('Create view MV1623 as '+@sSQL + @sSQL1)
Else
	Exec ('Alter view MV1623 as '+@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

