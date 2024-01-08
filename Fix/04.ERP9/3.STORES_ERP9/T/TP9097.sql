IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9097]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9097]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----<Summary>
---- Đổ nguồn kế thừa ngân sách lưới master
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 14/11/2018
---- Modified by Tuấn Anh ft Hồng Thảo on 09/12/2019: Loại bỏ điều kiện lọc theo Department: Đồng bộ với ERP9
----<Example>
/*
	EXEC TP9097 'BS', 'M', 11, 2018,'2018-10-29 00:00:00.000', '2018-10-30 00:00:00.000', '|LM', '21321'
	EXEC TP9097 @DivisionID, @BudgetType, @TranMonth, @TranYear, @FromDate, @ToDate, @DepartmentID, @VoucherID
*/
CREATE PROCEDURE [dbo].[TP9097] 	
(
	@DivisionID NVARCHAR(50),
	@BudgetType NVARCHAR(50),
	@Month INT,
	@Year INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@VoucherID varchar(50)
)
AS

DECLARE @SQL NVARCHAR(MAX),
		@SQL1 NVARCHAR(MAX),
		@WHERE NVARCHAR(MAX) = N''

IF ISNULL(@DivisionID,'') <> ''
SET @WHERE = @WHERE + N' 
				AND F00.DivisionID = '''+@DivisionID+''''
IF ISNULL(@BudgetType,'')<> ''
SET @WHERE = @WHERE + N' 
				AND F00.BudgetType = '''+@BudgetType+''''
IF ISNULL(@Month,'')<>''
SET @WHERE = @WHERE + N' 
				AND F00.MonthBP = '+Ltrim(@Month)+''
IF ISNULL(@Year,'')<>''
SET @WHERE = @WHERE + N' 
				AND F00.YearBP = '+Ltrim(@Year)+''
IF (ISNULL(@FromDate,'')<>'' AND ISNULL(@ToDate,'')<>'')
SET @WHERE = @WHERE + N'
				AND CONVERT(Varchar(20),F00.VoucherDate,120) BETWEEN '''+CONVERT(Varchar(20),@FromDate,120)+''' AND '''+CONVERT(Varchar(20),@ToDate,120)+''''

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM

CREATE TABLE #TAM
(
	APK varchar(50),
	APKDetail varchar(50),
	EndOAmount decimal(28,8),
	EndCAmount decimal(28,8)
)

Set  @SQL = '
INSERT INTO #TAM (APK, APKDetail, EndOAmount, EndCAmount)
SELECT	APK, APKDetail,
		ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount_T90,0) as EndOAmount,
		ISNULL(ConvertedAmount,0) - ISNULL(ActualCAmount_T90,0) as EndCAmount
