IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0054]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0054]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0054
-- <Summary>
---- Stored Xử lý phân bổ nhiều cấp (PACIFIC)
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
---- EXEC AP0054 @DivisionID = 'PCF', @UserID = 'ASOFTADMIN', @AllocationLevelID = 2

CREATE PROCEDURE [DBO].[AP0054]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@Orders AS INT,
	@AllocationID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50),
	@TransactionID AS NVARCHAR(50),
	@CurrencyID AS NVARCHAR(50),	
	@ExchangeRate AS DECIMAL(28)	
) 
AS

DECLARE @AllocationType TINYINT,
		@AllocationLevelID TINYINT,
		@TotalEmployeeNumber DECIMAL(28),
		@RowOrders INT,
		@ConvertedAmount DECIMAL(28, 8),
		@sSQL NVARCHAR(MAX)	= '',	
		@sSQL2 NVARCHAR(MAX) = ''			


SELECT @AllocationType = AllocationType, @AllocationLevelID = AllocationLevelID
FROM AT1610 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND AllocationID = @AllocationID

-- Số thứ tự dòng cuối cùng
SELECT @RowOrders = MAX(Orders) 
FROM AT1611 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND AllocationID = @AllocationID	

-- Số số tiền phân bổ
IF @AllocationLevelID = 1
BEGIN
	SELECT @ConvertedAmount = ConvertedAmount 
	FROM AT9000 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND VoucherID = @VoucherID
	AND TransactionID = @TransactionID	
END
ELSE 
BEGIN
	SELECT @ConvertedAmount = ConvertedAmount 
	FROM AT9001 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND VoucherID = @VoucherID
	AND TransactionID = @TransactionID		
END


