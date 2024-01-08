IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3001_BLA]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3001_BLA]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----Created by: Tiểu Mai on 25/08/2017
----purpose: In đơn đặt hàng cho Bê tông Long An (CustomizeIndex = 80)
----Modified by Tiểu Mai on 12/10/2017: Fix lấy dữ liệu chưa đúng
----Modified by Tiểu Mai on 31/10/2017: Chỉnh sửa cách hiển thị các mặt hàng của đơn hàng trước có cùng dự án
----Modified by Bảo Thy on 22/01/2018: Fix lỗi lên dữ liệu theo đợt và số lượng lũy kế chưa đúng
----Modified by Bảo Thy on 13/03/2018: Lấy trường Description theo nội dung diễn giải của đơn hàng bán đang in (http://192.168.0.204:8069/web?db=ASERP#id=3301&view_type=form&model=project.issue&menu_id=304&action=390)
----Modified by Bảo Thy on 20/04/2018: Fix lỗi double dữ liệu khi Description tại detail nhập không giống nhau (http://192.168.0.204:8069/web?db=ASERP#id=3934&view_type=form&model=project.issue&menu_id=304&action=390)
----Modified by Kim Thư on 25/09/2018: Bổ sung loại trừ phiếu đang in khi in kèm những phiếu cùng Dự án và Hợp đồng
----Modified by Kim Thư on 06/12/2018: Sửa lỗi kết bảng TBL Ana06ID => các đợt trước lên dữ liệu
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

---- exec OP3001_BLA @Divisionid=N'PC',@Tranmonth=8,@Tranyear=2016,@Orderid=N'SO/08/2016/0001'


CREATE PROCEDURE [dbo].[OP3001_BLA] 
				@DivisionID AS nvarchar(50),
				@TranMonth AS int,
				@TranYear AS int,
				@OrderID AS nvarchar(4000)

AS

Declare @sSQL AS varchar(max);
Declare @sSQL1 AS varchar(max);
Declare @sSQL2 AS varchar(max);
Declare @sSQL3 AS varchar(max);
Declare @sSQL4 AS varchar(max);
Declare @sSQL4_1 AS varchar(max);
Declare @sSQL5 AS varchar(max);
Declare @sSQL6 AS varchar(max)
Declare @sSQL6_1 AS varchar(max)
Declare @sSQL6_2 AS varchar(max)
Declare @sSQL6_3 AS varchar(max)
Declare @sSQL6_4 AS varchar(max)
Declare @sSQL7 AS varchar(max), @sSQL8 VARCHAR(MAX)
Declare @ObjectID nvarchar(50), @OrderDate as datetime, @VoucherTypeID as nvarchar(50);

Declare @AmountBookCN decimal (28,8); --công nợ tổng, tính theo dữ liệu
Declare @AmountCN decimal (28,8); --công nợ tính đến ngày phát sinh đơn hàng trở về trước.
SET @AmountBookCN = 0



Set @sSQL = N'
Select x.*, A00003.Image01ID 
into #TEMP
From
(
SELECT  Distinct OT2002.DivisionID,
	OT2001.SOrderID, 	OT2002.TransactionID, 
	OT2001.VoucherTypeID, 	VoucherNo, 	OrderDate, 	
	ContractNo,	 	ContractDate,
	OT2001.CurrencyID,
	OT2001.ObjectID, AT1202.ObjectName ,AT1202.Address ,  AT1202.VATNo AS OVATNo, AT1202.Tel, AT1202.Fax, AT1202.Email, 
	-- Edit Thanh Nguyen, date 23/03/2011
	AT1202.Website AS ObjectWebsite, AT1202.Contactor AS ObjectContactor, AT1202.BankName AS ObjectBankName, 
	AT1202.BankAddress AS ObjectBankAddress, AT1202.BankAccountNo AS ObjectBankAccountNo, AT1202.Note AS ObjectNote1, AT1202.Note1 AS ObjectNote2
	,
	OT2001.DeliveryAddress,
 	OT2001.Notes AS Descrip,
	OT2001.TransPort, OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
	OT2002.InventoryID, 	ISNULL(OT2002.InventoryCommonName, 	AT1302.InventoryName)  AS InventoryName,
	AT1302.UnitID, AT1304.UnitName,
	Isnull(AV1319.UnitID,AT1302.UnitID)  AS ConversionUnitID, 
	AV1319.ConversionFactor,
	Isnull(AV1319.UnitName, AT1304.UnitName) AS ConversionUnitName,
	AT1002.CityName,
	OT2002.MethodID, 	MethodName, 	
	OT2001.PaymentTermID,AT1208.PaymentTermName, 
	OrderQuantity, 		
	'
Set @sSQL1 = N'
	(case when AV1319.Operator = 0 OR  AV1319.ConversionFactor=0  then (OrderQuantity * AV1319.ConversionFactor  )
	else
	(OrderQuantity /  ISNULL(AV1319.ConversionFactor,1)   ) end)   AS ConversionQuantity , 		
	OT2002.SalePrice, 	OT2001.ExchangeRate, 
	case when AT1004.Operator = 0 or OT2001.ExchangeRate = 0  then SalePrice*OT2001.ExchangeRate else
	OT2002.SalePrice/OT2001.ExchangeRate  end AS SalePriceConverted,
	ISNULL(OT2002.ConvertedAmount,0) AS ConvertedAmount, 
	ISNULL(OT2002.OriginalAmount,0) AS OriginalAmount, 
	OT2002.VATPercent, 	
	ISNULL(OT2002.VATConvertedAmount,0) AS VATConvertedAmount, 	
	ISNULL(OT2002.VATOriginalAmount, 0) AS VATOriginalAmount,
	DiscountPercent, 	
	ISNULL(DiscountConvertedAmount,0) AS DiscountConvertedAmount, 	
	ISNULL(DiscountOriginalAmount,0) AS DiscountOriginalAmount,OT2002.ShipDate, OT2002.RefInfor,
	OT2002.Orders, AT1205.PaymentName, AT1004.CurrencyName,
	ISNULL(OT2002.OriginalAmount, 0) + ISNULL(OT2002.VATOriginalAmount, 0)	 -
	ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(CommissionOAmount,0) AS TotalOriginalAmount,
	ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - 
	ISNULL(OT2002.DiscountConvertedAmount, 0)-ISNULL(CommissionCAmount, 0)as TotalConvertedAmount,

	OT2002.Ana01ID, 
	OT2002.Ana02ID, 
	OT2002.Ana03ID, 
	OT2002.Ana04ID, 
	OT2002.Ana05ID,
	OT2002.Ana06ID,
	OT2002.Ana07ID,
	OT2002.Ana08ID,
	OT2002.Ana09ID,
	OT2002.Ana10ID,
	 '
	
set @sSQL2 = N'
	OT1002_1.AnaName AS AnaName1,
	OT1002_2.AnaName AS AnaName2, 
	OT1002_3.AnaName AS AnaName3,
	OT1002_4.AnaName AS AnaName4,
	OT1002_5.AnaName AS AnaName5,
	OT1002_6.AnaName AS AnaName6,
	OT1002_7.AnaName AS AnaName7,
	OT1002_8.AnaName AS AnaName8,
	OT1002_9.AnaName AS AnaName9,
	OT1002_10.AnaName AS AnaName10,
 	OT2002.Description ,
	ISNULL(OT2001.Contact, AT1202.contactor)as contactor ,
	OT2002.Notes, OT2002.Notes01, OT2002.Notes02,
	OT2001.VATObjectID,
	ISNULL(OT2001.VATObjectName,T02.ObjectName) AS VATObjectName,
	ISNULL(OT2001.Address,		 T02.Address) AS VATAddress,
	ISNULL(OT2001.VATNo,T02.VatNo) AS VATNo ,
	OT2002.EndDate,
	AT1302.I01ID, T15.AnaName AS AnaNameI01,  
	AT1302.I02ID, T16.AnaName AS AnaNameI02,
	AT1302.I03ID, T17.AnaName AS AnaNameI03,
	AT1302.I04ID, T18.AnaName AS AnaNameI04,
	AT1302.I05ID, T19.AnaName AS AnaNameI05,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1302.IsDiscount, AV1319.Operator, OT2002.Varchar01, OT2002.Varchar02, OT2002.Varchar03, OT2002.Varchar04, OT2002.Varchar05,
	OT2002.Varchar06, OT2002.Varchar07, OT2002.Varchar08, OT2002.Varchar09, OT2002.Varchar10,
	OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, OT2002.nvarchar04, OT2002.nvarchar05, 
	OT2002.nvarchar06, OT2002.nvarchar07, OT2002.nvarchar08, OT2002.nvarchar09, OT2002.nvarchar10,
	OT2001.OrderStatus, OV1101.Description AS OrderStatusName,
	OT2001.ClassifyID, OT1001.ClassifyName, OT1001.Note AS ClassifyNote, OT2001.QuotationID, OT2001.DueDate,
'
set @sSQL3 = N'	
	AT1202.Phonenumber,
	AT1202.DeAddress,
	AT1202.ReDueDays,
 '
set @sSQL4 = N'		
	(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
	AS OriginalAmountBeforeVAT,
	        
	(Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))
	AS ConvertAmountBeforeVAT,
	
	(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
          - ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
          - OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT,
          
	(OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - ISNULL(OT2002.DiscountSaleAmountDetail,0) -  (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity - OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT,
	OT2002.DiscountSaleAmountDetail, OT2001.ShipAmount,	0 as Quantity, convert(nvarchar(4000),'''') as ListInventoryName,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID,
	O99.S19ID, O99.S20ID
From (
							Select OT2002.*,  
									Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
									Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
									Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
							from OT2002 with (nolock) 
		) OT2002 
		'
		SET @sSQL4_1 = '
	LEFT JOIN AT1302 with (nolock)  on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
	LEFT JOIN AT1320 with (nolock)  on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
	LEFT JOIN OT1003 with (nolock)  on OT1003.MethodID = OT2002.MethodID AND OT1003.DivisionID = OT2002.DivisionID 
	INNER JOIN OT2001 with (nolock)  on OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1205 with (nolock)  on AT1205.PaymentID = OT2001.PaymentID
	LEFT JOIN AT1303 with (nolock)  on AT1303.DivisionID IN (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1301 with (nolock)  on AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 with (nolock)  on AT1304.UnitID = AT1302.UnitID         
	LEFT JOIN AT1103 with (nolock)  on AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 with (nolock)  on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1004 with (nolock)  on AT1004.CurrencyID = OT2001.CurrencyID
	LEFT JOIN AT1202 with (nolock)  on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN AT1202 T02 with (nolock)  on T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
	LEFT JOIN AT1208 with (nolock)  on AT1208.PaymentTermID = OT2001.PaymentTermID
	LEFT JOIN AT1002 with (nolock)  on AT1002.CityID = AT1202.CityID'
SET @sSQL5 = '	
	LEFT JOIN AT1011  OT1002_1 with (nolock) on OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01'' 
	LEFT JOIN AT1011  OT1002_2 with (nolock) on OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02'' 
	LEFT JOIN AT1011  OT1002_3 with (nolock) on OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03'' 
	LEFT JOIN AT1011  OT1002_4 with (nolock) on OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04'' 
	LEFT JOIN AT1011  OT1002_5 with (nolock) on OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05'' 
	LEFT JOIN AT1011  OT1002_6 with (nolock) on OT1002_6.AnaID = OT2002.Ana06ID AND  OT1002_6.AnaTypeID = ''A06'' 
	LEFT JOIN AT1011  OT1002_7 with (nolock) on OT1002_7.AnaID = OT2002.Ana07ID AND  OT1002_7.AnaTypeID = ''A07'' 
	LEFT JOIN AT1011  OT1002_8 with (nolock) on OT1002_8.AnaID = OT2002.Ana08ID AND  OT1002_8.AnaTypeID = ''A08'' 
	LEFT JOIN AT1011  OT1002_9 with (nolock) on OT1002_9.AnaID = OT2002.Ana09ID AND  OT1002_9.AnaTypeID = ''A09'' 
	LEFT JOIN AT1011  OT1002_10 with (nolock) on OT1002_10.AnaID = OT2002.Ana10ID AND  OT1002_10.AnaTypeID = ''A10'' 
	LEFT JOIN AT1015  T15 with (nolock) on T15.AnaID = AT1302.I01ID AND T15.AnaTypeID =''I01''
	LEFT JOIN AT1015  T16 with (nolock) on T16.AnaID = AT1302.I02ID AND T16.AnaTypeID =''I02''
	LEFT JOIN AT1015  T17 with (nolock) on T17.AnaID = AT1302.I03ID AND T17.AnaTypeID =''I03''
	LEFT JOIN AT1015  T18 with (nolock) on T18.AnaID = AT1302.I04ID AND T18.AnaTypeID =''I04''
	LEFT JOIN AT1015  T19 with (nolock) on T19.AnaID = AT1302.I05ID AND T19.AnaTypeID =''I05''
	LEFT JOIN AV1319 on AV1319.InventoryID = OT2002.InventoryID  AND  AV1319.UnitID  = OT2002.UnitID AND  AV1319.DivisionID in (OT2002.DivisionID,''@@@'')
	LEFT JOIN OT3019 with (nolock) on OT3019.SOKitTransactionID = OT2002.SOKitTransactionID AND OT3019.DivisionID = OT2002.DivisionID
	LEFT JOIN OV1101 on OV1101.TypeID = N''SO'' AND OV1101.OrderStatus = OT2001.OrderStatus AND OV1101.DivisionID in (OT2001.DivisionID,''@@@'')
	LEFT JOIN OT1001 with (nolock) on ISNULL(OT1001.Disabled,0) = 0 AND OT1001.TypeID = N''SO'' AND OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.DivisionID = OT2001.DivisionID
	LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID 
'

set @sSQL6 = N'
WHERE	OT2001.DivisionID = N''' + ISNULL(@DivisionID,'') + N''' AND 
		OT2001.SOrderID in ( N''' + ISNULL(@OrderID,'') + ''')

UNION
----Lay nhung DHB co cung du an (A03ID) va cung so hop dong (A06ID)
SELECT  Distinct OT2002.DivisionID,
	OT2001.SOrderID, 	OT2002.TransactionID, 
	OT2001.VoucherTypeID, 	VoucherNo, 	OT2001.OrderDate, 	
	ContractNo,	 	ContractDate,
	OT2001.CurrencyID,
	OT2001.ObjectID, AT1202.ObjectName ,AT1202.Address ,  AT1202.VATNo AS OVATNo, AT1202.Tel, AT1202.Fax, AT1202.Email, 
	-- Edit Thanh Nguyen, date 23/03/2011
	AT1202.Website AS ObjectWebsite, AT1202.Contactor AS ObjectContactor, AT1202.BankName AS ObjectBankName, 
	AT1202.BankAddress AS ObjectBankAddress, AT1202.BankAccountNo AS ObjectBankAccountNo, AT1202.Note AS ObjectNote1, AT1202.Note1 AS ObjectNote2
	,
	OT2001.DeliveryAddress,
 	OT2001.Notes AS Descrip,
	OT2001.TransPort, OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
	OT2002.InventoryID, 	ISNULL(OT2002.InventoryCommonName, 	AT1302.InventoryName)  AS InventoryName,
	AT1302.UnitID, AT1304.UnitName,
	Isnull(AV1319.UnitID,AT1302.UnitID)  AS ConversionUnitID, 
	AV1319.ConversionFactor,
	Isnull(AV1319.UnitName, AT1304.UnitName) AS ConversionUnitName,
	AT1002.CityName,
	OT2002.MethodID, 	MethodName, 	
	OT2001.PaymentTermID,AT1208.PaymentTermName, 
	OrderQuantity, 
	(case when AV1319.Operator = 0 OR  AV1319.ConversionFactor=0  then (OrderQuantity * AV1319.ConversionFactor  )
	else
	(OrderQuantity /  ISNULL(AV1319.ConversionFactor,1)   ) end)   AS ConversionQuantity , 		
	OT2002.SalePrice, 	OT2001.ExchangeRate, 
	case when AT1004.Operator = 0 or OT2001.ExchangeRate = 0  then SalePrice*OT2001.ExchangeRate else
	OT2002.SalePrice/OT2001.ExchangeRate  end AS SalePriceConverted,
	ISNULL(OT2002.ConvertedAmount,0) AS ConvertedAmount, 
	ISNULL(OT2002.OriginalAmount,0) AS OriginalAmount, 
	OT2002.VATPercent, 	
	ISNULL(OT2002.VATConvertedAmount,0) AS VATConvertedAmount, 	
	ISNULL(OT2002.VATOriginalAmount, 0) AS VATOriginalAmount,
	DiscountPercent, 	
	ISNULL(DiscountConvertedAmount,0) AS DiscountConvertedAmount, 	
	ISNULL(DiscountOriginalAmount,0) AS DiscountOriginalAmount,OT2002.ShipDate, OT2002.RefInfor,
	OT2002.Orders, AT1205.PaymentName, AT1004.CurrencyName,
	ISNULL(OT2002.OriginalAmount, 0) + ISNULL(OT2002.VATOriginalAmount, 0)	 -
	ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(CommissionOAmount,0) AS TotalOriginalAmount,
	ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - 
	ISNULL(OT2002.DiscountConvertedAmount, 0)-ISNULL(CommissionCAmount, 0)as TotalConvertedAmount,
'
SET @sSQL6_1 = '
	OT2002.Ana01ID, 
	OT2002.Ana02ID, 
	OT2002.Ana03ID, 
	OT2002.Ana04ID, 
	OT2002.Ana05ID,
	OT2002.Ana06ID,
	OT2002.Ana07ID,
	OT2002.Ana08ID,
	OT2002.Ana09ID,
	OT2002.Ana10ID,	
	OT1002_1.AnaName AS AnaName1,
	OT1002_2.AnaName AS AnaName2, 
	OT1002_3.AnaName AS AnaName3,
	OT1002_4.AnaName AS AnaName4,
	OT1002_5.AnaName AS AnaName5,
	OT1002_6.AnaName AS AnaName6,
	OT1002_7.AnaName AS AnaName7,
	OT1002_8.AnaName AS AnaName8,
	OT1002_9.AnaName AS AnaName9,
	OT1002_10.AnaName AS AnaName10,
 	TBL.Description ,
	ISNULL(OT2001.Contact, AT1202.contactor)as contactor ,
	OT2002.Notes, OT2002.Notes01, OT2002.Notes02,
	OT2001.VATObjectID,
	ISNULL(OT2001.VATObjectName,T02.ObjectName) AS VATObjectName,
	ISNULL(OT2001.Address,		 T02.Address) AS VATAddress,
	ISNULL(OT2001.VATNo,T02.VatNo) AS VATNo ,
	OT2002.EndDate,
	AT1302.I01ID, T15.AnaName AS AnaNameI01,  
	AT1302.I02ID, T16.AnaName AS AnaNameI02,
	AT1302.I03ID, T17.AnaName AS AnaNameI03,
	AT1302.I04ID, T18.AnaName AS AnaNameI04,
	AT1302.I05ID, T19.AnaName AS AnaNameI05,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1302.IsDiscount, AV1319.Operator, OT2002.Varchar01, OT2002.Varchar02, OT2002.Varchar03, OT2002.Varchar04, OT2002.Varchar05,
	OT2002.Varchar06, OT2002.Varchar07, OT2002.Varchar08, OT2002.Varchar09, OT2002.Varchar10,
	OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, OT2002.nvarchar04, OT2002.nvarchar05, 
	OT2002.nvarchar06, OT2002.nvarchar07, OT2002.nvarchar08, OT2002.nvarchar09, OT2002.nvarchar10,
	OT2001.OrderStatus, OV1101.Description AS OrderStatusName,
'
SET @sSQL6_2 = '
	OT2001.ClassifyID, OT1001.ClassifyName, OT1001.Note AS ClassifyNote, OT2001.QuotationID, OT2001.DueDate, AT1202.Phonenumber, AT1202.DeAddress, AT1202.ReDueDays,
	(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
	AS OriginalAmountBeforeVAT,
	        
	(Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))
	AS ConvertAmountBeforeVAT,
	
	(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
          - ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
          - OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT,
          
	(OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - ISNULL(OT2002.DiscountSaleAmountDetail,0) -  (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity - OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT,
	OT2002.DiscountSaleAmountDetail, OT2001.ShipAmount,	0 as Quantity, convert(nvarchar(4000),'''') as ListInventoryName,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, 
	O99.S18ID, O99.S19ID, O99.S20ID
	From (
			Select OT2002.*,  
					Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
					Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
					Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
			from OT2002 with (nolock) 
		) OT2002
	LEFT JOIN AT1302 with (nolock)  on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
	LEFT JOIN AT1320 with (nolock)  on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
	LEFT JOIN OT1003 with (nolock)  on OT1003.MethodID = OT2002.MethodID AND OT1003.DivisionID = OT2002.DivisionID 
	INNER JOIN OT2001 with (nolock)  on OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1205 with (nolock)  on AT1205.PaymentID = OT2001.PaymentID
	LEFT JOIN AT1303 with (nolock)  on AT1303.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1301 with (nolock)  on AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 with (nolock)  on AT1304.UnitID = AT1302.UnitID         
	LEFT JOIN AT1103 with (nolock)  on AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 with (nolock)  on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1004 with (nolock)  on AT1004.CurrencyID = OT2001.CurrencyID
	LEFT JOIN AT1202 with (nolock)  on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN AT1202 T02 with (nolock)  on T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
	LEFT JOIN AT1208 with (nolock)  on AT1208.PaymentTermID = OT2001.PaymentTermID
	LEFT JOIN AT1002 with (nolock)  on AT1002.CityID = AT1202.CityID
'
SET @sSQL6_3 = '
	LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID 
	LEFT JOIN AT1011  OT1002_1 with (nolock) on OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01'' 
	LEFT JOIN AT1011  OT1002_2 with (nolock) on OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02'' 
	LEFT JOIN AT1011  OT1002_3 with (nolock) on OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03'' 
	LEFT JOIN AT1011  OT1002_4 with (nolock) on OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04'' 
	LEFT JOIN AT1011  OT1002_5 with (nolock) on OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05'' 
	LEFT JOIN AT1011  OT1002_6 with (nolock) on OT1002_6.AnaID = OT2002.Ana06ID AND  OT1002_6.AnaTypeID = ''A06'' 
	LEFT JOIN AT1011  OT1002_7 with (nolock) on OT1002_7.AnaID = OT2002.Ana07ID AND  OT1002_7.AnaTypeID = ''A07'' 
	LEFT JOIN AT1011  OT1002_8 with (nolock) on OT1002_8.AnaID = OT2002.Ana08ID AND  OT1002_8.AnaTypeID = ''A08'' 
	LEFT JOIN AT1011  OT1002_9 with (nolock) on OT1002_9.AnaID = OT2002.Ana09ID AND  OT1002_9.AnaTypeID = ''A09'' 
	LEFT JOIN AT1011  OT1002_10 with (nolock) on OT1002_10.AnaID = OT2002.Ana10ID AND  OT1002_10.AnaTypeID = ''A10'' 
	LEFT JOIN AT1015  T15 with (nolock) on T15.AnaID = AT1302.I01ID AND T15.AnaTypeID =''I01''
	LEFT JOIN AT1015  T16 with (nolock) on T16.AnaID = AT1302.I02ID AND T16.AnaTypeID =''I02''
	LEFT JOIN AT1015  T17 with (nolock) on T17.AnaID = AT1302.I03ID AND T17.AnaTypeID =''I03''
	LEFT JOIN AT1015  T18 with (nolock) on T18.AnaID = AT1302.I04ID AND T18.AnaTypeID =''I04''
	LEFT JOIN AT1015  T19 with (nolock) on T19.AnaID = AT1302.I05ID AND T19.AnaTypeID =''I05''
	LEFT JOIN AV1319 on AV1319.InventoryID = OT2002.InventoryID  AND  AV1319.UnitID  = OT2002.UnitID AND  AV1319.DivisionID in (OT2002.DivisionID,''@@@'')
	LEFT JOIN OT3019 with (nolock) on OT3019.SOKitTransactionID = OT2002.SOKitTransactionID AND OT3019.DivisionID = OT2002.DivisionID
	LEFT JOIN OV1101 on OV1101.TypeID = N''SO'' AND OV1101.OrderStatus = OT2001.OrderStatus AND OV1101.DivisionID in (OT2001.DivisionID,''@@@'')
	LEFT JOIN OT1001 with (nolock) on ISNULL(OT1001.Disabled,0) = 0 AND OT1001.TypeID = N''SO'' AND OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.DivisionID = OT2001.DivisionID
	'
SET @sSQL6_4 = '
	INNER JOIN (SELECT Temp1.DivisionID, Temp1.InventoryID, Temp2.OrderDate, Temp1.SOrderID, Temp1.Ana03ID, Temp1.Ana05ID, Temp1.Ana06ID, Temp1.Description,
				Temp3.S01ID, Temp3.S02ID, Temp3.S03ID, Temp3.S04ID, Temp3.S05ID, Temp3.S06ID, Temp3.S07ID, Temp3.S08ID, Temp3.S09ID, Temp3.S10ID, Temp3.S11ID, Temp3.S12ID, Temp3.S13ID, Temp3.S14ID, Temp3.S15ID, Temp3.S16ID, Temp3.S17ID, Temp3.S18ID, Temp3.S19ID, Temp3.S20ID
				FROM OT2002 Temp1 WITH (NOLOCK)
				INNER JOIN OT2001 Temp2 WITH (NOLOCK) ON Temp1.DivisionID = Temp2.DivisionID AND Temp1.SOrderID = Temp2.SOrderID
				LEFT JOIN OT8899 Temp3 WITH (NOLOCK) ON Temp3.DivisionID = Temp1.DivisionID AND Temp3.VoucherID = Temp1.SOrderID AND Temp3.TransactionID = Temp1.TransactionID 
			   ) TBL ON OT2002.Ana03ID = TBL.Ana03ID AND OT2002.Ana05ID = TBL.Ana05ID 
					AND TBL.SOrderID = N''' + ISNULL(@OrderID,'') + ''' AND OT2002.DivisionID = TBL.DivisionID 
					AND CONVERT(INT,SUBSTRING(OT2002.Ana06ID, 1, LEN(OT2002.Ana06ID))) <= CONVERT(INT,SUBSTRING(TBL.Ana06ID, 1, LEN(TBL.Ana06ID)))
					AND OT2001.OrderType = 0 AND OT2001.OrderDate <= TBL.OrderDate
					AND ISNULL(O99.S01ID,'''') = ISNULL(TBL.S01ID,'''')
					AND ISNULL(O99.S02ID,'''') = ISNULL(TBL.S02ID,'''')
					AND ISNULL(O99.S03ID,'''') = ISNULL(TBL.S03ID,'''')
					AND ISNULL(O99.S04ID,'''') = ISNULL(TBL.S04ID,'''')
					AND ISNULL(O99.S05ID,'''') = ISNULL(TBL.S05ID,'''')
					AND ISNULL(O99.S06ID,'''') = ISNULL(TBL.S06ID,'''')
					AND ISNULL(O99.S07ID,'''') = ISNULL(TBL.S07ID,'''')
					AND ISNULL(O99.S08ID,'''') = ISNULL(TBL.S08ID,'''')
					AND ISNULL(O99.S09ID,'''') = ISNULL(TBL.S09ID,'''')
					AND ISNULL(O99.S10ID,'''') = ISNULL(TBL.S10ID,'''')
					AND ISNULL(O99.S11ID,'''') = ISNULL(TBL.S11ID,'''')
					AND ISNULL(O99.S12ID,'''') = ISNULL(TBL.S12ID,'''')
					AND ISNULL(O99.S13ID,'''') = ISNULL(TBL.S13ID,'''')
					AND ISNULL(O99.S14ID,'''') = ISNULL(TBL.S14ID,'''')
					AND ISNULL(O99.S15ID,'''') = ISNULL(TBL.S15ID,'''')
					AND ISNULL(O99.S16ID,'''') = ISNULL(TBL.S16ID,'''')
					AND ISNULL(O99.S17ID,'''') = ISNULL(TBL.S17ID,'''')
					AND ISNULL(O99.S18ID,'''') = ISNULL(TBL.S18ID,'''')
					AND ISNULL(O99.S19ID,'''') = ISNULL(TBL.S19ID,'''')
					AND ISNULL(O99.S20ID,'''') = ISNULL(TBL.S20ID,'''')
	WHERE	OT2001.DivisionID = N''' + ISNULL(@DivisionID,'') + N'''  
	AND ISNULL(OT2002.OrderQuantity,0) <> 0
	AND OT2001.SOrderID <> N''' + ISNULL(@OrderID,'')+''' 
) x 
LEFT JOIN A00003 on x.InventoryID= A00003.InventoryID	and x.DivisionID = A00003.DivisionID
'

SET @sSQL7 = '
UPDATE T
	SET T.Quantity = ISNULL(T2.Quantity,0)
FROM #TEMP T
LEFT JOIN 
(
	SELECT DivisionID, ObjectID, InventoryID, UnitID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID,
		S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, SUM(OrderQuantity) AS Quantity
	FROM
	(
		SELECT DivisionID, ObjectID, InventoryID, UnitID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID,
			S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, SUM(OrderQuantity) AS OrderQuantity
		FROM #TEMP
		GROUP BY DivisionID, ObjectID, InventoryID, UnitID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID,
			S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	)T GROUP BY DivisionID, ObjectID, InventoryID, UnitID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID,
		S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
) T2 ON T.DivisionID = T2.DivisionID AND T.ObjectID = T2.ObjectID AND T.InventoryID = T2.InventoryID AND T.UnitID = T2.UnitID  
AND ISNULL(T.S01ID,'''') = ISNULL(T2.S01ID,'''') AND ISNULL(T.S02ID,'''') = ISNULL(T2.S02ID,'''') AND ISNULL(T.S03ID,'''') = ISNULL(T2.S03ID,'''') AND ISNULL(T.S04ID,'''') = ISNULL(T2.S04ID,'''') AND ISNULL(T.S05ID,'''') = ISNULL(T2.S05ID,'''') 
AND ISNULL(T.S06ID,'''') = ISNULL(T2.S06ID,'''') AND ISNULL(T.S07ID,'''') = ISNULL(T2.S07ID,'''') AND ISNULL(T.S08ID,'''') = ISNULL(T2.S08ID,'''') AND ISNULL(T.S09ID,'''') = ISNULL(T2.S09ID,'''') AND ISNULL(T.S10ID,'''') = ISNULL(T2.S10ID,'''')
AND ISNULL(T.S11ID,'''') = ISNULL(T2.S11ID,'''') AND ISNULL(T.S12ID,'''') = ISNULL(T2.S12ID,'''') AND ISNULL(T.S13ID,'''') = ISNULL(T2.S13ID,'''') AND ISNULL(T.S14ID,'''') = ISNULL(T2.S14ID,'''') AND ISNULL(T.S15ID,'''') = ISNULL(T2.S15ID,'''')
AND ISNULL(T.S16ID,'''') = ISNULL(T2.S16ID,'''') AND ISNULL(T.S17ID,'''') = ISNULL(T2.S17ID,'''') AND ISNULL(T.S18ID,'''') = ISNULL(T2.S18ID,'''') AND ISNULL(T.S19ID,'''') = ISNULL(T2.S19ID,'''') AND ISNULL(T.S20ID,'''') = ISNULL(T2.S20ID,'''')

Update #TEMP
SET ListInventoryName = STUFF((SELECT DISTINCT '', '' + InventoryName 
        FROM 
			(SELECT DISTINCT InventoryName 
				FROM #Temp
				) A FOR XML PATH ('''')), 1, 1, ''''
)

SELECT * FROM #TEMP
ORDER BY InventoryID, Quantity
--'
--PRINT @sSQL
--PRINT(@sSQL1)
--PRINT(@sSQL2)
--PRINT(@sSQL3)
--PRINT(@sSQL4)
--PRINT(@sSQL4_1)
--PRINT(@sSQL5)
--PRINT(@sSQL6)
--PRINT(@sSQL6_1)
--PRINT(@sSQL6_2)
--PRINT(@sSQL6_3)
--PRINT(@sSQL6_4)
--PRINT(@sSQL7)
------PRINT(@sSQL8)
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3+ @sSQL4 + @sSQL4_1+ @sSQL5 + @sSQL6 + @sSQL6_1 + @sSQL6_2 + @sSQL6_3 + @sSQL6_4 + @sSQL7)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
