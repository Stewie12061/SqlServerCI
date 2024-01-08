IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7402_KYO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7402_KYO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---------- Xu ly tong hop No phai thu
----------- Created BY Nguyen Van Nhan, Date 22.08.2003
---- Last Edit: Nguyen Thi Thuy Tuyen, date 07/07/2007
---- Modified on 28/12/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 23/02/2016 by Hoàng vũ : Lấy dữ liệu cho những phiếu khi lưu loai tiền bị null (Sửa tạm thời cho khách hàng Tiên Tiến) sẽ update vào bảng chuẩn.
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 24/05/2017: Sửa danh mục dùng chung
----
-- <Example>
---- EXEC [AP7402_KYO] @DivisionID=N'HT',@CurrencyID=N'VND',@FromAccountID=N'1311',@ToAccountID=N'1311',@FromObjectID=N'243355677',@ToObjectID=N'SZ.0001',@StrDivisionID=''
CREATE PROCEDURE [dbo].[AP7402_KYO] 
    @DivisionID AS NVARCHAR(50), 
    @CurrencyID AS NVARCHAR(50), 
    @FromAccountID AS NVARCHAR(50), 
    @ToAccountID AS NVARCHAR(50), 
    @FromObjectID AS NVARCHAR(50), 
    @ToObjectID AS NVARCHAR(50),
    @StrDivisionID AS NVARCHAR(4000) = ''
AS

DECLARE @sql AS NVARCHAR(4000),
		@StrDivisionID_New AS NVARCHAR(4000)
SET @StrDivisionID_New = ''		

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = CASE WHEN @DivisionID = '%' THEN ' LIKE ''' + 
	@DivisionID + '''' ELSE ' IN (''' + replace(@DivisionID, ',',''',''')+ ''')' END
	
	
-------------------- Phat sinh No.

SET @sql = '
    SELECT TransactionID, 
        BatchID, VoucherID, TableID, D3.DivisionID, TranMonth, TranYear, 
        ''00'' AS RPTransactionType, 
        TransactionTypeID, 
        ObjectID, 
        DebitAccountID, CreditAccountID, 
        DebitAccountID AS AccountID, 
        VoucherNo, VoucherTypeID, VoucherDate, 
        InvoiceNo, 
        ISNULL(InvoiceDate, VoucherDate) AS InvoiceDate, 
        Serial, 
        VDescription, BDescription, TDescription, 
        (Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) AS CurrencyID, ExchangeRate, OriginalAmountCN AS OriginalAmount, ConvertedAmount, 
        OriginalAmountCN AS SignOriginalAmount, ConvertedAmount AS SignConvertedAmount, 
        Status, Isnull(D3.Ana05ID,'''') as Ana05ID
    FROM AT9000 D3 WITH (NOLOCK) INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = D3.DebitAccountID
				   Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
    WHERE AT1005.GroupID = ''G03'' 
        AND D3.DivisionID ' + @StrDivisionID_New + ' 
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
''01'' AS RPTransactionType, TransactionTypeID, 
CASE WHEN TransactionTypeID = ''T99'' THEN CreditObjectID ELSE ObjectID END AS ObjectID, 
DebitAccountID, CreditAccountID, 
CreditAccountID AS AccountID, 
VoucherNo, VoucherTypeID, VoucherDate, 
InvoiceNo, 
ISNULL(InvoiceDate, VoucherDate) AS InvoiceDate, 
Serial, 
VDescription, BDescription, TDescription, 
(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) AS CurrencyID, ExchangeRate, OriginalAmountCN AS OriginalAmount, ConvertedAmount, 
OriginalAmountCN *(-1) AS SignOriginalAmount, ConvertedAmount *(-1) AS SignConvertedAmount, 
Status , Isnull(D3.Ana05ID,'''') as Ana05ID

FROM AT9000 D3 WITH (NOLOCK) INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = D3.CreditAccountID
			   Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
WHERE AT1005.GroupID = ''G03'' AND
D3.DivisionID ' + @StrDivisionID_New + '  AND 
(CASE WHEN TransactionTypeID = ''T99'' THEN D3.CreditObjectID ELSE D3.ObjectID END BETWEEN N''' + @FromObjectID + ''' AND N''' + @ToObjectID + ''') AND 
(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE ''' + @CurrencyID + ''' '

IF @FromAccountID <> '%' 
SET @SQL = @SQL + ' AND D3.CreditAccountID > = ''' + @FromAccountID + ''' AND D3.CreditAccountID< = ''' + @ToAccountID + ''' '
ELSE
SET @SQL = @SQL + ' AND ISNULL(D3.CreditAccountID, '''') LIKE ''%'' '


IF NOT EXISTS(SELECT name FROM sysobjects WITH (NOLOCK) WHERE id = Object_id(N'[dbo].[AV7402]') AND OBJECTPROPERTY(id, N'IsView') = 1)
EXEC(' CREATE VIEW AV7402 --AP7402 
AS ' + @SQL)
ELSE
EXEC(' ALTER VIEW AV7402 --AP7402
 AS ' + @SQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
