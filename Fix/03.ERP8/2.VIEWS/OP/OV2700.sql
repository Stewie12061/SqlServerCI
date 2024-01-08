IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV2700]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV2700]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- (view chet) Loc ra cac don hang phuc vu cho cong tac bao cao Yeu cau mua hang	
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/04/2009 by Thuy Tuyen
---- 
--- Edited by Bao Anh	Date: 30/10/2012	Sua lai thanh tien = thanh tien + VAT - Chiet khau
---- Modified on 18/04/2013 by Le Thi Thu Hien : Bo sung Ana06--> Ana10
---- Modify on 03/05/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Khánh Đoan on 09/26/2019 Lây trường ConfirmUserID, ConfirmDate, ConfirmUserName
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Anh Đô on 25/11/2022 : Select thêm cột Ana01Name
---- Modified by Thành Sang on 08/03/2023 : Select thêm cột Notes, SuplierID, SuplierName
---- Modified by Kiều Nga on 30/03/2023 : Fix lỗi trùng dòng, lấy thêm cột NOTES01 
---- Modified by Thành Sang on 13/07/2023 : lấy thêm cột NOTES02

-- <Example>
----
 
CREATE VIEW [dbo].[OV2700] AS 
SELECT 
	Distinct
	OT3101.DivisionID,
	OT3101.TranMonth,
	OT3101.TranYear,	
	OT3101.TranYear AS Year,	  
	OV9999.MonthYear,
	OV9999.Quarter,
	OT3101.ROrderID AS OrderID, 	
	OT3101.VoucherTypeID, 
	OT3101.VoucherNo, 
	OT3101.OrderDate AS VoucherDate, 
	OT3101.ContractNo, 
	OT3101.ContractDate, 
	OT3101.ClassifyID, 
	OT3101.OrderType, 
	OT3101.ObjectID, 
	case when ISNULL(OT3101.ObjectName, '') = '' then  AT1202.ObjectName else OT3101.ObjectName end AS ObjectName,
	OT3101.ReceivedAddress, 
	OT3101.Description AS VDescription, 
	OT3101.OrderStatus, 	
	OT3101.CurrencyID, 
	AT1004.CurrencyName,
	OT3101.ExchangeRate, 
	OT3101.EmployeeID, 
	OT3101.Transport, 
	OT3101.PaymentID, 
	OT3101.VatNo, 
	OT3101.Address, 
	OT3101.ShipDate, 
	OT3101.Disabled, 
	ISNULL(OT3101.Ana01ID, '') AS VAna01ID, 		ISNULL(OT3101.Ana02ID, '') AS VAna02ID, 		ISNULL(OT3101.Ana03ID, '') AS VAna03ID, 	
	ISNULL(OT3101.Ana04ID, '') AS VAna04ID, 		ISNULL(OT3101.Ana05ID, '') AS VAna05ID,
	OT3102.TransactionID, 
	OT3102.InventoryID, 
	Isnull (OT3102.InventoryCommonName,AT1302.InventoryName) AS InventoryName  ,
	AT1302.Specification,
	at1302.InventoryTypeID,
	OT3102.OrderQuantity, 
	OT3102.RequestPrice, 
	ISNULL(OT3102.OriginalAmount,0) AS  OriginalAmount,
	ISNULL(OT3102.ConvertedAmount, 	0) AS ConvertedAmount,
	OT3102.VATPercent, 
	ISNULL(OT3102.VATOriginalAmount, 0) AS VATOriginalAmount,
	ISNULL(OT3102.VATConvertedAmount, 0) AS VATConvertedAmount,
	OT3102.DiscountPercent, 
	ISNULL(OT3102.DiscountOriginalAmount, 0)  AS DiscountOriginalAmount,
	ISNULL(OT3102.DiscountConvertedAmount, 0) AS DiscountConvertedAmount,
	
	(ISNULL(OT3102.OriginalAmount, 0) + ISNULL(OT3102.VATOriginalAmount, 0) - ISNULL(OT3102.DiscountOriginalAmount, 0)) AS TotalOriginalAmount,
	(ISNULL(OT3102.ConvertedAmount, 0) + ISNULL(OT3102.VATConvertedAmount, 0) - ISNULL(OT3102.DiscountConvertedAmount, 0)) AS TotalConvertedAmount,
	OT3102.Orders, 
	OT3102.Description AS TDescription,  
	ISNULL(OT3102.Ana01ID, '') AS Ana01ID, 		ISNULL(OT3102.Ana02ID, '') AS Ana02ID, 		
	ISNULL(OT3102.Ana03ID, '') AS Ana03ID, 		ISNULL(OT3102.Ana04ID, '') AS Ana04ID, 		
	ISNULL(OT3102.Ana05ID, '') AS Ana05ID,		ISNULL(OT3102.Ana06ID, '') AS Ana06ID,
	ISNULL(OT3102.Ana07ID, '') AS Ana07ID,		ISNULL(OT3102.Ana08ID, '') AS Ana08ID,
	ISNULL(OT3102.Ana09ID, '') AS Ana09ID,		ISNULL(OT3102.Ana10ID, '') AS Ana10ID,
	OT3102.InventoryCommonName, 
	OT3102.AdjustQuantity, 	
	AT1302.UnitID,	
	AT1304.UnitName,	
	ISNULL(AT1302.S1, '')  AS CI1ID,		ISNULL(AT1302.S2, '')  AS CI2ID, 		ISNULL(AT1302.S3, '') AS CI3ID,  
	ISNULL(AT1302.I01ID, '') AS I01ID, 		ISNULL(AT1302.I02ID, '') AS I02ID, 		ISNULL(AT1302.I03ID, '') AS I03ID,
	ISNULL( AT1302.I04ID, '') AS I04ID, 	ISNULL(AT1302.I05ID, '') AS I05ID,
	ISNULL(AT1202.S1, '')  AS CO1ID,		ISNULL(AT1202.S2, '') AS CO2ID, 		ISNULL(AT1202.S3, '') AS CO3ID,
	ISNULL(AT1202.O01ID, '') AS O01ID,		ISNULL(AT1202.O02ID, '') AS O02ID, 		
	ISNULL(AT1202.O03ID, '') AS O03ID,		ISNULL( AT1202.O04ID, '') AS O04ID,  	ISNULL(AT1202.O05ID, '') AS O05ID,
	OT3102.Finish,OT3101.ConfirmUserID,OT3101.ConfirmDate ,AT1405.UserName AS ConfirmUserName,
	o.ProjectName AS Ana01Name,
	A01.ObjectID as SuplierID,
	A01.ObjectName as SuplierName,
	OT3102.Notes, OT3102.Notes01, OT3102.Notes02
FROM OT3102 WITH (NOLOCK)
INNER JOIN OT3101 WITH (NOLOCK) on OT3101.ROrderID = OT3102.ROrderID And OT3102.DivisionID = OT3101.DivisionID
LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN ('@@@', OT3101.DivisionID) AND AT1302.InventoryID = OT3102.InventoryID
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (OT3102.DivisionID, '@@@') AND AT1202.ObjectID = OT3101.ObjectID
LEFT JOIN AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT3101.CurrencyID
LEFT JOIN AT1304 WITH (NOLOCK) on AT1302.UnitID = AT1304.UnitID
LEFT JOIN OV9999 on OT3101.TranMonth = OV9999.TranMonth and OT3101.TranYear = OV9999.TranYear and OT3101.DivisionID = OV9999.DivisionID
LEFT JOIN AT1405 WITH (NOLOCK) ON  AT1405.UserID = OT3101.ConfirmUserID
LEFT JOIN OOT2100 o WITH (NOLOCK) ON o.ProjectID = OT3102.Ana01ID
LEFT JOIN AT1202 A01 WITH (NOLOCK) on AT1202.DivisionID IN (OT3101.DivisionID, '@@@') AND A01.ObjectID = OT3101.ObjectID and A01.IsSupplier = 1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
