IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03391]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP03391]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lấy số phát sinh nợ tính đến thời điểm in báo cáo theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 20/02/2017: Fix bug dữ liệu do group TransactionTypeID khác nhau
---- Modified by Tiểu Mai on 21/03/2017: Bổ sung 4 trường InMonth
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Tiểu Mai on 23/06/2017: Chỉnh sửa lại cách lấy dữ liệu
---- Modified by Hải Long on 10/07/2017: Lấy dữ liệu theo ngày in báo cáo
---- Modified by Kim Thư on 21/9/2018: Lấy số dư nợ từ trước đến thời điểm in thay vì hiện tại lấy trong kỳ
---- Modified by Kim Thư on 03/01/2019: Sửa câu chạy cuối full join AV033914 để đối tượng không có nợ đầu kỳ vẫn lên số liệu trong kỳ.
---- Modified by Kim Thư on 13/03/2019: Bổ sung tính tiền thu đc trong năm và trong tháng group by theo Ana05 (KOYO), kết bảng check thêm Ana05
---- Modified by Kim Thư on 18/03/2019: Sửa tiền thu được trong tháng lấy từ thời điểm đầu tháng đến ngày in
----										tiền thu được trong năm lấy từ thời điểm đầu năm đến ngày in
---- Modified by Kim Thư on 19/06/2019: Bổ sung AV033922: doanh số hàng bán trả lại để trừ vào tổng công nợ phát sinh trong tháng và tiền thu được trong tháng
---- Modified by Kim Thư on 03/07/2019: Sửa tiền thu được trong tháng lấy từ thời điểm đầu tháng đến ngày in (theo phiếu thu - không theo giải trừ công nợ)
----										tiền thu được trong năm lấy từ thời điểm đầu năm đến ngày in (theo phiếu thu - không theo giải trừ công nợ)
---- Modified by Kim Thư on 09/07/2019: Bổ sung Isnull cho view tiền thu được trong tháng và năm: IsNull(AT9000.CreditObjectID, AT9000.ObjectID)
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
EXEC AP03391 'KVC', '02/06/2016', '1311', '171', 'KVC001', 'NNN06', 'VND'
*/

CREATE PROCEDURE [dbo].[AP03391] 	----Duoc goi tu Store AP0339
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@FromObjectID as nvarchar(50),
					@ToObjectID as nvarchar(50),
					@CurrencyID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@sSQL3 AS nvarchar(MAX),
		@Month AS int,
		@Year AS INT,
		@FromAna02ID AS NVARCHAR(50),
		@ToAna02ID AS NVARCHAR(50),
		@FromAna05ID AS NVARCHAR(50),
		@ToAna05ID AS NVARCHAR(50)
		
SET @FromAna02ID = (SELECT TOP 1 AnaID FROM AT1011
WHERE DivisionID IN ('KVC', '@@@') AND AnaTypeID LIKE 'A02'
ORDER BY AnaID)

SET @ToAna02ID = (SELECT TOP 1 AnaID FROM AT1011
WHERE DivisionID IN ('KVC', '@@@') AND AnaTypeID LIKE 'A02'
ORDER BY AnaID DESC)

SET @FromAna05ID = (SELECT TOP 1 AnaID FROM AT1011
WHERE DivisionID IN ('KVC', '@@@') AND AnaTypeID LIKE 'A05'
ORDER BY AnaID)

SET @ToAna05ID = (SELECT TOP 1 AnaID FROM AT1011
WHERE DivisionID IN ('KVC', '@@@') AND AnaTypeID LIKE 'A05'
ORDER BY AnaID DESC)	

SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

EXEC AP0316 @DivisionID,N'CNPTH001',@FromObjectID,@ToObjectID,@FromAccountID,@ToAccountID,@CurrencyID,N'',N'',@FromAna02ID,@ToAna02ID,@FromAna05ID,@ToAna05ID,@ReportDate,1,1

--------- So du No trong nam-----------------------------------------------------------------