IF @AllocationLevelID = 1 -- Trường hợp phân bổ cấp 1: Lấy các chứng từ ở AT9000
BEGIN
	IF @AllocationType = 1 -- Phân bổ theo tỉ lệ
	BEGIN
		SET @sSQL = '
		SELECT AT1611.DivisionID, ' + CONVERT(NVARCHAR(5), @Orders) + ' AS MasterOrders, AT1611.Orders, AT9000.TransactionID AS InheritTransactionID, AT9000.VoucherID AS InheritVoucherID,
		AT1611.AllocationID, AT1610.AllocationType, 
		AT1611.AnaID, AT1611.AnaTypeID, AT1011.AnaName, AT9000.DebitAccountID, AT9000.CreditAccountID, 
		(CASE WHEN AT1611.AnaTypeID = ''A01'' THEN AT1611.AnaID ELSE NULL END) AS Ana01ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A02'' THEN AT1611.AnaID ELSE NULL END) AS Ana02ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A03'' THEN AT1611.AnaID ELSE NULL END) AS Ana03ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A04'' THEN AT1611.AnaID ELSE NULL END) AS Ana04ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A05'' THEN AT1611.AnaID ELSE NULL END) AS Ana05ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A06'' THEN AT1611.AnaID ELSE NULL END) AS Ana06ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A07'' THEN AT1611.AnaID ELSE NULL END) AS Ana07ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A08'' THEN AT1611.AnaID ELSE NULL END) AS Ana08ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A09'' THEN AT1611.AnaID ELSE NULL END) AS Ana09ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A10'' THEN AT1611.AnaID ELSE NULL END) AS Ana10ID, 
		CONVERT(DECIMAL(28,8), ROUND(AT9000.ConvertedAmount*(PercentRate/100), AT1101.ConvertedDecimals)) AS ConvertedAmount,
		CONVERT(DECIMAL(28,8), ROUND(AT9000.ConvertedAmount*(PercentRate/100)/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)) AS OriginalAmount,
		AT9000.InventoryID, AT9000.UnitID, AT9000.BatchID, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID, AT9000.TransactionTypeID
		INTO #TEMP		
		FROM AT1611 WITH (NOLOCK)
		INNER JOIN AT1610 ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID
		INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT1611.DivisionID
		LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = AT1611.DivisionID AND AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + '''
		WHERE AT1611.DivisionID = ''' + @DivisionID + '''
		AND AT1611.AllocationID = ''' + @AllocationID + '''
		AND AT9000.VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionID = ''' + @TransactionID + '''
		ORDER BY AT1611.Orders'
		
		SET @sSQL2 = '
		UPDATE #TEMP
		SET ConvertedAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0), AT1101.ConvertedDecimals),
			OriginalAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0)/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)
		FROM #TEMP	
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #TEMP.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + ''' 
		WHERE #TEMP.Orders = ' + CONVERT(NVARCHAR(5), @RowOrders) + ' 	
		
		SELECT * FROM #TEMP			
		'		
	END
	ELSE
	IF @AllocationType = 2 -- Phân bổ theo số lượng nhân viên
	BEGIN	
		-- Lấy số lượng tổng nhân viên được khai báo
		SELECT @TotalEmployeeNumber = SUM(EmployeeNumber)  
		FROM AT1611 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID
		AND AllocationID = @AllocationID			
		
		SET @sSQL = '
		SELECT AT1611.DivisionID, ' + CONVERT(NVARCHAR(5), @Orders) + ' AS MasterOrders, AT1611.Orders, AT9000.TransactionID AS InheritTransactionID, AT9000.VoucherID AS InheritVoucherID,
		AT1611.AllocationID, AT1610.AllocationType, 
		AT1611.AnaID, AT1611.AnaTypeID, AT1011.AnaName, AT9000.DebitAccountID, AT9000.CreditAccountID, 
		(CASE WHEN AT1611.AnaTypeID = ''A01'' THEN AT1611.AnaID ELSE NULL END) AS Ana01ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A02'' THEN AT1611.AnaID ELSE NULL END) AS Ana02ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A03'' THEN AT1611.AnaID ELSE NULL END) AS Ana03ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A04'' THEN AT1611.AnaID ELSE NULL END) AS Ana04ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A05'' THEN AT1611.AnaID ELSE NULL END) AS Ana05ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A06'' THEN AT1611.AnaID ELSE NULL END) AS Ana06ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A07'' THEN AT1611.AnaID ELSE NULL END) AS Ana07ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A08'' THEN AT1611.AnaID ELSE NULL END) AS Ana08ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A09'' THEN AT1611.AnaID ELSE NULL END) AS Ana09ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A10'' THEN AT1611.AnaID ELSE NULL END) AS Ana10ID, 
		CONVERT(DECIMAL(28,8), ROUND(AT9000.ConvertedAmount*(EmployeeNumber/' + CONVERT(NVARCHAR(30), @TotalEmployeeNumber) + '), AT1101.ConvertedDecimals)) AS ConvertedAmount, 
		CONVERT(DECIMAL(28,8), ROUND(AT9000.ConvertedAmount*(EmployeeNumber/' + CONVERT(NVARCHAR(30),@TotalEmployeeNumber) + ')/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)) AS OriginalAmount,		
		AT9000.InventoryID, AT9000.UnitID, AT9000.BatchID, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID, AT9000.TransactionTypeID
		INTO #TEMP
		FROM AT1611 WITH (NOLOCK)
		INNER JOIN AT1610 ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID		
		INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT1611.DivisionID
		LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = AT1611.DivisionID AND AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9000.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + ''' 
		WHERE AT1611.DivisionID = ''' + @DivisionID + '''
		AND AT1611.AllocationID = ''' + @AllocationID + '''
		AND AT9000.VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionID = ''' + @TransactionID + '''
		ORDER BY AT1611.Orders'	
		
		SET @sSQL2 = '
		UPDATE #TEMP
		SET ConvertedAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0), AT1101.ConvertedDecimals),
			OriginalAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0)/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)
		FROM #TEMP	
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #TEMP.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + ''' 
		WHERE #TEMP.Orders = ' + CONVERT(NVARCHAR(5), @RowOrders) + ' 	
		
		SELECT * FROM #TEMP			
		'		
	END
	ELSE -- Phân bổ theo số lượng ấn định
	BEGIN
		SET @sSQL = '		
		SELECT AT1611.DivisionID, ' + CONVERT(NVARCHAR(5), @Orders) + ' AS MasterOrders, AT1611.Orders, AT9000.TransactionID AS InheritTransactionID, AT9000.VoucherID AS InheritVoucherID,
		AT1611.AllocationID, AT1610.AllocationType, 
		AT1611.AnaID, AT1611.AnaTypeID, AT1011.AnaName, AT9000.DebitAccountID, AT9000.CreditAccountID, 
		(CASE WHEN AT1611.AnaTypeID = ''A01'' THEN AT1611.AnaID ELSE NULL END) AS Ana01ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A02'' THEN AT1611.AnaID ELSE NULL END) AS Ana02ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A03'' THEN AT1611.AnaID ELSE NULL END) AS Ana03ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A04'' THEN AT1611.AnaID ELSE NULL END) AS Ana04ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A05'' THEN AT1611.AnaID ELSE NULL END) AS Ana05ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A06'' THEN AT1611.AnaID ELSE NULL END) AS Ana06ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A07'' THEN AT1611.AnaID ELSE NULL END) AS Ana07ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A08'' THEN AT1611.AnaID ELSE NULL END) AS Ana08ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A09'' THEN AT1611.AnaID ELSE NULL END) AS Ana09ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A10'' THEN AT1611.AnaID ELSE NULL END) AS Ana10ID, 		
		CONVERT(DECIMAL(28,8), 0) AS ConvertedAmount, CONVERT(DECIMAL(28,8), 0) AS OriginalAmount, 
		AT9000.InventoryID, AT9000.UnitID, AT9000.BatchID, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID, AT9000.TransactionTypeID
		FROM AT1611 WITH (NOLOCK)
		INNER JOIN AT1610 ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID		
		INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT1611.DivisionID
		LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = AT1611.DivisionID AND AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID 
		WHERE AT1611.DivisionID = ''' + @DivisionID + '''
		AND AT1611.AllocationID = ''' + @AllocationID + '''
		AND AT9000.VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionID = ''' + @TransactionID + '''
		ORDER BY AT1611.Orders'
	END	
