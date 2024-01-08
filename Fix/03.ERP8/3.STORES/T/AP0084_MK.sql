IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0084_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0084_MK]
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
---- Modified on 24/11/2016 by Phương Thảo: Bổ sung số chứng từ kế thừa
---- Modified on 18/08/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Kiều Nga on 22/12/2020: Fix lỗi vượt quá kí tự NVARCHAR(MAX)
---- Modified by Văn Tài  on 28/01/2021: Bổ sung load InheritTableID.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

--- Example: EXEC AP0084 'sth',1,2013,'((''''))','( (0=0) )','((''''))','( (0=0) )','((''''))','( (0=0) )', ''

CREATE PROCEDURE [dbo].[AP0084_MK] @DivisionID nvarchar(50),				
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
		@sSQL1 as NVARCHAR(MAX),
		@IsTC AS Tinyint -- thu/chi: 0(thu), 1(chi)

SELECT	Top 1 @IsTC = CASE WHEN TransactionTypeID = 'T21' THEN 0 ELSE 1 END
FROM	AT9000
WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID

IF ISNULL(@VoucherID, '') = ''--Load Truy vấn - AF0085
BEGIN		
	SET @sSQL = '
				SELECT 	
				VoucherTypeID, TransactionTypeID,
				VoucherNo, 
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
				(Case when  isnull(AT1202.IsUpdateName,0) <>0 then   VATObjectName else  AT1202.ObjectName end) AS ObjectName,
				RefNo01, RefNo02, 
				BDescription,TDescription,
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
			Isnull(AT9000.IsDeposit,0) as IsDeposit,AT9000.ReVoucherID

	From		AT9000  WITH (NOLOCK)	
	LEFT JOIN	AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID =  AT1202.ObjectID 

	Where		AT9000.DivisionID = ''' + @DivisionID + '''
		AND		AT9000.TranMonth = ' + convert(nvarchar(2),@TranMonth) + ' AND AT9000.TranYear = ' + convert(nvarchar(4),@TranYear) + '
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
				VoucherNo, ---Convert(Date, VoucherDate) As VoucherDate,  
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
				(Case when  isnull(AT1202.IsUpdateName,0) <>0 then   VATObjectName else  AT1202.ObjectName end) AS ObjectName,
				RefNo01, RefNo02, 
				BDescription,TDescription,
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
				AT9000.IsFACost, AT9000.WTTransID,
				Convert(NVarchar(50),'''') AS ReVoucherNo,
				Convert(Decimal(28,8),0) AS EndOriginalAmount, AT9000.DueDate, AT9000.IsVATWithhodingTax, AT9000.VATWithhodingRate, AT9000.IsAdvancePayment	,
			Isnull(AT9000.IsInheritInvoicePOS, 0) as IsInheritInvoicePOS, 
			Isnull(AT9000.IsInheritPayPOS,0) as IsInheritPayPOS, 
			Isnull(AT9000.IsInvoiceSuggest,0) as IsInvoiceSuggest, 
			Isnull(AT9000.IsDeposit,0) as IsDeposit
			, AT9000.ReVoucherID
			, AT9000.InheritTableID
	INTO #AP0084
	From		AT9000  WITH (NOLOCK)	
	LEFT JOIN	AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID =  AT1202.ObjectID
	LEFT JOIN  AT1005 C WITH (NOLOCK) on C.AccountID =  AT9000.CreditAccountID AND C.DivisionID = AT9000.DivisionID
	LEFT JOIN  AT1005 D  WITH (NOLOCK) on D.AccountID =  AT9000.DebitAccountID AND D.DivisionID = AT9000.DivisionID
	LEFT JOIN	MT1601 M01 WITH (NOLOCK) on M01.PeriodID = AT9000.PeriodID AND M01.DivisionID = AT9000.DivisionID
	LEFT JOIN	AT1302 AS AT02  WITH (NOLOCK) on  AT02.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT02.InventoryID = AT9000.ProductID

	Where		AT9000.DivisionID = ''' + @DivisionID + '''
		AND		AT9000.VoucherID = ''' + @VoucherID + '''

	Order by	AT9000.Orders


