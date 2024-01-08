IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0275_SIKICO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0275_SIKICO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








---- Created by: Kiều Nga 
---- Date: 03/10/2022  
---- Purpose: Loc danh sach cong no phai thu/phai tra dau ky (tạo customize cho SIKICO)
---- Modified by Kiều Nga on 26/10/2022: [2022/10/IS/0142] - Không hiển thị tài khoản đối ứng khi kế thừa tại bút toán tổng hợp
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE AP0275_SIKICO
(	
	@DivisionID NVARCHAR(50),
	@FromMonth INT,
  	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,  
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsDate TINYINT, ----0 theo ky, 1 theo ngày
	@Mode TINYINT,---0 cong no phai thu, 1 cong no phai tra
	@ObjectID NVARCHAR(50),
	@TransactionTypeID NVARCHAR (50), 
	@ConditionVT NVARCHAR(1000),
	@IsUsedConditionVT NVARCHAR(1000),
	@ConditionOB NVARCHAR(1000),
	@IsUsedConditionOB NVARCHAR(1000)
)			
AS
DECLARE @sqlSelect NVARCHAR(MAX)='',
		@sqlSelect1 NVARCHAR(MAX)='',
		@sqlSelect2 NVARCHAR(MAX)='',
		@sqlSelect3 NVARCHAR(MAX)='',
		@sqlSelect4 NVARCHAR(MAX)='',
		@sqlWhere  NVARCHAR(MAX)='',
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @IsDate = 0 SET  @sqlWhere = '
	AND TranMonth + TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+' '
