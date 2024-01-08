IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2033]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách lịch trả nợ chưa được kế thừa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 17/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP2033 'AS','ABCD','',1,8
*/
----
CREATE PROCEDURE LMP2033 ( 
        @DivisionID VARCHAR(50),
		@DisburseVoucherID VARCHAR(50),
		@TxtSearch VARCHAR(250) = '',
		@PageNumber INT,
        @PageSize INT
		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@TotalRow VARCHAR(50),
		@CostAnaTypeID varchar(50)
		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
  
SELECT @CostAnaTypeID = ISNULL(CostAnaTypeID,'') FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID 
  
--- Lấy các lịch trả nợ chưa thanh toán của chứng từ giải ngân @DisburseVoucherID
CREATE TABLE #TAM (DivisionID VARCHAR(50), TransactionID VARCHAR(50), EndOAmount DECIMAL(28,8))

INSERT INTO #TAM (DivisionID, TransactionID, EndOAmount)
SELECT DivisionID, TransactionID, ISNULL(PaymentOriginalAmount,0) - ISNULL(ActualAmount,0)
FROM
(
	SELECT	T22.DivisionID, T22.TransactionID, T22.PaymentOriginalAmount, T31.ActualAmount
	FROM LMT2022 T22 WITH (NOLOCK)
	LEFT JOIN	(Select DivisionID, PaymentPlanTransactionID, SUM(ActualOriginalAmount) as ActualAmount
				From LMT2031 WITH (NOLOCK) 
				Where DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID
				Group by DivisionID, PaymentPlanTransactionID
				)T31 ON T22.DivisionID = T31.DivisionID And T22.TransactionID = T31.PaymentPlanTransactionID
	WHERE T22.DivisionID = @DivisionID AND DisburseVoucherID = @DisburseVoucherID
) A
WHERE ISNULL(PaymentOriginalAmount,0) - ISNULL(ActualAmount,0) > 0

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY T22.PaymentDate, ISNULL(T22.PaymentType,0) DESC) AS RowNum, '+@TotalRow+' AS TotalRow,
			T22.TransactionID as Column01, Convert(Varchar(10),T22.PaymentDate,103) as Column02, T22.PaymentName as Column03, T22.PaymentType AS Column04,
			T99.Description as Column05, #TAM.EndOAmount as Column06, #TAM.EndOAmount * T22.ExchangeRate as Column07,
			T22.PaymentAccountID as Column08, T22.CostTypeID as Column09, A11.AnaName as Column10			
	FROM LMT2022 T22 WITH (NOLOCK)
	INNER JOIN #TAM ON T22.DivisionID = #TAM.DivisionID And T22.TransactionID = #TAM.TransactionID
	LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T22.CostTypeID = A11.AnaID And A11.AnaTypeID = ''' + @CostAnaTypeID + '''
	LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T22.PaymentType = T99.OrderNo And T99.CodeMaster = ''LMT00000010''
	WHERE T22.DivisionID = ''' + @DivisionID + ''' AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + '''
	AND (ISNULL(T22.PaymentName,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T99.Description,'''') LIKE ''%'+@TxtSearch+'%''
		OR ISNULL(T22.PaymentAccountID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T22.CostTypeID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(A11.AnaName,'''') LIKE ''%'+@TxtSearch+'%'')
	ORDER BY T22.PaymentDate, T22.PaymentType DESC'

SET @sSQL = @sSQL+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
--print @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

