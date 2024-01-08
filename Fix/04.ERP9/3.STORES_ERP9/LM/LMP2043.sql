IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2043]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu cho màn hình thanh toán để cập nhật số tiền trả trước hạn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 23/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP2043 'AS','01/20/2017','ABCD',300000000,1,1
*/
----
CREATE PROCEDURE LMP2043 ( 
        @DivisionID VARCHAR(50),
		@VoucherDate DATETIME,
		@DisburseVoucherID VARCHAR(50),
		@BeforeOriginalAmount DECIMAL(28,8),	--- Số tiền trả trước (nguyên tệ)
        @PunishRate DECIMAL(28,8),	--- lãi phạt trả trước
		@ExchangeRate DECIMAL(28,8)
) 
AS 
DECLARE @OriginalMethod TINYINT, --- Phương thức trả gốc
		@ToDate DATETIME,--- ngày đến hạn
		@CostAnaTypeID VARCHAR(3),
		@OAmountEachMonth DECIMAL(28,8),	--- Số tiền gốc phải trả hàng tháng theo lịch trả nợ
		@i INT,
		@ModAmount DECIMAL(28,8),
		@SQL Nvarchar(max)

SELECT @CostAnaTypeID = CostAnaTypeID From AT0000 WITH (NOLOCK) Where DefDivisionID = @DivisionID
  
SELECT	@ToDate = T21.ToDate, @OriginalMethod = T21.OriginalMethod
FROM LMT2021 T21 WITH (NOLOCK)
WHERE T21.DivisionID = @DivisionID
AND T21.VoucherID = @DisburseVoucherID

IF @OriginalMethod = 1 --- trả gốc vào cuối kỳ
BEGIN

	SELECT	PaymentDate, TransactionID as PaymentPlanTransactionID, PaymentName, PaymentType, T99.Description as PaymentTypeName,
			Convert(varchar(10),@VoucherDate,103) as ActualDate, @BeforeOriginalAmount as ActualOriginalAmount , @BeforeOriginalAmount*@ExchangeRate as ActualConvertedAmount,
			T22.PaymentAccountID, T22.CostTypeID, A01.AnaName as CostTypeName
	FROM LMT2022 T22 WITH (NOLOCK)
	LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T22.PaymentType = T99.OrderNo And T99.CodeMaster = 'LMT00000010'
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON T22.CostTypeID = A01.AnaID And A01.AnaTypeID = @CostAnaTypeID
	WHERE T22.DivisionID = @DivisionID AND T22.DisburseVoucherID = @DisburseVoucherID
	AND T22.PaymentType = 0 AND T22.PaymentDate = @ToDate

	UNION ALL --- tiền phạt phí trả trước
	SELECT	NULL as PaymentDate, NULL as PaymentPlanTransactionID, N'Phí trả trước hạn' as PaymentName, 2 as PaymentType,
			(Select Description From LMT0099 WITH (NOLOCK) Where CodeMaster = 'LMT00000010' and OrderNo = 2) as PaymentTypeName,
			Convert(varchar(10),@VoucherDate,103) as ActualDate, @BeforeOriginalAmount * Isnull(@PunishRate,0) as ActualOriginalAmount,
			@BeforeOriginalAmount * Isnull(@PunishRate,0) * @ExchangeRate as ActualConvertedAmount,	NULL as PaymentAccountID, NULL as CostTypeID, NULL as CostTypeName
END

