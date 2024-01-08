IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----Created by: Vo Thanh Huong, date: 16/11/2004
----purpose: In don hang  mua
------ Thuy Tuyen edit: 24/01/2008
----Edit by: Dang Le Bao Quynh; Date 02/04/2008
----Purpose: Tao view in bao cao to khai hai quan
-- Last Edit Thuy Tuyen, date 25/08/2008, 29/08/2008, 05/06/2009,18/06/2009,26/06/2009,10/07/2009
--- Last edit B.Anh, date 30/11/2009	Lay them truong SL, DG, DVT quy doi
--- Edit by B.Anh, date 05/12/2009	Lay them truong OrderStatus, OrderStatusName
--- Edit by B.Anh, date 18/01/2010	Lay them truong RequestID

/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [02/08/2010]
'********************************************/
--- Edit by B.Anh, date 17/07/2012	Lay them truong
--- Edit by T.Oanh, date 24/01/2014	Lay them truong AT1202.VATNo
--- Edit by Trí Thiện, date 12/11/2014	Bổ sung GROUP BY cho trường hợp tạo VIEW OV3055 với số lượng chi tiết OV3054 lớn hơn 3
--- Edit by Mai Duyen, date 20/04/2015	Bổ sung AT1302.BarCode
--- Edit by Tiểu Mai, date 07/09/2015 Bổ sung Mã và tên mã phân tích 06->10
--- Edit by Tiểu Mai, date 21/09/2015 Bổ sung trường LicenseNo
--- Edit by Tiểu Mai, date 02/03/2016: Bổ sung 20 cột quy cách và tên quy cách
--- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
--- Modified by Tiểu Mai on 12/07/2016: Bổ sung trường OT3001.DueDate
--- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
--- Modified by Trà Giang on 25/07/2018: Lấy thêm trường Năng lực sản xuất:POT2014.LeadTimeID ,Website,HotLine
--- Modified by Trà Giang on 14/01/2019: Chỉnh sửa trường Năng lưc -> POT2014.Quantity
--- Modified by Kim Thư on 15/02/2019: Bổ sung cột Notes03
---- Modified by Khánh Đoan on 09/26/2019 Lây trường ConfirmUserID, ConfirmDate, ConfirmUserName
--- Modified by Lê Hoàng on 17/01/2020: Bổ sung Mã số thuế VATNO của AT1101 (đơn vị - chi nhánh) cho Việt Nam Food (107)
--- Modified by Văn Minh on 10/03/2020: Bổ sung Kiểm tra VoucherNo tránh TH POrderID truyền vào là 1 GUID - NEWID()
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Minh Hiếu on 27/01/2022 : Bổ sung các trường thông tin đơn vị và master đơn.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhựt Trường on 14/03/2023: [2023/03/IS/0110] - Fix lỗi tràn dữ liệu.
---- Modified by Viết Toàn	on 19/10/2023: [2023/10/IS/0175] - Thay đổi điều kiện join với OT3101

--- exec OP3011 'HT', 1, 2016, ''
--- select * from OV3002

CREATE PROCEDURE [dbo].[OP3011] 	@DivisionID as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@OrderID as nvarchar(50)
				
AS
SET NOCOUNT ON
Declare 	@sSQLSelect nvarchar(max),
			@sSQLFrom as nvarchar(MAX),
			@sSQL as nvarchar(MAX),
			@sSQL1 as nvarchar(MAX),
			@For as int,
			@FieldCount as int,
			@NullRowInsert as nvarchar(1000),
			@RemainRows as int,
			@IsSubForm as tinyint,
			@IsEdit  as TINYINT,
			@sSQLFrom1 as nvarchar(MAX),
			@sSQLFrom2 as nvarchar(MAX)
	---@Quantity as Money,
	---@OriginalAmount as money 
