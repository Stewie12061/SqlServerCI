IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0338]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0338]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lấy số phát sinh nợ tính đến thời điểm in báo cáo theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
EXEC AP0338 'KVC', 'AR0332', '05/06/2016', '1311', '171', 'KVC001', 'NNN06', 'VND'
*/

CREATE PROCEDURE [dbo].[AP0338] 
					@DivisionID as nvarchar(50),
					@ReportID AS NVARCHAR(10),
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
--------- So du No phat sinh trong nam-----------------------------------------------------------------
IF @ReportID = 'AR0332'
BEGIN

SET @sSQL='
SELECT 
	Ana05ID, ObjectID, TransactionTypeID, VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID AS AccountID, DivisionID, VoucherDate, TranMonth, TranYear,
	BeginDebitAmount =SUM(ISNULL(OriginalAmountCN,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303 WITH (NOLOCK) 
									WHERE 	DivisionID = AT9000.DivisionID AND
										Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
										At0303.ObjectID = AT9000.ObjectID AND
										DebitVoucherID = AT9000.VoucherID AND
										DebitBatchID = AT9000.BatchID AND
										DebitTableID = At9000.TableID AND
										AT0303.AccountID = AT9000.DebitAccountID AND
										CurrencyID = AT9000.CurrencyIDCN),0),
	BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303 WITH (NOLOCK)
									WHERE 	DivisionID = AT9000.DivisionID AND
										Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
									    AT0303.ObjectID = AT9000.ObjectID AND
										DebitVoucherID = AT9000.VoucherID AND
										DebitBatchID = AT9000.BatchID AND
										DebitTableID = At9000.TableID AND
										AT0303.AccountID = AT9000.DebitAccountID AND
										CurrencyID = AT9000.CurrencyIDCN),0),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9000   WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TableID, batchID, CurrencyIDCN, DebitAccountID , DivisionID,  Ana05ID, TransactionTypeID, VoucherDate, TranMonth, TranYear
'
SET @sSQL1 = '
UNION ALL
SELECT 
	Ana05ID, ObjectID, TransactionTypeID , VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID AS AccountID, DivisionID, VoucherDate,TranMonth, TranYear,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount =SUM(ISNULL(OriginalAmountCN,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303 WITH (NOLOCK) 
									WHERE 	DivisionID = AT9000.DivisionID AND
										Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
										AT0303.ObjectID = AT9000.ObjectID AND
										CreditVoucherID = AT9000.VoucherID AND
										CreditBatchID = AT9000.BatchID AND
										CreditTableID = At9000.TableID AND
										AT0303.AccountID = AT9000.CreditAccountID AND
										CurrencyID = AT9000.CurrencyIDCN),0),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303 WITH (NOLOCK) 
									WHERE 	DivisionID = AT9000.DivisionID AND
										Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
										AT0303.ObjectID = AT9000.ObjectID AND
										CreditVoucherID = AT9000.VoucherID AND
										CreditBatchID = AT9000.BatchID AND

										CreditTableID = At9000.TableID AND
										AT0303.AccountID = AT9000.CreditAccountID AND
										CurrencyID = AT9000.CurrencyIDCN),0)
FROM  AT9000 WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TableID, batchID, CurrencyIDCN, CreditAccountID , DivisionID,  Ana05ID, TransactionTypeID, VoucherDate, TranMonth, TranYear  '