END
ELSE -- Trường hợp phân bổ cấp 2 trở đi: Lấy các chứng từ đã phân bổ AT9006
BEGIN 
	IF @AllocationType = 1 -- Phân bổ theo tỉ lệ
	BEGIN
		SET @sSQL = '				
		SELECT AT1611.DivisionID, ' + CONVERT(NVARCHAR(5), @Orders) + ' AS MasterOrders, AT1611.Orders, AT9001.TransactionID AS InheritTransactionID, AT9001.VoucherID AS InheritVoucherID,
		AT1611.AllocationID, AT1610.AllocationType, 
		AT1611.AnaID, AT1611.AnaTypeID, AT1011.AnaName, AT9001.DebitAccountID, AT9001.CreditAccountID, 
		(CASE WHEN AT1611.AnaTypeID = ''A01'' THEN AT1611.AnaID ELSE NULL END) AS Ana01ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A02'' THEN AT1611.AnaID ELSE NULL END) AS Ana02ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A03'' THEN AT1611.AnaID ELSE NULL END) AS Ana03ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A04'' THEN AT1611.AnaID ELSE NULL END) AS Ana04ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A05'' THEN AT1611.AnaID ELSE NULL END) AS Ana05ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A06'' THEN AT1611.AnaID ELSE NULL END) AS Ana06ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A07'' THEN AT1611.AnaID ELSE NULL END) AS Ana07ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A08'' THEN AT1611.AnaID ELSE NULL END) AS Ana08ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A09'' THEN AT1611.AnaID ELSE NULL END) AS Ana09ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A10'' THEN AT1611.AnaID ELSE NULL END) AS Ana10ID, 		
		CONVERT(DECIMAL(28,8), ROUND(AT9001.ConvertedAmount*(PercentRate/100), AT1101.ConvertedDecimals)) AS ConvertedAmount, 
		CONVERT(DECIMAL(28,8), ROUND(AT9001.ConvertedAmount*(PercentRate/100)/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)) AS OriginalAmount,		
		AT9001.InventoryID, AT9001.UnitID, AT9001.BatchID, AT9001.Serial, AT9001.InvoiceNo, AT9001.InvoiceDate, AT9001.ObjectID, AT9001.TransactionTypeID
		INTO #TEMP			
		FROM AT1611 WITH (NOLOCK)
		INNER JOIN AT1610 ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID				
		INNER JOIN AT9001 WITH (NOLOCK) ON AT9001.DivisionID = AT1611.DivisionID
		LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = AT1611.DivisionID AND AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9001.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + '''   
		WHERE AT1611.DivisionID = ''' + @DivisionID + '''
		AND AT1611.AllocationID = ''' + @AllocationID + '''		
		AND AT9001.VoucherID = ''' + @VoucherID + '''
		AND AT9001.TransactionID = ''' + @TransactionID + '''		
		ORDER BY AT1611.Orders'
		
		SET @sSQL2 = '
		UPDATE #TEMP
		SET ConvertedAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0), AT1101.ConvertedDecimals),
			OriginalAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0)/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)
		FROM #TEMP	
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #TEMP.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + ''' 
		WHERE #TEMP.Orders = ' + CONVERT(NVARCHAR(5), @RowOrders) + ' 	
		
		SELECT * FROM #TEMP			
		'			
	END
	ELSE
	IF @AllocationType = 2 -- Phân bổ theo số lượng nhân viên
	BEGIN
		-- Lấy số lượng tổng nhân viên được khai báo
		SELECT @TotalEmployeeNumber = SUM(EmployeeNumber)  
		FROM AT1611 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID
		AND AllocationID = @AllocationID
		
		SET @sSQL = '	
		SELECT AT1611.DivisionID, ' + CONVERT(NVARCHAR(5), @Orders) + ' AS MasterOrders, AT1611.Orders, AT9001.TransactionID AS InheritTransactionID, AT9001.VoucherID AS InheritVoucherID,
		AT1611.AllocationID, AT1610.AllocationType, 
		AT1611.AnaID, AT1611.AnaTypeID, AT1011.AnaName, AT9001.DebitAccountID, AT9001.CreditAccountID, 
		(CASE WHEN AT1611.AnaTypeID = ''A01'' THEN AT1611.AnaID ELSE NULL END) AS Ana01ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A02'' THEN AT1611.AnaID ELSE NULL END) AS Ana02ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A03'' THEN AT1611.AnaID ELSE NULL END) AS Ana03ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A04'' THEN AT1611.AnaID ELSE NULL END) AS Ana04ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A05'' THEN AT1611.AnaID ELSE NULL END) AS Ana05ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A06'' THEN AT1611.AnaID ELSE NULL END) AS Ana06ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A07'' THEN AT1611.AnaID ELSE NULL END) AS Ana07ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A08'' THEN AT1611.AnaID ELSE NULL END) AS Ana08ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A09'' THEN AT1611.AnaID ELSE NULL END) AS Ana09ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A10'' THEN AT1611.AnaID ELSE NULL END) AS Ana10ID, 		
		CONVERT(DECIMAL(28,8), ROUND(AT9001.ConvertedAmount*(EmployeeNumber/' + CONVERT(NVARCHAR(30), @TotalEmployeeNumber) + '), AT1101.ConvertedDecimals)) AS ConvertedAmount, 
		CONVERT(DECIMAL(28,8), ROUND(AT9001.ConvertedAmount*(EmployeeNumber/' + CONVERT(NVARCHAR(30), @TotalEmployeeNumber) + ')/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)) AS OriginalAmount,			
		AT9001.InventoryID, AT9001.UnitID, AT9001.BatchID, AT9001.Serial, AT9001.InvoiceNo, AT9001.InvoiceDate, AT9001.ObjectID, AT9001.TransactionTypeID
		INTO #TEMP			
		FROM AT1611 WITH (NOLOCK)
		INNER JOIN AT1610 ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID				
		INNER JOIN AT9001 WITH (NOLOCK) ON AT9001.DivisionID = AT1611.DivisionID
		LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = AT1611.DivisionID AND AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT9001.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + ''' 		 
		WHERE AT1611.DivisionID = ''' + @DivisionID + '''
		AND AT1611.AllocationID = ''' + @AllocationID + '''		
		AND AT9001.VoucherID = ''' + @VoucherID + '''
		AND AT9001.TransactionID = ''' + @TransactionID + '''
		ORDER BY AT1611.Orders'
		
		SET @sSQL2 = '
		UPDATE #TEMP
		SET ConvertedAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0), AT1101.ConvertedDecimals),
			OriginalAmount = ROUND(' + CONVERT(NVARCHAR(50), @ConvertedAmount) + ' - ISNULL((SELECT SUM(ConvertedAmount) FROM #TEMP WHERE #TEMP.Orders < ' + CONVERT(NVARCHAR(5), @RowOrders) + '), 0)/' + CONVERT(NVARCHAR(30), @ExchangeRate) + ', AT1004.ExchangeRateDecimal)
		FROM #TEMP	
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #TEMP.DivisionID
		LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = ''' + @CurrencyID + ''' 
		WHERE #TEMP.Orders = ' + CONVERT(NVARCHAR(5), @RowOrders) + ' 	
		
		SELECT * FROM #TEMP			
		'			
	END
	ELSE -- Phân bổ theo số lượng ấn định
	BEGIN
		SET @sSQL = '			
		SELECT AT1611.DivisionID, ' + CONVERT(NVARCHAR(5), @Orders) + ' AS MasterOrders, AT1611.Orders, AT9001.TransactionID AS InheritTransactionID, AT9001.VoucherID AS InheritVoucherID,
		AT1611.AllocationID, AT1610.AllocationType, 
		AT1611.AnaID, AT1611.AnaTypeID, AT1011.AnaName, AT9001.DebitAccountID, AT9001.CreditAccountID, 
		(CASE WHEN AT1611.AnaTypeID = ''A01'' THEN AT1611.AnaID ELSE NULL END) AS Ana01ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A02'' THEN AT1611.AnaID ELSE NULL END) AS Ana02ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A03'' THEN AT1611.AnaID ELSE NULL END) AS Ana03ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A04'' THEN AT1611.AnaID ELSE NULL END) AS Ana04ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A05'' THEN AT1611.AnaID ELSE NULL END) AS Ana05ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A06'' THEN AT1611.AnaID ELSE NULL END) AS Ana06ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A07'' THEN AT1611.AnaID ELSE NULL END) AS Ana07ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A08'' THEN AT1611.AnaID ELSE NULL END) AS Ana08ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A09'' THEN AT1611.AnaID ELSE NULL END) AS Ana09ID, 
		(CASE WHEN AT1611.AnaTypeID = ''A10'' THEN AT1611.AnaID ELSE NULL END) AS Ana10ID, 		
		CONVERT(DECIMAL(28,8), 0) AS ConvertedAmount, CONVERT(DECIMAL(28,8), 0) AS OriginalAmount, 
		AT9001.InventoryID, AT9001.UnitID, AT9001.BatchID, AT9001.Serial, AT9001.InvoiceNo, AT9001.InvoiceDate, AT9001.ObjectID, AT9001.TransactionTypeID
		FROM AT1611 WITH (NOLOCK)
		INNER JOIN AT1610 ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID				
		INNER JOIN AT9001 WITH (NOLOCK) ON AT9001.DivisionID = AT1611.DivisionID
		LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = AT1611.DivisionID AND AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID 
		WHERE AT1611.DivisionID = ''' + @DivisionID + '''
		AND AT1611.AllocationID = ''' + @AllocationID + '''		
		AND AT9001.VoucherID = ''' + @VoucherID + '''
		AND AT9001.TransactionID = ''' + @TransactionID + '''
		ORDER BY AT1611.Orders'
	END			
END	

PRINT @sSQL
PRINT @sSQL2
EXEC (@sSQL + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
