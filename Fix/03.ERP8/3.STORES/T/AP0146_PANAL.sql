IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0146_PANAL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0146_PANAL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- AP0146
-- <Summary>
---- Stored load dữ liệu hóa đơn phục vụ phát hành hóa đơn điện tử - Store riêng cho Panalpina
---- Created on 05/07/2019 Kim Thư
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Kim Thư on 17/07/2019: Sửa cột ProdUnit giới hạn 250 ký tự
---- Modified by Huỳnh Thử	on 17/09/2020: Bổ sung trường ParentInvoiceSign và ParentSerial của hóa đơn gốc
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- EXEC AP0146_PANAL @DivisionID = 'ANG',@UserID='ASOFTADMIN',@VoucherID='AV561ee05d-44de-4d71-8e4c-4927876f60df'

CREATE PROCEDURE [dbo].[AP0146_PANAL]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS

DECLARE @sSQL AS NVARCHAR(MAX) = '',
		@sSQL1A AS NVARCHAR(MAX) = '',
		@sSQL1A1 AS NVARCHAR(MAX) = '',
		@sSQL2A AS NVARCHAR(MAX) = '',
		@sSQL2A1 AS NVARCHAR(MAX) = '',
		@sSQLA AS NVARCHAR(MAX) = ''

BEGIN

	SET @sSQL = '     
	SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
	AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone,  AT1202.Email AS CusEmail, AT9000.VATNo AS CusTaxCode, AT1202.ObjectName AS Buyer, 
	CASE WHEN ISNULL(AT1202.TradeName,'''')<>'''' THEN ''Mã KH: ''+AT9000.VATObjectID+''/''+AT1202.TradeName ELSE ''Mã KH: ''+AT9000.VATObjectID END AS CusbankNo,

	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
	- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,

	ISNULL((SELECT SUM(ABS(DiscountAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(ABS(DiscountSalesAmount), 0) AS DiscountAmount,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,

	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) 
	- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,

	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND VATGroupID = ''T00''), 0) AS VATAmount0,
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND VATGroupID = ''T10''), 0) AS VATAmount10,
	' 
	SET @sSQL1A=N'
	CASE WHEN AT9000.VATGroupID=''TS0'' THEN -1 ELSE AT1010.VATRate END AS VAT_Rate, AT9000.InventoryID AS ProdID, 
	ISNULL(AT9000.InventoryName1,AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
	ABS(AT9000.ConvertedPrice) AS ProdPrice,  ABS(AT9000.ConvertedAmount) AS Amount,
	AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, ISNULL(AT9000.TDescription,'''') AS TDescription, A02.AnaName as Ana02Name,
	A12.PaymentName AS PaymentMethod,
	AT9000.BDescription as DonDatHangSo, ABS(AT9000.OriginalAmount) AS OriginalAmount, ISNULL(A02.AnaName+''/''+AT9000.VDescription,AT9000.VDescription) AS KindOfService, 
	AT9000.CurrencyID as Extra1, AT9000.ExchangeRate AS Extra,
	AT9000.InvoiceDate, AT9000.CurrencyID, AT9000.PaymentID, AT9000.VoucherNo,
	AT9000.VoucherID, AT9000.BatchID, AT9000.TransactionID, AT9000.TableID, AT9000.TranMonth, AT9000.TranYear, AT9000.TransactionTypeID, AT9000.ObjectID, AT9000.CreditObjectID, AT9000.VATNo,
	AT9000.VATObjectID, AT9000.VATObjectName, AT9000.VATObjectAddress, AT9000.DebitAccountID, AT9000.CreditAccountID, AT9000.ExchangeRate, AT9000.UnitPrice, AT9000.OriginalAmount as OriginalAmountAT9000,
	AT9000.ConvertedAmount, AT9000.ImTaxOriginalAmount, AT9000.ImTaxConvertedAmount, AT9000.ExpenseOriginalAmount, AT9000.ExpenseConvertedAmount, AT9000.IsStock, AT9000.VoucherDate,
	AT9000.VoucherTypeID, AT9000.VATGroupID, AT9000.Serial, AT9000.InvoiceNo, AT9000.Orders, AT9000.EmployeeID, AT9000.SenderReceiver, AT9000.SRDivisionName, AT9000.SRAddress,
	AT9000.RefNo01, AT9000.RefNo02, AT9000.VDescription, AT9000.BDescription, AT9000.Quantity, AT9000.InventoryID, AT9000.UnitID, AT9000.Status, AT9000.IsAudit, AT9000.IsCost, 
	AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, AT9000.PeriodID,
	AT9000.ExpenseID, AT9000.MaterialTypeID, AT9000.ProductID, AT9000.CreateDate, AT9000.CreateUserID, AT9000.LastModifyUserID, AT9000.LastModifyDate, AT9000.OriginalAmountCN,
	AT9000.ExchangeRateCN, AT9000.CurrencyIDCN, AT9000.DueDays, AT9000.DueDate, AT9000.DiscountRate, AT9000.OrderID, AT9000.CreditBankAccountID, AT9000.DebitBankAccountID,
	AT9000.CommissionPercent, AT9000.InventoryName1, AT9000.PaymentTermID,
	'
	SET @sSQL1A1=N' AT9000.DiscountAmount as DiscountAmountAT9000, AT9000.OTransactionID, AT9000.IsMultiTax, 
	ABS(AT9000.VATOriginalAmount) AS VATOriginalAmount, ABS(AT9000.VATConvertedAmount) AS VATConvertedAmount,
	AT9000.ReVoucherID, AT9000.ReBatchID, AT9000.ReTransactionID, AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05, AT9000.Parameter06,
	AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10, AT9000.MOrderID, AT9000.SOrderID, AT9000.MTransactionID,AT9000.STransactionID,AT9000.RefVoucherNo,
	AT9000.IsLateInvoice,AT9000.ConvertedQuantity,AT9000.ConvertedPrice,AT9000.ConvertedUnitID,AT9000.ConversionFactor,AT9000.UParameter01,AT9000.UParameter02,AT9000.UParameter03,
	AT9000.UParameter04,AT9000.UParameter05,AT9000.PriceListID,AT9000.WOrderID,AT9000.WTransactionID,AT9000.MarkQuantity,AT9000.TVoucherID,AT9000.OldCounter,AT9000.NewCounter,
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

	SET @sSQL2A='
	AT9000.ABParameter01,AT9000.ABParameter02,AT9000.ABParameter03,AT9000.ABParameter04,AT9000.ABParameter05,AT9000.ABParameter06,
	AT9000.ABParameter07,AT9000.ABParameter08,AT9000.ABParameter09,AT9000.ABParameter10,AT9000.SOAna01ID,AT9000.SOAna02ID,AT9000.SOAna03ID,AT9000.SOAna04ID,AT9000.SOAna05ID,
	AT9000.IsVATWithhodingTax,AT9000.VATWithhodingRate,AT9000.IsEInvoice,AT9000.EInvoiceStatus,AT9000.IsAdvancePayment,AT9000.Fkey,AT9000.IsInheritInvoicePOS,
	AT9000.InheritInvoicePOS,AT9000.IsInheritPayPOS,AT9000.InheritPayPOS,AT9000.IsInvoiceSuggest,AT9000.RefVoucherDate,AT9000.IsDeposit,AT9000.ReTransactionTypeID,
	AT9000.ImVoucherID,AT9000.ImTransactionID,AT9000.SourceNo,AT9000.LimitDate,AT9000.IsPromotionItem,AT9000.ObjectName1,
	CASE AT9000.VATGroupID WHEN ''T00'' THEN 1 WHEN ''T05'' THEN 2 WHEN ''T10'' THEN 3 WHEN ''TS0'' THEN 4 WHEN ''TZ0'' THEN 5 ELSE NULL END AS TaxRateID,
	CASE AT9000.PaymentID WHEN ''TM'' THEN 1 WHEN ''CK'' THEN 2 WHEN ''TM/CK'' THEN 3 ELSE NULL END AS PayMethodID, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice, AT9000.IsReceived,
	A16.BankAccountNo, A16.BankName, A26.ContactPerson, 
	ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as DVATOriginalAmount, ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) as DVATConvertedAmount,
	A13.UnitName AS ConvertedUnitName, A12.PaymentName, 0 AS IsDiscount, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson,
	ISNULL(AT9000.OriginalAmount,0) + ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as OriginalAfterVATAmount, 
	ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) AS ConvertedAfterVATAmount,
	A27.SourceNo as WSourceNo, CONVERT(NVARCHAR(10),A27.LimitDate,103) as WLimitDate, AT1302.I04ID, AT1015.AnaName as I04Name,
	(SELECT TOP 1 InvoiceSign  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentInvoiceSign,
	(SELECT TOP 1 Serial  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentSerial
	'
	SET @sSQL2A1 = '
	INTO #TEMP
	FROM AT9000 WITH (NOLOCK)
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
	LEFT JOIN AT2007 A27 WITH (NOLOCK) ON A27.VoucherID = A26.VoucherID AND A27.TransactionID = AT9000.TransactionID
	LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaTypeID = ''I04'' and AT1015.AnaID=AT1302.I04ID
	WHERE AT9000.DivisionID = ''' + @DivisionID + '''
	AND AT9000.VoucherID = ''' + @VoucherID + ''' 
	AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'',''T64'')
	ORDER BY AT9000.Orders
	'
	
	CREATE TABLE #TDESCRIPTION (ORDERS INT, Remark int, CusCode VARCHAR(50), CusName NVARCHAR(250), CusAddress NVARCHAR(250), CusPhone VARCHAR(100), CusEmail VARCHAR(MAX), CusTaxCode NVARCHAR(50),
			Buyer NVARCHAR(250), CusbankNo NVARCHAR(250), PaymentMethod NVARCHAR(50), Total DECIMAL(28,8), DiscountAmount DECIMAL(28,8), AfterAmount DECIMAL(28,8), VATAmount DECIMAL(28,8), VAT_Rate DECIMAL(28,8),
			ProdID VARCHAR(50), ProdName NVARCHAR(250), ProdUnit NVARCHAR(250), ProdQuantity DECIMAL(28,8), ProdPrice DECIMAL(28,8), Amount DECIMAL(28,8), InheritFkey NVARCHAR(50), 
			EInvoiceType TINYINT, TypeOfAdjust TINYINT, TDescription NVARCHAR(250), Ana02ID NVARCHAR(50), Ana02Name NVARCHAR(250),
			DonDatHangSo  NVARCHAR(250), OriginalAmount DECIMAL(28,8), KindOfService NVARCHAR(250), Extra1 VARCHAR(3), VATAmount0 DECIMAL(28,8), 
			VATAmount10 DECIMAL(28,8), Extra DECIMAL(28,8), VoucherID NVARCHAR(50), BatchID NVARCHAR(50), TransactionID NVARCHAR(50), TableID NVARCHAR(50), TranMonth INT, 
			TranYear INT, TransactionTypeID NVARCHAR(50), ObjectID NVARCHAR(50), CreditObjectID NVARCHAR(50), VATNo NVARCHAR(50), VATObjectID NVARCHAR(50), 
			VATObjectName NVARCHAR(250), VATObjectAddress NVARCHAR(250), DebitAccountID NVARCHAR(50), CreditAccountID NVARCHAR(50), ExchangeRate DECIMAL(28,8), 
			UnitPrice DECIMAL(28,8), OriginalAmountAT9000 DECIMAL(28,8), ConvertedAmount DECIMAL(28,8), ImTaxOriginalAmount DECIMAL(28,8), ImTaxConvertedAmount DECIMAL(28,8), 
			ExpenseOriginalAmount DECIMAL(28,8), ExpenseConvertedAmount DECIMAL(28,8), IsStock TINYINT, VoucherDate DATETIME, InvoiceDate DATETIME, CurrencyID NVARCHAR(50), VoucherTypeID NVARCHAR(50), 
			VATGroupID NVARCHAR(50), VoucherNo NVARCHAR(50), Serial NVARCHAR(50), InvoiceNo NVARCHAR(50), OrdersAT9000 INT, EmployeeID NVARCHAR(50), 
			SenderReceiver NVARCHAR(250), SRDivisionName NVARCHAR(250), SRAddress NVARCHAR(250), RefNo01 NVARCHAR(100), RefNo02 NVARCHAR(100), VDescription NVARCHAR(250), 
			BDescription NVARCHAR(250), Quantity DECIMAL(28,8), InventoryID NVARCHAR(50), UnitID NVARCHAR(50), Status NVARCHAR(50), IsAudit TINYINT, IsCost TINYINT, 
			Ana01ID NVARCHAR(50), Ana03ID NVARCHAR(50), PeriodID NVARCHAR(50), ExpenseID NVARCHAR(50), MaterialTypeID NVARCHAR(50), ProductID NVARCHAR(50), CreateDate DATETIME, 
			CreateUserID NVARCHAR(50), LastModifyDate DATETIME, LastModifyUserID NVARCHAR(50), OriginalAmountCN DECIMAL(28,8), ExchangeRateCN DECIMAL(28,8), CurrencyIDCN NVARCHAR(50), 
			DueDays INT, PaymentID NVARCHAR(50), DueDate DATETIME, DiscountRate DECIMAL(28,8), OrderID NVARCHAR(500), CreditBankAccountID NVARCHAR(50), DebitBankAccountID NVARCHAR(50),
			CommissionPercent DECIMAL(28,8), InventoryName1 NVARCHAR(250), Ana04ID NVARCHAR(50), Ana05ID NVARCHAR(50), PaymentTermID NVARCHAR(50), DiscountAmountAT9000 DECIMAL(28,8), 
			OTransactionID NVARCHAR(50), IsMultiTax TINYINT, VATOriginalAmount DECIMAL(28,8), VATConvertedAmount DECIMAL(28,8), ReVoucherID NVARCHAR(50), ReBatchID NVARCHAR(50), 
			ReTransactionID NVARCHAR(50), Parameter01 NVARCHAR(250), Parameter02 NVARCHAR(250), Parameter03 NVARCHAR(250), Parameter04 NVARCHAR(250), Parameter05 NVARCHAR(250), 
			Parameter06 NVARCHAR(250), Parameter07 NVARCHAR(250), Parameter08 NVARCHAR(250), Parameter09 NVARCHAR(250), Parameter10 NVARCHAR(250), MOrderID NVARCHAR(50), 
			SOrderID NVARCHAR(50), MTransactionID NVARCHAR(50), STransactionID NVARCHAR(50), RefVoucherNo NVARCHAR(50), IsLateInvoice TINYINT, ConvertedQuantity DECIMAL(28,8), 
			ConvertedPrice DECIMAL(28,8), ConvertedUnitID NVARCHAR(50), ConversionFactor DECIMAL(28,8), UParameter01 DECIMAL(28,8), UParameter02 DECIMAL(28,8), UParameter03 DECIMAL(28,8), 
			UParameter04 DECIMAL(28,8), UParameter05 DECIMAL(28,8), PriceListID NVARCHAR(50), Ana06ID NVARCHAR(50), Ana07ID NVARCHAR(50), Ana08ID NVARCHAR(50), Ana09ID NVARCHAR(50), 
			Ana10ID NVARCHAR(50), WOrderID NVARCHAR(50), WTransactionID NVARCHAR(50), MarkQuantity DECIMAL(28,8), TVoucherID NVARCHAR(50), OldCounter DECIMAL(28,8), 
			NewCounter DECIMAL(28,8), OtherCounter DECIMAL(28,8), TBatchID NVARCHAR(50), ContractDetailID NVARCHAR(50), InvoiceCode NVARCHAR(50), InvoiceSign NVARCHAR(50), 
			RefInfor NVARCHAR(250), StandardPrice DECIMAL(28,8), StandardAmount DECIMAL(28,8), IsCom TINYINT, VirtualPrice DECIMAL(28,8), VirtualAmount DECIMAL(28,8), 
			ReTableID NVARCHAR(50), DParameter01 NVARCHAR(250), DParameter02 NVARCHAR(250), DParameter03 NVARCHAR(250), DParameter04 NVARCHAR(250), DParameter05 NVARCHAR(250), 
			DParameter06 NVARCHAR(250), DParameter07 NVARCHAR(250), DParameter08 NVARCHAR(250), DParameter09 NVARCHAR(250), DParameter10 NVARCHAR(250), InheritTableID NVARCHAR(50), 
			InheritVoucherID VARCHAR(25), InheritTransactionID NVARCHAR(2000), ETaxVoucherID NVARCHAR(50), ETaxID NVARCHAR(50), ETaxConvertedUnit DECIMAL(28,8), 
			ETaxConvertedAmount DECIMAL(28,8), ETaxTransactionID NVARCHAR(50), AssignedSET TINYINT, SETID NVARCHAR(50), SETUnitID NVARCHAR(50), SETTaxRate DECIMAL(28,8), 
			SETConvertedUnit DECIMAL(28,8), SETQuantity DECIMAL(28,8), SETOriginalAmount DECIMAL(28,8), SETConvertedAmount DECIMAL(28,8), SETConsistID NVARCHAR(50), 
			SETTransactionID NVARCHAR(50), AssignedNRT TINYINT, NRTTaxAmount DECIMAL(28,8), NRTClassifyID NVARCHAR(50), NRTUnitID NVARCHAR(50), NRTTaxRate DECIMAL(28,8), 
			NRTConvertedUnit DECIMAL(28,8), NRTQuantity DECIMAL(28,8), NRTOriginalAmount DECIMAL(28,8), NRTConvertedAmount DECIMAL(28,8), NRTConsistID NVARCHAR(50), 
			NRTTransactionID NVARCHAR(50), CreditObjectName NVARCHAR(500), CreditVATNo NVARCHAR(500), IsPOCost TINYINT, TaxBaseAmount DECIMAL(28,8), WTCExchangeRate DECIMAL(28,8), 
			WTCOperator TINYINT, IsFACost TINYINT, IsInheritFA TINYINT, InheritedFAVoucherID NVARCHAR(50), AVRExchangeRate DECIMAL(28,8), PaymentExchangeRate DECIMAL(28,8), 
			IsMultiExR TINYINT, ExchangeRateDate DATETIME, DiscountSalesAmount DECIMAL(28,8), IsProInventoryID TINYINT, InheritQuantity DECIMAL(28,8), DiscountPercentSOrder DECIMAL(28,8), 
			DiscountAmountSOrder DECIMAL(28,8), IsWithhodingTax TINYINT, IsSaleInvoice TINYINT, WTTransID NVARCHAR(50), DiscountSaleAmountDetail DECIMAL(28,8), 
			ABParameter01 NVARCHAR(100), ABParameter02 NVARCHAR(100), ABParameter03 NVARCHAR(100), ABParameter04 NVARCHAR(100), ABParameter05 NVARCHAR(100), 
			ABParameter06 NVARCHAR(100), ABParameter07 NVARCHAR(100), ABParameter08 NVARCHAR(100), ABParameter09 NVARCHAR(100), ABParameter10 NVARCHAR(100), SOAna01ID NVARCHAR(50), 
			SOAna02ID NVARCHAR(50), SOAna03ID NVARCHAR(50), SOAna04ID NVARCHAR(50), SOAna05ID NVARCHAR(50), IsVATWithhodingTax TINYINT, VATWithhodingRate DECIMAL(28,8), 
			IsEInvoice TINYINT, EInvoiceStatus TINYINT, IsAdvancePayment TINYINT, Fkey NVARCHAR(50), IsInheritInvoicePOS TINYINT, InheritInvoicePOS VARCHAR(25), 
			IsInheritPayPOS TINYINT, InheritPayPOS VARCHAR(25), IsInvoiceSuggest TINYINT, RefVoucherDate DATETIME, IsDeposit TINYINT, ReTransactionTypeID VARCHAR(25), 
			ImVoucherID VARCHAR(25), ImTransactionID VARCHAR(25), SourceNo NVARCHAR(50), LimitDate DATETIME, IsPromotionItem TINYINT, ObjectName1 NVARCHAR(250), TaxRateID INT, PayMethodID INT,
			DiscountedUnitPrice DECIMAL(28,8), ConvertedDiscountedUnitPrice DECIMAL(28,8), IsReceived TINYINT, Ana01Name NVARCHAR(250), Ana03Name NVARCHAR(250), Ana04Name NVARCHAR(250),
			Ana05Name NVARCHAR(250), Ana06Name NVARCHAR(250), Ana07Name NVARCHAR(250), Ana08Name NVARCHAR(250), Ana09Name NVARCHAR(250), Ana10Name NVARCHAR(250),
			BankAccountNo VARCHAR(250), BankName VARCHAR(MAX), ContactPerson NVARCHAR(MAX), DVATOriginalAmount DECIMAL(28,8), DVATConvertedAmount DECIMAL(28,8), 
			ConvertedUnitName NVARCHAR(250), PaymentName NVARCHAR(1000), IsDiscount TINYINT, DivisionNameE NVARCHAR(MAX), AddressE NVARCHAR(MAX), District NVARCHAR(MAX), DContactPerson NVARCHAR(MAX),
			OriginalAfterVATAmount DECIMAL(28,8), ConvertedAfterVATAmount DECIMAL(28,8), WSourceNo VARCHAR(250), WLimitDate DATETIME, I04ID VARCHAR(50), I04Name NVARCHAR(250), ParentInvoiceSign NVARCHAR(250), ParentSerial NVARCHAR(250))
	
	SET @sSQLA = '
		DECLARE @Cur Cursor, @TDescription NVARCHAR(1000)
		SET @Cur  = Cursor Scroll KeySet FOR 
			SELECT DISTINCT TDescription FROM #TEMP
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @TDescription
		WHILE @@Fetch_Status = 0
		BEGIN
			INSERT INTO #TDESCRIPTION 

			SELECT (SELECT TOP 1 Remark FROM #TEMP WHERE TDescription= @TDescription ORDER BY Remark) AS ORDERS,
			Remark, CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
			Total, DiscountAmount, AfterAmount, VATAmount, VAT_Rate,
			ProdID, ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription, 
			Ana02ID, Ana02Name,
			DonDatHangSo, OriginalAmount, KindOfService, Extra1, VATAmount0, VATAmount10, Extra,
			VoucherID, BatchID, TransactionID, TableID, TranMonth, TranYear, 
			TransactionTypeID, ObjectID, CreditObjectID, VATNo, VATObjectID, VATObjectName, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice, 
			OriginalAmountAT9000, ConvertedAmount, ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate, InvoiceDate, CurrencyID, 
			VoucherTypeID, VATGroupID, VoucherNo, Serial, InvoiceNo, Orders AS OrdersAT9000 , EmployeeID, SenderReceiver, SRDivisionName, SRAddress, RefNo01, RefNo02, VDescription, 
			BDescription, Quantity, InventoryID, UnitID, Status, IsAudit, IsCost, Ana01ID, Ana03ID, PeriodID, ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, 
			LastModifyDate, LastModifyUserID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, DueDays, PaymentID, DueDate, DiscountRate, OrderID, CreditBankAccountID, 
			DebitBankAccountID, CommissionPercent, InventoryName1, Ana04ID, Ana05ID, PaymentTermID, DiscountAmountAT9000, OTransactionID, IsMultiTax, VATOriginalAmount, 
			VATConvertedAmount, ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06, Parameter07, Parameter08, 
			Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo, IsLateInvoice, ConvertedQuantity, ConvertedPrice, ConvertedUnitID, 
			ConversionFactor, UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, PriceListID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, WOrderID, 
			WTransactionID, MarkQuantity, TVoucherID, OldCounter, NewCounter, OtherCounter, TBatchID, ContractDetailID, InvoiceCode, InvoiceSign, RefInfor, StandardPrice, 
			StandardAmount, IsCom, VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06, DParameter07, 
			DParameter08, DParameter09, DParameter10, InheritTableID, InheritVoucherID, InheritTransactionID, ETaxVoucherID, ETaxID, ETaxConvertedUnit, ETaxConvertedAmount, 
			ETaxTransactionID, AssignedSET, SETID, SETUnitID, SETTaxRate, SETConvertedUnit, SETQuantity, SETOriginalAmount, SETConvertedAmount, SETConsistID, SETTransactionID, 
			AssignedNRT, NRTTaxAmount, NRTClassifyID, NRTUnitID, NRTTaxRate, NRTConvertedUnit, NRTQuantity, NRTOriginalAmount, NRTConvertedAmount, NRTConsistID, NRTTransactionID, 
			CreditObjectName, CreditVATNo, IsPOCost, TaxBaseAmount, WTCExchangeRate, WTCOperator, IsFACost, IsInheritFA, InheritedFAVoucherID, AVRExchangeRate, PaymentExchangeRate, 
			IsMultiExR, ExchangeRateDate, DiscountSalesAmount, IsProInventoryID, InheritQuantity, DiscountPercentSOrder, DiscountAmountSOrder, IsWithhodingTax, IsSaleInvoice, 
			WTTransID, DiscountSaleAmountDetail, ABParameter01, ABParameter02, ABParameter03, ABParameter04, ABParameter05, ABParameter06, ABParameter07, ABParameter08, 
			ABParameter09, ABParameter10, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID, IsVATWithhodingTax, VATWithhodingRate, IsEInvoice, EInvoiceStatus, IsAdvancePayment, 
			Fkey, IsInheritInvoicePOS, InheritInvoicePOS, IsInheritPayPOS, InheritPayPOS, IsInvoiceSuggest, RefVoucherDate, IsDeposit, ReTransactionTypeID, ImVoucherID, 
			ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, ISNULL(DiscountedUnitPrice,0) as DiscountedUnitPrice , 
			ISNULL(ConvertedDiscountedUnitPrice,0) as ConvertedDiscountedUnitPrice, IsReceived, Ana01Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name,
			BankAccountNo, BankName, ContactPerson, DVATOriginalAmount, DVATConvertedAmount, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson,
			OriginalAfterVATAmount, ConvertedAfterVATAmount, WSourceNo, WLimitDate, I04ID, I04Name, ParentInvoiceSign, ParentSerial
			FROM #TEMP
			WHERE TDescription= @TDescription
			--ORDER BY Remark ASC 
			UNION ALL
			SELECT (SELECT TOP 1 Remark FROM #TEMP WHERE TDescription= @TDescription ORDER BY Remark) AS ORDERS,
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
			NULL, NULL, NULL, NULL, NULL, 
			NULL, @TDescription, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
			
		FETCH NEXT FROM @Cur INTO  @TDescription
		END            
		CLOSE @Cur
		DEALLOCATE @Cur
		SELECT * FROM #TDESCRIPTION ORDER BY ORDERS, ISNULL(Remark,''999999999'') ASC'
END	
print @sSQL
print @sSQL1A
print @sSQL1A1
print @sSQL2A
PRINT @sSQL2A1
print @sSQLA
EXEC (@sSQL+@sSQL1A+@sSQL1A1+@sSQL2A+@sSQL2A1+@sSQLA)
	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
