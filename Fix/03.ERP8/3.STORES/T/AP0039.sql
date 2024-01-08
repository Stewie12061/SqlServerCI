IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0039]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0039]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0039
-- <Summary>
---- Stored load lưới master màn hình chọn chứng từ phân bổ nhiều cấp AF0359 (PACIFIC) 
---- Created on 10/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- exec AP0039 @DivisionID=N'PCF',@UserID=N'ASOFTADMIN',@TranMonth=5,@TranYear=2017,@CurrencyID=N'USD',@AllocationLevelID=2

CREATE PROCEDURE [DBO].[AP0039]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@TranMonth AS INT,
	@TranYear AS INT,
	@CurrencyID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50),
	@AllocationLevelID TINYINT
) 
AS


DECLARE @sSQL NVARCHAR(MAX)

IF @AllocationLevelID = 1
BEGIN
	SET @sSQL = N'
	SELECT AT9000.DivisionID, AT9000.VoucherNo, AT9000.VoucherID, AT9000.VoucherDate, N''Cấp 0'' AS AllocationLevelName, MAX(VDescription) AS Description, 
	ISNULL(AT1012.ExchangeRate, AT1004.ExchangeRate) AS ExchangeRate, 
	SUM(AT9000.ConvertedAmount - ISNULL(TB.ConvertedAmount,0)) AS ConvertedAmount, 
	SUM(AT9000.ConvertedAmount) AS OriginalConvertedAmount, SUM(ISNULL(TB.ConvertedAmount,0)) AS AllocatedConvertedAmount
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN
	(
		SELECT DivisionID, ExchangeDate, MAX(ExchangeRate) AS ExchangeRate
		FROM AT1012 WITH (NOLOCK)
		WHERE DivisionID = ''' + @DivisionID + '''
		AND CurrencyID = ''' + @CurrencyID + '''
		GROUP BY DivisionID, ExchangeDate
	) AT1012 ON AT1012.DivisionID = AT9000.DivisionID AND AT1012.ExchangeDate = AT9000.VoucherDate	
	LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''USD''
	LEFT JOIN
	(
		SELECT DivisionID, InheritVoucherID, InheritTransactionID, SUM(ConvertedAmount) AS ConvertedAmount
		FROM AT9001 WITH (NOLOCK)
		WHERE DivisionID = ''' + @DivisionID + '''
		GROUP BY DivisionID, InheritVoucherID, InheritTransactionID
	) TB ON TB.DivisionID = AT9000.DivisionID AND TB.InheritVoucherID = AT9000.VoucherID AND TB.InheritTransactionID = AT9000.TransactionID
	WHERE AT9000.DivisionID = ''' + @DivisionID + '''
	AND (AT9000.DebitAccountID LIKE ''5%'' OR AT9000.CreditAccountID LIKE ''5%'' OR AT9000.DebitAccountID LIKE ''6%'' OR AT9000.CreditAccountID LIKE ''6%'' OR AT9000.DebitAccountID LIKE ''7%'' OR AT9000.CreditAccountID LIKE ''7%'' OR AT9000.DebitAccountID LIKE ''8%'' OR AT9000.CreditAccountID LIKE ''8%'')
	AND AT9000.TransactionTypeID <> ''T98''
	AND AT9000.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	AND AT9000.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '	
	--AND ISNULL(AT9000.IsAudit, 0) = 0
	GROUP BY AT9000.DivisionID, AT9000.VoucherNo, AT9000.VoucherID, AT9000.VoucherDate, ISNULL(AT1012.ExchangeRate, AT1004.ExchangeRate)
	HAVING SUM(AT9000.ConvertedAmount - ISNULL(TB.ConvertedAmount,0)) > 0
	ORDER BY VoucherDate 
	'
END
ELSE
BEGIN
	SET @sSQL = N'
	SELECT AT9005.DivisionID, AT9005.VoucherNo, AT9005.VoucherID, AT9005.VoucherDate, N''Cấp '' + CONVERT(NVARCHAR(5), AT9005.AllocationLevelID) AS AllocationLevelName,
	AT9005.Description, AT9005.ExchangeRate, SUM(AT9001.ConvertedAmount - ISNULL(TB.ConvertedAmount,0)) AS ConvertedAmount,
	SUM(AT9001.ConvertedAmount) AS OriginalConvertedAmount, SUM(ISNULL(TB.ConvertedAmount,0)) AS AllocatedConvertedAmount	
	FROM AT9005 WITH (NOLOCK)
	INNER JOIN AT9001 WITH (NOLOCK) ON AT9001.DivisionID = AT9005.DivisionID AND AT9001.VoucherID = AT9005.VoucherID
	LEFT JOIN
	(
		SELECT DivisionID, InheritVoucherID, InheritTransactionID, SUM(ConvertedAmount) AS ConvertedAmount
		FROM AT9001 WITH (NOLOCK)
		WHERE DivisionID = ''' + @DivisionID + '''
		GROUP BY DivisionID, InheritVoucherID, InheritTransactionID
	) TB ON TB.DivisionID = AT9001.DivisionID AND TB.InheritVoucherID = AT9001.VoucherID AND TB.InheritTransactionID = AT9001.TransactionID
	WHERE AT9005.DivisionID = ''' + @DivisionID + '''
	AND AT9005.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	AND AT9005.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '
	AND AT9005.AllocationLevelID < ' + CONVERT(NVARCHAR(5), @AllocationLevelID) + '
	AND AT9005.VoucherID <> ''' + @VoucherID + '''
	--AND ISNULL(AT9005.IsAudit, 0) = 0	
	GROUP BY AT9005.DivisionID, AT9005.VoucherNo, AT9005.VoucherID, AT9005.VoucherDate, AT9005.AllocationLevelID, AT9005.Description, AT9005.ExchangeRate
	HAVING SUM(AT9001.ConvertedAmount - ISNULL(TB.ConvertedAmount,0)) > 0	
	ORDER BY AllocationLevelID DESC, AT9005.VoucherDate 	
	'
END	

PRINT @sSQL
EXEC (@sSQL) 


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
