IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0268]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0268]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Bảo Thy on 29/06/2017
---- Purpose: Load thông tin chi tiết từ màn hình kế thừa tạm chi/tạm chi ngân hàng qua màn hình cập nhật phiếu chi/ phiếu chi ngân hàng
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example> AP0268 'CAG','T02','AVe9b4947a-b3fc-43de-9a16-7283ef2176e1'
 
CREATE PROCEDURE AP0268
( 
		@DivisionID AS VARCHAR(20),
	    @TransactionTypeID as nvarchar(50),
	    @VoucherID nvarchar(50) ---voucherID của phiếu tạm chi được chọn để kế thừa
) 
AS 

DECLARE @sSQL AS VARCHAR(MAX) = '',
		@sSQL1 AS VARCHAR(MAX) = '',
		@sWhere AS VARCHAR(MAX)	= '',
		@BatchID AS VARCHAR(50),
		@CreditAccountID AS VARCHAR(50)

SELECT TOP 1 @BatchID = BatchID, @CreditAccountID = CreditAccountID
FROM AT9010
WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

IF EXISTS(SELECT TOP 1 1 FROM AT9010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND ISNULL(InheritTypeID,'') = 'HDMH')
BEGIN
	
	SET @sSQL = '
	SELECT 
	Convert(TinyInt, 0) As Choose,
	'''+@VoucherID+''' AS VoucherID, '''+@BatchID+''' AS BatchID, 
	T90.DivisionID, T90.VoucherTypeID, T90.VoucherID AS TVoucherID, T90.BatchID AS TBatchID, 
	T90.VoucherDate, T90.VoucherNo, T90.Serial, T90.InvoiceNo, T90.InvoiceDate, 
	T90.VDescription, T90.BDescription, T90.ObjectID, T90.ObjectName, T90.VATNo, T90.IsUpdateName,
	T90.CurrencyID, T90.ExchangeRate, '''+@CreditAccountID+''' AS CreditAccountID,
	T90.CreditAccountID as DebitAccountID,
	T90.Ana01ID, T90.Ana02ID, T90.Ana03ID, T90.Ana04ID, T90.Ana05ID,
	T90.Ana06ID, T90.Ana07ID, T90.Ana08ID, T90.Ana09ID, T90.Ana10ID,
	T90.OriginalAmount, T90.ConvertedAmount,
	(T90.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) AS EndOriginalAmount,
	(T90.ConvertedAmount - ISNULL(K.ConvertedAmountOffset,0)) AS EndConvertedAmount,
	T90.InvoiceCode, T90.InvoiceSign, T90.IsWithhodingTax
	FROM'

	SET @sSQL1 = '
	(
		Select 
		AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
		isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
		isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
		AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
		AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
		AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
		max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
		max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
		AT9000.InvoiceCode, AT9000.InvoiceSign, Isnull(AT9000.IsWithhodingTax,0) AS IsWithhodingTax
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		WHERE AT9000.TransactionTypeID in (''T03'',''T13'')
		AND	EXISTS (SELECT TOP 1 1 FROM AT1005 WHERE AT1005.GroupID = ''G04'' AND AT1005.IsObject = 1 AND AT9000.CreditAccountID = AT1005.AccountID)
		AND AT9000.VoucherID = (SELECT TOP 1 InheritVoucherID FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+@VoucherID+''')
		GROUP BY AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
		AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
		AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
		AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign,AT9000.IsWithhodingTax
	) T90

	LEFT JOIN
	(
		SELECT	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
				SUM(OriginalAmount) As OriginalAmountOffset, SUM(ConvertedAmount) As ConvertedAmountOffset
		FROM AT0404 WITH (NOLOCK)	
		Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
	)K ON T90.DivisionID = K.DivisionID and T90.VoucherID = K.CreditVoucherID
		  AND T90.BatchID = K.CreditBatchID AND T90.CreditAccountID = K.AccountID 
		  AND T90.TableID = K.CreditTableID  AND T90.CurrencyID = K.CurrencyID
	WHERE (T90.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0 
	ORDER BY T90.VoucherID, T90.VoucherDate, T90.InvoiceNo
	'

END
ELSE
BEGIN
	SET @sSQL = '	
	
	SELECT	CONVERT(tinyint, 0) AS Choose, T90.VoucherID, T90.BatchID, 
			'''' AS TVoucherID, '''' AS TBatchID, Orders, VoucherNo, VoucherDate, DueDate,
			T90.ObjectID, (Case when  isnull(AT1202.IsUpdateName,0) <> 0 then VATObjectName else AT1202.ObjectName end) as ObjectName,
			isnull(AT1202.IsUpdateName,0) as IsUpdateName, VoucherTypeID, T90.EmployeeID, AT1103.FullName as EmployeeName,
			SenderReceiver, SRDivisionName, SRAddress, RefNo01, RefNo02, CreditBankAccountID, DebitBankAccountID,
			AT1016.BankName as CreditBankAccountName, AT1016.BankAccountNo, AT1016.AccountID,
			T90.CurrencyID, ExchangeRate, VDescription, Serial, InvoiceNo, InvoiceDate, DebitAccountID, CreditAccountID,
			OriginalAmount, ConvertedAmount, T90.VATObjectID, VATObjectName, VATObjectAddress,
			(Case when  isnull(AT1202.IsUpdateName,0) <> 0 then T90.VATNo else AT1202.VATNo  end) as VATNo, VATTypeID, T90.VATGroupID,
			BDescription,TDescription, T90.OrderID, T90.PeriodID, M01.Description as PeriodName, OTransactionID, ProductID, AT1302.InventoryName as ProductName,
			Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
			
	FROM		AT9010 T90 WITH (NOLOCK)
	LEFT JOIN	AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T90.ObjectID = AT1202.ObjectID
	LEFT JOIN	AT1103 WITH (NOLOCK) on T90.EmployeeID = AT1103.EmployeeID
	LEFT JOIN	AT1016 WITH (NOLOCK) on T90.CreditBankAccountID = AT1016.BankAccountID
	LEFT JOIN	AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (T90.DivisionID,''@@@'') AND T90.ProductID = AT1302.InventoryID
	LEFT JOIN	MT1601 M01 WITH (NOLOCK) on M01.PeriodID = T90.PeriodID and M01.DivisionID = T90.DivisionID 
	
	WHERE		T90.DivisionID = ''' + @DivisionID + '''
				AND T90.VoucherID = ''' + @VoucherID + '''
				AND Isnull(T90.ReVoucherID,'''') = ''''
	ORDER BY T90.VoucherID, T90.VoucherDate, T90.Orders
				'

END
 		
--print @sSQL		
--print @sSQL1

EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

