/****** Object:  View [dbo].[WQ7001]    Script Date: 12/16/2010 15:43:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

--View chet
--So du va phat sinh khong lay van chuyen noi bo
---- Edit by: Thuy Tuyen; Date: 31/03/2010
---- Purpose: Bo sung truong hop xuat hang mua tra lai
----Edit: Thuy Tuyen, date : 13/04/2010
---- Modified on 11/09/2015 by Thanh Thịnh : Lấy thêm FullName Ở AT1303 cho Figla
----Them truong parameterID
--- Modify on 15/05/2016 by Bảo Anh: Bỏ distinct
--- Modified by Tiểu Mai on 20/03/2016: Fix báo cáo nhập tồn theo ĐVT quy đổi sai do cột ConvertedUnitID = NULL
--- Modified by Tiểu Mai on 21/10/2016: Cải tiến tốc độ
--- Modify on 15/05/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

ALTER VIEW   [dbo].[WQ7001] as 
--- So du No cua tai khoan ton kho

Select D17.TransactionID, D17.DivisionID, D17.TranMonth, D17.TranYear,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	'BD' as D_C,  --- So du No
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, D16.ObjectID,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID,
	D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.VATPercent, D02.Specification, 
	D02.Notes01, D02.Notes02, D02.Notes03,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	isnull(D03.IsTemp,0) as IsTemp,D03.FullName [WHFullName],
	---Thong tin DVT qui doi
	 Parameter01,  Parameter02,   Parameter03,  Parameter04,   Parameter05,
	D17.InventoryID +  'T01'+ cast (isnull(Parameter01,0) as varchar)  +   'T02'+ cast (isnull(Parameter02,0) as varchar)
	+  'T03'+ cast (isnull(Parameter03,0) as varchar)  + 'T04'+  cast (isnull(Parameter04,0) as varchar)   +  'T05'+  cast (isnull(Parameter03,0) as varchar)   as ParameterID,
	--CASE WHEN D17.UnitID = D17.ConvertedUnitID THEN NULL ELSE D17.ConvertedUnitID END AS ConvertedUnitID,  
	D17.ConvertedUnitID,
	D05.UnitName AS ConvertedUnitName,
	D17.ConvertedQuantity , D17.ConvertedQuantity AS  SignConvertedQuantity, D17.ConvertedPrice,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID

From AT2017 as D17 WITH (NOLOCK) left join AT2016 as D16 WITH (NOLOCK) On D16.VoucherID = D17.VoucherID and D16.DivisionID = D17.DivisionID
		left join AT1302 as D02 WITH (NOLOCK) on D02.DivisionID IN ('@@@', D17.DivisionID) AND D02.InventoryID = D17.InventoryID
		left join AT1304 as D04 WITH (NOLOCK) on D04.UnitID = D02.UnitID
		left join AT1303 as D03 WITH (NOLOCK) on D03.DivisionID IN ('@@@', D17.DivisionID) AND D03.WareHouseID = D16.WareHouseID
		left join AT1304 as D05 WITH (NOLOCK) on D05.UnitID = D17.ConvertedUnitID --CASE WHEN D17.UnitID = D17.ConvertedUnitID THEN NULL ELSE D17.ConvertedUnitID END		                                                      
        LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D17.DivisionID AND O99.VoucherID = D17.VoucherID AND O99.TransactionID = D17.TransactionID AND O99.TableID = 'AT2017'		                                                            
Where isnull(DebitAccountID,'') <>''

Union All --- So du co hang ton kho

Select D17.TransactionID, D17.DivisionID, D17.TranMonth, D17.TranYear,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	'BC' as D_C,  --- So du Co
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, D16.ObjectID,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID,
	D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID,  D02.VATPercent, D02.Specification,
	D02.Notes01, D02.Notes02, D02.Notes03,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	isnull(D03.IsTemp,0) as IsTemp,D03.FullName [WHFullName],
	---Thong tin DVT qui doi
	 Parameter01,  Parameter02,   Parameter03,  Parameter04,   Parameter05,
		D17.InventoryID + 'T01'+ cast (isnull(Parameter01,0) as varchar)  +   'T02'+ cast (isnull(Parameter02,0) as varchar)
	+  'T03'+ cast (isnull(Parameter03,0) as varchar)  + 'T04'+  cast (isnull(Parameter04,0) as varchar)   +  'T05'+  cast (isnull(Parameter03,0) as varchar)   as ParameterID,
	--CASE WHEN D17.UnitID = D17.ConvertedUnitID THEN NULL ELSE D17.ConvertedUnitID END AS ConvertedUnitID,  
	D17.ConvertedUnitID,
	D05.UnitName  AS ConvertedUnitName,
	D17.ConvertedQuantity , D17.ConvertedQuantity AS  SignConvertedQuantity, D17.ConvertedPrice,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID

From AT2017 as D17 WITH (NOLOCK) left join AT2016 as D16 WITH (NOLOCK) On D16.VoucherID = D17.VoucherID and D16.DivisionID = D17.DivisionID
		left join AT1302 as D02 WITH (NOLOCK) on D02.DivisionID IN ('@@@', D17.DivisionID) AND D02.InventoryID = D17.InventoryID
		left join AT1304 as D04 WITH (NOLOCK) on D04.UnitID = D02.UnitID
		left join AT1303 as D03 WITH (NOLOCK) on D03.DivisionID IN ('@@@', D17.DivisionID) AND D03.WareHouseID = D16.WareHouseID
		left join AT1304 as D05 WITH (NOLOCK) on D05.UnitID = D17.ConvertedUnitID --CASE WHEN D17.UnitID = D17.ConvertedUnitID THEN NULL ELSE D17.ConvertedUnitID END
		LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D17.DivisionID AND O99.VoucherID = D17.VoucherID AND O99.TransactionID = D17.TransactionID AND O99.TableID = 'AT2017'
Where isnull(CreditAccountID,'') <>''

Union All  -- Nhap kho

Select D07.TransactionID, D07.DivisionID, D07.TranMonth, D07.TranYear,
	D06.WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	'D' as D_C,  --- Phat sinh No
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, D06.ObjectID,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID,
	D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID,  D02.VATPercent, D02.Specification,
	D02.Notes01, D02.Notes02, D02.Notes03,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	isnull(D03.IsTemp,0) as IsTemp,D03.FullName [WHFullName],
	D07.Parameter01,D07.Parameter02, D07.Parameter03,D07.Parameter04, D07.Parameter05,
	D07.InventoryID+'T01'+ cast (isnull(Parameter01,0) as varchar)  +   'T02'+ cast (isnull(Parameter02,0) as varchar)
	+  'T03'+ cast (isnull(Parameter03,0) as varchar)  + 'T04'+  cast (isnull(Parameter04,0) as varchar)   +  'T05'+  cast (isnull(Parameter03,0) as varchar)   as ParameterID,
	--CASE WHEN D07.UnitID = D07.ConvertedUnitID THEN NULL ELSE D07.ConvertedUnitID END AS ConvertedUnitID,  
	D07.ConvertedUnitID,
	D05.UnitName as ConvertedUnitName,
	D07.ConvertedQuantity,D07.ConvertedQuantity as SignConvertedQuantity, D07.ConvertedPrice,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID

From AT2007 as D07 WITH (NOLOCK) left join AT2006 D06 WITH (NOLOCK) On D06.VoucherID = D07.VoucherID and D06.DivisionID = D07.DivisionID
		left join AT1302 as D02 WITH (NOLOCK) on D02.DivisionID IN ('@@@', D07.DivisionID) AND D02.InventoryID = D07.InventoryID
		left join AT1304 as D04 WITH (NOLOCK) on D04.UnitID = D02.UnitID
		left join AT1303 as D03 WITH (NOLOCK) on D03.DivisionID IN ('@@@', D07.DivisionID) AND D03.WareHouseID = D06.WareHouseID
		left join AT1304 as D05 WITH (NOLOCK) on D05.UnitID = D07.ConvertedUnitID --CASE WHEN D07.UnitID = D07.ConvertedUnitID THEN NULL ELSE D07.ConvertedUnitID END
		LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D07.DivisionID AND O99.VoucherID = D07.VoucherID AND O99.TransactionID = D07.TransactionID AND O99.TableID = 'AT2007'
Where D06.KindVoucherID in (1,5,7)

Union All  -- xuat kho
Select D07.TransactionID, D07.DivisionID, D07.TranMonth, D07.TranYear,
	Case when D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End as WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	'C' as D_C,  --- So du Co
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, D06.ObjectID,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID,
	D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID,  D02.VATPercent, D02.Specification, 
	D02.Notes01, D02.Notes02, D02.Notes03,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	isnull(D03.IsTemp,0) as IsTemp,D03.FullName [WHFullName],
	D07.Parameter01,D07.Parameter02, D07.Parameter03,D07.Parameter04, D07.Parameter05,
	D07.InventoryID+'T01'+ cast (isnull(Parameter01,0) as varchar)  +   'T02'+ cast (isnull(Parameter02,0) as varchar)
	+  'T03'+ cast (isnull(Parameter03,0) as varchar)  + 'T04'+  cast (isnull(Parameter04,0) as varchar)   +  'T05'+  cast (isnull(Parameter03,0) as varchar)   as ParameterID,
	--CASE WHEN D07.UnitID = D07.ConvertedUnitID THEN NULL ELSE D07.ConvertedUnitID END AS ConvertedUnitID,
	D07.ConvertedUnitID,  
	D05.UnitName as ConvertedUnitName,
	D07.ConvertedQuantity,D07.ConvertedQuantity as SignConvertedQuantity, D07.ConvertedPrice,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
From AT2007 as D07 WITH (NOLOCK) left join AT2006 D06 WITH (NOLOCK) On D06.VoucherID = D07.VoucherID and D06.DivisionID = D07.DivisionID
		left join AT1302 as D02 WITH (NOLOCK) on D02.DivisionID IN ('@@@', D07.DivisionID) AND D02.InventoryID = D07.InventoryID
		left join AT1304 as D04 WITH (NOLOCK) on D04.UnitID = D02.UnitID
		left join AT1303 as D03 WITH (NOLOCK) on D03.DivisionID IN ('@@@', D07.DivisionID) AND D03.WareHouseID = D06.WareHouseID
		left join AT1304 as D05 WITH (NOLOCK) on D05.UnitID = D07.ConvertedUnitID --CASE WHEN D07.UnitID = D07.ConvertedUnitID THEN NULL ELSE D07.ConvertedUnitID END
		LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D07.DivisionID AND O99.VoucherID = D07.VoucherID AND O99.TransactionID = D07.TransactionID AND O99.TableID = 'AT2007'
Where D06.KindVoucherID in (2,4,10)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO