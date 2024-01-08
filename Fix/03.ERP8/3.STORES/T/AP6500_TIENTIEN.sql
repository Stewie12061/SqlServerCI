IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP6500_TIENTIEN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP6500_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Báo cáo luân chuyển tiền tệ.
----- Created by Nguyễn Văn Tài, Date 25/11/2020
----  Modified on 01/04/2021 by Huỳnh Thử  :	Customize [TIENTIEN] -- print nhiều DivisionID


CREATE PROCEDURE [dbo].[AP6500_TIENTIEN]
		@DivisionID AS nvarchar(50),
		@TranMonthFrom1 AS INT,
		@TranYearFrom1 AS INT,
		@TranMonthTo1 AS INT,
		@TranYearTo1 AS INT,
		@ReportCode AS nvarchar(50),
		@AmountUnit AS TINYINT,
		@StrDivisionID AS NVARCHAR(4000) = '',
		@Mode As TINYINT = 0, --Mode = 0: Lấy dữ liệu kỳ trước là kỳ liền kề, Mode = 1 Lấy dữ liệu kỳ trước là cùng kỳ năm trước
		@ReportDate DATETIME = NULL
AS
DECLARE @TranMonthFrom AS INT,
        @TranYearFrom AS INT,
        @TranMonthTo AS INT,
        @TranYearTo AS INT,
        @LastTranMonthTo AS INT,
        @LastTranYearTo AS INT,
        @LastTranMonthTo1 AS INT,
        @LastTranYearTo1 AS INT,
        @ConvertAmountUnit AS DECIMAL(28, 8),
        @AT6502_Cursor AS CURSOR,
        @LineCode AS NVARCHAR(50),
        @LineDescription AS NVARCHAR(250),
        @LineDescriptionE AS NVARCHAR(250),
        @AccountIDFrom AS NVARCHAR(50),
        @AccountIDTo AS NVARCHAR(50),
        @CorAccountIDFrom AS NVARCHAR(50),
        @CorAccountIDTo AS NVARCHAR(50),
        @AmountSign AS TINYINT,
        @D_C AS TINYINT,
        @PeriodAmount AS TINYINT,
        @AccuSign AS NVARCHAR(50),
        @Accumulator AS NVARCHAR(50),
        @PrintStatus AS TINYINT,
        @PrintCode AS NVARCHAR(50),
        @Level AS TINYINT,
        @Notes AS NVARCHAR(250),
        @Space AS INT,
        @DisplayedMark AS TINYINT,
        @AccCaseFlowAnaFrom NVARCHAR(50),
        @AccCaseFlowAnaTo NVARCHAR(50),
        @CorAccCaseFlowAnaFrom NVARCHAR(50),
        @CorAccCaseFlowAnaTo NVARCHAR(50),
        @IsAna TINYINT,
        --Xu ly bien table de tang toc do xu ly
        @AV4201 AS TypeOfAV4201,
        @AV4202 AS TypeOfAV4202,
        @CaseAnaTypeID NVARCHAR(50),
        @ReportDivisionID AS VARCHAR(50),
		@DivisionIDCur AS NVARCHAR(50);

IF(@DivisionID <> 'AA')
BEGIN
	SET @ReportDivisionID = 'AAAAAAAAAA'
END
ELSE
BEGIN
	SET @ReportDivisionID  = @DivisionID
END