'

	IF(@IsTC = 0)
	BEGIN
	SET @sSQL1 = '
		UPDATE T1
		SET		T1.ReVoucherNo = T2.VoucherNo
		FROM	#AP0084 T1	
		LEFT JOIN AT9000 T2 WITH (NOLOCK) ON T1.TVoucherID = T2.VoucherID
		WHERE T1.DivisionID = ''' + @DivisionID + '''
		AND	T1.VoucherID = ''' + @VoucherID + '''

		UPDATE	T1
		SET		T1.EndOriginalAmount = ISNULL(AT9000.OriginalAmountCN,0) - ISNULL(T2.OriginalAmountOffset,0)
		FROM	#AP0084 T1
		LEFT JOIN
		(
		SELECT DivisionID, VoucherID, BatchID, DebitAccountID, CurrencyID, SUM(OriginalAmountCN) AS OriginalAmountCN
		FROM AT9000 WITH(NOLOCK)
		GROUP BY DivisionID, VoucherID, BatchID, DebitAccountID, CurrencyID
		) AT9000 ON T1.DivisionID = AT9000.DivisionID AND T1.TVoucherID = AT9000.VoucherID AND T1.TBatchID = AT9000.BatchID AND T1.DivisionID = AT9000.DivisionID
					AND T1.CreditAccountID = AT9000.DebitAccountID AND T1.CurrencyID = AT9000.CurrencyID
		LEFT JOIN 
		(
		Select	AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID,
				sum(OriginalAmount) As OriginalAmountOffset, 
				sum(ConvertedAmount) As ConvertedAmountOffset
		From AT0303	with(nolock)	
		WHERE Isnull(CreditVoucherID,'''') <> '''+@VoucherID+''' 
		Group by AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID
		) T2 ON T1.TVoucherID = T2.DebitVoucherID AND T1.TBatchID = T2.DebitBatchID AND T1.DivisionID = T2.DivisionID

	'
	END
	ELSE
	BEGIN
	SET @sSQL1 = '

			UPDATE T1
		SET		T1.ReVoucherNo = T2.VoucherNo
		FROM	#AP0084 T1	
		LEFT JOIN AT9000 T2 WITH (NOLOCK) ON T1.TVoucherID = T2.VoucherID
		WHERE T1.DivisionID = ''' + @DivisionID + '''
		AND	T1.VoucherID = ''' + @VoucherID + '''

		UPDATE	T1
		SET		T1.EndOriginalAmount = ISNULL(AT9000.OriginalAmountCN,0) - ISNULL(T2.OriginalAmountOffset,0)
		FROM	#AP0084 T1
		LEFT JOIN
		(
		SELECT DivisionID, VoucherID, BatchID, CreditAccountID, CurrencyID, SUM(OriginalAmountCN) AS OriginalAmountCN
		FROM AT9000 WITH(NOLOCK) 
		GROUP BY DivisionID, VoucherID, BatchID, CreditAccountID, CurrencyID
		) AT9000 ON T1.DivisionID = AT9000.DivisionID AND T1.TVoucherID = AT9000.VoucherID AND T1.TBatchID = AT9000.BatchID AND T1.DivisionID = AT9000.DivisionID
					AND T1.DebitAccountID = AT9000.CreditAccountID AND T1.CurrencyID = AT9000.CurrencyID
		LEFT JOIN 
		(
		Select	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
				sum(OriginalAmount) As OriginalAmountOffset, 
				sum(ConvertedAmount) As ConvertedAmountOffset
		From AT0404	with(nolock)	
		WHERE Isnull(DebitVoucherID,'''') <> '''+@VoucherID+''' 
		Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
		) T2 ON T1.TVoucherID = T2.CreditVoucherID AND T1.TBatchID = T2.CreditBatchID AND T1.DivisionID = T2.DivisionID
	'
	END
	SET @sSQL1 = @sSQL1 +'
	SELECT * FROM #AP0084'

	--UPDATE T1
	--SET		T1.WithhodingTax = 1
	--FROM	#AP0084 T1	
	--LEFT JOIN AT9000 T2 WITH (NOLOCK) ON T1.TVoucherID = T2.TVoucherID
	--WHERE T2.DivisionID = ''' + @DivisionID + '''
	--	AND	T2.VoucherID = ''' + @VoucherID + '''
	--	AND T1.TransactionTypeID <>''T43''
	--	AND T2.TransactionTypeID = ''T43''


END

--print @sSQL
--print @sSQL1
EXEC(@sSQL+@sSQL1)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