FROM
(
	SELECT	F01.DivisionID, F00.APK, F01.APK AS APKDetail,
			F01.ApprovalOAmount AS OriginalAmount, F01.ApprovalCAmount AS ConvertedAmount,
			T90.ActualOAmount_T90, T90.ActualCAmount_T90
	FROM TT2101 F01 WITH (NOLOCK)
	INNER JOIN TT2100 F00 WITH (NOLOCK) ON F01.DivisionID = F00.DivisionID AND F01.APKMaster = F00.APK AND F00.DeleteFlag = 0 AND F00.Status = 1
	LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(OriginalAmount) as ActualOAmount_T90, SUM(ConvertedAmount) as ActualCAmount_T90
				From AT9000 WITH (NOLOCK) 
				Where DivisionID = ''' + @DivisionID + ''' And ISNULL(InheritTableID,'''') = ''TT2100'' And Isnull(InheritTransactionID,'''') <> ''''
				Group by DivisionID, InheritTransactionID
				) T90 ON F01.DivisionID = T90.DivisionID And F01.APK = T90.InheritTransactionID
	WHERE F01.DivisionID = ''' + @DivisionID + ''' AND F01.DeleteFlag = 0
' + @WHERE + '
) A
WHERE ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount_T90,0) > 0 
'
EXEC(@SQL)

IF isnull(@VoucherID,'')<> ''	--- khi load edit
BEGIN
	Set  @SQL1 ='
	SELECT * FROM
	(
		SELECT	cast(0 as bit) as IsCheck,
				F00.APK, F00.VoucherNo, Convert(varchar(10),F00.VoucherDate,103) as VoucherDate,
				F00.BudgetType, T99.Description As BudgetTypeName, 
				CASE F00.BudgetType 
				WHEN ''M'' THEN  Ltrim(V99.MonthYear)
				WHEN ''Q'' THEN  Ltrim(V99.MonthYear)
				ELSE Ltrim(V99.TranYear) END As PeriorBudget,
				F00.CurrencyID, F00.ExchangeRate,
				F00.DepartmentID, T11.AnaName As DepartmentName, 
				F00.Description
		FROM TT2100 F00 WITH (NOLOCK)
		INNER JOIN #TAM ON F00.APK = #TAM.APK
		LEFT JOIN AT0099 T99 WITH (NOLOCK) ON F00.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
		LEFT JOIN AT0099 T09 WITH (NOLOCK) ON F00.Status = T09.ID AND T09.CodeMaster = ''Status''
		LEFT JOIN AT1011 T11 WITH (NOLOCK) ON F00.DepartmentID = T11.AnaID AND T11.AnaTypeID = ''A03''
		LEFT JOIN AV9999 V99 WITH (NOLOCK) ON F00.DivisionID = V99.DivisionID AND V99.TranMonth = F00.TranMonth AND V99.TranYear = F00.TranYear
		WHERE NOT EXISTS (	SELECT TOP 1 1
							FROM AT9000 WITH (NOLOCK)
							WHERE DivisionID = ''' + @DivisionID + ''' AND VoucherID = ''' + @VoucherID + '''
							AND InheritVoucherID = F00.APK
						)
		GROUP BY F00.APK, F00.VoucherNo, F00.VoucherDate,
				F00.BudgetType, T99.Description, V99.MonthYear, V99.TranYear, F00.CurrencyID, F00.ExchangeRate,F00.DepartmentID, T11.AnaName, F00.Description

		UNION ALL
		SELECT	cast(1 as bit) as IsCheck,
				F00.APK, F00.VoucherNo, Convert(varchar(10),F00.VoucherDate,103) as VoucherDate,
				F00.BudgetType, T99.Description As BudgetTypeName, 
				CASE F00.BudgetType 
				WHEN ''M'' THEN  Ltrim(V99.MonthYear)
				WHEN ''Q'' THEN  Ltrim(V99.MonthYear)
				ELSE Ltrim(V99.TranYear) END As PeriorBudget,
				F00.CurrencyID, F00.ExchangeRate,
				F00.DepartmentID, T11.AnaName As DepartmentName, 
				F00.Description
		FROM TT2100 F00 WITH (NOLOCK)
		INNER JOIN #TAM ON F00.APK = #TAM.APK
		LEFT JOIN AT0099 T99 WITH (NOLOCK) ON F00.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
		LEFT JOIN AT0099 T09 WITH (NOLOCK) ON F00.Status = T09.ID AND T09.CodeMaster = ''Status''
		LEFT JOIN AT1011 T11 WITH (NOLOCK) ON F00.DepartmentID = T11.AnaID AND T11.AnaTypeID = ''A03''
		LEFT JOIN AV9999 V99 WITH (NOLOCK) ON F00.DivisionID = V99.DivisionID AND V99.TranMonth = F00.TranMonth AND V99.TranYear = F00.TranYear
		WHERE NOT EXISTS (	SELECT TOP 1 1
							FROM AT9000 WITH (NOLOCK)
							WHERE DivisionID = ''' + @DivisionID + ''' AND VoucherID = ''' + @VoucherID + '''
							AND InheritVoucherID = F00.APK
						)
		GROUP BY F00.APK, F00.VoucherNo, F00.VoucherDate,
				F00.BudgetType, T99.Description, V99.MonthYear, V99.TranYear, F00.CurrencyID, F00.ExchangeRate,F00.DepartmentID, T11.AnaName, F00.Description
	) A
	ORDER BY IsCheck DESC, VoucherDate, VoucherNo
	'
END
ELSE --- khi load add new
BEGIN
	SET @SQL1 = '
	SELECT	cast(0 as bit) as IsCheck,
				F00.APK, F00.VoucherNo, Convert(varchar(10),F00.VoucherDate,103) as VoucherDate,
				F00.BudgetType, T99.Description As BudgetTypeName, 
				CASE F00.BudgetType 
				WHEN ''M'' THEN  Ltrim(V99.MonthYear)
				WHEN ''Q'' THEN  Ltrim(V99.MonthYear)
				ELSE Ltrim(V99.TranYear) END As PeriorBudget,
				F00.CurrencyID, F00.ExchangeRate,
				F00.DepartmentID, T11.AnaName As DepartmentName, 
				F00.Description
	FROM TT2100 F00 WITH (NOLOCK)
	INNER JOIN #TAM ON F00.APK = #TAM.APK
	LEFT JOIN AT0099 T99 WITH (NOLOCK) ON F00.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
	LEFT JOIN AT0099 T09 WITH (NOLOCK) ON F00.Status = T09.ID AND T09.CodeMaster = ''Status''
	LEFT JOIN AT1011 T11 WITH (NOLOCK) ON F00.DepartmentID = T11.AnaID AND T11.AnaTypeID = ''A03''
	LEFT JOIN AV9999 V99 WITH (NOLOCK) ON F00.DivisionID = V99.DivisionID AND V99.TranMonth = F00.TranMonth AND V99.TranYear = F00.TranYear
	WHERE F00.DivisionID = ''' + @DivisionID + '''
	GROUP BY F00.APK, F00.VoucherNo, F00.VoucherDate,
				F00.BudgetType, T99.Description, V99.MonthYear, V99.TranYear, F00.CurrencyID, F00.ExchangeRate,F00.DepartmentID, T11.AnaName, F00.Description
	ORDER BY  F00.VoucherDate, F00.VoucherNo'
END

--print (@SQL)
--print (@SQL1)
EXEC(@SQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

