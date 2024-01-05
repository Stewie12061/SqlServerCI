IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP9001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP9001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách chứng từ kế toán (master) để kế thừa cho các nghiệp vụ của quản lý vay
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
 EXEC LMP9001 'AS','01/01/2017','01/01/2017','01/2017,02/2017',0,1,'ACB','VND','ABCD','LMF2011',1,8
*/
----
CREATE PROCEDURE LMP9001 ( 
        @DivisionID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX),
		@IsDate BIT,
		@SourceID TINYINT,
		@ObjectID VARCHAR(250),
		@CurrencyID VARCHAR(50),
		@VoucherNo VARCHAR(50),
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
SET @PeriodList = REPLACE(@PeriodList,',',''',''')

IF @IsDate = 0
	SET @sWhere = ' AND ((CASE WHEN T90.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T90.TranMonth)))+''/''+ltrim(Rtrim(str(T90.TranYear))) in ('''+@PeriodList +'''))'
ELSE
	SET @sWhere = ' AND (Convert(varchar(20),T90.VoucherDate,103) Between ''' + Convert(varchar(20),@FromDate,103) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),103) + ''')'
	
IF @SourceID IS NOT NULL
	SET @sWhere = @sWhere + ' AND T90.TransactionTypeID = ''' + (case @SourceID when 0 then 'T01' when 1 then 'T02' when 2 then 'T21' when 3 then 'T22' else 'T99' end) + ''''

IF ISNULL(@ObjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND (T90.ObjectID like ''%' + @ObjectID + '%'' OR T02.ObjectName like N''%' + @ObjectID + '%'')'

IF ISNULL(@CurrencyID,'') <> ''
	SET @sWhere = @sWhere + ' AND T90.CurrencyID = ''' + @CurrencyID + ''''

IF ISNULL(@VoucherNo,'') <> ''
	SET @sWhere = @sWhere + ' AND T90.VoucherNo like ''%' + @VoucherNo + '%'''

IF @FormID = 'LMF2031'	--- cập nhật chứng từ thanh toán
BEGIN
	SET @sSQL = '
	SELECT DivisionID, TransactionID, ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) as EndOAmount, ISNULL(ConvertedAmount,0) - ISNULL(ActualCAmount,0) as EndCAmount
	INTO #TAM
	FROM
	(
		SELECT	T90.DivisionID, T90.TransactionID, T90.OriginalAmount, T90.ConvertedAmount, T31.ActualOAmount, T31.ActualCAmount
		FROM AT9000 T90 WITH (NOLOCK)
		LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(ActualOriginalAmount) as ActualOAmount, SUM(ActualConvertedAmount) as ActualCAmount
					From LMT2031 WITH (NOLOCK) 
					Where DivisionID = ''' + @DivisionID + ''' And Isnull(InheritTransactionID,'''') <> ''''
					Group by DivisionID, InheritTransactionID
					) T31 ON T90.DivisionID = T31.DivisionID And T90.TransactionID = T31.InheritTransactionID
		LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T90.ObjectID = T02.ObjectID
		WHERE T90.DivisionID = ''' + @DivisionID + '''' + @sWhere + '
	) A
	WHERE ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) > 0'
END
	
ELSE IF @FormID = 'LMF2011'	--- cập nhật phong tỏa/giải tỏa TK
BEGIN
	SET @sSQL = '
	SELECT DivisionID, TransactionID, ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) as EndOAmount, ISNULL(ConvertedAmount,0) - ISNULL(ActualCAmount,0) as EndCAmount
	INTO #TAM
	FROM
	(
		SELECT	T90.DivisionID, T90.TransactionID, T90.OriginalAmount, T90.ConvertedAmount, T31.ActualOAmount, T31.ActualCAmount
		FROM AT9000 T90 WITH (NOLOCK)
		LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(OriginalAmount) as ActualOAmount, SUM(ConvertedAmount) as ActualCAmount
					From LMT2011 WITH (NOLOCK) 
					Where DivisionID = ''' + @DivisionID + ''' And Isnull(InheritTransactionID,'''') <> ''''
					Group by DivisionID, InheritTransactionID
					) T31 ON T90.DivisionID = T31.DivisionID And T90.TransactionID = T31.InheritTransactionID
		LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T90.ObjectID = T02.ObjectID
		WHERE T90.DivisionID = ''' + @DivisionID + '''' + @sWhere + '
	) A
	WHERE ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount,0) > 0'
END

SET @sSQL = @sSQL + '
SELECT	ROW_NUMBER() OVER (ORDER BY T90.VoucherDate, T90.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
		T90.VoucherID, T90.VoucherNo, Convert(varchar(10),T90.VoucherDate,103) as VoucherDate,
		(case when ' + LTRIM(ISNULL(@SourceID,0)) + ' = 2 then T90.DebitBankAccountID when ' + LTRIM(ISNULL(@SourceID,0)) + ' = 3 then T90.CreditBankAccountID else NULL end) as BankAccountID,
		T90.VDescription as Description,
		SUM(#TAM.EndOAmount) as OriginalAmountTotal, SUM(#TAM.EndCAmount) as ConvertedAmountTotal
FROM AT9000 T90 WITH (NOLOCK)
INNER JOIN #TAM ON T90.DivisionID = #TAM.DivisionID And T90.TransactionID = #TAM.TransactionID
GROUP BY T90.VoucherID, T90.VoucherNo, T90.VoucherDate,
		(case when ' + LTRIM(ISNULL(@SourceID,0)) + ' = 2 then T90.DebitBankAccountID when ' + LTRIM(ISNULL(@SourceID,0)) + ' = 3 then T90.CreditBankAccountID else NULL end),
		T90.VDescription
ORDER BY T90.VoucherDate, T90.VoucherNo'

SET @sSQL = @sSQL+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--print @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