ELSE SET @sqlWhere = N'
	AND CONVERT(VARCHAR, VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+''' '
	
IF @Mode = 0 -- Trường hợp lập phiếu thu
BEGIN
-- Các bút toán không có tài khoản thuộc nhóm giải trừ (công nợ có quản lí đối tượng)
SET @sqlSelect1 = '
SELECT AT9000.DivisionID,
		AT9000.VoucherID,
		AT9000.TransactionID,
		ISNULL(OriginalAmount, 0) - ISNULL(OriginalAmountPT, 0) AS EndOriginalAmount,
		ISNULL(ConvertedAmount, 0) - ISNULL(ConvertedAmountPT, 0) AS EndConvertedAmount,
		IsWithhodingTax
INTO #Temp
FROM
(	(SELECT AT9000.DivisionID, TranMonth, TranYear, VoucherID, VoucherDate, BatchID, Invoiceno, TransactionID, TransactionTypeID
		,AT9000.ObjectID
		,AT9000.DebitAccountID
		,SUM(originalamount) as OriginalAmount
		,SUM(convertedamount) as  convertedamount, TableID, CurrencyID, IsWithhodingTax
	FROM AT9000  WITH (NOLOCK)
	WHERE TransactionTypeID = '''+@TransactionTypeID+'''
	GROUP BY AT9000.DivisionID, TranMonth, TranYear, VoucherID, VoucherDate, BatchID, Invoiceno, TransactionID,
		TransactionTypeID, AT9000.CreditObjectID , AT9000.ObjectID , AT9000.DebitAccountID, CreditAccountID, TableID, CurrencyID, TransactionTypeID, IsWithhodingTax
	) AT9000 '

SET @sqlSelect2 = '
	LEFT JOIN
		(	SELECT DivisionID, TVoucherID, TBatchID, SUM(OriginalAmountPT) OriginalAmountPT,
					CreditAccountID, SUM(ConvertedAmountPT) AS ConvertedAmountPT, InvoiceNo,ObjectID, ReTransactionID
			FROM (
				SELECT	AT9000.DivisionID, AT9000.TVoucherID, TBatchID, SUM(AT9000.OriginalAmount) OriginalAmountPT,
						AT9000.CreditAccountID, SUM(AT9000.ConvertedAmount) ConvertedAmountPT, InvoiceNo, AT9000.CreditObjectID AS ObjectID, ReTransactionID
				FROM AT9000  WITH (NOLOCK)
				LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.CreditAccountID = AT1005.AccountID
				WHERE TransactionTypeID = ''T99'' AND ISNULL(TVoucherID, '''') <> '''' 
				GROUP BY AT9000.DivisionID, TVoucherID, TBatchID, InvoiceNo, CreditObjectID, CreditAccountID, ReTransactionID
				UNION ALL
				SELECT	AT9000.DivisionID, AT9000.TVoucherID, TBatchID, SUM(AT9000.OriginalAmount) OriginalAmountPT,
						AT9000.CreditAccountID, SUM(AT9000.ConvertedAmount) ConvertedAmountPT, InvoiceNo, AT9000.ObjectID, ReTransactionID
				FROM AT9000 WITH (NOLOCK) 
				LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.CreditAccountID = AT1005.AccountID
				WHERE TransactionTypeID IN (''T01'',''T21'',''T02'',''T22'',''T00'') AND ISNULL(TVoucherID, '''') <> '''' 
				GROUP BY AT9000.DivisionID, TVoucherID, TBatchID, InvoiceNo, ObjectID, CreditAccountID, ReTransactionID
				UNION ALL
				SELECT	AT9000.DivisionID, AT9000.TVoucherID, TBatchID, SUM(AT9000.OriginalAmount) OriginalAmountPT,
						AT9000.DebitAccountID AS CreditAccountID, SUM(AT9000.ConvertedAmount) ConvertedAmountPT, InvoiceNo, AT9000.ObjectID, ReTransactionID
				FROM AT9000  WITH (NOLOCK)
				LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.CreditAccountID = AT1005.AccountID
				WHERE	TransactionTypeID IN (''T01'',''T21'',''T99'',''T02'',''T22'',''T00'') AND ISNULL(TVoucherID, '''') <> '''' 					
				GROUP BY AT9000.DivisionID, TVoucherID, TBatchID, InvoiceNo, ObjectID, DebitAccountID, ReTransactionID
				) T
			GROUP BY DivisionID, TVoucherID, TBatchID, CreditAccountID, InvoiceNo,ObjectID, ReTransactionID
		) K ON AT9000.DivisionID = K.DivisionID
				AND AT9000.VoucherID = K.TVoucherID
				AND AT9000.BatchID = K.TBatchID
				AND AT9000.TransactionID = K.ReTransactionID
				AND ISNULL(AT9000.ObjectID, '''') = ISNULL(K.ObjectID, '''')
				AND K.CreditAccountID = AT9000.DebitAccountID
				AND ISNULL(AT9000.InvoiceNo, '''') = ISNULL(K.InvoiceNo, ''''))'
	
-- Các bút toán có tài khoản thuộc nhóm giải trừ (công nợ có quản lí đối tượng)	
SET @sqlSelect3 = ' 
	UNION
SELECT AT9000.DivisionID,
					AT9000.VoucherID,
					AT9000.TransactionID,
					ISNULL(OriginalAmount, 0) - ISNULL(OriginalAmountOffset, 0) EndOriginalAmount,
					ISNULL(ConvertedAmount, 0) - ISNULL(ConvertedAmountOffset, 0) EndConvertedAmount,
					IsWithhodingTax
FROM
	(	(	SELECT AT9000.DivisionID,
				    TranMonth,
				    TranYear,
				    VoucherID,
				    VoucherDate,
				    BatchID,
				    Invoiceno,
					AT9000.ObjectID,
				    CreditAccountID,
				    SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount,
				    SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount,
				    IsWithhodingTax,
				    TableID,
				    CurrencyID,
				    TransactionTypeID,
					TransactionID
			FROM AT9000 WITH (NOLOCK)
			WHERE TransactionTypeID = '''+@TransactionTypeID+'''
			GROUP BY AT9000.DivisionID,
				        TranMonth,
				        TranYear,
				        VoucherID,
				        VoucherDate,
				        BatchID,
				        Invoiceno,				         
				        TransactionTypeID,
				        AT9000.CreditObjectID,
				        AT9000.ObjectID,				         
				        CreditAccountID,						 
				        IsWithhodingTax,
				        TableID,
				        CurrencyID,
				        TransactionTypeID,
						TransactionID
		) AT9000 '

SET @sqlSelect4 = ' LEFT JOIN 
				(
					SELECT AT0404.DivisionID,
						    AT0404.CreditVoucherID,
						    AT0404.CreditBatchID,
						    AT0404.CreditTableID,
						    AT0404.AccountID,
						    AT0404.CurrencyID,
						    sum(OriginalAmount) AS OriginalAmountOffset,
						    sum(ConvertedAmount) AS ConvertedAmountOffset,
						    ObjectID
					FROM AT0404 with(nolock)
					GROUP BY AT0404.DivisionID,
						        AT0404.CreditVoucherID,
						        AT0404.CreditBatchID,
						        AT0404.CreditTableID,
						        AT0404.AccountID,
						        AT0404.CurrencyID,
						        ObjectID
				) H ON AT9000.DivisionID = H.DivisionID
						AND AT9000.VoucherID = H.CreditVoucherID
						AND AT9000.BatchID = H.CreditBatchID
						AND AT9000.CreditAccountID = H.AccountID 
						AND AT9000.TableID = H.CreditTableID 
						AND AT9000.CurrencyID = H.CurrencyID
						AND ISNULL(AT9000.ObjectID, '''') = ISNULL(H.ObjectID, ''''))							
			WHERE AT9000.DivisionID = '''+@DivisionID+ ''' ' + @sqlWhere
	
	SET @sqlSelect = '
SELECT CONVERT(TINYINT, 0) AS [Choose], AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, VoucherDate, VoucherNo,
	Serial, InvoiceNo, InvoiceDate, TransactionTypeID, VDescription, BDescription,
	AT9000.ObjectID,
	AT1202.ObjectName,
	AT9000.CreditObjectID,
	A02B.ObjectName AS CreditObjectName,
	AT1202.VATNo,
	AT1202.IsUpdateName, AT9000.CurrencyID, ExchangeRate,
	(CASE WHEN TransactionTypeID IN (''T01'',''T21'') THEN AT9000.CreditAccountID ELSE DebitAccountID END) AccountID,
	(CASE WHEN TransactionTypeID IN (''T01'',''T21'') THEN AT9000.DebitAccountID ELSE CreditAccountID END) AccountID2,
	MAX(AT9000.Ana01ID) Ana01ID, MAX(AT9000.Ana02ID) Ana02ID, MAX(AT9000.Ana03ID) Ana03ID, MAX(AT9000.Ana04ID) Ana04ID, MAX(AT9000.Ana05ID) Ana05ID,
	MAX(AT9000.Ana06ID) Ana06ID, MAX(AT9000.Ana07ID) Ana07ID, MAX(AT9000.Ana08ID) Ana08ID, MAX(AT9000.Ana09ID) Ana09ID, MAX(AT9000.Ana10ID) Ana10ID,
	SUM(OriginalAmount) OriginalAmount, SUM(ConvertedAmount) ConvertedAmount,
	(SELECT SUM(EndOriginalAmount) FROM #Temp 
		WHERE DivisionID = AT9000.DivisionID AND VoucherID = AT9000.VoucherID AND TransactionID = AT9000.TransactionID) EndOriginalAmount,
	(SELECT SUM(EndConvertedAmount) FROM #Temp
		WHERE DivisionID = AT9000.DivisionID AND VoucherID = AT9000.VoucherID AND TransactionID = AT9000.TransactionID) EndConvertedAmount,
	InvoiceCode, InvoiceSign, AT9000.TransactionID
FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID -- Đối tượng nợ
	LEFT JOIN AT1202 A02B WITH (NOLOCK) ON A02B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.CreditObjectID = A02B.ObjectID -- Đối tượng có
WHERE AT9000.DivisionID = '''+@DivisionID+ ''' 
	AND AT9000.ObjectID LIKE '''+@ObjectID+ '''
	AND TransactionID IN (SELECT TransactionID FROM #Temp WHERE DivisionID = '''+@DivisionID+''' AND EndOriginalAmount > 0)
	AND TransactionTypeID = '''+@TransactionTypeID+''' '
	SET @sqlWhere = @sqlWhere + '
	AND (ISNULL(AT9000.VoucherTypeID,''#'') IN '+@ConditionVT+' OR '+@IsUsedConditionVT+')
	AND (ISNULL(AT9000.ObjectID,''#'') IN '+@ConditionOB+' OR '+@IsUsedConditionOB+')'

	SET @sqlWhere = @sqlWhere + '		
GROUP BY AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.TransactionID, AT9000.BatchID, VoucherDate, VoucherNo,
	Serial, InvoiceNo, InvoiceCode, InvoiceSign, InvoiceDate,TransactionTypeID, VDescription,
	BDescription,
	AT9000.ObjectID,
	AT1202.ObjectName,
	AT9000.CreditObjectID,
	A02B.ObjectName,
	AT1202.VATNo, AT1202.IsUpdateName, AT9000.CurrencyID, ExchangeRate,
	(CASE WHEN TransactionTypeID IN (''T01'',''T21'') THEN AT9000.CreditAccountID ELSE DebitAccountID END)
	,(CASE WHEN TransactionTypeID in (''T01'',''T21'') THEN AT9000.DebitAccountID ELSE CreditAccountID END)'
END			
ELSE --  Trường hợp lập phiếu chi
BEGIN

	-- Các bút toán có tài khoản không thuộc nhóm giải trừ (công nợ có quản lí đối tượng)
	SET @sqlSelect1 = '
SELECT AT9000.DivisionID,
		AT9000.VoucherID,
		AT9000.TransactionID,
		ISNULL(OriginalAmount, 0) - ISNULL(OriginalAmountPT, 0) AS EndOriginalAmount,
		ISNULL(ConvertedAmount, 0) - ISNULL(ConvertedAmountPT, 0) AS EndConvertedAmount,
		IsWithhodingTax
INTO #Temp
FROM
(	(SELECT AT9000.DivisionID,
				    TranMonth,
				    TranYear,
				    VoucherID,
				    VoucherDate,
				    BatchID,
				    Invoiceno,
				    TransactionID,
					AT9000.ObjectID,
					AT9000.CreditAccountID,
				    SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount,
				    SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount,
				    IsWithhodingTax,
				    TableID,
				    CurrencyID,
				    TransactionTypeID
			FROM AT9000 WITH (NOLOCK)
			WHERE TransactionTypeID = '''+@TransactionTypeID+'''
			GROUP BY AT9000.DivisionID,
				        TranMonth,
				        TranYear,
				        VoucherID,
				        VoucherDate,
				        BatchID,
				        Invoiceno,
				        TransactionID,
				        TransactionTypeID,
				        AT9000.CreditObjectID,
				        AT9000.ObjectID,
				        AT9000.DebitAccountID,
				        CreditAccountID,
				        IsWithhodingTax,
				        TableID,
				        CurrencyID,
				        TransactionTypeID
		) AT9000 '

-- Các bút toán có tài khoản thuộc nhóm giải trừ (công nợ có quản lí đối tượng)
	SET @sqlSelect2 = '
		LEFT JOIN
			(	SELECT DivisionID, TVoucherID, TBatchID, SUM(OriginalAmountPT) OriginalAmountPT,
					DebitAccountID, SUM(ConvertedAmountPT) AS ConvertedAmountPT, InvoiceNo,ObjectID, ReTransactionID
				FROM (
					SELECT	AT9000.DivisionID, AT9000.TVoucherID, TBatchID, SUM(AT9000.OriginalAmount) OriginalAmountPT,
							AT9000.CreditAccountID AS DebitAccountID, SUM(AT9000.ConvertedAmount) ConvertedAmountPT, InvoiceNo, AT9000.CreditObjectID AS ObjectID, ReTransactionID
					FROM AT9000 WITH (NOLOCK) 
					LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.CreditAccountID = AT1005.AccountID
					WHERE TransactionTypeID = ''T99'' AND ISNULL(TVoucherID, '''') <> '''' 
					GROUP BY AT9000.DivisionID, TVoucherID, TBatchID, InvoiceNo, CreditObjectID, CreditAccountID, ReTransactionID
					UNION ALL
					SELECT	AT9000.DivisionID, AT9000.TVoucherID, TBatchID, SUM(AT9000.OriginalAmount) OriginalAmountPT,
							AT9000.CreditAccountID AS DebitAccountID, SUM(AT9000.ConvertedAmount) ConvertedAmountPT, InvoiceNo, AT9000.ObjectID, ReTransactionID
					FROM AT9000  WITH (NOLOCK)
					LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.CreditAccountID = AT1005.AccountID
					WHERE TransactionTypeID IN (''T01'',''T21'',''T02'',''T22'',''T00'') AND ISNULL(TVoucherID, '''') <> '''' 
					GROUP BY AT9000.DivisionID, TVoucherID, TBatchID, InvoiceNo, ObjectID, CreditAccountID, ReTransactionID
					UNION ALL
					SELECT	AT9000.DivisionID, AT9000.TVoucherID, TBatchID, SUM(AT9000.OriginalAmount) OriginalAmountPT,
							AT9000.DebitAccountID, SUM(AT9000.ConvertedAmount) ConvertedAmountPT, InvoiceNo, AT9000.ObjectID, ReTransactionID
					FROM AT9000 WITH (NOLOCK) 
					LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.CreditAccountID = AT1005.AccountID
					WHERE	TransactionTypeID IN (''T01'',''T21'',''T99'',''T02'',''T22'',''T00'') AND ISNULL(TVoucherID, '''') <> '''' 							
					GROUP BY AT9000.DivisionID, TVoucherID, TBatchID, InvoiceNo, ObjectID, DebitAccountID, ReTransactionID
					) T
				GROUP BY DivisionID, TVoucherID, TBatchID, DebitAccountID, InvoiceNo,ObjectID, ReTransactionID
			)K ON AT9000.DivisionID = K.DivisionID
					AND AT9000.VoucherID = K.TVoucherID
					AND AT9000.BatchID = K.TBatchID
					AND AT9000.TransactionID = K.ReTransactionID
					AND ISNULL(AT9000.ObjectID, '''') = ISNULL(K.ObjectID, '''')
					AND CreditAccountID = DebitAccountID
					AND ISNULL(AT9000.InvoiceNo, '''') = ISNULL(K.InvoiceNo, ''''))
					WHERE AT9000.DivisionID = ''' + @DivisionID+ ''' ' + @sqlWhere + '
					UNION '
SET @sqlSelect3 = ' 
SELECT AT9000.DivisionID,
					AT9000.VoucherID,
					(select top 1 TransactionID from at9000 a9 where a9.voucherid = at9000.voucherid AND a9.batchid = at9000.batchid) AS TransactionID,
					ISNULL(OriginalAmount, 0) - ISNULL(OriginalAmountOffset, 0) EndOriginalAmount,
					ISNULL(ConvertedAmount, 0) - ISNULL(ConvertedAmountOffset, 0) EndConvertedAmount,
					IsWithhodingTax
FROM
	(	(	SELECT AT9000.DivisionID,
				    TranMonth,
				    TranYear,
				    VoucherID,
				    VoucherDate,
				    BatchID,
				    Invoiceno,
					AT9000.ObjectID,
				    CreditAccountID,
				    SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount,
				    SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount,
				    IsWithhodingTax,
				    TableID,
				    CurrencyID,
				    TransactionTypeID
			FROM AT9000 WITH (NOLOCK)
			WHERE TransactionTypeID = '''+@TransactionTypeID+'''
			GROUP BY AT9000.DivisionID,
				        TranMonth,
				        TranYear,
				        VoucherID,
				        VoucherDate,
				        BatchID,
				        Invoiceno,				         
				        TransactionTypeID,
				        AT9000.CreditObjectID,
				        AT9000.ObjectID,				         
				        CreditAccountID,						 
				        IsWithhodingTax,
				        TableID,
				        CurrencyID,
				        TransactionTypeID						 
		) AT9000 '


SET @sqlSelect4 = ' LEFT JOIN 
				(
					SELECT AT0404.DivisionID,
						    AT0404.CreditVoucherID,
						    AT0404.CreditBatchID,
						    AT0404.CreditTableID,
						    AT0404.AccountID,
						    AT0404.CurrencyID,
						    sum(OriginalAmount) AS OriginalAmountOffset,
						    sum(ConvertedAmount) AS ConvertedAmountOffset,
						    ObjectID
					FROM AT0404 with(nolock)
					GROUP BY AT0404.DivisionID,
						        AT0404.CreditVoucherID,
						        AT0404.CreditBatchID,
						        AT0404.CreditTableID,
						        AT0404.AccountID,
						        AT0404.CurrencyID,
						        ObjectID
				) H ON AT9000.DivisionID = H.DivisionID
						AND AT9000.VoucherID = H.CreditVoucherID
						AND AT9000.BatchID = H.CreditBatchID
						AND AT9000.CreditAccountID = H.AccountID 
						AND AT9000.TableID = H.CreditTableID 
						AND AT9000.CurrencyID = H.CurrencyID
						AND ISNULL(AT9000.ObjectID, '''') = ISNULL(H.ObjectID, ''''))							
			WHERE AT9000.DivisionID = '''+@DivisionID+ ''' ' + @sqlWhere


	SET @sqlSelect = '
		SELECT CONVERT(TINYINT, 0) AS [Choose], AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, VoucherDate,
			VoucherNo, Serial, InvoiceNo, InvoiceDate, TransactionTypeID, VDescription, BDescription,
			AT9000.ObjectID,
			AT1202.ObjectName,
			AT9000.CreditObjectID,
			A02B.ObjectName AS CreditObjectName,
			AT1202.VATNo, AT1202.IsUpdateName, AT9000.CurrencyID, ExchangeRate,
			(CASE WHEN TransactionTypeID IN (''T02'',''T22'') THEN AT9000.CreditAccountID ELSE DebitAccountID END) AccountID2,
			(CASE WHEN TransactionTypeID IN (''T02'',''T22'') THEN AT9000.DebitAccountID ELSE CreditAccountID END) AccountID,
			MAX(AT9000.Ana01ID) Ana01ID, MAX(AT9000.Ana02ID) Ana02ID, MAX(AT9000.Ana03ID) Ana03ID, MAX(AT9000.Ana04ID) Ana04ID, MAX(AT9000.Ana05ID) Ana05ID,
			MAX(AT9000.Ana06ID) Ana06ID, MAX(AT9000.Ana07ID) Ana07ID, MAX(AT9000.Ana08ID) Ana08ID, MAX(AT9000.Ana09ID) Ana09ID, MAX(AT9000.Ana10ID) Ana10ID,
			(SELECT SUM(ISNULL(OriginalAmount, 0)) FROM AT9000 A91 WHERE AT9000.VoucherID = A91.VoucherID AND AT9000.TransactionID = A91.TransactionID AND AT9000.BatchID = A91.BatchID AND AT9000.DivisionID = A91.DivisionID) OriginalAmount,
			(SELECT SUM(isnull(ConvertedAmount, 0)) FROM AT9000 A91 WHERE AT9000.VoucherID = A91.Voucherid AND AT9000.TransactionID = A91.TransactionID and at9000.batchid = a91.batchid and at9000.DivisionID = a91.DivisionID)  ConvertedAmount, 
			(SELECT SUM(EndOriginalAmount) FROM #Temp 
				WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = AT9000.VoucherID AND TransactionID = AT9000.TransactionID) EndOriginalAmount,
			(SELECT SUM(EndConvertedAmount) From #Temp 
				WHERE DivisionID = '''+@DivisionID+''' And VoucherID = AT9000.VoucherID AND TransactionID = AT9000.TransactionID) as EndConvertedAmount
		,InvoiceCode,InvoiceSign, ISNULL(IsWithhodingTax, 0) AS IsWithhodingTax, AT9000.TransactionID
		FROM AT9000  WITH (NOLOCK)
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		LEFT JOIN AT1202 A02B WITH (NOLOCK) ON A02B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.CreditObjectID = A02B.ObjectID
		WHERE AT9000.DivisionID = '''+@DivisionID+'''
		AND (CASE WHEN TransactionTypeID = ''T99'' THEN ISNULL(AT9000.CreditObjectID, '''') ELSE ISNULL(AT9000.ObjectID, '''') END) LIKE '''+@ObjectID+'''
		AND TransactionID IN (SELECT TransactionID FROM #Temp WHERE DivisionID = '''+@DivisionID+''' AND EndOriginalAmount > 0)'
--	 and TransactionTypeID = '''+@TransactionTypeID+''''
	SET @sqlWhere = @sqlWhere + '
	AND (ISNULL(AT9000.VoucherTypeID,''#'') IN '+@ConditionVT+' OR '+@IsUsedConditionVT+')
	AND (ISNULL(AT9000.ObjectID,''#'') IN '+@ConditionOB+' OR '+@IsUsedConditionOB+')'
					
	SET @sqlWhere = @sqlWhere + '
	GROUP BY AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.TransactionID, AT9000.BatchID, VoucherDate, VoucherNo,
		Serial, InvoiceNo,InvoiceCode,InvoiceSign, InvoiceDate,TransactionTypeID, VDescription, BDescription, IsWithhodingTax,
		AT9000.ObjectID,
		AT1202.ObjectName,
		AT9000.CreditObjectID,
		A02B.ObjectName,
		AT1202.VATNo, AT1202.IsUpdateName, AT9000.CurrencyID, ExchangeRate,
		(CASE WHEN TransactionTypeID in (''T02'',''T22'') THEN AT9000.CreditAccountID ELSE DebitAccountID END),
		(CASE WHEN TransactionTypeID in (''T02'',''T22'') THEN AT9000.DebitAccountID ELSE CreditAccountID END)
		, AT9000.TransactionID'
END
print @sqlSelect1
print @sqlSelect2
print @sqlSelect3
print @sqlSelect4
print @sqlSelect
print @sqlWhere
EXEC (@sqlSelect1 + @sqlSelect2 + @sqlSelect3 + @sqlSelect4 + @sqlSelect + @sqlWhere)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO