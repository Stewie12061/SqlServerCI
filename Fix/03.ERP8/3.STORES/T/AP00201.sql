IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP00201]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP00201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lấy số dư nợ cuối năm trước, số dư nợ năm nay tính đến thời điểm in báo cáo (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP00201] 	--- Duoc goi tu Store AP0020
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
--Delete AT0393
SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

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
	BeginDebitAmount =SUM(ISNULL(OriginalAmountCN,0))
	 -
	 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303  WITH (NOLOCK)
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
	 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303  WITH (NOLOCK)
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
		TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
		AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
GROUP BY AT9000.ObjectID,  VoucherID,  TransactionID, CurrencyID, CreditAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID  '

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3 
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002011]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    EXEC ('  CREATE VIEW AV002011 	--CREATED BY AP00201
				AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)
ELSE
	EXEC ('  ALTER VIEW AV002011  	--CREATED BY AP00201
				AS ' + @sSQL +@sSQL1+@sSQL2+@sSQL3)



SET @sSQL =' 
SELECT 	AV002011.ObjectID, '+@GroupIDField+'  AS  GroupID  ,  AV002011.VoucherID, AV002011.TableID, Ana05ID, 
		AV002011.batchID, AV002011.CurrencyIDCN, AV002011.AccountID, AV002011.DivisionID, 
		SUM(ISNULL(AV002011.BeginDebitAmount,0)) AS BeginDebitAmount  , SUM(ISNULL(AV002011.BeginDebitConAmount,0)) AS BeginDebitConAmount , 
		SUM(ISNULL(AV002011.BeginCreditAmount,0)) AS BeginCreditAmount  , SUM(ISNULL(AV002011.BeginCreditConAmount,0)) AS BeginCreditConAmount

FROM	AV002011  
INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV002011.ObjectID
GROUP BY   AV002011.ObjectID ,  AV002011.VoucherID, AV002011.TableID, 
			AV002011.batchID, AV002011.CurrencyIDCN, AV002011.AccountID, AV002011.DivisionID, Ana05ID '

--print @sSQL
--print @GroupIDField
SET @sSQL =  @sSQL + @SQLGroup

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002012]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV002012	--CREATED BY AP00201
		AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW  AV002012 	--CREATED BY AP00201
		AS ' + @sSQL )


---- So du cong no nam truoc ----------------
	SET @sSQL='
	SELECT 
		AT9000.ObjectID , Ana01ID , VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID AS AccountID, DivisionID,	VoucherDate, Ana05ID,
		BeginDebitAmount =SUM(ISNULL(OriginalAmountCN,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303 
										WHERE 	DivisionID = AT9000.DivisionID AND
											Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
											At0303.ObjectID = AT9000.ObjectID AND
											DebitVoucherID = AT9000.VoucherID AND
											DebitBatchID = AT9000.BatchID AND
											DebitTableID = At9000.TableID AND
											AT0303.AccountID = AT9000.DebitAccountID AND
											CurrencyID = AT9000.CurrencyIDCN),0),
	
		BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303 
										WHERE 	DivisionID = AT9000.DivisionID AND
											Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
											AT0303.ObjectID = AT9000.ObjectID AND
											DebitVoucherID = AT9000.VoucherID AND
											DebitBatchID = AT9000.BatchID AND
											DebitTableID = At9000.TableID AND
											AT0303.AccountID = AT9000.DebitAccountID AND
											CurrencyID = AT9000.CurrencyIDCN),0),

		0 AS BeginCreditAmount,
		0 AS BeginCreditConAmount
	FROM  AT9000  WITH (NOLOCK) 

	WHERE 	DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
			AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
			TranMonth + TranYear*100  Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100
			and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
	GROUP BY AT9000.ObjectID,  VoucherID, TableID, batchID, CurrencyIDCN, DebitAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID
	UNION ALL
	SELECT 
		AT9000.ObjectID, Ana01ID  , VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID AS AccountID, DivisionID, VoucherDate, Ana05ID,
		0 AS BeginDebitAmount,
		0 AS BeginDebitConAmount,

		BeginCreditAmount =SUM(ISNULL(OriginalAmountCN,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303 
										WHERE 	DivisionID = AT9000.DivisionID AND
											Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
											AT0303.ObjectID = AT9000.ObjectID AND
											CreditVoucherID = AT9000.VoucherID AND
											CreditBatchID = AT9000.BatchID AND
											CreditTableID = At9000.TableID AND
											AT0303.AccountID = AT9000.CreditAccountID AND
								CurrencyID = AT9000.CurrencyIDCN),0),
		BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303 
										WHERE 	DivisionID = AT9000.DivisionID AND
											Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
											AT0303.ObjectID = AT9000.ObjectID AND
											CreditVoucherID = AT9000.VoucherID AND
											CreditBatchID = AT9000.BatchID AND

											CreditTableID = At9000.TableID AND
											AT0303.AccountID = AT9000.CreditAccountID AND
											CurrencyID = AT9000.CurrencyIDCN),0)
	
	
	FROM  AT9000  WITH (NOLOCK)

	WHERE 	CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
			AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
			TranMonth + TranYear*100  Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100
			and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
	GROUP BY AT9000.ObjectID,  VoucherID, TableID, batchID, CurrencyIDCN, CreditAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID  '

	-------------AT9090 But toan tong hop
	SET @sSQL1='
	UNION ALL
	SELECT 
		AT9000.ObjectID , Ana01ID , VoucherID, 
		''AT9090'' AS TableID, TransactionID AS BatchID, 
		CurrencyID AS CurrencyIDCN, DebitAccountID AS AccountID, 
		DivisionID,	VoucherDate, Ana05ID,
		BeginDebitAmount =SUM(ISNULL(OriginalAmount,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) 
				FROM AT0303  WITH (NOLOCK)
				WHERE 	DivisionID = AT9000.DivisionID AND
						Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
						At0303.ObjectID = AT9000.ObjectID AND
						DebitVoucherID = AT9000.VoucherID AND
						DebitBatchID = AT9000.VoucherID AND
						DebitTableID = ''AT9090'' AND
						AT0303.AccountID = AT9000.DebitAccountID AND
						CurrencyID = AT9000.CurrencyID),0),
	
		BeginDebitConAmount =SUM(ISNULL(ConvertedAmount,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) 
				FROM AT0303  WITH (NOLOCK)
				WHERE 	DivisionID = AT9000.DivisionID AND
						Month(CreditVoucherDate)+100*Year(CreditVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
						AT0303.ObjectID = AT9000.ObjectID AND
						DebitVoucherID = AT9000.VoucherID AND
						DebitBatchID = AT9000.VoucherID AND
						DebitTableID = ''AT9090'' AND
						AT0303.AccountID = AT9000.DebitAccountID AND
						CurrencyID = AT9000.CurrencyID),0),

		0 AS BeginCreditAmount,
		0 AS BeginCreditConAmount
	FROM  AT9090 AT9000  WITH (NOLOCK) 

	WHERE 	DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
			AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
			TranMonth + TranYear*100  Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100
			and AT9000.CurrencyID like '''+@CurrencyID+'''
	GROUP BY AT9000.ObjectID,  VoucherID, TransactionID, CurrencyID, DebitAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID

	UNION ALL

	SELECT 
		AT9000.ObjectID, Ana01ID  , VoucherID, 
		''AT9090'' AS TableID, TransactionID AS BatchID, 
		CurrencyID AS CurrencyIDCN, 
		CreditAccountID AS AccountID, DivisionID, VoucherDate, Ana05ID,
		0 AS BeginDebitAmount,
		0 AS BeginDebitConAmount,

		BeginCreditAmount =SUM(ISNULL(OriginalAmount,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(OriginalAmount,0)) FROM AT0303 
										WHERE 	DivisionID = AT9000.DivisionID AND
											Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
											AT0303.ObjectID = AT9000.ObjectID AND
											CreditVoucherID = AT9000.VoucherID AND
											CreditBatchID = AT9000.VoucherID AND
											CreditTableID = ''AT9090'' AND
											AT0303.AccountID = AT9000.CreditAccountID AND
								CurrencyID = AT9000.CurrencyID),0),
		BeginCreditConAmount =SUM(ISNULL(ConvertedAmount,0))
		 -
		 ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM AT0303 
										WHERE 	DivisionID = AT9000.DivisionID AND
											Month(DebitVoucherDate)+100*Year(DebitVoucherDate) Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100 AND
											AT0303.ObjectID = AT9000.ObjectID AND
											CreditVoucherID = AT9000.VoucherID AND
											CreditBatchID = AT9000.VoucherID AND
											CreditTableID = ''AT9090'' AND
											AT0303.AccountID = AT9000.CreditAccountID AND
											CurrencyID = AT9000.CurrencyID),0)
	
	
	FROM  AT9090 AT9000  WITH (NOLOCK)

	WHERE 	CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
			AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
			TranMonth + TranYear*100  Between '+str(@Year-1)+'*100 + 1 AND 12+'+str(@Year-1)+'*100
			AND AT9000.CurrencyID like '''+@CurrencyID+'''
		
	GROUP BY AT9000.ObjectID,  VoucherID,  TransactionID, CurrencyID, CreditAccountID , DivisionID,  Ana01ID, VoucherDate, Ana05ID  '

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002013]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV002013 	--CREATED BY AP00201
				AS ' + @sSQL +@sSQL1)