SET @sSQL='
SELECT 
	Ana05ID, ObjectID, VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID AS AccountID, DivisionID, VoucherDate, TranMonth, TranYear, DueDate,
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
FROM  AT9000  WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		--TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		TranMonth + TranYear*100 < '+str(@Year)+'*100 + 1
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TableID, batchID, CurrencyIDCN, DebitAccountID , DivisionID,  Ana05ID, VoucherDate, TranMonth, TranYear, DueDate
'
SET @sSQL1 = '
UNION ALL
SELECT 
	Ana05ID, ObjectID, VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID AS AccountID, DivisionID, VoucherDate,TranMonth, TranYear, DueDate,
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
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		--TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		TranMonth + TranYear*100 < '+str(@Year)+'*100 + 1
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TableID, batchID, CurrencyIDCN, CreditAccountID , DivisionID,  Ana05ID, VoucherDate, TranMonth, TranYear, DueDate  '

-------------AT9090 But toan tong hop
SET @sSQL2='
UNION ALL
SELECT 
	Ana05ID , ObjectID, VoucherID, 
	''AT9090'' AS TableID, TransactionID AS BatchID, 
	CurrencyID AS CurrencyIDCN, DebitAccountID AS AccountID, 
	DivisionID,	VoucherDate,TranMonth, TranYear, DueDate,
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
FROM  AT9090 AT9000  WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		--TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		TranMonth + TranYear*100 < '+str(@Year)+'*100 + 1
		and AT9000.CurrencyID like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TransactionID, CurrencyID, DebitAccountID , DivisionID,  Ana05ID , VoucherDate, TranMonth, TranYear, DueDate
'
SET @sSQL3 = '
UNION ALL
SELECT 
	Ana05ID  , ObjectID, VoucherID, 
	''AT9090'' AS TableID, TransactionID AS BatchID, 
	CurrencyID AS CurrencyIDCN, 
	CreditAccountID AS AccountID, DivisionID, VoucherDate,TranMonth, TranYear, DueDate,
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
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		--TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		TranMonth + TranYear*100 < '+str(@Year)+'*100 + 1
		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
GROUP BY VoucherID, ObjectID, TransactionID, CurrencyID, CreditAccountID , DivisionID,  Ana05ID, VoucherDate, TranMonth, TranYear, DueDate '

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3 
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033911]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    DROP VIEW AV033911

EXEC ('  CREATE VIEW AV033911 	--CREATED BY AP03391
			AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)



SET @sSQL = '
SELECT AV033911.DivisionID , AV033911.ObjectID, AV033911.AccountID, AV033911.Ana05ID,
	SUM(ISNULL(AV033911.BeginDebitAmount,0)) AS DebitAmount  , SUM(ISNULL(AV033911.BeginDebitConAmount,0)) AS DebitConAmount 
FROM AV033911

GROUP BY AV033911.DivisionID, AV033911.ObjectID, AV033911.AccountID, AV033911.Ana05ID
'
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033912]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033912
	
EXEC ('  CREATE VIEW  AV033912	--CREATED BY AP03391
	AS ' + @sSQL )


------------ Lấy tổng nợ phát sinh-------------------------

SET @sSQL='
SELECT 
	Ana05ID, ObjectID, TransactionTypeID, VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID AS AccountID, DivisionID, VoucherDate, TranMonth, TranYear,
	BeginDebitAmount =SUM(ISNULL(OriginalAmountCN,0)),
	BeginDebitConAmount = SUM(ISNULL(ConvertedAmount,0)),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9000 WITH (NOLOCK)  
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''			
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY VoucherID, ObjectID, TableID, batchID, CurrencyIDCN, DebitAccountID , DivisionID,  Ana05ID, TransactionTypeID, VoucherDate, TranMonth, TranYear
'
SET @sSQL1 = '
UNION ALL
SELECT 
	Ana05ID, ObjectID, TransactionTypeID , VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID AS AccountID, DivisionID, VoucherDate,TranMonth, TranYear,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount =SUM(ISNULL(OriginalAmountCN,0)),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
FROM  AT9000  WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''			
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
	BeginDebitAmount =SUM(ISNULL(OriginalAmount,0)),
	BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0)),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9090 AT9000 WITH (NOLOCK)  
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''			
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
	BeginCreditAmount =SUM(ISNULL(OriginalAmount,0)),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
FROM  AT9090 AT9000 WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''			
		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
GROUP BY VoucherID, ObjectID, TransactionID, CurrencyID, CreditAccountID , DivisionID,  Ana05ID, TransactionTypeID, VoucherDate, TranMonth, TranYear  '
--SELECT @sSQL
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033913]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033913
	
