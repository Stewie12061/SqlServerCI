IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0332]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0332]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lấy dữ liệu mặc định tờ khai thuế nhà thầu
-- <History>
---- Create on 12/11/2015 by Phương Thảo
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified on 02/06/2017 by Hải Long: Lấy dữ liệu thuế GTGT nhà thầu
-- <Example>
/*
exec AP0332 @DivisionID = 'vg', @TranMonth = 1, @TranYear = 2015, @ReturnDate = '2014-10-07', @IsPeriodTax = 1
*/

CREATE PROCEDURE [dbo].[AP0332] 	
	@DivisionID NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT,	
	@ReturnDate DATETIME,
	@IsPeriodTax TINYINT	
AS
DECLARE	@sSQL NVARCHAR(4000) = '',
		@sSQL1 NVARCHAR(4000) = '',
		@sWhere NVARCHAR(4000) = ''


IF (@IsPeriodTax = 0)
BEGIN
	SET @sWhere = 'AND AT9000.VoucherDate = '''+Convert(Varchar(20),@ReturnDate,101)+''''
END
ELSE
BEGIN
	SET @sWhere = 'AND AT9000.TranMonth + AT9000.TranYear*100 = '+STR(@TranMonth+@TranYear*100)+''
END

SET @sSQL = N'
SELECT	AT9000.VoucherID, AT9000.BatchID, AT9000.DivisionID,
		AT1101.VATNO AS WTNo,
		ISNULL(AT9000.TDescription, A90.TDescription) AS WTDescription, AT9000.ObjectID, AT9000.VoucherNo, AT9000.InvoiceNo, AT9000.Serial, 
		-- Doanh Thu tinh thue VND (len bao cao theo HTKK)
		AT9000.TaxBaseAmount, 
		-- Doanh thu chua bao gom thue VND (len bao cao theo HTKK)
		TB90.OriginalAmount AS NetPayAmount,		
		-- Doanh thu chua bao gom thue NT (len bao cao dac thu KH)
		CASE WHEN AT9000.WTCOperator = 0 THEN AT9000.TaxBaseAmount / AT9000.WTCExchangeRate ELSE  AT9000.TaxBaseAmount * AT9000.WTCExchangeRate END AS OAmount,
		-- Doanh thu chua bao gom thue QD (len bao cao dac thu KH)
		CASE WHEN AT1004.Operator = 0 THEN AT9000.TaxBaseAmount * AT9000.ExchangeRate ELSE  AT9000.TaxBaseAmount / AT9000.ExchangeRate END AS CAmount,
		-- Doanh thu tinh thue NT (len bao cao dac thu KH)
		CASE WHEN AT9000.WTCOperator = 0 THEN AT9000.TaxBaseAmount/AT9000.WTCExchangeRate ELSE AT9000.TaxBaseAmount*AT9000.WTCExchangeRate END AS AfterTaxOAmount,
		-- Convert(money,0) AS AfterTaxOAmount,  
		-- Doanh thu tinh thue QD (len bao cao dac thu KH)
		-- Convert(money,0) AS AfterTaxCAmount,
		CASE WHEN AT1004.Operator = 0 THEN AT9000.TaxBaseAmount * AT9000.ExchangeRate ELSE  AT9000.TaxBaseAmount / AT9000.ExchangeRate END AS AfterTaxCAmount,
		AT9000.CurrencyID, AT9000.ExchangeRate,
		AT9000.WTCExchangeRate,
		AT9000.WTCOperator,
		--9000.ExchangeRate,
		-- Chi co gia tri khi phat sinh thue nha thau ben Ban (tam thoi chua xu ly)
		A90.TaxBaseAmount AS VATTaxBaseAmount,
		A10.VATRate AS VATRate, 0 as TaxableTurnoverRate, A90.OriginalAmount as VATAmount,		
		AT9000.InvoiceDate AS PaymentDate, 
		AT9000.VATGroupID AS WTGroupID, 
		AT1010.VATRate  AS CITRate, 0 AS CITReduce,
		AT9000.OriginalAmount AS CITAmount, (AT9000.OriginalAmount + A90.OriginalAmount) AS TotalAmount,
		AT9000.TVoucherID, AT9000.TBatchID, AT1004.Operator, AT9000.VoucherDate, AT9000.InvoiceDate
INTO	#AP0332
FROM	AT9000  WITH (NOLOCK)
INNER JOIN AT1010 WITH (NOLOCK) ON AT9000.VATGroupID = AT1010.VATGroupID
INNER JOIN AT1101 WITH (NOLOCK) ON AT9000.DivisionID = AT1101.DivisionID
INNER JOIN AT1004 WITH (NOLOCK) ON AT9000.CurrencyID = AT1004.CurrencyID
LEFT JOIN AT9000 A90 ON A90.DivisionID = AT9000.DivisionID AND A90.VoucherID = AT9000.VoucherID AND A90.TBatchID = AT9000.TBatchID AND A90.TVoucherID = AT9000.TVoucherID AND A90.TransactionTypeID = ''T43'' AND A90.Orders % 2 = 0
LEFT JOIN AT1010 A10 WITH (NOLOCK) ON A10.VATGroupID = A90.VATGroupID
LEFT JOIN
(
	SELECT DivisionID, VoucherID, TVoucherID, TBatchID, SUM(OriginalAmount) AS OriginalAmount 
	FROM AT9000 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+'''
	AND TransactionTypeID = ''T22''' + @sWhere + '
	GROUP BY DivisionID, VoucherID, TVoucherID, TBatchID
) TB90 ON TB90.DivisionID = AT9000.DivisionID AND TB90.VoucherID = AT9000.VoucherID AND TB90.TVoucherID = AT9000.TVoucherID AND TB90.TBatchID = AT9000.TBatchID  
WHERE AT9000.DivisionID = '''+@DivisionID+''' AND AT9000.TransactionTypeID = ''T43'' AND AT9000.Orders % 2 = 1

 ' + @sWhere

SET @sSQL1 = '
--UPDATE T1
--SET		T1.NetPayAmount = CASE WHEN T1.WTCOperator = 0 THEN T1.OAmount * T1.WTCExchangeRate ELSE  T1.OAmount / T1.WTCExchangeRate END,		
--		T1.AfterTaxCAmount = CASE WHEN T1.Operator = 0 THEN T1.AfterTaxOAmount * T1.ExchangeRate ELSE T1.AfterTaxOAmount / T1.ExchangeRate END
--FROM #AP0332 T1
--INNER JOIN 
--(
--SELECT	CurrencyID, DivisionID, 
--FROM AT9000 
--INNER JOIN AT1004 ON AT9000.CurrencyID = AT1004.CurrencyID AND AT9000.DivisionID = AT1004.DivisionID
--LEFT JOIN AT1010 on AT9000.VATGroupID = AT1010.VATGroupID
--WHERE AT9000.TransactionTypeID in (''T02'',''T22'')
--GROUP BY AT9000.VoucherID, AT9000.BatchID, AT9000.DivisionID, AT9000.CurrencyID, AT9000.ExchangeRate,AT1004.Operator, AT9000.TVoucherID, AT9000.TBatchID
--) T2
--ON T1.VoucherID = T2.VoucherID AND T1.DivisionID = T2.DivisionID 
----AND T1.TVoucherID = T2.TVoucherID AND T1.TBatchID = T2.TBatchID

SELECT * FROM #AP0332 ORDER BY PaymentDate, VoucherNo
drop table #AP0332
'

--PRINT (@sSQL)
--PRINT (@sSQL1)
EXEC (@sSQL + @sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

