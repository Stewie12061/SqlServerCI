IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[BP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Biểu đồ tình hình doanh thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ tình hình doanh thu
-- <History>
---- Create on 28/06/2016 by Phuong Thao: 
---- Modified on 28/06/2016 by Phuong Thao
---- Modified on 11/07/2016 by Kim Vu: Mode 2 không lấy divisionid,tranyear
---- Modified on 10/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified by Tiểu Mai on 10/07/2017: Chỉnh sửa cách lấy dữ liệu doanh thu đạt được
---- Modified by Tiểu Mai on 02/08/2017: Chỉnh sửa cách lấy dữ liệu Giá vốn hàng khuyến mãi
---- Modified by Tiểu Mai on 06/10/2017: Chỉnh sửa cách order by các kỳ
---- Modified by Phương Thảo on 08/02/2018: Bổ sung tùy chỉnh thời gian lấy dữ liệu khi lên dashboard
---- Modified by Phương Thảo on 08/03/2018: Bổ sung mode thời gian 2 năm gần nhất.
---- Modified by Thành Luân	 on 13/03/2020: Bổ sung điều kiện tìm kiếm với DivisionIDList.
---- Modified by Văn Tài	 on 14/04/2022: Bổ sung điều kiện OrderStatus.
-- <Example>
---- EXEC BP3002 'ANG', 1, '2017-01-01 00:00:00.000', 1, 2017, '2017-01-31 00:00:00.000', 3,2017,0, 1
---- EXEC BP3002 'ANG', 0, '', 1, 2017, '', 3,2017,1, 1
---- EXEC BP3002 'ANG', 0, '', 1, 2017, '', 3,2017,1, 0

CREATE PROCEDURE BP3002
(
	@DivisionID VARCHAR(50),
	@IsDate TINYINT, --0: Kỳ, 1: Ngày
	@FromDate DATETIME, 
	@FromMonth INT, 
	@FromYear INT, 
	@ToDate DATETIME, 
	@ToMonth INT, 
	@ToYear INT, 	
	@IsCostOfSale TINYINT, -- 1: Check Bieu do ty le chi phi BH
	@SaleReceipt TINYINT,  -- 1: Check in doanh số thu tiền	
	@TimeType TINYINT = NULL,
	@DivisionIDList AS NVARCHAR(MAX) = NULL
)
AS
SET NOCOUNT ON

DECLARE	@sSQL1 as nvarchar(4000),
		@sSQL2 as nvarchar(4000),
		@sSQL3 as nvarchar(4000),
		@QuantityDecimals TINYINT,
		@UnitCostDecimals TINYINT,
		@ConvertedDecimals TINYINT,
		@sSQLWhereDivision NVARCHAR(MAX) = '',
		@sSQLWhereDivision2 NVARCHAR(MAX) = '',
		@CustomerIndex INT

-- Lấy customer index hiện tại
SELECT TOP(1) @CustomerIndex = CustomerName FROM CustomerIndex

-- Kiểm tra customer là VNF
IF(@CustomerIndex = 107)
BEGIN
	-- Bảng Divisions
	DECLARE @Divisions TABLE (
		DivisionID NVARCHAR(50)
	);
	
	INSERT INTO @Divisions
	SELECT DISTINCT * FROM [dbo].StringSplit(REPLACE(COALESCE(@DivisionIDList, @DivisionID), '''', ''), ',');
	
	DECLARE @DivisionCount INT = NULL,
			@FromDatePeriod DATETIME2 = NULL,
			@ToDatePeriod DATETIME2 = NULL;

	SELECT TOP(1) @DivisionCount = COUNT(*) FROM @Divisions
	SET @FromDatePeriod = DATEFROMPARTS(@FromYear, @FromMonth, 1)
	SET @ToDatePeriod = EOMONTH(DATEFROMPARTS(@ToYear, @ToMonth, 1))
	
	SELECT R.DivisionID,
			R.ChartLabel,
			SUM(R.ActualAmount) AS AcctualAmount,
			SUM(R.TargetAmount) AS TargetAmount
	FROM (
		SELECT (CASE WHEN @DivisionCount > 1 THEN '@@@' ELSE A9.DivisionID END) AS DivisionID,
			   LTRIM(RTRIM(A9.TranMonth)) + '/' +  LTRIM(RTRIM(A9.TranYear)) AS ChartLabel,
			   SUM(COALESCE(
				CASE WHEN A9.TransactionTypeID = 'T24' THEN -(A9.ConvertedAmount)
						ELSE A9.ConvertedAmount
				   END,
				0.0
			   )) AS ActualAmount,
			   0.0 AS TargetAmount
		FROM AT9000 AS A9 WITH(NOLOCK)
		WHERE A9.DivisionID IN (SELECT DivisionID FROM @Divisions)
			AND A9.VoucherDate BETWEEN @FromDatePeriod AND @ToDatePeriod
			-- Chỉ lấy những phiếu là hàng bán (T04) và hàng bán trả lại(T24)
			AND A9.TransactionTypeID IN ('T04', 'T24')
		GROUP BY (CASE WHEN @DivisionCount > 1 THEN '@@@' ELSE A9.DivisionID END), A9.TranYear, A9.TranMonth
		
		UNION ALL
		-- Union với bảng Kế hoạch bán hàng
		SELECT (CASE WHEN @DivisionCount > 1 THEN '@@@' ELSE O1.DivisionID END) AS DivisionID, 
			   LTRIM(RTRIM(O1.TranMonth)) + '/' +  LTRIM(RTRIM(O1.TranYear)) AS ChartLabel,
			   0.0 AS ActualAmount,
			   SUM(COALESCE(O2.EstimateConvertedAmount, 0.0)) AS TargetAmount
		FROM OT0149 AS O1 WITH(NOLOCK)
		LEFT JOIN OT0150 AS O2 ON O1.VoucherID = O2.VoucherID
		WHERE O1.DivisionID IN (SELECT DivisionID FROM @Divisions)
			-- Chỉ lấy kế hoạch tháng vì tiêu thức in chỉ cho phép chọn từ tháng đến tháng, nếu Where với điều kiện quý hoặc năm có thể trả ra số liệu không đúng.
			AND O1.PlanTypeID = 'M'
			AND (O1.TranYear * 100 + O1.TranMonth) BETWEEN (@FromYear * 100 + @FromMonth) AND (@ToYear * 100 + @ToMonth)
		GROUP BY (CASE WHEN @DivisionCount > 1 THEN '@@@' ELSE O1.DivisionID END), O1.TranYear, O1.TranMonth
	) AS R
	GROUP BY R.DivisionID, R.ChartLabel
	ORDER BY R.DivisionID, R.ChartLabel

	RETURN;
END

--Check Para DivisionIDList null then get DivisionID 
IF COALESCE(@DivisionIDList,'') = ''
BEGIN
	SET @sSQLWhereDivision = @sSQLWhereDivision + ' T33.DivisionID IN ('''+ @DivisionID+''')'
	SET @sSQLWhereDivision2 = @sSQLWhereDivision2 + ' ('''+ @DivisionID+''') '
END
Else
BEGIN
SET @sSQLWhereDivision = @sSQLWhereDivision + '  T33.DivisionID IN ('''+@DivisionIDList+''')'
SET @sSQLWhereDivision2 = @sSQLWhereDivision2 + ' ('''+@DivisionIDList+''') '
END

SELECT @QuantityDecimals = QuantityDecimals, 
		@UnitCostDecimals = UnitCostDecimals,
		@ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK)
WHERE DivisionID = @DivisionID

SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)


IF(@TimeType is not null)
BEGIN
	SELECT TOP 1 @ToMonth = TranMonth, @ToYear = TranYear
	FROM OT2001 WITH(NOLOCK)
	ORDER BY TranYear desc, TranMonth desc

	IF(@TimeType = 0 ) -- 1 năm gần nhất
		SELECT	@FromMonth = MONTH(DATEADD(yyyy,-1,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
				@FromYear = YEAR(DATEADD(yyyy,-1,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

	IF(@TimeType = 1) -- 6 tháng gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(mm,-6,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )),
				@FromYear = YEAR(DATEADD(mm,-6,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

	IF(@TimeType = 2) -- 3 tháng gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(mm,-3,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )),
				@FromYear = YEAR(DATEADD(mm,-3,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) ))

	IF(@TimeType = 3) -- 2 năm gần nhất		
			SELECT	@FromMonth = MONTH(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
					@FromYear = YEAR(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

END

SELECT @sSQL1 = '
SELECT  DivisionID, TranMonth, TranYear, SUM(Amount) As Amount, SUM(Amount02) As Amount02
INTO	#BP3002_DTTH
FROM
(
	SELECT    ---- PHAT SINH CO
			T33.DivisionID, T33.TranMonth, T33.TranYear,
			(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
			ISNULL(VATConvertedAmount, 0) - ISNULL(T1.DiscountSaleAmountDetail,0) + ISNULL(T1.DiscountSaleAmountDetail,0))
			AS Amount,
			(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
			ISNULL(VATConvertedAmount, 0) - ISNULL(T1.DiscountSaleAmountDetail,0))
			AS Amount02
	FROM	OT2002 T1 with (nolock)
	LEFT JOIN OT2001 T33 with (nolock) on T1.DivisionID = T33.DivisionID AND T1.SOrderID = T33.SOrderID
	INNER JOIN AT1004 T2 with (nolock) on T33.CurrencyID = T2.CurrencyID	
	WHERE	'+ @sSQLWhereDivision +'
			'+ CASE WHEN @IsDate = 0 THEN 'AND T33.TranYear*100 + T33.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100'
			ELSE ' AND T33.OrderDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''' END + '			
			AND T33.OrderStatus = 1			
			AND Isnull(T1.IsProInventoryID, 0) = 0
			AND T33.OrderDate <= GETDATE()'
			+ CASE WHEN @CustomerIndex = 107
			THEN ''
			ELSE ' AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> '''''
			END
			+ ') T GROUP BY DivisionID, TranMonth, TranYear'

IF @SaleReceipt = 1
BEGIN
	SET @sSQL2 = '
		SELECT T1.DivisionID, LTRIM(RTRIM(T1.TranMonth))+''/''+  LTRIM(RTRIM(T1.TranYear)) as ChartLabel, T1.Amount AS AcctualAmount,
			T2.Amount AS TargetAmount, T1.Amount02 AS SaleReceiptAmount, 
			CASE WHEN T2.Amount <> 0 THEN (T1.Amount/T2.Amount) ELSE 0 END AS ActualRate,
			CASE WHEN T2.Amount <> 0 THEN (T1.Amount02/T2.Amount) ELSE 0 END AS SaleReceiptRate
		FROM #BP3002_DTTH T1
		LEFT JOIN 
		(
		SELECT DivisionID, MONTH(FromDate) AS TranMonth, YEAR(FromDate) AS TranYear, SUM(SalesMonth) AS Amount
		FROM AT0161
		WHERE DivisionID IN '+ @sSQLWhereDivision2 +'
				'+ CASE WHEN @IsDate = 0 THEN ' AND YEAR(FromDate)*100 + MONTH(FromDate) BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100'
					ELSE 'AND (FromDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''  OR 
					ToDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+''' OR
					'''+Convert(Varchar(50),@FromDate,101)+''' BETWEEN Convert(nvarchar(50),FromDate,101) AND Convert(nvarchar(50),ToDate,101) OR
					'''+Convert(Varchar(50),@ToDate,101)+''' BETWEEN Convert(nvarchar(50),FromDate,101) AND Convert(nvarchar(50),ToDate,101))
					' END + '
		GROUP BY DivisionID,  YEAR(FromDate), MONTH(FromDate)
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
		ORDER BY T1.DivisionID, T1.TranYear, T1.TranMonth
		'
END	
ELSE 
	SET @sSQL2 = '
		SELECT T1.DivisionID, LTRIM(RTRIM(T1.TranMonth))+''/''+  LTRIM(RTRIM(T1.TranYear)) as ChartLabel, T1.Amount AS AcctualAmount, T2.Amount AS TargetAmount,
			CASE WHEN T2.Amount <> 0 THEN (T1.Amount/T2.Amount) ELSE 0 END AS ActualRate
		FROM #BP3002_DTTH T1
		LEFT JOIN 
		(
		SELECT DivisionID,  TranMonth, TranYear, SUM(Amount) AS Amount
		FROM	BT30021_AG
		WHERE	DivisionID IN '+ @sSQLWhereDivision2 +'
				'+ CASE WHEN @IsDate = 0 THEN 'AND TranYear*100 + TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100'
					ELSE 'AND BT30021_AG.VoucherDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''' END + '
		GROUP BY DivisionID,  TranMonth, TranYear
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
		ORDER BY T1.DivisionID, T1.TranYear, T1.TranMonth
		'

IF(@IsCostOfSale = 1)
BEGIN
	SELECT @sSQL3 = '
	
	SELECT T1.DivisionID,  T1.TranMonth, T1.TranYear, CASE WHEN ISNULL(T1.Amount,0)  = 0 THEN 0 ELSE T2.Amount/T1.Amount END AS EmpRate
	INTO #BP3002_RS1
	FROM #BP3002_DTTH T1
	LEFT JOIN
	(
	SELECT DivisionID, TranMonth, TranYear, SUM(Amount) AS Amount
	FROM BT30022_AG
	WHERE DivisionID IN ' + @sSQLWhereDivision2 + '
			'+ CASE WHEN @IsDate = 0 THEN 'AND TranYear*100 + TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100'
				ELSE 'AND BT30022_AG.VoucherDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''' END + '
	GROUP BY DivisionID,  TranMonth, TranYear
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear


	SELECT T1.DivisionID,  T1.TranMonth, T1.TranYear, CASE WHEN ISNULL(T1.Amount,0)  = 0 THEN 0 ELSE T2.Amount/T1.Amount END AS ProRate
	INTO #BP3002_RS2
	FROM #BP3002_DTTH T1
	LEFT JOIN 
	(	
		SELECT B.DivisionID, B.TranMonth, B.TranYear, ROUND(SUM(B.OrderQuantity * B.UnitPrice), ' + CONVERT(NVARCHAR(5),@ConvertedDecimals) +') AS Amount
		FROM (
			SELECT A.DivisionID, A.TranMonth, A.TranYear, A.InventoryID, A.OrderQuantity, 
			CASE WHEN SUM(B.ActualQuantity) = 0 THEN 0 ELSE SUM(B.Amount) /  SUM(B.ActualQuantity) END  AS UnitPrice
			FROM 
			(SELECT O01.TranMonth, O01.TranYear, O02.DivisionID, O02.InventoryID, SUM(O02.OrderQuantity) AS OrderQuantity
				FROM OT2002 O02 WITH (NOLOCK)
				LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
				WHERE ISNULL(O02.IsProInventoryID,0) = 1
					AND O01.DivisionID IN '+ @sSQLWhereDivision2 +'
					'+ CASE WHEN @IsDate = 0 THEN 'AND O01.TranYear*100 + O01.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100'
					ELSE ' AND O01.OrderDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''' END + '
					AND O01.OrderDate <= GETDATE()
				GROUP BY O01.TranMonth, O01.TranYear, O02.DivisionID, O02.InventoryID
			) A
			LEFT JOIN 
			(
				SELECT A06.DivisionID, A06.TranMonth, A06.TranYear, A06.WareHouseID, A07.InventoryID, MAX(A07.UnitPrice) AS UnitPrice, SUM(A07.ActualQuantity) AS ActualQuantity,
						MAX(A07.UnitPrice) * SUM(A07.ActualQuantity) AS Amount
				FROM AT2007 A07 WITH (NOLOCK)
				LEFT JOIN AT2006 A06 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID
				WHERE A06.DivisionID IN '+ @sSQLWhereDivision2 +'
					'+ CASE WHEN @IsDate = 0 THEN 'AND A06.TranYear*100 + A06.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100'
					ELSE ' AND A06.VoucherDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''' END + '
					AND A06.TableID = ''AT2006'' AND A06.KindVoucherID = 2 
				GROUP BY A06.DivisionID, A06.TranMonth, A06.TranYear, A06.WareHouseID, A07.InventoryID, A07.UnitPrice	
			) B ON B.TranMonth = A.TranMonth AND B.TranYear = A.TranYear AND B.InventoryID = A.InventoryID AND B.DivisionID = A.DivisionID
			GROUP BY A.DivisionID, A.TranMonth, A.TranYear, A.InventoryID, A.OrderQuantity
		) B
		GROUP BY B.DivisionID, B.TranMonth, B.TranYear
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear


	SELECT LTRIM(RTRIM(T1.TranMonth))+''/''+  LTRIM(RTRIM(T1.TranYear)) as ChartLabel, ISNULL(T1.EmpRate,0) AS EmpRate, ISNULL(T2.ProRate,0) AS ProRate
	FROM #BP3002_RS1 T1
	LEFT JOIN  #BP3002_RS2 T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
	ORDER BY T1.DivisionID, T1.TranYear, T1.TranMonth
	'
END
--PRINT (@sSQL1)
--PRINT (@sSQL2)
--PRINT (@sSQL3)
EXEC (@sSQL1 + @sSQL2 + @sSQL3)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

