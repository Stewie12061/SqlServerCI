IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0146_QTC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0146_QTC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0146
-- <Summary>
---- Stored load dữ liệu hóa đơn phục vụ phát hành hóa đơn điện tử - QTC - gom nhóm theo diễn giải chi tiết mặt hàng
---- Created on 27/08/2020 by Đức Thông
---- Modified by Huỳnh Thử	on 17/09/2020: Bổ sung trường ParentInvoiceSign và ParentSerial của hóa đơn gốc
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông on 17/11/2020: Bổ sung trường hợp TDescription rỗng thì không gộp dòng
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- EXEC AP0146 @DivisionID = 'ANG',@UserID='ASOFTADMIN',@VoucherID='AV561ee05d-44de-4d71-8e4c-4927876f60df'

CREATE PROCEDURE [dbo].[AP0146_QTC]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS

DECLARE @sSQL AS NVARCHAR(MAX) = '',
		@sSQL1 AS NVARCHAR(MAX) = '',
		@sSQL2 AS NVARCHAR(MAX) = '',
		@sSQL2A AS NVARCHAR(MAX) = '',
		@sSQL3 AS NVARCHAR(MAX) = '',
		@sSQL4 AS NVARCHAR(MAX) = ''								

SET @sSQL = '     
SELECT ROW_NUMBER() OVER(ORDER BY Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone,  AT1202.Email AS CusEmail, AT9000.VATNo AS CusTaxCode,
AT1202.ObjectName AS Buyer, AT1202.TradeName AS CusbankNo,

ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,

ISNULL((SELECT SUM(ABS(DiscountAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(ABS(DiscountSalesAmount), 0) AS DiscountAmount,
ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,

ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0)
- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,

CASE WHEN AT9000.VATGroupID=''TS0'' THEN -1 ELSE AT1010.VATRate END AS VAT_Rate, AT9000.InventoryID AS ProdID, 
ISNULL(AT9000.InventoryName1,AT1302.InventoryName) AS ProdName, 
AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
ABS(AT9000.ConvertedPrice) AS ProdPrice, (SELECT SUM(ConvertedAmount) FROM AT9000 B WHERE AT9000.VoucherID = B.VoucherID AND AT9000.TDescription = B.TDescription) AS Amount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, ISNULL(AT9000.TDescription,'''') AS TDescription, A02.AnaName as Ana02Name, AT9000.PaymentID AS PaymentMethod, AT9000.BDescription as DonDatHangSo,  (SELECT SUM(OriginalAmount) FROM AT9000 B WHERE AT9000.VoucherID = B.VoucherID AND AT9000.TDescription = B.TDescription) AS OriginalAmount, ISNULL(A02.AnaName+''/''+AT9000.VDescription,AT9000.VDescription) AS KindOfService, AT9000.CurrencyID as Extra1, ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T00''), 0) AS VATAmount0, ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T10''), 0) AS VATAmount10,
AT9000.ExchangeRate  AS Extra,'

SET @sSQL1=N'
AT9000.InvoiceDate, AT9000.CurrencyID, AT9000.PaymentID, AT9000.VoucherNo,
AT9000.VoucherID, AT9000.BatchID, AT9000.TransactionID, AT9000.TableID, AT9000.TranMonth, AT9000.TranYear, AT9000.TransactionTypeID, AT9000.ObjectID, AT9000.CreditObjectID, AT9000.VATNo,
AT9000.VATObjectID, AT9000.VATObjectName, AT9000.VATObjectAddress, AT9000.DebitAccountID, AT9000.CreditAccountID, AT9000.ExchangeRate, AT9000.UnitPrice, AT9000.OriginalAmount as OriginalAmountAT9000, (SELECT SUM(ConvertedAmount) FROM AT9000 B WHERE AT9000.VoucherID = B.VoucherID AND AT9000.TDescription = B.TDescription) AS ConvertedAmount, AT9000.ImTaxOriginalAmount, AT9000.ImTaxConvertedAmount, AT9000.ExpenseOriginalAmount, AT9000.ExpenseConvertedAmount, AT9000.IsStock, AT9000.VoucherDate,
AT9000.VoucherTypeID, AT9000.VATGroupID, AT9000.Serial, AT9000.InvoiceNo, AT9000.Orders, AT9000.EmployeeID, AT9000.SenderReceiver, AT9000.SRDivisionName, AT9000.SRAddress,
AT9000.RefNo01, AT9000.RefNo02, AT9000.VDescription, AT9000.BDescription, AT9000.Quantity, AT9000.InventoryID, AT9000.UnitID, AT9000.Status, AT9000.IsAudit, AT9000.IsCost, 
AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, AT9000.PeriodID,
AT9000.ExpenseID, AT9000.MaterialTypeID, AT9000.ProductID, CONVERT(VARCHAR(10),AT9000.CreateDate,103) AS CreateDate, AT9000.CreateUserID, AT9000.LastModifyUserID, CONVERT(VARCHAR(10),AT9000.LastModifyDate,103) AS LastModifyDate, AT9000.OriginalAmountCN,
AT9000.ExchangeRateCN, AT9000.CurrencyIDCN, AT9000.DueDays, AT9000.DueDate, AT9000.DiscountRate, AT9000.OrderID, AT9000.CreditBankAccountID, AT9000.DebitBankAccountID,
AT9000.CommissionPercent, AT9000.InventoryName1, AT9000.PaymentTermID,
AT9000.DiscountAmount as DiscountAmountAT9000, AT9000.OTransactionID, AT9000.IsMultiTax, ABS(AT9000.VATOriginalAmount) AS VATOriginalAmount, ABS(AT9000.VATConvertedAmount) AS VATConvertedAmount,
AT9000.ReVoucherID, AT9000.ReBatchID, AT9000.ReTransactionID, AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05, AT9000.Parameter06,
AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10, AT9000.MOrderID, AT9000.SOrderID, AT9000.MTransactionID,AT9000.STransactionID,AT9000.RefVoucherNo,
AT9000.IsLateInvoice,AT9000.ConvertedQuantity,AT9000.ConvertedPrice,AT9000.ConvertedUnitID,AT9000.ConversionFactor,AT9000.PriceListID,AT9000.WOrderID,
--AT9000.UParameter01,AT9000.UParameter02,AT9000.UParameter03,  AT9000.UParameter04,AT9000.UParameter05,AT9000.WTransactionID,
AT9000.MarkQuantity,AT9000.TVoucherID,AT9000.OldCounter,AT9000.NewCounter,
AT9000.OtherCounter,AT9000.TBatchID,AT9000.ContractDetailID,AT9000.InvoiceCode,AT9000.InvoiceSign,AT9000.RefInfor,AT9000.StandardPrice,AT9000.StandardAmount,AT9000.IsCom,
AT9000.VirtualPrice,AT9000.VirtualAmount,AT9000.ReTableID,AT9000.DParameter01,AT9000.DParameter02,AT9000.DParameter03,AT9000.DParameter04,AT9000.DParameter05,AT9000.DParameter06,
AT9000.DParameter07,AT9000.DParameter08,AT9000.DParameter09,AT9000.DParameter10,AT9000.InheritTableID,AT9000.InheritVoucherID,AT9000.InheritTransactionID,AT9000.ETaxVoucherID,
AT9000.ETaxID,AT9000.ETaxConvertedUnit,AT9000.ETaxConvertedAmount,AT9000.ETaxTransactionID,AT9000.AssignedSET,AT9000.SETID,AT9000.SETUnitID,AT9000.SETTaxRate,
AT9000.SETConvertedUnit,AT9000.SETQuantity,AT9000.SETOriginalAmount,AT9000.SETConvertedAmount,AT9000.SETConsistID,AT9000.SETTransactionID,AT9000.AssignedNRT,AT9000.NRTTaxAmount,
AT9000.NRTClassifyID,AT9000.NRTUnitID,AT9000.NRTTaxRate,AT9000.NRTConvertedUnit,AT9000.NRTQuantity,AT9000.NRTOriginalAmount,AT9000.NRTConvertedAmount,AT9000.NRTConsistID,
AT9000.NRTTransactionID,AT9000.CreditObjectName,AT9000.CreditVATNo,AT9000.IsPOCost,AT9000.TaxBaseAmount,AT9000.WTCExchangeRate,AT9000.WTCOperator,AT9000.IsFACost,
AT9000.IsInheritFA,AT9000.InheritedFAVoucherID,AT9000.AVRExchangeRate,AT9000.PaymentExchangeRate,AT9000.IsMultiExR,AT9000.ExchangeRateDate,AT9000.DiscountSalesAmount,
AT9000.IsProInventoryID,AT9000.InheritQuantity,AT9000.DiscountPercentSOrder,AT9000.DiscountAmountSOrder,AT9000.IsWithhodingTax,AT9000.IsSaleInvoice,AT9000.WTTransID,
AT9000.DiscountSaleAmountDetail, A01.AnaName as Ana01Name, A03.AnaName as Ana03Name, A04.AnaName as Ana04Name, A05.AnaName as Ana05Name, A06.AnaName as Ana06Name,
A07.AnaName as Ana07Name, A08.AnaName as Ana08Name, A09.AnaName as Ana09Name, A10.AnaName as Ana10Name,'

SET @sSQL2='
AT9000.ABParameter01,AT9000.ABParameter02,AT9000.ABParameter03,AT9000.ABParameter04,AT9000.ABParameter05,AT9000.ABParameter06,
AT9000.ABParameter07,AT9000.ABParameter08,AT9000.ABParameter09,AT9000.ABParameter10,AT9000.SOAna01ID,AT9000.SOAna02ID,AT9000.SOAna03ID,AT9000.SOAna04ID,AT9000.SOAna05ID,
AT9000.IsVATWithhodingTax,AT9000.VATWithhodingRate,AT9000.IsEInvoice,AT9000.EInvoiceStatus,AT9000.IsAdvancePayment,AT9000.Fkey,AT9000.IsInheritInvoicePOS,
AT9000.InheritInvoicePOS,AT9000.IsInheritPayPOS,AT9000.InheritPayPOS,AT9000.IsInvoiceSuggest,AT9000.RefVoucherDate,AT9000.IsDeposit,AT9000.ReTransactionTypeID,
AT9000.ImVoucherID,AT9000.ImTransactionID,AT9000.SourceNo,AT9000.LimitDate,AT9000.IsPromotionItem,AT9000.ObjectName1,
CASE AT9000.VATGroupID WHEN ''T00'' THEN 1 WHEN ''T05'' THEN 2 WHEN ''T10'' THEN 3 WHEN ''TS0'' THEN 4 WHEN ''TZ0'' THEN 5 ELSE NULL END AS TaxRateID,
CASE AT9000.PaymentID WHEN ''TM'' THEN 1 WHEN ''CK'' THEN 2 WHEN ''TM/CK'' THEN 3 ELSE NULL END AS PayMethodID, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice, AT9000.IsReceived,
A16.BankAccountNo, A16.BankName, A26.ContactPerson, ISNULL(ROUND(AT1010.VATRate*AT9000.OriginalAmount/100,0),0) as DVATOriginalAmount, ISNULL(ROUND(AT1010.VATRate*AT9000.ConvertedAmount/100,0),0) as DVATConvertedAmount,
A13.UnitName AS ConvertedUnitName, A12.PaymentName, CASE WHEN TransactionTypeID = ''T64'' THEN 1 ELSE 0 END AS IsDiscount, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson,
ISNULL(AT9000.OriginalAmount,0) + ISNULL(ROUND(AT1010.VATRate*AT9000.OriginalAmount/100,0),0) as OriginalAfterVATAmount, ISNULL(AT9000.ConvertedAmount,0) + ISNULL(ROUND(AT1010.VATRate*AT9000.ConvertedAmount/100,0),0) AS ConvertedAfterVATAmount,
	(SELECT TOP 1 InvoiceSign  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentInvoiceSign,
	(SELECT TOP 1 Serial  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentSerial

INTO #TEMP
FROM AT9000 WITH (NOLOCK)'
set @sSQL2A = '
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' and A01.AnaID=AT9000.Ana01ID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' and A02.AnaID=AT9000.Ana02ID
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' and A03.AnaID=AT9000.Ana03ID
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' and A04.AnaID=AT9000.Ana04ID
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' and A05.AnaID=AT9000.Ana05ID
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' and A06.AnaID=AT9000.Ana06ID
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' and A07.AnaID=AT9000.Ana07ID
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' and A08.AnaID=AT9000.Ana08ID
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' and A09.AnaID=AT9000.Ana09ID
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' and A10.AnaID=AT9000.Ana10ID
LEFT JOIN AT1101 A11 WITH (NOLOCK) ON AT9000.DivisionID = A11.DivisionID
LEFT JOIN AT1016 A16 WITH (NOLOCK) ON A16.BankAccountID = A11.BankAccountID
LEFT JOIN AT2006 A26 WITH (NOLOCK) ON AT9000.VoucherID = A26.VoucherID AND A26.KindVoucherID=4
LEFT JOIN AT1304 A13 WITH (NOLOCK) ON A13.UnitID = AT9000.ConvertedUnitID
LEFT JOIN AT1205 A12 WITH (NOLOCK) ON A12.PaymentID = AT9000.PaymentID
WHERE AT9000.DivisionID = ''' + @DivisionID + '''
AND AT9000.VoucherID = ''' + @VoucherID + ''' 
AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'',''T64'')
AND AT9000.Orders IN (
	SELECT MIN(Orders)
	FROM AT9000
	WHERE VoucherID = ''' + @VoucherID + ''' AND ISNULL(TDescription, '''') != ''''
	GROUP BY VoucherID, TDescription
	UNION
	SELECT DISTINCT Orders
	FROM AT9000
	WHERE ISNULL(TDescription, '''') = '''' AND VoucherID = ''' + @VoucherID + '''
)
ORDER BY AT9000.Orders
'

SET @sSQL3 = '
	SELECT * FROM (
		SELECT	TOP 100 PERCENT Remark, CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
				Total, DiscountAmount, AfterAmount, VATAmount, VAT_Rate,
				ProdID, ProdName, ProdUnit, SUM(ProdQuantity) AS ProdQuantity, SUM(Amount)/SUM(ProdQuantity) as ProdPrice, SUM(Amount) AS Amount, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
				DonDatHangSo, SUM(OriginalAmount) AS OriginalAmount, KindOfService, Extra1, VATAmount0, VATAmount10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
				VoucherID, BatchID, NULL AS TransactionID, TableID, TranMonth, TranYear, TransactionTypeID, ObjectID, CreditObjectID, VATNo,
				VATObjectID, VATObjectName, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate, SUM(OriginalAmountAT9000)/SUM(Quantity) AS UnitPrice, SUM(OriginalAmountAT9000) AS OriginalAmountAT9000,
				SUM(ConvertedAmount) AS ConvertedAmount, ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate,
				VoucherTypeID, VATGroupID, Serial, InvoiceNo, NULL AS Orders, EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
				RefNo01, RefNo02, VDescription, BDescription, SUM(Quantity) AS Quantity, NULL AS InventoryID, UnitID, Status, IsAudit, IsCost,
				NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, PeriodID,
				ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, SUM(OriginalAmountCN) AS OriginalAmountCN,
				ExchangeRateCN, CurrencyIDCN, DueDays, DueDate, DiscountRate, OrderID, CreditBankAccountID, DebitBankAccountID,
				CommissionPercent, NULL AS InventoryName1, PaymentTermID, SUM(DiscountAmountAT9000) AS DiscountAmountAT9000, OTransactionID, IsMultiTax, 
				VATOriginalAmount, VATConvertedAmount,
				ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06,
				Parameter07, Parameter08, Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo,
				IsLateInvoice, SUM(ConvertedQuantity) AS ConvertedQuantity, ConvertedPrice, ConvertedUnitID, ConversionFactor, PriceListID, WOrderID,
				--UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, WTransactionID,
				SUM(MarkQuantity) AS MarkQuantity, TVoucherID, OldCounter, NewCounter,
				OtherCounter, TBatchID, ContractDetailID, InvoiceCode, InvoiceSign, RefInfor, StandardPrice, StandardAmount, IsCom,
				VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06,
				DParameter07, DParameter08, DParameter09, DParameter10, InheritTableID, InheritVoucherID, InheritTransactionID, ETaxVoucherID,
				ETaxID, ETaxConvertedUnit, ETaxConvertedAmount, ETaxTransactionID, AssignedSET, SETID, SETUnitID, SETTaxRate,
				SETConvertedUnit, SETQuantity, SETOriginalAmount, SETConvertedAmount, SETConsistID, SETTransactionID, AssignedNRT, NRTTaxAmount,
				NRTClassifyID, NRTUnitID, NRTTaxRate, NRTConvertedUnit, NRTQuantity, NRTOriginalAmount, NRTConvertedAmount, NRTConsistID,
				NRTTransactionID, CreditObjectName, CreditVATNo, IsPOCost, TaxBaseAmount, WTCExchangeRate, WTCOperator, IsFACost,
				IsInheritFA, InheritedFAVoucherID, AVRExchangeRate, PaymentExchangeRate, IsMultiExR, ExchangeRateDate, DiscountSalesAmount,
				IsProInventoryID, InheritQuantity, DiscountPercentSOrder, DiscountAmountSOrder, IsWithhodingTax, IsSaleInvoice, WTTransID,
				DiscountSaleAmountDetail, ABParameter01, ABParameter02, ABParameter03, ABParameter04, ABParameter05, ABParameter06,
				ABParameter07, ABParameter08, ABParameter09, ABParameter10, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
				IsVATWithhodingTax, VATWithhodingRate, IsEInvoice, EInvoiceStatus, IsAdvancePayment, Fkey, IsInheritInvoicePOS,
				InheritInvoicePOS, IsInheritPayPOS, InheritPayPOS, IsInvoiceSuggest, RefVoucherDate, IsDeposit, ReTransactionTypeID,
				ImVoucherID, ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, SUM(DiscountedUnitPrice) AS DiscountedUnitPrice, 
				SUM(ConvertedDiscountedUnitPrice) AS ConvertedDiscountedUnitPrice, IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, 
				NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
				BankAccountNo, BankName, ContactPerson, SUM(DVATOriginalAmount) AS DVATOriginalAmount, SUM(DVATConvertedAmount) AS DVATConvertedAmount, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson,
				SUM(OriginalAfterVATAmount) AS OriginalAfterVATAmount, SUM(ConvertedAfterVATAmount) AS ConvertedAfterVATAmount, 0 AS ItemTypeID,ParentInvoiceSign,ParentSerial
		FROM #TEMP
		
		GROUP BY CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
				Total, DiscountAmount, AfterAmount, VATAmount, VAT_Rate, ProdID,
				ProdName, ProdName + Ltrim(LEN(ProdName)), ProdUnit, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription,
				DonDatHangSo, KindOfService, Extra1, VATAmount0, VATAmount10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
				VoucherID, BatchID, TableID, TranMonth, TranYear, TransactionTypeID, ObjectID, CreditObjectID, VATNo,
				VATObjectID, VATObjectName, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate,
				ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate,
				VoucherTypeID, VATGroupID, Serial, InvoiceNo, EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
				RefNo01, RefNo02, VDescription, BDescription, UnitID, Status, IsAudit, IsCost, PeriodID,
				ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate,
				ExchangeRateCN, CurrencyIDCN, DueDays, DueDate, DiscountRate, OrderID, CreditBankAccountID, DebitBankAccountID,
				CommissionPercent, PaymentTermID,OTransactionID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
				ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06,
				Parameter07, Parameter08, Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo,
				IsLateInvoice, ConvertedPrice, ConvertedUnitID, ConversionFactor, PriceListID, WOrderID, 
				--UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, WTransactionID, 
				TVoucherID, OldCounter, NewCounter,
				OtherCounter, TBatchID, ContractDetailID, InvoiceCode, InvoiceSign, RefInfor, StandardPrice, StandardAmount, IsCom,
				VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06,
				DParameter07, DParameter08, DParameter09, DParameter10, InheritTableID, InheritVoucherID, InheritTransactionID, ETaxVoucherID,
				ETaxID, ETaxConvertedUnit, ETaxConvertedAmount, ETaxTransactionID, AssignedSET, SETID, SETUnitID, SETTaxRate,
				SETConvertedUnit, SETQuantity, SETOriginalAmount, SETConvertedAmount, SETConsistID, SETTransactionID, AssignedNRT, NRTTaxAmount,
				NRTClassifyID, NRTUnitID, NRTTaxRate, NRTConvertedUnit, NRTQuantity, NRTOriginalAmount, NRTConvertedAmount, NRTConsistID,
				NRTTransactionID, CreditObjectName, CreditVATNo, IsPOCost, TaxBaseAmount, WTCExchangeRate, WTCOperator, IsFACost,
				IsInheritFA, InheritedFAVoucherID, AVRExchangeRate, PaymentExchangeRate, IsMultiExR, ExchangeRateDate, DiscountSalesAmount,
				IsProInventoryID, InheritQuantity, DiscountPercentSOrder, DiscountAmountSOrder, IsWithhodingTax, IsSaleInvoice, WTTransID,
				DiscountSaleAmountDetail, ABParameter01, ABParameter02, ABParameter03, ABParameter04, ABParameter05, ABParameter06,
				ABParameter07, ABParameter08, ABParameter09, ABParameter10, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
				IsVATWithhodingTax, VATWithhodingRate, IsEInvoice, EInvoiceStatus, IsAdvancePayment, Fkey, IsInheritInvoicePOS,
				InheritInvoicePOS, IsInheritPayPOS, InheritPayPOS, IsInvoiceSuggest, RefVoucherDate, IsDeposit, ReTransactionTypeID,
				ImVoucherID, ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, 
				IsReceived, BankAccountNo, BankName, ContactPerson, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson, Remark, ParentInvoiceSign, ParentSerial
		
	) X 
	ORDER BY Remark
'	
IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter10,'') <> '')

SET @sSQL4 = '
	UNION ALL
	SELECT TOP 1 9999 AS Remark, CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
				Total, DiscountAmount, AfterAmount, VATAmount, VAT_Rate,
				NULL AS ProdID, Parameter10 AS ProdName, ProdUnit, NULL AS ProdQuantity, NULL as ProdPrice, NULL AS Amount, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
				DonDatHangSo, SUM(OriginalAmount) AS OriginalAmount, KindOfService, Extra1, VATAmount0, VATAmount10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
				VoucherID, BatchID, NULL AS TransactionID, TableID, TranMonth, TranYear, TransactionTypeID, ObjectID, CreditObjectID, VATNo,
				VATObjectID, VATObjectName, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate, SUM(OriginalAmountAT9000)/SUM(Quantity) AS UnitPrice, SUM(OriginalAmountAT9000) AS OriginalAmountAT9000,
				SUM(ConvertedAmount) AS ConvertedAmount, ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate,
				VoucherTypeID, VATGroupID, Serial, InvoiceNo, NULL AS Orders, EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
				RefNo01, RefNo02, VDescription, BDescription, SUM(Quantity) AS Quantity, NULL AS InventoryID, UnitID, Status, IsAudit, IsCost,
				NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, PeriodID,
				ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, SUM(OriginalAmountCN) AS OriginalAmountCN,
				ExchangeRateCN, CurrencyIDCN, DueDays, DueDate, DiscountRate, OrderID, CreditBankAccountID, DebitBankAccountID,
				CommissionPercent, NULL AS InventoryName1, PaymentTermID, SUM(DiscountAmountAT9000) AS DiscountAmountAT9000, OTransactionID, IsMultiTax, 
				VATOriginalAmount, VATConvertedAmount,
				ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06,
				Parameter07, Parameter08, Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo,
				IsLateInvoice, SUM(ConvertedQuantity) AS ConvertedQuantity, ConvertedPrice, ConvertedUnitID, ConversionFactor, PriceListID, WOrderID,
				--UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, WTransactionID,
				SUM(MarkQuantity) AS MarkQuantity, TVoucherID, OldCounter, NewCounter,
				OtherCounter, TBatchID, ContractDetailID, InvoiceCode, InvoiceSign, RefInfor, StandardPrice, StandardAmount, IsCom,
				VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06,
				DParameter07, DParameter08, DParameter09, DParameter10, InheritTableID, InheritVoucherID, InheritTransactionID, ETaxVoucherID,
				ETaxID, ETaxConvertedUnit, ETaxConvertedAmount, ETaxTransactionID, AssignedSET, SETID, SETUnitID, SETTaxRate,
				SETConvertedUnit, SETQuantity, SETOriginalAmount, SETConvertedAmount, SETConsistID, SETTransactionID, AssignedNRT, NRTTaxAmount,
				NRTClassifyID, NRTUnitID, NRTTaxRate, NRTConvertedUnit, NRTQuantity, NRTOriginalAmount, NRTConvertedAmount, NRTConsistID,
				NRTTransactionID, CreditObjectName, CreditVATNo, IsPOCost, TaxBaseAmount, WTCExchangeRate, WTCOperator, IsFACost,
				IsInheritFA, InheritedFAVoucherID, AVRExchangeRate, PaymentExchangeRate, IsMultiExR, ExchangeRateDate, DiscountSalesAmount,
				IsProInventoryID, InheritQuantity, DiscountPercentSOrder, DiscountAmountSOrder, IsWithhodingTax, IsSaleInvoice, WTTransID,
				DiscountSaleAmountDetail, ABParameter01, ABParameter02, ABParameter03, ABParameter04, ABParameter05, ABParameter06,
				ABParameter07, ABParameter08, ABParameter09, ABParameter10, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
				IsVATWithhodingTax, VATWithhodingRate, IsEInvoice, EInvoiceStatus, IsAdvancePayment, Fkey, IsInheritInvoicePOS,
				InheritInvoicePOS, IsInheritPayPOS, InheritPayPOS, IsInvoiceSuggest, RefVoucherDate, IsDeposit, ReTransactionTypeID,
				ImVoucherID, ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, SUM(DiscountedUnitPrice) AS DiscountedUnitPrice, 
				SUM(ConvertedDiscountedUnitPrice) AS ConvertedDiscountedUnitPrice, IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, 
				NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
				BankAccountNo, BankName, ContactPerson, SUM(DVATOriginalAmount) AS DVATOriginalAmount, SUM(DVATConvertedAmount) AS DVATConvertedAmount, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson,
				SUM(OriginalAfterVATAmount) AS OriginalAfterVATAmount, SUM(ConvertedAfterVATAmount) AS ConvertedAfterVATAmount, 4 AS ItemTypeID,ParentInvoiceSign,ParentSerial
	FROM #TEMP
	GROUP BY CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
				Total, DiscountAmount, AfterAmount, VATAmount, VAT_Rate,
				ProdName, ProdName + Ltrim(LEN(ProdName)), ProdUnit, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription,
				DonDatHangSo, KindOfService, Extra1, VATAmount0, VATAmount10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
				VoucherID, BatchID, TableID, TranMonth, TranYear, TransactionTypeID, ObjectID, CreditObjectID, VATNo,
				VATObjectID, VATObjectName, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate,
				ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate,
				VoucherTypeID, VATGroupID, Serial, InvoiceNo, EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
				RefNo01, RefNo02, VDescription, BDescription, UnitID, Status, IsAudit, IsCost, PeriodID,
				ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate,
				ExchangeRateCN, CurrencyIDCN, DueDays, DueDate, DiscountRate, OrderID, CreditBankAccountID, DebitBankAccountID,
				CommissionPercent, PaymentTermID,OTransactionID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
				ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06,
				Parameter07, Parameter08, Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo,
				IsLateInvoice, ConvertedPrice, ConvertedUnitID, ConversionFactor, PriceListID, WOrderID, 
				--UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, WTransactionID, 
				TVoucherID, OldCounter, NewCounter,
				OtherCounter, TBatchID, ContractDetailID, InvoiceCode, InvoiceSign, RefInfor, StandardPrice, StandardAmount, IsCom,
				VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06,
				DParameter07, DParameter08, DParameter09, DParameter10, InheritTableID, InheritVoucherID, InheritTransactionID, ETaxVoucherID,
				ETaxID, ETaxConvertedUnit, ETaxConvertedAmount, ETaxTransactionID, AssignedSET, SETID, SETUnitID, SETTaxRate,
				SETConvertedUnit, SETQuantity, SETOriginalAmount, SETConvertedAmount, SETConsistID, SETTransactionID, AssignedNRT, NRTTaxAmount,
				NRTClassifyID, NRTUnitID, NRTTaxRate, NRTConvertedUnit, NRTQuantity, NRTOriginalAmount, NRTConvertedAmount, NRTConsistID,
				NRTTransactionID, CreditObjectName, CreditVATNo, IsPOCost, TaxBaseAmount, WTCExchangeRate, WTCOperator, IsFACost,
				IsInheritFA, InheritedFAVoucherID, AVRExchangeRate, PaymentExchangeRate, IsMultiExR, ExchangeRateDate, DiscountSalesAmount,
				IsProInventoryID, InheritQuantity, DiscountPercentSOrder, DiscountAmountSOrder, IsWithhodingTax, IsSaleInvoice, WTTransID,
				DiscountSaleAmountDetail, ABParameter01, ABParameter02, ABParameter03, ABParameter04, ABParameter05, ABParameter06,
				ABParameter07, ABParameter08, ABParameter09, ABParameter10, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
				IsVATWithhodingTax, VATWithhodingRate, IsEInvoice, EInvoiceStatus, IsAdvancePayment, Fkey, IsInheritInvoicePOS,
				InheritInvoicePOS, IsInheritPayPOS, InheritPayPOS, IsInvoiceSuggest, RefVoucherDate, IsDeposit, ReTransactionTypeID,
				ImVoucherID, ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, 
				IsReceived, BankAccountNo, BankName, ContactPerson, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson, Remark, ParentInvoiceSign, ParentSerial

				ORDER BY Remark
'

--select @sSQL
--select @sSQL1
--select @sSQL2
--select @sSQL3
--select @sSQL4
EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL2A+@sSQL3+@sSQL4)
	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO