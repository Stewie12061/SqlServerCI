IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3003]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[BP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Biểu đồ tồn kho bình quân
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ tồn kho bình quân
-- <History>
---- Create on 10/05/2016 by Phuong Thao: 
---- Modified on 17/03/2017 by Phuong Thao: Chỉnh sửa cách tính số tiền tồn kho và fix lỗi số ngày tồn kho
---- Modified by Tiểu Mai on 06/10/2017: Chỉnh sửa lại cách order by TranYear, TranMonth
---- Modified by Phương Thảo on 08/02/2018: Bổ sung tùy chỉnh thời gian lấy dữ liệu khi lên dashboard
---- Modified by Phương Thảo on 08/03/2018: Bổ sung mode thời gian 2 năm gần nhất
---- Modified by Văn Tài	 on 24/04/2022: Bổ sung điều kiện Division @@@ cho danh mục mặt hàng.
-- <Example>
---- EXEC BP3003 'ANG', 0, 1, 2017, 10,2017, '0101600031', 'TA00500005','EMS01'
---- EXEC BP3003 'MK', 1, 1, 2016, 3,2016, '0101600031', 'TA00500005','EMS01'
CREATE PROCEDURE BP3003
( 
	@DivisionID VARCHAR(50), 
	@Mode TINYINT, --0:In biểu đồ, 2: In báo cáo ( Đổ caption cột động )
	@FromMonth INT, 
	@FromYear INT, 
	@ToMonth INT, 
	@ToYear INT, 
	@FromInventoryID VARCHAR(50), 
	@ToInventoryID VARCHAR(50),
	@WarehouseID VARCHAR(50),
	@TimeType Tinyint = null
) 
AS
SET NOCOUNT ON


DECLARE	@sSQL1 as nvarchar(4000),
		@sSQL2 as nvarchar(4000),
		@sSQL3 as nvarchar(4000),		
		@sSQL4 as Varchar(8000),
		@sSQL5 as varchar(8000),
		@sSQL6 as Nvarchar(4000),			
		@sSQL7 as Nvarchar(4000),
		@sSQL8 as Nvarchar(4000),
		@TableName  varchar(50)		
			
select @sSQL2 = '', @sSQL3 = '', @sSQL4 = '', @sSQL5 = '', @sSQL6 = '', @sSQL7 = ''


IF(@TimeType is not null)
BEGIN
	SELECT  TOP 1 @ToMonth = TranMonth, @ToYear = TranYear
	FROM AT2006 WITH(NOLOCK)
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

DECLARE @ConvertedDecimals Int
SELECT @ConvertedDecimals = ConvertedDecimals
FROM AT1101
WHERE DivisionID = @DivisionID

DECLARE @FromDate Datetime, @ToDate Datetime

SELECT @FromDate =  DATEADD(mm,DATEDIFF(mm,0,CONVERT(date,'01/'+STR(@FromMonth)+'/'+STR(@FromYear),103)),0)
SELECT @ToDate =  DATEADD(ms,- 3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,CONVERT(date,'01/'+STR(@ToMonth)+'/'+STR(@ToYear),103))+1,0)))

CREATE TABLE #NGAYTON (DivisionID VARCHAR(50), InventoryID VARCHAR(50),-- VoucherDate Datetime, 
						TranMonth Tinyint, TranYear Int, Amount Decimal(28,8))

SELECT DivisionID, VoucherDate, InventoryID, TranMonth, TranYear, SignQuantity, SignAmount
INTO	#AV7000_SD
FROM  AV7000
WHERE	TranMonth + TranYear * 100 <= @ToMonth+@ToYear*100 
		AND WarehouseID LIKE @WarehouseID AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
		AND VoucherDate <= GETDATE() 
		AND DivisionID = @DivisionID

WHILE (@FromDate <= @ToDate)
BEGIN		
	INSERT INTO #NGAYTON
	SELECT DivisionID, InventoryID,	TranMonth, TranYear	, Amount 
	FROM (
		SELECT DivisionID, InventoryID, Month(@FromDate) AS TranMonth, Year(@FromDate) AS TranYear, SUM(SignQuantity) as ActualQuantity, SUM(SignAmount) AS Amount
		FROM #AV7000_SD
		WHERE  DivisionID = @DivisionID AND VoucherDate <= @FromDate
		GROUP BY DivisionID, InventoryID--, TranMonth, TranYear
		) T
	WHERE T.ActualQuantity <> 0 

	SET @FromDate = @FromDate + 1	
END

SELECT DivisionID, InventoryID, TranMonth, TranYear,  Count(InventoryID) AS StockDays
INTO #BP3003_NGAYTON
FROM #NGAYTON T
WHERE (TranYear*100 + TranMonth BETWEEN @FromMonth+@FromYear*100 AND @ToMonth+@ToYear*100)
GROUP BY DivisionID, InventoryID, TranMonth, TranYear

SELECT	DivisionID, InventoryID, TranMonth, TranYear, SUM(Amount) AS EndAmount
INTO	#BP3003_TIENTON
FROM	#NGAYTON
GROUP BY DivisionID, InventoryID, TranMonth, TranYear

SELECT  T1.DivisionID, T1.InventoryID, T3.InventoryName, T4.UnitName,
		T1.TranMonth, T1.TranYear, T2.StockDays, T1.EndAmount, 
		CASE WHEN Isnull(T2.StockDays,0) = 0 THEN 0 ELSE T1.EndAmount/T2.StockDays END AVRAmount,
		LTRIM(RTRIM(STR(T1.TranMonth)))+'/'+LTRIM(RTRIM(STR(T1.TranYear))) AS Period
