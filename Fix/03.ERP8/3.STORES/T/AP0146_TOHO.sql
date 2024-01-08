IF EXISTS (
		SELECT TOP 1 1
		FROM DBO.SYSOBJECTS
		WHERE ID = OBJECT_ID(N'[DBO].[AP0146_TOHO]')
			AND OBJECTPROPERTY(ID, N'IsProcedure') = 1
		)
	DROP PROCEDURE [DBO].[AP0146_TOHO]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

-- AP0146_TOHO
-- <Summary>
---- Stored load dữ liệu hóa đơn phục vụ phát hành hóa đơn điện tử - Customize TOHO
---- Created on 22/09/2020 Đức Thông
-- <Param>
-- <History>
--	Modified on 22/09/2020 by Đức Thông: Customize toho: lấy thành tiền nguyên tệ thay vì qui đổi
--	Modified on 24/09/2020 by Đức Thông: Bỏ stt ở dòng chú thích
--	Modified on 24/09/2020 by Đức Thông: Lấy tổng tiền là tiền nguyên tệ
--  Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--  Modify on 14/10/2020 by Đức Thông: Sửa câu truy vấn lấy tên mặt hàng loại bỏ mã hàng
-- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Return>
---- 
-- <Reference>
---- 
CREATE PROCEDURE [dbo].[AP0146_TOHO] @DivisionID AS NVARCHAR(50)
	,@UserID AS NVARCHAR(50)
	,@VoucherID AS NVARCHAR(50)
AS
DECLARE @sSQL AS NVARCHAR(MAX) = ''
	,@sSQL1A AS NVARCHAR(MAX) = ''
	,@sSQL1A1 AS NVARCHAR(MAX) = ''
	,@sSQL2A AS NVARCHAR(MAX) = ''
	,@sSQLA AS NVARCHAR(MAX) = ''
	,@sSQL3 AS NVARCHAR(MAX) = ''
	,@sSQL4 AS NVARCHAR(MAX) = ''
	,@sSQL5 AS NVARCHAR(MAX) = ''

SET @sSQL = 
	'     
	SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, 
	CASE WHEN ISNULL(AT9000.VATObjectName,'''') <> '''' THEN AT9000.VATObjectName ELSE AT1202.ObjectName END AS CusName, 
	AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone,  AT1202.Email AS CusEmail, AT9000.VATNo AS CusTaxCode,
	AT1202.ObjectName AS Buyer, AT1202.TradeName AS CusbankNo,
		
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
	- ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,

	ISNULL((SELECT SUM(ABS(DiscountAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(ABS(DiscountSalesAmount), 0) AS DiscountAmount,
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,

	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) 
	- ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,
		
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND VATGroupID = ''T00''), 0) AS VATAmount0,
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND VATGroupID = ''T10''), 0) AS VATAmount10,
	'
