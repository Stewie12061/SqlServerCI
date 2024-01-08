IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0072]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Loc ra cac phieu thu - chi - doi tien 
---- Create on 23/09/2013 by Khanh Van
---- Modify on 03/11/2013 by Bảo Anh: Bổ sung trường ContractDetailID, ContractNo (kế thừa hợp đồng)
---- Modify on 16/01/2014 by Mai Duyen: Sửa điều kiện Format VoucherDate
---- Modified on 01/12/2014 by Lê Thị Hạnh: Bổ sung 10 trường tham số trên lưới phiếu thu/chi(Giống màn hình AF0066 - Hoá đơn bán hàng)
---- Modified on 06/03/2015 by Lê Thị Hạnh: Bổ sung IsPOCost chi phí mua hàng
---- Modified on 11/11/2015 by Phương Thảo: Bổ sung IsFACost: chi phí hình thành TSCĐ
---- Modified on 07/12/2015 by Phương Thảo: Bổ sung WithhodingTax - Khai thuế nhà thầu
---- Modified on 10/01/2016 by Phương Thảo: Bổ sung 2 tỷ giá thanh toán và BQ di động
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 11/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 12/06/2017: Bổ sung trường IsVATWithhodingTax, VATWithhodingRate khi load edit		
---- Modified by Hải Long on 12/06/2017: Bổ sung trường IsAdvancePayment - Là phiếu thu tạm ứng (Bê Tông Long An)	
---- Modified by Hoàng Vũ on 16/03/2018: Bổ sung trường IsInheritInvoicePOS, IsInheritPayPOS, IsInvoiceSuggest, IsDeposit - Là phiếu thu / thu qua ngân hàng (OKIA)	
---- Modified by Kim Thư on 25/02/2019: Sửa cách lấy ObjectName cho khách vãng lai là ISNULL(AT9000.VATObjectName,AT1202.ObjectName), khách không vãng lai thì lấy AT1202.ObjectName.
---- Modified by Huỳnh Thử on 18/08/2020: Merge code: MEKIO và MTE: -- Tách Store.
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Kiều Nga   on 02/04/2021: Lấy thêm trường ReVoucherNo (CBD)
---- Modified by Nhật Thanh   on 15/03/2022: Bổ sung điều kiện DivisionID IN cho bảng AT1202.
---- Modified by Thành Sang   on 14/02/2022: Cho phép truy vấn dữ liệu cũ.

-- <Example>
/*
 exec AP0072 @DivisionID=N'CTY',@TranMonth=11,@TranYear=2014,@FromDate='2014-12-01 00:00:00',@ToDate='2014-12-01 00:00:00',
 @ConditionVT=N'('''')',@IsUsedConditionVT=N' (0=0) ',@ConditionAC=N'('''')',@IsUsedConditionAC=N' (0=0) ',
 @ConditionOB=N'('''')',@IsUsedConditionOB=N' (0=0) ',@ObjectID=N'',@VoucherID=N'AV7d9cca8a-a8d4-419b-895a-b82b1b93f23e' 
*/

CREATE PROCEDURE [dbo].[AP0072]
								@DivisionID AS NVARCHAR(50),
								@TranMonth int,
								@TranYear int,
								@FromDate datetime,
								@ToDate datetime,
								@ConditionVT NVARCHAR(MAX),
								@IsUsedConditionVT NVARCHAR(MAX),
								@ConditionAC NVARCHAR(MAX),
								@IsUsedConditionAC NVARCHAR(MAX),
								@ConditionOB NVARCHAR(MAX),
								@IsUsedConditionOB NVARCHAR(MAX),
								@ObjectID NVARCHAR (50),
								@VoucherID  NVARCHAR(50)	
AS
	Declare @sSQL as NVARCHAR(MAX)
	, @CustomerName INT

	SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex
IF (@CustomerName = 50 OR @CustomerName = 115)
BEGIN
	EXEC AP0072_MK @DivisionID ,
								@TranMonth ,
								@TranYear ,
								@FromDate ,
								@ToDate ,
								@ConditionVT ,
								@IsUsedConditionVT ,
								@ConditionAC ,
								@IsUsedConditionAC ,
								@ConditionOB ,
								@IsUsedConditionOB ,
								@ObjectID  ,
								@VoucherID 	
END
ELSE
BEGIN
	IF ISNULL(@VoucherID, '') = ''--Load Truy vấn - AF0072
	BEGIN		
	SET @sSQL = '

	Select  VoucherTypeID,TransactionTypeID,AT9000.VoucherNo,VoucherDate,DebitAccountID,VoucherID,  
			TransactionID, BatchID,CreditAccountID, ExchangeRate, OriginalAmount,OriginalAmount As OldOriginalAmount,   
			ConvertedAmount,  InvoiceDate, DueDate,  (Case when AT9000.TransactionTypeID =''T11'' and AT9000.CurrencyIDCN<>''VND''  then AT9000.	CurrencyIDCN else   AT9000.CurrencyID end)  as CurrencyID, VATTypeID, AT9000.VATGroupID, Serial, InvoiceNo, Orders, 
			AT9000.EmployeeID,AT9000.ObjectID, 
			(Case when  isnull(AT1202.IsUpdateName,0) <>0 then   ISNULL(AT9000.VATObjectName,AT1202.ObjectName) else  AT1202.ObjectName end) AS ObjectName, RefNo01, RefNo02,
			VDescription, BDescription,TDescription,Quantity, AT9000.InventoryID,AT9000.UnitID,Status,IsAudit,AT9000.CreateDate, 
			AT9000.CreateUserID, AT9000.LastModifyDate, AT9000.LastModifyUserID,AT9000.DivisionID, TranMonth, TranYear, SenderReceiver, SRAddress,  SRDivisionName, C.IsObject as CIsObject, D.IsObject as DIsObject, isnull(AT1202.IsUpdateName,0) as IsUpdateName,AT9000.VATObjectName, 
			AT9000.VATObjectAddress, (Case when  isnull(AT1202.IsUpdateName,0) <>0 then   AT9000.VATNo  else  AT1202.VATNo  end) as VATNo,  
			AT9000.CurrencyIDCN, AT9000.ExchangeRateCN, AT9000.OriginalAmountCN, AT9000.Ana01ID,  AT9000.Ana02ID, AT9000.Ana03ID,AT9000.Ana04ID,
			AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID,AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, AT9000.OrderID, AT9000.PeriodID,
			M01.Description as PeriodName, AT9000.ProductID,AT02.InventoryName as ProductName, AT9000.ReVoucherID,AT9000.ReTransactionID, 
			AT9000.TVoucherID, AT9000.TBatchID, AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.TableID,
			AT9000.PaymentExchangeRate, AT9000.AVRExchangeRate, ISNULL(AT9000.IsAdvancePayment, 0) AS IsAdvancePayment,
			Isnull(AT9000.IsInheritInvoicePOS, 0) as IsInheritInvoicePOS, 
			Isnull(AT9000.IsInheritPayPOS,0) as IsInheritPayPOS, 
			Isnull(AT9000.IsInvoiceSuggest,0) as IsInvoiceSuggest, 
			Isnull(AT9000.IsDeposit,0) as IsDeposit,
			OV03.VoucherNo as ReVoucherNo
	From  AT9000 WITH (NOLOCK)  Left Join AT1202 WITH (NOLOCK) on AT9000.ObjectID =  AT1202.ObjectID AND AT1202.DivisionID IN (''@@@'',AT9000.DivisionID) 
	  Inner Join AT1005 D WITH (NOLOCK) on D.AccountID =  AT9000.DebitAccountID
	  Inner Join AT1005 C WITH (NOLOCK) on C.AccountID =  AT9000.CreditAccountID
	  Left Join MT1601 M01 WITH (NOLOCK) on M01.PeriodID = AT9000.PeriodID and M01.DivisionID = AT9000.DivisionID  
	  Left Join AT1302 as AT02 WITH (NOLOCK) on AT02.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT02.InventoryID = AT9000.ProductID
	  Left Join (Select DivisionID,OrderID ,VoucherNo  from OV1003 WITH (NOLOCK)) as OV03 on OV03.DivisionID IN (AT9000.DivisionID,''@@@'') AND OV03.OrderID = AT9000.OrderID

	Where (TransactionTypeID in (''T01'',''T02'',''T11'') or (TransactionTypeID in (''T04'', ''T14'') and DebitAccountID like ''111%'')    
				 or (TransactionTypeID in (''T03'', ''T13'', ''T23'') and CreditAccountID like ''111%'')   
				 or ( TransactionTypeID =''T21'' and CreditAccountID like ''111%'')  ---- Thu qua ngan hang
				 or ( TransactionTypeID =''T22'' and DebitAccountID like ''111%''))  ---- Chi qua ngan hang      
				and AT9000.DivisionID = ''' + @DivisionID + '''
				AND	(Isnull(AT9000.VoucherTypeID,''#'')  in ' + @ConditionVT + ' OR ' + @IsUsedConditionVT + ')
				AND	(Isnull(AT9000.DebitAccountID,''#'')  in ' + @ConditionAC + ' OR ' + @IsUsedConditionAC + ')
				AND	(Isnull(AT9000.CreditAccountID,''#'')  in ' + @ConditionAC + ' OR ' + @IsUsedConditionAC + ')
				AND	(Isnull(AT9000.ObjectID,''#'')  in ' + @ConditionOB + ' OR ' + @IsUsedConditionOB + ')
				And  Convert(nvarchar(10),AT9000.VoucherDate,21)   Between '''+ Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+'''
				AND isnull(AT9000.ObjectID,''%'') like ('''+@ObjectID+''')
	Order by	AT9000.VoucherDate, AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Orders'

	End
	ELSE -- Trường hợp load phiếu thu/chi để View/ Edit
	Begin
	SET @sSQL = '

	Select  VoucherTypeID,TransactionTypeID,AT9000.VoucherNo,VoucherDate,DebitAccountID,VoucherID,  
			TransactionID, BatchID,CreditAccountID, ExchangeRate, OriginalAmount,OriginalAmount As OldOriginalAmount,   
			ConvertedAmount,  InvoiceDate, DueDate,  (Case when AT9000.TransactionTypeID =''T11'' and AT9000.CurrencyIDCN<>''VND''  then AT9000.	CurrencyIDCN else   AT9000.CurrencyID end)  as CurrencyID, VATTypeID, AT9000.VATGroupID, Serial, InvoiceNo, Orders, 
			AT9000.EmployeeID,AT9000.ObjectID, AT9000.InvoiceCode, AT9000.InvoiceSign,
			(Case when  isnull(AT1202.IsUpdateName,0) <>0 then   VATObjectName else  AT1202.ObjectName end) as ObjectName, RefNo01, RefNo02,
			VDescription, BDescription,TDescription,Quantity, AT9000.InventoryID,AT9000.UnitID,Status,IsAudit,AT9000.CreateDate, 
			AT9000.CreateUserID, AT9000.LastModifyDate, AT9000.LastModifyUserID,AT9000.DivisionID, TranMonth, TranYear, SenderReceiver, SRAddress,  SRDivisionName, C.IsObject as CIsObject, D.IsObject as DIsObject, isnull(AT1202.IsUpdateName,0) as IsUpdateName,AT9000.VATObjectName, 
			AT9000.VATObjectAddress, (Case when  isnull(AT1202.IsUpdateName,0) <>0 then   AT9000.VATNo  else  AT1202.VATNo  end) as VATNo,  
			AT9000.CurrencyIDCN, AT9000.ExchangeRateCN, AT9000.OriginalAmountCN, AT9000.Ana01ID,  AT9000.Ana02ID, AT9000.Ana03ID,AT9000.Ana04ID,
			AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID,AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, AT9000.OrderID, AT9000.PeriodID,
			M01.Description as PeriodName, AT9000.ProductID,AT02.InventoryName as ProductName, AT9000.ReVoucherID,AT9000.ReTransactionID, 
			AT9000.TVoucherID, AT9000.TBatchID,
			AT9000.ContractDetailID,
			(Select AT1020.ContractNo From AT1020 WITH (NOLOCK) Inner join AT1021 WITH (NOLOCK) On AT1020.DivisionID = AT1021.DivisionID And AT1020.ContractID = AT1021.ContractID
			 Where AT1020.DivisionID = ''' + @DivisionID + ''' And AT1021.ContractDetailID = AT9000.ContractDetailID) as ContractNo
			 ,AT9000.TableID, AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03,
			AT9000.DParameter04, AT9000.DParameter05, AT9000.DParameter06, AT9000.DParameter07,
			AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10, 
			AT9000.Parameter01,AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05, 
			AT9000.Parameter06,AT9000.Parameter07, AT9000.Parameter08,AT9000.Parameter09,AT9000.Parameter10,
			ISNULL(AT9000.IsPOCost,0) AS IsPOCost,
			ISNULL(AT9000.IsFACost,0) AS IsFACost,
			WTCExchangeRate, WTCOperator, TaxBaseAmount,
			CAST(IsWithhodingTax AS BIT) AS WithhodingTax,
			AT9000.PaymentExchangeRate, AT9000.AVRExchangeRate,
			AT9000.CreditAccountID AS DCreditAccountID,
			AT9000.DebitAccountID AS DDebitAccountID,
			AT9000.WTTransID, AT9000.IsVATWithhodingTax, AT9000.VATWithhodingRate, AT9000.IsAdvancePayment,
			Isnull(AT9000.IsInheritInvoicePOS, 0) as IsInheritInvoicePOS, 
			Isnull(AT9000.IsInheritPayPOS,0) as IsInheritPayPOS, 
			Isnull(AT9000.IsInvoiceSuggest,0) as IsInvoiceSuggest, 
			Isnull(AT9000.IsDeposit,0) as IsDeposit,
			OV03.VoucherNo as ReVoucherNo
		
	--INTO #AP0072
	From  AT9000 WITH (NOLOCK)  Left Join AT1202 WITH (NOLOCK) on AT9000.ObjectID =  AT1202.ObjectID AND AT1202.DivisionID IN (''@@@'',AT9000.DivisionID) 
	LEFT Join AT1005 D WITH (NOLOCK) on D.AccountID =  AT9000.DebitAccountID
	LEFT Join AT1005 C WITH (NOLOCK) on C.AccountID =  AT9000.CreditAccountID
	Left Join MT1601 M01 WITH (NOLOCK) on M01.PeriodID = AT9000.PeriodID and M01.DivisionID = AT9000.DivisionID  
	Left Join AT1302 as AT02 WITH (NOLOCK) on AT02.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT02.InventoryID = AT9000.ProductID
	Left Join (Select DivisionID,OrderID ,VoucherNo  from OV1003 WITH (NOLOCK)) as OV03 on OV03.DivisionID IN (AT9000.DivisionID,''@@@'') AND OV03.OrderID = AT9000.OrderID

	Where  AT9000.DivisionID = ''' + @DivisionID + '''
		AND		AT9000.VoucherID = ''' + @VoucherID + '''
		Order by	AT9000.Orders
	

	--UPDATE T1
	--SET		T1.WithhodingTax = 1
	--FROM	#AP0072 T1	
	--LEFT JOIN AT9000 T2 WITH (NOLOCK) ON T1.TVoucherID = T2.TVoucherID
	--WHERE T2.DivisionID = ''' + @DivisionID + '''
	--	AND	T2.VoucherID = ''' + @VoucherID + '''
	--	AND T1.TransactionTypeID <> ''T43''
	--	AND T2.TransactionTypeID = ''T43''

	--SELECT * FROM #AP0072	
		'
	End
	--print @sSQL
	EXEC(@sSQL)
END	






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