EXEC ('  CREATE VIEW  AV033913	--CREATED BY AP03391
	AS ' + @sSQL )

SET @sSQL = '
SELECT AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID,
	SUM(ISNULL(AV033913.BeginDebitAmount,0)) AS DebitAmountInYear  , SUM(ISNULL(AV033913.BeginDebitConAmount,0)) AS DebitConAmountInYear
FROM AV033913
GROUP BY AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID
'
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033914]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033914
	
EXEC ('  CREATE VIEW  AV033914	--CREATED BY AP03391
	AS ' + @sSQL )


------------ Lấy doanh thu chưa VAT------------------------

SET @sSQL = '
SELECT AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID,
	SUM(ISNULL(AV033913.BeginDebitAmount,0)) AS UnincludedVATDebitAmount  , SUM(ISNULL(AV033913.BeginDebitConAmount,0)) AS UnincludedVATDebitConAmount 
FROM AV033913
WHERE AV033913.TransactionTypeID not in (''T14'')
GROUP BY AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID
'

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033915]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033915
	
EXEC ('  CREATE VIEW  AV033915	--CREATED BY AP03391
	AS ' + @sSQL )

------------ Lấy tổng nợ quá hạn---------------------------
SET @sSQL = '
SELECT AV033911.DivisionID, AV033911.ObjectID, AV033911.AccountID, AV033911.Ana05ID,
	SUM(ISNULL(AV033911.BeginDebitAmount,0)) AS OverDueDebitAmount  , SUM(ISNULL(AV033911.BeginDebitConAmount,0)) AS OverDueDebitConAmount 
FROM AV033911
LEFT JOIN AT1202 A01 WITH (NOLOCK) ON A01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A01.ObjectID = AV033911.ObjectID
WHERE (DATEDIFF(dd,CONVERT(NVARCHAR(50),ISNULL(AV033911.DueDate, AV033911.VoucherDate),101), '''+CONVERT(NVARCHAR(50),@ReportDate,101)+''') > Isnull(A01.ReDays,0))
	AND CONVERT(NVARCHAR(50),ISNULL(AV033911.DueDate, AV033911.VoucherDate),101) < '''+CONVERT(NVARCHAR(50),@ReportDate,101)+'''
GROUP BY AV033911.DivisionID, AV033911.ObjectID, AV033911.AccountID, AV033911.Ana05ID
'
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033916]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033916
	
EXEC ('  CREATE VIEW  AV033916	--CREATED BY AP03391
	AS ' + @sSQL )

--PRINT @sSQL

------------ Lấy tiền thu được trong tháng-----------------
SET @sSQL = '
	--SELECT AT0303.DivisionID, AT0303.ObjectID, AT0303.AccountID, A.Ana05ID, 
	--	SUM(ISNULL(AT0303.OriginalAmount,0)) as CreditPayOriginalAmount,
	--	SUM(ISNULL(AT0303.ConvertedAmount,0)) as CreditPayConvertedAmount
	--FROM AT0303 WITH (NOLOCK) OUTER APPLY (SELECT TOP 1 * FROM AT9000 WHERE AT0303.CreditVoucherID = AT9000.VoucherID) A
	--WHERE 	AT0303.DivisionID = '''+@DivisionID+''' AND
	--	AT0303.ObjectID Between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
	--	--Month(AT0303.CreditVoucherDate)+100*Year(AT0303.CreditVoucherDate) Between '+str(@Year)+'*100 +'+str(@Month)+' AND '+str(@Month)+'+'+str(@Year)+'*100 
	--	(AT0303.CreditVoucherDate BETWEEN '''+ CAST(@Year AS VARCHAR(5)) + '-' + CASE WHEN @Month < 10 THEN '0' + CAST (@Month AS VARCHAR(5)) ELSE CAST (@Month AS VARCHAR(5)) END  + '-' + '01'+''' and '''+ CONVERT(VARCHAR(10),@ReportDate,21) + ' 23:59:59'')
	--GROUP BY AT0303.DivisionID, AT0303.ObjectID, AT0303.AccountID, A.Ana05ID

	SELECT AT9000.DivisionID, Isnull(AT9000.CreditObjectID, AT9000.ObjectID) as ObjectID, AT9000.CreditAccountID as AccountID, AT9000.Ana05ID,
		SUM(ISNULL(AT9000.OriginalAmount,0)) as CreditPayOriginalAmount,
		SUM(ISNULL(AT9000.ConvertedAmount,0)) as CreditPayConvertedAmount
	FROM AT9000 WITH(NOLOCK)
	WHERE AT9000.DivisionID = '''+@DivisionID+'''
		--AND AT9000.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		AND Isnull(AT9000.CreditObjectID, AT9000.ObjectID) BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		AND AT9000.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
		AND (AT9000.VoucherDate BETWEEN '''+ CAST(@Year AS VARCHAR(5)) + '-' + CASE WHEN @Month < 10 THEN '0' + CAST (@Month AS VARCHAR(5)) ELSE CAST (@Month AS VARCHAR(5)) END  + '-' + '01'+''' and '''+ CONVERT(VARCHAR(10),@ReportDate,21) + ' 23:59:59'')
	GROUP BY AT9000.DivisionID, Isnull(AT9000.CreditObjectID, AT9000.ObjectID), AT9000.CreditAccountID, AT9000.Ana05ID
'

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033917]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033917
	
EXEC ('  CREATE VIEW  AV033917	--CREATED BY AP03391
	AS ' + @sSQL )

------------ Lấy tiền thu được trong năm-----------------
SET @sSQL = '
	--SELECT AT0303.DivisionID, AT0303.ObjectID, AT0303.AccountID, A.Ana05ID, 
	--	SUM(ISNULL(AT0303.OriginalAmount,0)) as CreditPayOriginalAmountInYear,
	--	SUM(ISNULL(AT0303.ConvertedAmount,0)) as CreditPayConvertedAmountInYear
	--FROM AT0303 WITH (NOLOCK)   OUTER APPLY (SELECT TOP 1 * FROM AT9000 WHERE AT0303.CreditVoucherID = AT9000.VoucherID) A
	--WHERE 	AT0303.DivisionID = '''+@DivisionID+''' AND
	--	AT0303.ObjectID Between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
	--	--Year(CreditVoucherDate) = '+str(@Year)+' AND
	--	--Month(AT0303.CreditVoucherDate)+100*Year(AT0303.CreditVoucherDate) Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100 and 
	--	(AT0303.CreditVoucherDate BETWEEN '''+ CAST(@Year AS VARCHAR(5)) + '-01-01'+''' and '''+ CONVERT(VARCHAR(10),@ReportDate,21) + ' 23:59:59'')
	--GROUP BY AT0303.DivisionID, AT0303.ObjectID, AT0303.AccountID, A.Ana05ID

	SELECT AT9000.DivisionID, Isnull(AT9000.CreditObjectID, AT9000.ObjectID) as ObjectID, AT9000.CreditAccountID as AccountID, AT9000.Ana05ID,
		SUM(ISNULL(AT9000.OriginalAmount,0)) as CreditPayOriginalAmountInYear,
		SUM(ISNULL(AT9000.ConvertedAmount,0)) as CreditPayConvertedAmountInYear
	FROM AT9000 WITH(NOLOCK)
	WHERE AT9000.DivisionID = '''+@DivisionID+'''
		AND Isnull(AT9000.CreditObjectID, AT9000.ObjectID) BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		AND AT9000.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
		AND (AT9000.VoucherDate BETWEEN '''+ CAST(@Year AS VARCHAR(5)) + '-01-01'+''' and '''+ CONVERT(VARCHAR(10),@ReportDate,21) + ' 23:59:59'')
	GROUP BY AT9000.DivisionID, Isnull(AT9000.CreditObjectID, AT9000.ObjectID), AT9000.CreditAccountID, AT9000.Ana05ID

'
--SELECT @sSQL
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033918]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033918
	
EXEC ('  CREATE VIEW  AV033918	--CREATED BY AP03391
	AS ' + @sSQL )

--PRINT @sSQL

Exec AP7402  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID,  @ToObjectID, @DivisionID 

SET @sSQL = '
SELECT DivisionID, ObjectID, AccountID, Ana05ID,
SUM (CASE WHEN ((TranMonth + 100 * TranYear < 1  + 100 * ' + str(@Year) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END)  AS DebitOriginalOpening,
SUM (CASE WHEN ((TranMonth + 100 * TranYear < 1  + 100 * ' + str(@Year) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS DebitConvertedOpening,
SUM (CASE WHEN ((TranMonth + 100 * TranYear < 1  + 100 * ' + str(@Year) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END)  AS CreditOriginalOpening,
SUM (CASE WHEN ((TranMonth + 100 * TranYear < 1  + 100 * ' + str(@Year) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS CreditConvertedOpening
FROM AV7402
GROUP BY DivisionID, ObjectID, AccountID, Ana05ID
'
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033919]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033919
	
EXEC ('  CREATE VIEW  AV033919	--CREATED BY AP03391
	AS ' + @sSQL )
	
------------ Lấy doanh thu chưa VAT trong thang ------------------------

SET @sSQL = '
SELECT AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID,
	SUM(ISNULL(AV033913.BeginDebitAmount,0)) AS UnincludedVATDebitAmountInMonth  , SUM(ISNULL(AV033913.BeginDebitConAmount,0)) AS UnincludedVATDebitConAmountInMonth 
FROM AV033913
WHERE AV033913.TransactionTypeID not in (''T14'') AND MONTH(VoucherDate) = '+STR(@Month)+' AND YEAR(VoucherDate) = '+STR(@Year)+'
GROUP BY AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID
'

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033920]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033920
	
EXEC ('  CREATE VIEW  AV033920	--CREATED BY AP03391
	AS ' + @sSQL )

SET @sSQL = '
SELECT AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID,
	SUM(ISNULL(AV033913.BeginDebitAmount,0)) AS DebitAmountInMonth  , SUM(ISNULL(AV033913.BeginDebitConAmount,0)) AS DebitConAmountInMonth
FROM AV033913
WHERE MONTH(VoucherDate) = '+STR(@Month)+' AND YEAR(VoucherDate) = '+STR(@Year)+'
GROUP BY AV033913.DivisionID, AV033913.ObjectID, AV033913.AccountID, AV033913.Ana05ID
'
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033921]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033921
	
EXEC ('  CREATE VIEW  AV033921	--CREATED BY AP03391
	AS ' + @sSQL )

------------ Lấy tổng tiền hàng bán trả lại để trừ vào tổng công nợ phải thu ------------------------
SET @sSQL = '
SELECT 
	Ana05ID , ObjectID, 
	CurrencyID AS CurrencyIDCN, 
	CreditAccountID AS AccountID, DivisionID,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	ReturnCreditAmount =SUM(ISNULL(OriginalAmount,0)),
	ReturnCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
FROM  AT9000 WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		MONTH(VoucherDate) = '+STR(@Month)+' AND YEAR(VoucherDate) = '+STR(@Year)+'
		AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''			
		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		AND AT9000.TransactionTypeID in (''T24'',''T34'')
GROUP BY ObjectID, CurrencyID, CreditAccountID , DivisionID,  Ana05ID
'

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033922]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033922
	
EXEC ('  CREATE VIEW  AV033922	--CREATED BY AP03391
	AS ' + @sSQL )

SET @sSQL ='
SELECT  ISNULL(AV033912.DivisionID,AV033914.DivisionID) AS DivisionID, ISNULL(AV033912.ObjectID,AV033914.ObjectID) AS ObjectID, 
ISNULL(AV033912.AccountID,AV033914.AccountID) AS AccountID, ISNULL(AV033912.Ana05ID,AV033914.Ana05ID) AS Ana05ID,
		Isnull(AV033915.UnincludedVATDebitAmount,0) as UnincludedVATDebitAmount, Isnull(AV033915.UnincludedVATDebitConAmount,0) as UnincludedVATDebitConAmount,
		Isnull(AV033914.DebitAmountInYear,0) as DebitAmountInYear, Isnull(AV033914.DebitConAmountInYear,0) as DebitConAmountInYear,
		(ISNULL(AV0316.OriginalAmount1,0) + ISNULL(AV0316.OriginalAmount2,0) + ISNULL(AV0316.OriginalAmount3,0) + ISNULL(AV0316.OriginalAmount4,0) + ISNULL(AV0316.OriginalAmount5,0)) as OverDueDebitAmount,
		(ISNULL(AV0316.ConvertedAmount1,0) + ISNULL(AV0316.ConvertedAmount2,0) + ISNULL(AV0316.ConvertedAmount3,0) + ISNULL(AV0316.ConvertedAmount4,0) + ISNULL(AV0316.ConvertedAmount5,0)) as OverDueDebitConAmount,
		--Isnull(AV033917.CreditPayOriginalAmount,0) as CreditPayOriginalAmountInMonth, Isnull(AV033917.CreditPayConvertedAmount,0) as CreditPayConvertedAmountInMonth,
		Isnull(AV033917.CreditPayOriginalAmount,0) - ISNULL(AV033922.ReturnCreditAmount,0) as CreditPayOriginalAmountInMonth, 
		Isnull(AV033917.CreditPayConvertedAmount,0) - ISNULL(AV033922.ReturnCreditConAmount,0) as CreditPayConvertedAmountInMonth,
		Isnull(AV033912.DebitAmount,0) as DebitAmount, Isnull(AV033912.DebitConAmount,0) as DebitConAmount,
		Isnull(AV033918.CreditPayOriginalAmountInYear,0) as CreditPayOriginalAmountInYear, Isnull(AV033918.CreditPayConvertedAmountInYear,0) as CreditPayConvertedAmountInYear,
		Isnull(AV033919.DebitOriginalOpening,0) as DebitOriginalOpening,
		Isnull(AV033919.DebitConvertedOpening,0) as DebitConvertedOpening,
		Isnull(AV033919.CreditOriginalOpening,0) as CreditOriginalOpening,
		Isnull(AV033919.CreditConvertedOpening,0) as CreditConvertedOpening,
		Isnull(AV033920.UnincludedVATDebitAmountInMonth,0) as UnincludedVATDebitAmountInMonth, 
		Isnull(AV033920.UnincludedVATDebitConAmountInMonth,0) as UnincludedVATDebitConAmountInMonth,
		Isnull(AV033921.DebitAmountInMonth,0) - ISNULL(AV033922.ReturnCreditAmount,0) as DebitAmountInMonth, 
		Isnull(AV033921.DebitConAmountInMonth,0) - ISNULL(AV033922.ReturnCreditConAmount,0) as DebitConAmountInMonth
		--Isnull(AV033921.DebitAmountInMonth,0) as DebitAmountInMonth, 
		--Isnull(AV033921.DebitConAmountInMonth,0) as DebitConAmountInMonth
FROM	AV033912
FULL JOIN AV033914 AV033914 ON AV033912.DivisionID = AV033914.DivisionID AND AV033912.ObjectID = AV033914.ObjectID AND AV033912.AccountID = AV033914.AccountID AND ISNULL(AV033912.Ana05ID,'''') = Isnull(AV033914.Ana05ID,'''')
LEFT JOIN AV033915 AV033915 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033915.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033915.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033915.AccountID AND ISNULL(ISNULL(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV033915.Ana05ID,'''')
LEFT JOIN AV0316 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV0316.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV0316.ObjectID AND ISNULL(ISNULL(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV0316.Group3,'''')
LEFT JOIN AV033917 AV033917 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033917.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033917.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033917.AccountID AND Isnull(Isnull(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV033917.Ana05ID,'''')
FULL JOIN AV033918 AV033918 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033918.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033918.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033918.AccountID AND Isnull(Isnull(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV033918.Ana05ID,'''') 
LEFT JOIN AV033919 AV033919 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033919.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033919.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033919.AccountID AND Isnull(AV033912.Ana05ID,'''') = Isnull(AV033919.Ana05ID,'''')
LEFT JOIN AV033920 AV033920 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033920.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033920.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033920.AccountID AND ISNULL(ISNULL(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV033920.Ana05ID,'''')
LEFT JOIN AV033921 AV033921 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033921.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033921.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033921.AccountID AND ISNULL(ISNULL(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV033921.Ana05ID,'''')
LEFT JOIN AV033922 AV033922 ON ISNULL(AV033912.DivisionID,AV033914.DivisionID) = AV033922.DivisionID AND ISNULL(AV033912.ObjectID,AV033914.ObjectID) = AV033922.ObjectID AND ISNULL(AV033912.AccountID,AV033914.AccountID) = AV033922.AccountID AND ISNULL(ISNULL(AV033912.Ana05ID,AV033914.Ana05ID),'''') = Isnull(AV033922.Ana05ID,'''')

'

--PRINT @sSQL
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03391]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV03391
	
EXEC ('  CREATE VIEW  AV03391	--CREATED BY AP03391
	AS ' + @sSQL )








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
