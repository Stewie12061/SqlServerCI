IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP3001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo tổng hợp hạn mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 28/07/2017 by Bảo Anh
----Modify on 10/09/2020 by Kiều Nga : Lấy thêm các cột động hình thức tín dụng
-- <Example>
/*  
 EXEC LMP3001 'AS','01/01/2017','01/01/2017','01/2017,02/2017',0,'ACB,VCB,SCB','VND,USD,EUR',0,1,8
*/
----
CREATE PROCEDURE LMP3001 ( 
        @DivisionID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX)='',
		@IsDate BIT,
		@BankIDList VARCHAR(MAX)='',
		@CurrencyIDList VARCHAR(MAX)='',
		@IsExcel BIT, --1: thực hiện xuất file Excel; 0: Thực hiện In
		@PageNumber INT,
        @PageSize INT
) 
AS 
DECLARE @sSQL VARCHAR (MAX) ='',
		@sWhere VARCHAR (MAX) ='',
		@sWhere1 VARCHAR (MAX) ='',
		@TotalRow VARCHAR(50) ='',
		@cols  AS NVARCHAR(MAX)='';

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = ''

IF @IsDate = 0
	SET @sWhere1 = @sWhere1 + ' AND ((CASE WHEN T10.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T10.TranMonth)))+''/''+ltrim(Rtrim(str(T10.TranYear))) in ('''+@PeriodList +'''))'
ELSE
	SET @sWhere1 = @sWhere1 + ' AND (Convert(varchar(20),T10.VoucherDate,103) Between ''' + Convert(varchar(20),@FromDate,103) + ''' AND ''' + Convert(varchar(20),@ToDate,103) + ''')'

IF ISNULL(@BankIDList,'') <> ''
	SET @sWhere = @sWhere + ' AND T10.BankID in (''' + @BankIDList + ''')'

IF ISNULL(@CurrencyIDList,'') <> ''
	SET @sWhere = @sWhere + ' AND T10.CurrencyID in (''' + @CurrencyIDList + ''')'

--- Lấy cột động hình thức tín dụng
DECLARE @BankList TABLE (
	BankID NVARCHAR(50)
);

DECLARE @CurrencyList TABLE (
	CurrencyID NVARCHAR(50)
);

DECLARE @PeriodIDList TABLE (
	PeriodID NVARCHAR(50)
);

INSERT INTO @BankList
SELECT * FROM [dbo].StringSplit(REPLACE(@BankIDList, '''', ''), ',');

INSERT INTO @CurrencyList
SELECT * FROM [dbo].StringSplit(REPLACE(@CurrencyIDList, '''', ''), ',');

INSERT INTO @PeriodIDList
SELECT * FROM [dbo].StringSplit(REPLACE(@PeriodList, '''', ''), ',');

SELECT T01.CreditFormID,T11.CreditFormName
INTO #COL
FROM LMT1010 T10 WITH (NOLOCK)
LEFT JOIN LMT2001 T01 WITH (NOLOCK) ON T10.DivisionID = T01.DivisionID And T10.VoucherID = T01.LimitVoucherID
LEFT JOIN LMT1001 T11 WITH (NOLOCK) ON T01.CreditFormID = T11.CreditFormID
where T10.DivisionID = @DivisionID 
AND((@IsDate = 0 AND (CASE WHEN T10.TranMonth <10 THEN '0' ELSE '' END) + Ltrim(str(T10.TranMonth))+'/'+Ltrim(str(T10.TranYear)) in (select PeriodID from @PeriodIDList))
	OR (@IsDate = 1 AND (Convert(varchar(20),T10.VoucherDate,103) Between Convert(varchar(20),@FromDate,103) AND Convert(varchar(20),@ToDate,103))))
AND (ISNULL(@BankIDList,'') = '' OR T10.BankID in (select BankID from @BankList))
AND (ISNULL(@CurrencyIDList,'') = '' OR T10.CurrencyID in (select CurrencyID from @CurrencyList))
AND ISNULL(T01.CreditFormID,'') <> ''


SELECT @cols = @cols + QUOTENAME(CreditFormID) + ',' FROM (SELECT DISTINCT CreditFormID
															FROM #COL
														) as tmp
SELECT @cols = substring(@cols, 0, len(@cols))

IF @cols = '' return

--- Load caption hình thức tín dụng 
SELECT DISTINCT * FROM #COL

--- Lấy dữ liệu báo cáo
SET @sSQL = N'
	SELECT DISTINCT	BankID, BankName, CurrencyID,
			(Select SUM(OriginalLimitTotal) From LMT1010 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + '''
			And BankID = A.BankID And CurrencyID = A.CurrencyID' + REPLACE(@sWhere1,'T10.','') + ') as OriginalLimitTotal,
			(Select SUM(ConvertedLimitTotal) From LMT1010 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + '''
			And BankID = A.BankID And CurrencyID = A.CurrencyID' + REPLACE(@sWhere1,'T10.','') + ') as ConvertedLimitTotal,
			CreditFormID, CreditFormName, ExchangeRate, DisOriginalAmount, DisConvertedAmount
	INTO #TAM
	FROM
	(
		SELECT	T10.BankID, T16.BankName, T10.CurrencyID, T01.CreditFormID, T11.CreditFormName,
				AVG(T21.ExchangeRate) as ExchangeRate,SUM(T21.OriginalAmount) as DisOriginalAmount, SUM(ISNULL(T21.ConvertedAmount,0)) as DisConvertedAmount
		FROM LMT1010 T10 WITH (NOLOCK)
		LEFT JOIN LMT2001 T01 WITH (NOLOCK) ON T10.DivisionID = T01.DivisionID And T10.VoucherID = T01.LimitVoucherID
		LEFT JOIN LMT2021 T21 WITH (NOLOCK) ON T01.DivisionID = T21.DivisionID And T01.VoucherID = T21.CreditVoucherID
		LEFT JOIN LMT1001 T11 WITH (NOLOCK) ON T01.CreditFormID = T11.CreditFormID
		LEFT JOIN (Select Distinct ObjectID as BankID, ObjectName as BankName From AT1202 WITH (NOLOCK) Where DivisionID in (''@@@'',''' + @DivisionID + ''') And Disabled = 0) T16 ON T10.BankID = T16.BankID
		WHERE T10.DivisionID = ''' + @DivisionID + ''''+ @sWhere1 + @sWhere + ' AND ISNULL(T01.CreditFormID,'''') <> '''' AND ISNULL(T10.BankID,'''') <> ''''
		GROUP BY T10.BankID, T16.BankName, T10.CurrencyID, T01.CreditFormID, T11.CreditFormName
	) A
	
	SELECT ROW_NUMBER() OVER (ORDER BY BankID, CurrencyID) AS RowNum,  '+@TotalRow+' AS TotalRow, BankID, BankName, CurrencyID,ConvertedLimitTotal,ExchangeRate,'+ @cols +'
	From(
		select BankID, BankName, CurrencyID,ConvertedLimitTotal,ExchangeRate,CreditFormID,DisConvertedAmount
		from #TAM WITH (NOLOCK)
	) src
	pivot 
	(
		SUM(DisConvertedAmount) for CreditFormID in (' + @cols + ')
	) piv
	ORDER BY BankID, CurrencyID
	'

IF @IsExcel = 0
	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)
PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

