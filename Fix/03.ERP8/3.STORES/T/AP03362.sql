IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03362]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP03362]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lấy số tiền phiếu thu theo hóa đơn đến thời điểm in báo cáo theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Thư on 6/12/2018: Điều chỉnh theo những cải tiến ở bản 8.1 do trước đó chưa sửa luôn cho bản 8.3.7STD
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
EXEC AP03362 'KVC', '05/06/2016', '1311', '171', 'KVC001', 'NNN06', 'VND'
*/

CREATE PROCEDURE [dbo].[AP03362] 	----Duoc goi tu Store AP0337
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@FromEmployeeID as nvarchar(50),
					@ToEmployeeID as nvarchar(50),
					@CurrencyID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@sSQL3 AS nvarchar(MAX),
		@Month AS int,
		@Year AS INT
		

SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

SET @sSQL = '
SELECT 
	AT9000.DivisionID, Ana05ID, TranMonth, TranYear, AT9000.CreditAccountID AS AccountID,
	ReceiptOriginalAmount =  SUM(ISNULL(AT9000.OriginalAmount,0)),
	ReceiptConvertedAmount = SUM(ISNULL(AT9000.ConvertedAmount,0))
FROM  AT9000 WITH (NOLOCK) 
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID= case when AT9000.TransactionTypeID=''T99'' then AT9000.CreditObjectID else AT9000.ObjectID end
WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
		AT9000.CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
		---- Loại trừ đối tượng có mã phân tích đối tượng số 3 là Z
		and AT1202.O03ID<>''Z''
		---- Loại trừ bút toán điều chỉnh trực tiếp cho doanh thu, trả hàng
		and AT9000.VoucherID not in
		(select VoucherID from at9000 where TransactionTypeID=''T24'')
GROUP BY AT9000.DivisionID, Ana05ID, TranMonth, TranYear, AT9000.CreditAccountID  '

--SET @sSQL='
--SELECT 
--	AT9000.ObjectID , AT9000.Ana05ID , AT9000.VoucherID, AT9000.TableID, AT9000.batchID, AT9000.CurrencyIDCN, AT9000.DebitAccountID AS AccountID, AT9000.DivisionID, AT9000.VoucherDate,
--	A09.TranMonth, A09.TranYear,
--	ReceiptOriginalAmount =  ISNULL(AT0303.OriginalAmount,0),
--	ReceiptConvertedAmount = ISNULL(AT0303.ConvertedAmount,0)
--FROM  AT9000 WITH (NOLOCK)
--LEFT JOIN AT0303 WITH (NOLOCK) ON AT0303.DivisionID = AT9000.DivisionID AND AT0303.ObjectID = AT9000.ObjectID AND
--										AT0303.DebitVoucherID = AT9000.VoucherID AND
--										AT0303.DebitBatchID = AT9000.BatchID AND
--										AT0303.DebitTableID = AT9000.TableID AND
--										AT0303.AccountID = AT9000.DebitAccountID AND
--										AT0303.CurrencyID = AT9000.CurrencyIDCN
--LEFT JOIN AT9000 A09 WITH (NOLOCK) ON A09.DivisionID = AT0303.DivisionID AND A09.VoucherID = AT0303.CreditVoucherID AND A09.BatchID = AT0303.CreditBatchID
--WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
--		AT9000.DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
--		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
--		AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
--		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
--GROUP BY AT9000.ObjectID, AT0303.OriginalAmount, AT0303.ConvertedAmount, AT9000.VoucherID, AT9000.TableID, AT9000.batchID, AT9000.CurrencyIDCN, AT9000.DebitAccountID , AT9000.DivisionID,  AT9000.Ana05ID, AT9000.VoucherDate,
--A09.TranMonth, A09.TranYear'

--SET @sSQL1 = '
--UNION ALL
--SELECT 
--	AT9000.ObjectID, AT9000.Ana05ID  , AT9000.VoucherID, AT9000.TableID, AT9000.batchID, AT9000.CurrencyIDCN, AT9000.CreditAccountID AS AccountID, AT9000.DivisionID, AT9000.VoucherDate,
--	A09.TranMonth, A09.TranYear,
--	ReceiptOriginalAmount =  ISNULL(AT0303.OriginalAmount,0),
--	ReceiptConvertedAmount = ISNULL(AT0303.ConvertedAmount,0)
--FROM  AT9000 WITH (NOLOCK) 
--LEFT JOIN AT0303 WITH (NOLOCK) ON AT0303.DivisionID = AT9000.DivisionID AND AT0303.ObjectID = AT9000.ObjectID AND
--										AT0303.DebitVoucherID = AT9000.VoucherID AND
--										AT0303.DebitBatchID = AT9000.BatchID AND
--										AT0303.DebitTableID = AT9000.TableID AND
--										AT0303.AccountID = AT9000.DebitAccountID AND
--										AT0303.CurrencyID = AT9000.CurrencyIDCN
--LEFT JOIN AT9000 A09 WITH (NOLOCK) ON A09.DivisionID = AT0303.DivisionID AND A09.VoucherID = AT0303.CreditVoucherID AND A09.BatchID = AT0303.CreditBatchID
--WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
--		AT9000.CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
--		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
--		AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
--		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
--GROUP BY AT9000.ObjectID, AT0303.OriginalAmount, AT0303.ConvertedAmount,  AT9000.VoucherID, AT9000.TableID, AT9000.batchID, AT9000.CurrencyIDCN, AT9000.CreditAccountID , AT9000.DivisionID,  AT9000.Ana05ID, AT9000.VoucherDate,
--A09.TranMonth, A09.TranYear  '

