IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0128]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0128]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Tính chi phí lưu kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 12/01/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 26/05/2017: Fix lỗi tính chi phí lưu kho sang kỳ tiếp không đúng, Tính chi phí lưu kho theo tuần, tháng không đúng
---- Modified by Bảo Thy on 03/08/2017: fix lỗi sai khoảng thời gian cuối cùng khi tính lưu kho
---- 
---- Modified on by 
-- <Example>
/*
    EXEC WP0128 'HT','ASOFTADMIN',11,2016,'2016-11-01', 'BIDV','MK0007', 'ADM01', 'E0000','dfs','afsd','aadsa'
	EXEC WP0128 @DivisionID,@UserID,@TranMonth,@TranYear,@Date,@FromObjectID,@ToObjectID,
	@FromContractID,@ToContractID,@FromWareHouseID,@ToWareHouseID
*/

 CREATE PROCEDURE WP0128
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,
     @Date DATETIME,
	 @FromObjectID VARCHAR(50),
	 @ToObjectID VARCHAR(50),
	 @FromContractID VARCHAR(50),
	 @ToContractID VARCHAR(50),
	 @FromWareHouseID VARCHAR(50),
	 @ToWareHouseID VARCHAR(50),
	 @VoucherTypeID VARCHAR(50)
)
AS
DECLARE @FromDate DATETIME,
		@ToDate DATETIME,
		@ContractID VARCHAR(50),
		@ObjectID VARCHAR(50),
		@CurrencyID VARCHAR(50),
		@WareHouseID VARCHAR(50),
		@NumDate INT,
		@BeginDate DATETIME,
		@EndDate DATETIME,
		@DayUnit TINYINT,
		@Cur CURSOR,
		@Cur1 CURSOR,
		@TranMonths VARCHAR(2),
		@VoucherNo VARCHAR(50),
		@PVoucherNo VARCHAR(50)

IF @TranMonth < 10 SET @TranMonths = '0'+CONVERT(VARCHAR(2),@TranMonth)
ELSE SET @TranMonths = CONVERT(VARCHAR(2),@TranMonth)

CREATE TABLE #NGAYTON (DivisionID VARCHAR(50), ContractID VARCHAR(50), VoucherID VARCHAR(50), VoucherNo VARCHAR(50), VoucherDate Datetime, WareHouseID VARCHAR(50), 
						InventoryID VARCHAR(50), ActualQuantity DECIMAL(28,8), FromDate DATETIME, ToDate DATETIME, ObjectID VARCHAR(50), CurrencyID VARCHAR(50),
						DayUnit TINYINT)
CREATE TABLE #VoucherNo (ObjectID VARCHAR(50), ContractID VARCHAR(50), VoucherNo VARCHAR(50))

---- Dữ liệu chạy cursor
SELECT T1.ObjectID, T1.ContractID, T1.CurrencyID, T2.InventoryID AS WareHouseID, 

CASE WHEN ISNULL(T3.ContractID,'') = '' THEN T2.ActBeginDate ELSE MAX(T3.ToDate) + 1 END AS FromDate,
CASE WHEN CONVERT(DATE, @Date,120) <= MAX(T3.ToDate) THEN CONVERT(DATE, @Date,120) 
ELSE (CASE WHEN CONVERT(DATE, @Date,120) > T2.ActEndDate THEN T2.ActEndDate ELSE CONVERT(DATE, @Date,120) END) END AS ToDate, 
ISNULL(T2.ActBeginDate,T2.BeginDate) AS ActBeginDate, ISNULL(T2.ActEndDate,T2.EndDate) AS ActEndDate, T1.DayUnit
INTO #Data
FROM AT1020 T1 WITH (NOLOCK)
LEFT JOIN AT1031 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractID = T2.ContractID
LEFT JOIN WT0099 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.ContractID = T3.ContractID
WHERE T1.DivisionID = @DivisionID
AND T1.ObjectID BETWEEN @FromObjectID AND @ToObjectID
AND T1.ContractID BETWEEN @FromContractID AND @ToContractID
AND T2.InventoryID BETWEEN @FromWareHouseID AND @ToWareHouseID
AND CONVERT(DATE, @Date,120) BETWEEN T1.BeginDate AND T1.EndDate
AND ISNULL(T2.InventoryID,'') <> ''
GROUP BY T1.ObjectID, T1.ContractID, T1.CurrencyID, T2.InventoryID, 
T3.ContractID, T2.ActBeginDate, T2.ActEndDate, T1.DayUnit, T2.BeginDate, T2.EndDate

