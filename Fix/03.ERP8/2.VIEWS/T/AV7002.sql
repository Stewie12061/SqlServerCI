IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7002]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- View chet. Xu ly so du hang ton kho theo quy cách.
---- Create on 05/11/2015 by Tiểu Mai
---- Giống view AV7000
--- Modify on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
---- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Kim Thư on 16/11/2018: Thêm cột OrderID - lưu số đơn hàng (Lên báo cáo cho Mạnh Phương)
---- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

---- Example: select top 1  * from AV7002

CREATE VIEW [dbo].[AV7002] AS 
--- So du No cua tai khoan ton kho
SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	'BD' AS D_C,  --- So du No
	'' AS RefNo01, '' AS RefNo02, 	D17.Notes,
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
	D16.ObjectID,AT1202.ObjectName,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID, D02.VATPercent,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedQuantity, 
	ConvertedAmount,
	0 as OExpenseConvertedAmount,
	ActualQuantity AS SignQuantity, 
	ConvertedQuantity AS SignConvertedQuantity, 
	ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3 ,
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
	D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
	D16.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,
	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification, 
	D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,D02.SalePrice01,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 
	isnull(D03.IsTemp,0) AS IsTemp, D03.FullName [WHFullName],
	0 AS 	 KindVoucherID,
	(CASE WHEN  D17.TranMonth <10 then '0'+rtrim(ltrim(str(D17.TranMonth)))+'/'+ltrim(Rtrim(str(D17.TranYear))) 
	Else rtrim(ltrim(str(D17.TranMonth)))+'/'+ltrim(Rtrim(str(D17.TranYear))) End) AS MonthYear,
	('0'+ ltrim(rtrim(CASE WHEN D17.TranMonth %3 = 0 then D17.TranMonth/3  Else D17.TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(D17.TranYear)))
	)  AS Quarter ,
	str(D17.TranYear) AS Year,D17.SourceNo,
	D17.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
    ,NULL AS ProductID, NULL AS MOrderID, NULL AS ProductName,
    D02.Barcode,D16.Description AS VoucherDesc,
    D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name, 
	D17.Notes01, D17.Notes02, D17.Notes03, D17.Notes04, D17.Notes05, D17.Notes06, D17.Notes07, D17.Notes08,
	D17.Notes09, D17.Notes10, D17.Notes11, D17.Notes12, D17.Notes13, D17.Notes14, D17.Notes15, D17.MarkQuantity, D17.MarkQuantity as SignMarkQuantity,
	A08.Notes as Ana08Notes, D17.DebitAccountID as InventoryAccountID, WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID, D16.OrderID
    
From AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D17.DivisionID AND WT8899.VoucherID = D17.VoucherID AND WT8899.TransactionID = D17.TransactionID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D17.DivisionID, '@@@') AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,'@@@') AND D02.InventoryID = D17.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (D17.DivisionID,'@@@') AND D03.WareHouseID = D16.WareHouseID
LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = 'I01' AND S1.S = D02.S1
LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = 'I02' AND S2.S = D02.S2
LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = 'I03' AND S3.S = D02.S3
LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = 'I01' AND I1.AnaID = D02.I01ID
LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = 'I02' AND I2.AnaID = D02.I02ID
LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = 'I03' AND I3.AnaID = D02.I03ID
LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = 'I04' AND I4.AnaID = D02.I04ID
LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = 'I05' AND I5.AnaID = D02.I05ID
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = 'A01' AND A01.AnaID = D17.Ana01ID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = 'A02' AND A02.AnaID = D17.Ana02ID
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = 'A03' AND A03.AnaID = D17.Ana03ID
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = 'A04' AND A04.AnaID = D17.Ana04ID
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = 'A05' AND A05.AnaID = D17.Ana05ID
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = 'A06' AND A06.AnaID = D17.Ana06ID
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = 'A07' AND A07.AnaID = D17.Ana07ID
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = 'A08' AND A08.AnaID = D17.Ana08ID
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = 'A09' AND A09.AnaID = D17.Ana09ID
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = 'A10' AND A10.AnaID = D17.Ana10ID

Where isnull(DebitAccountID,'') <>''

UNION ALL --- So du co hang ton kho

SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	'BC' AS D_C,  --- So du Co
	'' AS RefNo01, '' AS RefNo02, 	D17.Notes,
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
	D16.ObjectID,AT1202.ObjectName, 	
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedQuantity, 
	ConvertedAmount,
	0 AS OExpenseConvertedAmount,
	-ActualQuantity AS SignQuantity, 
		-ConvertedQuantity AS SignConvertedQuantity, 
	-ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3 ,
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
	D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
	D16.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,

	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,D02.SalePrice01,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 
	isnull(D03.IsTemp,0) AS IsTemp, D03.FullName [WHFullName],
	0 AS KindVoucherID,
	(CASE WHEN  D17.TranMonth <10 then '0'+rtrim(ltrim(str(D17.TranMonth)))+'/'+ltrim(Rtrim(str(D17.TranYear))) 
	Else rtrim(ltrim(str(D17.TranMonth)))+'/'+ltrim(Rtrim(str(D17.TranYear))) End) AS MonthYear,
	('0'+ ltrim(rtrim(CASE WHEN D17.TranMonth %3 = 0 then D17.TranMonth/3  Else D17.TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(D17.TranYear)))
	)  AS Quarter ,
	str(D17.TranYear) AS Year, D17.SourceNo,
	D17.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
	,NULL AS ProductID, NULL AS MOrderID, NULL AS ProductName,
	D02.Barcode,D16.Description AS VoucherDesc,
    D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
	D17.Notes01, D17.Notes02, D17.Notes03, D17.Notes04, D17.Notes05, D17.Notes06, D17.Notes07, D17.Notes08,
	D17.Notes09, D17.Notes10, D17.Notes11, D17.Notes12, D17.Notes13, D17.Notes14, D17.Notes15, D17.MarkQuantity, -D17.MarkQuantity as SignMarkQuantity,
	A08.Notes as Ana08Notes, D17.CreditAccountID as InventoryAccountID, WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID, D16.OrderID
    
	
FROM AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID 
LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D17.DivisionID AND WT8899.VoucherID = D17.VoucherID AND WT8899.TransactionID = D17.TransactionID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D17.DivisionID, '@@@') AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,'@@@') AND D02.InventoryID = D17.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (D17.DivisionID,'@@@') AND D03.WareHouseID = D16.WareHouseID
LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = 'I01' AND S1.S = D02.S1
LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = 'I02' AND S2.S = D02.S2
LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = 'I03' AND S3.S = D02.S3
LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = 'I01' AND I1.AnaID = D02.I01ID 
LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = 'I02' AND I2.AnaID = D02.I02ID 
LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = 'I03' AND I3.AnaID = D02.I03ID 
LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = 'I04' AND I4.AnaID = D02.I04ID 
LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = 'I05' AND I5.AnaID = D02.I05ID 
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = 'A01' AND A01.AnaID = D17.Ana01ID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = 'A02' AND A02.AnaID = D17.Ana02ID
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = 'A03' AND A03.AnaID = D17.Ana03ID
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = 'A04' AND A04.AnaID = D17.Ana04ID
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = 'A05' AND A05.AnaID = D17.Ana05ID
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = 'A06' AND A06.AnaID = D17.Ana06ID
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = 'A07' AND A07.AnaID = D17.Ana07ID
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = 'A08' AND A08.AnaID = D17.Ana08ID
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = 'A09' AND A09.AnaID = D17.Ana09ID
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = 'A10' AND A10.AnaID = D17.Ana10ID

WHERE ISNULL(CreditAccountID,'') <>''

UNION ALL  -- Nhap kho

SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear,
	D06.WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	'D' AS D_C,  --- Phat sinh No
	RefNo01 AS RefNo01, RefNo02, 	D07.Notes,
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
	D06.ObjectID,AT1202.ObjectName,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedQuantity, 
	ConvertedAmount,
	isnull(OExpenseConvertedAmount,0) as OExpenseConvertedAmount,
	ActualQuantity AS SignQuantity, 
		ConvertedQuantity AS SignConvertedQuantity, 
	ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3, 
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
	D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
	D06.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,
	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,D02.SalePrice01,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 

	isnull(D03.IsTemp,0) AS IsTemp, D03.FullName [WHFullName],
	CASE WHEN  KindVoucherID = 3 then 3 else 0 end AS KindVoucherID,
	(CASE WHEN  D07.TranMonth <10 then '0'+rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) 
	Else rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) End) AS MonthYear,
	('0'+ ltrim(rtrim(CASE WHEN D07.TranMonth %3 = 0 then D07.TranMonth/3  Else D07.TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(D07.TranYear)))
	)  AS Quarter ,
	str(D07.TranYear) AS Year, D07.SourceNo,
	D07.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
    ,D07.ProductID, D07.MOrderID, P02.InventoryName AS ProductName,
    D02.Barcode,D06.Description AS VoucherDesc,
    D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
	D07.Notes01, D07.Notes02, D07.Notes03, D07.Notes04, D07.Notes05, D07.Notes06, D07.Notes07, D07.Notes08,
	D07.Notes09, D07.Notes10, D07.Notes11, D07.Notes12, D07.Notes13, D07.Notes14, D07.Notes15, D07.MarkQuantity, D07.MarkQuantity as SignMarkQuantity,
	A08.Notes as Ana08Notes, D07.DebitAccountID as InventoryAccountID, WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID, D06.OrderID
    
    
