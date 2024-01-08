IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Created by Hoang Thi Lan
--Date 17/10/2003
--Purpose:Dïng cho report doanh sè hµng b¸n
--Last Update Van Nhan, 16/08/2006
--Edit by Nguyen Quoc Huy Date 01/12/2008.
--Last Edit : Thuy Tuyen , date 12/08/2008
--Edit by: Dang Le Bao Quynh; Date:30/09/2009
--Purpose: Them 5 ma phan tich mat hang
--Edit by: Dang Le Bao Quynh; Date:19/10/2009
--Purpose: Them cac truong tien thue VAT
--Edit by: Dang Le Bao Quynh; Date:12/11/2009
--Purpose: Them cac truong Von dieu le, Note, Note1 cua doi tuong
--- Edit by B.Anh, date 05/12/2009	Lay them cac truong Loai chung tu, chiet khau
--- Edit by T.Phu, date 10/09/2012	Lay them cac truong AT9000.RefNo01, AT9000.RefNo02
---- Modified on 22/11/2012 by Le Thi Thu Hien : Bổ sung FieldName
---- Modified on 07/12/2012 by Le Thi Thu Hien : Bổ sung Khoan muc Ana06--> Ana10
--  exec AP3025 @DivisionID=N'AS',@FromDate='2012-12-07 10:02:25.37',@ToDate='2012-12-07 10:02:25.37',@FromMonth=5,@FromYear=2012,@ToMonth=5,@ToYear=2012,@IsDate=0,@IsDetail=1,@IsCustomer=0
-- Last Modified on 01/03/2013 by Thiên Huỳnh: Bổ sung InventoryTypeID, WareHouseID, WareHouseName
---- Modified on 17/04/2013 by Le Thi Thu Hien : Sửa lại lấy dữ liệu VATOriginalAmount, VATConvertedAmount
---- Modified on 05/03/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 24/03/2014 by Bảo Anh : Bổ sung InventoryTypeName, ComAmountOB, ComAmountEM, PriceInList (Long Trường Vũ)
---- Modified on 23/07/2014 by Mai Duyen : Bổ sung them field AT9000.Orders(KH Printech)
---- Modified on 08/08/2014 by Thanh Sơn: Bổ sung thêm điều kiện kết với bảng giá  'AND AT9000.PriceListID = OT1302.ID' do 1 mặt hàng có thể thuộc 2 bảng giá nên bị đúp dòng
---- Modified on 21/01/2015 by Mai Duyen : Bổ sung AT2007.SoureNo,AT2007.LimitDate   (Savi)
---- Modified on 20/03/2015 by Lê Thị Hạnh: Bổ sung lấy thông tin thuế BVMT: ETaxID, ETaxName, ETaxAmount, ETaxConvertedUnit, ETaxConvertedAmount
---- Modified on 10/09/2015 by Tiểu Mai: Bổ sung tên 10 MPT, 10 tham số Parameter.
---- Modified on 08/01/2016 by Tiểu Mai: Bổ sung thông tin quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified on 05/05/2016 by Bảo Anh: Bổ sung OrderID và MOrderID
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH(NOLOCK)
---- Modified on 25/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Thy on 28/04/2017: Bổ sung thông tin quy cách
---- Modified by Hải Long on 11/07/2017: Bổ sung 5 tham số Parameter của AT2007
---- Modified by Tiểu Mai on 30/08/2017: Bổ sung AT9000.ConvertedUnitID, AT9000.ConvertedQuantity
---- Modified by Bảo Anh on 09/03/2018: Bổ sung PrimeCostPrice1,PrimeCostAmount1
---- Modified by Tiểu Mai on 19/06/2018: Bổ sung AT9000.DParameter01 --> 10
---- Modified on 10/07/2018 by Bảo Anh : Bổ sung cột Số đơn hàng cho Karaben
---- Modified by Bảo Anh on 24/08/2018: Bổ sung TradeName, FileRef, InvoiceNote, TrafficType
---- Modified on 28/10/2018 by Bảo Anh : Trả thẳng dữ liệu không tạo view
---- Modified on 23/07/2020 by Nhựt Trường: Thay đổi cách lấy trường PrimeCostAmount1 để sửa lỗi cho trường hợp 1 phiếu xuất kế thừa ra 2 phiếu bán hàng
---- Modified on 28/07/2020 by Nhựt Trường: Thêm trường hợp, 1 phiếu xuất kế thừa ra 2 phiếu bán hàng thì PrimeCostAmount1 = AT2007.UnitPrice * AT9000.Quantity, còn lại thì lấy như cũ AT2007.ConvertedAmount. Và thêm Group By
---- Modified on 25/08/2020 by Nhựt Trường: Điều chỉnh lại cách lấy trường PrimeCostAmount1 đã sửa, chỉ dành cho customize GODREJ.
---- Modified on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified on 19/10/2020 by Nhựt Trường: Fix lỗi - (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified on 14/01/2021 by Văn Tài: Tách store AP3022 để tính giá vốn cho các mặt hàng là Bộ.
---- Modified on 13/08/2021 by Nhựt Trường: Fix lỗi - Bổ sung điều kiện DivisionID khi join bảng AT1303.
---- Modified on 08/09/2022 by Thành Sang: Bổ sung thêm điều kiện DivisionID khi join các bảng dùng chung.
---- Modified on 27/12/2022 by Nhật Thanh: Cập nhật lấy hạn dùng (LimitDate) từ AT9000 thay cho AT2007
---- Modified on 13/01/2023 by Thanh Lượng:[2023/01/IS/0074] - Bổ sung điều kiện lấy dữ liệu cho LimitDate(nếu không có AT9000 thì lấy từ AT2007).
---- Modified on 10/05/2023 by Nhựt Trường:[2023/05/IS/0040] - Fix lỗi thiếu group by AT2007.LimitDate
---- Modified on 21/06/2023 by Đình Định : Bổ sung cột InvoiceSign.

CREATE PROCEDURE [dbo].[AP3022] 
	@DivisionID as nvarchar(50) ,
	@sSQLWhere as nvarchar(max) ,
	@UserID AS VARCHAR(50) = ''
AS
declare @sSQL1 as nvarchar(max),
		@sSQL2 as nvarchar(max),
		@sSQL3 as nvarchar(max),
		@sSQL4 AS NVARCHAR(MAX),
		@sSQL5 as NVARCHAR(MAX),
		@sWhere as NVARCHAR(MAX),
		@GroupBy as NVARCHAR(MAX)
		
----------->>>> Kiem tra customize
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName AS Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444
-----------<<<< Kiem tra customize

IF(@CustomerName = 74) -- GODREJ.
BEGIN
	EXEC AP3022_GOD
			@DivisionID = @DivisionID,
			@sSQLWhere = @sSQLWhere,
			@UserID = @UserID
END
ELSE
BEGIN

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''	
if(Isnull(@sSQLWhere,'')<>'')
BEGIN
	SET @sSQLWhere = 'AND ' + @sSQLWhere
END

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 WITH(NOLOCK) ON AT0010.DivisionID = AT9000.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = AT9000.CreateUserID '
		SET @sWHEREPer = ' AND (AT9000.CreateUserID = AT0010.UserID
								OR  AT9000.CreateUserID = '''+@UserID+''') '		
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác

------ Thong tin quy cach------
SET @sSQL4 = ''
SET @sSQL5 = ''
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN

	SET @sSQL4 = ',
	O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
	O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20 '

	SET @sSQL5 = '
	LEFT JOIN AT8899 O99 WITH(NOLOCK) ON O99.DivisionID = AT9000.DivisionID AND O99.VoucherID = AT9000.VoucherID AND O99.TransactionID = AT9000.TransactionID
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON O99.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON O99.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON O99.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON O99.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON O99.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON O99.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON O99.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON O99.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON O99.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON O99.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON O99.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON O99.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON O99.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON O99.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON O99.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON O99.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON O99.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON O99.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON O99.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON O99.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20'' '
	
END
	
IF @CustomerName = 74 --(Customize GODREJ)	
	BEGIN
		set @sSQL1=N'
	SELECT  AT1202.ObjectID,
			AT1202.ObjectName,
			AT1202.TradeName,
			AT1202.Address,
			AT1202.LegalCapital,
			AT1202.Note,
			AT1202.Note1,
			AT9000.InventoryID,
			Case when isnull(AT9000.InventoryName1,'''')= '''' then  isnull(AT1302.InventoryName,'''')  Else AT9000.InventoryName1 end as InventoryName,
			AT1302.InventoryName AS InventoryName_AT1302,
			AT1302.UnitID,
			AT1304.UnitName,
	       	AT9000.Serial,
			AT9000.InvoiceNo,
			AT9000.VoucherNo,
			AT9000.InvoiceDate,
			AT9000.VoucherDate,
			isnull(AT9000.Quantity,0) as Quantity,
			AT9000.CurrencyID,
			AT9000.UnitPrice,
			isnull(AT9000.OriginalAmount,0)/(Case when isnull(AT9000.Quantity,0)=0 then 1 else AT9000.Quantity end) as SalePrice01,
			isnull(AT9000.ConvertedAmount,0)/(Case when isnull(AT9000.Quantity,0)=0 then 1 else AT9000.Quantity end) as SalePrice02,
			isnull(AT9000.OriginalAmount,0) as OriginalAmount,
			isnull(AT9000.ConvertedAmount,0) as ConvertedAmount, VATRate,  
			Isnull(AT9000.VATOriginalAmount,0) as VATOriginalAmount,
			Isnull(AT9000.VATConvertedAmount,0) as VATConvertedAmount,
			(Isnull (AT9000.UnitPrice,0) * Isnull (VATRate,0))/100  + Isnull(AT9000.UnitPrice,0) as VATUnitPrice,
			(Select Sum(Isnull (T9.OriginalAmount,0)) From AT9000 T9 Where T9.VoucherID = AT9000.VoucherID And T9.TransactionTypeID = ''T14'')  as VATOriginalAmountForInvoice,
			(Select Sum(Isnull (T9.ConvertedAmount,0)) From AT9000 T9 Where T9.VoucherID = AT9000.VoucherID And T9.TransactionTypeID = ''T14'')  as VATConvertedAmountForInvoice,

			isnull(AT2007.UnitPrice,0) as PrimeCostPrice,
			isnull(AT2007.ConvertedAmount,0) as PrimeCostAmount,
			isnull(A007.UnitPrice,0) as PrimeCostPrice1,
			CASE WHEN COUNT(A000.WTransactionID) > 1  and  COUNT(A000.InventoryID) > 1 
			THEN CONVERT(DECIMAL(28,8),CONVERT(DECIMAL(28,0),(isnull(A007.UnitPrice,0) * AT9000.Quantity)))
			ELSE isnull(A007.ConvertedAmount,0) END AS PrimeCostAmount1,
			---AT2007.DebitAccountID,
			----AT2007.CreditAccountID,
			AT9000.DebitAccountID,
			AT9000.CreditAccountID,
			AT9000.Orders,
			AT9000.Ana01ID,   AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID,   AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.VDescription, AT9000.BDescription, AT9000.TDescription, AT9000.Duedate,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID, AT0300.FileRef, AT0300.InvoiceNote, AT0300.TrafficType,	'
	END
ELSE
	BEGIN
		set @sSQL1=N'
	SELECT  AT1202.ObjectID,
			AT1202.ObjectName,
			AT1202.TradeName,
			AT1202.Address,
			AT1202.LegalCapital,
			AT1202.Note,
			AT1202.Note1,
			AT9000.InventoryID,
			Case when isnull(AT9000.InventoryName1,'''')= '''' then  isnull(AT1302.InventoryName,'''')  Else AT9000.InventoryName1 end as InventoryName,
			AT1302.InventoryName AS InventoryName_AT1302,
			AT1302.UnitID,
			AT1304.UnitName,
	       	AT9000.Serial,
			AT9000.InvoiceNo,
			AT9000.VoucherNo,
			AT9000.InvoiceDate,
			AT9000.InvoiceSign,
			AT9000.VoucherDate,
			isnull(AT9000.Quantity,0) as Quantity,
			AT9000.CurrencyID,
			AT9000.UnitPrice,
			isnull(AT9000.OriginalAmount,0)/(Case when isnull(AT9000.Quantity,0)=0 then 1 else AT9000.Quantity end) as SalePrice01,
			isnull(AT9000.ConvertedAmount,0)/(Case when isnull(AT9000.Quantity,0)=0 then 1 else AT9000.Quantity end) as SalePrice02,
			isnull(AT9000.OriginalAmount,0) as OriginalAmount,
			isnull(AT9000.ConvertedAmount,0) as ConvertedAmount, VATRate,  
			Isnull(AT9000.VATOriginalAmount,0) as VATOriginalAmount,
			Isnull(AT9000.VATConvertedAmount,0) as VATConvertedAmount,
			(Isnull (AT9000.UnitPrice,0) * Isnull (VATRate,0))/100  + Isnull(AT9000.UnitPrice,0) as VATUnitPrice,
			(Select Sum(Isnull (T9.OriginalAmount,0)) From AT9000 T9 Where T9.VoucherID = AT9000.VoucherID And T9.TransactionTypeID = ''T14'')  as VATOriginalAmountForInvoice,
			(Select Sum(Isnull (T9.ConvertedAmount,0)) From AT9000 T9 Where T9.VoucherID = AT9000.VoucherID And T9.TransactionTypeID = ''T14'')  as VATConvertedAmountForInvoice,

			isnull(AT2007.UnitPrice,0) as PrimeCostPrice,
			isnull(AT2007.ConvertedAmount,0) as PrimeCostAmount,
			isnull(A007.UnitPrice,0) as PrimeCostPrice1,
			isnull(A007.ConvertedAmount,0) as PrimeCostAmount1,
			---AT2007.DebitAccountID,
			----AT2007.CreditAccountID,
			AT9000.DebitAccountID,
			AT9000.CreditAccountID,
			AT9000.Orders,
			AT9000.Ana01ID,   AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID,   AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.VDescription, AT9000.BDescription, AT9000.TDescription, AT9000.Duedate,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID, AT0300.FileRef, AT0300.InvoiceNote, AT0300.TrafficType,	'
	END
		
set @sSQL2=N'
			O1.AnaName As O01Name, O2.AnaName As O02Name, O3.AnaName As O03Name, O4.AnaName As O04Name, O5.AnaName As O05Name,
			AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
			I1.AnaName As I01Name, I2.AnaName As I02Name, I3.AnaName As I03Name, I4.AnaName As I04Name, I5.AnaName As I05Name,
			AT9000.VoucherTypeID, AT9000.DiscountRate, AT9000.DiscountAmount, AT9000.DivisionID,
			AT9000.Parameter01,AT9000.Parameter02,AT9000.Parameter03,AT9000.Parameter04,
			AT9000.Parameter05,AT9000.Parameter06,AT9000.Parameter07,AT9000.Parameter08,AT9000.Parameter09,AT9000.Parameter10,
			A1.AnaName as Ana01Name, A2.AnaName as Ana02Name, A3.AnaName as Ana03Name, A4.AnaName as Ana04Name, A5.AnaName as Ana05Name,
			A6.AnaName as Ana06Name, A7.AnaName as Ana07Name, A8.AnaName as Ana08Name, A9.AnaName as Ana09Name, A101.AnaName as Ana10Name,
			AT9000.RefNo01, AT9000.RefNo02,
			(Select Count(ObjectID) From AT1202 A Where A.O02ID = AT1202.O02ID) As FieldName, 
			AT1302.InventoryTypeID, AT2006.WareHouseID, AT1303.WareHouseName, AT9000.IsMultiTax, AT2006.VoucherNo as WVoucherNo,
			AT1301.InventoryTypeName , AT2007.SourceNo, CASE WHEN ISNULL(AT9000.LimitDate,'''')!='''' then AT9000.LimitDate else AT2007.LimitDate end AS LimitDate,
			AT1302.ETaxID, AT93.ETaxName, ISNULL(AT95.ETaxAmount,0) AS ETaxAmount, 
			ISNULL(AT9000.ETaxConvertedUnit,0) AS ETaxConvertedUnit, ISNULL(AT9000.ETaxConvertedAmount,0) AS ETaxConvertedAmount,
			AT9000.OrderID, AT9000.MOrderID,
			AT2007.Parameter01 AS AT2007_Parameter01, AT2007.Parameter02 AS AT2007_Parameter02, AT2007.Parameter03 AS AT2007_Parameter03, AT2007.Parameter04 AS AT2007_Parameter04, AT2007.Parameter05 AS AT2007_Parameter05,
			AT9000.ConvertedUnitID, AT9000.ConvertedQuantity,
			AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
			AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10'

IF @CustomerName = 24 --- Long Trường Vũ
	set @sSQL2 = @sSQL2 + ',CMT1.ComAmount as ComAmountOB, CMT2.ComAmount as ComAmountEM, OT1302.UnitPrice as PriceInList'

IF @CustomerName = 45 --- Karaben
	set @sSQL2 = @sSQL2 + ', (SELECT TOP 1 OrderID FROM AT2007 WITH (NOLOCK) WHERE DivisionID = AT2006.DivisionID AND VoucherID = AT2006.VoucherID) AS OrderNo'

set @sSQL2 = @sSQL2 + @sSQL4 + '
	FROM AT9000 WITH(NOLOCK)
	LEFT JOIN AT9000 A000 WITH(NOLOCK) on A000.DivisionID = AT9000.DivisionID AND A000.WTransactionID = AT9000.WTransactionID
	LEFT JOIN AT1302 WITH(NOLOCK) on AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID=AT1302.InventoryID
	LEFT JOIN AT1301 WITH(NOLOCK) on AT1302.DivisionID IN (AT1301.DivisionID,''@@@'') AND AT1302.InventoryTypeID=AT1301.InventoryTypeID
	LEFT JOIN AT1015 I1 WITH(NOLOCK) On AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND AT1302.I01ID = I1.AnaID And I1.AnaTypeID = ''I01''
	LEFT JOIN AT1015 I2 WITH(NOLOCK) On AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND AT1302.I02ID = I2.AnaID And I2.AnaTypeID = ''I02''
	LEFT JOIN AT1015 I3 WITH(NOLOCK) On AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND AT1302.I03ID = I3.AnaID And I3.AnaTypeID = ''I03''
	LEFT JOIN AT1015 I4 WITH(NOLOCK) On AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND AT1302.I04ID = I4.AnaID And I4.AnaTypeID = ''I04''
	LEFT JOIN AT1015 I5 WITH(NOLOCK) On AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND AT1302.I05ID = I5.AnaID And I5.AnaTypeID = ''I05''
   	LEFT JOIN AT1202 WITH(NOLOCK) on AT1202.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.ObjectID=AT1202.ObjectID
	LEFT JOIN AT1304 WITH(NOLOCK) on AT1304.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1010 WITH(NOLOCK) on AT1010.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1010.VATGroupID = AT9000.VATGroupID
	LEFT JOIN AT2007 WITH(NOLOCK) on AT2007.TransactionID =AT9000.TransactionID and
						AT2007.InventoryID = AT9000.InventoryID and AT9000.DivisionID=AT2007.DivisionID
	LEFT JOIN AT2007 A007 WITH(NOLOCK) on A007.TransactionID =AT9000.WTransactionID and
						A007.InventoryID = AT9000.InventoryID and AT9000.DivisionID=A007.DivisionID
	LEFT JOIN AT0300 WITH(NOLOCK) ON AT0300.TransactionID = AT9000.InheritTransactionID AND AT9000.InheritTableID = ''AT0300''
	'
set @sSQL3=N'
	LEFT JOIN AT1015 O1 WITH(NOLOCK) on AT1202.O01ID = O1.AnaID And O1.AnaTypeID = ''O01''
	LEFT JOIN AT1015 O2 WITH(NOLOCK) on AT1202.O02ID = O2.AnaID And O2.AnaTypeID = ''O02''
	LEFT JOIN AT1015 O3 WITH(NOLOCK) on AT1202.O03ID = O3.AnaID And O3.AnaTypeID = ''O03''
	LEFT JOIN AT1015 O4 WITH(NOLOCK) on AT1202.O04ID = O4.AnaID And O4.AnaTypeID = ''O04''
	LEFT JOIN AT1015 O5 WITH(NOLOCK) on AT1202.O05ID = O5.AnaID And O5.AnaTypeID = ''O05''
	LEFT JOIN AT1011 A1 WITH(NOLOCK) on AT9000.Ana01ID = A1.AnaID and A1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A2 WITH(NOLOCK) on AT9000.Ana02ID = A2.AnaID and A2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A3 WITH(NOLOCK) on AT9000.Ana03ID = A3.AnaID and A3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A4 WITH(NOLOCK) on AT9000.Ana04ID = A4.AnaID and A4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A5 WITH(NOLOCK) on AT9000.Ana05ID = A5.AnaID and A5.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A6 WITH(NOLOCK) on AT9000.Ana06ID = A6.AnaID and A6.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A7 WITH(NOLOCK) on AT9000.Ana07ID = A7.AnaID and A7.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A8 WITH(NOLOCK) on AT9000.Ana08ID = A8.AnaID and A8.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A9 WITH(NOLOCK) on AT9000.Ana09ID = A9.AnaID and A9.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A101 WITH(NOLOCK) on AT9000.Ana10ID = A101.AnaID and A101.AnaTypeID = ''A10''
	LEFT JOIN AT2006 WITH(NOLOCK) on (AT9000.VoucherID = AT2006.VoucherID Or AT9000.WOrderID = AT2006.VoucherID) And AT9000.DivisionID = AT2006.DivisionID
	LEFT JOIN AT1303 WITH(NOLOCK) on AT1303.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND AT2006.WareHouseID = AT1303.WareHouseID
	LEFT JOIN AT0295 AT95 WITH(NOLOCK) ON AT95.VoucherID = AT9000.ETaxVoucherID AND AT1302.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT95.ETaxID = AT1302.ETaxID
	LEFT JOIN AT0293 AT93 WITH(NOLOCK) ON AT1302.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT93.ETaxID = AT1302.ETaxID '

IF @CustomerName = 24 --- Long Trường Vũ
	set @sSQL3 = @sSQL3 + N'
	LEFT JOIN (Select VoucherID,Sum(ComAmount) as ComAmount From CMT0010 WITH(NOLOCK) LEFT JOIN AT1202 T02 WITH(NOLOCK) on CMT0010.ObjectID = T02.ObjectID
				Where CMT0010.DivisionID = ''' + @DivisionID + ''' And Isnull(T02.ObjectTypeID,'''') <> ''NV'' Group by VoucherID) CMT1
	On AT9000.VoucherID = CMT1.VoucherID
	
	LEFT JOIN (Select VoucherID,Sum(ComAmount) as ComAmount From CMT0010 WITH(NOLOCK) LEFT JOIN AT1202 T02 WITH(NOLOCK) on CMT0010.ObjectID = T02.ObjectID
				Where CMT0010.DivisionID = ''' + @DivisionID + ''' And Isnull(T02.ObjectTypeID,'''') = ''NV'' Group by VoucherID) CMT2
	On AT9000.VoucherID = CMT2.VoucherID
	
	LEFT JOIN (Select InventoryID, OT1302.ID, UnitPrice, FromDate, ToDate From OT1302 WITH(NOLOCK) Inner join OT1301 WITH(NOLOCK) On OT1302.DivisionID = OT1301.DivisionID And OT1302.ID = OT1301.ID
				Where OT1302.DivisionID = ''' + @DivisionID + ''') OT1302
	On AT9000.InventoryID = OT1302.InventoryID and AT9000.VoucherDate >= OT1302.FromDate and AT9000.VoucherDate <= Isnull(OT1302.ToDate,''01/01/9999'')
	 AND AT9000.PriceListID = OT1302.ID
	'
	
set @sSQL3 = @sSQL3 + N'
	/*Lay truc tiep thue thue row
	LEFT JOIN (	SELECT	DivisionID, VoucherID, BatchID, OriginalAmount AS VATOriginalAmount, ConvertedAmount AS VATConvertedAmount
				FROM	AT9000 A  WITH(NOLOCK)
	           	WHERE	A.DivisionID = '''+@DivisionID+'''
	           			AND A.TransactionTypeID = ''T14''
				) VAT
		ON		VAT.DivisionID = AT9000.DivisionID AND VAT.VoucherID = AT9000.VoucherID 
				AND VAT.BatchID = AT9000.BatchID
	*/	
	'+@sSQLPer+ ''

SET @sWhere = '	
	WHERE	AT9000.DivisionID='''+@DivisionID+'''
			'+@sWHEREPer+'
			and AT9000.TransactionTypeID in (''T04'',''T40'')
			'+@sSQLWhere+''

SET @GroupBy = 'Group By AT1202.ObjectID,
			AT1202.ObjectName,
			AT1202.TradeName,
			AT1202.Address,
			AT1202.LegalCapital,
			AT1202.Note,
			AT1202.Note1,
			AT9000.InventoryID,
			A007.TransactionID,
			AT9000.InventoryName1,
			AT1302.InventoryName,
			AT1302.UnitID,
			AT1304.UnitName,
	       	AT9000.Serial,
			AT9000.InvoiceNo,
			AT9000.InvoiceSign,
			AT9000.VoucherNo,
			AT9000.InvoiceDate,
			AT9000.VoucherDate,
			AT9000.Quantity,
			AT9000.CurrencyID,
			AT9000.UnitPrice,
			AT9000.VoucherID,
			AT9000.OriginalAmount,
			AT9000.ConvertedAmount,
			VATRate,
			AT9000.VATOriginalAmount,
			AT9000.VATConvertedAmount,
			AT2007.UnitPrice,
			AT2007.ConvertedAmount,
			A007.UnitPrice,
			AT9000.WTransactionID,
			A007.ConvertedAmount,
			AT9000.DebitAccountID,
			AT9000.CreditAccountID,
			AT9000.Orders,
			AT9000.Ana01ID,   AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID,   AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.VDescription, AT9000.BDescription, AT9000.TDescription, AT9000.Duedate,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID, AT0300.FileRef, AT0300.InvoiceNote, AT0300.TrafficType,
			O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName,
			A1.AnaName, A2.AnaName , A3.AnaName , A4.AnaName , A5.AnaName ,
			A6.AnaName, A7.AnaName , A8.AnaName, A9.AnaName, A101.AnaName,
			AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
			I1.AnaName, I2.AnaName, I3.AnaName, I4.AnaName, I5.AnaName,
			AT9000.VoucherTypeID, AT9000.DiscountRate, AT9000.DiscountAmount, AT9000.DivisionID,
			AT9000.Parameter01,AT9000.Parameter02,AT9000.Parameter03,AT9000.Parameter04,
			AT9000.Parameter05,AT9000.Parameter06,AT9000.Parameter07,AT9000.Parameter08,AT9000.Parameter09,AT9000.Parameter10,
			AT9000.RefNo01, AT9000.RefNo02,
			AT1302.InventoryTypeID, AT2006.WareHouseID, AT1303.WareHouseName, AT9000.IsMultiTax, AT2006.VoucherNo,
			AT1301.InventoryTypeName , AT2007.SourceNo, CASE WHEN ISNULL(AT9000.LimitDate,'''')!='''' then AT9000.LimitDate else AT2007.LimitDate end,
			AT95.ETaxAmount,
			AT9000.ETaxConvertedUnit,
			AT9000.ETaxConvertedAmount,
			AT1302.ETaxID, AT93.ETaxName,
			AT9000.OrderID, AT9000.MOrderID,
			AT2007.Parameter01,
			AT2007.Parameter02,
			AT2007.Parameter03,
			AT2007.Parameter04,
			AT2007.Parameter05,
			AT9000.ConvertedUnitID, AT9000.ConvertedQuantity,
			AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
			AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10
			'



--IF  EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'AV3025' AND XTYPE ='V')
--	DROP VIEW AV3025
--EXEC ('CREATE VIEW AV3025 --tao boi AP3022
--			 as '+@sSQL1+@sSQL2+@sSQL3+@sSQL5+@sWhere+@GroupBy)

PRINT(@sSQL1)
PRINT(@sSQL2)
PRINT(@sSQL3)
PRINT(@sSQL5)
PRINT(@sWhere)
PRINT(@GroupBy)

EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL5+@sWhere+@GroupBy)

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


