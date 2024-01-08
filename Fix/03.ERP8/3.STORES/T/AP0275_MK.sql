IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0275_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0275_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Loc danh sach cong no phai thu/phai tra dau ky (Cusomize Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> T/Nghiep vu THu , CHi/ Ke thua tu nguon khac
---- 
-- <History>
----- Created by Phuong Thao, Date 22/03/2016
----- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
----- Modified by Hải Long on 17/05/2017: Chỉnh sửa danh mục dùng chung
----- Modified by Đức Thông on 23/03/2021: [MEIKO] 2021/03/IS/0193: Fix lỗi merge code
----- Modified by Nhựt Trường on 25/06/2021: Bỏ trường BDescription do khách hàng nhập 2 diễn giải hóa đơn nên ko sum được số tiền cùng chứng từ.
----- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE AP0275_MK
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
DECLARE @sqlSelect NVARCHAR(MAX),
		@sqlSelect1 NVARCHAR(MAX),
		@sqlSelect2 NVARCHAR(MAX),
		@sqlWhere  NVARCHAR(MAX)

SELECT @sqlSelect1 = N'', @sqlSelect2 = N''
IF @IsDate = 0 SET  @sqlWhere = '
	AND TranMonth + TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+' '
ELSE SET @sqlWhere = N'
	AND CONVERT(VARCHAR, VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+''' '

SET @sqlWhere = @sqlWhere + '
	AND (ISNULL(AT9000.VoucherTypeID,''#'') IN '+@ConditionVT+' OR '+@IsUsedConditionVT+')
	AND (ISNULL(AT9000.ObjectID,''#'') IN '+@ConditionOB+' OR '+@IsUsedConditionOB+')'
						
IF @Mode = 0
BEGIN
	SET @sqlSelect1 = N'
	SELECT	Convert(TinyInt, 0) As Choose,
			AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, 
			AT9000.VoucherDate, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
			AT9000.VDescription,
			--AT9000.BDescription,
			AT9000.ObjectID, AT9000.ObjectName, AT9000.VATNo, AT9000.IsUpdateName,
			AT9000.CurrencyID, AT9000.ExchangeRate, AT9000.DebitAccountID as AccountID,
			AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.OriginalAmount, AT9000.ConvertedAmount,
			(AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) AS EndOriginalAmount,
			(AT9000.ConvertedAmount - ISNULL(K.ConvertedAmountOffset,0)) AS EndConvertedAmount,
			AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
	FROM '

	SET @sqlSelect2 = N'
	(	(SELECT AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.DebitAccountID, AT9000.TableID,
				isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
				isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
				AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
				AT9000.VDescription,
				--AT9000.BDescription,
				AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
				AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
				max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
				max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
				AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
		FROM AT9000 with(nolock)
		LEFT JOIN	AT1202  with(nolock) ON	AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		WHERE TransactionTypeID = '''+@TransactionTypeID+'''
			AND	EXISTS (SELECT TOP 1 1 FROM AT1005 WITH (NOLOCK) 
						WHERE AT1005.GroupID = ''G03'' AND AT1005.IsObject = 1 AND AT9000.DebitAccountID = AT1005.AccountID)	
			'+ case when Isnull(@ObjectID,'') <> '' THEN 'AND AT9000.ObjectID Like N'''+@ObjectID+''' 'ELSE '' END+'
			AND AT9000.DivisionID =N'''+@DivisionID+N''''+@sqlWhere+'			
		GROUP BY AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.DebitAccountID, AT9000.TableID,
				AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
				AT9000.VDescription,
				--AT9000.BDescription,
				AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
				AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
		) AT9000 
	
		Left join 
		(
			Select	AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID,
					sum(OriginalAmount) As OriginalAmountOffset, 
					sum(ConvertedAmount) As ConvertedAmountOffset
			From AT0303	with(nolock)	
			Group by AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID
		) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.DebitVoucherID
				AND AT9000.BatchID = K.DebitBatchID AND AT9000.DebitAccountID = K.AccountID 
				and AT9000.TableID = K.DebitTableID AND AT9000.CurrencyID = K.CurrencyID
	)
	WHERE (AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0
	ORDER BY AT9000.VoucherID, AT9000.VoucherDate, AT9000.InvoiceNo
		'		
END
ELSE
BEGIN	
	SET @sqlSelect1 = N'
	SELECT	Convert(TinyInt, 0) As Choose,
			AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, 
			AT9000.VoucherDate, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
			AT9000.VDescription,
			--AT9000.BDescription,
			AT9000.ObjectID, AT9000.ObjectName, AT9000.VATNo, AT9000.IsUpdateName,
			AT9000.CurrencyID, AT9000.ExchangeRate, AT9000.CreditAccountID as AccountID,
			AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.OriginalAmount, AT9000.ConvertedAmount,
			(AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) AS EndOriginalAmount,
			(AT9000.ConvertedAmount - ISNULL(K.ConvertedAmountOffset,0)) AS EndConvertedAmount,
			AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
	FROM
	(	(SELECT AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
				isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
				isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
				AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
				AT9000.VDescription,
				--AT9000.BDescription,
				AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
				AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
				max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
				max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
				AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
		FROM AT9000 with(nolock)
		LEFT JOIN	AT1202  with(nolock) ON	AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		WHERE TransactionTypeID = '''+@TransactionTypeID+'''
			AND	EXISTS (SELECT TOP 1 1 FROM AT1005 WITH (NOLOCK) 
						WHERE AT1005.GroupID = ''G04'' AND AT1005.IsObject = 1 AND AT9000.CreditAccountID = AT1005.AccountID)	
			'+ case when Isnull(@ObjectID,'') <> '' THEN 'AND AT9000.ObjectID Like N'''+@ObjectID+''' 'ELSE '' END+'
			AND AT9000.DivisionID =N'''+@DivisionID+N''''+@sqlWhere+'
			AND  TransactionTypeID <> ''T99''
		GROUP BY AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
				AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
				AT9000.VDescription,
				--AT9000.BDescription,
				AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
				AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax '
		SET @sqlSelect2 = N'
		union all
		SELECT AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
				isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
				isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
				AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
				AT9000.VDescription,
				--AT9000.BDescription,
				AT9000.CreditObjectID AS ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
				AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
				max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
				max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
				AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
		FROM AT9000 with(nolock)
		LEFT JOIN	AT1202  with(nolock) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.CreditObjectID
		WHERE TransactionTypeID = '''+@TransactionTypeID+'''
			AND	EXISTS (SELECT TOP 1 1 FROM AT1005  WITH (NOLOCK)
						WHERE AT1005.GroupID = ''G04'' AND AT1005.IsObject = 1 AND AT9000.CreditAccountID = AT1005.AccountID)	
			'+ case when Isnull(@ObjectID,'') <> '' THEN 'AND AT9000.CreditObjectID Like N'''+@ObjectID+''' 'ELSE '' END+'
			AND AT9000.DivisionID =N'''+@DivisionID+N''''+@sqlWhere+'
			AND  TransactionTypeID = ''T99''
		GROUP BY AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
				AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
				AT9000.VDescription,
				--AT9000.BDescription,
				AT9000.CreditObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
				AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
		) AT9000 
	
		Left join 
		(
			Select	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
					sum(OriginalAmount) As OriginalAmountOffset, 
					sum(ConvertedAmount) As ConvertedAmountOffset
			From AT0404	with(nolock)	
			Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
		) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.CreditVoucherID
				AND AT9000.BatchID = K.CreditBatchID AND AT9000.CreditAccountID = K.AccountID 
				and AT9000.TableID = K.CreditTableID AND AT9000.CurrencyID = K.CurrencyID
	)
	WHERE (AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0
	ORDER BY AT9000.VoucherID, AT9000.VoucherDate, AT9000.InvoiceNo
		'		
END
--print @sqlSelect1
--print @sqlSelect2
EXEC (@sqlSelect1+@sqlSelect2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