-------------AT9090 But toan tong hop
SET @sSQL2='
UNION ALL
SELECT 
	Ana05ID , ObjectID, TransactionTypeID, VoucherID, 
	''AT9090'' AS TableID, TransactionID AS BatchID, 
	CurrencyID AS CurrencyIDCN, DebitAccountID AS AccountID, 
	DivisionID,	VoucherDate,TranMonth, TranYear,
	BeginDebitAmount =SUM(ISNULL(OriginalAmount,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) 
	        FROM AT0303 WITH (NOLOCK) 
			WHERE 	DivisionID = AT9000.DivisionID AND
					Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
					At0303.ObjectID = AT9000.ObjectID AND
					DebitVoucherID = AT9000.VoucherID AND
					DebitBatchID = AT9000.VoucherID AND
					DebitTableID = ''AT9090'' AND
					AT0303.AccountID = AT9000.DebitAccountID AND
					CurrencyID = AT9000.CurrencyID),0),
	BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) 
	        FROM AT0303 WITH (NOLOCK) 
			WHERE 	DivisionID = AT9000.DivisionID AND
					Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
				    AT0303.ObjectID = AT9000.ObjectID AND
					DebitVoucherID = AT9000.VoucherID AND
					DebitBatchID = AT9000.VoucherID AND
					DebitTableID = ''AT9090'' AND
					AT0303.AccountID = AT9000.DebitAccountID AND
					CurrencyID = AT9000.CurrencyID),0),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9090 AT9000 WITH (NOLOCK)  
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyID like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TransactionID, CurrencyID, DebitAccountID , DivisionID,  Ana05ID , TransactionTypeID, VoucherDate, TranMonth, TranYear
'
SET @sSQL3 = '
UNION ALL
SELECT 
	Ana05ID  , ObjectID, TransactionTypeID, VoucherID, 
	''AT9090'' AS TableID, TransactionID AS BatchID, 
	CurrencyID AS CurrencyIDCN, 
	CreditAccountID AS AccountID, DivisionID, VoucherDate,TranMonth, TranYear,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount =SUM(ISNULL(OriginalAmount,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303 WITH (NOLOCK) 
									WHERE 	DivisionID = AT9000.DivisionID AND
										Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
										AT0303.ObjectID = AT9000.ObjectID AND
										CreditVoucherID = AT9000.VoucherID AND
										CreditBatchID = AT9000.VoucherID AND
										CreditTableID = ''AT9090'' AND
										AT0303.AccountID = AT9000.CreditAccountID AND
							CurrencyID = AT9000.CurrencyID),0),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303 WITH (NOLOCK) 
									WHERE 	DivisionID = AT9000.DivisionID AND
										Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 AND
										AT0303.ObjectID = AT9000.ObjectID AND
										CreditVoucherID = AT9000.VoucherID AND
										CreditBatchID = AT9000.VoucherID AND
										CreditTableID = ''AT9090'' AND
										AT0303.AccountID = AT9000.CreditAccountID AND
										CurrencyID = AT9000.CurrencyID),0)
FROM  AT9090 AT9000  WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
GROUP BY VoucherID, ObjectID, TransactionID, CurrencyID, CreditAccountID , DivisionID,  Ana05ID, TransactionTypeID, VoucherDate, TranMonth, TranYear  '

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3 
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03381]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    DROP VIEW AV03381

EXEC ('  CREATE VIEW AV03381 	--CREATED BY AP0338
			AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)


SET @sSQL ='
SELECT  AV03381.Ana05ID, AT1011.AnaName,  AV03381.AccountID, AV03381.DivisionID,
		SUM(ISNULL(AV03381.BeginDebitAmount,0)) AS OverDueDebitAmount  , SUM(ISNULL(AV03381.BeginDebitConAmount,0)) AS OverDueDebitConAmount,
		0 AS InDueDebitAmount, 0 AS InDueDebitConAmount

FROM	AV03381
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV03381.ObjectID
INNER JOIN AT1011 WITH (NOLOCK) on AT1011.AnaID = AV03381.Ana05ID AND AT1011.DivisionID = AV03381.DivisionID AND AT1011.AnaTypeID = ''A05''
WHERE (DATEDIFF(dd,AV03381.VoucherDate, Getdate()) > Isnull(AT1202.ReDays,0))
	AND AV03381.VoucherDate < GETDATE()
GROUP BY   AV03381.AccountID, AV03381.DivisionID, AV03381.Ana05ID, AT1011.AnaName 

UNION ALL
SELECT  AV03381.Ana05ID, AT1011.AnaName,  AV03381.AccountID, AV03381.DivisionID,
		0 AS OverDueDebitAmount, 0 AS OverDueDebitConAmount, 
		SUM(ISNULL(AV03381.BeginDebitAmount,0)) AS InDueDebitAmount  , SUM(ISNULL(AV03381.BeginDebitConAmount,0)) AS InDueDebitConAmount 

FROM	AV03381
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV03381.ObjectID
INNER JOIN AT1011 WITH (NOLOCK) on AT1011.AnaID = AV03381.Ana05ID AND AT1011.AnaTypeID = ''A05''
WHERE (DATEDIFF(dd,AV03381.VoucherDate, Getdate()) <= Isnull(AT1202.ReDays,0))
	AND AV03381.VoucherDate <= GETDATE()
GROUP BY   AV03381.AccountID, AV03381.DivisionID, AV03381.Ana05ID, AT1011.AnaName 
'

--PRINT @sSQL
EXEC (@sSQL)
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