SET @sSQL1A = 
	N'
	CASE WHEN AT9000.VATGroupID=''TS0'' THEN -1 ELSE AT1010.VATRate END AS VAT_Rate, AT9000.InventoryID AS ProdID,		
	ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName,		
	AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
	ABS(AT9000.ConvertedPrice) AS ProdPrice, ABS(AT9000.OriginalAmount) AS Amount,
	AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, ISNULL(AT9000.TDescription,'''') AS TDescription, A02.AnaName as Ana02Name,
	AT9000.PaymentID AS PaymentMethod,
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
SET @sSQL1A1 = 
	N' AT9000.DiscountAmount as DiscountAmountAT9000, AT9000.OTransactionID, AT9000.IsMultiTax, 
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

	AT9000.ABParameter01,AT9000.ABParameter02,AT9000.ABParameter03,AT9000.ABParameter04,AT9000.ABParameter05,AT9000.ABParameter06,
	AT9000.ABParameter07,AT9000.ABParameter08,AT9000.ABParameter09,AT9000.ABParameter10,AT9000.SOAna01ID,AT9000.SOAna02ID,AT9000.SOAna03ID,AT9000.SOAna04ID,AT9000.SOAna05ID,
	AT9000.IsVATWithhodingTax,AT9000.VATWithhodingRate,AT9000.IsEInvoice,AT9000.EInvoiceStatus,AT9000.IsAdvancePayment,AT9000.Fkey,AT9000.IsInheritInvoicePOS,
	AT9000.InheritInvoicePOS,AT9000.IsInheritPayPOS,AT9000.InheritPayPOS,AT9000.IsInvoiceSuggest,AT9000.RefVoucherDate,AT9000.IsDeposit,AT9000.ReTransactionTypeID,
	AT9000.ImVoucherID,AT9000.ImTransactionID,AT9000.SourceNo,AT9000.LimitDate,AT9000.IsPromotionItem,AT9000.ObjectName1,'
	SET @sSQL2A = 
	'
	CASE AT9000.VATGroupID WHEN ''T00'' THEN 1 WHEN ''T05'' THEN 2 WHEN ''T10'' THEN 3 WHEN ''TS0'' THEN 4 WHEN ''TZ0'' THEN 5 ELSE NULL END AS TaxRateID,
	CASE AT9000.PaymentID WHEN ''TM'' THEN 1 WHEN ''CK'' THEN 2 WHEN ''TM/CK'' THEN 3 ELSE NULL END AS PayMethodID, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice, AT9000.IsReceived,
	A16.BankAccountNo, A16.BankName, A26.ContactPerson, 
	ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as DVATOriginalAmount, ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) as DVATConvertedAmount,
	A13.UnitName AS ConvertedUnitName, A12.PaymentName, CASE WHEN TransactionTypeID = ''T64'' THEN 1 ELSE 0 END AS IsDiscount, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson,
	ISNULL(AT9000.OriginalAmount,0) + ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as OriginalAfterVATAmount, 
	ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) AS ConvertedAfterVATAmount,
	A27.SourceNo as WSourceNo, CONVERT(NVARCHAR(10),A27.LimitDate,103) as WLimitDate, AT1302.I04ID, AT1015.AnaName as I04Name,
	AT1202.BankAccountNo as CusBankAccountNo,
	(SELECT TOP 1 InvoiceSign  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentInvoiceSign,
	(SELECT TOP 1 Serial  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentSerial
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
	WHERE AT9000.DivisionID = ''' 
	+ @DivisionID + '''
	AND AT9000.VoucherID = ''' + @VoucherID + ''' 
	AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'',''T64'')
	ORDER BY AT9000.Orders
	'
SET @sSQLA = 
	'
		SELECT * FROM (
			SELECT TOP 100 PERCENT Remark
	,CusCode
	,CusName
	,CusAddress
	,CusPhone
	,CusEmail
	,CusTaxCode
	,Buyer
	,PaymentMethod
	,Total
	,DiscountAmount
	,AfterAmount
	,VATAmount
	,VAT_Rate
	,ProdID
	,ProdName
	,ProdUnit
	,ProdQuantity
	,ProdPrice
	,Amount
	,InheritFkey
	,EInvoiceType
	,TypeOfAdjust
	,TDescription
	,Ana02ID
	,Ana02Name
	,DonDatHangSo
	,OriginalAmount
	,KindOfService
	,Extra1
	,VATAmount0
	,VATAmount10
	,Extra
	,InvoiceDate
	,CurrencyID
	,PaymentID
	,VoucherNo
	,VoucherID
	,BatchID
	,TransactionID
	,TableID
	,TranMonth
	,TranYear
	,TransactionTypeID
	,ObjectID
	,CreditObjectID
	,VATNo
	,VATObjectID
	,VATObjectName
	,VATObjectAddress
	,DebitAccountID
	,CreditAccountID
	,ExchangeRate
	,UnitPrice
	,OriginalAmountAT9000
	,ConvertedAmount
	,ImTaxOriginalAmount
	,ImTaxConvertedAmount
	,ExpenseOriginalAmount
	,ExpenseConvertedAmount
	,IsStock
	,VoucherDate
	,VoucherTypeID
	,VATGroupID
	,Serial
	,InvoiceNo
	,Orders
	,EmployeeID
	,SenderReceiver
	,SRDivisionName
	,SRAddress
	,RefNo01
	,RefNo02
	,VDescription
	,BDescription
	,Quantity
	,InventoryID
	,UnitID
	,STATUS
	,IsAudit
	,IsCost
	,Ana01ID
	,Ana03ID
	,Ana04ID
	,Ana05ID
	,Ana06ID
	,Ana07ID
	,Ana08ID
	,Ana09ID
	,Ana10ID
	,PeriodID
	,ExpenseID
	,MaterialTypeID
	,ProductID
	,CreateDate
	,CreateUserID
	,LastModifyUserID
	,LastModifyDate
	,OriginalAmountCN
	,ExchangeRateCN
	,CurrencyIDCN
	,DueDays
	,DueDate
	,DiscountRate
	,OrderID
	,CreditBankAccountID
	,DebitBankAccountID
	,CommissionPercent
	,InventoryName1
	,PaymentTermID
	,DiscountAmountAT9000
	,OTransactionID
	,IsMultiTax
	,VATOriginalAmount
	,VATConvertedAmount
	,ReVoucherID
	,ReBatchID
	,ReTransactionID
	,Parameter01
	,Parameter02
	,Parameter03
	,Parameter04
	,Parameter05
	,Parameter06
	,Parameter07
	,Parameter08
	,Parameter09
	,Parameter10
	,MOrderID
	,SOrderID
	,MTransactionID
	,STransactionID
	,RefVoucherNo
	,IsLateInvoice
	,ConvertedQuantity
	,ConvertedPrice
	,ConvertedUnitID
	,ConversionFactor
	,UParameter01
	,UParameter02
	,UParameter03
	,UParameter04
	,UParameter05
	,PriceListID
	,WOrderID
	,WTransactionID
	,MarkQuantity
	,TVoucherID
	,OldCounter
	,NewCounter
	,OtherCounter
	,TBatchID
	,ContractDetailID
	,InvoiceCode
	,InvoiceSign
	,RefInfor
	,StandardPrice
	,StandardAmount
	,IsCom
	,VirtualPrice
	,VirtualAmount
	,ReTableID
	,DParameter01
	,DParameter02
	,DParameter03
	,DParameter04
	,DParameter05
	,DParameter06
	,DParameter07
	,DParameter08
	,DParameter09
	,DParameter10
	,InheritTableID
	,InheritVoucherID
	,InheritTransactionID
	,ETaxVoucherID
	,ETaxID
	,ETaxConvertedUnit
	,ETaxConvertedAmount
	,ETaxTransactionID
	,AssignedSET
	,SETID
	,SETUnitID
	,SETTaxRate
	,SETConvertedUnit
	,SETQuantity
	,SETOriginalAmount
	,SETConvertedAmount
	,SETConsistID
	,SETTransactionID
	,AssignedNRT
	,NRTTaxAmount
	,NRTClassifyID
	,NRTUnitID
	,NRTTaxRate
	,NRTConvertedUnit
	,NRTQuantity
	,NRTOriginalAmount
	,NRTConvertedAmount
	,NRTConsistID
	,NRTTransactionID
	,CreditObjectName
	,CreditVATNo
	,IsPOCost
	,TaxBaseAmount
	,WTCExchangeRate
	,WTCOperator
	,IsFACost
	,IsInheritFA
	,InheritedFAVoucherID
	,AVRExchangeRate
	,PaymentExchangeRate
	,IsMultiExR
	,ExchangeRateDate
	,DiscountSalesAmount
	,IsProInventoryID
	,InheritQuantity
	,DiscountPercentSOrder
	,DiscountAmountSOrder
	,IsWithhodingTax
	,IsSaleInvoice
	,WTTransID
	,DiscountSaleAmountDetail
	,ABParameter01
	,ABParameter02
	,ABParameter03
	,ABParameter04
	,ABParameter05
	,ABParameter06
	,ABParameter07
	,ABParameter08
	,ABParameter09
	,ABParameter10
	,SOAna01ID
	,SOAna02ID
	,SOAna03ID
	,SOAna04ID
	,SOAna05ID
	,IsVATWithhodingTax
	,VATWithhodingRate
	,IsEInvoice
	,EInvoiceStatus
	,IsAdvancePayment
	,Fkey
	,IsInheritInvoicePOS
	,InheritInvoicePOS
	,IsInheritPayPOS
	,InheritPayPOS
	,IsInvoiceSuggest
	,RefVoucherDate
	,IsDeposit
	,ReTransactionTypeID
	,ImVoucherID
	,ImTransactionID
	,SourceNo
	,LimitDate
	,IsPromotionItem
	,ObjectName1
	,TaxRateID
	,PayMethodID
	,DiscountedUnitPrice
	,ConvertedDiscountedUnitPrice
	,IsReceived
	,Ana01Name
	,Ana03Name
	,Ana04Name
	,Ana05Name
	,Ana06Name
	,Ana07Name
	,Ana08Name
	,Ana09Name
	,Ana10Name
	,BankAccountNo
	,BankName
	,ContactPerson
	,DVATOriginalAmount
	,DVATConvertedAmount
	,ConvertedUnitName
	,PaymentName
	,IsDiscount
	,DivisionNameE
	,AddressE
	,District
	,DContactPerson
	,OriginalAfterVATAmount
	,ConvertedAfterVATAmount
	,WSourceNo
	,WLimitDate
	,I04ID
	,I04Name
	,0 AS ItemTypeID
	,CusBankAccountNo
	,ParentInvoiceSign
	,ParentSerial
FROM #TEMP
ORDER BY Remark


		) X
	'

IF EXISTS (
		SELECT TOP 1 1
		FROM AT0000
		WHERE DefDivisionID = @DivisionID
			AND EInvoicePartner = 'VNPT'
		)
	AND EXISTS (
		SELECT TOP 1 1
		FROM AT9000 WITH (NOLOCK)
		WHERE VoucherID = @VoucherID
			AND ISNULL(Parameter01, '') <> ''
		)
	SET @sSQL3 = 
		'
			

UNION ALL

SELECT TOP 1
	NULL AS Remark
	,CusCode AS CusCode
	,CusName AS CusName
	,CusAddress AS CusAddress
	,'''' AS CusPhone
	,'''' AS CusEmail
	,'''' AS CusTaxCode
	,Buyer AS Buyer
	,'''' AS PaymentMethod
	,0 AS Total
	,0 AS DiscountAmount
	,0 AS AfterAmount
	,0 AS VATAmount
	,0 AS VAT_Rate
	,'''' AS ProdID
	,Parameter01 AS ProdName
	,'''' AS ProdUnit
	,0 AS ProdQuantity
	,0 AS ProdPrice
	,0 AS Amount
	,'''' AS InheritFkey
	,0 AS EInvoiceType
	,0 AS TypeOfAdjust
	,'''' AS TDescription
	,'''' AS Ana02ID
	,'''' AS Ana02Name
	,'''' AS DonDatHangSo
	,0 AS OriginalAmount
	,'''' AS KindOfService
	,CurrencyID AS Extra1
	,0 AS VATAmount0
	,0 AS VATAmount10
	,1 AS Extra
	,InvoiceDate
	,CurrencyID
	,'''' AS VoucherID
	,'''' AS PaymentID
	,'''' AS VoucherNo
	,'''' AS BatchID
	,'''' AS TransactionID
	,'''' AS TableID
	,0 AS TranMonth
	,0 AS TranYear
	,'''' AS TransactionTypeID
	,'''' AS ObjectID
	,'''' AS CreditObjectID
	,'''' AS VATNo
	,'''' AS VATObjectID
	,'''' AS VATObjectName
	,'''' AS VATObjectAddress
	,'''' AS DebitAccountID
	,'''' AS CreditAccountID
	,1 AS ExchangeRate
	,0 AS UnitPrice
	,0 AS OriginalAmountAT9000
	,0 AS ConvertedAmount
	,0 AS ImTaxOriginalAmount
	,0 AS ImTaxConvertedAmount
	,0 AS ExpenseOriginalAmount
	,0 AS ExpenseConvertedAmount
	,0 AS IsStock
	,'''' AS VoucherDate
	,'''' AS VoucherTypeID
	,'''' AS VATGroupID
	,'''' AS Serial
	,'''' AS InvoiceNo
	,0 AS Orders
	,'''' AS EmployeeID
	,'''' AS SenderReceiver
	,'''' AS SRDivisionName
	,'''' AS SRAddress
	,'''' AS RefNo01
	,'''' AS RefNo02
	,'''' AS VDescription
	,'''' AS BDescription
	,0 AS Quantity
	,'''' AS InventoryID
	,'''' AS UnitID
	,'''' AS STATUS
	,0 AS IsAudit
	,0 AS IsCost
	,'''' AS Ana01ID
	,'''' AS Ana03ID
	,'''' AS Ana04ID
	,'''' AS Ana05ID
	,'''' AS Ana06ID
	,'''' AS Ana07ID
	,'''' AS Ana08ID
	,'''' AS Ana09ID
	,'''' AS Ana10ID
	,'''' AS PeriodID
	,'''' AS ExpenseID
	,'''' AS MaterialTypeID
	,'''' AS ProductID
	,'''' AS CreateDate
	,'''' AS CreateUserID
	,'''' AS LastModifyDate
	,'''' AS LastModifyUserID
	,0 AS OriginalAmountCN
	,1 AS ExchangeRateCN
	,'''' AS CurrencyIDCN
	,0 AS DueDays
	,'''' AS DueDate
	,0 AS DiscountRate
	,'''' AS OrderID
	,'''' AS CreditBankAccountID
	,'''' AS DebitBankAccountID
	,0 AS CommissionPercent
	,'''' AS InventoryName1
	,'''' AS PaymentTermID
	,0 AS DiscountAmountAT9000
	,'''' AS OTransactionID
	,0 AS IsMultiTax
	,0 AS VATOriginalAmount
	,0 AS VATConvertedAmount
	,'''' AS ReVoucherID
	,'''' AS ReBatchID
	,'''' AS ReTransactionID
	,'''' AS Parameter01
	,'''' AS Parameter02
	,'''' AS Parameter03
	,'''' AS Parameter04
	,'''' AS Parameter05
	,'''' AS Parameter06
	,'''' AS Parameter07
	,'''' AS Parameter08
	,'''' AS Parameter09
	,'''' AS Parameter10
	,'''' AS MOrderID
	,'''' AS SOrderID
	,'''' AS MTransactionID
	,'''' AS STransactionID
	,'''' AS RefVoucherNo
	,0 AS IsLateInvoice
	,0 AS ConvertedQuantity
	,0 AS ConvertedPrice
	,'''' AS ConvertedUnitID
	,0 AS ConversionFactor
	,0 AS UParameter01
	,0 AS UParameter02
	,0 AS UParameter03
	,0 AS UParameter04
	,0 AS UParameter05
	,'''' AS PriceListID
	,'''' AS WOrderID
	,'''' AS WTransactionID
	,0 AS MarkQuantity
	,'''' AS TVoucherID
	,0 AS OldCounter
	,0 AS NewCounter
	,0 AS OtherCounter
	,'''' AS TBatchID
	,'''' AS ContractDetailID
	,'''' AS InvoiceCode
	,'''' AS InvoiceSign
	,'''' AS RefInfor
	,0 AS StandardPrice
	,0 AS StandardAmount
	,0 AS IsCom
	,0 AS VirtualPrice
	,0 AS VirtualAmount
	,'''' AS ReTableID
	,'''' AS DParameter01
	,'''' AS DParameter02
	,'''' AS DParameter03
	,'''' AS DParameter04
	,'''' AS DParameter05
	,'''' AS DParameter06
	,'''' AS DParameter07
	,'''' AS DParameter08
	,'''' AS DParameter09
	,'''' AS DParameter10
	,'''' AS InheritTableID
	,'''' AS InheritVoucherID
	,'''' AS InheritTransactionID
	,'''' AS ETaxVoucherID
	,'''' AS ETaxID
	,0 AS ETaxConvertedUnit
	,0 AS ETaxConvertedAmount
	,'''' AS ETaxTransactionID
	,0 AS AssignedSET
	,'''' AS SETID
	,'''' AS SETUnitID
	,0 AS SETTaxRate
	,0 AS SETConvertedUnit
	,0 AS SETQuantity
	,0 AS SETOriginalAmount
	,0 AS SETConvertedAmount
	,'''' AS SETConsistID
	,'''' AS SETTransactionID
	,0 AS AssignedNRT
	,0 AS NRTTaxAmount
	,'''' AS NRTClassifyID
	,'''' AS NRTUnitID
	,0 AS NRTTaxRate
	,0 AS NRTConvertedUnit
	,0 AS NRTQuantity
	,0 AS NRTOriginalAmount
	,0 AS NRTConvertedAmount
	,'''' AS NRTConsistID
	,'''' AS NRTTransactionID
	,'''' AS CreditObjectName
	,'''' AS CreditVATNo
	,0 AS IsPOCost
	,0 AS TaxBaseAmount
	,0 AS WTCExchangeRate
	,0 AS WTCOperator
	,0 AS IsFACost
	,0 AS IsInheritFA
	,'''' AS InheritedFAVoucherID
	,0 AS AVRExchangeRate
	,0 AS PaymentExchangeRate
	,0 AS IsMultiExR
	,'''' AS ExchangeRateDate
	,0 AS DiscountSalesAmount
	,0 AS IsProInventoryID
	,0 AS InheritQuantity
	,0 AS DiscountPercentSOrder
	,0 AS DiscountAmountSOrder
	,0 AS IsWithhodingTax
	,0 AS IsSaleInvoice
	,'''' AS WTTransID
	,0 AS DiscountSaleAmountDetail
	,'''' AS ABParameter01
	,'''' AS ABParameter02
	,'''' AS ABParameter03
	,'''' AS ABParameter04
	,'''' AS ABParameter05
	,'''' AS ABParameter06
	,'''' AS ABParameter07
	,'''' AS ABParameter08
	,'''' AS ABParameter09
	,'''' AS ABParameter10
	,'''' AS SOAna01ID
	,'''' AS SOAna02ID
	,'''' AS SOAna03ID
	,'''' AS SOAna04ID
	,'''' AS SOAna05ID
	,0 AS IsVATWithhodingTax
	,0 AS VATWithhodingRate
	,0 AS IsEInvoice
	,0 AS EInvoiceStatus
	,0 AS IsAdvancePayment
	,'''' AS Fkey
	,0 AS IsInheritInvoicePOS
	,'''' AS InheritInvoicePOS
	,0 AS IsInheritPayPOS
	,'''' AS InheritPayPOS
	,0 AS IsInvoiceSuggest
	,'''' AS RefVoucherDate
	,0 AS IsDeposit
	,'''' AS ReTransactionTypeID
	,'''' AS ImVoucherID
	,'''' AS ImTransactionID
	,'''' AS SourceNo
	,'''' AS LimitDate
	,0 AS IsPromotionItem
	,'''' AS ObjectName1
	,'''' AS TaxRateID
	,2 AS PayMethodID
	,0 AS DiscountedUnitPrice
	,0 AS ConvertedDiscountedUnitPrice
	,0 AS IsReceived
	,'''' AS Ana01Name
	,'''' AS Ana03Name
	,'''' AS Ana04Name
	,'''' AS Ana05Name
	,'''' AS Ana06Name
	,'''' AS Ana07Name
	,'''' AS Ana08Name
	,'''' AS Ana09Name
	,'''' AS Ana10Name
	,'''' AS BankAccountNo
	,'''' AS BankName
	,'''' AS ContactPerson
	,0 AS DVATOriginalAmount
	,0 AS DVATConvertedAmount
	,'''' AS ConvertedUnitName
	,'''' AS PaymentName
	,0 AS IsDiscount
	,'''' AS DivisionNameE
	,'''' AS AddressE
	,'''' AS District
	,'''' AS DContactPerson
	,0 AS OriginalAfterVATAmount
	,0 AS ConvertedAfterVATAmount
	,'''' AS WSourceNo
	,'''' AS WLimitDate
	,'''' AS I04ID
	,'''' AS I04Name
	,4 AS ItemTypeID
	,'''' AS CusBankAccountNo
	,'''' AS ParentInvoiceSign
	,'''' AS ParentSerial
FROM #TEMP


	
		'

print @sSQL
print @sSQL1A
print @sSQL1A1
print @sSQL2A
print @sSQLA
print @sSQL3

EXEC (@sSQL + @sSQL1A + @sSQL1A1 + @sSQL2A + @sSQLA + @sSQL3)
GO

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON
GO



