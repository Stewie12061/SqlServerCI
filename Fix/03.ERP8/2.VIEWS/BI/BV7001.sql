IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BV7001]') AND OBJECTPROPERTY(ID, N'IsView') = 1)  
DROP VIEW [DBO].[BV7001]  
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO

--- Created by B.Anh	Date: 05/11/2010
--- Purpose: View so du theo seri, khong lay VCNB
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE View BV7001 as 
-- Nhap kho
Select  D07.DivisionID, D07.TranMonth, D07.TranYear, D07.WareHouseID, 
	D07.SeriNo, D07.InventoryID, 'D' as D_C,  --- Phat sinh No
	D07.Notes, D07.VoucherID, D07.VoucherDate, D07.VoucherNo, 
	D07.ObjectID,AT1202.ObjectName, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	D03.WareHouseName, Quantity, D02.S1, D02.S2, D02.S3, D02.S1 as CI1ID, D02.S2 as CI2ID, D02.S3 as CI3ID, 
	D07.VoucherTypeID, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D02.Notes01, D02.Notes02, D02.Notes03,
	isnull(D03.IsTemp,0) as IsTemp,
	(Case When  D07.TranMonth <10 then '0'+rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) 
	Else rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) End) as MonthYear,
	('0'+ ltrim(rtrim(Case when D07.TranMonth %3 = 0 then D07.TranMonth/3  Else D07.TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(D07.TranYear)))
	)  as Quarter ,
	str(D07.TranYear) as Year

From BT1002 as D07 WITH (NOLOCK) Left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (D07.DivisionID, '@@@') AND AT1202.ObjectID = D07.ObjectID
			inner join AT1302 as D02 WITH (NOLOCK) on D02.InventoryID = D07.InventoryID
			inner join AT1304 as D04 WITH (NOLOCK) on D04.UnitID = D02.UnitID
			inner join AT1303 as D03 WITH (NOLOCK) on D03.WareHouseID = D07.WareHouseID

Where D07.KindVoucherID in (1) and Isnull(D07.ReVoucherID,'') <> ''

Union All  -- xuat kho
Select  D07.DivisionID, D07.TranMonth, D07.TranYear,
	Case when D07.KindVoucherID = 3 then D07.WareHouseID2 Else  D07.WareHouseID End as WareHouseID, 
	D07.SeriNo, D07.InventoryID, 'C' as D_C,  --- So du Co
	D07.Notes, D07.VoucherID, D07.VoucherDate, D07.VoucherNo, 
	D07.ObjectID,AT1202.ObjectName, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	Case when D07.KindVoucherID = 3 then D031.WareHouseName Else  D03.WareHouseName End as WareHouseName,	
	Quantity, D02.S1, D02.S2, D02.S3, D02.S1 as CI1ID, D02.S2 as CI2ID, D02.S3 as CI3ID, 
	D07.VoucherTypeID, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D02.Notes01, D02.Notes02, D02.Notes03,
	isnull(D03.IsTemp,0) as IsTemp,
	(Case When  D07.TranMonth <10 then '0'+rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) 
	Else rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) End) as MonthYear,
	('0'+ ltrim(rtrim(Case when D07.TranMonth %3 = 0 then D07.TranMonth/3  Else D07.TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(D07.TranYear)))
	)  as Quarter ,
	str(D07.TranYear) as Year

From BT1002 as D07	WITH (NOLOCK) Left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (D07.DivisionID, '@@@') AND AT1202.ObjectID = D07.ObjectID
			inner join AT1302 as D02 WITH (NOLOCK) on D02.InventoryID = D07.InventoryID
			inner join AT1304 as D04 WITH (NOLOCK) on D04.UnitID = D02.UnitID
			inner join AT1303 as D03 WITH (NOLOCK) on D03.WareHouseID = D07.WareHouseID
			left join AT1303 as  D031 WITH (NOLOCK) on D031.WareHouseID = D07.WareHouseID2

Where D07.KindVoucherID in (2) and Isnull(D07.ReVoucherID,'') <> ''









  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
