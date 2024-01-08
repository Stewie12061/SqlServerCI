IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7300]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7300]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tạo view sử dụng trong phần in bảng cân đối phát sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Gọi bởi AP7301
-- <History>
---- Create on 21/07/03 by Nguyen Van Nhan
---- Modified on 29/07/2010 by Việt Khánh
---- Modified on 30/12/2011 by Nguyễn Bình Minh (PRT0173): Sửa lỗi lấy số đầu kỳ không đúng do lấy sai điều kiện và sửa lại các điều kiện cho chuẩn
---- Modified on 08/03/2012 by Lê Thị Thu Hiền : Bổ sung Z00 số dư đầu kỳ của tài khoản ngoại bảng
---- Modified on 19/10/2012 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
---- Modified on 05/11/2012 by Lê Thị Thu Hiền : Không Group theo DivisionID
---- Modified on 10/12/2012 by Bảo Anh : Sửa lỗi Số tiền Có lên sai đối với bút toán ngoại bảng (dùng AV9004.SignConvertedAmount thay cho AV9004.ConvertedAmount)
---- Modified on 05/11/2012 by Lê Thị Thu Hiền : LEFT JOIN bảng DivisionID kết với @DivisionID (0019537 )
---- Modified on 14/04/2016 by Bảo Anh: Bổ sung with nolock
---- Modified by Bảo Thy on 24/05/2017: Sửa danh mục dùng chung
---- Modified on 19/06/2017 by Bảo Anh:	Bổ sung in theo ngày
----									Loại trừ TK 024910 ra khỏi báo cáo(customize Bông Sen)
---- Modified on 30/09/2020 by Nhựt Trường: Customize Tiên Tiến - Lấy tỉ giá từ AT1012 và tính toán lại khi KH sử dụng nguyên tệ khác VND.
---- Modified on 18/11/2020 by Văn Tài	  : Format sql, không thay đổi về code.
---- Modified on 24/11/2020 by Văn Tài	  : Customize [TIENTIEN] Xử lý tính nhiều loại tiền theo Division AA.
---- Modified on 01/04/2021 by Huỳnh Thử  :	Customize [TIENTIEN] -- print nhiều DivisionID
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP7300]
(
    @DivisionID AS NVARCHAR(50), 
    @TranMonthFrom AS INT, 
    @TranYearFrom AS INT, 
    @TranMonthTo AS INT, 
    @TranYearTo AS INT,
    @StrDivisionID AS NVARCHAR(4000) = '',
	@IsDate as tinyint = 0,
	@FromDate Datetime = null,
	@ToDate Datetime = null,
	@ReportDate AS DATETIME
)    
AS

DECLARE @strSQL1 NVARCHAR(4000), 
		@strSQL2 NVARCHAR(4000), 
		@PeriodFrom AS INT, 
		@PeriodTo AS INT,
		@CustomerIndex INT,
		@CustomerName INT,
		@ReportDivisionID VARCHAR(50)
		
SELECT @CustomerIndex = CustomerName FROM CustomerIndex

