IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP9002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP9002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách chứng từ kế toán (Detail) để kế thừa cho các nghiệp vụ của quản lý vay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP9002 'AS','ABCD,DEFG','LMF2031',1,8
*/
----
CREATE PROCEDURE LMP9002 ( 
        @DivisionID VARCHAR(50),
		@VoucherIDList VARCHAR(MAX),
		@FormID VARCHAR(50),
		@PageNumber INT,
        @PageSize INT
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL VARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = ''
SET @VoucherIDList = REPLACE(@VoucherIDList,',',''',''')

IF @FormID = 'LMF2031'	--- cập nhật chứng từ thanh toán
BEGIN
	SET @sSQL = '
	SELECT DivisionID, VoucherNo, TransactionID, ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) as EndOAmount, ISNULL(ConvertedAmount,0) - ISNULL(ActualCAmount,0) as EndCAmount
	INTO #TAM
	FROM
	(
		SELECT	 T90.DivisionID, T90.VoucherNo, T90.TransactionID, T90.OriginalAmount, T90.ConvertedAmount, T31.ActualOAmount, T31.ActualCAmount
		FROM AT9000 T90 WITH (NOLOCK)
		LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(ActualOriginalAmount) as ActualOAmount, SUM(ActualConvertedAmount) as ActualCAmount
					From LMT2031 WITH (NOLOCK) 
					Where DivisionID = ''' + @DivisionID + ''' And Isnull(InheritTransactionID,'''') <> '''' And InheritTableName = ''AT9000''
					Group by DivisionID, InheritTransactionID
					) T31 ON T90.DivisionID = T31.DivisionID And T90.TransactionID = T31.InheritTransactionID
		WHERE T90.DivisionID = ''' + @DivisionID + ''' AND T90.VoucherID in (''' + @VoucherIDList + ''')
	) A
	WHERE ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) > 0'
END
	
ELSE IF @FormID = 'LMF2011'	--- cập nhật phong tỏa/giải tỏa TK
BEGIN
	SET @sSQL = '
	SELECT DivisionID, VoucherNo, TransactionID, ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) as EndOAmount, ISNULL(ConvertedAmount,0) - ISNULL(ActualCAmount,0) as EndCAmount
	INTO #TAM
	FROM
	(
		SELECT	T90.DivisionID, T90.VoucherNo, T90.TransactionID, T90.OriginalAmount, T90.ConvertedAmount, T31.ActualOAmount, T31.ActualCAmount
		FROM AT9000 T90 WITH (NOLOCK)
		LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(OriginalAmount) as ActualOAmount, SUM(ConvertedAmount) as ActualCAmount
					From LMT2011 WITH (NOLOCK) 
					Where DivisionID = ''' + @DivisionID + ''' And Isnull(InheritTransactionID,'''') <> '''' And InheritTableName = ''AT9000''
					Group by DivisionID, InheritTransactionID
					) T31 ON T90.DivisionID = T31.DivisionID And T90.TransactionID = T31.InheritTransactionID
		WHERE T90.DivisionID = ''' + @DivisionID + ''' AND T90.VoucherID in (''' + @VoucherIDList + ''')
	) A
	WHERE ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) > 0'
END

SET @sSQL = @sSQL+'
SELECT	ROW_NUMBER() OVER (ORDER BY T90.VoucherDate, T90.VoucherNo, T90.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, T90.VoucherNo,
		T90.TransactionID, T90.InvoiceNo, T90.Serial, Convert(varchar(10),T90.InvoiceDate,103) as InvoiceDate, T90.ObjectID,
		T90.CurrencyID, T90.ExchangeRate, T90.TDescription, T02.ObjectName,
		T90.OriginalAmount, T90.ConvertedAmount, '''' AS CostTypeID, '''' AS CostTypeName
FROM AT9000 T90 WITH (NOLOCK)
INNER JOIN #TAM ON T90.DivisionID = #TAM.DivisionID And T90.TransactionID = #TAM.TransactionID
LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T90.ObjectID = T02.ObjectID
WHERE T90.DivisionID = ''' + @DivisionID + '''
ORDER BY T90.VoucherDate, T90.VoucherNo, T90.Orders'

--SET @sSQL = @sSQL+'
--OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
--FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--print @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