INTO	#BP3003_RS_1
FROM	#BP3003_TIENTON T1
INNER JOIN #BP3003_NGAYTON T2 ON T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
INNER JOIN AT1302 T3 ON T3.DivisionID IN ('@@@', T1.DivisionID) AND T1.InventoryID = T3.InventoryID 
INNER JOIN AT1304 T4 ON T4.DivisionID IN ('@@@', T1.DivisionID) AND T3.UnitID = T4.UnitID 
Order by TranYear, TranMonth


SELECT	DISTINCT Period
INTO	#BP3003_RS_2
FROM	#BP3003_RS_1


IF(@Mode = 1)
BEGIN
SELECT @sSQL1 =
N'
SELECT FielID, Caption, DataType
FROM
(
SELECT		Period, ''Date''+ T1.Period AS FielID, N''Tổng số ngày tồn trong tháng''+T1.Period AS Caption,
			''Int'' AS DataType, 0 AS OrderNo
FROM		#BP3003_RS_2 T1
UNION ALL
SELECT		Period, ''Amount''+ T1.Period AS FielID, N''Tổng số tiền tháng''+T1.Period AS Caption,
			''Decimal(28,8)'' AS DataType, 1 AS OrderNo
FROM		#BP3003_RS_2 T1
UNION ALL
SELECT		Period, ''AVRAmount''+ T1.Period AS FielID, N''Tồn kho tháng''+T1.Period AS Caption,
			''Decimal(28,8)'' AS DataType, 2 AS OrderNo
FROM		#BP3003_RS_2 T1
) T
ORDER BY	RIGHT(Period,4), LEFT(Period,2), OrderNo
'

EXEC (@sSQL1)

IF EXISTS (SELECT TOP 1 1 FROM #BP3003_RS_2)
BEGIN

	SELECT @sSQL2 = @sSQL2 +
	'
	SELECT	*
	INTO  #BP3003_RS_Date
	FROM	
	(
	SELECT	DivisionID, InventoryID, InventoryName, UnitName,
			StockDays, ''Date''+Period AS Period 
	FROM	 #BP3003_RS_1	
	) P
	PIVOT
	(SUM(StockDays) FOR Period IN ('
	SELECT	@sSQL3 = @sSQL3 + CASE WHEN @sSQL3 <> '' THEN ',' ELSE '' END + '['+'Date'+Period+''+']'
	FROM	#BP3003_RS_2
	
	SELECT	@sSQL3 = @sSQL3 +')
	) As T'

	SELECT @sSQL4 = @sSQL4 +
	'
	SELECT	*
	INTO  #BP3003_RS_Amount
	FROM	
	(
	SELECT	DivisionID AS DivisionID1, InventoryID AS InventoryID1,
			EndAmount, ''Amount''+Period As Period
	FROM	 #BP3003_RS_1	
	) P	
	PIVOT 
	(SUM(EndAmount) FOR Period IN ('
	SELECT	@sSQL5 = @sSQL5 + CASE WHEN @sSQL5 <> '' THEN ',' ELSE '' END + '['+'Amount'+Period+''+']'
	FROM	#BP3003_RS_2

	SELECT	@sSQL5 = @sSQL5 +')
	) As T'

	SELECT @sSQL6 = @sSQL6 +
	'
	SELECT	*
	INTO  #BP3003_RS_AVRAmount
	FROM	
	(
	SELECT	DivisionID AS DivisionID2, InventoryID AS InventoryID2,
			AVRAmount, ''AVRAmount''+Period As Period
	FROM	 #BP3003_RS_1	
	) P	
	PIVOT 
	(SUM(AVRAmount) FOR Period IN ('
	SELECT	@sSQL7 = @sSQL7 + CASE WHEN @sSQL7 <> '' THEN ',' ELSE '' END + '['+'AVRAmount'+Period+''+']'
	FROM	#BP3003_RS_2

	SELECT	@sSQL7 = @sSQL7 +')
	) As T
	
	
	SELECT ROW_NUMBER() OVER (ORDER BY InventoryID) AS OrderNo, *
	FROM	#BP3003_RS_Date T1
	INNER JOIN #BP3003_RS_Amount T2 ON T1.InventoryID = T2.InventoryID1 AND T1.DivisionID = T2.DivisionID1
	INNER JOIN #BP3003_RS_AVRAmount T3 ON T1.InventoryID = T3.InventoryID2 AND T1.DivisionID = T3.DivisionID2
	ORDER BY T1.InventoryID
	'
	--PRINT (@sSQL2)
	--PRINT (@sSQL3)
	--PRINT (@sSQL4)
	--PRINT (@sSQL5)
	--PRINT (@sSQL6)
	--PRINT (@sSQL7)
END
ELSE
BEGIN
	SELECT @sSQL2 = @sSQL2 +
	'
	SELECT	DivisionID, InventoryID, InventoryName, UnitName,
			StockDays, EndAmount, AVRAmount
	FROM	 #BP3003_RS_1	
	WHERE 1 = 0
	'
END
EXEC (@sSQL2 + @sSQL3+ @sSQL4+ @sSQL5+@sSQL6 +@sSQL7)
END


IF(@Mode = 0)
BEGIN
	SET @sSQL8 = '
	SELECT LTRIM(RTRIM(STR(TranMonth)))+''/''+LTRIM(RTRIM(STR(TranYear))) AS ChartLabel, SUM(AVRAmount) AS AVRAmount, ''Int'' AS DataType
	FROM	#BP3003_RS_1
	GROUP BY TranYear, TranMonth
	ORDER BY TranYear, TranMonth
	'
	--PRINT (@sSQL8)
	EXEC (@sSQL8)
END 





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

