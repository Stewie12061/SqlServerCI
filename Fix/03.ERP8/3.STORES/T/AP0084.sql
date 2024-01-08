IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0084]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0084]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--- Created by: Bao Anh, date: 27/05/2013
--- Purpose: Tra ra danh sach phieu thu, chi, chuyen khoan qua ngan hang
--- Edit by: Thiên Huỳnh, date: 30/05/2013: Bổ sung @VoucherID: Load Xem, Sửa
--- Modify on 03/11/2013 by Bảo Anh: Bổ sung trường ContractDetailID, ContractNo (kế thừa hợp đồng)
--- Modify on 10/06/2014 by Tan Phu: Thay doi ham check from date va todate
---- Modified on 06/03/2015 by Lê Thị Hạnh: Bổ sung IsPOCost chi phí mua hàng
---- Modified on 07/12/2015 by Phương Thảo: Bổ sung WithhodingTax - Khai thuế nhà thầu
---- Modified on 10/01/2016 by Phương Thảo: Bổ sung 2 tỷ giá thanh toán và BQ di động
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 17/03/2017: Bổ sung trường DueDate (Ngày đáo hạn)
---- Modified by Bảo Thy on 11/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 12/06/2017: Bổ sung trường IsVATWithhodingTax, VATWithhodingRate khi load edit		
---- Modified by Hải Long on 12/06/2017: Bổ sung trường IsAdvancePayment - Là phiếu thu tạm ứng (Bê Tông Long An)	
---- Modified by Hoàng Vũ on 16/03/2018: Bổ sung trường IsInheritInvoicePOS, IsInheritPayPOS, IsInvoiceSuggest, IsDeposit - Là phiếu thu / thu qua ngân hàng (OKIA)	
---- Modified by Huỳnh Thử on 18/08/2020: Merge Code: MEKIO và MTE -- Tách Store
---- Modified by Kim Thư on 25/02/2019: Sửa cách lấy ObjectName cho khách vãng lai là ISNULL(AT9000.VATObjectName,AT1202.ObjectName), khách không vãng lai thì lấy AT1202.ObjectName.
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông   on 30/11/2020: Lấy status của phiếu gốc thay vì phiếu chi
---- Modified by Đức Thông   on 08/12/2020: Load thêm retransactionid của phiếu để lưu vết phiếu gốc
---- Modified by Huỳnh Thử   on 29/01/2021: Lấy status của phiếu chi thay vì phiếu gốc
---- Modified by Kiều Nga   on 02/04/2021: Lấy thêm trường ReVoucherNo (CBD)
---- Modified by Nhựt Trường on 08/12/2021: [2021/12/IS/0024] - Bỏ bớt code đã được comment.
---- Modified by Nhựt Trường on 15/02/2022: Bổ sung kiều kiện DivisionID khi JOIN bảng AT1202.
---- Modified by Xuân Nguyên on 17/05/2022: [2022/05/IS/0090]Sửa cách lấy ObjectName 
---- Modified by Xuân Nguyên on 27/07/2022: [2022/07/IS/0154]Sửa điều kiện DivisionID khi join bảng AT1202
---- Modified by Nhật Thanh on 05/09/2022: Tách SQL vì quá dài
---- Modified by Thành Sang on 08/02/2023: Bỏ qua điều kiện lọc theo Kỳ khi truy vấn
--- Example: EXEC AP0084 'HT',1,2013,'((''''))','( (0=0) )','((''''))','( (0=0) )','((''''))','( (0=0) )', ''

CREATE PROCEDURE [dbo].[AP0084] @DivisionID nvarchar(50),				
								@TranMonth int,
								@TranYear int,
								@FromDate datetime,
								@ToDate datetime,
								@ConditionVT nvarchar(1000),
								@IsUsedConditionVT nvarchar(1000),
								@ConditionAC nvarchar(1000),
								@IsUsedConditionAC nvarchar(1000),
								@ConditionOB nvarchar(1000),
								@IsUsedConditionOB nvarchar(1000),
								@ObjectID nvarchar (50),
								@VoucherID  nvarchar(50)			
AS
Declare @sSQL as varchar(max),
		@sSQL1 as varchar(max)
		,@CustomerName INT 
SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex
IF(@CustomerName = 50 OR @CustomerName = 115) -- Mekio or Mte
BEGIN
	EXEC AP0084_MK @DivisionID ,				
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
	IF ISNULL(@VoucherID, '') = ''--Load Truy vấn - AF0085
	BEGIN		
	SET @sSQL = '
				SELECT 	
				VoucherTypeID, TransactionTypeID,
				AT9000.VoucherNo, 
				VoucherDate,  
				DebitAccountID, VoucherID,	TransactionID,
				CreditAccountID,      ExchangeRate,          OriginalAmount ,
				ConvertedAmount,  InvoiceDate,	
				AT9000.CurrencyID  AS CurrencyID,
				AT9000.VATTypeID,    AT9000.VATGroupID,           
				Serial,      InvoiceNo,    Orders,
				DebitBankAccountID,
				CreditbankAccountID,
				AT9000.ObjectID, 
				(Case when  isnull(AT1202.IsUpdateName,0) <>0 then   ISNULL(AT9000.VATObjectName,AT1202.ObjectName) else  AT1202.ObjectName end) AS ObjectName,
				RefNo01, RefNo02, 
				BDescription,TDescription,
				--(SELECT TOP 1 Status FROM AT9000 A1 WHERE AT9000.TVoucherID = A1.VoucherID and AT9000.TVoucherID = A1.VoucherID) as Status,
				Status,
				AT9000.CreateUserID,
				AT9000.DivisionID, TranMonth, TranYear,
				AT9000.CurrencyIDCN,
				AT9000.Ana01ID,
				AT9000.Ana02ID,
				AT9000.Ana03ID,
				AT9000.Ana04ID,
				AT9000.Ana05ID,
				AT9000.Ana06ID,
				AT9000.Ana07ID,
				AT9000.Ana08ID,
				AT9000.Ana09ID,
				AT9000.Ana10ID,
				AT9000.InvoiceCode,
				AT9000.InvoiceSign,
				AT9000.TableID,
				AT9000.PaymentExchangeRate, AT9000.AVRExchangeRate, ISNULL(AT9000.IsAdvancePayment, 0) AS IsAdvancePayment,
				Isnull(AT9000.IsInheritInvoicePOS, 0) as IsInheritInvoicePOS, 
				Isnull(AT9000.IsInheritPayPOS,0) as IsInheritPayPOS, 
				Isnull(AT9000.IsInvoiceSuggest,0) as IsInvoiceSuggest, 
				Isnull(AT9000.IsDeposit,0) as IsDeposit,
				OV03.VoucherNo as ReVoucherNo
'
set @sSQL1='
	From		AT9000  WITH (NOLOCK)	
	LEFT JOIN	AT1202 WITH (NOLOCK) on AT1202.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT9000.ObjectID =  AT1202.ObjectID
	Left Join (Select DivisionID,OrderID ,VoucherNo  from OV1003 WITH (NOLOCK)) as OV03 on OV03.DivisionID IN (AT9000.DivisionID,''@@@'') AND OV03.OrderID = AT9000.OrderID

	Where		AT9000.DivisionID = ''' + @DivisionID + '''
		--AND		AT9000.TranMonth = ' + convert(nvarchar(2),@TranMonth) + ' AND AT9000.TranYear = ' + convert(nvarchar(4),@TranYear) + '
		AND		AT9000.TransactionTypeID in (''T21'',''T22'',''T16'')	
		AND		(Isnull(AT9000.VoucherTypeID,''#'')  in ' + @ConditionVT + ' OR ' + @IsUsedConditionVT + ')
		AND		(Isnull(AT9000.DebitAccountID,''#'')  in ' + @ConditionAC + ' OR ' + @IsUsedConditionAC + ')
		AND		(Isnull(AT9000.CreditAccountID,''#'')  in ' + @ConditionAC + ' OR ' + @IsUsedConditionAC + ')
		AND		(Isnull(AT9000.ObjectID,''#'')  in ' + @ConditionOB + ' OR ' + @IsUsedConditionOB + ')
		---And Convert(Date, AT9000.VoucherDate) Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+'''
		And  Convert(nvarchar(10),AT9000.VoucherDate,21)   Between '''+ Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+'''  
		AND isnull(AT9000.ObjectID,''%'') like ('''+@ObjectID+''')

	Order by	AT9000.VoucherDate, AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Orders'
	END
	ELSE -- Load Xem, Sửa - AF0102, AF0103
	BEGIN
	SET @sSQL = '
				SELECT 	
				VoucherTypeID, TransactionTypeID,
				AT9000.VoucherNo, ---Convert(Date, VoucherDate) As VoucherDate,  
				VoucherDate,
				DebitAccountID, VoucherID,	TransactionID,
				CreditAccountID,      ExchangeRate,          OriginalAmount ,
				ConvertedAmount,  InvoiceDate,	
				AT9000.CurrencyID  AS CurrencyID,
				AT9000.VATTypeID,    AT9000.VATGroupID,           
				Serial,      InvoiceNo,    Orders,
				DebitBankAccountID,
				CreditbankAccountID,
				AT9000.ObjectID, 
				(Case when  isnull(AT1202.IsUpdateName,0) <>0 then  ISNULL(AT9000.VATObjectName,AT1202.ObjectName) else  AT1202.ObjectName end) AS ObjectName,
				RefNo01, RefNo02, 
				BDescription,TDescription,
				--(SELECT TOP 1 Status FROM AT9000 A1 WHERE AT9000.TVoucherID = A1.VoucherID and AT9000.TVoucherID = A1.VoucherID) as Status,
				Status,
				AT9000.CreateUserID,
				AT9000.DivisionID, TranMonth, TranYear,
				AT9000.CurrencyIDCN,
				AT9000.Ana01ID,
				AT9000.Ana02ID,
				AT9000.Ana03ID,
				AT9000.Ana04ID,
				AT9000.Ana05ID,
				AT9000.Ana06ID,
				AT9000.Ana07ID,
				AT9000.Ana08ID,
				AT9000.Ana09ID,
				AT9000.Ana10ID,
				AT9000.InvoiceCode,
				AT9000.InvoiceSign,
				--Cac column lay them cho truong hop Xem, Sua
				AT9000.OrderID,
				AT9000.EmployeeID,
				AT9000.VDescription,
				AT9000.SRAddress,
				AT9000.SRDivisionName,
				AT9000.SenderReceiver,
				C.IsObject AS CIsObject,
				D.IsObject AS DIsObject,
				ISNULL(AT1202.IsUpdateName,0) AS IsUpdateName,
				(Case when  isnull(AT1202.IsUpdateName,0) <>0 then   AT9000.VATNo  else  AT1202.VATNo  end) AS VATNo,
				AT9000.VATObjectName,
				AT9000.VATObjectAddress,
				AT9000.TVoucherID,
				AT9000.TBatchID,
				AT9000.BatchID,
				AT9000.ReTransactionID,
				AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05,
				AT9000.Parameter06, AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10,
				AT9000.PeriodID, M01.Description AS PeriodName,
				AT9000.ProductID, AT02.InventoryName AS ProductName,
				AT9000.ContractDetailID,
				(Select AT1020.ContractNo From AT1020 WITH (NOLOCK) Inner join AT1021 WITH (NOLOCK) On AT1020.DivisionID = AT1021.DivisionID And AT1020.ContractID = AT1021.ContractID
				 Where AT1020.DivisionID = ''' + @DivisionID + ''' And AT1021.ContractDetailID = AT9000.ContractDetailID) as ContractNo
				 ,AT9000.TableID
				 , ISNULL(AT9000.IsPOCost,0) AS IsPOCost,
				 WTCExchangeRate, WTCOperator, TaxBaseAmount,
				CAST(IsWithhodingTax AS BIT) AS WithhodingTax,
				AT9000.PaymentExchangeRate, AT9000.AVRExchangeRate,
				AT9000.CreditAccountID AS DCreditAccountID,
				AT9000.DebitAccountID AS DDebitAccountID,
				AT9000.IsFACost, AT9000.WTTransID, AT9000.DueDate, AT9000.IsVATWithhodingTax, AT9000.VATWithhodingRate, AT9000.IsAdvancePayment	,
				Isnull(AT9000.IsInheritInvoicePOS, 0) as IsInheritInvoicePOS, 
				Isnull(AT9000.IsInheritPayPOS,0) as IsInheritPayPOS, 
				Isnull(AT9000.IsInvoiceSuggest,0) as IsInvoiceSuggest, 
				Isnull(AT9000.IsDeposit,0) as IsDeposit,
				OV03.VoucherNo as ReVoucherNo
