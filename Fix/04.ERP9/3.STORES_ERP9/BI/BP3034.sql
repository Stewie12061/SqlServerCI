IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo SALES
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ  Báo cáo SALES
-- <History>
---- Created by Thành Luân 13/05/2020: Báo cáo SALES.
---- Updated by Thành Luân 13/08/2020: Sửa lỗi in doanh thu sai.
---- Updated by Thành Luân 14/09/2020: Fix lỗi alias A1.PlanTypeID => PlanTypeID
-- <Example>
/*
 exec BP3034 @DivisionID = 'CM', @DivisionIDList = '', @ObjectID = NULL, @AccountID = NULL, @CurrencyID = NULL, @Date='2020-05-13', @UserID = 'Test'
*/

CREATE PROCEDURE BP3034
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@Date				DATETIME,
	--@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	--@FromDate			DATETIME, 
	--@ToDate				DATETIME, 
	--@PeriodIDList		NVARCHAR(2000),
	@ObjectID				NVARCHAR(MAX) = NULL,
	@AccountID			NVARCHAR(MAX) = NULL,
	@CurrencyID		NVARCHAR(MAX) = NULL,
	@UserID				VARCHAR(50)
)
AS
SET NOCOUNT ON

DECLARE @TranMonth INT,
		@TranYear INT,
		@IID VARCHAR(50);
		--@CurrentDate DATE;

SET @TranYear = YEAR(@Date);
SET @TranMonth = MONTH(@Date);
SET @IID = 'I02';

--SET @CurrentDate = GETDATE();

--DECLARE @FromDateToDateList TABLE(
--	FromDate DATE,
--	ToDate DATE
--);

-- Bảng Divisions
DECLARE @Divisions TABLE (
	DivisionID NVARCHAR(50)
);

DECLARE @Objects TABLE(
	ObjectID NVARCHAR(50)
);

DECLARE @Accounts TABLE(
	AccountID NVARCHAR(50)
);

-- Danh sách tháng trong quý
DECLARE @Quarters TABLE(
	TranMonth INT
);

DECLARE @CurrencyTypes TABLE(
	CurrencyID NVARCHAR(50)
);

DECLARE @AT1015 TABLE(
	DivisionID NVARCHAR(50),
	AnaID NVARCHAR(50),
	AnaTypeID NVARCHAR(50),
	AnaName NVARCHAR(250)
);

-- Bảng doanh thu dự kiến cho năm
DECLARE @ExpectedRevenueInMonthAmount TABLE(
	AnaID NVARCHAR(50),
	AnaName NVARCHAR(50),
	TranYear INT,
	TranMonth INT,
	EstimateConvertedAmount DECIMAL(28,8),
	PlanTypeID NVARCHAR(50)
);