DECLARE @StrDivisionID_New AS NVARCHAR(4000)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + REPLACE(@StrDivisionID, ',',''',''') + ''')' END
    
If @IsDate = 0
Begin
	SET @PeriodFrom = @TranYearFrom * 100 + @TranMonthFrom
	SET @PeriodTo = @TranYearTo * 100 + @TranMonthTo
End
Else
Begin
	SET @TranYearFrom = Year(@FromDate)
End

----------------------------------------------> Customize Tiên Tiến <------------------------------------------------------
If(@CustomerName = 13) -- Tiên Tiến 
BEGIN
	IF(@DivisionID <> 'AA')
	BEGIN
		SET @ReportDivisionID = 'AAAAAAAAAA'
	END
	ELSE
	BEGIN
		SET @ReportDivisionID  = @DivisionID
	END

	If @IsDate = 0 
	Begin
		SET @strSQL1 = '
		SELECT		V01.DivisionID AS DivisionID
				, V01.AccountID
				, T1.AccountName
				, T1.AccountNameE
				, SUM((ISNULL(ConvertedAmount, 0)) * ISNULL(AT1012.ExchangeRate, 1)) AS Closing
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) < ''' + STR(@PeriodFrom) + ''' 
								OR V01.TransactionTypeID IN ( ''T00'', ''Z00'') 
							THEN ISNULL(ConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS Opening
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
									AND V01.D_C = ''D'' 
									AND (V01.TransactionTypeID NOT IN ( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodDebit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN ( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0) * (-1) ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodCredit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(ConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS AccumulatedDebit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(ConvertedAmount, 0) * (-1) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS AccumulatedCredit
				, ISNULL(AT1012.ExchangeRate, 1) AS ExchangeRate
				, AT1012.ExchangeDate 
		FROM AV4201 AS V01
		INNER JOIN AT1005 AS T1 WITH (NOLOCK) ON T1.AccountID = V01.AccountID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = V01.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
											AND AT1012.DivisionID '+@StrDivisionID_New+'
											AND AT1012.ExchangeDate = ''' + LTRIM(@ReportDate) + '''		
		WHERE V01.DivisionID '+@StrDivisionID_New+' AND T1.GroupID <> ''G00''
				AND (V01.TranYear * 100 + V01.TranMonth <= ''' + STR(@PeriodTo) + ''' 
						OR V01.TransactionTypeID IN ( ''T00'', ''Z00'')
					)
		'

		SET @strSQL1 = @strSQL1 + '
		GROUP BY	V01.DivisionID,
					V01.AccountID
					, T1.AccountName
					, T1.AccountNameE
					, AT1012.ExchangeRate
					, AT1012.ExchangeDate	
		'
		----------------------------- PHAN TAI KHOAN NGOAI BANG ---------------------------------------------------------------------------------------------------------------------------------
		SET @strSQL2 = '
		UNION ALL 
		SELECT		'''+@DivisionID +''' AS DivisionID
				, V01.AccountID
				, T1.AccountName
				, T1.AccountNameE
				, SUM((ISNULL(SignConvertedAmount, 0)) * ISNULL(AT1012.ExchangeRate, 1)) AS Closing
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) < ''' + STR(@PeriodFrom) + ''' 
								OR V01.TransactionTypeID IN (''T00'', ''Z00'') THEN ISNULL(SignConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS Opening
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
							THEN ISNULL(SignConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodDebit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(SignConvertedAmount, 0) * (-1) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodCredit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(SignConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS AccumulatedDebit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(SignConvertedAmount, 0) * (-1) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS AccumulatedCredit
  			   , ISNULL(AT1012.ExchangeRate, 1) AS ExchangeRate
			   , AT1012.ExchangeDate
		FROM AV9004 AS V01 
		INNER JOIN AT1005 AS T1 WITH (NOLOCK) ON T1.AccountID = V01.AccountID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = V01.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
											AND AT1012.DivisionID '+@StrDivisionID_New+'
											AND AT1012.ExchangeDate = ''' + LTRIM(@ReportDate) + '''
		WHERE	V01.DivisionID '+@StrDivisionID_New+'
				AND (V01.TranYear * 100 + V01.TranMonth <= ''' + STR(@PeriodTo) + ''' OR V01.TransactionTypeID IN( ''T00'', ''Z00''))'

		SET @strSQL2 = @strSQL2 + '
		GROUP BY	V01.AccountID
					, T1.AccountName
					, T1.AccountNameE
					, AT1012.ExchangeRate
					, AT1012.ExchangeDate
		'
	END
	ELSE -- IN THEO NGAY
	BEGIN
		SET @strSQL1 = '
		SELECT		V01.DivisionID AS DivisionID
				, V01.AccountID
				, T1.AccountName
				, T1.AccountNameE
				, SUM((ISNULL(SignAmount, 0)) * ISNULL(AT1012.ExchangeRate,1)) AS Closing
				, SUM((CASE WHEN V01.VoucherDate < ''' + LTRIM(@FromDate) + ''' 
								OR V01.TransactionTypeID IN( ''T00'', ''Z00'') 
							THEN ISNULL(SignAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate,1)) AS Opening
				, SUM((CASE WHEN V01.VoucherDate >= ''' + LTRIM(@FromDate) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
							THEN ISNULL(ConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodDebit
				, SUM((CASE WHEN V01.VoucherDate >= ''' + LTRIM(@FromDate) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(ConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodCredit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(ConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS AccumulatedDebit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(ConvertedAmount, 0)
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate,1)) AS AccumulatedCredit
   			   , ISNULL(AT1012.ExchangeRate, 1) AS ExchangeRate
			   , AT1012.ExchangeDate
		FROM AV5000 AS V01
		INNER JOIN	AT1005 AS T1 WITH (NOLOCK) ON T1.AccountID = V01.AccountID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = V01.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
											AND AT1012.DivisionID '+@StrDivisionID_New+'
											AND AT1012.ExchangeDate = ''' + LTRIM(@ReportDate) + '''
		WHERE	V01.DivisionID ' + @StrDivisionID_New + ' AND T1.GroupID <> ''G00''
				AND (V01.VoucherDate <= ''' + LTRIM(@ToDate) + ''' OR V01.TransactionTypeID IN (''T00'', ''Z00''))
		'
						
		SET @strSQL1 = @strSQL1 + '
		GROUP BY	V01.DivisionID,
					V01.AccountID
					, T1.AccountName
					, T1.AccountNameE
					, AT1012.ExchangeRate
					, AT1012.ExchangeDate
		'
		----------------------------- PHAN TAI KHOAN NGOAI BANG ---------------------------------------------------------------------------------------------------------------------------------
		SET @strSQL2 = '
		UNION ALL 
		SELECT		'''+@DivisionID +''' AS DivisionID
				, V01.AccountID
				, T1.AccountName
				, T1.AccountNameE
				, SUM((ISNULL(SignConvertedAmount, 0)) * ISNULL(AT1012.ExchangeRate, 1)) AS Closing
				, SUM((CASE WHEN V01.VoucherDate < ''' + ltrim(@FromDate) + '''
								OR V01.TransactionTypeID IN (''T00'', ''Z00'') 
							THEN ISNULL(SignConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate,1)) AS Opening
				, SUM((CASE WHEN V01.VoucherDate >= ''' + ltrim(@FromDate) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
							THEN ISNULL(SignConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate,1)) AS PeriodDebit
				, SUM((CASE WHEN V01.VoucherDate >= ''' + ltrim(@FromDate) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(SignConvertedAmount, 0) * (-1) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS PeriodCredit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN (''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
							THEN ISNULL(SignConvertedAmount, 0) 
							ELSE 0 END) * ISNULL(AT1012.ExchangeRate, 1)) AS AccumulatedDebit
				, SUM((CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) * (-1) 
					ELSE 0 END) * ISNULL(AT1012.ExchangeRate,1)) AS AccumulatedCredit
			   , ISNULL(AT1012.ExchangeRate,1) AS ExchangeRate
			   , AT1012.ExchangeDate
		FROM AV9004 AS V01 
		INNER JOIN	AT1005 AS T1 WITH (NOLOCK) ON T1.AccountID = V01.AccountID
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = V01.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 		
											AND AT1012.DivisionID  '+@StrDivisionID_New+'
											AND AT1012.ExchangeDate LIKE''' + LTRIM(@ReportDate) + '''
		WHERE V01.DivisionID '+@StrDivisionID_New+'
				AND (V01.VoucherDate <= ''' + LTRIM(@ToDate) + ''' OR V01.TransactionTypeID IN( ''T00'', ''Z00''))'

		SET @strSQL2 = @strSQL2 + '
		GROUP BY	V01.AccountID
					, T1.AccountName
					, T1.AccountNameE
					, AT1012.ExchangeRate
					, AT1012.ExchangeDate
		'
	End
END
------------------------------------------> [END] - Customize Tiên Tiến <-------------------------------------------------
ELSE
BEGIN
	If @IsDate = 0 
	Begin
		SET @strSQL1 = '
		SELECT		'''+@DivisionID +''' AS DivisionID,
				V01.AccountID,
				T1.AccountName,
				T1.AccountNameE,
				SUM(ISNULL(ConvertedAmount, 0)) AS Closing,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) < ''' + STR(@PeriodFrom) + ''' 
								OR V01.TransactionTypeID IN( ''T00'', ''Z00'') THEN ISNULL(ConvertedAmount, 0) 
					ELSE 0 END) AS Opening,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS PeriodDebit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS AccumulatedDebit,
			   SUM(	CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0) * (-1) 
					ELSE 0 END) AS AccumulatedCredit
		FROM		AV4201 AS V01
		INNER JOIN	AT1005 AS T1 with (nolock) ON  T1.AccountID = V01.AccountID
		WHERE	V01.DivisionID '+@StrDivisionID_New+' AND T1.GroupID <> ''G00''
				AND (V01.TranYear * 100 + V01.TranMonth <= ''' + STR(@PeriodTo) + ''' OR V01.TransactionTypeID IN( ''T00'', ''Z00''))'

		IF @CustomerIndex = 78 --- Customize Bông Sen
			SET @strSQL1 = @strSQL1 + ' AND V01.AccountID<>''024910'''

		SET @strSQL1 = @strSQL1 + '
		GROUP BY	V01.AccountID,
					T1.AccountName,
					T1.AccountNameE
		'
		----------------------------- PHAN TAI KHOAN NGOAI BANG ---------------------------------------------------------------------------------------------------------------------------------
		SET @strSQL2 = '
		UNION ALL 
		SELECT		'''+@DivisionID +''' AS DivisionID,
				V01.AccountID,
				T1.AccountName,
				T1.AccountNameE,
				SUM(ISNULL(SignConvertedAmount, 0)) AS Closing,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) < ''' + STR(@PeriodFrom) + ''' 
								OR V01.TransactionTypeID IN( ''T00'', ''Z00'') THEN ISNULL(SignConvertedAmount, 0) 
					ELSE 0 END) AS Opening,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(SignConvertedAmount, 0) ELSE 0 END) AS PeriodDebit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@PeriodFrom) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) ELSE 0 END) AS AccumulatedDebit,
			   SUM(	CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) * (-1) 
					ELSE 0 END) AS AccumulatedCredit
		FROM		AV9004 AS V01 
		INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID
		WHERE	V01.DivisionID '+@StrDivisionID_New+'
				AND (V01.TranYear * 100 + V01.TranMonth <= ''' + STR(@PeriodTo) + ''' OR V01.TransactionTypeID IN( ''T00'', ''Z00''))'

		IF @CustomerIndex = 78 --- Customize Bông Sen
			SET @strSQL2 = @strSQL2 + ' AND V01.AccountID<>''024910'''

		SET @strSQL2 = @strSQL2 + '
		GROUP BY	V01.AccountID, T1.AccountName, T1.AccountNameE
		'
	End
	Else -- In theo ngay
	Begin
		SET @strSQL1 = '
		SELECT		'''+@DivisionID +''' AS DivisionID,
				V01.AccountID,
				T1.AccountName,
				T1.AccountNameE,
				SUM(ISNULL(SignAmount, 0)) AS Closing,
				SUM(CASE WHEN V01.VoucherDate < ''' + ltrim(@FromDate) + ''' 
								OR V01.TransactionTypeID IN( ''T00'', ''Z00'') THEN ISNULL(SignAmount, 0) 
					ELSE 0 END) AS Opening,
				SUM(CASE WHEN V01.VoucherDate >= ''' + ltrim(@FromDate) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS PeriodDebit,
				SUM(CASE WHEN V01.VoucherDate >= ''' + ltrim(@FromDate) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS PeriodCredit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS AccumulatedDebit,
			   SUM(	CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(ConvertedAmount, 0)
					ELSE 0 END) AS AccumulatedCredit
		FROM		AV5000 AS V01
		INNER JOIN	AT1005 AS T1 with (nolock)	ON  T1.AccountID = V01.AccountID
		WHERE	V01.DivisionID '+@StrDivisionID_New+' AND T1.GroupID <> ''G00''
				AND (V01.VoucherDate <= ''' + ltrim(@ToDate) + ''' OR V01.TransactionTypeID IN( ''T00'', ''Z00''))'

		IF @CustomerIndex = 78 --- Customize Bông Sen
			SET @strSQL1 = @strSQL1 + ' AND V01.AccountID<>''024910'''

		SET @strSQL1 = @strSQL1 + '
		GROUP BY	V01.AccountID,
					T1.AccountName,
					T1.AccountNameE
		'
		----------------------------- PHAN TAI KHOAN NGOAI BANG ---------------------------------------------------------------------------------------------------------------------------------
		SET @strSQL2 = '
		UNION ALL 
		SELECT		'''+@DivisionID +''' AS DivisionID,
				V01.AccountID,
				T1.AccountName,
				T1.AccountNameE,
				SUM(ISNULL(SignConvertedAmount, 0)) AS Closing,
				SUM(CASE WHEN V01.VoucherDate < ''' + ltrim(@FromDate) + '''
								OR V01.TransactionTypeID IN( ''T00'', ''Z00'') THEN ISNULL(SignConvertedAmount, 0) 
					ELSE 0 END) AS Opening,
				SUM(CASE WHEN V01.VoucherDate >= ''' + ltrim(@FromDate) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(SignConvertedAmount, 0) ELSE 0 END) AS PeriodDebit,
				SUM(CASE WHEN V01.VoucherDate >= ''' + ltrim(@FromDate) + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) ELSE 0 END) AS AccumulatedDebit,
			   SUM(	CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ''' + STR(@TranYearFrom * 100 + 1) + '''
							   AND V01.D_C = ''C'' AND (V01.TransactionTypeID NOT IN( ''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignConvertedAmount, 0) * (-1) 
					ELSE 0 END) AS AccumulatedCredit
		FROM		AV9004 AS V01 
		INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID
		WHERE	V01.DivisionID '+@StrDivisionID_New+'
				AND (V01.VoucherDate <= ''' + ltrim(@ToDate) + ''' OR V01.TransactionTypeID IN( ''T00'', ''Z00''))'

		IF @CustomerIndex = 78 --- Customize Bông Sen
			SET @strSQL2 = @strSQL2 + ' AND V01.AccountID<>''024910'''

		SET @strSQL2 = @strSQL2 + '
		GROUP BY	V01.AccountID, T1.AccountName, T1.AccountNameE
		'
	End
END

Print @strSQL1 
Print @strSQL2
IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4207' AND SYSOBJECTS.XTYPE = 'V')
    EXEC('CREATE VIEW AV4207 AS ' + @strSQL1 + @strSQL2)
ELSE
    EXEC('ALTER VIEW AV4207 AS ' + @strSQL1 + @strSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
