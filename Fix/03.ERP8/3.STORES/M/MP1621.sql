IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1621]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1621]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Edited by: Vo Thanh Huong, date: 19/05/2005
---purpose: In chung tu phat sinh SXC
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [02/08/2010]
'**************************************************************/
--- Modified by Tiểu Mai on 21/12/2015: Bổ sung thông tin quy cách sản phẩm PS01ID --> PS20ID, bỏ view
--- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
--- Modified by Tiểu Mai on 18/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
--- Modified by Hải Long on 16/05/2017: Sửa lỗi thay "" thành ''''
--- Modified by N.Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[MP1621] @DivisionID as nvarchar(50),			
			@VoucherID nvarchar(50)
AS
Declare		@sSQL as nvarchar(4000), @sSQL1 as nvarchar(4000)

Set @sSQL='
Select   MV9000.VoucherTypeID,
	MV9000.TransactionID,
	MV9000.TableID,
	MV9000.FromTable,
	MV9000.VoucherID,
	MV9000.BatchID,
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
	AT1302.InventoryName as ProductName,
	AT1302.UnitID as ProductUnitID,
	MV9000.UnitID,
	MV9000.EmployeeID, AT1103.FullName,
	MV9000.VDescription,
	MV9000.PeriodID,
	MV9000.ExpenseID,
	MT0699.UserName,
	MV9000.MaterialTypeID,
	MV9000.ObjectID,
	AT1202.ObjectName as ObjectName,
	MV9000.Orders, 
	MV9000.TransactionTypeID,
	MV9000.Ana01ID, 
	MV9000.Ana02ID, 
	MV9000.Ana03ID, 
	MV9000.Ana04ID, 
	MV9000.Ana05ID,
	MV9000.Ana06ID,
	MV9000.Ana07ID,
	MV9000.Ana08ID,
	MV9000.Ana09ID,
	MV9000.Ana10ID, 
	AT1011_01.AnaName as AnaName01, 	
	AT1011_02.AnaName as AnaName02, 
	AT1011_03.AnaName as AnaName03,
	AT1011_04.AnaName as AnaName04,
	AT1011_05.AnaName as AnaName05,
	AT1011_06.AnaName as AnaName06,
	AT1011_07.AnaName as AnaName07,
	AT1011_08.AnaName as AnaName08,
	AT1011_09.AnaName as AnaName09,
	AT1011_10.AnaName as AnaName10
	'
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)

	SET @sSQL = @sSQL + ',
	MV9000.PS01ID, MV9000.PS02ID, MV9000.PS03ID, MV9000.PS04ID, MV9000.PS05ID, MV9000.PS06ID, MV9000.PS07ID, MV9000.PS08ID, MV9000.PS09ID, MV9000.PS10ID, 
	MV9000.PS11ID, MV9000.PS12ID, MV9000.PS13ID, MV9000.PS14ID, MV9000.PS15ID, MV9000.PS16ID, MV9000.PS17ID, MV9000.PS18ID, MV9000.PS19ID, MV9000.PS20ID
	'

SET @sSQL1 = '
From MV9000 	
	left join AT1302 WITH (NOLOCK) on MV9000.ProductID = AT1302.InventoryID AND AT1302.DivisionID IN (MV9000.DivisionID,''@@@'')
	left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND MV9000.ObjectID	= AT1202.ObjectID				
	left join MT0699 WITH (NOLOCK) on MV9000.MaterialTypeID	=	MT0699.MaterialTypeID	 and MV9000.DivisionID	= MT0699.DivisionID					
	left join AT1103 WITH (NOLOCK) on  AT1103.EmployeeID  = MV9000.EmployeeID					
	left join AT1011 AT1011_01 WITH (NOLOCK)  on AT1011_01.AnaID = MV9000.Ana01ID and AT1011_01.AnaTypeID = ''A01''
	left join AT1011 AT1011_02 WITH (NOLOCK)  on AT1011_02.AnaID = MV9000.Ana02ID and AT1011_02.AnaTypeID = ''A02''
	left join AT1011 AT1011_03 WITH (NOLOCK)  on AT1011_03.AnaID = MV9000.Ana03ID and AT1011_03.AnaTypeID = ''A03''
	left join AT1011 AT1011_04 WITH (NOLOCK)  on AT1011_04.AnaID = MV9000.Ana04ID and AT1011_04.AnaTypeID = ''A04''
	left join AT1011 AT1011_05 WITH (NOLOCK)  on AT1011_05.AnaID = MV9000.Ana05ID and AT1011_05.AnaTypeID = ''A05''
	left join AT1011 AT1011_06 WITH (NOLOCK)  on AT1011_06.AnaID = MV9000.Ana06ID and AT1011_06.AnaTypeID = ''A06''
	left join AT1011 AT1011_07 WITH (NOLOCK)  on AT1011_07.AnaID = MV9000.Ana07ID and AT1011_07.AnaTypeID = ''A07''
	left join AT1011 AT1011_08 WITH (NOLOCK)  on AT1011_08.AnaID = MV9000.Ana08ID and AT1011_08.AnaTypeID = ''A08''
	left join AT1011 AT1011_09 WITH (NOLOCK)  on AT1011_09.AnaID = MV9000.Ana09ID and AT1011_09.AnaTypeID = ''A09''
	left join AT1011 AT1011_10 WITH (NOLOCK)  on AT1011_10.AnaID = MV9000.Ana10ID and AT1011_10.AnaTypeID = ''A10''
Where 	MV9000.DivisionID='''+@DivisionID+''' and 
	MV9000.VoucherID = ''' + @VoucherID + ''' 	and 
	(MV9000.ExpenseID=''COST003'' or (Isnull(MV9000.ExpenseID,'''')= '''' and
							(DebitAccountID in (Select AccountID 
										  From MT0700 WITH (NOLOCK)
										  Where MT0700.ExpenseID=''COST003'' and MT0700.DivisionID ='''+@DivisionID+'''	) or CreditAccountID in (Select AccountID 
										  From MT0700 WITH (NOLOCK)
										  Where MT0700.ExpenseID=''COST003'' and MT0700.DivisionID ='''+@DivisionID+'''	))))
'
--PRINT @sSQL
--PRINT @sSQL1
EXEC (@sSQL + @sSQL1)
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