SET @sSQLFrom2 = '' 	
set @sSQLSelect = 
N'Select OT3002.DivisionID, A11.VATNO DivisionVATNo,
	OT3001.POrderID, 	OT3002.TransactionID, 
	Ot3001.VoucherTypeID, 	
	OT3001.VoucherNo, 	
	Ot3001.OrderDate,  
	OT3001.Notes as Description,
	OT3001.TransPort,
	OT3001.ObjectID, 	
	case when isnull(OT3001.ObjectName, '''') = '''' then AT1202.ObjectName else OT3001.ObjectName end as ObjectName,
	AT1202.Website, AT1202.Contactor, AT1202.Contactor + ''-'' + AT1202.Phonenumber AS Phonenumber, AT1202.Email as ObjectEmail, AT1202.LicenseNo,
	AT1202.Tel, '''' as HotLine, P14.Quantity, AT1202.Fax, AT1202.VATNo,  OT3001.ReceivedAddress,  
	isnull(OT3001.Address, AT1202.Address)  as ObjectAddress, 
	AT1202.BankName as ObjectBankName, AT1202.BankAddress as ObjectBankAddress, AT1202.BankAccountNo as ObjectBankAccountNo, 
	AT1202.Note as ObjectNote1, AT1202.Note1 as ObjectNote2,
	AT1002.CityName,AT1202.Email,
	OT3001.CurrencyID,  AT1004.CurrencyName,
	OT3001.ShipDate, OT3001.ExchangeRate, 
	OT3001.ContractNo, OT3001.CreateDate,
	OT3001.ContractDate, OT3001.CreateUserID,
	AT1202.CountryID,
	AT1001.CountryName,  	
	AT1202.AreaID,
	AT1003.AreaName,
	AT1205.PaymentName,		
	OT3001.EmployeeID, AT1103.FullName, AT1103.Address as EmployeeAddress, AT1103.HireDate as EmployeeHireDate, 
	AT1103.EndDate as EmployeeEndDate, AT1103.BirthDay as EmployeeBirthDay, AT1103.Tel as EmployeeTel, AT1103.Fax as EmployeeFax, AT1103.Email as EmployeeEmail,
	AT1103.BankAccountNumber,
	OT3002.InventoryID, 	
	case when isnull(OT3002. InventoryCommonName, '''') = '''' then InventoryName else 
	OT3002.InventoryCommonName end as InventoryName, A003.Image01ID,
	AT1302.UnitID, 
	AT1304.UnitName, 
	AT1302.Specification,
	AT1302.Notes01 as InNotes01, AT1302.Notes02 as InNotes02,AT1302.Notes03 as InNotes03,
	AT1310_S1.SName as SName1, AT1310_S2.SName as SName2,
	OT3002.OrderQuantity,
	PurchasePrice, 
	case when AT1004.Operator = 0 or OT3001.ExchangeRate = 0  then OT3002.PurchasePrice*OT3001.ExchangeRate else
	OT3002.PurchasePrice/OT3001.ExchangeRate  end as PurchasePriceConverted,
	isnull(OT3002.ConvertedAmount,0) as ConvertedAmount,  
	isnull(OT3002.ConvertedAmount,0) as IMConvertedAmount,  
	----isnull(ConvertedAmount,0) as VATConvertedAmount,  
	isnull(OT3002.OriginalAmount, 0) as OriginalAmount,	
	--OT3002.VATPercent,
	isnull(OT3002.VATPercent,0) as VATPercent,
	--OT3002.VATOriginalAmount,
	isnull(OT3002.VATOriginalAmount,0) as VATOriginalAmount, 
	OT3002.VATConvertedAmount,
	OT3002.DiscountPercent, 
	isnull(OT3002.DiscountConvertedAmount,0) as DiscountConvertedAmount,  
	isnull(OT3002.DiscountOriginalAmount,0) as DiscountOriginalAmount,
	isnull(OT3002.OriginalAmount, 0) + isnull(OT3002.VATOriginalAmount, 0) - isnull(OT3002.DiscountOriginalAmount, 0) as TotalOriginalAmount,
	isnull(OT3002.ConvertedAmount, 0) + isnull(OT3002.VATConvertedAmount, 0) - isnull(OT3002.DiscountConvertedAmount, 0) as TotalConvertedAmount,
	IsPicking, 
	OT3002.WareHouseID, 
	WareHouseName, 
	OT3002.Orders,
	OT3002.Description as TDescription,
	OT3001.Ana01ID,
	OT3001.Ana02ID,
	OT3001.Ana03ID,
	OT3001.Ana04ID,
	OT3001.Ana05ID,
	P01.AnaName as PO01AnaName,
	P02.AnaName as PO02AnaName,
	P03.AnaName as PO03AnaName,
	P04.AnaName as PO04AnaName,
	P05.AnaName as PO05AnaName,	
	OT3002.Ana01ID as TAna01ID,
	OT3002.Ana02ID as TAna02ID,
	OT3002.Ana03ID as TAna03ID,
	OT3002.Ana04ID as TAna04ID,
	OT3002.Ana05ID as TAna05ID,	
	A01.AnaName as A01AnaName,
	A02.AnaName as A02AnaName,
	A03.AnaName as A03AnaName,
	A04.AnaName as A04AnaName,
	A05.AnaName as A05AnaName,	
	OT3002.Ana06ID as TAna06ID,
	OT3002.Ana07ID as TAna07ID,
	OT3002.Ana08ID as TAna08ID,
	OT3002.Ana09ID as TAna09ID,
	OT3002.Ana10ID as TAna10ID,	
	A06.AnaName as A06AnaName,
	A07.AnaName as A07AnaName,
	A08.AnaName as A08AnaName,
	A09.AnaName as A09AnaName,
	A10.AnaName as A10AnaName,	
	AT1302.I01ID, 
	AT1302.I02ID, 
	AT1302.I03ID, 
	AT1302.I04ID, 
	AT1302.I05ID, '
Set @sSQL = N'
	I01.AnaName as I01AnaName,
	I02.AnaName as I02AnaName,
	I03.AnaName as I03AnaName,
	I04.AnaName as I04AnaName,
	I05.AnaName as I05AnaName,	
	AT1015. AnaName,
	isnull(OT3002.Notes02,  T03. AnaName) as AnaName03,
	OT3002.Notes, OT3002.Notes01, OT3002.Notes02,AT1016.BankAccountNo , AT1016.BankName,
	AT1302.Varchar01 as InventoryVarchar01, AT1302.Varchar02 as InventoryVarchar02, AT1302.Varchar03 as InventoryVarchar03, AT1302.varchar04 as InventoryVarchar04, AT1302.varchar05 as InventoryVarchar05,
	OT3001.Varchar01 as PVarchar01 ,OT3001.Varchar02 as PVarchar02, OT3001.Varchar03 as PVarchar03, OT3001.Varchar04 as PVarchar04,OT3001.Varchar05 as PVarchar05, 
	OT3001.Varchar06 as PVarchar06, OT3001.Varchar07 as PVarchar07, OT3001.Varchar08 as PVarchar08,OT3001.Varchar09  as PVarchar09, OT3001.Varchar10 as PVarchar10,
	OT3001.Varchar11 as PVarchar11 ,OT3001.Varchar12 as PVarchar12, OT3001.Varchar13 as PVarchar13, OT3001.Varchar14 as PVarchar14,OT3001.Varchar15 as PVarchar15, 
	OT3001.Varchar16 as PVarchar16, OT3001.Varchar17 as PVarchar17, OT3001.Varchar18 as PVarchar18,OT3001.Varchar19  as PVarchar19, OT3001.Varchar20 as PVarchar20,
	ImTaxpercent,OT3002.ImTaxOriginalAmount,ImtaxConvertedAmount,
	TotalTaxConvertedAmount = ( Select Sum ( isnull (ImTaxConvertedAmount,0) + isnull (VATConvertedAmount,0)) from OT3002  inner join OT3001 on OT3001.POrderID = OT3002.POrderID Where OT3001.DivisionID = ''' + isnull(@DivisionID,'') + ''' and 
	OT3001.POrderID = N''' + isnull(@OrderID,'') + N'''  ) ,
	null as OtherPercent,
	Null as OtherAmount,
	T04.AnaName as  AnaName04,
	OT3101.ROrderID,
	OT3102.ROrderID as ROrderIDDetail,
	OT3101.OrderDate as ROrderDate , OT3101.Shipdate as RShipdate,
	OT3002.Quantity01,
	OT3002.Quantity02,
	OT3002.Quantity03,
	OT3002.Quantity04,
	OT3002.Quantity05,
	OT3002.Quantity06,
	OT3003.Date01,
	OT3003.Date02,	
	OT3003.Date03,
	OT3003.Date04,
	OT3003.Date05,
	OT3003.Date06,
	OT3003.Date07,	
	OT3003.Date08,
	OT3003.Date09,
	OT3003.Date10,
	OT3002.ConvertedQuantity,
	OT3002.ConvertedSalePrice,
	OT3002.UnitID as ConvertedUnitID,
	T34.UnitName as ConvertedUnitName,
	OT3001.OrderStatus, OV1101.Description as OrderStatusName, OV1101.Description as OrderStatusNameE,
	OT3001.RequestID
	, OT3001.ClassifyID, OT1001.ClassifyName, OT1001.Note as ClassifyNote,
	OT3001.PaymentTermID, AT1208.PaymentTermName,
	P01.AnaNameE as PO01AnaNameE,
	P02.AnaNameE as PO02AnaNameE,
	P03.AnaNameE as PO03AnaNameE,
	P04.AnaNameE as PO04AnaNameE,
	P05.AnaNameE as PO05AnaNameE,
	OT3001.Varchar01, OT3001.Varchar02, OT3001.Varchar03, OT3001.Varchar04, OT3001.Varchar05,
	OT3001.Varchar06, OT3001.Varchar07, OT3001.Varchar08, OT3001.Varchar09, OT3001.Varchar10,
	OT3001.Varchar11, OT3001.Varchar12, OT3001.Varchar13, OT3001.Varchar14, OT3001.Varchar15,
	OT3001.Varchar16, OT3001.Varchar17, OT3001.Varchar18, OT3001.Varchar19, OT3001.Varchar20,
	AT1302.Barcode, OT3002.StrParameter01, OT3002.StrParameter02, OT3002.StrParameter03, OT3002.StrParameter04, 
	OT3002.StrParameter05, OT3002.StrParameter06, OT3002.StrParameter07, OT3002.StrParameter08, OT3002.StrParameter09, 
	OT3002.StrParameter10, OT3001.DueDate,
	OT3002.Parameter01, OT3002.Parameter02, OT3002.Parameter03, OT3002.Parameter04, OT3002.Parameter05,
	OT3002.Notes03,OT3001.ConfirmUserID,OT3001.ConfirmDate ,AT1405.UserName AS ConfirmUserName
	, OT3002.ReceivedDate as ReceivedDate
	--, OT3002.InheritVoucherID as VoucherNo_YCMH
	, OT3101.VoucherNo as VoucherNo_YCMH
'

Set @sSQLFrom =  
N'  From OT3002 WITH (NOLOCK) 
	left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT1302.InventoryID= OT3002.InventoryID
	inner join OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID and OT3001.DivisionID= OT3002.DivisionID
	left join A00003 A003 WITH (NOLOCK) on A003.InventoryID = OT3002.InventoryID AND A003.DivisionID = OT3002.DivisionID
	left join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT3002.WareHouseID
	left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT3001.InventoryTypeID
	left join AT1304 WITH (NOLOCK) on AT1304.UnitID = AT1302.UnitID	
	left join AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT3001.EmployeeID
	left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3001.ObjectID
	left join AT1205 WITH (NOLOCK) on AT1205.PaymentID = OT3001.PaymentID
	left join AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT3001.CurrencyID
	left join AT1001 WITH (NOLOCK) on AT1001.CountryID = AT1202.CountryID
	left join AT1003 WITH (NOLOCK) on AT1003.AreaID = AT1202.AreaID
	left join AT1002 WITH (NOLOCK) on AT1002.CityID = AT1202.CityID
	left join AT1310 AT1310_S1 WITH (NOLOCK) on AT1310_S1.STypeID= ''I01'' and AT1310_S1.S = AT1302.S1 
	left join AT1310 AT1310_S2 WITH (NOLOCK) on AT1310_S2.STypeID= ''I02'' and AT1310_S2.S = AT1302.S2 
	left Join AT1015 WITH (NOLOCK) on AT1015.AnaID = AT1302.I02ID  and AT1015. AnaTypeID =''I02''
	left Join AT1015 T03 WITH (NOLOCK) on T03.AnaID = AT1302.I03ID  and T03. AnaTypeID =''I03''
	left Join AT1015 T04 WITH (NOLOCK) on T04.AnaID = AT1302.I04ID  and  T04. AnaTypeID =''I04''
	left join  OT3102 WITH (NOLOCK) On OT3002.RefTransactionID = OT3102.TransactionID and OT3102.DivisionID= OT3002.DivisionID
	left join  OT3101 WITH (NOLOCK) On OT3002.InheritVoucherID = OT3101.VoucherNo and OT3101.DivisionID= OT3002.DivisionID
	left  join OT3003 WITH (NOLOCK) on OT3003.POrderID = OT3002.POrderID and OT3003.DivisionID= OT3002.DivisionID
	left join AT1304 T34 WITH (NOLOCK) on T34.UnitID = OT3002.UnitID
	left join OV1101 on OT3001.OrderStatus = OV1101.OrderStatus and OV1101.TypeID=''PO''and OV1101.DivisionID= OT3002.DivisionID
	Left Join OT1001 WITH (NOLOCK) on IsNull(OT1001.Disabled,0) = 0 And OT1001.TypeID = N''PO'' And OT1001.ClassifyID = OT3001.ClassifyID And OT1001.DivisionID = OT3002.DivisionID
	
'
SET @sSQLFrom1 =  
N'	left join OT1002 P01 WITH (NOLOCK) on P01.AnaTypeID = ''P01'' and P01.AnaID = OT3001.Ana01ID  and P01.DivisionID= OT3002.DivisionID
	left join OT1002 P02 WITH (NOLOCK) on P02.AnaTypeID = ''P02'' and P02.AnaID = OT3001.Ana02ID  and P02.DivisionID= OT3002.DivisionID
	left join OT1002 P03 WITH (NOLOCK) on P03.AnaTypeID = ''P03'' and P03.AnaID = OT3001.Ana03ID  and P03.DivisionID= OT3002.DivisionID
	left join OT1002 P04 WITH (NOLOCK) on P04.AnaTypeID = ''P04'' and P04.AnaID = OT3001.Ana04ID  and P04.DivisionID= OT3002.DivisionID
	left join OT1002 P05 WITH (NOLOCK) on P05.AnaTypeID = ''P05'' and P05.AnaID = OT3001.Ana05ID  and P05.DivisionID= OT3002.DivisionID
		
	left join AT1011 A01 WITH (NOLOCK) on A01.AnaTypeID = ''A01'' and A01.AnaID = OT3002.Ana01ID 
	left join AT1011 A02 WITH (NOLOCK) on A02.AnaTypeID = ''A02'' and A02.AnaID = OT3002.Ana02ID 
	left join AT1011 A03 WITH (NOLOCK) on A03.AnaTypeID = ''A03'' and A03.AnaID = OT3002.Ana03ID 
	left join AT1011 A04 WITH (NOLOCK) on A04.AnaTypeID = ''A04'' and A04.AnaID = OT3002.Ana04ID 
	left join AT1011 A05 WITH (NOLOCK) on A05.AnaTypeID = ''A05'' and A05.AnaID = OT3002.Ana05ID 
	left join AT1011 A06 WITH (NOLOCK) on A06.AnaTypeID = ''A06'' and A06.AnaID = OT3002.Ana06ID 
	left join AT1011 A07 WITH (NOLOCK) on A07.AnaTypeID = ''A07'' and A07.AnaID = OT3002.Ana07ID 
	left join AT1011 A08 WITH (NOLOCK) on A08.AnaTypeID = ''A08'' and A08.AnaID = OT3002.Ana08ID 
	left join AT1011 A09 WITH (NOLOCK) on A09.AnaTypeID = ''A09'' and A09.AnaID = OT3002.Ana09ID 
	left join AT1011 A10 WITH (NOLOCK) on A10.AnaTypeID = ''A10'' and A10.AnaID = OT3002.Ana10ID 
	
	left join AT1015 I01 WITH (NOLOCK) on I01.AnaTypeID = ''I01'' and I01.AnaID = AT1302.I01ID  
	left join AT1015 I02 WITH (NOLOCK) on I02.AnaTypeID = ''I02'' and I02.AnaID = AT1302.I02ID  
	left join AT1015 I03 WITH (NOLOCK) on I03.AnaTypeID = ''I03'' and I03.AnaID = AT1302.I03ID  
	left join AT1015 I04 WITH (NOLOCK) on I04.AnaTypeID = ''I04'' and I04.AnaID = AT1302.I04ID  
	left join AT1015 I05 WITH (NOLOCK) on I05.AnaTypeID = ''I05'' and I05.AnaID = AT1302.I05ID  
	Left Join AT1208 WITH (NOLOCK) on OT3001.PaymentTermID = AT1208.PaymentTermID
	LEFT JOIN AT1405 WITH (NOLOCK) ON  AT1405.UserID = OT3001.ConfirmUserID
	left join POT2018 P18 WITH (NOLOCK) on OT3002.InheritTableID= P18.InheritTableID and OT3002.InheritVoucherID= P18.InheritVoucherID and OT3002.InheritTransactionID=P18.InheritTransactionID
	left join POT2017 P17 WITH (NOLOCK) on  P17.APK=P18.APK_Master
	left join POT2014 P14 WITH (NOLOCK) on  P17.LeadTimeID= P14.LeadTimeID and P14.DetailID= P18.ID_LeadtimeMOQ
	left join POT2013 P13 WITH (NOLOCK) on  P13.LeadTimeID= P14.LeadTimeID
	left join AT1101 A11 WITH (NOLOCK) on A11.DivisionID = OT3002.DivisionID
	left join AT1016 WITH (NOLOCK) on AT1016.BankAccountID = A11.BankAccountID AND AT1016.DivisionID = OT3002.DivisionID
'
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL1 = ', 
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID,
	O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID,
	O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
	a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
	a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
	a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
'
	SET @sSQLFrom2 = '
	LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT3002.DivisionID AND O99.VoucherID = OT3002.POrderID AND O99.TransactionID = OT3002.TransactionID
	LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
							   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) 
									for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
												S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID in (O99.DivisionID,''@@@'')
	
'
END
SET @sSQLFrom2 = @sSQLFrom2
+
N'        Where OT3001.DivisionID = N''' + isnull(@DivisionID,'') + N''' and
          (OT3001.POrderID = N''' + isnull(@OrderID,'') + N'''
          OR OT3001.VoucherNo = N'''+ ISNULL(@OrderID,'') + N''')'
-- Bổ sung load thông tin tham số cho report đơn hàng nhập khẩu
DECLARE @sSQLVarchar NVARCHAR(MAX)
SET @sSQLVarchar='
	SELECT TOP 100 PERCENT *, CASE WHEN VarcharLabel = ''Transshipment '' THEN CASE WHEN ISNULL(VarcharNote,'''') <> '''' THEN 1 ELSE 0 END
			ELSE CASE WHEN VarcharLabel = ''Partial shipment'' THEN CASE WHEN ISNULL(VarcharNote,'''') <> '''' THEN 1 ELSE 0 END ELSE 0 END END AS NoteCheck
	FROM (
	SELECT TypeID, UserNameE AS VarcharLabel,
	CASE TypeID WHEN ''P01'' THEN OT3001.Varchar01
		WHEN ''P02'' THEN OT3001.Varchar02
		WHEN ''P03'' THEN OT3001.Varchar03 
		WHEN ''P04'' THEN OT3001.Varchar04 
		WHEN ''P05'' THEN OT3001.Varchar05
		WHEN ''P06'' THEN OT3001.Varchar06
		WHEN ''P07'' THEN OT3001.Varchar07
		WHEN ''P08'' THEN OT3001.Varchar08 
		WHEN ''P09'' THEN OT3001.Varchar09
		WHEN ''P10'' THEN OT3001.Varchar10
		WHEN ''P11'' THEN OT3001.Varchar11
		WHEN ''P12'' THEN OT3001.Varchar12
		WHEN ''P13'' THEN OT3001.Varchar13 
		WHEN ''P14'' THEN OT3001.Varchar14 
		WHEN ''P15'' THEN OT3001.Varchar15
		WHEN ''P16'' THEN OT3001.Varchar16
		WHEN ''P17'' THEN OT3001.Varchar17
		WHEN ''P18'' THEN OT3001.Varchar18 
		WHEN ''P19'' THEN OT3001.Varchar19
		WHEN ''P20'' THEN OT3001.Varchar20
	ELSE '''' END AS VarcharNote
	FROM OT0005 INNER JOIN OT3001 ON OT0005.DivisionID = OT3001.DivisionID AND OT3001.POrderID='''+@OrderID+'''
	WHERE OT0005.DivisionID = '''+@DivisionID+'''
	And TypeID like ''P__''
	And TypeID <>''P06''
	And IsUsed=1
	)X
	ORDER BY TypeID
'
--Print @sSQLSelect
--Print @sSQL
--Print @sSQL1
--Print @sSQLFrom
--Print @sSQLFrom1
--Print @sSQLFrom2

If Not Exists (Select 1 From sysObjects Where Name ='OV3002')
	Exec ('Create view OV3002  ---tao boi OP3011
		as '+ @sSQLSelect + @sSQL + @sSQL1 + @sSQLFrom + @sSQLFrom1 + @sSQLFrom2)
Else
	Exec( 'Alter view OV3002  ---tao boi OP3011
		as '+ @sSQLSelect + @sSQL + @sSQL1 + @sSQLFrom + @sSQLFrom1 + @sSQLFrom2)
If Not Exists (Select 1 From sysObjects Where Name ='OV3002A')
	Exec ('Create view OV3002A  ---tao boi OP3011
		as '+ @sSQLVarchar)
Else
	Exec( 'Alter view OV3002A  ---tao boi OP3011
		as '+ @sSQLVarchar)
--PRINT ( @sSQLSelect + @sSQL + @sSQLFrom + @sSQLFrom1)


-- Xu ly in nhom theo mat hang, mau bao cao OR3002
Set @sSQL =N'
Select OT3002.DivisionID, 
    A11.VATNO DivisionVATNo,
	OT3001.POrderID, 	
	OT3001.VoucherNo, 	
	OT3001.OrderDate,  
	OT3001.Notes as Description,
	P14.Quantity,
	OT3002.Description as TDescription,
	OT3001.TransPort,
	OT3001.ObjectID, 	
	case when isnull(OT3001.ObjectName, '''') = '''' then AT1202.ObjectName else 
	OT3001.ObjectName end as ObjectName,
	AT1202.Website, '''' as HotLine, AT1202.Contactor, AT1202.Contactor + ''-'' + AT1202.Phonenumber AS Phonenumber,
	AT1202.Tel, AT1202.Fax,  AT1202.VATNo, OT3001.ReceivedAddress,  
	isnull(OT3001.Address, AT1202.Address)  as ObjectAddress, 
	AT1002.CityName,
	OT3001.CurrencyID,  AT1004.CurrencyName,
	OT3001.ShipDate, OT3001.ExchangeRate, 
	OT3001.ContractNo, OT3001.ContractDate,
	AT1202.CountryID,
	AT1001.CountryName,  	
	AT1202.AreaID,
	AT1003.AreaName,
	AT1205.PaymentName,		OT3001.EmployeeID, 
	AT1103.FullName, 	AT1103.Address as EmployeeAddress,
	OT3002.InventoryID, 	
	case when isnull(OT3002. InventoryCommonName,'''') = '''' then InventoryName else 
	OT3002.InventoryCommonName end as InventoryName, 
	AT1302.UnitID, 
	AT1304.UnitName, 
	AT1302.Specification,
	AT1302.Notes01 as InNotes01, AT1302.Notes02 as InNotes02,AT1302.Notes03 as InNotes03,
	AT1310_S1.SName as SName1, AT1310_S2.SName as SName2,
	sum (isnull(OT3002.OrderQuantity,0)) as OrderQuantity , 
	PurchasePrice, 
	Sum (isnull(OT3002.ConvertedAmount,0)) as ConvertedAmount,  
	sum (isnull(OT3002.ConvertedAmount,0)) as IMConvertedAmount,  
	Sum (isnull(OT3002.OriginalAmount, 0)) as OriginalAmount,	
	sum (isnull(OT3002.OriginalAmount, 0)) +  sum(isnull(OT3002.VATOriginalAmount, 0)) -  sum(isnull(OT3002.DiscountOriginalAmount, 0)) as TotalOriginalAmount,
	Sum(isnull(OT3002.ConvertedAmount, 0)) +  sum(isnull(OT3002.VATConvertedAmount, 0)) - sum( isnull(OT3002.DiscountConvertedAmount, 0)) as TotalConvertedAmount,
	OT3002.VATPercent,
	Sum ( Isnull (OT3002.VATOriginalAmount,0)) as VATOriginalAmount ,
	Sum ( Isnull (OT3002.VATConvertedAmount,0)) as VATConvertedAmount ,
	OT3002.DiscountPercent, 
	sum(isnull(OT3002.DiscountConvertedAmount,0)) as DiscountConvertedAmount,  
	sum (isnull(OT3002.DiscountOriginalAmount,0)) as DiscountOriginalAmount,
	OT3001.Ana01ID,
	OT3001.Ana02ID,
	OT3001.Ana03ID,
	OT1002.AnaName as AnaName01,
	AT1302.I02ID, AT1015. AnaName,
	ImTaxpercent,
	Sum(Isnull (OT3002.ImTaxOriginalAmount,0)) As ImTaxOriginalAmount ,
	Sum(Isnull (ImtaxConvertedAmount,0)) As ImtaxConvertedAmount ,
	T04.AnaName as  AnaName04, 
	V01.EndQuantity, -- Ton kho thuc te
	SQuantity,-- Giu cho
	PQuantity, -- Chan bi ban,
	OT3002.WareHouseID,
	OT3101.ROrderID,
	OT3102.ROrderID as ROrderIDDetail,
	OT3101.OrderDate as ROrderDate , OT3101.Shipdate as RShipdate,
	OT3002.Notes, OT3002.Notes01, OT3002.Notes02,
	Sum (isnull(OT3002.ConvertedQuantity,0)) as ConvertedQuantity,
	OT3002.ConvertedSalePrice,
	OT3002.UnitID as ConvertedUnitID,
	T34.UnitName as ConvertedUnitName,
	OT3001.OrderStatus, OV1101.Description as OrderStatusName,
	OT3002.Orders, OT3001.RequestID,
	OT3001.PaymentTermID, AT1208.PaymentTermName,
	AT1202.Email,
	OT3001.Varchar01, OT3001.Varchar02, OT3001.Varchar03, OT3001.Varchar04, OT3001.Varchar05,
	OT3001.Varchar06, OT3001.Varchar07, OT3001.Varchar08, OT3001.Varchar09, OT3001.Varchar10,
	OT3001.Varchar11, OT3001.Varchar12, OT3001.Varchar13, OT3001.Varchar14, OT3001.Varchar15,
	OT3001.Varchar16, OT3001.Varchar17, OT3001.Varchar18, OT3001.Varchar19, OT3001.Varchar20,
	OT3001.Ana04ID,
	OT3001.Ana05ID,
	P01.AnaName as PO01AnaName,
	P02.AnaName as PO02AnaName,
	P03.AnaName as PO03AnaName,
	P04.AnaName as PO04AnaName,
	P05.AnaName as PO05AnaName,
	P01.AnaNameE as PO01AnaNameE,
	P02.AnaNameE as PO02AnaNameE,
	P03.AnaNameE as PO03AnaNameE,
	P04.AnaNameE as PO04AnaNameE,
	P05.AnaNameE as PO05AnaNameE,
	OT3002.Notes03
'
SET @sSQLFrom = N'
From OT3002 WITH (NOLOCK) 
	left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT1302.InventoryID= OT3002.InventoryID 
	inner join OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID and OT3001.DivisionID= OT3002.DivisionID
	left join OT1002 WITH (NOLOCK) on OT1002.AnaTypeID = ''P01'' and OT1002.AnaID = OT3001.Ana01ID  and OT1002.DivisionID= OT3002.DivisionID
	left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT3001.InventoryTypeID 
	left join AT1304 WITH (NOLOCK) on AT1304.UnitID = AT1302.UnitID
	left join AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT3001.EmployeeID
	left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3001.ObjectID
	left join AT1205 WITH (NOLOCK) on AT1205.PaymentID = OT3001.PaymentID
	left join AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT3001.CurrencyID
	left join AT1001 WITH (NOLOCK) on AT1001.CountryID = AT1202.CountryID
	left join AT1003 WITH (NOLOCK) on AT1003.AreaID = AT1202.AreaID	
	left join AT1002 WITH (NOLOCK) on AT1002.CityID = AT1202.CityID
	left join AT1310 AT1310_S1 WITH (NOLOCK)  on AT1310_S1.STypeID= ''I01'' and AT1310_S1.S = AT1302.S1
	left join AT1310 AT1310_S2 WITH (NOLOCK) on AT1310_S2.STypeID= ''I02'' and AT1310_S2.S = AT1302.S2
	left Join AT1015 WITH (NOLOCK) on AT1015.AnaID = AT1302.I02ID  and AT1015. AnaTypeID =''I02''
	left Join AT1015 T03 WITH (NOLOCK)   on T03.AnaID = AT1302.I03ID  and T03. AnaTypeID =''I03''
	left Join AT1015 T04 WITH (NOLOCK)  on T04.AnaID = AT1302.I04ID  and  T04. AnaTypeID =''I04''
	Left Join  (Select DivisionID, InventoryID,WareHouseID, sum(isnull(DebitQuantity,0))-sum(isnull(CreditQuantity,0)) as EndQuantity
		From OV2401 
		Group by DivisionID, WareHouseID,  InventoryID Having  sum(isnull(DebitQuantity,0))-sum(isnull(CreditQuantity,0)) <>0
		) V01 on V01.DivisionID = OT3002.DivisionID and V01.InventoryID = ot3002.InventoryID and V01.WareHouseID = OT3002.WareHouseID

	Left Join (Select DivisionID, InventoryID, WareHouseID,
			SUM(case when TypeID <> ''PO'' and Finish <> 1 then OrderQuantity - ActualQuantity else  0 end) as SQuantity,
			SUM(case when TypeID = ''PO'' and Finish <> 1  then OrderQuantity - ActualQuantity else  0 end) as PQuantity
		From OV2800
		Group by DivisionID, InventoryID,WareHouseID
		) V02 on V02.DivisionID = OT3002.DivisionID and V02.InventoryID = ot3002.InventoryID and OT3002.WareHouseID = V02.WareHouseID
	left join  OT3102 WITH (NOLOCK) On OT3002.RefTransactionID = OT3102.TransactionID and OT3102.DivisionID= OT3002.DivisionID
	left join  OT3101 WITH (NOLOCK) On OT3002.InheritVoucherID = OT3101.VoucherNo and OT3101.DivisionID= OT3002.DivisionID
	left join AT1304 T34 WITH (NOLOCK) on T34.UnitID = OT3002.UnitID
	left join OV1101 on OT3001.OrderStatus = OV1101.OrderStatus and OV1101.TypeID=''PO'' and OV1101.DivisionID= OT3002.DivisionID
	Left Join AT1208 WITH (NOLOCK) on OT3001.PaymentTermID = AT1208.PaymentTermID
	left join OT1002 P01 WITH (NOLOCK) on P01.AnaTypeID = ''P01'' and P01.AnaID = OT3001.Ana01ID  and P01.DivisionID= OT3002.DivisionID
	left join OT1002 P02 WITH (NOLOCK) on P02.AnaTypeID = ''P02'' and P02.AnaID = OT3001.Ana02ID  and P02.DivisionID= OT3002.DivisionID
	left join OT1002 P03 WITH (NOLOCK) on P03.AnaTypeID = ''P03'' and P03.AnaID = OT3001.Ana03ID  and P03.DivisionID= OT3002.DivisionID
	left join OT1002 P04 WITH (NOLOCK) on P04.AnaTypeID = ''P04'' and P04.AnaID = OT3001.Ana04ID  and P04.DivisionID= OT3002.DivisionID
	left join OT1002 P05 WITH (NOLOCK) on P05.AnaTypeID = ''P05'' and P05.AnaID = OT3001.Ana05ID  and P05.DivisionID= OT3002.DivisionID
	left join POT2018 P18 WITH (NOLOCK) on OT3002.InheritTableID= P18.InheritTableID and OT3002.InheritVoucherID= P18.InheritVoucherID and OT3002.InheritTransactionID=P18.InheritTransactionID
	left join POT2017 P17 WITH (NOLOCK) on  P17.APK=P18.APK_Master
	left join POT2014 P14 WITH (NOLOCK) on  P17.LeadTimeID= P14.LeadTimeID and P14.DetailID= P18.ID_LeadtimeMOQ
'
SET @sSQLFrom1 = N' 
	left join POT2013 P13 WITH (NOLOCK) on  P13.LeadTimeID= P14.LeadTimeID
	left join AT1101 A11 WITH (NOLOCK) on A11.DivisionID = OT3002.DivisionID
Where OT3001.DivisionID = N''' + isnull(@DivisionID,'') + N''' and
         (OT3001.POrderID = N''' + isnull(@OrderID,'') + N'''
		 OR OT3001.VoucherNo = N''' + ISNULL(@OrderID,'') + N''')
Group by OT3002.DivisionID, A11.VATNO,
OT3001.POrderID,OT3001.VoucherNo,OT3001.OrderDate,  OT3001.Notes,OT3001.TransPort, OT3001.ObjectID, OT3001.ObjectName,  AT1202.ObjectName ,
	AT1202.Website, AT1202.Contactor, Phonenumber, AT1202.Tel, AT1202.Fax, AT1202.VATNo, OT3001.ReceivedAddress,  
	OT3001.Address, AT1202.Address, AT1002.CityName, OT3001.CurrencyID,  AT1004.CurrencyName,
	OT3001.ShipDate, OT3001.ExchangeRate, OT3001.ContractNo, OT3001.ContractDate,
	AT1202.CountryID,AT1001.CountryName,  AT1202.AreaID,
	AT1003.AreaName,AT1205.PaymentName,OT3001.EmployeeID, AT1103.FullName, AT1103.Address ,
	OT3002.InventoryID,OT3002. InventoryCommonName,
	AT1302.InventoryName,	AT1302.UnitID, 	AT1304.UnitName, AT1302.Specification,
	AT1302.Notes01 , AT1302.Notes02 ,AT1302.Notes03,
	AT1310_S1.SName , AT1310_S2.SName ,PurchasePrice, 
	OT3002.VATPercent,	OT3002.DiscountPercent, 
	OT3001.Ana01ID,OT3001.Ana02ID,OT3001.Ana03ID,OT1002.AnaName ,
	AT1302.I02ID, AT1015. AnaName,ImTaxpercent,T04.AnaName , V01.EndQuantity,
	SQuantity,PQuantity, Ot3002.WareHouseID, OT3101.ROrderID,
	OT3102.ROrderID,
	OT3101.OrderDate ,OT3101.Shipdate,OT3002.Notes, OT3002.Notes01, OT3002.Notes02, OT3002.ConvertedSalePrice, OT3002.UnitID, T34.UnitName,
	OT3001.OrderStatus, OV1101.Description, OT3002.Orders, OT3001.RequestID,
	OT3001.PaymentTermID, AT1208.PaymentTermName,
	AT1202.Email,
	OT3001.Varchar01, OT3001.Varchar02, OT3001.Varchar03, OT3001.Varchar04, OT3001.Varchar05,
	OT3001.Varchar06, OT3001.Varchar07, OT3001.Varchar08, OT3001.Varchar09, OT3001.Varchar10,
	OT3001.Varchar11, OT3001.Varchar12, OT3001.Varchar13, OT3001.Varchar14, OT3001.Varchar15,
	OT3001.Varchar16, OT3001.Varchar17, OT3001.Varchar18, OT3001.Varchar19, OT3001.Varchar20,
	OT3001.Ana04ID, OT3001.Ana05ID,OT3002.Description,
	P01.AnaName,
	P02.AnaName,
	P03.AnaName,
	P04.AnaName,
	P05.AnaName,
	P01.AnaNameE,
	P02.AnaNameE,
	P03.AnaNameE,
	P04.AnaNameE,
	P05.AnaNameE,
	OT3002.Notes03,
	P14.Quantity
	'
---OP3011 'PMT',7,2012,'PO/07/2012/0001'

--print @sSQL	
--print @sSQLFrom
--print @sSQLFrom1

If Not Exists (Select 1 From sysObjects Where Name ='OV3110')
	Exec ('Create view OV3110---tao boi OP3011
		as '+@sSQL + @sSQLFrom + @sSQLFrom1)
Else
	Exec( 'Alter view OV3110---tao boi OP3011
		as '+@sSQL + @sSQLFrom + @sSQLFrom1)

/*
--Xu ly in to khai hai quan

Delete From OT3050    

If Exists (Select 1 From sysObjects Where Name ='OV3050' and xType = 'V') Drop view OV3050

-- IN trang 1
If (Select COUNT(*) From OV3002)   < = 3

BEGIN
	
	Insert Into OT3050 (TransactionID, DivisionID) Select Top 3 TransactionID, @DivisionID From OV3002 Order by Orders

	If Not Exists (Select 1 From sysObjects Where Name ='OV3050' and xType = 'V')
	Exec ('Create view OV3050  ---tao boi OP3011
		as 
		Select Top 100 Percent * from OV3002 Where TransactionID In (Select TransactionID From OT3050) Order by Orders')
	Else
	Exec( 'Alter view OV3050  ---tao boi OP3011
		as 
		Select Top 100 Percent * from OV3002 Where TransactionID In (Select TransactionID From OT3050) Order by Orders')

Set @sSQLSelect = ''
Set @FieldCount = (select count(name) From syscolumns where id = object_id('OV3002'))
Set @NullRowInsert = REPLICATE('Null,',@FieldCount)
Set @NullRowInsert = LEFT(@NullRowInsert,LEN(@NullRowInsert)-1)

Select @RemainRows = 3 - Count(*) From OV3050

If @RemainRows>0 And @RemainRows<3
Begin
	Set @For = 1
	While @For <=@RemainRows
	Begin
		Set @sSQLSelect = @sSQLSelect +  ' Union All 
					Select ' + @NullRowInsert + ' 
					'		
		Set @For = @For + 1
	End
End
PRINT @sSQLSelect
If Not Exists (Select 1 From sysObjects Where Name ='OV3050' and xType = 'V')
	Exec ('Create view OV3050 ---tao boi OP3011
		as 
		Select * From (Select Top 100 Percent * from OV3002 Where TransactionID In (Select TransactionID From OT3050) Order by Orders) as OV02 ' + @sSQLSelect)
Else
	Exec( 'Alter view OV3050 ---tao boi OP3011
		as 
		Select * From (Select  Top 100 Percent * from OV3002 Where TransactionID In (Select TransactionID From OT3050) Order by Orders) as OV02 ' + @sSQLSelect)

End
-------------------------------

	Set @sSQLSelect =' Select  DivisionID, Quantity  = ( Select Sum(isnull (OrderQuantity,0))  from OV3002 ),
	                OriginalAmount = ( Select Sum(isnull (OriginalAmount,0))  from OV3002 ),
		Sum(isnull (ConvertedAMount,0)) as ConvertedAMount, ImTaxPercent, VATPercent  From OV3002
		Group by DivisionID, ImTaxPercent, VATPercent'
 

	If Not Exists (Select 1 From sysObjects Where Name ='OV3054')
	Exec ('Create view OV3054 ---tao boi OP3011
		as '+@sSQLSelect)
	Else
	Exec( 'Alter view OV3054  ---tao boi OP3011
		as '+@sSQLSelect)


IF (Select  count(*) from OV3054 )  > 3

Set @sSQLSelect = ' Select  DivisionID, Quantity  = ( Select Sum(isnull (OrderQuantity,0))  from OV3002 ),
					OriginalAmount = ( Select Sum(isnull (OriginalAmount,0))  from OV3002 ),
					ImAmount =  ( Select Sum(isnull (ImTaxConVertedAmount,0))  from OV3002 ),
					VATAmount =  ( Select Sum(isnull (VATConvertedAmount,0))  from OV3002 ),
					Sum(isnull (ConvertedAMount,0)) as ConvertedAMount, null as  ImTaxPercent,  null as VATPercent  From OV3002
					Group by DivisionID -- updated: 12/11/2014
		'

ELSE 
Set @sSQLSelect = ' Select  DivisionID, Quantity  = ( Select Sum(isnull (OrderQuantity,0))  from OV3002 ),
					OriginalAmount = ( Select Sum(isnull (OriginalAmount,0))  from OV3002 ),
					ImAmount =  ( Select Sum(isnull (ImTaxConVertedAmount,0))  from OV3002 ),
					VATAmount =  ( Select Sum(isnull (VATConvertedAmount,0))  from OV3002 ),
					Sum(isnull (ConvertedAMount,0)) as ConvertedAMount, ImTaxPercent, VATPercent  From OV3002
					Group by DivisionID, ImTaxPercent, VATPercent'




If Not Exists (Select 1 From sysObjects Where Name ='OV3055')
	Exec ('Create view OV3055 ---tao boi OP3011
		as '+@sSQLSelect)
	Else
	Exec( 'Alter view OV3055 ---tao boi OP3011
		as '+@sSQLSelect)


--:  Xu ly co goi  subFrom hay khong  ! @IsSubFrom = 0: khong goi from OF3015, @IsSubFrom = 1 co goi From
  Set @IsSubForm = 0
  Set @IsEdit = 0 


If (Select COUNT(*) From OV3002)    >  3
      Begin
	 sET  @IsSubForm = 1
	----Goto BaoANH

      End	



-- Tinh toan so lieu dua ra From OF3015


If  ( (Select distinct POrderID from OT3015 WHere  POrderID = @OrderID ) = @OrderID)
Begin
Set @IsEdit = 1 -- Load edit
End


Select @IsEdit as IsEdit, @IsSubForm as  IsSubForm

SET NOCOUNT OFF

*/



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