--SELECT DATEDIFF(d,FromDate,ToDate), ContractID, ObjectID, CurrencyID, WareHouseID, FromDate, ToDate, ActBeginDate, ActEndDate, DayUnit
--FROM #Data
----WHERE ToDate >= FromDate
--ORDER BY ContractID, WareHouseID

---Tính ngày tồn theo mặt hàng của từng kho trong hợp đồng
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT ContractID, ObjectID, CurrencyID, WareHouseID, FromDate, ToDate, ActBeginDate, ActEndDate, DayUnit
FROM #Data
WHERE ToDate >= FromDate
ORDER BY ContractID, WareHouseID

OPEN @Cur
FETCH NEXT FROM @Cur INTO @ContractID, @ObjectID, @CurrencyID, @WareHouseID,@FromDate,@ToDate, @BeginDate, @EndDate, @DayUnit
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT IDENTITY(int, 1, 1) AS OrdeNo, T1.DivisionID, T1.VoucherDate, T1.InventoryID, Convert(Decimal(28,8),0) AS Quantity, 
	T1.VoucherDate AS FromDate, ISNULL(T1.VoucherDate, @ToDate) AS ToDate
	INTO #AV7000
	FROM  AV7000 T1
	LEFT JOIN WT0095 T2 ON T1.DivisionID = T2.DivisionID AND T1.InheritVoucherID = T2.VoucherID
	WHERE	T1.DivisionID = @DivisionID
	AND T1.ObjectID = @ObjectID
	AND T2.ContractID = @ContractID
	AND T1.WarehouseID LIKE @WarehouseID 
	AND T1.VoucherDate BETWEEN @FromDate AND @ToDate
	ORDER BY T1.InventoryID

	-- Update so luong ton theo tung ngay
	UPDATE T1
	SET		T1.Quantity = T2.EndQuantity	
	FROM #AV7000 T1
	INNER JOIN 
	(
		SELECT T1.DivisionID, T1.InventoryID, T2.VoucherDate, SUM(T1.SignQuantity) as EndQuantity
		FROM AV7000 T1
		inner join #AV7000 T2 on T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T1.VoucherDate <= T2.VoucherDate
		LEFT JOIN WT0095 T3 ON T1.DivisionID = T3.DivisionID AND T1.InheritVoucherID = T3.VoucherID
		WHERE	T1.DivisionID = @DivisionID
		AND T1.ObjectID = @ObjectID
		AND T3.ContractID = @ContractID
		AND T1.WarehouseID LIKE @WarehouseID 
		AND T1.VoucherDate <= T2.VoucherDate
		GROUP BY T1.DivisionID, T1.InventoryID, T2.VoucherDate
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T2.VoucherDate = T1.VoucherDate
	
	INSERT INTO #AV7000 (DivisionID, VoucherDate, InventoryID, Quantity, FromDate,ToDate)
	SELECT DivisionID, MIN(VoucherDate) - 1, InventoryID, Convert(Decimal(28,8),0) Quantity, @FromDate, MIN(VoucherDate) - 1
	FROM #AV7000
	GROUP BY DivisionID, InventoryID
	HAVING MIN(VoucherDate) > @FromDate

	UPDATE T1
	SET		T1.Quantity = T2.EndQuantity	
	FROM #AV7000 T1
	INNER JOIN 
	(
		SELECT T1.DivisionID, T1.InventoryID, T2.VoucherDate, SUM(T1.SignQuantity) as EndQuantity
		FROM AV7000 T1
		inner join #AV7000 T2 on T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T1.VoucherDate <= T2.VoucherDate
		LEFT JOIN WT0095 T3 ON T1.DivisionID = T3.DivisionID AND T1.InheritVoucherID = T3.VoucherID
		WHERE	T1.DivisionID = @DivisionID
		AND T1.ObjectID = @ObjectID
		AND T3.ContractID = @ContractID
		AND T1.WarehouseID LIKE @WarehouseID 
		AND T1.VoucherDate <= T2.VoucherDate
		AND T2.FromDate = @FromDate
		GROUP BY T1.DivisionID, T1.InventoryID, T2.VoucherDate
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T2.VoucherDate <= T1.VoucherDate
	WHERE T1.FromDate = @FromDate

	--- Update khoảng thời gian
	UPDATE	T1
	SET		T1.ToDate = T2.VoucherDate - 1
	FROM	#AV7000 T1
	INNER JOIN #AV7000 T2 ON T1.DivisionID = T2.DivisionID
							AND T1.InventoryID = T2.InventoryID AND T1.OrdeNo = T2.OrdeNo-1 

	UPDATE #AV7000
	SET ToDate = @ToDate
	FROM #AV7000 
	INNER JOIN
	(	
		SELECT InventoryID, MAX(VoucherDate) VoucherDate
		FROM #AV7000 
		GROUP BY InventoryID
	)T ON #AV7000.InventoryID = T.InventoryID AND #AV7000.VoucherDate = T.VoucherDate
	
	UPDATE T1
	SET		T1.Quantity = T2.EndQuantity	
	FROM #AV7000 T1
	INNER JOIN 
	(
		SELECT T1.DivisionID, T1.InventoryID, T2.VoucherDate, SUM(T1.SignQuantity) as EndQuantity
		FROM AV7000 T1
		inner join #AV7000 T2 on T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T1.VoucherDate <= T2.ToDate
		LEFT JOIN WT0095 T3 ON T1.DivisionID = T3.DivisionID AND T1.InheritVoucherID = T3.VoucherID
		WHERE	T1.DivisionID = @DivisionID
		AND T1.ObjectID = @ObjectID
		AND T3.ContractID = @ContractID
		AND T1.WarehouseID LIKE @WarehouseID 
		AND T1.VoucherDate <= @ToDate
		AND T2.ToDate = @ToDate
		GROUP BY T1.DivisionID, T1.InventoryID, T2.VoucherDate
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.InventoryID = T2.InventoryID AND T2.VoucherDate = T1.VoucherDate
	WHERE T1.ToDate = @ToDate

	--select '#AV7000', * from  #AV7000

	INSERT INTO #NGAYTON (DivisionID, ContractID, VoucherID, VoucherNo, VoucherDate, CurrencyID, WareHouseID, InventoryID, ActualQuantity, FromDate, ToDate, 
							ObjectID, DayUnit)
	SELECT #AV7000.DivisionID, @ContractID, NEWID(), '', CONVERT(DATE,GETDATE(),120), @CurrencyID, @WareHouseID, #AV7000.InventoryID, #AV7000.Quantity, FromDate, ToDate, 
	@ObjectID, @DayUnit
	FROM #AV7000
	WHERE Quantity > 0

	DROP TABLE #AV7000

FETCH NEXT FROM @Cur INTO @ContractID, @ObjectID, @CurrencyID, @WareHouseID,@FromDate,@ToDate, @BeginDate, @EndDate, @DayUnit
END 
Close @Cur 

----Sinh số chứng từ theo Đối tượng và hợp đồng
SET @Cur1 = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT ContractID, ObjectID
FROM #NGAYTON
OPEN @Cur1
FETCH NEXT FROM @Cur1 INTO @ContractID, @ObjectID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC AP0002  @DivisionID, @PVoucherNo OUTPUT , 'WT0099', @VoucherTypeID, @TranMonths, @TranYear,15, 3, 1, '/'		
	
	INSERT INTO #VoucherNo (ObjectID, ContractID, VoucherNo)
	VALUES (@ObjectID, @ContractID, @PVoucherNo)
	
FETCH NEXT FROM @Cur1 INTO @ContractID, @ObjectID
END 
Close @Cur1 

--SELECT '#VoucherNo', * FROM #VoucherNo

UPDATE T1
SET T1.VoucherNo = T2.VoucherNo
FROM #NGAYTON T1
LEFT JOIN #VoucherNo T2 ON T1.ObjectID = T2.ObjectID AND T1.ContractID = T2.ContractID

--select '#NGAYTON', * from #NGAYTON

---Tính chi phí lưu kho
INSERT INTO WT0099 (DivisionID, VoucherID, VoucherNo, VoucherDate, ObjectID, ContractID, WareHouseID, InventoryID, UnitPrice, Quantity,
ConvertCoefficient, UnitID, FromDate, ToDate, NumDate, OriginalAmount, ExchangeRate, ConvertAmount, DayUnit, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)

SELECT DISTINCT T1.DivisionID, T1.VoucherID, T1.VoucherNo, VoucherDate, T1.ObjectID, T1.ContractID, T1.WareHouseID, T1.InventoryID, T2.SalePrice AS UnitPrice,
T1.ActualQuantity, T3.ConvertCoefficient, T3.UnitID, T1.FromDate, T1.ToDate, DATEDIFF(d,FromDate,ToDate) + 1 AS NumDate, 
T1.ActualQuantity / T3.ConvertCoefficient * T2.SalePrice 
* CEILING(CONVERT(DECIMAL(28,8),DATEDIFF(d,FromDate,ToDate)+1)/ CONVERT(DECIMAL(28,8),CASE WHEN T1.DayUnit = 0 THEN 1  --Ngày
																						WHEN T1.DayUnit = 1 THEN 7  --Tuần
																						WHEN T1.DayUnit = 2 THEN 30 END)) AS OriginalAmount, 
T4.ExchangeRate,
CASE WHEN T4.Operator = 0 THEN T1.ActualQuantity / T3.ConvertCoefficient * T2.SalePrice 
*CEILING(CONVERT(DECIMAL(28,8),DATEDIFF(d,FromDate,ToDate)+1)/ CONVERT(DECIMAL(28,8),CASE WHEN T1.DayUnit = 0 THEN 1  --Ngày
																						  WHEN T1.DayUnit = 1 THEN 7  --Tuần
																						  WHEN T1.DayUnit = 2 THEN 30 END)) * T4.ExchangeRate
ELSE T1.ActualQuantity / T3.ConvertCoefficient * T2.SalePrice 
*CEILING(CONVERT(DECIMAL(28,8),DATEDIFF(d,FromDate,ToDate)+1)/ CONVERT(DECIMAL(28,8),CASE WHEN T1.DayUnit = 0 THEN 1  --Ngày
																						  WHEN T1.DayUnit = 1 THEN 7  --Tuần
																						  WHEN T1.DayUnit = 2 THEN 30 END)) / T4.ExchangeRate END AS ConvertAmount, T1.DayUnit,
@UserID AS CreateUserID, GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate
FROM #NGAYTON AS T1
LEFT JOIN AT1031 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractID = T2.ContractID AND T1.WareHouseID = T2.InventoryID
LEFT JOIN AT1025 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.ContractID = T3.ContractID AND T1.InventoryID = T3.InventoryID
LEFT JOIN AV1004 T4 ON T1.CurrencyID = T4.CurrencyID AND T4.DivisionID in (T1.DivisionID,'@@@')


DROP TABLE #Data
DROP TABLE #NGAYTON




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