---------------AT9090 But toan tong hop
--SET @sSQL2='
--UNION ALL
--SELECT 
--	AT9000.ObjectID , AT9000.Ana05ID , AT9000.VoucherID, 
--	''AT9090'' AS TableID, AT9000.TransactionID AS BatchID, 
--	AT9000.CurrencyID AS CurrencyIDCN, AT9000.DebitAccountID AS AccountID, 
--	AT9000.DivisionID,	AT9000.VoucherDate,
--	A09.TranMonth, A09.TranYear,
--	ReceiptOriginalAmount =  ISNULL(AT0303.OriginalAmount,0),
--	ReceiptConvertedAmount = ISNULL(AT0303.ConvertedAmount,0)
--FROM  AT9090 AT9000 WITH (NOLOCK)
--LEFT JOIN AT0303 WITH (NOLOCK) ON AT0303.DivisionID = AT9000.DivisionID AND AT0303.ObjectID = AT9000.ObjectID AND
--										AT0303.DebitVoucherID = AT9000.VoucherID AND
--										AT0303.DebitBatchID = AT9000.VoucherID AND
--										AT0303.DebitTableID = ''AT9090'' AND
--										AT0303.AccountID = AT9000.DebitAccountID AND
--										AT0303.CurrencyID = AT9000.CurrencyID
--LEFT JOIN AT9000 A09 WITH (NOLOCK) ON A09.DivisionID = AT0303.DivisionID AND A09.VoucherID = AT0303.CreditVoucherID AND A09.BatchID = AT0303.CreditBatchID
--WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
--		AT9000.DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
--		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
--		AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
--		and AT9000.CurrencyID like '''+@CurrencyID+'''
--GROUP BY AT9000.ObjectID, AT0303.OriginalAmount, AT0303.ConvertedAmount, AT9000.VoucherID, AT9000.TransactionID, AT9000.CurrencyID, AT9000.DebitAccountID , AT9000.DivisionID,  AT9000.Ana05ID , AT9000.VoucherDate,
--A09.TranMonth, A09.TranYear
--'
--SET @sSQL3 = '
--UNION ALL
--SELECT 
--	AT9000.ObjectID, AT9000.Ana05ID  , AT9000.VoucherID, 
--	''AT9090'' AS TableID, AT9000.TransactionID AS BatchID, 
--	AT9000.CurrencyID AS CurrencyIDCN, 
--	AT9000.CreditAccountID AS AccountID, AT9000.DivisionID, AT9000.VoucherDate,
--	A09.TranMonth, A09.TranYear,
--	ReceiptOriginalAmount =  ISNULL(AT0303.OriginalAmount,0),
--	ReceiptConvertedAmount = ISNULL(AT0303.ConvertedAmount,0)
--FROM  AT9090 AT9000 WITH (NOLOCK) 
--LEFT JOIN AT0303 WITH (NOLOCK) ON AT0303.DivisionID = AT9000.DivisionID AND AT0303.ObjectID = AT9000.ObjectID AND
--										AT0303.DebitVoucherID = AT9000.VoucherID AND
--										AT0303.DebitBatchID = AT9000.VoucherID AND
--										AT0303.DebitTableID = ''AT9090'' AND
--										AT0303.AccountID = AT9000.DebitAccountID AND
--										AT0303.CurrencyID = AT9000.CurrencyID
--LEFT JOIN AT9000 A09 WITH (NOLOCK) ON A09.DivisionID = AT0303.DivisionID AND A09.VoucherID = AT0303.CreditVoucherID AND A09.BatchID = AT0303.CreditBatchID
--WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
--		AT9000.CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
--		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
--		AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
--		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
--GROUP BY AT9000.ObjectID, AT0303.OriginalAmount, AT0303.ConvertedAmount, AT9000.VoucherID,  AT9000.TransactionID, AT9000.CurrencyID, AT9000.CreditAccountID , AT9000.DivisionID,  AT9000.Ana05ID, AT9000.VoucherDate,
--A09.TranMonth, A09.TranYear  '

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3 
--IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033621]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--    DROP VIEW AV033621

--EXEC ('  CREATE VIEW AV033621 	--CREATED BY AP03362
--			AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)


--SET @sSQL = '
--		SELECT DivisionID, Ana05ID, AccountID, TranMonth, TranYear,
--			SUM(ReceiptOriginalAmount) AS ReceiptOriginalAmount,
--			SUM(ReceiptConvertedAmount) AS ReceiptConvertedAmount
--		FROM AV033621
--		GROUP BY DivisionID, Ana05ID, TranMonth, TranYear, AccountID
--'

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03362]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    DROP VIEW AV03362

EXEC ('  CREATE VIEW AV03362 	--CREATED BY AP03362
			AS ' + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO








