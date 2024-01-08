IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV2300]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV2300]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- (view chet) Loc ra cac don hang phuc vu cho cong tac bao cao	
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 05/07/2005 by Vo Thanh Huong
---- 
---- Modified on 12/11/2009 by Thuy Tuyen : Lay ten ma phan tich cua don hang ban, lay cac truong theo don vi tinh qui doi, so luong, don gia qui doi
---- Modified on 11/02/2010 by Thuy Tuyen : Them truong FOrderQuantity
---- Modified on 10/05/2010 by Thuy Tuyen : Them cac truong m aphan tich nghiep vu
---- Modified on 23/09/2011 by Le Thi Thu Hien : Bo sung SalesMan2
---- Modified on 03/10/2011 by Le Thi Thu Hien : Bo sung check FirstOrder de biet don hang la don hang dau tien cua khach hang do
---- Modified on 07/11/2011 by Thien Huynh: Bo sung PeriodID, PeriodName
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung ActualQuantity( So luong xuat kho theo bo Khach hang EUROVIE)
---- Modified on 06/09/2012 by Bao Anh : Bo sung tham so Parameter01 -> 05
---- Modified on 30/01/2013 by Le Thi Thu Hien : Bo sung tham so Nvarchar01->nvarchar10
---- Modified on 17/04/2013 by Le Thi Thu Hien : Bo sung Ana06 -->Ana10
---- Modified on 02/03/2014 by Le Thi Thu Hien : Bo sung CreateUserID
---- Modified on 02/10/2014 by Thanh Sơn: Bổ sung thêm 5 mã phân tích nghiệp vụ (Name)
---- Modified on 02/10/2014 by Thanh Sơn: Lấy thêm trường tên kho cho APSG
---- Modified on 25/05/2015 by Lê Thị Hạnh: Bổ sung AT1302.ETaxConvertedUnit (Customize Index: 36 - SGPT)
---- Modified on 09/09/2015 by Tiểu Mai: Bổ sung mã, tên MPT Ana06-->Ana10
---- Modified on 10/12/2015 by Kim Vu: Bổ sung Varchar01 - Varchar10 as nvarchar10 -> nvarchar20 ( ABA)
---- Modified on 11/01/2016 by Quôc Tuấn: Bố sung từ S01ID -> S20ID
---- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Hoàng Vũ on 14/06/2017: bổ sung lấy thêm thông tin đơn vị, phục vụ xem báo cáo nhiều DivisionID, Bổ sung With Nolock
---- Modified by Bảo Thy on 12/09/2017: bổ sung ObjectAddress 
---- Modified on 05/10/2017 by Hải Long: Bố sung từ tên 20 quy cách
---- Modified by Khả Vi on 07/11/2017: Bồ sung trường giá bán: SalePrice01 --> SalePrice05, CO2Name
---- Modified on 23/02/2018 by Bảo Anh : Bổ sung cột PaymentName
---- Modified on 06/03/2018 by Bảo Anh: Bổ sung I06ID -> I10ID, I01Name -> I10Name, CityID, CityName, O02Name, O03Name
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhật Thanh on 28/09/2020 : Lấy dealerID cho trường hợp sellout
---- Modified on 30/09/2022 by Hoài Bảo : Bổ sung load cột DiscountAmount
---- Modified on 05/01/2022 by Phương Thảo : Bổ sung load cột DiscountSaleAmountDetail,IsProInventoryID  ,,
---- Modified on 11/01/2022 [2023/01/IS/0033] by Phương Thảo : Điều chỉnh lấy ObjectID, ưu tiên lấy ObjectID trước DealerID
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
----
 
CREATE VIEW [dbo].[OV2300] AS 
SELECT	OT2001.DivisionID, AT1101.DivisionName,
		OT2001.TranMonth,
		OT2001.TranYear,	
		OT2001.TranYear AS Year,	  
		OV9999.MonthYear,
		OV9999.Quarter,
		OT2001.SOrderID AS OrderID, 	
		OT2001.VoucherTypeID, 
		OT2001.VoucherNo, 
		OT2001.OrderDate AS VoucherDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate, 
		OT2001.ClassifyID, 
		OT2001.OrderType,
		ISNULL(OT2001.ObjectID,OT2001.DealerID) as ObjectID,
		case when ISNULL(OT2001.ObjectName, '') = '' then  AT1202.ObjectName else OT2001.ObjectName end AS ObjectName,
		OT2001.DeliveryAddress, 
		OT2001.Notes AS VDescription, 
		OT2001.OrderStatus, 	
		OT2001.CurrencyID, 
		AT1004.CurrencyName,
		OT2001.ExchangeRate, 
		OT2001.EmployeeID, 
		OT2001.SalesManID, 
		AT1103.FullName AS SalesManName,
		OT2001.SalesMan2ID, 
		AT1103_S2.FullName AS SalesMan2Name,
		AT1103_S3.FullName AS FullName,
		OT2001.Transport, 
		OT2001.PaymentID, 
		OT2001.VatNo, 
		OT2001.Address, 
		OT2001.ShipDate, 
		OT2001.Notes AS Description,
		OT2001.PaymentTermID,
		OT2001.Disabled, 
		ISNULL(OT2001.Ana01ID, '') AS VAna01ID, 		ISNULL(OT2001.Ana02ID, '') AS VAna02ID,
		ISNULL(OT2001.Ana03ID, '') AS VAna03ID, 		ISNULL(OT2001.Ana04ID, '') AS VAna04ID,
		ISNULL(OT2001.Ana05ID, '') AS VAna05ID,			ISNULL(OT2001.Ana06ID, '') AS VAna06ID,
		ISNULL(OT2001.Ana07ID, '') AS VAna07ID,			ISNULL(OT2001.Ana08ID, '') AS VAna08ID,
		ISNULL(OT2001.Ana09ID, '') AS VAna09ID,			ISNULL(OT2001.Ana10ID, '') AS VAna10ID,
		ISNULL(T01.AnaName, '') AS VAna01Name, 			ISNULL(T02.AnaName, '') AS VAna02Name, 		
		ISNULL(T03.AnaName, '') AS VAna03name, 	
		ISNULL(T03.AnaName, '') AS VAna04Name, 			ISNULL(T05.AnaName, '') AS VAna05Name,
		OT2002.IsProInventoryID, 
		OT2002.DiscountSaleAmountDetail, 
		OT2002.TransactionID, 
		OT2002.InventoryID,	AT1302.InventoryName,
		OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
		AT1310_S1.SName AS SName1, 
		AT1310_S2.SName AS SName2,
		AT1302.Notes01 AS InNotes01,
		AT1302.Notes02 AS InNotes02,
		AT1302.InventoryTypeID,
		AT1302.Specification,
		OT2001.QuotationID,
		OT2001.Contact,
		OT2002.RefInfor,
		OT2002.MethodID, 
		OT2002.OrderQuantity, --So luong tren don hang
		AT2027.ActualQuantity, -- So luong xuat kho theo bo
		CASE WHEN OrderType = 0 THEN   ---neu la don hang ban
			Case when Finish = 0 then OT2002.OrderQuantity else 0 end
		else
			OT2002.OrderQuantity   
		end AS FOrderQuantity,
		OT2002.SalePrice, 
		OT2002.LinkNo,
		ISNULL(OT2002.OriginalAmount,0) AS  OriginalAmount,
		ISNULL(OT2002.ConvertedAmount, 	0) AS ConvertedAmount,
		OT2002.VATPercent, 
		ISNULL(OT2002.VATOriginalAmount, 0) AS VATOriginalAmount,
		ISNULL(OT2002.VATConvertedAmount, 0) AS VATConvertedAmount,
		OT2002.DiscountPercent, 
		ISNULL(OT2002.DiscountOriginalAmount, 0)  AS DiscountOriginalAmount,
		ISNULL(OT2002.DiscountConvertedAmount, 0) AS DiscountConvertedAmount,
		ISNULL(OT2002.DiscountAmount, 0) AS DiscountAmount,
		OT2002.CommissionPercent, 
		ISNULL(OT2002.CommissionOAmount, 0) AS CommissionOAmount, 
		ISNULL(OT2002.CommissionCAmount,0) AS  CommissionCAmount,
		OT2002.IsPicking, 
		OT2002.WareHouseID, A03.WareHouseName,
		(ISNULL(OT2002.OriginalAmount, 0) + ISNULL(OT2002.VATOriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountAmount, 0) - ISNULL(OT2002.CommissionOAmount, 0)) AS TotalOriginalAmount,
		(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0) - (ISNULL(OT2002.DiscountAmount, 0) * ISNULL(OT2001.ExchangeRate, 0)) - ISNULL(OT2002.CommissionCAmount,0)) AS TotalConvertedAmount,
		OT2002.Orders, 
		OT2002.Description AS TDescription,  	
		ISNULL(OT2002.Ana01ID, '') AS Ana01ID, 		ISNULL(OT2002.Ana02ID, '') AS Ana02ID, 		
		ISNULL(OT2002.Ana03ID, '') AS Ana03ID, 		ISNULL(OT2002.Ana04ID, '') AS Ana04ID, 		
		ISNULL(OT2002.Ana05ID, '') AS Ana05ID,		ISNULL(OT2002.Ana06ID, '') AS Ana06ID,
		ISNULL(OT2002.Ana07ID, '') AS Ana07ID,		ISNULL(OT2002.Ana08ID, '') AS Ana08ID,
		ISNULL(OT2002.Ana09ID, '') AS Ana09ID,		ISNULL(OT2002.Ana10ID, '') AS Ana10ID,
		OT2002.InventoryCommonName, 
		OT2002.AdjustQuantity, 	
		AT1302.UnitID,	
		AT1304.UnitName,
		ISNULL(AT1302.S1, '')  AS CI1ID,	ISNULL(AT1302.S2, '')  AS CI2ID, 	ISNULL(AT1302.S3, '') AS CI3ID,  
		ISNULL(AT1302.I01ID, '') AS I01ID, 	ISNULL(AT1302.I02ID, '') AS I02ID, 	ISNULL(AT1302.I03ID, '') AS I03ID,
		ISNULL(AT1302.I04ID, '') AS I04ID, 	ISNULL(AT1302.I05ID, '') AS I05ID,	ISNULL(AT1302.I06ID, '') AS I06ID,
		ISNULL(AT1302.I07ID, '') AS I07ID,	ISNULL(AT1302.I08ID, '') AS I08ID,	ISNULL(AT1302.I09ID, '') AS I09ID,	ISNULL(AT1302.I10ID, '') AS I10ID,
		ISNULL(AT51.AnaName, '') AS I01Name, ISNULL(AT52.AnaName, '') AS I02Name, ISNULL(AT53.AnaName, '') AS I03Name, ISNULL(AT54.AnaName, '') AS I04Name, ISNULL(AT55.AnaName, '') AS I05Name,
		ISNULL(AT56.AnaName, '') AS I06Name, ISNULL(AT57.AnaName, '') AS I07Name, ISNULL(AT58.AnaName, '') AS I08Name, ISNULL(AT59.AnaName, '') AS I09Name, ISNULL(AT50.AnaName, '') AS I10Name,
		ISNULL(AT1202.S1, '')  AS CO1ID,	ISNULL(AT1202.S2, '') AS CO2ID, 	ISNULL(AT1202.S3, '') AS CO3ID,
		ISNULL(AT1202.O01ID, '') AS O01ID,  ISNULL(AT1202.O02ID, '') AS O02ID, 		
		ISNULL(AT1202.O03ID, '') AS O03ID,	ISNULL( AT1202.O04ID, '') AS O04ID,  ISNULL(AT1202.O05ID, '') AS O05ID,
		OV1001.Description AS StatusName,
		OT2002.Notes , OT2002.Notes01 , OT2002.Notes02,
		OT2002.SaleOffPercent01,		OT2002.SaleOffAmount01,
		OT2002.SaleOffPercent02,		OT2002.SaleOffAmount02,
		OT2002.SaleOffPercent03,		OT2002.SaleOffAmount03,
		OT2002.SaleOffPercent04,		OT2002.SaleOffAmount04,
		OT2002.SaleOffPercent05,		OT2002.SaleOffAmount05,
		OT2002.UnitID AS ConversionUnitID, 
		AV1319.ConversionFactor,
		AV1319.UnitName AS ConversionUnitName,
		OT2002.ConvertedQuantity,
		OT2002.ConvertedSalePrice,
		OT2002.Finish,
		OT2001.Varchar01,OT2001.Varchar02,OT2001.Varchar03,OT2001.Varchar04,OT2001.Varchar05,
        OT2001.Varchar06,OT2001.Varchar07,OT2001.Varchar08,OT2001.Varchar09,OT2001.Varchar10,
        OT2001.Varchar11,OT2001.Varchar12,OT2001.Varchar13,OT2001.Varchar14,OT2001.Varchar15,
        OT2001.Varchar16,OT2001.Varchar17,OT2001.Varchar18,OT2001.Varchar19,OT2001.Varchar20,
		AT01.AnaName AS AnaName01, AT02.AnaName AS AnaName02,AT03.AnaName AS AnaName03,
		AT04.AnaName AS AnaName04, AT05.AnaName AS AnaName05,AT06.AnaName AS AnaName06,
		AT07.AnaName AS AnaName07, AT08.AnaName AS AnaName08,AT09.AnaName AS AnaName09, AT10.AnaName AS AnaName10,
		CASE WHEN (	SELECT TOP 1 1 FROM OT2001 CO WITH (NOLOCK)
					WHERE	CO.DivisionID = OT2001.DivisionID AND CO.OrderType = OT2001.OrderType
							AND CO.ObjectID = OT2001.ObjectID AND CO.OrderDate < OT2001.OrderDate) IS NOT NULL THEN 0 ELSE 1 END AS FirstOrder,
		MT1601.PeriodID, MT1601.[Description] AS PeriodName,
		OT2002.nvarchar01,OT2002.nvarchar02,OT2002.nvarchar03,OT2002.nvarchar04,OT2002.nvarchar05,
		OT2002.nvarchar06,OT2002.nvarchar07,OT2002.nvarchar08,OT2002.nvarchar09,OT2002.nvarchar10,
		OT2002.Varchar01 as nvarchar11, OT2002.Varchar02 as nvarchar12, OT2002.Varchar03 as nvarchar13,
		OT2002.Varchar04 as nvarchar14, OT2002.Varchar05 as nvarchar15, OT2002.Varchar06 as nvarchar16,
		OT2002.Varchar07 as nvarchar17, OT2002.Varchar08 as nvarchar18, OT2002.Varchar09 as nvarchar19,
		OT2002.Varchar10 as nvarchar20,
		OT2001.CreateUserID, ISNULL(AT1302.ETaxConvertedUnit,0) AS ETaxConvertedUnit, AT1301.InventoryTypeName,	
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		AT01_A.StandardName S01Name, AT02_A.StandardName S02Name, AT03_A.StandardName S03Name, AT04_A.StandardName S04Name, AT05_A.StandardName S05Name,
		AT06_A.StandardName S06Name, AT07_A.StandardName S07Name, AT08_A.StandardName S08Name, AT09_A.StandardName S09Name, AT10_A.StandardName S10Name,
		AT11_A.StandardName S11Name, AT12_A.StandardName S12Name, AT13_A.StandardName S13Name, AT14_A.StandardName S14Name, AT15_A.StandardName S15Name,
		AT16_A.StandardName S16Name, AT17_A.StandardName S17Name, AT18_A.StandardName S18Name, AT19_A.StandardName S19Name, AT20_A.StandardName S20Name,		
		OT2002.Quantity01, OT2002.Quantity02, OT2002.Quantity03, OT2002.Quantity04, OT2002.Quantity05, OT2002.Quantity06, OT2002.Quantity07, OT2002.Quantity08, OT2002.Quantity09, OT2002.Quantity10,
		OT2002.Quantity11, OT2002.Quantity12, OT2002.Quantity13, OT2002.Quantity14, OT2002.Quantity15, OT2002.Quantity16, OT2002.Quantity17, OT2002.Quantity18, OT2002.Quantity19, OT2002.Quantity20,
		OT2002.Quantity21, OT2002.Quantity22, OT2002.Quantity23, OT2002.Quantity24, OT2002.Quantity25, OT2002.Quantity26, OT2002.Quantity27, OT2002.Quantity28, OT2002.Quantity29, OT2002.Quantity30,
		OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP, AT1302.S2,
		AT1202.[Address] AS ObjectAddress, AT1302.SalePrice01, AT1302.SalePrice02, AT1302.SalePrice03, AT1302.SalePrice04, 
		AT1302.SalePrice05, AT1207.SName AS CO2Name, AT1205.PaymentName, AT1202.CityID, AT1002.CityName, AT61.AnaName as O02Name, AT62.AnaName as O03Name,AT63.AnaName as O01Name,AT64.AnaName as O04Name,
		AT65.AnaName as O05Name,AT1202.Tel,AT1202.Email
