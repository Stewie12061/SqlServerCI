IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0602_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0602_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--created by Hoang Thi Lan
--Date 17/10/2003
--Purpose: Dung cho Report Doanh so hang mua theo mat hang(tong hop) theo quy cách
--Edit by: Dang Le Bao Quynh; Date: 21/05/2008
--Purpose: Them he so quy doi cho mat hang
/********************************************
'* Edited by: [GS] [Thanh Nguyen] [29/07/2010]
'********************************************/
--- Edited by: Bao Anh	Date: 17/07/2012
--- Purpose: Lay them truong MPT doi tuong, dien giai, dieu khoan thanh toan
---- Modified on 26/10/2012 by Lê Thị Thu Hiền : Bổ sung JOIN DivisionID
---- Modified on 22/11/2013 by Thanh Sơn: Bổ sung lấy thêm 5 trường mã phân tích mặt hàng (Mã + Tên)
---- Modified on 08/01/2016 by Tiểu Mai: Bổ sung thông tin quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified on 08/05/2017 by Bảo Thy: Sửa danh mục dùng chung và bổ sung điều kiện quy cách khi left join AT9000 với AT1309
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP0602_QC] @DivisionID AS nvarchar(50), 
				@sSQLWhere AS nvarchar(4000), 
				@Group1ID as tinyint,	---- = 0 la theo loai mat hang.
								---  = 1 la theo tai khoan doanh so
								---  = 2 la theo doi tuong
				@Group2ID as tinyint
AS

