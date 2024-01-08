IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0146_HP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0146_HP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- AP0146_HP
-- <Summary>
---- Stored load dữ liệu hóa đơn phục vụ phát hành hóa đơn điện tử (Customize Hưng Phát)
---- Created on 11/11/2020 by Đức Thông Cus thuế VAT, tổng tiền ngoại tệ lấy nguyên tệ làm tròn 2 chữ số thập phân
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- EXEC AP0146_HP @DivisionID = 'BE',@UserID='ASOFTADMIN',@VoucherID='AVf0984226-d6e8-4e04-8be1-ab6cd097a9e2'

CREATE PROCEDURE [dbo].[AP0146_HP]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS

DECLARE @sSQL AS NVARCHAR(MAX) = '',
		@sSQL1A AS NVARCHAR(MAX) = '',

		@sSQL1A1 AS NVARCHAR(MAX) = '',
		@sSQL2A AS NVARCHAR(MAX) = '',
		@sSQLA AS NVARCHAR(MAX) = '',
		@sSQLA8 AS NVARCHAR(MAX) = '',
		@sSQL3 AS NVARCHAR(MAX) = '',											
		@sSQL4 AS NVARCHAR(MAX) = ''									



	SET @sSQL = '     
	SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, CASE WHEN ISNULL(AT1202.EInvoiceObjectID, '''') = '''' THEN AT9000.ObjectID ELSE AT1202.EInvoiceObjectID END AS CusCode, AT1202.ObjectName AS CusName, 
	AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone,  AT1202.Email AS CusEmail, AT9000.VATNo AS CusTaxCode,
	AT1202.ObjectName AS Buyer, AT1202.BankAccountNo AS CusbankNo,

	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
	- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,
	
	ISNULL((SELECT SUM(ABS(DiscountAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(ABS(DiscountSalesAmount), 0) AS DiscountAmount,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,

	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0)
	- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,
	
	CASE WHEN ISNULL(AT9000.VATGroupID, ''TS0'') = ''TS0'' THEN -1 ELSE AT1010.VATRate END AS VAT_Rate, AT9000.InventoryID AS ProdID, 
	ISNULL(AT9000.InventoryName1,AT1302.InventoryName) AS ProdName, 
	AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
	ABS(AT9000.ConvertedPrice) AS ProdPrice, (AT9000.Quantity * ABS(AT9000.ConvertedPrice)) AS TotalAmount, case at9000.currencyid when ''vnd'' then ABS(AT9000.convertedAmount) else round(ABS(AT9000.OriginalAmount), 2) end AS Amount,
	AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, ISNULL(AT9000.TDescription,'''') AS TDescription, A02.AnaName as Ana02Name,
	AT9000.PaymentID AS PaymentMethod,
	AT9000.BDescription as DonDatHangSo, ABS(AT9000.OriginalAmount) AS OriginalAmount, ISNULL(A02.AnaName+''/''+AT9000.VDescription,AT9000.VDescription) AS KindOfService, 
	AT9000.CurrencyID as Extra1,
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T00''), 0) AS VATAmount0,
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T10''), 0) AS VATAmount10,
	AT9000.ExchangeRate AS Extra,'

	SET @sSQL1A=N'
	AT9000.InvoiceDate, AT9000.CurrencyID, AT9000.PaymentID, AT9000.VoucherNo,
	AT9000.VoucherID, AT9000.BatchID, AT9000.TransactionID, AT9000.TableID, AT9000.TranMonth, AT9000.TranYear, AT9000.TransactionTypeID, AT9000.ObjectID, AT9000.CreditObjectID, AT9000.VATNo,
	AT9000.VATObjectID, A1202_1.ObjectName as VATObjectName,A1202_1.Tel as VATCusPhone,A1202_1.VATNo as VATCusTaxCode,A1202_1.BankAccountNo AS VATCusbankNo, AT9000.VATObjectAddress, AT9000.DebitAccountID, AT9000.CreditAccountID, AT9000.ExchangeRate, AT9000.UnitPrice, AT9000.OriginalAmount as OriginalAmountAT9000,
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
	A07.AnaName as Ana07Name, A08.AnaName as Ana08Name, A09.AnaName as Ana09Name, A10.AnaName as Ana10Name,
	AT9000.ABParameter01,AT9000.ABParameter02,AT9000.ABParameter03,AT9000.ABParameter04,AT9000.ABParameter05,AT9000.ABParameter06,'
	SET @sSQL2A='
	
	AT9000.ABParameter07,AT9000.ABParameter08,AT9000.ABParameter09,AT9000.ABParameter10,AT9000.SOAna01ID,AT9000.SOAna02ID,AT9000.SOAna03ID,AT9000.SOAna04ID,AT9000.SOAna05ID,
	AT9000.IsVATWithhodingTax,AT9000.VATWithhodingRate,AT9000.IsEInvoice,AT9000.EInvoiceStatus,AT9000.IsAdvancePayment,AT9000.Fkey,AT9000.IsInheritInvoicePOS,
	AT9000.InheritInvoicePOS,AT9000.IsInheritPayPOS,AT9000.InheritPayPOS,AT9000.IsInvoiceSuggest,AT9000.RefVoucherDate,AT9000.IsDeposit,AT9000.ReTransactionTypeID,
	AT9000.ImVoucherID,AT9000.ImTransactionID,AT9000.SourceNo,AT9000.LimitDate,AT9000.IsPromotionItem,AT9000.ObjectName1,
	CASE AT9000.VATGroupID WHEN ''T00'' THEN 1 WHEN ''T05'' THEN 2 WHEN ''T10'' THEN 3 WHEN ''TS0'' THEN 4 WHEN ''TZ0'' THEN 5 ELSE NULL END AS TaxRateID,
	CASE AT9000.PaymentID WHEN ''TM'' THEN 1 WHEN ''CK'' THEN 2 WHEN ''TM/CK'' THEN 3 ELSE NULL END AS PayMethodID, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice, AT9000.IsReceived,
	A16.BankAccountNo, A16.BankName, A26.ContactPerson, 
	ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as DVATOriginalAmount, case at9000.currencyid when N''VND'' THEN ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) ELSE ROUND(ISNULL(AT1010.VATRate*AT9000.oRIGINALAmount/100,0), 2) END as DVATConvertedAmount,
	A13.UnitName AS ConvertedUnitName, A12.PaymentName, CASE WHEN TransactionTypeID = ''T64'' THEN 1 ELSE 0 END AS IsDiscount, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson,
	ISNULL(AT9000.OriginalAmount,0) + ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as OriginalAfterVATAmount, 
	ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) AS ConvertedAfterVATAmount,
	A27.SourceNo as WSourceNo, CONVERT(NVARCHAR(10),A27.LimitDate,103) as WLimitDate, AT1302.I04ID, AT1015.AnaName as I04Name

	INTO #TEMP
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
	LEFT JOIN AT1202 A1202_1 WITH (NOLOCK) ON A1202_1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A1202_1.ObjectID = AT9000.VATObjectID
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
	LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaTypeID = ''I04'' and AT1015.AnaID=AT1302.I04ID
	WHERE AT9000.DivisionID = ''' + @DivisionID + '''
	AND AT9000.VoucherID = ''' + @VoucherID + ''' 
	AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'',''T64'')
	ORDER BY AT9000.Orders
	'

	SET @sSQLA = '
		SELECT * FROM (
			SELECT	TOP 100 PERCENT Remark, CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
				Total, DiscountAmount, AfterAmount, VATAmount, VAT_Rate,
				--CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
				--CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
				ProdID, ProdName, ProdUnit, ProdQuantity, ProdPrice, TotalAmount, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription, Ana02ID, Ana02Name,
				DonDatHangSo, OriginalAmount, KindOfService, Extra1, VATAmount0, VATAmount10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
				 VoucherID, BatchID, TransactionID, TableID, TranMonth, TranYear, TransactionTypeID, ObjectID, CreditObjectID, VATNo,
				 VATObjectID, VATObjectName,VATCusPhone,VATCusTaxCode,VATCusbankNo, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice, OriginalAmountAT9000,
				 ConvertedAmount, ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate,
				 VoucherTypeID, VATGroupID, Serial, InvoiceNo, Orders, EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
				 RefNo01, RefNo02, VDescription, BDescription, Quantity, InventoryID, UnitID, Status, IsAudit, IsCost,
				 Ana01ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, PeriodID,
				 ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, OriginalAmountCN,
				 ExchangeRateCN, CurrencyIDCN, DueDays, DueDate, DiscountRate, OrderID, CreditBankAccountID, DebitBankAccountID,'


		set 	@sSQLA8 =	 'CommissionPercent, InventoryName1, PaymentTermID, DiscountAmountAT9000, OTransactionID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
				 ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06,
				 Parameter07, Parameter08, Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo,
				 IsLateInvoice, ConvertedQuantity, ConvertedPrice, ConvertedUnitID, ConversionFactor, UParameter01, UParameter02, UParameter03,
				 UParameter04, UParameter05, PriceListID, WOrderID, WTransactionID, MarkQuantity, TVoucherID, OldCounter, NewCounter,
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
				 ImVoucherID, ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, DiscountedUnitPrice, 
				 ConvertedDiscountedUnitPrice, IsReceived, Ana01Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name,
				 BankAccountNo, BankName, ContactPerson, DVATOriginalAmount, DVATConvertedAmount, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson,
				 OriginalAfterVATAmount, ConvertedAfterVATAmount, WSourceNo, WLimitDate, I04ID, I04Name, 0 as ItemTypeID
			FROM #TEMP
			ORDER BY Remark
		) X
	'	


	IF EXISTS (SELECT TOP 1 1  FROM AT0000 WHERE DefDivisionID=@DivisionID AND EInvoicePartner='BKAV') AND EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter10,'') <> '')
		SET @sSQL3='
			UNION ALL

			SELECT	NULL AS Remark, NULL AS CusCode, NULL AS CusName, NULL AS CusAddress, NULL AS CusPhone, NULL AS CusEmail, NULL AS CusTaxCode, NULL AS Buyer, NULL AS CusbankNo, NULL AS PaymentMethod, 
			NULL AS Total, NULL AS DiscountAmount, NULL AS AfterAmount, NULL AS VATAmount, NULL AS VAT_Rate,
			NULL AS ProdID, Parameter10 as ProdName, NULL AS ProdUnit, NULL AS ProdQuantity, NULL AS ProdPrice, NULL AS TotalAmount, NULL AS Amount, NULL AS InheritFkey, NULL AS EInvoiceType, NULL AS TypeOfAdjust, NULL AS TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
			NULL AS DonDatHangSo, NULL AS OriginalAmount, NULL AS KindOfService, NULL AS Extra1, NULL AS VATAmount0, NULL AS VATAmount10, NULL AS Extra, NULL AS InvoiceDate, NULL AS CurrencyID, NULL AS PaymentID, NULL AS VoucherNo,
			 NULL AS VoucherID, NULL AS BatchID, NULL AS TransactionID, NULL AS TableID, NULL AS TranMonth, NULL AS TranYear, NULL AS TransactionTypeID, NULL AS ObjectID, NULL AS CreditObjectID, NULL AS VATNo,
			 NULL AS VATObjectID, NULL AS VATObjectName,NULL AS VATCusPhone,NULL AS VATCusTaxCode,NULL AS VATCusbankNo, NULL AS VATObjectAddress, NULL AS DebitAccountID, NULL AS CreditAccountID, NULL AS ExchangeRate, NULL AS UnitPrice, NULL AS OriginalAmountAT9000,
			 NULL AS ConvertedAmount, NULL AS ImTaxOriginalAmount, NULL AS ImTaxConvertedAmount, NULL AS ExpenseOriginalAmount, NULL AS ExpenseConvertedAmount, NULL AS IsStock, NULL AS VoucherDate,
			 NULL AS VoucherTypeID, NULL AS VATGroupID, NULL AS Serial, NULL AS InvoiceNo, NULL AS Orders, NULL AS EmployeeID, NULL AS SenderReceiver, NULL AS SRDivisionName, NULL AS SRAddress,
			 NULL AS RefNo01, NULL AS RefNo02, NULL AS VDescription, NULL AS BDescription, NULL AS Quantity, NULL AS InventoryID, NULL AS UnitID, NULL AS Status, NULL AS IsAudit, NULL AS IsCost,
			 NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, NULL AS PeriodID,
			 NULL AS ExpenseID, NULL AS MaterialTypeID, NULL AS ProductID, NULL AS CreateDate, NULL AS CreateUserID, NULL AS LastModifyUserID, NULL AS LastModifyDate, NULL AS OriginalAmountCN,
			 NULL AS ExchangeRateCN, NULL AS CurrencyIDCN, NULL AS DueDays, NULL AS DueDate, NULL AS DiscountRate, NULL AS OrderID, NULL AS CreditBankAccountID, NULL AS DebitBankAccountID,
			 NULL AS CommissionPercent, NULL AS InventoryName1, NULL AS PaymentTermID, NULL AS DiscountAmountAT9000, NULL AS OTransactionID, NULL AS IsMultiTax, NULL AS VATOriginalAmount, NULL AS VATConvertedAmount,
			 NULL AS ReVoucherID, NULL AS ReBatchID, NULL AS ReTransactionID, NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, NULL AS Parameter06,
			 NULL AS Parameter07, NULL AS Parameter08, NULL AS Parameter09, NULL AS Parameter10, NULL AS MOrderID, NULL AS SOrderID, NULL AS MTransactionID, NULL AS STransactionID, NULL AS RefVoucherNo,
			 NULL AS IsLateInvoice, NULL AS ConvertedQuantity, NULL AS ConvertedPrice, NULL AS ConvertedUnitID, NULL AS ConversionFactor, NULL AS UParameter01, NULL AS UParameter02, NULL AS UParameter03,
			 NULL AS UParameter04, NULL AS UParameter05, NULL AS PriceListID, NULL AS WOrderID, NULL AS WTransactionID, NULL AS MarkQuantity, NULL AS TVoucherID, NULL AS OldCounter, NULL AS NewCounter,
			 NULL AS OtherCounter, NULL AS TBatchID, NULL AS ContractDetailID, NULL AS InvoiceCode, NULL AS InvoiceSign, NULL AS RefInfor, NULL AS StandardPrice, NULL AS StandardAmount, NULL AS IsCom,
			 NULL AS VirtualPrice, NULL AS VirtualAmount, NULL AS ReTableID, NULL AS DParameter01, NULL AS DParameter02, NULL AS DParameter03, NULL AS DParameter04, NULL AS DParameter05, NULL AS DParameter06,
			 NULL AS DParameter07, NULL AS DParameter08, NULL AS DParameter09, NULL AS DParameter10, NULL AS InheritTableID, NULL AS InheritVoucherID, NULL AS InheritTransactionID, NULL AS ETaxVoucherID,
			 NULL AS ETaxID, NULL AS ETaxConvertedUnit, NULL AS ETaxConvertedAmount, NULL AS ETaxTransactionID, NULL AS AssignedSET, NULL AS SETID, NULL AS SETUnitID, NULL AS SETTaxRate,
			 NULL AS SETConvertedUnit, NULL AS SETQuantity, NULL AS SETOriginalAmount, NULL AS SETConvertedAmount, NULL AS SETConsistID, NULL AS SETTransactionID, NULL AS AssignedNRT, NULL AS NRTTaxAmount,
			 NULL AS NRTClassifyID, NULL AS NRTUnitID, NULL AS NRTTaxRate, NULL AS NRTConvertedUnit, NULL AS NRTQuantity, NULL AS NRTOriginalAmount, NULL AS NRTConvertedAmount, NULL AS NRTConsistID,
			 NULL AS NRTTransactionID, NULL AS CreditObjectName, NULL AS CreditVATNo, NULL AS IsPOCost, NULL AS TaxBaseAmount, NULL AS WTCExchangeRate, NULL AS WTCOperator, NULL AS IsFACost,
			 NULL AS IsInheritFA, NULL AS InheritedFAVoucherID, NULL AS AVRExchangeRate, NULL AS PaymentExchangeRate, NULL AS IsMultiExR, NULL AS ExchangeRateDate, NULL AS DiscountSalesAmount,
			 NULL AS IsProInventoryID, NULL AS InheritQuantity, NULL AS DiscountPercentSOrder, NULL AS DiscountAmountSOrder, NULL AS IsWithhodingTax, NULL AS IsSaleInvoice, NULL AS WTTransID,
			 NULL AS DiscountSaleAmountDetail, NULL AS ABParameter01, NULL AS ABParameter02, NULL AS ABParameter03, NULL AS ABParameter04, NULL AS ABParameter05, NULL AS ABParameter06,
			 NULL AS ABParameter07, NULL AS ABParameter08, NULL AS ABParameter09, NULL AS ABParameter10, NULL AS SOAna01ID, NULL AS SOAna02ID, NULL AS SOAna03ID, NULL AS SOAna04ID, NULL AS SOAna05ID,
			 NULL AS IsVATWithhodingTax, NULL AS VATWithhodingRate, NULL AS IsEInvoice, NULL AS EInvoiceStatus, NULL AS IsAdvancePayment, NULL AS Fkey, NULL AS IsInheritInvoicePOS,
			 NULL AS InheritInvoicePOS, NULL AS IsInheritPayPOS, NULL AS InheritPayPOS, NULL AS IsInvoiceSuggest, NULL AS RefVoucherDate, NULL AS IsDeposit, NULL AS ReTransactionTypeID,
			 NULL AS ImVoucherID, NULL AS ImTransactionID, NULL AS SourceNo, NULL AS LimitDate, NULL AS IsPromotionItem, NULL AS ObjectName1, NULL AS TaxRateID, NULL AS PayMethodID, NULL AS DiscountedUnitPrice, 
			 NULL AS ConvertedDiscountedUnitPrice, NULL AS IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
			 NULL AS BankAccountNo, NULL AS BankName, NULL AS ContactPerson, NULL AS DVATOriginalAmount, NULL AS DVATConvertedAmount, NULL AS ConvertedUnitName, NULL AS PaymentName, NULL AS IsDiscount, NULL AS DivisionNameE, NULL AS AddressE, NULL AS District, NULL AS DContactPerson,
			 NULL AS OriginalAfterVATAmount, NULL AS ConvertedAfterVATAmount, NULL AS WSourceNo, NULL AS WLimitDate, NULL AS I04ID, NULL AS I04Name, 4 as ItemTypeID
		FROM #TEMP
		GROUP BY Parameter10
		'
IF EXISTS (SELECT TOP 1 1  FROM AT0000 WHERE DefDivisionID=@DivisionID AND EInvoicePartner='BKAV') AND EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter09,'') <> '')
		SET @sSQL4='
			UNION ALL

			SELECT	NULL AS Remark, NULL AS CusCode, NULL AS CusName, NULL AS CusAddress, NULL AS CusPhone, NULL AS CusEmail, NULL AS CusTaxCode, NULL AS Buyer, NULL AS CusbankNo, NULL AS PaymentMethod, 
			NULL AS Total, NULL AS DiscountAmount, NULL AS AfterAmount, NULL AS VATAmount, NULL AS VAT_Rate,
			NULL AS ProdID, Parameter09 as ProdName, NULL AS ProdUnit, NULL AS ProdQuantity, NULL AS ProdPrice, NULL AS TotalAmount, NULL AS Amount, NULL AS InheritFkey, NULL AS EInvoiceType, NULL AS TypeOfAdjust, NULL AS TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
			NULL AS DonDatHangSo, NULL AS OriginalAmount, NULL AS KindOfService, NULL AS Extra1, NULL AS VATAmount0, NULL AS VATAmount10, NULL AS Extra, NULL AS InvoiceDate, NULL AS CurrencyID, NULL AS PaymentID, NULL AS VoucherNo,
			 NULL AS VoucherID, NULL AS BatchID, NULL AS TransactionID, NULL AS TableID, NULL AS TranMonth, NULL AS TranYear, NULL AS TransactionTypeID, NULL AS ObjectID, NULL AS CreditObjectID, NULL AS VATNo,
			 NULL AS VATObjectID, NULL AS VATObjectName,NULL AS VATCusPhone,NULL AS VATCusTaxCode,NULL AS VATCusbankNo, NULL AS VATObjectAddress, NULL AS DebitAccountID, NULL AS CreditAccountID, NULL AS ExchangeRate, NULL AS UnitPrice, NULL AS OriginalAmountAT9000,
			 NULL AS ConvertedAmount, NULL AS ImTaxOriginalAmount, NULL AS ImTaxConvertedAmount, NULL AS ExpenseOriginalAmount, NULL AS ExpenseConvertedAmount, NULL AS IsStock, NULL AS VoucherDate,
			 NULL AS VoucherTypeID, NULL AS VATGroupID, NULL AS Serial, NULL AS InvoiceNo, NULL AS Orders, NULL AS EmployeeID, NULL AS SenderReceiver, NULL AS SRDivisionName, NULL AS SRAddress,
			 NULL AS RefNo01, NULL AS RefNo02, NULL AS VDescription, NULL AS BDescription, NULL AS Quantity, NULL AS InventoryID, NULL AS UnitID, NULL AS Status, NULL AS IsAudit, NULL AS IsCost,
			 NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, NULL AS PeriodID,
			 NULL AS ExpenseID, NULL AS MaterialTypeID, NULL AS ProductID, NULL AS CreateDate, NULL AS CreateUserID, NULL AS LastModifyUserID, NULL AS LastModifyDate, NULL AS OriginalAmountCN,
			 NULL AS ExchangeRateCN, NULL AS CurrencyIDCN, NULL AS DueDays, NULL AS DueDate, NULL AS DiscountRate, NULL AS OrderID, NULL AS CreditBankAccountID, NULL AS DebitBankAccountID,
			 NULL AS CommissionPercent, NULL AS InventoryName1, NULL AS PaymentTermID, NULL AS DiscountAmountAT9000, NULL AS OTransactionID, NULL AS IsMultiTax, NULL AS VATOriginalAmount, NULL AS VATConvertedAmount,
			 NULL AS ReVoucherID, NULL AS ReBatchID, NULL AS ReTransactionID, NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, NULL AS Parameter06,
			 NULL AS Parameter07, NULL AS Parameter08, NULL AS Parameter09, NULL AS Parameter10, NULL AS MOrderID, NULL AS SOrderID, NULL AS MTransactionID, NULL AS STransactionID, NULL AS RefVoucherNo,
			 NULL AS IsLateInvoice, NULL AS ConvertedQuantity, NULL AS ConvertedPrice, NULL AS ConvertedUnitID, NULL AS ConversionFactor, NULL AS UParameter01, NULL AS UParameter02, NULL AS UParameter03,
			 NULL AS UParameter04, NULL AS UParameter05, NULL AS PriceListID, NULL AS WOrderID, NULL AS WTransactionID, NULL AS MarkQuantity, NULL AS TVoucherID, NULL AS OldCounter, NULL AS NewCounter,
			 NULL AS OtherCounter, NULL AS TBatchID, NULL AS ContractDetailID, NULL AS InvoiceCode, NULL AS InvoiceSign, NULL AS RefInfor, NULL AS StandardPrice, NULL AS StandardAmount, NULL AS IsCom,
			 NULL AS VirtualPrice, NULL AS VirtualAmount, NULL AS ReTableID, NULL AS DParameter01, NULL AS DParameter02, NULL AS DParameter03, NULL AS DParameter04, NULL AS DParameter05, NULL AS DParameter06,
			 NULL AS DParameter07, NULL AS DParameter08, NULL AS DParameter09, NULL AS DParameter10, NULL AS InheritTableID, NULL AS InheritVoucherID, NULL AS InheritTransactionID, NULL AS ETaxVoucherID,
			 NULL AS ETaxID, NULL AS ETaxConvertedUnit, NULL AS ETaxConvertedAmount, NULL AS ETaxTransactionID, NULL AS AssignedSET, NULL AS SETID, NULL AS SETUnitID, NULL AS SETTaxRate,
			 NULL AS SETConvertedUnit, NULL AS SETQuantity, NULL AS SETOriginalAmount, NULL AS SETConvertedAmount, NULL AS SETConsistID, NULL AS SETTransactionID, NULL AS AssignedNRT, NULL AS NRTTaxAmount,
			 NULL AS NRTClassifyID, NULL AS NRTUnitID, NULL AS NRTTaxRate, NULL AS NRTConvertedUnit, NULL AS NRTQuantity, NULL AS NRTOriginalAmount, NULL AS NRTConvertedAmount, NULL AS NRTConsistID,
			 NULL AS NRTTransactionID, NULL AS CreditObjectName, NULL AS CreditVATNo, NULL AS IsPOCost, NULL AS TaxBaseAmount, NULL AS WTCExchangeRate, NULL AS WTCOperator, NULL AS IsFACost,
			 NULL AS IsInheritFA, NULL AS InheritedFAVoucherID, NULL AS AVRExchangeRate, NULL AS PaymentExchangeRate, NULL AS IsMultiExR, NULL AS ExchangeRateDate, NULL AS DiscountSalesAmount,
			 NULL AS IsProInventoryID, NULL AS InheritQuantity, NULL AS DiscountPercentSOrder, NULL AS DiscountAmountSOrder, NULL AS IsWithhodingTax, NULL AS IsSaleInvoice, NULL AS WTTransID,
			 NULL AS DiscountSaleAmountDetail, NULL AS ABParameter01, NULL AS ABParameter02, NULL AS ABParameter03, NULL AS ABParameter04, NULL AS ABParameter05, NULL AS ABParameter06,
			 NULL AS ABParameter07, NULL AS ABParameter08, NULL AS ABParameter09, NULL AS ABParameter10, NULL AS SOAna01ID, NULL AS SOAna02ID, NULL AS SOAna03ID, NULL AS SOAna04ID, NULL AS SOAna05ID,
			 NULL AS IsVATWithhodingTax, NULL AS VATWithhodingRate, NULL AS IsEInvoice, NULL AS EInvoiceStatus, NULL AS IsAdvancePayment, NULL AS Fkey, NULL AS IsInheritInvoicePOS,
			 NULL AS InheritInvoicePOS, NULL AS IsInheritPayPOS, NULL AS InheritPayPOS, NULL AS IsInvoiceSuggest, NULL AS RefVoucherDate, NULL AS IsDeposit, NULL AS ReTransactionTypeID,
			 NULL AS ImVoucherID, NULL AS ImTransactionID, NULL AS SourceNo, NULL AS LimitDate, NULL AS IsPromotionItem, NULL AS ObjectName1, NULL AS TaxRateID, NULL AS PayMethodID, NULL AS DiscountedUnitPrice, 
			 NULL AS ConvertedDiscountedUnitPrice, NULL AS IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
			 NULL AS BankAccountNo, NULL AS BankName, NULL AS ContactPerson, NULL AS DVATOriginalAmount, NULL AS DVATConvertedAmount, NULL AS ConvertedUnitName, NULL AS PaymentName, NULL AS IsDiscount, NULL AS DivisionNameE, NULL AS AddressE, NULL AS District, NULL AS DContactPerson,
			 NULL AS OriginalAfterVATAmount, NULL AS ConvertedAfterVATAmount, NULL AS WSourceNo, NULL AS WLimitDate, NULL AS I04ID, NULL AS I04Name, 4 as ItemTypeID
		FROM #TEMP
		GROUP BY Parameter09
		'
print @sSQL
print @sSQL1A
print @sSQL1A1
print @sSQL2A
print @sSQLA
print @sSQL3
print @sSQL4
EXEC (@sSQL+@sSQL1A+@sSQL1A1+@sSQL2A+@sSQLA+@sSQLA8+@sSQL3+@sSQL4)
	






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