From	OT2002 WITH (NOLOCK) Left join AT1101 WITH (NOLOCK) on OT2002.DivisionID = AT1101.DivisionID
LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('@@@', OT2002.DivisionID) AND A03.WareHouseID = OT2002.WareHouseID
INNER JOIN OT2001 WITH (NOLOCK) on OT2001.DivisionID = OT2002.DivisionID    and OT2001.SOrderID = OT2002.SOrderID 
LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID 
LEFT JOIN AT1301  WITH (NOLOCK) on AT1302.InventoryTypeID = AT1301.InventoryTypeID
LEFT JOIN AT1310 AT1310_S1  WITH (NOLOCK) on AT1310_S1.STypeID= 'I01' and AT1310_S1.S = AT1302.S1 
LEFT JOIN AT1310 AT1310_S2  WITH (NOLOCK) on AT1310_S2.STypeID= 'I02' and AT1310_S2.S = AT1302.S2 
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (OT2002.DivisionID, '@@@') AND AT1202.ObjectID = OT2001.ObjectID
LEFT JOIN AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT2001.CurrencyID
LEFT JOIN AT1304 WITH (NOLOCK) on AT1302.UnitID = AT1304.UnitID
LEFT JOIN OV9999 on OV9999.DivisionID = OT2002.DivisionID and OT2001.TranMonth = OV9999.TranMonth and OT2001.TranYear = OV9999.TranYear
LEFT JOIN OV1001 on OV1001.DivisionID = OT2002.DivisionID and OV1001.TypeID = 'SO' and OV1001.OrderStatus = OT2001.OrderStatus
LEFT JOIN AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT2001.SalesManID
LEFT JOIN AT1103 AT1103_S3 WITH (NOLOCK) on AT1103_S3.EmployeeID = OT2001.EmployeeID
LEFT JOIN AT1103 AT1103_S2 WITH (NOLOCK) on AT1103.EmployeeID = OT2001.SalesMan2ID
LEFT JOIN OT1002 T01 WITH (NOLOCK) on T01.DivisionID = OT2002.DivisionID and T01.AnaID = OT2001.Ana01ID and T01.AnaTypeID ='S01'
LEFT JOIN OT1002 T02 WITH (NOLOCK) on T02.DivisionID = OT2002.DivisionID and T02.AnaID = OT2001.Ana02ID and T02.AnaTypeID ='S02'
LEFT JOIN OT1002 T03 WITH (NOLOCK) on T03.DivisionID = OT2002.DivisionID and T03.AnaID = OT2001.Ana03ID and  T03.AnaTypeID ='S03'
LEFT JOIN OT1002 T04 WITH (NOLOCK) on T04.DivisionID = OT2002.DivisionID and T04.AnaID = OT2001.Ana04ID and T04.AnaTypeID ='S04'
LEFT JOIN OT1002 T05 WITH (NOLOCK) on T05.DivisionID = OT2002.DivisionID and T05.AnaID = OT2001.Ana05ID and  T05.AnaTypeID ='S05'
LEFT JOIN AT1011 AT01 WITH (NOLOCK) on AT01.AnaID = OT2002.Ana01ID and AT01.AnaTypeID ='A01'
LEFT JOIN AT1011 AT02 WITH (NOLOCK) on AT02.AnaID = OT2002.Ana02ID and AT02.AnaTypeID ='A02'
LEFT JOIN AT1011 AT03 WITH (NOLOCK) on AT03.AnaID = OT2002.Ana03ID and AT03.AnaTypeID ='A03'
LEFT JOIN AT1011 AT04 WITH (NOLOCK) on AT04.AnaID = OT2002.Ana04ID and AT04.AnaTypeID ='A04'
LEFT JOIN AT1011 AT05 WITH (NOLOCK) on AT05.AnaID = OT2002.Ana05ID and AT05.AnaTypeID ='A05'
LEFT JOIN AT1011 AT06 WITH (NOLOCK) on AT06.AnaID = OT2002.Ana06ID and AT06.AnaTypeID ='A06'
LEFT JOIN AT1011 AT07 WITH (NOLOCK) on AT07.AnaID = OT2002.Ana07ID and AT07.AnaTypeID ='A07'
LEFT JOIN AT1011 AT08 WITH (NOLOCK) on AT08.AnaID = OT2002.Ana08ID and AT08.AnaTypeID ='A08'
LEFT JOIN AT1011 AT09 WITH (NOLOCK) on AT09.AnaID = OT2002.Ana09ID and AT09.AnaTypeID ='A09'
LEFT JOIN AT1011 AT10 WITH (NOLOCK) on AT10.AnaID = OT2002.Ana10ID and AT10.AnaTypeID ='A10'
LEFT JOIN AT0128 AT01_A WITH (NOLOCK) ON AT01_A.StandardID = O99.S01ID AND AT01_A.StandardTypeID = 'S01'
LEFT JOIN AT0128 AT02_A WITH (NOLOCK) ON AT02_A.StandardID = O99.S02ID AND AT02_A.StandardTypeID = 'S02'
LEFT JOIN AT0128 AT03_A WITH (NOLOCK) ON AT03_A.StandardID = O99.S03ID AND AT03_A.StandardTypeID = 'S03'
LEFT JOIN AT0128 AT04_A WITH (NOLOCK) ON AT04_A.StandardID = O99.S04ID AND AT04_A.StandardTypeID = 'S04'
LEFT JOIN AT0128 AT05_A WITH (NOLOCK) ON AT05_A.StandardID = O99.S05ID AND AT05_A.StandardTypeID = 'S05'
LEFT JOIN AT0128 AT06_A WITH (NOLOCK) ON AT06_A.StandardID = O99.S06ID AND AT06_A.StandardTypeID = 'S06'
LEFT JOIN AT0128 AT07_A WITH (NOLOCK) ON AT07_A.StandardID = O99.S07ID AND AT07_A.StandardTypeID = 'S07'
LEFT JOIN AT0128 AT08_A WITH (NOLOCK) ON AT08_A.StandardID = O99.S08ID AND AT08_A.StandardTypeID = 'S08'
LEFT JOIN AT0128 AT09_A WITH (NOLOCK) ON AT09_A.StandardID = O99.S09ID AND AT09_A.StandardTypeID = 'S09'
LEFT JOIN AT0128 AT10_A WITH (NOLOCK) ON AT10_A.StandardID = O99.S10ID AND AT10_A.StandardTypeID = 'S10'
LEFT JOIN AT0128 AT11_A WITH (NOLOCK) ON AT11_A.StandardID = O99.S11ID AND AT11_A.StandardTypeID = 'S11'
LEFT JOIN AT0128 AT12_A WITH (NOLOCK) ON AT12_A.StandardID = O99.S12ID AND AT12_A.StandardTypeID = 'S12'
LEFT JOIN AT0128 AT13_A WITH (NOLOCK) ON AT13_A.StandardID = O99.S13ID AND AT13_A.StandardTypeID = 'S13'
LEFT JOIN AT0128 AT14_A WITH (NOLOCK) ON AT14_A.StandardID = O99.S15ID AND AT14_A.StandardTypeID = 'S14'
LEFT JOIN AT0128 AT15_A WITH (NOLOCK) ON AT15_A.StandardID = O99.S15ID AND AT15_A.StandardTypeID = 'S15'
LEFT JOIN AT0128 AT16_A WITH (NOLOCK) ON AT16_A.StandardID = O99.S16ID AND AT16_A.StandardTypeID = 'S16'
LEFT JOIN AT0128 AT17_A WITH (NOLOCK) ON AT17_A.StandardID = O99.S17ID AND AT17_A.StandardTypeID = 'S17'
LEFT JOIN AT0128 AT18_A WITH (NOLOCK) ON AT18_A.StandardID = O99.S18ID AND AT18_A.StandardTypeID = 'S18'
LEFT JOIN AT0128 AT19_A WITH (NOLOCK) ON AT19_A.StandardID = O99.S19ID AND AT19_A.StandardTypeID = 'S19'
LEFT JOIN AT0128 AT20_A WITH (NOLOCK) ON AT20_A.StandardID = O99.S20ID AND AT20_A.StandardTypeID = 'S20'
LEFT JOIN AV1319  on AV1319.DivisionID in (OT2002.DivisionID,'@@@') and AV1319.InventoryID = OT2002.InventoryID  and  AV1319.UnitID  = OT2002.UnitID
LEFT JOIN MT1601 On MT1601.PeriodID = OT2001.PeriodID
LEFT JOIN	(	SELECT		SUM(ISNULL(ActualQuantity,0)) AS ActualQuantity, OrderID 
				FROM		AT2027 WITH (NOLOCK)
				GROUP BY	OrderID
	   	 )AT2027
ON		OT2002.SOrderID = AT2027.OrderID
LEFT JOIN AT1207 WITH (NOLOCK) ON AT1202.S2 = AT1207.S AND AT1207.DivisionID IN (AT1202.DivisionID, '@@@') AND AT1207.STypeID = 'O02'
LEFT JOIN AT1205 WITH (NOLOCK) ON OT2001.PaymentID = AT1205.PaymentID
LEFT JOIN AT1015 AT51 WITH (NOLOCK) on AT51.AnaID = AT1302.I01ID and AT51.AnaTypeID ='I01'
LEFT JOIN AT1015 AT52 WITH (NOLOCK) on AT52.AnaID = AT1302.I02ID and AT52.AnaTypeID ='I02'
LEFT JOIN AT1015 AT53 WITH (NOLOCK) on AT53.AnaID = AT1302.I03ID and AT53.AnaTypeID ='I03'
LEFT JOIN AT1015 AT54 WITH (NOLOCK) on AT54.AnaID = AT1302.I04ID and AT54.AnaTypeID ='I04'
LEFT JOIN AT1015 AT55 WITH (NOLOCK) on AT55.AnaID = AT1302.I05ID and AT55.AnaTypeID ='I05'
LEFT JOIN AT1015 AT56 WITH (NOLOCK) on AT56.AnaID = AT1302.I06ID and AT56.AnaTypeID ='I06'
LEFT JOIN AT1015 AT57 WITH (NOLOCK) on AT57.AnaID = AT1302.I07ID and AT57.AnaTypeID ='I07'
LEFT JOIN AT1015 AT58 WITH (NOLOCK) on AT58.AnaID = AT1302.I08ID and AT58.AnaTypeID ='I08'
LEFT JOIN AT1015 AT59 WITH (NOLOCK) on AT59.AnaID = AT1302.I09ID and AT59.AnaTypeID ='I09'
LEFT JOIN AT1015 AT50 WITH (NOLOCK) on AT50.AnaID = AT1302.I10ID and AT50.AnaTypeID ='I10'
LEFT JOIN AT1015 AT61 WITH (NOLOCK) on AT61.AnaID = AT1202.O02ID and AT61.AnaTypeID ='O02'
LEFT JOIN AT1015 AT62 WITH (NOLOCK) on AT62.AnaID = AT1202.O03ID and AT62.AnaTypeID ='O03'
LEFT JOIN AT1015 AT63 WITH (NOLOCK) on AT63.AnaID = AT1202.O01ID and AT63.AnaTypeID ='O01'
LEFT JOIN AT1015 AT64 WITH (NOLOCK) on AT64.AnaID = AT1202.O04ID and AT64.AnaTypeID ='O04'
LEFT JOIN AT1015 AT65 WITH (NOLOCK) on AT65.AnaID = AT1202.O05ID and AT65.AnaTypeID ='O05'
LEFT JOIN AT1002 WITH (NOLOCK) ON AT1202.CityID = AT1002.CityID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