ELSE	--- trả gốc hàng tháng
BEGIN
	--- Lấy số tiền gốc phải thanh toán hàng tháng
	SELECT TOP 1 @OAmountEachMonth = PaymentOriginalAmount
	FROM LMT2022 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID And DisburseVoucherID = @DisburseVoucherID And PaymentType = 0

	SELECT @i = @BeforeOriginalAmount/@OAmountEachMonth	--- số tháng chẵn trả trước gốc
	SELECT @ModAmount = @BeforeOriginalAmount % @OAmountEachMonth	--- số dư
	
	SET @SQL = '
	SELECT TOP ' + LTRIM(@i) + ' PaymentDate INTO #TAM
	FROM LMT2022 T22 WITH (NOLOCK)
	WHERE T22.DivisionID = ''' + @DivisionID + ''' AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + '''
	AND T22.PaymentType = 0 AND NOT EXISTS (Select 1 From LMT2031 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + '''
											AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + ''' AND PaymentPlanTransactionID = T22.TransactionID)
	ORDER BY PaymentDate DESC

	--- Phần tiền dư đưa vào ngày thanh toán kề trên
	SELECT TOP 1 PaymentDate INTO #TAM_DU
	FROM LMT2022 T22 WITH (NOLOCK)
	WHERE T22.DivisionID = ''' + @DivisionID + ''' AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + '''
	AND T22.PaymentType = 0 AND ' + LTRIM(@ModAmount) + ' <> 0
	AND NOT EXISTS (Select 1 From LMT2031 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + '''
					AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + ''' AND PaymentPlanTransactionID = T22.TransactionID)
	AND T22.PaymentDate < (Select Top 1 PaymentDate From #TAM Order by PaymentDate)
	ORDER BY T22.PaymentDate DESC

	--- Update IsNotPayment = 1 đối với các dòng lãi tương ứng các ngày thanh toán trả trước
	UPDATE LMT2022 SET IsNotPayment = 1
	WHERE DivisionID = ''' + @DivisionID + ''' AND DisburseVoucherID = ''' + @DisburseVoucherID + ''' AND PaymentType = 1
	AND EXISTS (Select 1 From #TAM Where PaymentDate = LMT2022.PaymentDate)

	--- Hiển thị danh sách lên màn hình thanh toán
	SELECT ROW_NUMBER() OVER (ORDER BY A.PaymentDate, A.PaymentType) AS RowNum, A.*
	FROM
	(
	SELECT T22.PaymentDate, TransactionID as PaymentPlanTransactionID, T22.PaymentName, T22.PaymentType, T99.Description as PaymentTypeName,
			''' + Convert(varchar(10),@VoucherDate,103) + ''' as ActualDate, ' + LTRIM(@OAmountEachMonth) + ' as ActualOriginalAmount, ' + LTRIM(@OAmountEachMonth*@ExchangeRate) + ' as ActualConvertedAmount,
			T22.PaymentAccountID, T22.CostTypeID, A01.AnaName as CostTypeName
	FROM LMT2022 T22 WITH (NOLOCK)
	INNER JOIN #TAM ON T22.PaymentDate = #TAM.PaymentDate AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + '''
	LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T22.PaymentType = T99.OrderNo And T99.CodeMaster = ''LMT00000010''
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON T22.CostTypeID = A01.AnaID And A01.AnaTypeID = ''' + @CostAnaTypeID + '''
	WHERE T22.DivisionID = ''' + @DivisionID + ''' AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + ''' AND T22.PaymentType = 0
	
	UNION ALL	--- lấy thêm phần dư
	SELECT T22.PaymentDate, TransactionID as PaymentPlanTransactionID, T22.PaymentName, T22.PaymentType, T99.Description as PaymentTypeName,
			''' + Convert(varchar(10),@VoucherDate,103) + ''' as ActualDate, ' + LTRIM(@ModAmount) + ' as ActualOriginalAmount, ' + LTRIM(@ModAmount*@ExchangeRate) + ' as ActualConvertedAmount,
			T22.PaymentAccountID, T22.CostTypeID, A01.AnaName as CostTypeName
	FROM LMT2022 T22 WITH (NOLOCK)
	INNER JOIN #TAM_DU ON T22.PaymentDate = #TAM_DU.PaymentDate AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + '''
	LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T22.PaymentType = T99.OrderNo And T99.CodeMaster = ''LMT00000010''
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON T22.CostTypeID = A01.AnaID And A01.AnaTypeID = ''' + @CostAnaTypeID + '''
	WHERE T22.DivisionID = ''' + @DivisionID + ''' AND T22.DisburseVoucherID = ''' + @DisburseVoucherID + N''' AND T22.PaymentType = 0

	UNION ALL --- tiền phạt phí trả trước
	SELECT	NULL as PaymentDate, NULL as PaymentPlanTransactionID, N''Phạt trước hạn'' AS PaymentName, 2 as PaymentType,
			(Select Description From LMT0099 WITH (NOLOCK) Where CodeMaster = ''LMT00000010'' and OrderNo = 2) as PaymentTypeName,
			''' + Convert(varchar(10),@VoucherDate,103) + ''' as ActualDate, ' + LTRIM(@BeforeOriginalAmount * Isnull(@PunishRate,0)) + ' as ActualOriginalAmount,
			' + LTRIM(@BeforeOriginalAmount * Isnull(@PunishRate,0) * @ExchangeRate) + ' as ActualConvertedAmount, NULL as PaymentAccountID, NULL as CostTypeID, NULL as CostTypeName

	) A
	ORDER BY PaymentDate, PaymentType'

	--PRINT(@SQL)
	EXEC(@SQL)
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

