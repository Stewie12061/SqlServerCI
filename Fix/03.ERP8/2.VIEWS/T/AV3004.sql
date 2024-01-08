IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV3004]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV3004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--View chet dung cho FIFO: chi lay nhung phieu nhap kho va nhap kho VCNB
--Creater By Nguyen Thi Thuy Tuyen
--Date: 07/10/2006
--- Edited by Bao Anh	Date: 30/10/2012
--- Purpose: Bo sung truong tham so, MPT, ConvertedUnitID, ConvertedQuantity, Loai chung tu
--- Modified on 08/03/2013 by Bao Anh: Bo sung 15 tham so, doi tuong
--- Modified on 14/03/2013 by Bao Anh: Bo sung ConvertedUnitName
--- Modified on 07/05/2013 by Bao Anh: Sua inner join AT1202 thanh left join
--- Modified on 22/08/2013 by Khanh Van: Select thêm số lượng mark 2T
--- Modified on 30/03/2016 by Phương Thảo: Bổ sung TK
--- Modify on 25/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
--- Modified by Bảo Thy on 22/01/2018: Bổ sung thông tin quy cách
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--- Modified by Đình Định on 08/06/2023: VIMEC - Bổ sung thêm cột Description, Ana01ID, Nhóm hàng.

CREATE VIEW [dbo].[AV3004] as 
Select   --Case When KindVoucherID=3 then WareHouseID2 else WareHouseID End as WareHouseID
	WareHouseID, 
	AT2007.TransactionID, AT2007.VoucherID, AT2007.InventoryID, AT2007.UnitID, 
	AT2007.ActualQuantity, 
	AT2007.MarkQuantity, AT2007.UnitPrice, 
	AT2007.OriginalAmount, AT2007.ConvertedAmount, AT2007.TranMonth, AT2007.TranYear, 
	AT2007.DivisionID, AT2007.ReTransactionID, AT2007.ReVoucherID,
	AT2007.exchangeRate,AT2007.currencyID,AT2007.notes,
	'T05'  as TransactionTypeID,
	AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
	AT2007.Ana04ID, AT2007.Ana05ID, AT2007.ConvertedUnitID, AT2007.ConvertedQuantity, AT2006.VoucherTypeID,
	AT2007.Notes01, AT2007.Notes02, AT2007.Notes03, AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,
	AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13, AT2007.Notes14, AT2007.Notes15,
	AT2006.ObjectID, AT1202.ObjectName, AT1304.UnitName as ConvertedUnitName,
	AT2007.DebitAccountID, AT2007.CreditAccountID, AT2006.[Description], AT2007.Ana01ID,
	WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, 
	WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID, 
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, 
	WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
From AT2007 WITH (NOLOCK)
inner Join AT2006 WITH (NOLOCK) On AT2006.VoucherID = AT2007.VoucherID And AT2006.DivisionID = AT2007.DivisionID and KindVoucherID in (1,3,5,7,9)
left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AT2007.DivisionID, '@@@') AND AT2006.ObjectID = AT1202.ObjectID
left join AT1304 WITH (NOLOCK) on AT2007.ConvertedUnitID = AT1304.UnitID
LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.VoucherID = AT2007.VoucherID AND WT8899.DivisionID = AT2007.DivisionID AND WT8899.TransactionID = AT2007.TransactionID

Union 

Select   AT2016.WareHouseID, 
	AT2017.TransactionID, AT2017.VoucherID, AT2017.InventoryID, AT2017.UnitID, 
	AT2017.ActualQuantity,
	AT2017.MarkQuantity, AT2017.UnitPrice, 
	AT2017.OriginalAmount, AT2017.ConvertedAmount, AT2017.TranMonth, AT2017.TranYear, 
	AT2017.DivisionID, AT2017.ReTransactionID, AT2017.ReVoucherID ,
	AT2017.exchangeRate,AT2017.currencyID,AT2017.notes	,
	'T00' as TransactionTypeID,
	AT2017.Parameter01, AT2017.Parameter02, AT2017.Parameter03, AT2017.Parameter04, AT2017.Parameter05,
	AT2017.Ana04ID, AT2017.Ana05ID, AT2017.ConvertedUnitID, AT2017.ConvertedQuantity, AT2016.VoucherTypeID,
	AT2017.Notes01, AT2017.Notes02, AT2017.Notes03, AT2017.Notes04, AT2017.Notes05, AT2017.Notes06, AT2017.Notes07, AT2017.Notes08,
	AT2017.Notes09, AT2017.Notes10, AT2017.Notes11, AT2017.Notes12, AT2017.Notes13, AT2017.Notes14, AT2017.Notes15,
	AT2016.ObjectID, AT1202.ObjectName, AT1304.UnitName as ConvertedUnitName,
	AT2017.DebitAccountID, AT2017.CreditAccountID, AT2016.[Description], AT2017.Ana01ID, 
	WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, 
	WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID, 
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, 
	WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
From AT2017 WITH (NOLOCK)
inner Join AT2016 WITH (NOLOCK) On AT2016.VoucherID = AT2017.VoucherID And AT2016.DivisionID = AT2017.DivisionID
left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AT2017.DivisionID, '@@@') AND AT2016.ObjectID = AT1202.ObjectID
left join AT1304 WITH (NOLOCK) on AT2017.ConvertedUnitID = AT1304.UnitID
LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.VoucherID = AT2017.VoucherID AND WT8899.DivisionID = AT2017.DivisionID AND WT8899.TransactionID = AT2017.TransactionID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