'
set @sSQL1='
	--INTO #AP0084
	From		AT9000  WITH (NOLOCK)	
	LEFT JOIN	AT1202 WITH (NOLOCK) on AT1202.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT9000.ObjectID =  AT1202.ObjectID
	LEFT JOIN  AT1005 C WITH (NOLOCK) on C.AccountID =  AT9000.CreditAccountID
	LEFT JOIN  AT1005 D  WITH (NOLOCK) on D.AccountID =  AT9000.DebitAccountID
	LEFT JOIN	MT1601 M01 WITH (NOLOCK) on M01.PeriodID = AT9000.PeriodID AND M01.DivisionID = AT9000.DivisionID
	LEFT JOIN	AT1302 AS AT02  WITH (NOLOCK) on  AT02.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT02.InventoryID = AT9000.ProductID
	Left Join (Select DivisionID,OrderID ,VoucherNo  from OV1003 WITH (NOLOCK)) as OV03 on OV03.DivisionID IN (AT9000.DivisionID,''@@@'') AND OV03.OrderID = AT9000.OrderID

	Where		AT9000.DivisionID = ''' + @DivisionID + '''
		AND		AT9000.VoucherID = ''' + @VoucherID + '''

	Order by	AT9000.Orders
	'
	END

	Print @sSQL
	Print @sSQL1
	EXEC(@sSQL+@sSQL1)
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO