IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03361]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP03361]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lấy số phát sinh nợ tính đến thời điểm in báo cáo theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 15/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 6/12/2018: Điều chỉnh theo những cải tiến ở bản 8.1 do trước đó chưa sửa luôn cho bản 8.3.7STD (những comment của chị Mai)
		---- Modified by Tiểu Mai on 14/06/2017: Lấy bổ sung Số lượng, doanh thu hàng bán trả lại
		---- Modified by Tiểu Mai on 26/07/2018: Chỉnh sửa lại đúng yêu cầu, cải tiến tốc độ

/*
EXEC AP03361 'KVC', '05/06/2016', '1311', '171', 'KVC001', 'NNN06', 'VND'
*/

CREATE PROCEDURE [dbo].[AP03361] 	----Duoc goi tu Store AP0336
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
--------- So du No phat sinh trong nam-----------------------------------------------------------------

SET @sSQL='
SELECT 
	Ana05ID, TransactionTypeID, DebitAccountID AS AccountID, DivisionID, TranMonth, TranYear,
	BeginDebitAmount =SUM(ISNULL(OriginalAmountCN,0)),
	BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0)),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9000   WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY DebitAccountID , DivisionID,  Ana05ID, TransactionTypeID, TranMonth, TranYear
'
SET @sSQL1 = '
UNION ALL
SELECT 
	Ana05ID, TransactionTypeID , CreditAccountID AS AccountID, DivisionID, TranMonth, TranYear,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount =SUM(ISNULL(OriginalAmountCN,0)),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
FROM  AT9000  WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY CreditAccountID , DivisionID,  Ana05ID, TransactionTypeID, TranMonth, TranYear  '


--PRINT @sSQL
--PRINT @sSQL1

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033611]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    DROP VIEW AV033611

EXEC ('  CREATE VIEW AV033611 	--CREATED BY AP03361
			AS ' + @sSQL +@sSQL1)

---- Lấy doanh thu chưa VAT
SET @sSQL='
SELECT 
	Ana05ID, TransactionTypeID, DebitAccountID AS AccountID, DivisionID, TranMonth, TranYear,
	BeginDebitAmount =SUM(ISNULL(OriginalAmountCN,0)),
	BeginDebitConAmount = SUM(ISNULL(ConvertedAmount,0)),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount,
	SUM(ISNULL(Quantity,0)) AS Quantity,
	SUM(ISNULL(ConvertedQuantity,0)) AS ConvertedQuantity
FROM  AT9000  WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		TransactionTypeID not in (''T14'') AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY DebitAccountID , DivisionID,  Ana05ID, TransactionTypeID, TranMonth, TranYear
'
SET @sSQL1 = '
UNION ALL
SELECT 
	Ana05ID, TransactionTypeID , CreditAccountID AS AccountID, DivisionID,TranMonth, TranYear,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount =SUM(ISNULL(OriginalAmountCN,0)),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0)),
	SUM(ISNULL(Quantity,0)) AS Quantity,
	SUM(ISNULL(ConvertedQuantity,0)) AS ConvertedQuantity
FROM  AT9000  WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		TransactionTypeID not in (''T14'') AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY CreditAccountID , DivisionID,  Ana05ID, TransactionTypeID, TranMonth, TranYear  '

IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033612]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV033612
	
EXEC ('  CREATE VIEW  AV033612	--CREATED BY AP03361
	AS ' + @sSQL + @sSQL1 )



SET @sSQL =' 
SELECT A.*, ISNULL(B.QuantityTL,0) AS QuantityTL, ISNULL(B.ConvertedAmountTL,0) AS ConvertedAmountTL 
FROM (
		SELECT  AV033611.Ana05ID, AV033611.AccountID, AV033611.DivisionID, AV033611.TranMonth, AV033611.TranYear, A02.SaleAmount,
				SUM(ISNULL(AV033611.BeginDebitAmount,0)) AS DebitAmount  , SUM(ISNULL(AV033611.BeginDebitConAmount,0)) AS DebitConAmount , 
				SUM(ISNULL(AV033611.BeginCreditAmount,0)) AS CreditAmount  , SUM(ISNULL(AV033611.BeginCreditConAmount,0)) AS CreditConAmount

		FROM	AV033611  
		INNER JOIN AT1011 WITH (NOLOCK) on AT1011.AnaID = AV033611.Ana05ID AND AT1011.AnaTypeID = ''A05''
		LEFT JOIN (SELECT  AV033612.Ana05ID, AV033612.AccountID, AV033612.DivisionID, TranMonth, TranYear,
							SUM(ISNULL(AV033612.BeginDebitAmount,0)) AS SaleAmount
					FROM	AV033612  
					GROUP BY   AV033612.AccountID, AV033612.DivisionID, AV033612.Ana05ID, TranMonth, TranYear
					) A02 ON A02.DivisionID = AV033611.DivisionID AND  A02.Ana05ID = AV033611.Ana05ID AND 
							 A02.AccountID = AV033611.AccountID AND A02.TranMonth = AV033611.TranMonth AND A02.TranYear = AV033611.TranYear
		GROUP BY   AV033611.AccountID, AV033611.DivisionID, AV033611.Ana05ID, A02.SaleAmount, AV033611.TranMonth, AV033611.TranYear 
	) A 
	LEFT JOIN 
	(	SELECT  AT9000.DivisionID, TranMonth, TranYear, SUM(ISNULL(ConvertedQuantity,0)) AS QuantityTL, SUM(ISNULL(BeginCreditConAmount,0)) AS ConvertedAmountTL,
		CONVERT(varchar(2),TranMonth) +''/''+CONVERT(varchar(5),TranYear) AS Period, Ana05ID, AccountID
		FROM  AV033612 AT9000 WITH (NOLOCK) 
		WHERE TransactionTypeID = ''T24''
		GROUP BY AT9000.DivisionID, TranMonth,TranYear, Ana05ID, AccountID
	) B ON B.DivisionID  = A.DivisionID AND B.TranMonth = A.TranMonth AND B.TranYear = A.TranYear 
				AND ISNULL(B.AccountID,'''') = ISNULL(A.AccountID,'''') AND ISNULL(B.Ana05ID,'''') = ISNULL(A.Ana05ID,'''')'

--PRINT @sSQL
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03361]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV03361
	
EXEC ('  CREATE VIEW  AV03361	--CREATED BY AP03361
	AS ' + @sSQL )


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