ELSE
	EXEC ('  ALTER VIEW AV002013  	--CREATED BY AP00201
				AS ' + @sSQL +@sSQL1)


	SET @sSQL = '
	SELECT 	AV002013.ObjectID, '+@GroupIDField+'  AS  GroupID  ,  AV002013.VoucherID, AV002013.TableID, Ana05ID, 
		AV002013.batchID, AV002013.CurrencyIDCN, AV002013.AccountID, AV002013.DivisionID, 
		SUM(ISNULL(AV002013.BeginDebitAmount,0)) AS EndDebitAmountLastYear  , SUM(ISNULL(AV002013.BeginDebitConAmount,0)) AS EndDebitConAmountLastYear , 
		SUM(ISNULL(AV002013.BeginCreditAmount,0)) AS EndCreditAmountLastYear  , SUM(ISNULL(AV002013.BeginCreditConAmount,0)) AS EndCreditConAmountLastYear

	FROM	AV002013
	--INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV002013.ObjectID
	GROUP BY   AV002013.ObjectID ,  AV002013.VoucherID, AV002013.TableID, 
				AV002013.batchID, AV002013.CurrencyIDCN, AV002013.AccountID, AV002013.DivisionID, Ana05ID'

IF NOT EXISTS (SELECT NAME FROM sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV002014]') AND OBJECTPROPERTY(ID,N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV002014 	--CREATED BY AP00201
		AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW  AV002014 	--CREATED BY AP00201
		AS ' + @sSQL )
	
IF @IsGroup = 1
	SET @sSQL = '
	SELECT AV002012.DivisionID, AV002012.ObjectID, AV002012.Ana05ID, AV002012.GroupID, AV002012.BeginDebitAmount, AV002012.BeginCreditAmount, AV002012.BeginDebitConAmount, AV002012.BeginCreditConAmount,
			AV002014.EndDebitAmountLastYear, AV002014.EndCreditAmountLastYear, AV002014.EndDebitConAmountLastYear, AV002014.EndCreditConAmountLastYear
	FROM (SELECT DivisionID, ObjectID, Ana05ID,  GroupID, 
			SUM(BeginDebitAmount) AS BeginDebitAmount, SUM(BeginCreditAmount) AS BeginCreditAmount, 
			SUM(BeginDebitConAmount) AS BeginDebitConAmount, SUM(BeginCreditConAmount) AS BeginCreditConAmount
	FROM	AV002012
	WHERE	BeginDebitAmount<>0 
			or BeginCreditAmount<>0 
			or  BeginDebitConAmount<>0 
			or BeginCreditConAmount<>0
	GROUP BY DivisionID,ObjectID, Ana05ID, GroupID) AV002012
	INNER JOIN (SELECT  DivisionID, ObjectID, Ana05ID,  GroupID, 
			SUM(EndDebitAmountLastYear) AS EndDebitAmountLastYear, SUM(EndCreditAmountLastYear) AS EndCreditAmountLastYear, 
			SUM(EndDebitConAmountLastYear) AS EndDebitConAmountLastYear, SUM(EndCreditConAmountLastYear) AS EndCreditConAmountLastYear
	FROM	AV002014
	WHERE	EndDebitAmountLastYear<>0 
			or EndCreditAmountLastYear<>0 
			or  EndDebitConAmountLastYear<>0 
			or EndCreditConAmountLastYear<>0
	GROUP BY DivisionID,ObjectID, Ana05ID, GroupID) AV002014 ON AV002012.DivisionID = AV002014.DivisionID AND AV002012.ObjectID = AV002014.ObjectID
	'
ELSE	
	SET @sSQL = '
	SELECT AV002012.DivisionID, AV002012.ObjectID, AV002012.Ana05ID, AV002012.RemainDebitAmountInYear, AV002012.RemainCreditAmountinYear, AV002012.RemainDebitConAmountInYear, AV002012.RemainCreditConAmountinYear,
			AV002014.EndDebitAmountLastYear, AV002014.EndCreditAmountLastYear, AV002014.EndDebitConAmountLastYear, AV002014.EndCreditConAmountLastYear
	FROM (SELECT DivisionID, ObjectID, Ana05ID, 
			SUM(BeginDebitAmount) AS RemainDebitAmountInYear, SUM(BeginCreditAmount) AS RemainCreditAmountinYear, 
			SUM(BeginDebitConAmount) AS RemainDebitConAmountInYear, SUM(BeginCreditConAmount) AS RemainCreditConAmountinYear
	FROM	AV002012
	WHERE	BeginDebitAmount<>0 
			or BeginCreditAmount<>0 
			or  BeginDebitConAmount<>0 
			or BeginCreditConAmount<>0
	GROUP BY DivisionID,ObjectID, Ana05ID) AV002012
	lEFT JOIN (SELECT  DivisionID, ObjectID, Ana05ID,
			SUM(EndDebitAmountLastYear) AS EndDebitAmountLastYear, SUM(EndCreditAmountLastYear) AS EndCreditAmountLastYear, 
			SUM(EndDebitConAmountLastYear) AS EndDebitConAmountLastYear, SUM(EndCreditConAmountLastYear) AS EndCreditConAmountLastYear
	FROM	AV002014
	WHERE	EndDebitAmountLastYear<>0 
			or EndCreditAmountLastYear<>0 
			or  EndDebitConAmountLastYear<>0 
			or EndCreditConAmountLastYear<>0
	GROUP BY DivisionID,ObjectID, Ana05ID) AV002014 ON AV002012.DivisionID = AV002014.DivisionID AND AV002012.ObjectID = AV002014.ObjectID AND AV002012.Ana05ID = AV002014.Ana05ID
	'	
	
	IF NOT EXISTS (SELECT NAME FROM sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV00201]') AND OBJECTPROPERTY(ID,N'ISVIEW') = 1)
		EXEC ('  CREATE VIEW AV00201 	--CREATED BY AP00201
			AS ' + @sSQL )
	ELSE
		EXEC ('  ALTER VIEW  AV00201	--CREATED BY AP00201
			AS ' + @sSQL )

Set nocount on

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