--IF @IsDate = 1
--BEGIN
--	INSERT INTO @FromDateToDateList
--	SELECT DATEFROMPARTS(
--		CONVERT(INT, LTRIM(RTRIM(SUBSTRING(A.Value, (CHARINDEX('/',A.Value)+1), (LEN(A.Value)-1))))),
--		CONVERT(INT, LTRIM(RTRIM(SUBSTRING(A.Value, 1, (CHARINDEX('/',A.Value)-1))))),
--		1
--	) AS FromDate,
--	EOMONTH(
--		DATEFROMPARTS(
--			CONVERT(INT, LTRIM(RTRIM(SUBSTRING(A.Value, (CHARINDEX('/',A.Value)+1), (LEN(A.Value)-1))))),
--			CONVERT(INT, LTRIM(RTRIM(SUBSTRING(A.Value, 1, (CHARINDEX('/',A.Value)-1))))),
--			1
--		)
--	) AS ToDate
--	FROM (
--		SELECT Value FROM [dbo].StringSplit(REPLACE(COALESCE(@PeriodIDList, @PeriodIDList), '''', ''), ',')
--	) AS A
--END
--ELSE
--BEGIN
--	INSERT INTO @FromDateToDateList VALUES(@FromDate, @ToDate)
--END

-- Lấy danh sách tháng trong quý
IF @TranMonth < 4 -- Quý 1
BEGIN
	INSERT INTO @Quarters VALUES(1);
	INSERT INTO @Quarters VALUES(2);
	INSERT INTO @Quarters VALUES(3);
END
ELSE IF @TranMonth < 7 -- Quý 2
BEGIN
	INSERT INTO @Quarters VALUES(4);
	INSERT INTO @Quarters VALUES(5);
	INSERT INTO @Quarters VALUES(6);
END
ELSE IF  @TranMonth < 10 -- Quý 3
BEGIN
	INSERT INTO @Quarters VALUES(7);
	INSERT INTO @Quarters VALUES(8);
	INSERT INTO @Quarters VALUES(9);
END
ELSE -- Quý 4
BEGIN
	INSERT INTO @Quarters VALUES(10);
	INSERT INTO @Quarters VALUES(11);
	INSERT INTO @Quarters VALUES(12);
END

INSERT INTO @Divisions
SELECT * FROM [dbo].StringSplit(REPLACE(COALESCE(@DivisionIDList, @DivisionID), '''', ''), ',');

INSERT INTO @Objects
SELECT * FROM [dbo].StringSplit(REPLACE(COALESCE(@ObjectID, ''), '''', ''), ',');

INSERT INTO @Accounts
SELECT * FROM [dbo].StringSplit(REPLACE(COALESCE(@AccountID, ''), '''', ''), ',');

---- Công nợ mã phân tích mặt hàng
------ Số dư
--- Phát sinh nợ
SELECT AT9000.DivisionID, TranMonth,TranYear,
		CurrencyIDCN, VoucherDate, InvoiceDate, DueDate,
		AT1302.I02ID,
		AT9000.DebitAccountID AS AccountID, AT1005.AccountName,
		SUM(COALESCE(ConvertedAmount, 0)) AS ConvertedAmount,
		SUM(COALESCE(OriginalAmountCN, 0)) AS OriginalAmount,

		-- Tài khoản đối ứng
		CreditAccountID AS CorAccountID,
		'D' AS D_C, TransactionTypeID
INTO #AV03081
FROM AT9000 WITH (NOLOCK)
 INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.DebitAccountID
 LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
 LEFT JOIN AT1015 I2 WITH (NOLOCK) ON AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = @IID
WHERE
		AT9000.DivisionID IN (SELECT DivisionID FROM @Divisions)
		AND AT9000.DebitAccountID IS NOT NULL
		AND (COALESCE(@AccountID, '') = '' OR AT9000.DebitAccountID IN (SELECT * FROM @Accounts))
		AND (COALESCE(@ObjectID, '') = '' OR AT9000.ObjectID IN (SELECT * FROM @Objects))
		AND ((AT9000.VoucherDate = @Date AND AT9000.TransactionTypeID = 'T00')
			OR (AT9000.VoucherDate < @Date))
		AND (COALESCE(@CurrencyID, '') = '' OR AT9000.CurrencyIDCN IN (SELECT * FROM @CurrencyTypes))
		AND AT1005.GroupID  in ('G03', 'G04')
GROUP BY AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear,
		CurrencyIDCN, VoucherDate, InvoiceDate, DueDate,
		DebitAccountID, AT1005.AccountName,	CreditAccountID,
		TransactionTypeID, AT1302.I02ID
UNION ALL

---- Phát sinh có, lấy âm
SELECT
	AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear,
	CurrencyIDCN,VoucherDate, InvoiceDate, DueDate,
	AT1302.I02ID,
	AT9000.CreditAccountID AS AccountID, AT1005.AccountName,
	SUM(COALESCE(ConvertedAmount,0)*-1) AS ConvertedAmount, 
	SUM(COALESCE(OriginalAmountCN,0)*-1) AS OriginalAmount,
	DebitAccountID AS CorAccountID,
	'C' AS D_C, TransactionTypeID
FROM AT9000  WITH (NOLOCK)
INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1015 I2 WITH (NOLOCK) ON AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = @IID
WHERE
		AT9000.DivisionID IN (SELECT DivisionID FROM @Divisions)
		AND AT9000.CreditAccountID IS NOT NULL
		AND (COALESCE(@AccountID, '') = '' OR AT9000.CreditAccountID IN (SELECT * FROM @Accounts))
		AND (COALESCE(@ObjectID, '') = '' OR COALESCE(AT9000.CreditObjectID,AT9000.ObjectID) IN (SELECT * FROM @Objects))
		AND ((AT9000.VoucherDate = @Date AND AT9000.TransactionTypeID = 'T00')
			OR (AT9000.VoucherDate < @Date))
		AND (COALESCE(@CurrencyID, '') = '' OR AT9000.CurrencyIDCN IN (SELECT * FROM @CurrencyTypes))
		AND AT1005.GroupID IN ('G03', 'G04')
GROUP BY AT9000.DivisionID, TranMonth, TranYear,
		(CASE WHEN TransactionTypeID = 'T99' THEN CreditObjectID ELSE ObjectID END),
		CurrencyIDCN, VoucherDate, InvoiceDate, DueDate,
		CreditAccountID, AT1005.AccountName, DebitAccountID,
		TransactionTypeID, AT9000.InventoryID, AT1302.I02ID

		SELECT 'T00' AS TransactionTypeID, AV4202.I02ID, I2.AnaName,
			   '%' AS CurrencyID,
			   SUM(ConvertedAmount) AS OpeningConvertedAmount,
			   SUM(OriginalAmount) AS OpeningOriginalAmount,
			   AV4202.DivisionID
		INTO #AV0328
		FROM #AV03081 AV4202
		LEFT JOIN AT1015 I2 WITH (NOLOCK) on AV4202.I02ID = I2.AnaID AND I2.AnaTypeID = @IID
		GROUP BY AV4202.DivisionID, AV4202.I02ID, I2.AnaName

------ Phát sinh
SELECT 	AT9000.Orders,
		TransactionTypeID,		
		VoucherDate, VoucherNo, VoucherTypeID,
		AT1302.I02ID, I2.AnaName AS I02Name,
		COALESCE(AT1010.VATRate,0) AS VATRate,
		AT9000.InvoiceDate, AT9000.InvoiceNo, AT9000.Serial, AT9000.DueDate,
		OriginalAmount AS DebitOriginalAmount,
		ConvertedAmount AS DebitConvertedAmount, 
		COALESCE(Quantity,0) AS DebitQuantity, 
		UnitPrice AS DebitUnitPrice,
		0 AS CreditOriginalAmount,
		0 AS CreditConvertedAmount,
		0 AS CreditQuantity, AT9000.DivisionID
-- Bảng tạm phát sinh
INTO #AV0318
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT9000.ObjectID
LEFT JOIN AT1010 WITH (NOLOCK) on AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = @IID
WHERE ((TransactionTypeID <> 'T00' AND TransactionTypeID NOT IN ('T24','T34')
		AND (COALESCE(@AccountID, '') = '' OR DebitAccountID IN (SELECT * FROM @Accounts))) OR
		(TransactionTypeID in ('T24','T34') AND (COALESCE(@AccountID, '') = '' OR DebitAccountID IN (SELECT * FROM @Accounts)))) AND 
		AT9000.DivisionID IN (SELECT DivisionID FROM @Divisions) AND
		((COALESCE(@ObjectID, '') = '' OR AT9000.ObjectID IN (SELECT * FROM @Objects)) AND AT1202.Disabled = 0) AND
		(COALESCE(@CurrencyID, '') = '' OR CurrencyIDCN IN (SELECT * FROM @CurrencyTypes)) AND (AT9000.VoucherDate = @Date)  
UNION ALL
SELECT 999 AS Orders,
		TransactionTypeID,
		VoucherDate, VoucherNo,VoucherTypeID,
		AT1302.I02ID, I2.AnaName AS I02Name,
		isnull(AT1010.VATRate,0) AS VATRate,
		AT9000.InvoiceDate, AT9000.InvoiceNo, AT9000.Serial, AT9000.DueDate,
		0 AS DebitOriginalAmount,
		0 AS DebitConvertedAmount,
		0 AS DebitQuantity,
		0 AS DebitUnitPrice,
		SUM(OriginalAmount) AS CreditOriginalAmount,
		SUM(ConvertedAmount) AS CreditConvertedAmount,
		SUM(COALESCE(Quantity,0)) AS CreditQuantity, AT9000.DivisionID
FROM AT9000  WITH (NOLOCK)
 LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.InventoryID = AT9000.InventoryID
 LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT9000.ObjectID
 LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = @IID
 LEFT JOIN AT1010 WITH (NOLOCK) on AT1010.VATGroupID = AT9000.VATGroupID
 LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AT9000.CreditAccountID
WHERE ((TransactionTypeID <>'T00' AND TransactionTypeID NOT IN ('T24','T34')
		AND (COALESCE(@AccountID, '') = '' OR CreditAccountID IN (SELECT * FROM @Accounts))) OR
		(TransactionTypeID IN ('T24','T34') AND (COALESCE(@AccountID, '') = '' OR CreditAccountID IN (SELECT * FROM @Accounts)))) AND
		AT9000.DivisionID IN (SELECT DivisionID FROM @Divisions) AND
		(((COALESCE(@ObjectID, '') = '' OR CreditObjectID IN (SELECT * FROM @Objects)) AND TransactiontypeID<>'T99')		
			OR ((COALESCE(@ObjectID, '') = '' OR CreditObjectID IN (SELECT * FROM @Objects)) AND TransactiontypeID='T99')
		) AND (COALESCE(@CurrencyID, '') = '' OR CurrencyIDCN IN (SELECT * FROM @CurrencyTypes))
		  AND (AT9000.VoucherDate = @Date)
		  AND AT1005.GroupID IN ('G03')
GROUP BY TransactionTypeID, AT1010.VATRate,
		 VoucherDate,VoucherNo,VoucherTypeID,VoucherID,
		 AT1302.I02ID, I2.AnaName,
		 AT9000.InvoiceDate, AT9000.InvoiceNo, AT9000.Serial, AT9000.DueDate,
		 AT9000.DivisionID
---end

SELECT 	AV0318.Orders,
		AV0318.TransactionTypeID,		
		VoucherDate,
		DueDate,
		VoucherNo,
		VoucherTypeID,
		AV0318.I02ID AnaID, AV0318.I02Name AnaName,
		AV0318.VATRate,
		InvoiceDate,
		InvoiceNo,
		Serial,
		DebitQuantity,
		DebitUnitPrice,
		COALESCE(DebitOriginalAmount,0) AS DebitOriginalAmount,
		COALESCE(DebitConvertedAmount,0) AS DebitConvertedAmount,
		COALESCE(CreditOriginalAmount,0) AS CreditOriginalAmount,
		COALESCE(CreditConvertedAmount,0) AS CreditConvertedAmount,
		COALESCE(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
		COALESCE(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
		COALESCE(CreditQuantity,0) AS CreditQuantity,
		COALESCE(AV0318.DivisionID,AV0328.DivisionID) AS DivisionID
INTO #AP0308_AV0314
FROM #AV0318 AV0318
 LEFT JOIN #AV0328 AV0328 ON COALESCE(AV0318.I02ID,'') = COALESCE(AV0328.I02ID,'') AND AV0318.DivisionID = AV0328.DivisionID

----cong no ma phan tich mat hang

-- Insert ana vào bảng tạm
INSERT INTO @AT1015
SELECT DivisionID, AnaID, AnaTypeID, AnaName
FROM AT1015 WITH(NOLOCK)
WHERE DivisionID = '@@@' OR DivisionID IN (Select DivisionID FROM @Divisions);

-- Insert dữ liệu doanh thu dự kiến trong 1 năm vào bảng tạm
INSERT INTO @ExpectedRevenueInMonthAmount
SELECT A1015.AnaID,	A1015.AnaName, O0149.TranYear, O0149.TranMonth, EstimateConvertedAmount, O0149.PlanTypeID
FROM OT0149 AS O0149
 INNER JOIN OT0150 AS O0150 ON O0149.DivisionID = O0150.DivisionID AND O0149.VoucherID = O0150.VoucherID
 INNER JOIN AT1302 AS A1302 ON O0150.InventoryID = A1302.InventoryID
 LEFT JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID AND A1015.AnaTypeID = 'I02'
WHERE O0149.DivisionID IN (Select DivisionID FROM @Divisions) AND O0149.TranYear = @TranYear;

-- Báo cáo tổng doanh thu, theo dõi hàng trả, trừ tiền tháng
SELECT Sumary.AnaID,
	   Sumary.AnaName,
	   SUM(Sumary.GeneratedRevenueInMonthAmount) AS GeneratedRevenueInMonthAmount,
	   SUM(Sumary.ExpectedRevenueInMonthAmount) AS ExpectedRevenueInMonthAmount,
	   SUM(Sumary.Lasted3MonthsRevenueAmount) AS Lasted3MonthsRevenueAmount,
	   SUM(Sumary.MeanYTDRevenueAmount) AS MeanYTDRevenueAmount,
	   SUM(Sumary.TotalLiabilitiesAmount) AS TotalLiabilitiesAmount,
	   SUM(Sumary.OutDueTotalLiabilitiesAmount) AS OutDueTotalLiabilitiesAmount,
	   SUM(Sumary.InDueTotalLiabilitiesAmount) AS InDueTotalLiabilitiesAmount,
	   SUM(Sumary.ItemReturnedQuantity) AS ItemReturnedQuantity,
	   SUM(Sumary.ReductionValueAmount) AS ReductionValueAmount
FROM
(
-- Doanh thu phát sinh trong tháng
	SELECT
		A1015.AnaID,
		A1015.AnaName,
		ROUND(
			SUM(
				-- Doanh thu hàng bán trả lại thì trừ ra
				CASE WHEN A9000.TransactionTypeID = 'T24' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
					 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
				END
			),
		0) AS GeneratedRevenueInMonthAmount,
		0.0 AS ExpectedRevenueInMonthAmount,
		0.0 AS Lasted3MonthsRevenueAmount,
		0.0 AS MeanYTDRevenueAmount,
		0.0 AS TotalLiabilitiesAmount,
		0.0 AS OutDueTotalLiabilitiesAmount,
		0.0 AS InDueTotalLiabilitiesAmount,
		0.0 AS ItemReturnedQuantity,
		0.0 AS ReductionValueAmount
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 LEFT JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID AND A1015.AnaTypeID = 'I02'
	 LEFT JOIN AT1010 WITH(NOLOCK) ON (AT1010.DivisionID = '@@@' OR AT1010.DivisionID IN (Select DivisionID FROM @Divisions)) AND A9000.VATGroupID = AT1010.VATGroupID
	WHERE A9000.TransactionTypeID IN ('T04', 'T24') AND A9000.TranYear = @TranYear AND A9000.TranMonth = @TranMonth AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName
	
	UNION ALL
	
	/*
	- Doanh thu dự kiến: Load trường Thành tiền (quy đổi) dưới lưới chi tiết tương ứng với các cột mã phân tích mặt hàng theo thời gian chọn in
	Ví dụ: In báo cáo ngày 12/10/2019, sẽ hiển thị tổng số lượng kế hoạch tháng 10/2019 + kế hoạch quý 4/2019 + kế hoạch năm 2019
	*/
	SELECT A1.AnaID,
		   A1.AnaName,
		   0.0 AS GeneratedRevenueInMonthAmount,
		   SUM(A1.EstimateConvertedAmount) AS ExpectedRevenueInMonthAmount,
		   0.0 AS Lasted3MonthsRevenueAmount,
		   0.0 AS MeanYTDRevenueAmount,
		   0.0 AS TotalLiabilitiesAmount,
		   0.0 AS OutDueTotalLiabilitiesAmount,
		   0.0 AS InDueTotalLiabilitiesAmount,
		   0.0 AS ItemReturnedQuantity,
		   0.0 AS ReductionValueAmount
	FROM (
		-- Doanh thu dự kiến tháng
		SELECT AnaID,
			   AnaName, 
			   SUM(EstimateConvertedAmount) AS EstimateConvertedAmount
		FROM @ExpectedRevenueInMonthAmount
		WHERE TranMonth = @TranMonth AND PlanTypeID = 'M'
		GROUP BY AnaID, AnaName
	
		UNION ALL
	
		-- Doanh thu dự kiến quý
		SELECT AnaID, AnaName, 
			   SUM(EstimateConvertedAmount) AS EstimateConvertedAmount
		FROM @ExpectedRevenueInMonthAmount AS A1
		 INNER JOIN @Quarters AS Quarters ON A1.TranMonth = Quarters.TranMonth
		WHERE PlanTypeID = 'Q'
		GROUP BY AnaID, AnaName
	
		UNION ALL
	
		-- Doanh thu dự kiến năm
		SELECT AnaID, AnaName, SUM(EstimateConvertedAmount) AS EstimateConvertedAmount
		FROM @ExpectedRevenueInMonthAmount
		WHERE PlanTypeID = 'Y'
		GROUP BY AnaID, AnaName
	) AS A1
	GROUP BY A1.AnaID, A1.AnaName
	
	UNION ALL
	
	-- Doanh thu bình quân 3 tháng gần nhất
	SELECT
		A1015.AnaID,
		A1015.AnaName,
		0.0 AS GeneratedRevenueInMonthAmount,
		0.0 AS ExpectedRevenueInMonthAmount,
		(ROUND(
			SUM(
					-- Doanh thu hàng bán trả lại thì trừ ra
				CASE WHEN A9000.TransactionTypeID = 'T24' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
					 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
				END
			),
		0) / 3) AS Lasted3MonthsRevenueAmount,
		0.0 AS MeanYTDRevenueAmount,
		0.0 AS TotalLiabilitiesAmount,
		0.0 AS OutDueTotalLiabilitiesAmount,
		0.0 AS InDueTotalLiabilitiesAmount,
		0.0 AS ItemReturnedQuantity,
		0.0 AS ReductionValueAmount
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 LEFT JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID AND A1015.AnaTypeID = 'I02'
	 LEFT JOIN AT1010 WITH(NOLOCK) ON (AT1010.DivisionID = '@@@' OR AT1010.DivisionID IN (Select DivisionID FROM @Divisions)) AND A9000.VATGroupID = AT1010.VATGroupID
	WHERE A9000.TransactionTypeID IN ('T04', 'T24')
		  AND (
			(A9000.TranYear = YEAR(DATEADD(m, -1, @Date)) AND A9000.TranMonth = MONTH(DATEADD(m, -1, @Date)))
			OR
			(A9000.TranYear = YEAR(DATEADD(m, -2, @Date)) AND A9000.TranMonth = MONTH(DATEADD(m, -2, @Date)))
			OR
			(A9000.TranYear = YEAR(DATEADD(m, -3, @Date)) AND A9000.TranMonth = MONTH(DATEADD(m, -3, @Date)))
		  )
		  AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName
	
	UNION ALL
	
	/*
	Doanh thu trung bình tháng YTD: Tính bình quân trường Thành tiền (Quy đổi) từ ngày đầu năm đến hết tháng trước so với thời gian chọn in
	Ví dụ: In báo cáo ngày 12/10/2019, sẽ tính trung bình tổng doanh thu từ tháng 1 đến tháng 9
	Trung bình YTD = (Doanh thu T1 + ... + Doanh thu T9) / 9
	*/
	SELECT
		A1015.AnaID,
		A1015.AnaName,
		0.0 AS GeneratedRevenueInMonthAmount,
		0.0 AS ExpectedRevenueInMonthAmount,
		0.0 AS Lasted3MonthsRevenueAmount,
		CASE WHEN @TranMonth - 1 > 0 THEN
			(ROUND(SUM(
					-- Doanh thu hàng bán trả lại thì trừ ra
					CASE WHEN A9000.TransactionTypeID = 'T24' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
														      ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
					END
											), 0) / (@TranMonth - 1))
		ELSE 0.0
		END	AS MeanYTDRevenueAmount,
		0.0 AS TotalLiabilitiesAmount,
		0.0 AS OutDueTotalLiabilitiesAmount,
		0.0 AS InDueTotalLiabilitiesAmount,
		0.0 AS ItemReturnedQuantity,
		0.0 AS ReductionValueAmount
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 LEFT JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID AND A1015.AnaTypeID = 'I02'
	 LEFT JOIN AT1010 WITH(NOLOCK) ON (AT1010.DivisionID = '@@@' OR AT1010.DivisionID IN (Select DivisionID FROM @Divisions)) AND A9000.VATGroupID = AT1010.VATGroupID
	WHERE A9000.TransactionTypeID IN ('T04', 'T24') AND A9000.TranYear = @TranYear
		  AND (
			A9000.TranMonth > 0 AND A9000.TranMonth <= (@TranMonth - 1)
		  )
		  AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName

	--UNION ALL
	
	---- Tổng công nợ
	--SELECT A.AnaID,
	--	A.AnaName,
	--	0.0 AS GeneratedRevenueInMonthAmount,
	--	0.0 AS ExpectedRevenueInMonthAmount,
	--	0.0 AS Lasted3MonthsRevenueAmount,
	--	0.0 AS MeanYTDRevenueAmount,
	--	(COALESCE(A.ReBeConvertedAmount,0) + SUM(COALESCE(A.DebitConvertedAmount,0)) - SUM(COALESCE(CreditConvertedAmount,0))) 
	--	AS TotalLiabilitiesAmount,
	--	(COALESCE(A.ReBeConvertedAmount,0) + SUM(COALESCE(A.OutDueDebitConvertedAmount,0)) - SUM(COALESCE(OutDueCreditConvertedAmount,0))) 
	--	AS OutDueTotalLiabilitiesAmount,
	--	(COALESCE(A.ReBeConvertedAmount,0) + SUM(COALESCE(A.InDueDebitConvertedAmount,0)) - SUM(COALESCE(InDueCreditConvertedAmount,0))) 
	--	AS InDueTotalLiabilitiesAmount,
	--	0.0 AS ItemReturnedQuantity,
	--	0.0 AS ReductionValueAmount
	--FROM (
	--	-- Tổng công nợ
	--	SELECT
	--		AnaID, AnaName,
	--		OpeningConvertedAmount AS ReBeConvertedAmount,
	--		DebitConvertedAmount,
	--		0.0 AS OutDueDebitConvertedAmount,
	--		0.0 AS InDueDebitConvertedAmount,
	--		CreditConvertedAmount,
	--		0.0 AS OutDueCreditConvertedAmount,
	--		0.0 AS InDueCreditConvertedAmount
	--	FROM #AP0308_AV0314 AS A1

	--	UNION ALL

	--	-- Tổng công nợ quá hạn
	--	SELECT
	--		AnaID, AnaName,
	--		OpeningConvertedAmount AS ReBeConvertedAmount,
	--		0.0 AS DebitConvertedAmount,
	--		DebitConvertedAmount AS OutDueDebitConvertedAmount,
	--		0.0 AS InDueDebitConvertedAmount,
	--		0.0 AS CreditConvertedAmount,
	--		CreditConvertedAmount AS OutDueCreditConvertedAmount,
	--		0.0 AS InDueCreditConvertedAmount
	--	FROM #AP0308_AV0314 AS A1
	--	WHERE A1.DueDate IS NOT NULL AND @Date > A1.DueDate

	--	UNION ALL

	--	-- Tổng công nợ trong hạn
	--	SELECT
	--		AnaID, AnaName,
	--		OpeningConvertedAmount AS ReBeConvertedAmount,
	--		0.0 AS DebitConvertedAmount,
	--		0.0 AS OutDueDebitConvertedAmount,
	--		DebitConvertedAmount AS InDueDebitConvertedAmount,
	--		0.0 CreditConvertedAmount,
	--		0.0 AS OutDueCreditConvertedAmount,
	--		CreditConvertedAmount AS InDueCreditConvertedAmount
	--	FROM #AP0308_AV0314 AS A1
	--	WHERE (A1.DueDate IS NOT NULL AND @Date <= A1.DueDate) OR A1.DueDate IS NULL

	--) AS A
	--GROUP BY A.AnaID, A.AnaName, ReBeConvertedAmount	

	UNION ALL
	
	-- Sản lượng hàng trả, giảm trừ
	SELECT
		A1015.AnaID,
		A1015.AnaName,
		0.0 AS GeneratedRevenueInMonthAmount,
		0.0 AS ExpectedRevenueInMonthAmount,
		0.0 AS Lasted3MonthsRevenueAmount,
		0.0 AS MeanYTDRevenueAmount,
		0.0 AS TotalLiabilitiesAmount,
		0.0 AS OutDueTotalLiabilitiesAmount,
		0.0 AS InDueTotalLiabilitiesAmount,
		SUM(A9000.ConvertedQuantity * (1+(AT1010.VATRate / 100))) AS ItemReturnedQuantity,
		SUM(A9000.ConvertedAmount * (1+(AT1010.VATRate / 100))) AS ReductionValueAmount
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 INNER JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID
	 LEFT JOIN AT1010 WITH(NOLOCK) ON (AT1010.DivisionID = '@@@' OR AT1010.DivisionID IN (Select DivisionID FROM @Divisions)) AND A9000.VATGroupID = AT1010.VATGroupID
	WHERE A9000.TransactionTypeID IN ('T24') AND A9000.TranYear = @TranYear AND A9000.TranMonth = @TranMonth AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName
) AS Sumary
GROUP BY Sumary.AnaID, Sumary.AnaName

-- Báo cáo tổng công nợ lấy từ mã phân tích nghiệp vụ
-- Thực thi Store AP0316_V2
EXEC AP0316_V2 @DivisionID = @DivisionID,
			   @ReportCode = 'NT07',
			   @ObjectID = @ObjectID,
			   @AccountID = @AccountID,
			   @CurrencyID = @CurrencyID,
			   @ReportDate = @Date,
			   @IsBefore = 0,
			   @IsType = 2,
			   @DivisionIDList = @DivisionIDList

SELECT * FROM AV0316
WHERE DivisionID IN (SELECT DivisionID FROM @Divisions)

SELECT Accumulated.AnaID, Accumulated.AnaName,
		SUM(Accumulated.ConvertedAmountByDate) AS ConvertedAmountByDate,
		SUM(Accumulated.ConvertedQuantityByDate) AS ConvertedQuantityByDate,
		SUM(Accumulated.ConvertedAmountByMonth) AS ConvertedAmountByMonth,
		SUM(Accumulated.ConvertedQuantityByMonth) AS ConvertedQuantityByMonth,
		SUM(Accumulated.ConvertedAmountByYear) AS ConvertedAmountByYear, 
		SUM(Accumulated.ConvertedQuantityByYear) AS ConvertedQuantityByYear
FROM (
	SELECT A1015.AnaID, A1015.AnaName,
		SUM(A9000.ConvertedAmount) AS ConvertedAmountByDate,
		SUM(A9000.ConvertedQuantity) AS ConvertedQuantityByDate,
		0.0 AS ConvertedAmountByMonth,
		0.0 AS ConvertedQuantityByMonth,
		0.0 AS ConvertedAmountByYear,
		0.0 AS ConvertedQuantityByYear
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 INNER JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID
	WHERE A9000.VoucherDate = @Date AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A1015.AnaID, A1015.AnaName
	
	UNION ALL
	
	SELECT A1015.AnaID, A1015.AnaName,
	0.0 AS ConvertedAmountByDate,
	0.0 AS ConvertedQuantityByDate,
	SUM(A9000.ConvertedAmount) AS ConvertedAmountByMonth,
	SUM(A9000.ConvertedQuantity) AS ConvertedQuantityByMonth,
	0.0 AS ConvertedAmountByYear,
	0.0 AS ConvertedQuantityByYear
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 INNER JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID
	WHERE A9000.VoucherDate BETWEEN DATEFROMPARTS(@TranYear, @TranMonth, 1) AND DATEADD(DAY, -1, @Date) AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A1015.AnaID, A1015.AnaName
	
	UNION ALL
	
	SELECT A1015.AnaID, A1015.AnaName,
	0.0 AS ConvertedAmountByDate,
	0.0 AS ConvertedQuantityByDate,
	0.0 AS ConvertedAmountByMonth,
	0.0 AS ConvertedQuantityByMonth,
	SUM(A9000.ConvertedAmount) AS ConvertedAmountByYear,
	SUM(A9000.ConvertedQuantity) AS ConvertedQuantityByYear
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 INNER JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID
	WHERE A9000.VoucherDate BETWEEN DATEFROMPARTS(@TranYear, 1, 1) AND DATEADD(DAY, -1, @Date) AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
	GROUP BY A1015.AnaID, A1015.AnaName
) AS Accumulated
GROUP BY Accumulated.AnaID, Accumulated.AnaName

-- Biểu đồ tổng doanh thu thực tế năm
;WITH FromDateToDateInMonth(FromDate, ToDate) AS (
	SELECT DATEADD(MONTH, -1, @Date), @Date

	UNION ALL

	SELECT DATEADD(MONTH, -1, FromDate), DATEADD(MONTH, -1, ToDate)
	FROM FromDateToDateInMonth
	WHERE DATEADD(MONTH, -1, FromDate) > DATEFROMPARTS(@TranYear - 1, 1, 1)
)
SELECT AnaID, AnaName, A.FromDate, A.ToDate, COALESCE(SUM(B.ConvertedAmount), 0.0) AS ConvertedAmount FROM FromDateToDateInMonth AS A
OUTER APPLY(
	SELECT A1015.AnaID, A1015.AnaName, A9000.ConvertedAmount
	FROM AT9000 AS A9000 WITH(NOLOCK)
	 INNER JOIN AT1302 AS A1302 WITH(NOLOCK) ON A9000.InventoryID = A1302.InventoryID
	 INNER JOIN @AT1015 AS A1015 ON A1302.I02ID = A1015.AnaID
	WHERE VoucherDate BETWEEN A.FromDate AND A.ToDate AND A9000.DivisionID IN (SELECT DivisionID FROM @Divisions)
) AS B
WHERE AnaID IS NOT NULL
GROUP BY AnaID, AnaName, A.FromDate, A.ToDate
ORDER BY AnaID, AnaName, A.FromDate, A.ToDate