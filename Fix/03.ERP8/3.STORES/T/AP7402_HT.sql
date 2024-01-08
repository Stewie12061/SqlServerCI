IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7402_HT]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7402_HT]
GO
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

---------- Xu ly tong hop No phai thu
----------- Created BY Nguyen Van Nhan, Date 22.08.2003
---- Last Edit: Nguyen Thi Thuy Tuyen, date 07/07/2007
---- Modified on 28/12/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 25/01/2016 by Thị Phượng :thay đối tượng sang mã phân tích đối tượng (Customize Hoàng trần)
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- EXEC AP7402_HT @DivisionID=N'AS',@CurrencyID=N'VND',@FromAccountID=N'1311',@ToAccountID=N'1311',@FromObjectID='%',@ToObjectID='%', @FromO05ID=N'NHOM01',@ToO05ID=N'NHOM02'
CREATE PROCEDURE [dbo].[AP7402_HT] 
    @DivisionID AS VARCHAR(50), 
    @CurrencyID AS VARCHAR(50), 
    @FromAccountID AS VARCHAR(50), 
    @ToAccountID AS VARCHAR(50),
	@FromObjectID AS NVARCHAR(50), 
    @ToObjectID AS NVARCHAR(50), 
    @FromO05ID AS VARCHAR(50), 
    @ToO05ID AS VARCHAR(50)
AS

DECLARE @sql AS NVARCHAR(4000)
	
	
-------------------- Phat sinh No.

SET @sql = '
    SELECT TransactionID, 
        BatchID, VoucherID, TableID, D3.DivisionID, TranMonth, TranYear, 
        ''00'' AS RPTransactionType, 
        TransactionTypeID, D3.ObjectID,AT02.ObjectName,
		 AT02.O05ID,  
        DebitAccountID, CreditAccountID, 
        DebitAccountID AS AccountID, 
        VoucherNo, VoucherTypeID, VoucherDate, 
        InvoiceNo, 
        ISNULL(InvoiceDate, VoucherDate) AS InvoiceDate, 
        Serial, 
        VDescription, BDescription, TDescription, 
        CurrencyIDCN AS CurrencyID, ExchangeRate, OriginalAmountCN AS OriginalAmount, ConvertedAmount, 
        OriginalAmountCN AS SignOriginalAmount, ConvertedAmount AS SignConvertedAmount, 
        Status
    FROM AT9000 D3  WITH (NOLOCK)
	INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = D3.DebitAccountID
	INNER JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID = D3.ObjectID
	Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
    WHERE AT1005.GroupID = ''G03'' 
        AND D3.DivisionID like ''' + @DivisionID + ''' 
        AND (AT02.O05ID BETWEEN ''' + @FromO05ID + ''' AND ''' + @ToO05ID + ''') 
		AND (D3.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
        AND (Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE ''' + @CurrencyID + '''
'

IF @FromAccountID <> '%' 
    SET @SQL = @SQL + ' AND D3.DebitAccountID > = ''' + @FromAccountID + ''' AND D3.DebitAccountID< = ''' + @ToAccountID + ''' '
ELSE
    SET @SQL = @SQL + ' AND D3.DebitAccountID LIKE ''%'' '

------------------------------- Phat sinh Co

SET @sql = @sql + 'UNION ALL 
SELECT TransactionID, BatchID, VoucherID, TableID, D3.DivisionID, TranMonth, TranYear, 
''01'' AS RPTransactionType, TransactionTypeID, D3.ObjectID, AT02.ObjectName,
CASE WHEN TransactionTypeID = ''T99'' THEN CreditObjectID ELSE AT02.O05ID END AS O05ID, 
DebitAccountID, CreditAccountID, 
CreditAccountID AS AccountID, 
VoucherNo, VoucherTypeID, VoucherDate, 
InvoiceNo, 
ISNULL(InvoiceDate, VoucherDate) AS InvoiceDate, 
Serial, 
VDescription, BDescription, TDescription, 
CurrencyIDCN AS CurrencyID, ExchangeRate, OriginalAmountCN AS OriginalAmount, ConvertedAmount, 
OriginalAmountCN *(-1) AS SignOriginalAmount, ConvertedAmount *(-1) AS SignConvertedAmount, 
Status 

FROM AT9000 D3 WITH (NOLOCK) INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = D3.CreditAccountID
INNER JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID = D3.ObjectID
Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
WHERE AT1005.GroupID = ''G03'' AND
D3.DivisionID like ''' + @DivisionID + '''  AND 
(CASE WHEN TransactionTypeID = ''T99'' THEN D3.CreditObjectID ELSE AT02.O05ID END BETWEEN N''' + @FromO05ID + ''' AND N''' + @ToO05ID + ''') AND 
(CASE WHEN TransactionTypeID = ''T99'' THEN D3.CreditObjectID ELSE D3.ObjectID END BETWEEN N''' + @FromObjectID + ''' AND N''' + @ToObjectID + ''')AND
(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE ''' + @CurrencyID + ''' '

IF @FromAccountID <> '%' 
SET @SQL = @SQL + ' AND D3.CreditAccountID > = ''' + @FromAccountID + ''' AND D3.CreditAccountID< = ''' + @ToAccountID + ''' '
ELSE
SET @SQL = @SQL + ' AND ISNULL(D3.CreditAccountID, '''') LIKE ''%'' '

IF NOT EXISTS(SELECT name FROM sysobjects WITH (NOLOCK) WHERE id = Object_id(N'[dbo].[AV7402_HT]') AND OBJECTPROPERTY(id, N'IsView') = 1)
EXEC(' CREATE VIEW AV7402_HT --AP7402 
AS ' + @SQL)
ELSE
EXEC(' ALTER VIEW AV7402_HT --AP7402
 AS ' + @SQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