DECLARE @StrDivisionID_New AS NVARCHAR(4000)
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + REPLACE(@StrDivisionID, ',',''',''') + ''')' END
    

DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

SELECT @CaseAnaTypeID = ISNULL(CaseFlowAnaTypeID,'') FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID

IF ISNULL(@CaseAnaTypeID,'') <> ''
BEGIN 
	SET @IsAna = 1
	-- AV4201 -----------------------------------------------------------------
	INSERT INTO @AV4201
	(
		DivisionID,
		AccountID,
		ConvertedAmount,
		TranMonth,
		TranYear,
		CorAccountID,
		D_C,
		TransactionTypeID,
		AnaID
	)
	SELECT AT9000.DivisionID,
		   AT9000.DebitAccountID AS AccountID,
		   SUM(AT9000.ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) AS ConvertedAmount,
		   AT9000.TranMonth,
		   AT9000.TranYear,
		   AT9000.CreditAccountID AS CorAccountID, -- tai khoan doi ung  
		   'D' AS D_C,
		   AT9000.TransactionTypeID,
		   CASE
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
				   AT9000.Ana01ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
				   AT9000.Ana02ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
				   AT9000.Ana03ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
				   AT9000.Ana04ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
				   AT9000.Ana05ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
				   AT9000.Ana06ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
				   AT9000.Ana07ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
				   AT9000.Ana08ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
				   AT9000.Ana09ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
				   AT9000.Ana10ID
		   END AS AnaID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE ISNULL(DebitAccountID, '') <> ''
	GROUP BY AT9000.DivisionID,
			 AT9000.DebitAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.CreditAccountID,
			 AT9000.TransactionTypeID,
			 CASE
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
					 AT9000.Ana01ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
					 AT9000.Ana02ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
					 AT9000.Ana03ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
					 AT9000.Ana04ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
					 AT9000.Ana05ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
					 AT9000.Ana06ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
					 AT9000.Ana07ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
					 AT9000.Ana08ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
					 Ana09ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
					 AT9000.Ana10ID
			 END
	UNION ALL  
	------------------- So phat sinh co, lay am  
	SELECT AT9000.DivisionID,
       AT9000.CreditAccountID AS AccountID,
       SUM(AT9000.ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) * -1) AS ConvertedAmount,
       AT9000.TranMonth,
       AT9000.TranYear,
       AT9000.DebitAccountID AS CorAccountID,
       'C' AS D_C,
       AT9000.TransactionTypeID,
       CASE
            WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
				AT9000.Ana01ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
				AT9000.Ana02ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
				AT9000.Ana03ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
				AT9000.Ana04ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
				AT9000.Ana05ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
				AT9000.Ana06ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
				AT9000.Ana07ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
				AT9000.Ana08ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
				Ana09ID
			WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
				AT9000.Ana10ID
       END AS AnaID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE ISNULL(AT9000.CreditAccountID, '') <> ''
	GROUP BY AT9000.DivisionID,
			 AT9000.CreditAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.DebitAccountID,
			 AT9000.TransactionTypeID,
			 CASE WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
			 		AT9000.Ana01ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
			 	 	AT9000.Ana02ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
			 	 	AT9000.Ana03ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
			 	 	AT9000.Ana04ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
			 	 	AT9000.Ana05ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
			 	 	AT9000.Ana06ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
			 	 	AT9000.Ana07ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
			 	 	AT9000.Ana08ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
			 	 	Ana09ID
				  WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
			 	 	AT9000.Ana10ID
				  END;

	--AV4202 -----------------------------------------------------------------
	INSERT INTO @AV4202
	(
		ObjectID,
		CurrencyIDCN,
		VoucherDate,
		InvoiceDate,
		DueDate,
		DivisionID,
		AccountID,
		InventoryID,
		ConvertedAmount,
		OriginalAmount,
		TranMonth,
		TranYear,
		CorAccountID,
		D_C,
		TransactionTypeID,
		AnaID
	)
	SELECT AT9000.ObjectID,                        ---- PHAT SINH NO  
		   AT9000.CurrencyIDCN,
		   AT9000.VoucherDate,
		   AT9000.InvoiceDate,
		   AT9000.DueDate,
		   AT9000.DivisionID,
		   AT9000.DebitAccountID AS AccountID,
		   AT9000.InventoryID,
		   SUM(ISNULL(AT9000.ConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1)) AS ConvertedAmount,
		   SUM(ISNULL(AT9000.OriginalAmountCN, 0)) AS OriginalAmount,
		   AT9000.TranMonth,
		   AT9000.TranYear,
		   AT9000.CreditAccountID AS CorAccountID, -- tai khoan doi ung  
		   'D' AS D_C,
		   AT9000.TransactionTypeID,
		   CASE
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
				   AT9000.Ana01ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
				   AT9000.Ana02ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
				   AT9000.Ana03ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
				   AT9000.Ana04ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
				   AT9000.Ana05ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
				   AT9000.Ana06ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
				   AT9000.Ana07ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
				   AT9000.Ana08ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
				   AT9000.Ana09ID
			   WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
				   AT9000.Ana10ID
		   END AS AnaID
	FROM AT9000 WITH (NOLOCK)
	INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.DebitAccountID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE AT9000.DebitAccountID IS NOT NULL
		  AND AT1005.GroupID IN ( 'G03', 'G04' )
	GROUP BY AT9000.ObjectID,
			 AT9000.Ana01ID,
			 AT9000.CurrencyIDCN,
			 AT9000.VoucherDate,
			 AT9000.InvoiceDate,
			 AT9000.DueDate,
			 AT9000.DivisionID,
			 AT9000.DebitAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.CreditAccountID,
			 AT9000.TransactionTypeID,
			 AT9000.InventoryID,
			 CASE
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
					 Ana01ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
					 Ana02ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
					 Ana03ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
					 Ana04ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
					 Ana05ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
					 Ana06ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
					 Ana07ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
					 Ana08ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
					 Ana09ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
					 Ana10ID
			 END
	UNION ALL  
	------------------- So phat sinh co, lay am  
	SELECT ---- PHAT SINH CO   
    (CASE
         WHEN AT9000.TransactionTypeID = 'T99' THEN
              AT9000.CreditObjectID
         ELSE
              AT9000.ObjectID
     END
    ) AS ObjectID,
    AT9000.CurrencyIDCN,
    AT9000.VoucherDate,
    AT9000.InvoiceDate,
    AT9000.DueDate,
    AT9000.DivisionID,
    AT9000.CreditAccountID AS AccountID,
    AT9000.InventoryID,
    SUM(ISNULL(AT9000.ConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1) * -1) AS ConvertedAmount,
    SUM(ISNULL(AT9000.OriginalAmountCN, 0) * -1) AS OriginalAmount,
    AT9000.TranMonth,
    AT9000.TranYear,
    AT9000.DebitAccountID AS CorAccountID,
    'C' AS D_C,
    AT9000.TransactionTypeID,
    CASE
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
            AT9000.Ana01ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
            AT9000.Ana02ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
            AT9000.Ana03ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
            AT9000.Ana04ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
            AT9000.Ana05ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
            AT9000.Ana06ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
            AT9000.Ana07ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
            AT9000.Ana08ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
            AT9000.Ana09ID
        WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
            AT9000.Ana10ID
    END AS AnaID
	FROM AT9000 WITH (NOLOCK)
	INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE AT9000.CreditAccountID IS NOT NULL
		  AND AT1005.GroupID IN ( 'G03', 'G04' )
	GROUP BY (CASE
				  WHEN AT9000.TransactionTypeID = 'T99' THEN
					   AT9000.CreditObjectID
				  ELSE
					   AT9000.ObjectID
			  END
			 ),
			 AT9000.Ana01ID,
			 AT9000.CurrencyIDCN,
			 AT9000.VoucherDate,
			 AT9000.InvoiceDate,
			 AT9000.DueDate,
			 AT9000.DivisionID,
			 AT9000.CreditAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.DebitAccountID,
			 AT9000.TransactionTypeID,
			 AT9000.InventoryID,
			 CASE
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A01' THEN
					 AT9000.Ana01ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A02' THEN
					 AT9000.Ana02ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A03' THEN
					 AT9000.Ana03ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A04' THEN
					 AT9000.Ana04ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A05' THEN
					 AT9000.Ana05ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A06' THEN
					 AT9000.Ana06ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A07' THEN
					 AT9000.Ana07ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A08' THEN
					 AT9000.Ana08ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A09' THEN
					 Ana09ID
				 WHEN ISNULL(@CaseAnaTypeID, '') = 'A10' THEN
					 Ana10ID
			 END;
END
ELSE
BEGIN
	SET @IsAna = 0
	--AV4201
	INSERT INTO @AV4201
	(
		DivisionID,
		AccountID,
		ConvertedAmount,
		TranMonth,
		TranYear,
		CorAccountID,
		D_C,
		TransactionTypeID
	)
	SELECT AT9000.DivisionID,
		   AT9000.DebitAccountID AS AccountID,
		   SUM(AT9000.ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) AS ConvertedAmount,
		   AT9000.TranMonth,
		   AT9000.TranYear,
		   AT9000.CreditAccountID AS CorAccountID, -- tai khoan doi ung  
		   'D' AS D_C,
		   AT9000.TransactionTypeID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE ISNULL(AT9000.DebitAccountID, '') <> ''
	GROUP BY AT9000.DivisionID,
			 AT9000.DebitAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.CreditAccountID,
			 AT9000.TransactionTypeID
	UNION ALL
	------------------- So phat sinh co, lay am  
	SELECT AT9000.DivisionID,
		   AT9000.CreditAccountID AS AccountID,
		   SUM(AT9000.ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) * -1) AS ConvertedAmount,
		   AT9000.TranMonth,
		   AT9000.TranYear,
		   AT9000.DebitAccountID AS CorAccountID,
		   'C' AS D_C,
		   AT9000.TransactionTypeID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE ISNULL(AT9000.CreditAccountID, '') <> ''
	GROUP BY AT9000.DivisionID,
			 AT9000.CreditAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.DebitAccountID,
			 AT9000.TransactionTypeID;

	--AV4202
	INSERT INTO @AV4202
	(
		ObjectID,
		CurrencyIDCN,
		VoucherDate,
		InvoiceDate,
		DueDate,
		DivisionID,
		AccountID,
		InventoryID,
		ConvertedAmount,
		OriginalAmount,
		TranMonth,
		TranYear,
		CorAccountID,
		D_C,
		TransactionTypeID
	)
	SELECT AT9000.ObjectID,                        ---- PHAT SINH NO  
		   AT9000.CurrencyIDCN,
		   AT9000.VoucherDate,
		   AT9000.InvoiceDate,
		   AT9000.DueDate,
		   AT9000.DivisionID,
		   AT9000.DebitAccountID AS AccountID,
		   AT9000.InventoryID,
		   SUM(ISNULL(AT9000.ConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1)) AS ConvertedAmount,
		   SUM(ISNULL(AT9000.OriginalAmountCN, 0)) AS OriginalAmount,
		   AT9000.TranMonth,
		   AT9000.TranYear,
		   AT9000.CreditAccountID AS CorAccountID, -- tai khoan doi ung  
		   'D' AS D_C,
		   AT9000.TransactionTypeID
	FROM AT9000 WITH (NOLOCK)
	INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.DebitAccountID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE AT9000.DebitAccountID IS NOT NULL
		  AND AT1005.GroupID IN ( 'G03', 'G04' )
	GROUP BY AT9000.ObjectID,
			 AT9000.Ana01ID,
			 AT9000.CurrencyIDCN,
			 AT9000.VoucherDate,
			 AT9000.InvoiceDate,
			 AT9000.DueDate,
			 AT9000.DivisionID,
			 AT9000.DebitAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.CreditAccountID,
			 AT9000.TransactionTypeID,
			 AT9000.InventoryID
	UNION ALL
	------------------- So phat sinh co, lay am  
	SELECT ---- PHAT SINH CO   
		(CASE
			 WHEN AT9000.TransactionTypeID = 'T99' THEN
				  AT9000.CreditObjectID
			 ELSE
				 AT9000.ObjectID
		 END
		) AS ObjectID,
		AT9000.CurrencyIDCN,
		AT9000.VoucherDate,
		AT9000.InvoiceDate,
		AT9000.DueDate,
		AT9000.DivisionID,
		AT9000.CreditAccountID AS AccountID,
		AT9000.InventoryID,
		SUM(ISNULL(AT9000.ConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1) * -1) AS ConvertedAmount,
		SUM(ISNULL(AT9000.OriginalAmountCN, 0) * -1) AS OriginalAmount,
		AT9000.TranMonth,
		AT9000.TranYear,
		AT9000.DebitAccountID AS CorAccountID,
		'C' AS D_C,
		AT9000.TransactionTypeID
	FROM AT9000 WITH (NOLOCK)
	INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID
											AND AT1012.DivisionID = @ReportDivisionID
											AND AT1012.ExchangeDate = @ReportDate
	WHERE AT9000.CreditAccountID IS NOT NULL
		  AND AT1005.GroupID IN ( 'G03', 'G04' )
	GROUP BY (CASE
				  WHEN AT9000.TransactionTypeID = 'T99' THEN
					   AT9000.CreditObjectID
				  ELSE
					  AT9000.ObjectID
			  END
			 ),
			 AT9000.Ana01ID,
			 AT9000.CurrencyIDCN,
			 AT9000.VoucherDate,
			 AT9000.InvoiceDate,
			 AT9000.DueDate,
			 AT9000.DivisionID,
			 AT9000.CreditAccountID,
			 AT9000.TranMonth,
			 AT9000.TranYear,
			 AT9000.DebitAccountID,
			 AT9000.TransactionTypeID,
			 AT9000.InventoryID;
END 

DELETE AT6503 
--WHERE DivisionID = @DivisionID

IF @Mode = 0 
BEGIN

		IF @TranMonthFrom1 > 1
			BEGIN	---- Thang truoc do; nam cua ky truoc do
			SET @TranMonthTo = @TranMonthFrom1 -1
			SET @TranYearTo = @TranYearFrom1
			END
		ELSE
			BEGIN
			SET @TranMonthTo = 12
			SET @TranYearTo = @TranYearFrom1 -1
			END

		------- Xac dinh ky truoc ch­a chÝnh x¸c
		Set @Space =(@TranMonthTo1+@TranYearTo1*12) -  (@TranMonthFrom1+@TranYearFrom1*12)

		--Print ' KC :'+str(@Space)
		Set @Space=(@TranMonthTo+12*@TranYearTo)-@Space

		---Print str(@Space)
		If @Space%12 =0 
		Begin
			set @TranYearFrom = @Space/12 -1
			Set @TranMonthFrom=12
		End
		Else
		Begin
			set @TranYearFrom = @Space/12
			Set @TranMonthFrom=@Space%12
		End
END
ELSE 
	BEGIN
		SET @TranMonthFrom = @TranMonthFrom1
		SET @TranYearFrom = @TranYearFrom1 - 1
		SET @TranMonthTo = @TranMonthTo1
		SET @TranYearTo = @TranYearTo1 - 1
	END

--Print 'tu: '+str(@TranMonthFrom)+'/'+str(@TranYearFrom)+' den: '++str(@TranMonthTo)+'/'+str(@TranYearTo)

SET @ConvertAmountUnit =1

IF @AmountUnit = 1 SET @ConvertAmountUnit = 1
IF @AmountUnit = 2 SET @ConvertAmountUnit = 10
IF @AmountUnit = 3 SET @ConvertAmountUnit = 100
IF @AmountUnit = 4 SET @ConvertAmountUnit = 1000
IF @AmountUnit = 5 SET @ConvertAmountUnit = 10000
IF @AmountUnit = 6 SET @ConvertAmountUnit = 100000
IF @AmountUnit = 7 SET @ConvertAmountUnit = 1000000

---- Buoc 1: Insert gia tri vao bang tam

SET @AT6502_Cursor = CURSOR SCROLL KEYSET FOR
						SELECT T32.DivisionID,
							   T32.LineCode,
							   T32.LineDescription,
							   T32.LineDescriptionE,
							   T32.PrintStatus,
							   T32.AccuSign,
							   T32.Accumulator,
							   T32.PrintCode,
							   ISNULL(Level1, 3),
							   T32.Notes,
							   T32.DisplayedMark
						FROM AT6502 AS T32
						WHERE T32.ReportCode = @ReportCode
							  AND DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)

OPEN @AT6502_Cursor
FETCH NEXT FROM @AT6502_Cursor INTO
			@DivisionIDCur, @LineCode,		@LineDescription, 	@LineDescriptionE, 	@PrintStatus,		@AccuSign,	
			@Accumulator,		@PrintCode,  @Level,	@Notes, @DisplayedMark
WHILE @@FETCH_STATUS = 0
    BEGIN
	
	INSERT INTO AT6503  (DivisionID, 
		LineCode,		LineDescription,	LineDescriptionE,		PrintStatus, 		
		Amount1,		Amount2,  	
		AccuSign,		Accumulator,		PrintCode, 				Level1,			Notes, DisplayedMark
		)
	    VALUES ( @DivisionIDCur,
		@LineCode,		@LineDescription,	@LineDescriptionE, 		@PrintStatus,		
		0,				0,
		@AccuSign,		@Accumulator,		@PrintCode ,			@Level,			@Notes	, @DisplayedMark	
		)     	

	FETCH NEXT FROM @AT6502_Cursor INTO
			@DivisionIDCur, @LineCode,		@LineDescription, 	@LineDescriptionE, 	@PrintStatus,		@AccuSign,	@Accumulator,
			@PrintCode,		@Level,				@Notes, @DisplayedMark
    END
CLOSE @AT6502_Cursor
DEALLOCATE @AT6502_Cursor

---------- Buoc 2: Xu ly so lieu tung dong.


SET @DivisionIDCur = ''
DECLARE @Amount1 AS decimal(28, 8),		
		@Amount2 AS decimal(28, 8)		

SET @AT6502_Cursor = CURSOR SCROLL KEYSET FOR
						SELECT T32.DivisionID,
							   T32.LineCode,
							   T32.AccountIDFrom,
							   T32.AccountIDTo,
							   T32.CorAccountIDFrom,
							   T32.CorAccountIDTo,
							   T32.D_C,
							   T32.AmountSign,
							   T32.AccuSign,
							   T32.Accumulator,
							   T32.PeriodAmount,
							   T32.AccCaseFlowAnaFrom,
							   T32.AccCaseFlowAnaTo,
							   T32.CorAccCaseFlowAnaFrom,
							   T32.CorAccCaseFlowAnaTo
						FROM AT6502 AS T32
						WHERE T32.ReportCode = @ReportCode
							  AND DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)
			
/*			
Print ltrim(@TranMonthFrom1) + '/' + ltrim(@TranYearFrom1)
Print ltrim(@TranMonthTo1) + '/' + ltrim(@TranYearTo1)
Print ltrim(@TranMonthFrom) + '/' + ltrim(@TranYearFrom)
Print ltrim(@TranMonthTo) + '/' + ltrim(@TranYearTo)
*/

OPEN @AT6502_Cursor
FETCH NEXT FROM @AT6502_Cursor INTO
			@DivisionIDCur, @LineCode,		@AccountIDFrom,	@AccountIDTo,		@CorAccountIDFrom,	
			@CorAccountIDTo,	@D_C,			@AmountSign,		@AccuSign,
			@Accumulator,		@PeriodAmount, @AccCaseFlowAnaFrom, @AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo
WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @Amount1 = 0
	SET @Amount2 = 0
	
	IF @PeriodAmount = 2   --- So dau nam
	    BEGIN
			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom1,
						  @TranYearFrom1,
						  @TranMonthTo1,
						  @TranYearTo1,
						  1,
						  @D_C,
						  @OutputAmount = @Amount1 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;

			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom,
						  @TranYearFrom,
						  @TranMonthTo,
						  @TranYearTo,
						  1,
						  @D_C,
						  @OutputAmount = @Amount2 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;
	    END	
	    
	IF @PeriodAmount = 0   --- So cuoi nam
	    BEGIN
			IF @AmountSign In (0,1)
			BEGIN
				EXEC AP760301 @DivisionIDCur,
							  @AccountIDFrom,
							  @AccountIDTo,
							  @CorAccountIDFrom,
							  @CorAccountIDTo,
							  @TranMonthFrom1,
							  @TranYearFrom1,
							  @TranMonthTo1,
							  @TranYearTo1,
							  7,
							  @D_C,
							  @OutputAmount = @Amount1 OUTPUT,
							  @StrDivisionID = @DivisionIDCur,
							  @AV4201 = @AV4201,
							  @AV4202 = @AV4202,
							  @IsAna = @IsAna,
							  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
							  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
							  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
							  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;

				EXEC AP760301 @DivisionIDCur,
							  @AccountIDFrom,
							  @AccountIDTo,
							  @CorAccountIDFrom,
							  @CorAccountIDTo,
							  @TranMonthFrom,
							  @TranYearFrom,
							  @TranMonthTo,
							  @TranYearTo,
							  7,
							  @D_C,
							  @OutputAmount = @Amount2 OUTPUT,
							  @StrDivisionID = @DivisionIDCur,
							  @AV4201 = @AV4201,
							  @AV4202 = @AV4202,
							  @IsAna = @IsAna,
							  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
							  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
							  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
							  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;
			END
						
			IF @AmountSign = 2
			BEGIN
				EXEC AP760301 @DivisionIDCur,
							  @AccountIDFrom,
							  @AccountIDTo,
							  @CorAccountIDFrom,
							  @CorAccountIDTo,
							  @TranMonthFrom1,
							  @TranYearFrom1,
							  @TranMonthTo1,
							  @TranYearTo1,
							  6,
							  @D_C,
							  @OutputAmount = @Amount1 OUTPUT,
							  @StrDivisionID = @DivisionIDCur,
							  @AV4201 = @AV4201,
							  @AV4202 = @AV4202,
							  @IsAna = @IsAna,
							  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
							  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
							  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
							  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;

				EXEC AP760301 @DivisionIDCur,
							  @AccountIDFrom,
							  @AccountIDTo,
							  @CorAccountIDFrom,
							  @CorAccountIDTo,
							  @TranMonthFrom,
							  @TranYearFrom,
							  @TranMonthTo,
							  @TranYearTo,
							  6,
							  @D_C,
							  @OutputAmount = @Amount2 OUTPUT,
							  @StrDivisionID = @DivisionIDCur,
							  @AV4201 = @AV4201,
							  @AV4202 = @AV4202,
							  @IsAna = @IsAna,
							  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
							  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
							  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
							  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;
			END
	    END	

	IF @PeriodAmount = 1 ---- So trong ky	
	    BEGIN
		IF @AmountSign = 0	---- Phat sinh Co
		    BEGIN
			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom1,
						  @TranYearFrom1,
						  @TranMonthTo1,
						  @TranYearTo1,
						  5,
						  @D_C,
						  @OutputAmount = @Amount1 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;

			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom,
						  @TranYearFrom,
						  @TranMonthTo,
						  @TranYearTo,
						  5,
						  @D_C,
						  @OutputAmount = @Amount2 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;
		    END
		IF @AmountSign = 1   	 --- Phat sinh No
		    BEGIN
			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom1,
						  @TranYearFrom1,
						  @TranMonthTo1,
						  @TranYearTo1,
						  4,
						  @D_C,
						  @OutputAmount = @Amount1 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;

			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom,
						  @TranYearFrom,
						  @TranMonthTo,
						  @TranYearTo,
						  4,
						  @D_C,
						  @OutputAmount = @Amount2 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;
		    END
		IF @AmountSign = 2   --- Ca hai
		    BEGIN
			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom1,
						  @TranYearFrom1,
						  @TranMonthTo1,
						  @TranYearTo1,
						  3,
						  @D_C,
						  @OutputAmount = @Amount1 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;

			EXEC AP760301 @DivisionIDCur,
						  @AccountIDFrom,
						  @AccountIDTo,
						  @CorAccountIDFrom,
						  @CorAccountIDTo,
						  @TranMonthFrom,
						  @TranYearFrom,
						  @TranMonthTo,
						  @TranYearTo,
						  3,
						  @D_C,
						  @OutputAmount = @Amount2 OUTPUT,
						  @StrDivisionID = @DivisionIDCur,
						  @AV4201 = @AV4201,
						  @AV4202 = @AV4202,
						  @IsAna = @IsAna,
						  @AccCaseFlowAnaFrom = @AccCaseFlowAnaFrom,
						  @AccCaseFlowAnaTo = @AccCaseFlowAnaTo,
						  @CorAccCaseFlowAnaFrom = @CorAccCaseFlowAnaFrom,
						  @CorAccCaseFlowAnaTo = @CorAccCaseFlowAnaTo;
		    END
	    END
	
	
	SET @Amount1 = @Amount1/@ConvertAmountUnit
	SET @Amount2 = @Amount2/@ConvertAmountUnit

	IF (@Amount1<>0 OR @Amount2<>0)
		EXEC AP6501 @DivisionIDCur,
					@ReportCode,
					@LineCode,
					@Amount2,
					@Amount1,
					'+',
					@LineCode	

	FETCH NEXT FROM @AT6502_Cursor
					INTO @DivisionIDCur,
						 @LineCode,
						 @AccountIDFrom,
						 @AccountIDTo,
						 @CorAccountIDFrom,
						 @CorAccountIDTo,
						 @D_C,
						 @AmountSign,
						 @AccuSign,
						 @Accumulator,
						 @PeriodAmount,
						 @AccCaseFlowAnaFrom,
						 @AccCaseFlowAnaTo,
						 @CorAccCaseFlowAnaFrom,
						 @CorAccCaseFlowAnaTo;
    END

CLOSE @AT6502_Cursor

DEALLOCATE @AT6502_Cursor
DELETE A00007 WHERE SPID = @@SPID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