Declare @sSQL as nvarchar(4000)
Declare @sSQL1 as nvarchar(4000)
Declare @sSQL2 as nvarchar(4000)

	Set @sSQL=N'
			Select 	
				' + (Case when @Group1ID = 0 then 'AT9000.InventoryID'
					when @Group1ID = 1 then 'AT9000.DebitAccountID'
					else 'AT9000.ObjectID' end) + ' as Group1ID,
				' + (Case when @Group1ID = 0 then 'AT1302.InventoryName'
					when @Group1ID = 1 then 'AT1005.AccountName'
					else 'AT1202.ObjectName' end) + ' as Group1Name,
				' + (Case when @Group2ID = 0 then 'AT9000.InventoryID'
					when @Group2ID = 1 then 'AT9000.DebitAccountID'
					else 'AT9000.ObjectID' end) + ' as Group2ID,
				' + (Case when @Group2ID = 0 then 'AT1302.InventoryName'
					when @Group2ID = 1 then 'AT1005.AccountName'
					else 'AT1202.ObjectName' end) + ' as Group2Name,
				AT9000.ObjectID,
				AT1202.ObjectName,
				AT9000.InventoryID,
				AT1302.InventoryName,
				AT1302.UnitID,
				AT1309.UnitID As ConversionUnitID,
				AT1309.ConversionFactor,
				AT1309.Operator,	
				DebitAccountID, AccountName as DebitAccountName,
				sum(isnull(Quantity,0)) as Quantity,
				sum(isnull(OriginalAmount,0)) as OriginalAmount,
				sum(isnull(ConvertedAmount,0)) as ConvertedAmount,

				sum(ImTaxOriginalAmount) as ImTaxOriginalAmount,
				sum(ImTaxConvertedAmount) as ImTaxConvertedAmount,
				sum(ExpenseOriginalAmount) as ExpenseOriginalAmount,	
				sum(ExpenseConvertedAmount) as ExpenseConvertedAmount,
				AT9000.DivisionID,
				AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
				O1.AnaName As O01Name, O2.AnaName As O02Name, O3.AnaName As O03Name, O4.AnaName As O04Name, O5.AnaName As O05Name,
				BDescription, TDescription, AT9000.PaymentTermID, AT1208.PaymentTermName,
				AT1302.[I01ID], AT1302.[I02ID], AT1302.[I03ID], AT1302.[I04ID], AT1302.[I05ID],
				I1.AnaName AS I01Name,I2.AnaName AS I02Name,I3.AnaName AS I03Name,I4.AnaName AS I04Name,I5.AnaName AS I05Name,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID
	From AT9000 WITH (NOLOCK) left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
			LEFT JOIN AT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT9000.DivisionID AND O99.VoucherID = AT9000.VoucherID AND O99.TransactionID = AT9000.TransactionID'
	SET @sSQL1 = '
			Left join (Select DivisionID, InventoryID,Min(UnitID) As UnitID,Min(ConversionFactor) As ConversionFactor, Min(Operator) As Operator ,
					ISNULL(S01ID,'''') AS S01ID, ISNULL(S02ID,'''') AS S02ID, ISNULL(S03ID,'''') AS S03ID, ISNULL(S04ID,'''') AS S04ID, 
					ISNULL(S05ID,'''') AS S05ID, ISNULL(S06ID,'''') AS S06ID, ISNULL(S07ID,'''') AS S07ID, ISNULL(S08ID,'''') AS S08ID, 
					ISNULL(S09ID,'''') AS S09ID, ISNULL(S10ID,'''') AS S10ID, ISNULL(S11ID,'''') AS S11ID, ISNULL(S12ID,'''') AS S12ID, 
					ISNULL(S13ID,'''') AS S13ID, ISNULL(S14ID,'''') AS S14ID, ISNULL(S15ID,'''') AS S15ID, ISNULL(S16ID,'''') AS S16ID, 
					ISNULL(S17ID,'''') AS S17ID, ISNULL(S18ID,'''') AS S18ID, ISNULL(S19ID,'''') AS S19ID, ISNULL(S20ID,'''') AS S20ID
					From AT1309 WITH (NOLOCK) Group By DivisionID, InventoryID,ISNULL(S01ID,''''), ISNULL(S02ID,''''), ISNULL(S03ID,''''), 
					ISNULL(S04ID,''''), ISNULL(S05ID,''''), ISNULL(S06ID,''''), ISNULL(S07ID,''''), ISNULL(S08ID,''''), 
					ISNULL(S09ID,''''), ISNULL(S10ID,''''), ISNULL(S11ID,''''), ISNULL(S12ID,''''), ISNULL(S13ID,''''), 
					ISNULL(S14ID,''''), ISNULL(S15ID,''''), ISNULL(S16ID,''''), ISNULL(S17ID,''''), ISNULL(S18ID,''''), 
					ISNULL(S19ID,''''), ISNULL(S20ID,'''')) AT1309 
			On AT9000.InventoryID = AT1309.InventoryID
			AND ISNULL(O99.S01ID,'''') = isnull(AT1309.S01ID,'''') AND ISNULL(O99.S02ID,'''') = isnull(AT1309.S02ID,'''')
			AND ISNULL(O99.S03ID,'''') = isnull(AT1309.S03ID,'''') AND ISNULL(O99.S04ID,'''') = isnull(AT1309.S04ID,'''') 
			AND ISNULL(O99.S05ID,'''') = isnull(AT1309.S05ID,'''') AND ISNULL(O99.S06ID,'''') = isnull(AT1309.S06ID,'''') 
			AND ISNULL(O99.S07ID,'''') = isnull(AT1309.S07ID,'''') AND ISNULL(O99.S08ID,'''') = isnull(AT1309.S08ID,'''') 
			AND ISNULL(O99.S09ID,'''') = isnull(AT1309.S09ID,'''') AND ISNULL(O99.S10ID,'''') = isnull(AT1309.S10ID,'''') 
			AND ISNULL(O99.S11ID,'''') = isnull(AT1309.S11ID,'''') AND ISNULL(O99.S12ID,'''') = isnull(AT1309.S12ID,'''') 
			AND ISNULL(O99.S13ID,'''') = isnull(AT1309.S13ID,'''') AND ISNULL(O99.S14ID,'''') = isnull(AT1309.S14ID,'''') 
			AND ISNULL(O99.S15ID,'''') = isnull(AT1309.S15ID,'''') AND ISNULL(O99.S16ID,'''') = isnull(AT1309.S16ID,'''') 
			AND ISNULL(O99.S17ID,'''') = isnull(AT1309.S17ID,'''') AND ISNULL(O99.S18ID,'''') = isnull(AT1309.S18ID,'''') 
			AND ISNULL(O99.S19ID,'''') = isnull(AT1309.S19ID,'''') AND ISNULL(O99.S20ID,'''') = isnull(AT1309.S20ID,'''')
			left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID = AT1202.ObjectID
			left join AT1005 WITH (NOLOCK) on AT9000.DebitAccountID = AT1005.AccountID
			Left join AT1015 O1 WITH (NOLOCK) on AT1202.O01ID = O1.AnaID And O1.AnaTypeID = ''O01''
			Left join AT1015 O2 WITH (NOLOCK) on AT1202.O02ID = O2.AnaID And O2.AnaTypeID = ''O02''
			Left join AT1015 O3 WITH (NOLOCK) on AT1202.O03ID = O3.AnaID And O3.AnaTypeID = ''O03''
			Left join AT1015 O4 WITH (NOLOCK) on AT1202.O04ID = O4.AnaID And O4.AnaTypeID = ''O04''
			Left join AT1015 O5 WITH (NOLOCK) on AT1202.O05ID = O5.AnaID And O5.AnaTypeID = ''O05''
			Left join AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND AT1302.I01ID = I1.AnaID And I1.AnaTypeID = ''I01''
			Left join AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND AT1302.I02ID = I2.AnaID And I2.AnaTypeID = ''I02''
			Left join AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND AT1302.I03ID = I3.AnaID And I3.AnaTypeID = ''I03''
			Left join AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND AT1302.I04ID = I4.AnaID And I4.AnaTypeID = ''I04''
			Left join AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND AT1302.I05ID = I5.AnaID And I5.AnaTypeID = ''I05''
			Left Join AT1208 WITH (NOLOCK) on AT9000.PaymentTermID = AT1208.PaymentTermID
		'
	set @sSQL2 = 'Where AT9000.DivisionID=N'''+@DivisionID+''' and AT9000.TransactionTypeID in (N''T03'',N''T30'')
		and '+@sSQLWhere+'
	Group by AT9000.ObjectID, AT1202.ObjectName, AT9000.InventoryID, AT1302.InventoryName, DebitAccountID,
				AT1005.AccountName,
				AT1302.UnitID,
				AT1309.UnitID,
				AT1309.ConversionFactor,
				AT1309.Operator,
				AT9000.DivisionID,
				AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
				O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName,
				BDescription, TDescription, AT9000.PaymentTermID, AT1208.PaymentTermName,
				AT1302.[I01ID], AT1302.[I02ID], AT1302.[I03ID], AT1302.[I04ID], AT1302.[I05ID],
				I1.AnaName, I2.AnaName, I3.AnaName, I4.AnaName, I5.AnaName,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID   '
	
--print @sSQL
--print @sSQL1
--print @sSQL2

If not exists (Select top 1 1 From SysObjects Where name = 'AV0602' and Xtype ='V')
	Exec ('Create view AV0602 --AP0602
	as '+@sSQL + @sSQL1 + @sSQL2)
Else
	Exec ('Alter view AV0602  --AP0602
	as '+@sSQL + @sSQL1 + @sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