FROM AT2007 AS D07  WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D07.DivisionID AND WT8899.VoucherID = D07.VoucherID AND WT8899.TransactionID = D07.TransactionID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D07.DivisionID, '@@@') AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,'@@@') AND D02.InventoryID = D07.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (D07.DivisionID,'@@@') AND D03.WareHouseID = D06.WareHouseID
LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.DivisionID IN (D07.DivisionID,'@@@') AND P02.InventoryID = D07.ProductID
LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = 'I01' AND S1.S = D02.S1 
LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = 'I02' AND S2.S = D02.S2 
LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = 'I03' AND S3.S = D02.S3
LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = 'I01' AND I1.AnaID = D02.I01ID
LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = 'I02' AND I2.AnaID = D02.I02ID
LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = 'I03' AND I3.AnaID = D02.I03ID
LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = 'I04' AND I4.AnaID = D02.I04ID
LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = 'I05' AND I5.AnaID = D02.I05ID
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = 'A01' AND A01.AnaID = D07.Ana01ID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = 'A02' AND A02.AnaID = D07.Ana02ID
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = 'A03' AND A03.AnaID = D07.Ana03ID
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = 'A04' AND A04.AnaID = D07.Ana04ID
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = 'A05' AND A05.AnaID = D07.Ana05ID
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = 'A06' AND A06.AnaID = D07.Ana06ID
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = 'A07' AND A07.AnaID = D07.Ana07ID
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = 'A08' AND A08.AnaID = D07.Ana08ID
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = 'A09' AND A09.AnaID = D07.Ana09ID
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = 'A10' AND A10.AnaID = D07.Ana10ID

WHERE D06.KindVoucherID in (1,3,5,7,9,15,17)

UNION ALL  -- xuat kho

SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear,
	CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	'C' AS D_C,  --- So du Co
	RefNo01 AS RefNo01, RefNo02, 	D07.Notes,
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
	D06.ObjectID,AT1202.ObjectName, 	
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	CASE WHEN D06.KindVoucherID = 3 then D031.WareHouseName Else  D03.WareHouseName End  AS WareHouseName,	
	ActualQuantity, 
	ConvertedQuantity, 
	ConvertedAmount,
	isnull(OExpenseConvertedAmount,0) as OExpenseConvertedAmount,
	-ActualQuantity AS SignQuantity, 
		-ConvertedQuantity AS SignConvertedQuantity, 
	-ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3, 
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
	D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
	D06.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,
	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,D02.SalePrice01,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 
	isnull(D03.IsTemp,0) AS IsTemp, D03.FullName [WHFullName],
	CASE WHEN  KindVoucherID = 3 then 3 else 0 end AS KindVoucherID,
	(CASE WHEN  D07.TranMonth <10 then '0'+rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) 
	Else rtrim(ltrim(str(D07.TranMonth)))+'/'+ltrim(Rtrim(str(D07.TranYear))) End) AS MonthYear,
	('0'+ ltrim(rtrim(CASE WHEN D07.TranMonth %3 = 0 then D07.TranMonth/3  Else D07.TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(D07.TranYear)))
	)  AS Quarter ,
	str(D07.TranYear) AS Year, D07.SourceNo,
	D07.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
	,D07.ProductID, D07.MOrderID, P02.InventoryName AS ProductName,
	D02.Barcode,D06.Description AS VoucherDesc,
	D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
	D07.Notes01, D07.Notes02, D07.Notes03, D07.Notes04, D07.Notes05, D07.Notes06, D07.Notes07, D07.Notes08,
	D07.Notes09, D07.Notes10, D07.Notes11, D07.Notes12, D07.Notes13, D07.Notes14, D07.Notes15, D07.MarkQuantity, -D07.MarkQuantity as SignMarkQuantity,
	A08.Notes as Ana08Notes, D07.CreditAccountID as InventoryAccountID, WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID, D06.OrderID
From AT2007 AS D07  WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D07.DivisionID AND WT8899.VoucherID = D07.VoucherID AND WT8899.TransactionID = D07.TransactionID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D07.DivisionID, '@@@') AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,'@@@') AND D02.InventoryID = D07.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (D07.DivisionID,'@@@') AND D03.WareHouseID = D06.WareHouseID
LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.DivisionID IN (D07.DivisionID,'@@@') AND P02.InventoryID = D07.ProductID
LEFT JOIN AT1303 AS  D031 WITH (NOLOCK) ON D031.DivisionID IN (D07.DivisionID,'@@@') AND D031.WareHouseID = D06.WareHouseID2
LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = 'I01' AND S1.S = D02.S1
LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = 'I02' AND S2.S = D02.S2
LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = 'I03' AND S3.S = D02.S3
LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = 'I01' AND I1.AnaID = D02.I01ID
LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = 'I02' AND I2.AnaID = D02.I02ID
LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = 'I03' AND I3.AnaID = D02.I03ID
LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = 'I04' AND I4.AnaID = D02.I04ID
LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = 'I05' AND I5.AnaID = D02.I05ID
LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = 'A01' AND A01.AnaID = D07.Ana01ID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = 'A02' AND A02.AnaID = D07.Ana02ID
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = 'A03' AND A03.AnaID = D07.Ana03ID
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = 'A04' AND A04.AnaID = D07.Ana04ID
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = 'A05' AND A05.AnaID = D07.Ana05ID
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = 'A06' AND A06.AnaID = D07.Ana06ID
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = 'A07' AND A07.AnaID = D07.Ana07ID
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = 'A08' AND A08.AnaID = D07.Ana08ID
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = 'A09' AND A09.AnaID = D07.Ana09ID
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = 'A10' AND A10.AnaID = D07.Ana10ID
Where D06.KindVoucherID in (2,3,4,6,8,10,14,20)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON