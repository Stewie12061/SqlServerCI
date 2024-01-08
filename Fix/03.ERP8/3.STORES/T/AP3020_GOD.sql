IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3020_GOD]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP3020_GOD]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>  
---- Dung cho Report AR3014(report ban hang)   
-- <Param>  
----   
-- <Return>  
----   
-- <Reference>  
----   
-- <History>  
---- Created by Hoang Thi Lan on 06/10/2003  
---- Edit by Nguyen Quoc Huy 14/05/2007  
---- Last Edit thuy Tuyen  09/07/2007 --Them truong RDAddress, commistion  
---- Last Edit Thuy Tuyen 3/10/2007 --Lay them truong Image01ID,Image01ID,  
---- Last Edit Bao Anh 05/05/2008   --- Lay them truong VoucherDate, EmployeeID, FullName,  
---- viet customer lay so lo cho Dai Viet--  
---- Edit by: Dang Le Bao Quynh  
---- Bo sung bien ket noi  
---- Edit by: Dang Le Bao Quynh; Date: 12/11/2008  
---- Purpose: Them ten ma phan tich 2 - 5  
---- Edit by: Dang Le Bao Quynh; Date: 20/11/2008  
---- Purpose: Them truong so tien chiet khau  
---- Edit by: Dang Le Bao Quynh; Date: 01/12/2008  
---- Purpose: Them truong A.RepaymentTermID  
---- Edit by: Dang Le Bao Quynh; Date: 11/12/2008  
---- Purpose: Them truong IsMultitax  
---- Edit by B.Anh  Lay them cac truong ghi chu 1 & 2 cua doi tuong  
---- Edit by .Thuy Tuyen   Lay them cac truong VATGroupID, VATGroupName, 22/06/2009, 07/07/2009: Them truong  OT2001.DeliveryAddress,17/07/2009  
---- Edit by B.Anh, date 05/08/2009, bo sung cho truong hop xuat kho ban' hang  
---- Edit by: Dang Le Bao Quynh; Date: 29/09/2009  
---- Purpose: Them truong SalePrice01  
---- Edit by: Dang Le Bao Quynh; Date: 06/10/2009  
---- Purpose: Them truong Ten phan tich doi tuong 1-5  
---- Edit by B.Anh, date 08/10/2009, lay truong IsDiscount (mat hang thuong doanh so)  
---- Edit by B.Anh, date 25/11/2010, lay truong logo cua don vi  
---- Edit by : Dang Le Bao Quynh; Date: 06/12/2010  
---- Purpose: Bo sung cac dong trong cho du so luong dong in hoa don  
---- Edit by B.Anh, Date: 08/12/2010 - Purpose: Lay cac truong tham so, lay VATRate cho cac dong NULL  
---- Modified on 14/11/2011 by Le Thi Thu Hien : Bo sung RecievedPrice  
---- Modified on 09/01/2012 by Le Thi Thu Hien : Bo sung ReCreditLimit, PaCreditLimit,PaPaymentTermID,ReDueDays, PaDueDays,Redays, ReceivedAmount, PaymentAmount, OverDueAmount  
---- Modified on 09/01/2012 by Le Thi Thu Hien : Loi NULL khi INSERT vao bang tam  
---- Modified on 11/05/2012 by Huynh Tan Phu: Thay the LEFT JOIN AV1319 ON (AV1319.InventoryID = AT1302.InventoryID AND AV1319.UnitID = AT9000.UnitID thanh LEFT JOIN AV1319 ON (AV1319.InventoryID = AT1302.InventoryID AND AV1319.UnitID = AT9000.ConvertedUnitID  
---- Edit by Trung Dung, Date: 31/08/2012 - Purpose: Lay them truong RecordNum(So dong thuc te cua hoa don)  
---- Modified on 28/11/2012 by Le Thi Thu Hien : B? sung kho?ng m?c 6 -> 10  
---- Modified on 03/01/2013 by Bao Anh : B? sung các tru?ng Counter dùng cho hóa don phí b?n ch?p c?a Siêu Thanh  
---- Modified on 29/03/2013 by Bao Quynh : Them dieu kien DivisionID  
---- Modified on 14/06/2013 by Trung Dung : Fix loi insert null truong IsStock  
---- Modified on 21/02/2014 by Mai Duyen : Bo sung them filed AT2006.VoucherNo  
---- Modified on 20/05/2014 by Mai Duyen : Bo sung them filed  AT9000.ConvertedQuantity, AT9000.ConvertedPrice (KH Vimec)  
---- Modified on 31/12/2014 by Thanh Sơn: Lấy thêm trường CreateDate cho LAVO  
---- Modified on 06/10/2015 by Tieu Mai: Bổ sung thêm trường VATNoCustomer, CountryID, CountryName, NotesAna02  
---- Modified on 21/10/2015 by Tieu Mai: bổ sung thêm trường CityName  
---- Modified on 26/10/2015 by Phuong Thao: bổ sung in hóa đơn tại màn hình xuất kho (nghiệp vụ hàng biếu tặng)  
---- Modified on 19/11/2015 by Quốc Tuấn: Bổ sung thêm trường số lần in  
---- Modified on 28/12/2015 by Tiểu Mai: Bổ sung thông tin quy cách khi có thiết lập quản lý mặt hàng theo quy cách  
---- Modified on 06/01/2016 by Kim Vu : Bổ sung kiem tra CurrencyID NULL  
---- Modified on 14/01/2016 by Kim Vu : Bo sung VoucherNo_AT2006A so chung tu ke thua tu xuat kho  
---- Modified on 29/12/2016 by Bảo Thy: Bổ sung CommissionDescription  
---- Modified on 04/01/2017 by Hải Long: Sửa lại câu join với bảng OT2002  
---- Modified on 04/01/2017 by Hải Long: Bổ sung DParameter01 - DParameter10, AT9000_Refinfor 
---- Modified on 10/01/2017 by Hồng Vu: Bổ sung CommissionAmount 
---- Modified by Kim Thư on 12/09/2018: Bổ sung WITH(NOLOCK) tránh bị deadlock
---- Modified by Kim Thư on 20/12/2018: Lấy thêm thông tin phiếu xuất kho, Sửa lỗi tạo bảng tạm chứa ConnID 
---- Modified on 08/09/2020 by Nhựt Trường: Lây thêm trường: VATConvertedAmount, VATOriginalAmount
---- Modified on 08/09/2020 by Nhựt Trường: Lây thêm trường: I01Name -> I05Name
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 06/11/2020: Cắt bớt chuỗi @sSql2 bỏ sang chuỗi @sSql2a để fix lỗi tràn dữ liệu.
---- Modified by Hoài Phong  on 09/12/2020: Lấy PaymentID trong AT9000
---- Modified by Xuân Nguyên on 12/04/2022: [2022/04/IS/0053]Bổ sung ExInvoiceNo
---- Modified by Xuân Nguyên on 22/04/2022: fix lỗi Ambiguous InvoiceNo
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Example :   
/*  
exec sp_executesql N'  
      AP3020_GOD ''GS'', @VoucherID, @ConnID, @IsParticularBill  
    ',N'@VoucherID nvarchar(38),@ConnID nvarchar(2),@IsParticularBill bit',@VoucherID=N'AV2f119439-765d-4532-a2ca-6bba4352cb2d',@ConnID=N'62',@IsParticularBill=1  
*/  
CREATE PROCEDURE AP3020_GOD  
(   
    @DivisionID NVARCHAR(50),  
          @VoucherID NVARCHAR(50),   
          @ConnID VARCHAR(100) = '',   
          @IsParticularBill BIT = 1,  
          @InvoiceRow INT = 15  
 )  
AS  
DECLARE @sSql NVARCHAR(MAX),  
  @sSql1 NVARCHAR(MAX),  
  @sSql2 VARCHAR(MAX),  
  @sSql2a VARCHAR(MAX),  
  @sSql3 VARCHAR(MAX),  
  @sSQL5 VARCHAR(MAX),  
  @sSqlUnion NVARCHAR(MAX),  
  @Count INT,  
  @AddRows INT,  
  @CurrencyID VARCHAR(50),  
  @VATRate MONEY    
------------------>>> Lay so du cong no  
DECLARE @ReAccountID NVARCHAR(50),  
  @PaAccountID NVARCHAR(50),  
  @ReceivedAmount DECIMAL(28,8),  
  @PaymentAmount DECIMAL(28,8),  
  @OverDueAmount DECIMAL(28,8),  
  @ExchangeRateDecimal TINYINT,  
  @ObjectID NVARCHAR(50),  
  @VoucherDate DATETIME,  
  @CustomizeIndex INT,  
  @sSQL4 NVARCHAR(2000) ='',  
  @TransactionTypeID NVarchar(50) = '',  
  @PrintedTimes INT=0  
SET @sSQL5 = ''  
SELECT TOP 1 @TransactionTypeID =  TransactionTypeID,@ObjectID = ObjectID, @VoucherDate = VoucherDate  
FROM AT9000  
WHERE VoucherID = @VoucherID  
ORDER BY TransactionTypeID  
  
SET @ObjectID = ISNULL(@ObjectID, '')  
SET @VoucherDate = ISNULL(@VoucherDate, GETDATE())  
  
SET @PrintedTimes = ISNULL((SELECT COUNT(VoucherID) FROM AT1112 WHERE AT1112.DivisionID=@DivisionID AND AT1112.VoucherID=@VoucherID),0)  
    
SET @CustomizeIndex = ISNULL((SELECT TOP 1 CustomerName FROM CustomerIndex), -1)  
IF @CustomizeIndex = 40 SET @sSQL4 = 'AT9000.TransactionTypeID in (''T04'',''T40'',''T64'', ''T14'')  
 AND (AT9000.OriginalAmount <> 0 OR AT9000.TransactionTypeID <> ''T14'') ' -- LONG GIANG  
ELSE  
 IF @TransactionTypeID = 'T06' SET  @sSQL4 = 'AT9000.TransactionTypeID in (''T06'')'  
 ELSE SET @sSQL4 = 'AT9000.TransactionTypeID in (''T04'',''T40'',''T64'')'  
  
  
SET @ExchangeRateDecimal = (SELECT TOP 1 ExchangeRateDecimal FROM AT1004 WHERE CurrencyID = @CurrencyID)  
SET @ExchangeRateDecimal = ISNULL(@ExchangeRateDecimal, 0)  
  
SELECT TOP 1 @ReAccountID = ReAccountID, @PaAccountID = PaAccountID  
FROM AT1202   
WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID = @ObjectID  
SET @ReAccountID = ISNULL(@ReAccountID, '')  
SET @PaAccountID = ISNULL(@PaAccountID, '')  
         
---------------<<<<< Lay so du cong no  
IF (@TransactionTypeID = 'T06')  
BEGIN  
 SET @Count = (SELECT COUNT(*)   
     FROM AT9000 WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID   
     AND TransactionTypeID IN ('T06'))  
END  
ELSE  
BEGIN  
 SET @Count = (SELECT COUNT(*)   
     FROM AT9000 WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID   
     AND TransactionTypeID IN ('T04','T40','T64'))  
END  
  
IF (@TransactionTypeID = 'T06')  
BEGIN  
 SELECT @CurrencyID =  'VND', @VATRate = AT1010.VATRate  
 FROM AT9000  
 LEFT JOIN AT1010 ON AT1010.VATGroupID = AT9000.VATGroupID  
 WHERE VoucherID = @VoucherID AND TransactionTypeID IN ('T06') AND AT9000.DivisionID = @DivisionID  
END  
ELSE   
BEGIN  
 SELECT @CurrencyID = AT9000.CurrencyID, @VATRate = AT1010.VATRate  
 FROM AT9000  
 LEFT JOIN AT1010 ON AT1010.VATGroupID = AT9000.VATGroupID  
 WHERE VoucherID = @VoucherID AND TransactionTypeID IN ('T04','T40','T64') AND AT9000.DivisionID = @DivisionID  
END  
  
  
SET @AddRows = @InvoiceRow - (@Count % @InvoiceRow)  
SET @sSqlUnion = ''  
SET @CurrencyID = ISNULL(@CurrencyID,'VND')  
SET @sSql = '  
SELECT 0 AS TaxOrders, AT9000.Orders, AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,  
 AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,  
 A1.AnaName AS AnaName1, A2.AnaName AS AnaName2, A3.AnaName AS AnaName3, A4.AnaName AS AnaName4,  
 A5.AnaName AS AnaName5, A6.AnaName AS AnaName6, A7.AnaName AS AnaName7, A8.AnaName AS AnaName8,  
 A9.AnaName AS AnaName9, A10.AnaName AS AnaName10, A1.RefDate AS Ana01RefDate, AT9000.InventoryID,   
 AT9000.UnitID, AV1319.UnitID AS ConversionUnitID, AV1319.ConversionFactor, AV1319.UnitName AS ConversionUnitName,  
 AT9000.OrderID, AT1304.UnitName,  
 --(AT9000.OriginalAmount/Quantity) AS UnitPrice,   
 AT9000.UnitPrice, AT9000.Quantity, AT9000.OriginalAmount, Cast(isnull(AT9000.DiscountRate,0) AS Decimal(28,8)) AS DiscountRate,  
 AT9000.DiscountAmount, AT9000.ConvertedAmount,  
 Serial,AT9000.InvoiceNo,   
 CASE WHEN isnull(AT9000.InventoryName1,'''') ='''' THEN AT1302.InventoryName ELSE AT9000.InventoryName1 end AS InventoryName ,  
 AT1302.Specification, AT1302.Notes01 AS InventoryNotes01, AT1302.Notes02 AS InventoryNotes02, AT1302.Notes03 AS InventoryNotes03,  
 AT1302.InventoryTypeID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, A.S1, A.S2, A.S3,  
 AT9000.ObjectID, A.ObjectName AS ObjectName01, A.Email AS ObjectEmail, A.Tel AS ObjectTel, A.Fax AS ObjectFax,  
 A.Address AS ObjectAddress, A.Note, A.Note1, A.Contactor AS ObjectContactor,      -- Nguoi lien he AT1202  
 (SELECT ContactPerson FROM AT2006 WHERE VoucherID = AT9000.VoucherID AND DivisionID = '''+@DivisionID+''') AS Contactor, -- Nguoi lien he xuat kho ban hang  
 OT2001.contact AS OPContact,   --- Nguoi lien he lay tu  OP  
 A.BankName, A.BankAccountNo, (CASE WHEN Isnull(AT9000.VATObjectAddress, '''') <> '''' THEN AT9000.VATObjectAddress ELSE   
          CASE WHEN isnull(AT9000.VATObjectID,'''') ='''' THEN  A.Address ELSE B.Address end  End ) AS ObAddress,  
 ----A.Contactor,  
 AT9000.PaymentID, AT1205.PaymentName, AT9000.PaymentTermID, AT1208_P.PaymentTermName,  
 Isnull(OT2001.PaymentTermID, A.RepaymentTermID) as RepaymentTermID,  
 AT1208_R.PaymentTermName AS RePaymentTermName, AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.VoucherDate,  
 isnull(AT9000.EmployeeID,OT2001.EmployeeID) AS EmployeeID, AT1103.FullName,  
 AT9000.InvoiceDate,   
 AT9000.DivisionID, AT1101.DivisionName, AT1101.Address, AT1101.Tel, AT1101.Fax,   
 AT1101.VATNO AS DivisionVATNO, CASE WHEN (AT9000.TransactionTypeID = ''T06'') THEN ''VND'' ELSE AT9000.CurrencyID END CurrencyID,   
 AT1010.VATRate, AT1010.VATGroupID, AT1010.VATGroupName,  
 CASE WHEN AT9000.TransactiontypeID = ''T14'' THEN AT9000.TDescription ELSE AT9000.VDescription END VDescription,  
 AT9000.BDescription, AT9000.TDescription, T2.CommissionDescription,T2.CommissionAmount, AT9000.Refinfor AS AT9000_Refinfor,  
 AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,  
 AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10,  
 TB.SOrderID,'  
   
SET @sSql1 ='   
 AT1302.Varchar01,AT1302.Varchar02,AT1302.Varchar03,AT1302.Varchar04,AT1302.Varchar05,  
 AT9000.ExchangeRate,  
 OriginalAmountTax = (CASE WHEN (SELECT Sum(isnull(OriginalAmount,0))   
   FROM AT9000 T9   WITH (NOLOCK)   
   WHERE TransactiontypeID in (''T14'',''T40'')  AND VoucherID = AT9000.VoucherID AND DivisionID = ''' + @DivisionID + ''') is null  
   then 0 ELSE (SELECT Sum(isnull(OriginalAmount,0))   
   FROM AT9000 T9   WITH (NOLOCK)   
   WHERE TransactiontypeID in (''T14'',''T40'')  AND VoucherID = AT9000.VoucherID  AND DivisionID = ''' + @DivisionID + ''') end),  
 ConvertedAmountTax = (CASE WHEN (SELECT Sum(isnull(ConvertedAmount,0))   
   FROM AT9000 T9   WITH (NOLOCK)   
   WHERE TransactiontypeID in (''T14'',''T40'')  AND T9. VoucherID = AT9000.VoucherID  AND DivisionID = ''' + @DivisionID + ''') is null  
   then 0 ELSE (SELECT Sum(isnull(ConvertedAmount,0))   
   FROM AT9000 T9    WITH (NOLOCK)  
   WHERE TransactiontypeID in (''T14'',''T40'')  AND T9. VoucherID = AT9000.VoucherID  AND DivisionID = ''' + @DivisionID + ''') end),  
   
   
 AT9000.VATObjectID,  
 (CASE WHEN B.IsUpdateName =1 THEN AT9000.VATObjectName ELSE   
      CASE WHEN isnull(AT9000.VATObjectID,'''') <>''''  THEN B.ObjectName  
   ELSE A.ObjectName  End End) AS ObjectName,  
   
 (CASE WHEN   B.IsUpdateName =1 THEN  AT9000.VATNo ELSE   
      CASE WHEN isnull(AT9000.VATObjectID,'''') <>''''  THEN B.VATNo  
   ELSE A.VATNo  End End) AS VATNo,  
  
 AT2006.ContactPerson,  
  
 OT2002.Notes, OT2002.Notes01, OT2002.Notes02, AT2006.RDAddress,  
 OT2001.SalesManID, T3.FullName AS SalesManName,   
 OT2001.DeliveryAddress, OT2001.ContractNo,OT2001.Shipdate, OT2002.RefInfor,  
 AT9000.CommissionPercent, OT2001.Transport,  
 AT1302.Image01ID,  
 AT1302.Image02ID,  
 (CASE WHEN AT1302.Image01ID IS NULL THEN 0 ELSE 1 END ) AS IsImage01,  
 AT9000.CreditAccountID ,  
 AT9000.DebitAccountID,  
 AT2007.SourceNo, AT2007.LimitDate,  
 AT9000.Duedate, A.DeAddress, AT1009.VATTypeName,   
 A.O01ID, A.O02ID, A.O03ID,A.O04ID,A.O05ID,  
 O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name,   
 AT9000.IsMultiTax, A.TradeName, AT1302.RefInventoryID, AT1302.SalePrice01, AT1302.IsDiscount,  
 AT0000.Image01ID AS Logo,   
 AT0000.Image02ID AS Background,  
 AT9000.Parameter01,  
 AT9000.Parameter02,  
 AT9000.Parameter03,  
 AT9000.Parameter04,  
 AT9000.Parameter05,  
 AT9000.Parameter06,  
 AT9000.Parameter07,  
 AT9000.Parameter08,  
 AT9000.Parameter09,  
 AT9000.Parameter10,  
 AT1302.RecievedPrice,  
 A.ReCreditLimit,  
 A.PaCreditLimit,  
 A.PaPaymentTermID,  
 A.ReDueDays,   
 A.PaDueDays,  
 A.Redays,   
 R.ReceivedAmount,  
 P.PaymentAmount,  
 O.OverDueAmount  
 , '+ LTRIM(RTRIM(STR(@Count))) +'  as  RecordNum,  
 AT9000.NewCounter, AT9000.OldCounter, AT9000.OtherCounter, Isnull(AT9000.IsStock,0) as IsStock,  
 AT2006.VoucherNo as VoucherNo_AT2006,  
 AT9000.ConvertedQuantity, AT9000.ConvertedPrice, AT9000.CreateDate,  
 A.VATNo as VATNoCustomer, A.CountryID, AT1001.CountryName, AT1015.Notes as NotesAna02, AT1002.CityName,  
 '+STR(@PrintedTimes)+' PrintedTimes, AT2006A.VoucherNo as VoucherNo_AT2006A,  AT2007.UnitPrice as UnitPriceAT2007, AT2007.OriginalAmount as OriginalAmountAT2007, AT2007.ConvertedAmount as ConvertedAmountAT2007,
I1.AnaName AS I01Name,I2.AnaName AS I02Name ,I3.AnaName AS I03Name, I4.AnaName AS I04Name, I5.AnaName AS I05Name,
AT9000.VATConvertedAmount, AT9000.VATOriginalAmount,AT9000.ExInvoiceNo
 '  
  
SET @sSql2 = '   
FROM AT9000  WITH (NOLOCK)   
LEFT JOIN (SELECT DivisionID, VoucherID, BatchID, MAX(BDescription) AS CommissionDescription,  sum(ConvertedAmount) as CommissionAmount FROM AT9000 T1   
   WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.TransactionTypeID = ''T54'' AND T1.VoucherID = '''+@VoucherID+'''  
   GROUP BY DivisionID, VoucherID, BatchID  
    ) T2  
 ON T2.DivisionID = AT9000.DivisionID AND AT9000.VoucherID = T2.VoucherID AND AT9000.BatchID = T2.BatchID  
LEFT JOIN AT1302  WITH (NOLOCK) ON (AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID)  
LEFT JOIN AT1304  WITH (NOLOCK) ON (AT1304.UnitID = AT9000.UnitID AND AT1304.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1202 A  WITH (NOLOCK) ON (A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A.ObjectID = AT9000.ObjectID)  
LEFT JOIN AT1202 B  WITH (NOLOCK) ON (B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND B.ObjectID = AT9000.VATObjectID)  
LEFT JOIN AT1015 O1  WITH (NOLOCK) on  (O1.AnaID = A.O01ID AND  O1.AnaTypeID = ''O01'' AND O1.DivisionID = A.DivisionID)  
LEFT JOIN AT1015 O2  WITH (NOLOCK) on  (O2.AnaID = A.O02ID AND  O2.AnaTypeID = ''O02'' AND O2.DivisionID = A.DivisionID)  
LEFT JOIN AT1015 O3  WITH (NOLOCK) on  (O3.AnaID = A.O03ID AND  O3.AnaTypeID = ''O03'' AND O3.DivisionID = A.DivisionID)  
LEFT JOIN AT1015 O4  WITH (NOLOCK) on  (O4.AnaID = A.O04ID AND  O4.AnaTypeID = ''O04'' AND O4.DivisionID = A.DivisionID)  
LEFT JOIN AT1015 O5  WITH (NOLOCK) on  (O5.AnaID = A.O05ID AND  O5.AnaTypeID = ''O05'' AND O5.DivisionID = A.DivisionID)
LEFT JOIN AT1015 I1  WITH (NOLOCK) on  (AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID AND  I1.AnaTypeID = ''I01'')
LEFT JOIN AT1015 I2  WITH (NOLOCK) on  (AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I02ID AND  I2.AnaTypeID = ''I02'')
LEFT JOIN AT1015 I3  WITH (NOLOCK) on  (AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I03ID AND  I3.AnaTypeID = ''I03'')
LEFT JOIN AT1015 I4  WITH (NOLOCK) on  (AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I04ID AND  I4.AnaTypeID = ''I04'')
LEFT JOIN AT1015 I5  WITH (NOLOCK) on  (AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I05ID AND  I5.AnaTypeID = ''I05'')  
LEFT JOIN AT1101  WITH (NOLOCK) ON AT1101.DivisionID=AT9000.DivisionID  
LEFT JOIN AT1010  WITH (NOLOCK) ON (AT1010.VATGroupID = AT9000.VATGroupID AND AT1010.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A1  WITH (NOLOCK) on ( A1.AnaID = AT9000.Ana01ID AND  A1.AnaTypeID = ''A01'' AND A1.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A2  WITH (NOLOCK) on ( A2.AnaID = AT9000.Ana02ID AND  A2.AnaTypeID = ''A02'' AND A2.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A3  WITH (NOLOCK) on ( A3.AnaID = AT9000.Ana03ID AND  A3.AnaTypeID = ''A03'' AND A3.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A4  WITH (NOLOCK) on ( A4.AnaID = AT9000.Ana04ID AND  A4.AnaTypeID = ''A04'' AND A4.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A5  WITH (NOLOCK) on ( A5.AnaID = AT9000.Ana05ID AND  A5.AnaTypeID = ''A05'' AND A5.DivisionID = AT9000.DivisionID)  
  
LEFT JOIN AT1011 A6  WITH (NOLOCK) on ( A6.AnaID = AT9000.Ana06ID AND  A6.AnaTypeID = ''A06'' AND A6.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A7  WITH (NOLOCK) on ( A7.AnaID = AT9000.Ana07ID AND  A7.AnaTypeID = ''A07'' AND A7.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A8  WITH (NOLOCK) on ( A8.AnaID = AT9000.Ana08ID AND  A8.AnaTypeID = ''A08'' AND A8.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A9  WITH (NOLOCK) on ( A9.AnaID = AT9000.Ana09ID AND  A9.AnaTypeID = ''A09'' AND A9.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1011 A10  WITH (NOLOCK) on ( A10.AnaID = AT9000.Ana10ID AND  A10.AnaTypeID = ''A10'' AND A10.DivisionID = AT9000.DivisionID)  
  
LEFT JOIN OT2002  WITH (NOLOCK) ON OT2002.SOrderID = At9000.OrderID AND OT2002.TransactionID = AT9000.OTransactionID AND OT2002.DivisionID = AT9000.DivisionID  
'  
  
SET @sSql2a = '
LEFT JOIN OT2001  WITH (NOLOCK) ON (OT2001.SOrderID = AT9000.OrderID AND OT2001.DivisionID = AT9000.DivisionID) --- lay nguoi lien he
LEFT JOIN AT2006  WITH (NOLOCK) ON (AT2006.VoucherID = AT9000.VoucherID AND AT2006.DivisionID = AT9000.DivisionID)  
LEFT JOIN AV1319  WITH (NOLOCK) ON (AT1302.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV1319.InventoryID = AT1302.InventoryID AND AV1319.UnitID = AT9000.ConvertedUnitID)  
LEFT JOIN AT2007  WITH (NOLOCK) ON (AT2007.VoucherID =  AT9000.VoucherID  
      AND AT2007.TransactionID =AT9000.TransactionID AND AT2007.DivisionID =  AT9000.DivisionID)  
LEFT JOIN AT1009  WITH (NOLOCK) ON (AT9000.VATTypeID = AT1009.VATTypeID AND AT9000.DivisionID = AT1009.DivisionID)  
LEFT JOIN AT1205  WITH (NOLOCK) ON (AT1205.PaymentID = OT2001.PaymentID AND AT1205.DivisionID = OT2001.DivisionID)  
LEFT JOIN AT1208 AT1208_P  WITH (NOLOCK) ON ( AT1208_P.PaymentTermID = AT9000.PaymentTermID AND AT1208_P.DivisionID = AT9000.DivisionID)  
LEFT JOIN AT1208 AT1208_R  WITH (NOLOCK) ON ( AT1208_R.PaymentTermID = Isnull(OT2001.PaymentTermID, A.RepaymentTermID) AND  AT1208_R.DivisionID = Isnull(OT2001.DivisionID, A.DivisionID))  
  
LEFT JOIN AT1103  WITH (NOLOCK) ON (AT1103.EmployeeID=isnull (AT9000.EmployeeID,OT2001.EmployeeID) AND AT1103.DivisionID=isnull (AT9000.DivisionID,OT2001.DivisionID))  
LEFT JOIN AT1103 T3  WITH (NOLOCK) ON (T3.EmployeeID = OT2001.SalesManID AND T3.DivisionID = OT2001.DivisionID)  
LEFT JOIN AT0000  WITH (NOLOCK) ON AT0000.DefDivisionID = AT9000.DivisionID  
LEFT JOIN AT1001  WITH (NOLOCK) ON A.DivisionID = AT1001.DivisionID and A.CountryID = AT1001.CountryID  
LEFT JOIN AT1002  WITH (NOLOCK) ON A.DivisionID = AT1002.DivisionID AND A.CityID = AT1002.CityID  
LEFT JOIN AT1015  WITH (NOLOCK) ON AT1015.DivisionID = A.DivisionID and AT1015.AnaID = A.O02ID and AT1015.AnaTypeID = ''O02'''  
SET @sSQL3 = '  
LEFT JOIN ( SELECT SUM(OriginalAmount) AS ReceivedAmount , ObjectID  
   FROM AV4202  
   WHERE  AccountID LIKE '''+@ReAccountID+'''  
     AND ObjectID = '''+@ObjectID+'''  
     AND DivisionID = '''+@DivisionID+'''   
     AND VoucherDate <= '''+CONVERT(VARCHAR(10),@VoucherDate,101)+'''  
     AND CurrencyIDCN = '''+@CurrencyID+'''  
            GROUP BY ObjectID  
  )R  
 ON R.ObjectID = AT9000.ObjectID  
LEFT JOIN ( SELECT - sum(OriginalAmount) AS PaymentAmount, ObjectID  
   FROM AV4202  
   WHERE  AccountID like '''+@PaAccountID+'''   
     AND ObjectID = '''+@ObjectID+'''  
     AND DivisionID = '''+@DivisionID+'''   
     AND VoucherDate <= '''+CONVERT(VARCHAR(10),@VoucherDate,101)+'''  
     AND CurrencyIDCN = '''+@CurrencyID+'''  
   GROUP BY ObjectID  
  )P  
 ON P.ObjectID = AT9000.ObjectID  
LEFT JOIN ( SELECT  sum(ISNULL( OriginalAmount,0)- ISNULL (GivedOriginalAmount,0)) AS OverDueAmount , ObjectID  
   FROM AV0301  
   WHERE  DebitAccountID like '''+@ReAccountID+'''  
     AND ObjectID = '''+@ObjectID+'''  
     AND DivisionID = '''+@DivisionID+'''   
     AND (DueDate < = CASE WHEN DueDate <> ''01/01/1900'' THEN '''+CONVERT(VARCHAR(10),@VoucherDate,101)+''' END )   
     AND CurrencyIDCN = '''+@CurrencyID+'''  
   GROUP BY ObjectID  
   )O  
 ON O.ObjectID = AT9000.ObjectID  
LEFT JOIN AT2007 AT2007A  WITH (NOLOCK) ON AT2007A.DivisionID = AT9000.DivisionID AND AT2007A.TransactionID = AT9000.WTransactionID  
LEFT JOIN AT2006 AT2006A  WITH (NOLOCK) ON AT2006A.VoucherID = AT2007A.VoucherID AND AT2006A.DivisionID = AT2007A.DivisionID  
LEFT JOIN  
(  
 SELECT A1.DivisionID, A1.VoucherID,  
 STUFF(( SELECT  '', '' + A2.OrderID  
   FROM    AT2007 A2  WITH (NOLOCK)  
   WHERE   A1.DivisionID = A2.DivisionID  
     AND A1.VoucherID = A2.VoucherID  
   GROUP BY A2.OrderID  
   FOR  
   XML PATH('''')  
    ), 1, 1, '''') AS SOrderID  
 FROM AT2007 A1  WITH (NOLOCK)  
 GROUP BY A1.DivisionID, A1.VoucherID  
) TB ON TB.DivisionID = AT9000.DivisionID AND TB.VoucherID = AT9000.WOrderID  
 '  
  
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)  
BEGIN  
  
 SET @sSQL5 = ',  
  O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,   
  O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,  
  A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,  
  A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A010.StandardName AS S10Name,  
  A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,  
  A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name  
 '  
 SET @sSQL3 = @sSql3 + '  
  LEFT JOIN AT8899 O99  WITH (NOLOCK) on O99.DivisionID = AT9000.DivisionID and O99.VoucherID = AT9000.VoucherID and O99.TransactionID = AT9000.TransactionID and O99.TableID = ''AT9000''  
  LEFT JOIN AT0128 A01  WITH (NOLOCK) ON A01.DivisionID = O99.DivisionID AND A01.StandardID = O99.S01ID AND A01.StandardTypeID = ''S01''  
  LEFT JOIN AT0128 A02  WITH (NOLOCK) ON A02.DivisionID = O99.DivisionID AND A02.StandardID = O99.S02ID AND A02.StandardTypeID = ''S02''  
  LEFT JOIN AT0128 A03  WITH (NOLOCK) ON A03.DivisionID = O99.DivisionID AND A03.StandardID = O99.S03ID AND A03.StandardTypeID = ''S03''  
  LEFT JOIN AT0128 A04  WITH (NOLOCK) ON A04.DivisionID = O99.DivisionID AND A04.StandardID = O99.S04ID AND A04.StandardTypeID = ''S04''  
  LEFT JOIN AT0128 A05  WITH (NOLOCK) ON A05.DivisionID = O99.DivisionID AND A05.StandardID = O99.S05ID AND A05.StandardTypeID = ''S05''  
  LEFT JOIN AT0128 A06  WITH (NOLOCK) ON A06.DivisionID = O99.DivisionID AND A06.StandardID = O99.S06ID AND A06.StandardTypeID = ''S06''  
  LEFT JOIN AT0128 A07  WITH (NOLOCK) ON A07.DivisionID = O99.DivisionID AND A07.StandardID = O99.S07ID AND A07.StandardTypeID = ''S07''  
  LEFT JOIN AT0128 A08  WITH (NOLOCK) ON A08.DivisionID = O99.DivisionID AND A08.StandardID = O99.S08ID AND A08.StandardTypeID = ''S08''  
  LEFT JOIN AT0128 A09  WITH (NOLOCK) ON A09.DivisionID = O99.DivisionID AND A09.StandardID = O99.S09ID AND A09.StandardTypeID = ''S09''  
  LEFT JOIN AT0128 A010  WITH (NOLOCK) ON A010.DivisionID = O99.DivisionID AND A010.StandardID = O99.S10ID AND A010.StandardTypeID = ''S10''  
  LEFT JOIN AT0128 A11  WITH (NOLOCK) ON A11.DivisionID = O99.DivisionID AND A11.StandardID = O99.S11ID AND A11.StandardTypeID = ''S11''  
  LEFT JOIN AT0128 A12  WITH (NOLOCK) ON A12.DivisionID = O99.DivisionID AND A12.StandardID = O99.S12ID AND A12.StandardTypeID = ''S12''  
  LEFT JOIN AT0128 A13  WITH (NOLOCK) ON A13.DivisionID = O99.DivisionID AND A13.StandardID = O99.S13ID AND A13.StandardTypeID = ''S13''  
  LEFT JOIN AT0128 A14  WITH (NOLOCK) ON A14.DivisionID = O99.DivisionID AND A14.StandardID = O99.S14ID AND A14.StandardTypeID = ''S14''  
  LEFT JOIN AT0128 A15  WITH (NOLOCK) ON A15.DivisionID = O99.DivisionID AND A15.StandardID = O99.S15ID AND A15.StandardTypeID = ''S15''  
  LEFT JOIN AT0128 A16  WITH (NOLOCK) ON A16.DivisionID = O99.DivisionID AND A16.StandardID = O99.S16ID AND A16.StandardTypeID = ''S16''  
  LEFT JOIN AT0128 A17  WITH (NOLOCK) ON A17.DivisionID = O99.DivisionID AND A17.StandardID = O99.S17ID AND A17.StandardTypeID = ''S17''  
  LEFT JOIN AT0128 A18  WITH (NOLOCK) ON A18.DivisionID = O99.DivisionID AND A18.StandardID = O99.S18ID AND A18.StandardTypeID = ''S18''  
  LEFT JOIN AT0128 A19  WITH (NOLOCK) ON A19.DivisionID = O99.DivisionID AND A19.StandardID = O99.S19ID AND A19.StandardTypeID = ''S19''  
  LEFT JOIN AT0128 A20  WITH (NOLOCK) ON A20.DivisionID = O99.DivisionID AND A20.StandardID = O99.S20ID AND A20.StandardTypeID = ''S20''  
 ' + '  
 WHERE  AT9000.DivisionID = ''' + @DivisionID + ''' AND AT9000.VoucherID ='''+@VoucherID+''' AND   
        '+@sSQL4+' '    
END  
ELSE  
 SET @sSql3 = @sSql3 + '  
 WHERE  AT9000.DivisionID = ''' + @DivisionID + ''' AND AT9000.VoucherID ='''+@VoucherID+''' AND   
        '+@sSQL4+' '  
  
--PRINT(@sSql)  
--PRINT(@sSql1)  
--PRINT(@sSQL5)  
--PRINT(@sSQL2)  
--PRINT(@sSQL2a)  
--PRINT(@sSQL3)  
  
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'AV3014'  AND  XTYPE ='V')  
 DROP VIEW AV3014  
 EXEC ('CREATE VIEW AV3014  --Create by AP3020_GOD   
  AS '+@sSql + @sSql1 + @sSQL5 + @sSQL2 + @sSql2a + @sSQL3) --- Tao boi store AP3020_GOD  
 --select * from AV3014   
IF(@IsParticularBill=1)  
BEGIN  
  
 SET @sSqlUnion = '  
 IF EXISTS (SELECT Top 1 1 FROM sysObjects WHERE id = Object_ID(''AT3020' + @ConnID + ''') AND xType = ''U'')  
 DROP TABLE AT3020' + @ConnID + '  
  
 --Tao cau truc bang  
 SELECT TOP 0 * INTO AT3020' + @ConnID + ' FROM AV3014 '  
 EXEC (@sSqlUnion)  
   
 SET @sSqlUnion = '  
  
 Declare   
  @FldCur AS cursor,  
  @FldName AS nvarchar(100),  
  @sSQL AS varchar(4000),  
  @i AS int  
  
 SET @sSQL = ''''  
 SET @i = 1  
    
 SET @FldCur = cursor static for   
 SELECT name FROM syscolumns WHERE id = Object_ID(''AT3020' + @ConnID + ''') Order by colid  
  
 Open @FldCur  
  
 Fetch Next FROM @FldCur Into @FldName  
  
 While @@Fetch_Status = 0  
 Begin  
  SET @sSQL = @sSQL +   
  Case @FldName  
  When ''TaxOrders'' THEN   
   ''0 AS TaxOrders,''   
  When ''IsImage01'' THEN   
   ''0 AS IsImage01,''   
  When ''RecordNum'' Then   
   ''0 as RecordNum,''   
  When ''IsStock'' Then   
   ''0 as IsStock,''  
  When ''Orders'' THEN   
   ''' + ltrim(@count + 1) + ' AS Orders,''   
  When ''CurrencyID'' THEN   
   ''''''' + @CurrencyID + ''''' AS CurrencyID,''   
  When ''DivisionID'' THEN   
   ''''''' + @DivisionID + ''''' AS DivisionID,''   
  When ''VATRate'' then  
  ''' + str(@VATRate) + ' as VATRate,''  
  When ''PrintedTimes'' then  
  ''0 as PrintedTimes,''  
  ELSE    
   ''Null AS '' + @FldName + '',''   
  End  
  
  Fetch Next FROM @FldCur Into @FldName  
 End  
  
 Close @FldCur  
  
 SET @sSQL = left(@sSQL,len(@sSQL)-1)  
  
 SET @i = 1  
  
 While @i <= ' + ltrim(@AddRows) + '  
 Begin  
  EXEC(''Insert Into AT3020' + @ConnID + ' SELECT '' + @sSQL)  
    
  SET @i = @i + 1  
 End  
  
 '  
 EXEC (@sSqlUnion)  
   
 If not exists (SELECT top 1 1 FROM SysObjects WHERE name = 'AV3014' + @ConnID AND   
 Xtype ='V')  
  Exec ('Create view AV3014' + @ConnID + ' --Create by AP3020_GOD   
   as '+@sSql+@sSql1+@sSQL2+@sSQL2a+@sSQL3 + '  
   Union All  
   SELECT * FROM AT3020' + @ConnID+' WITH (NOLOCK) ') --- Tao boi store AP3020_GOD  
 Else  
  Exec ('Alter view AV3014' + @ConnID + ' --Create by AP3020_GOD   
   as '+@sSql+@sSql1+@sSQL2+@sSQL2a+@sSQL3+ '  
   UNION ALL  
   SELECT * FROM AT3020' + @ConnID+'  WITH (NOLOCK) ') --- Tao boi store AP3020_GOD  
END   
  
ELSE   
 BEGIN  
 IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'AV3014' + @CONNID AND   
  XTYPE ='V')  
   EXEC ('CREATE VIEW AV3014' + @ConnID + ' --Create by AP3020_GOD   
    as '+@sSql+@sSql1 +@sSQL5+@sSQL2+@sSQL2a+@sSQL3) --- Tao boi store AP3020_GOD  
  ELSE  
   EXEC ('ALTER VIEW AV3014' + @ConnID + ' --CREATE BY AP3020_GOD   
    AS '+@sSql+@sSql1+@sSQL5+@sSQL2+@sSQL2a+@sSQL3) --- Tao boi store AP3020_GOD  
  
 END  
  
--PRINT(@sSql)  
--PRINT(@sSql1)  
--PRINT(@sSQL2)  
--PRINT(@sSQL3)  
  
  
