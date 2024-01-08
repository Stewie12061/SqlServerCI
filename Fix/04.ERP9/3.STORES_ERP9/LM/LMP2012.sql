IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2012]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách hợp đồng vay để hiển thị lên màn hình chọn LMF4444
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 09/07/2017 by Bảo Anh
----Modify by Phương Thảo on 23/01/2018: Chỉnh sửa sp
----Modify by Như Hàn on 18/02/2018: Chỉnh sửa lại Store theo TL
----Modify by Đình Hoà on 09/09/2020: Thêm điều kiện search cho màn hình Thanh toán
----Modify by Đình Hoà on 08/10/2020: Lấy tên ngân hàng và tên đối tượng cho màn hình phong toả(LMF2011)
-- <Example>
/*  
 EXEC LMP2012 'AS','',1,8, 0
 EXEC LMP2012 'AS','',1,8, 1
*/
----
CREATE PROCEDURE LMP2012 ( 
        @DivisionID VARCHAR(50),
		@TxtSearch VARCHAR(250) = '',
		@VoucherNoHDV VARCHAR(250) = '',
		@PageNumber INT,
        @PageSize INT,
		@AdvanceTypeID INT = 0,
		@FormID Varchar(20)
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL VARCHAR (MAX),
		@sSearch VARCHAR (MAX)
		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF(@FormID = 'LMF2021') -- Giai ngan
BEGIN
	SET @sSQL = '
	SELECT	ROW_NUMBER() OVER (ORDER BY T10.VoucherDate, T10.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T10.VoucherID as Column01, T10.VoucherNo as Column02, Convert(varchar(20),T10.VoucherDate,103) as Column03, T01.CreditFormName as Column04, T10.BankAccountID as Column05,
			T10.FromDate as Column06, T10.ToDate as Column07, T10.CurrencyID as Column08,
			T10.ExchangeRate as Column09, T10.OriginalAmount - ISNULL(T12.InheritOriginalAmount,0)  as Column10, 
			T10.ConvertedAmount - ISNULL(T12.InheritConvertedAmount,0)  as Column11, AT1004.Operator as Column12, AT1004.ExchangeRateDecimal as Column13,
			T11.BankID as Column14
	FROM LMT2001 T10 WITH (NOLOCK)
	LEFT JOIN LMT1001 T01 WITH (NOLOCK) On T10.CreditFormID = T01.CreditFormID
	LEFT JOIN AT1004 WITH (NOLOCK) ON T10.CurrencyID = AT1004.CurrencyID
	LEFT JOIN LMT1010 T11 WITH (NOLOCK) On T10.DivisionID = T11.DivisionID And T10.LimitVoucherID = T11.VoucherID
	LEFT JOIN (Select DivisionID, CreditVoucherID, SUM(OriginalAmount) AS InheritOriginalAmount, SUM(ConvertedAmount) AS InheritConvertedAmount 
			   From LMT2021 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+'''  
			   Group by DivisionID, CreditVoucherID
	) T12 ON T10.DivisionID = T12.DivisionID AND T10.VoucherID = T12.CreditVoucherID
	WHERE T10.DivisionID = ''' + @DivisionID + '''
	AND T10.Status <> 9
	AND (ISNULL(T10.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T01.CreditFormName,'''') LIKE ''%'+@TxtSearch+'%''
		OR ISNULL(T10.BankAccountID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T10.CurrencyID,'''') LIKE ''%'+@TxtSearch+'%'')'

	SET @sSQL = @sSQL + '
	ORDER BY T10.VoucherNo, T10.FromDate, T10.ToDate'

	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
ELSE

IF(@FormID in ('LMF2031','LMF2041')) -- Thanh toán
BEGIN
	IF @TxtSearch = '' 
	   SET @TxtSearch = @VoucherNoHDV

	SET @sSQL = '
	SELECT	ROW_NUMBER() OVER (ORDER BY T10.VoucherDate, T10.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T10.VoucherID as Column01, T10.VoucherNo as Column02, Convert(varchar(20),T10.VoucherDate,103) as Column03, T01.CreditFormName as Column04, T10.BankAccountID as Column05,
			T10.FromDate as Column06, T10.ToDate as Column07, T10.CurrencyID as Column08,
			T10.ExchangeRate as Column09, T10.OriginalAmount  as Column10, T10.ConvertedAmount as Column11, 
			AT1004.Operator as Column12, AT1004.ExchangeRateDecimal as Column13, T11.BankID as Column14
	FROM LMT2001 T10 WITH (NOLOCK)
	LEFT JOIN LMT1001 T01 WITH (NOLOCK) On T10.CreditFormID = T01.CreditFormID
	LEFT JOIN AT1004 WITH (NOLOCK) ON T10.CurrencyID = AT1004.CurrencyID
	LEFT JOIN LMT1010 T11 WITH (NOLOCK) On T10.DivisionID = T11.DivisionID And T10.LimitVoucherID = T11.VoucherID	
	WHERE T10.DivisionID = ''' + @DivisionID + '''
	AND T10.Status <> 9
	AND  (ISNULL(T10.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T01.CreditFormName,'''') LIKE ''%'+@TxtSearch+'%''
		OR ISNULL(T10.BankAccountID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T10.CurrencyID,'''') LIKE ''%'+@TxtSearch+'%'')
	AND EXISTS (SELECT TOP 1 1 FROM LMT2021 WHERE T10.DivisionID = LMT2021.DivisionID AND T10.VoucherID = LMT2021.CreditVoucherID)		
		'

	SET @sSQL = @sSQL + '
	ORDER BY T10.VoucherNo, T10.FromDate, T10.ToDate'

	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	PRINT @sSQL
END
ELSE
IF(@FormID = 'LMF2011') -- Phong toa/Giai toa
BEGIN
	IF(@AdvanceTypeID = 0) -- Phong toa
	BEGIN
		SET @sSQL = '
		SELECT	ROW_NUMBER() OVER (ORDER BY T10.VoucherDate, T10.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T10.VoucherID as Column01, T10.VoucherNo as Column02, Convert(varchar(20),T10.VoucherDate,103) as Column03, 
			T01.CreditFormName as Column04, T101.BankAccountID as Column05,
			T10.FromDate as Column06, T10.ToDate as Column07, T10.CurrencyID as Column08, T10.ExchangeRate as Column09,
			--T10.OriginalAmount as Column05, T10.ConvertedAmount as Column06, T10.Description as Column07,
			T10.OriginalAmount as Column10, T10.ConvertedAmount AS Column11,
			AT1004.Operator as Column12, AT1004.ExchangeRateDecimal as Column13, T101.BankID as Column14,
			'''' As Cloumn15,
			'''' As Column16,
			'''' As Column17,
			'''' As Column18,
			'''' As Column19,
			T10.ProjectID AS Column20,
			T101.BankAccountID As Column21, ----- Tài khoản ngân hàng
			T10.ObjectID As Column22, ---- Hiện tại trường này đang lấy theo nhà cung cấp của hợp đồng bảo lãnh
			A02.ObjectName As Column23,
			A02_1.ObjectName As Column24
		FROM LMT2051 T10 WITH (NOLOCK)
		LEFT JOIN LMT1010 T101 WITH (NOLOCK) ON T10.DivisionID = T101.DivisionID And T10.LimitVoucherID = T101.VoucherID
		LEFT JOIN AT1004 WITH (NOLOCK) ON T10.CurrencyID = AT1004.CurrencyID
		LEFT JOIN LMT1001 T01 WITH (NOLOCK) On T10.CreditFormID = T01.CreditFormID
		LEFT JOIN AT1202 A02  WITH (NOLOCK) On T10.ObjectID = A02.ObjectID
		LEFT JOIN AT1202 A02_1  WITH (NOLOCK) On T101.BankID = A02_1.ObjectID
		WHERE T10.DivisionID = ''' + @DivisionID + '''
		AND NOT EXISTS (SELECT TOP 1 1 FROM LMT2011 WITH (NOLOCK) WHERE T10.DivisionID = LMT2011.DivisionID AND T10.VoucherID = LMT2011.CreditVoucherID)
		AND ISNULL(T10.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' '

		SET @sSQL = @sSQL + '
		ORDER BY T10.VoucherNo, T10.FromDate, T10.ToDate'

		Print @sSQL
		SET @sSQL = @sSQL+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE
	BEGIN
		SET @sSQL = '
		SELECT	ROW_NUMBER() OVER (ORDER BY T10.VoucherDate, T10.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T10.VoucherID as Column01, T10.VoucherNo as Column02, Convert(varchar(20),T10.VoucherDate,103) as Column03, 
			T01.CreditFormName as Column04, T101.BankAccountID as Column05,
			T10.FromDate as Column06, T10.ToDate as Column07, T10.CurrencyID as Column08, T10.ExchangeRate as Column09,			
			--T11.OriginalAmount - ISNULL(T12.InheritOriginalAmount,0) as Column10, ISNULL(T11.ConvertedAmount,0) - ISNULL(T12.InheritConvertedAmount,0) AS Column11,
			T10.OriginalAmount AS Column10, T10.ConvertedAmount AS Column11,
			AT1004.Operator as Column12, AT1004.ExchangeRateDecimal as Column13, T101.BankID as Column14,
			T11.AdvanceDate AS Cloumn15, 
			ISNULL(T11.OriginalAmount,0) AS Column16, ---- Giá trị phong tỏa (nguyên tệ)
			ISNULL(T11.ConvertedAmount,0) AS Column17, ---- Giá trị phong tỏa (quy đổi)
			ISNULL(T11.ConvertedAmount,0) - ISNULL(T12.InheritConvertedAmount,0) AS Column18, ---- Giá trị phong tỏa còn lại
			ISNULL(T12.InheritConvertedAmount,0) As Column19, ---- Giá trị đã giải tỏa
			T10.ProjectID AS Column20,
			T101.BankAccountID As Column21, ----- Tài khoản ngân hàng
			T10.ObjectID As Column22 ---- Hiện tại trường này đang lấy theo nhà cung cấp của hợp đồng bảo lãnh
		FROM LMT2051 T10 WITH (NOLOCK)
		LEFT JOIN LMT1010 T101 WITH (NOLOCK) ON T10.DivisionID = T101.DivisionID And T10.LimitVoucherID = T101.VoucherID
		LEFT JOIN AT1004 WITH (NOLOCK) ON T10.CurrencyID = AT1004.CurrencyID
		LEFT JOIN LMT1001 T01 WITH (NOLOCK) On T10.CreditFormID = T01.CreditFormID	
		LEFT JOIN LMT2011 T11 WITH (NOLOCK) ON T10.DivisionID = T11.DivisionID AND T10.VoucherID = T11.CreditVoucherID AND ISNULL(AdvanceTypeID,0) = 0
		LEFT JOIN (Select DivisionID, CreditVoucherID, SUM(OriginalAmount) AS InheritOriginalAmount, SUM(ConvertedAmount) AS InheritConvertedAmount 
			From LMT2011 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND ISNULL(AdvanceTypeID,0) = 1 
			Group by DivisionID, CreditVoucherID
		) T12 ON T10.DivisionID = T12.DivisionID AND T10.VoucherID = T12.CreditVoucherID	
		WHERE T10.DivisionID = ''' + @DivisionID + '''
		--AND EXISTS (SELECT TOP 1 1 FROM LMT2011 WITH (NOLOCK) WHERE T10.DivisionID = LMT2011.DivisionID AND T10.VoucherID = LMT2011.CreditVoucherID)
		AND ISNULL(T10.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' 
		AND ISNULL(T11.VoucherID,'''') <> '''' AND ISNULL(T11.ConvertedAmount,0) - ISNULL(T12.InheritConvertedAmount,0) > 0
		'

		SET @sSQL = @sSQL + '
		ORDER BY T10.VoucherNo, T10.FromDate, T10.ToDate'

		SET @sSQL = @sSQL+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END	
END


--PRINT @sSQL
EXEC(@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

