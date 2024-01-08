IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP00203]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP00203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lấy số phát sinh nợ tính đến thời điểm in báo cáo (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP00203] 	----Duoc goi tu Store AP0020
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@FromObjectID as nvarchar(50),
					@ToObjectID as nvarchar(50),
					@CurrencyID as nvarchar(50),
					@IsGroup as tinyint,
					@GroupID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@sSQL3 AS nvarchar(MAX),
		@Month AS int,
		@Year AS int,
		@GroupIDField AS nvarchar(50),
		@SQLGroup AS nvarchar(50)
	
SET nocount off
SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)
--------- So du No phat sinh trong nam-----------------------------------------------------------------

If @IsGroup = 1
Begin
	SET @GroupIDField =  (SELECT Case @GroupID when  'A01'  then 'Ana01ID'
					   when 'O01' then 'O01ID'   when 'O02' then 'O02ID'   when 'O03' then 'O03ID'   when 'O04' then 'O04ID' 
					   when 'O05' then 'O05ID'   End)

	SET @SQLGroup = ',' + @GroupIDField
End

Else 

Begin
   SET     @GroupIDField   =  ''''''''''
   SET   @SQLGroup = ''
End

SET @sSQL='
SELECT 
	AT9000.ObjectID , Ana01ID , VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID AS AccountID, DivisionID, VoucherDate, Ana05ID,
	BeginDebitAmount = SUM(ISNULL(OriginalAmountCN,0)),
	BeginDebitConAmount = SUM(ISNULL(ConvertedAmount,0)),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9000  WITH (NOLOCK) 
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY AT9000.ObjectID,  VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID
'
SET @sSQL1 = '
UNION ALL
SELECT 
	AT9000.ObjectID, Ana01ID  , VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID AS AccountID, DivisionID, VoucherDate, Ana05ID,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount = SUM(ISNULL(OriginalAmountCN,0)),
	BeginCreditConAmount = SUM(ISNULL(ConvertedAmount,0))
FROM  AT9000  WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
GROUP BY AT9000.ObjectID,  VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID  '

-------------AT9090 But toan tong hop
SET @sSQL2='
UNION ALL
SELECT 
	AT9000.ObjectID , Ana01ID , VoucherID, 
	''AT9090'' AS TableID, TransactionID AS BatchID, 
	CurrencyID AS CurrencyIDCN, DebitAccountID AS AccountID, 
	DivisionID,	VoucherDate, Ana05ID,
	BeginDebitAmount =SUM(ISNULL(OriginalAmount,0)),
	BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0)),
	0 AS BeginCreditAmount,
	0 AS BeginCreditConAmount
FROM  AT9090 AT9000 WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		and AT9000.CurrencyID like '''+@CurrencyID+'''
GROUP BY AT9000.ObjectID,  VoucherID, TransactionID, CurrencyID, DebitAccountID , DivisionID,  Ana01ID , VoucherDate, Ana05ID
'
SET @sSQL3 = '
UNION ALL
SELECT 
	AT9000.ObjectID, Ana01ID  , VoucherID, 
	''AT9090'' AS TableID, TransactionID AS BatchID, 
	CurrencyID AS CurrencyIDCN, 
	CreditAccountID AS AccountID, DivisionID, VoucherDate, Ana05ID,
	0 AS BeginDebitAmount,
	0 AS BeginDebitConAmount,
	BeginCreditAmount =SUM(ISNULL(OriginalAmount,0)),
	BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
FROM  AT9090 AT9000  WITH (NOLOCK)
WHERE 	DivisionID = '''+@DivisionID+''' AND
		CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
GROUP BY AT9000.ObjectID,  VoucherID,  TransactionID, CurrencyID, CreditAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID  '

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3 
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002031]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    EXEC ('  CREATE VIEW AV002031 	--CREATED BY AP00203
				AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)
ELSE
	EXEC ('  ALTER VIEW AV002031  	--CREATED BY AP00203
				AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)



SET @sSQL =' 
SELECT 	AV002031.ObjectID, Ana05ID, '+@GroupIDField+'  AS  GroupID  ,  AV002031.VoucherID, AV002031.TableID, 
		AV002031.batchID, AV002031.CurrencyIDCN, AV002031.AccountID, AV002031.DivisionID, 
		SUM(ISNULL(AV002031.BeginDebitAmount,0)) AS BeginDebitAmount  , SUM(ISNULL(AV002031.BeginDebitConAmount,0)) AS BeginDebitConAmount , 
		SUM(ISNULL(AV002031.BeginCreditAmount,0)) AS BeginCreditAmount  , SUM(ISNULL(AV002031.BeginCreditConAmount,0)) AS BeginCreditConAmount

FROM	AV002031  
INNER JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV002031.ObjectID
GROUP BY   AV002031.ObjectID ,  AV002031.VoucherID, AV002031.TableID, 
			AV002031.batchID, AV002031.CurrencyIDCN, AV002031.AccountID, AV002031.DivisionID, Ana05ID '

--print @sSQL
--print @GroupIDField
SET @sSQL =  @sSQL + @SQLGroup

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002032]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV002032	--CREATED BY AP00203
		AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW  AV002032 	--CREATED BY AP00203
		AS ' + @sSQL )

--------- Lấy ngày thanh toán gần nhất--------------------------------------
SET @sSQL = '
SELECT DivisionID, ObjectID,  Max(VoucherDate) as MaxVoucherDate
FROM AT9000 WITH (NOLOCK)
WHERE DivisionID = '''+@DivisionID+'''
AND TransactionTypeID IN (''T01'', ''T21'')
AND ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+'''
GROUP BY DivisionID, ObjectID
'
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002033]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV002033	--CREATED BY AP00203
		AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW  AV002033 	--CREATED BY AP00203
		AS ' + @sSQL )

SET @sSQL = '
SELECT AV002032.DivisionID, AV002032.ObjectID,  GroupID, MaxVoucherDate, Ana05ID,
			SUM(BeginDebitAmount) AS DebitAmountInYear, SUM(BeginCreditAmount) AS CreditAmountInYear, 
			SUM(BeginDebitConAmount) AS DebitConAmountInYear, SUM(BeginCreditConAmount) AS CreditConAmountInYear
FROM AV002032
LEFT JOIN AV002033 ON AV002033.DivisionID = AV002032.DivisionID AND AV002032.ObjectID = AV002033.ObjectID
GROUP BY AV002032.DivisionID, AV002032.ObjectID, AV002032.GroupID, AV002033.MaxVoucherDate, Ana05ID
'
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV00203]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV00203	--CREATED BY AP00203
		AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW  AV00203	--CREATED BY AP00203
		AS ' + @sSQL )

Set nocount on

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
