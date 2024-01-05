IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP1012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách hợp đồng hạn mức còn thời hạn và hạn mức cho vay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/06/2017 by Bảo Anh
----Modified on 07/11/2018 by Bảo Anh: Sửa cách lấy BankName
----Modified on 14/01/2019 by Như Hàn: Bổ sung hạn mức, Han mức đã sử dụng
-- <Example>
/*  
 EXEC LMP1012 'AS','01/04/2017','',1,8
*/
----
CREATE PROCEDURE LMP1012 ( 
        @DivisionID VARCHAR(50),
		@VoucherDate DATETIME,
		@TxtSearch VARCHAR(250) = '',
		@PageNumber INT,
        @PageSize INT
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL VARCHAR (MAX)
		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = '
SELECT VoucherID, BankName, Operator, ExchangeRateDecimal, ISNULL(OriginalLimitTotal,0) - ISNULL(LoansAmount,0) - ISNULL(GuaranteeAmount,0) as EndOAmount, OriginalLimitTotal, LoansAmount
INTO #TAM
FROM
(
	SELECT	T10.DivisionID, T10.VoucherID, T16.ObjectName AS BankName,
			T04.Operator, T04.ExchangeRateDecimal, T10.OriginalLimitTotal, T31.ActualAmount AS LoansAmount, T51.ActualAmount AS GuaranteeAmount
	FROM LMT1010 T10 WITH (NOLOCK)
	LEFT JOIN	(Select T01.LimitVoucherID as VoucherID, SUM(T01.OriginalAmount) as ActualAmount
				From LMT2001 T01  WITH (NOLOCK) 	
				Where T01.DivisionID = ''' + @DivisionID + ''' 
				Group by T01.LimitVoucherID
				)T31 ON T10.VoucherID = T31.VoucherID
	LEFT JOIN (Select T51.LimitVoucherID as VoucherID, SUM(T51.OriginalAmount) as ActualAmount
				From LMT2051 T51 WITH (NOLOCK) 				
				Where T51.DivisionID = ''' + @DivisionID + '''
				Group by T51.LimitVoucherID
				)T51 ON T10.VoucherID = T51.VoucherID
	LEFT JOIN AT1202 T16 WITH (NOLOCK) On T10.BankID = T16.ObjectID
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T10.CurrencyID = T04.CurrencyID
	WHERE T10.DivisionID = ''' + @DivisionID + '''
	AND (''' + Convert(varchar(10),@VoucherDate,101) + ''' between T10.FromDate and T10.ToDate)
	AND (ISNULL(T10.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T16.ObjectName,'''') LIKE ''%'+@TxtSearch+'%''
	OR ISNULL(T10.BankAccountID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T10.CurrencyID,'''') LIKE ''%'+@TxtSearch+'%'') 
) A
WHERE ISNULL(OriginalLimitTotal,0) - ISNULL(LoansAmount,0) - ISNULL(GuaranteeAmount,0) > 0'

SET @sSQL = @sSQL + '
SELECT	ROW_NUMBER() OVER (ORDER BY T10.VoucherDate, T10.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
		T10.VoucherID as Column01, T10.VoucherNo as Column02, Convert(varchar(10),T10.VoucherDate,103) as Column03, #TAM.BankName as Column04,
		T10.BankAccountID as Column05, Convert(varchar(10),T10.FromDate,103) as Column06, Convert(varchar(10),T10.ToDate,103) as Column07,
		T10.CurrencyID as Column08, T10.ExchangeRate as Column09,
		#TAM.EndOAmount as Column10, #TAM.EndOAmount * T10.ExchangeRate as Column11,
		#TAM.Operator as Column12, #TAM.ExchangeRateDecimal as Column13, T10.BankID as Column14,
		#TAM.OriginalLimitTotal as Column15, #TAM.OriginalLimitTotal * T10.ExchangeRate as Column16, 
		#TAM.LoansAmount as Column17, #TAM.LoansAmount * T10.ExchangeRate as Column18
FROM LMT1010 T10 WITH (NOLOCK)
INNER JOIN #TAM ON T10.VoucherID = #TAM.VoucherID 
ORDER BY T10.VoucherDate, T10.VoucherNo'

SET @sSQL = @sSQL+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--PRINT @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
