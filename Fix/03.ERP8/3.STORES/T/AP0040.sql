IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0040
-- <Summary>
---- Stored load lưới detail màn hình chọn chứng từ phân bổ nhiều cấp AF0359 (PACIFIC) 
---- Created on 12/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0040 @DivisionID=N'PCF',@UserID=N'ASOFTADMIN',@TranMonth=4,@TranYear=2017,@CurrencyID=N'USD',@AllocationLevelID=1, @VoucherID = 'AV2017000000028'
---- EXEC AP0040 @DivisionID=N'PCF',@UserID=N'ASOFTADMIN',@TranMonth=5,@TranYear=2017,@CurrencyID=N'USD',@AllocationLevelID=5, @VoucherID = 'd8769561-ada8-493b-ac53-c53145c3348e'

CREATE PROCEDURE [DBO].[AP0040]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@TranMonth AS INT,
	@TranYear AS INT,
	@CurrencyID AS NVARCHAR(50),
	@AllocationLevelID TINYINT,
	@VoucherID AS NVARCHAR(50)
) 
AS


DECLARE @sSQL NVARCHAR(MAX)

IF @AllocationLevelID = 1
BEGIN
	SET @sSQL = N'
	SELECT AT9000.DivisionID, AT9000.TransactionID AS InheritTransactionID, AT9000.VoucherID AS InheritVoucherID, AT9000.VoucherNo AS InheritVoucherNo, 
	AT9000.VoucherID AS OriginalInheritVoucherID, AT9000.VoucherDate AS OriginalInheritVoucherDate, NULL AS AnaID, NULL AS AnaName, 
	AT9000.DebitAccountID, AT9000.CreditAccountID, ISNULL(AT1012.ExchangeRate, AT1004.ExchangeRate) AS ExchangeRate, AT9000.ConvertedAmount
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN
	(
		SELECT DivisionID, ExchangeDate, MAX(ExchangeRate) AS ExchangeRate
		FROM AT1012 WITH (NOLOCK)
		WHERE DivisionID = ''' + @DivisionID + '''
		AND CurrencyID = ''' + @CurrencyID + '''
		GROUP BY DivisionID, ExchangeDate
	) AT1012 ON AT1012.DivisionID = AT9000.DivisionID AND AT1012.ExchangeDate = AT9000.VoucherDate	
	LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + '''
	LEFT JOIN
	(
		SELECT DivisionID, InheritVoucherID, InheritTransactionID
		FROM AT9001 WITH (NOLOCK)
		WHERE DivisionID = ''' + @DivisionID + '''
		GROUP BY DivisionID, InheritVoucherID, InheritTransactionID
	) TB ON TB.DivisionID = AT9000.DivisionID AND TB.InheritVoucherID = AT9000.VoucherID AND TB.InheritTransactionID = AT9000.TransactionID 
	WHERE AT9000.DivisionID = ''' + @DivisionID + '''
	AND (AT9000.DebitAccountID LIKE ''5%'' OR AT9000.CreditAccountID LIKE ''5%'' OR AT9000.DebitAccountID LIKE ''6%'' OR AT9000.CreditAccountID LIKE ''6%'' OR AT9000.DebitAccountID LIKE ''7%'' OR AT9000.CreditAccountID LIKE ''7%'' OR AT9000.DebitAccountID LIKE ''8%'' OR AT9000.CreditAccountID LIKE ''8%'')
	AND AT9000.TransactionTypeID <> ''T98''
	AND AT9000.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	AND AT9000.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '
	AND AT9000.ConvertedAmount > 0	
	AND AT9000.VoucherID = ''' + @VoucherID + '''
	AND TB.DivisionID IS NULL 
	ORDER BY AT9000.Orders 
	'
END
ELSE
BEGIN
	SET @sSQL = N'
	SELECT AT9005.DivisionID, AT9001.TransactionID AS InheritTransactionID, AT9005.VoucherID AS InheritVoucherID, AT9005.VoucherNo AS InheritVoucherNo, 
	AT9005.OriginalInheritVoucherID, AT9005.OriginalInheritVoucherDate, 
	(CASE WHEN AT9001.AnaTypeID = ''A01'' THEN AT9001.Ana01ID 
		  WHEN AT9001.AnaTypeID = ''A02'' THEN AT9001.Ana02ID 
		  WHEN AT9001.AnaTypeID = ''A03'' THEN AT9001.Ana03ID 
		  WHEN AT9001.AnaTypeID = ''A04'' THEN AT9001.Ana04ID 
		  WHEN AT9001.AnaTypeID = ''A05'' THEN AT9001.Ana05ID 
		  WHEN AT9001.AnaTypeID = ''A06'' THEN AT9001.Ana06ID 
		  WHEN AT9001.AnaTypeID = ''A07'' THEN AT9001.Ana07ID 
		  WHEN AT9001.AnaTypeID = ''A08'' THEN AT9001.Ana08ID 
		  WHEN AT9001.AnaTypeID = ''A09'' THEN AT9001.Ana09ID ELSE AT9001.Ana10ID END) AS AnaID, AT1011.AnaName,
	AT9001.DebitAccountID, AT9001.CreditAccountID, AT9005.ExchangeRate, AT9001.ConvertedAmount	  
	FROM AT9005 WITH (NOLOCK)
	INNER JOIN AT9001 WITH (NOLOCK) ON AT9001.DivisionID = AT9005.DivisionID AND AT9001.VoucherID = AT9005.VoucherID
	LEFT JOIN
	(
		SELECT DivisionID, InheritVoucherID, InheritTransactionID
		FROM AT9001 WITH (NOLOCK)
		WHERE DivisionID = ''' + @DivisionID + '''
		GROUP BY DivisionID, InheritVoucherID, InheritTransactionID
	) TB ON TB.DivisionID = AT9001.DivisionID AND TB.InheritVoucherID = AT9001.VoucherID AND TB.InheritTransactionID = AT9001.TransactionID
	LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.AnaTypeID = AT9001.AnaTypeID 
	AND AT1011.AnaID = CASE WHEN AT9001.AnaTypeID = ''A01'' THEN AT9001.Ana01ID 
							WHEN AT9001.AnaTypeID = ''A02'' THEN AT9001.Ana02ID 
							WHEN AT9001.AnaTypeID = ''A03'' THEN AT9001.Ana03ID 
							WHEN AT9001.AnaTypeID = ''A04'' THEN AT9001.Ana04ID 
							WHEN AT9001.AnaTypeID = ''A05'' THEN AT9001.Ana05ID 
							WHEN AT9001.AnaTypeID = ''A06'' THEN AT9001.Ana06ID 
							WHEN AT9001.AnaTypeID = ''A07'' THEN AT9001.Ana07ID 
							WHEN AT9001.AnaTypeID = ''A08'' THEN AT9001.Ana08ID 
							WHEN AT9001.AnaTypeID = ''A09'' THEN AT9001.Ana09ID ELSE AT9001.Ana10ID END	
	WHERE AT9005.DivisionID = ''' + @DivisionID + '''
	AND AT9005.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	AND AT9005.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '
	AND AT9001.ConvertedAmount > 0	
	AND AT9005.AllocationLevelID < ' + CONVERT(NVARCHAR(5), @AllocationLevelID) + '
	AND AT9005.VoucherID = ''' + @VoucherID + '''	
	AND TB.DivisionID IS NULL 
	ORDER BY AT9001.Orders
	'
END	

PRINT @sSQL
EXEC (@sSQL) 



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
