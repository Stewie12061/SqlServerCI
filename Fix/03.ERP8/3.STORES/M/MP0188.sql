IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0188]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0188]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Customize Angel: In báo cáo so sánh giá thành thực tế và định mức
---- Created by Tiểu Mai on 07/04/2017
---- Modified by Tiểu Mai on 17/04/2017: Fix lấy dữ liệu báo cáo theo công thức
---- Modified on 08/01/2018 by Bảo Anh: Bổ sung in tất cả đối tượng THCP
---- Modified on 19/03/2019 by Kim Thư: Viết lại xử lý làm tròn - cộng phần chênh lệch vào dòng có số tiền lớn nhất theo từng đối tượng, ko phân biệt ProductID
---- Modified on 24/04/2019 by Kim Thư: Bổ sung trường hợp phân bổ theo hệ số hay NVL tuy vào thiết lập, bổ sung làm tròn theo từng tài khoản SXC
---- Modified on 03/01/2020 by Huỳnh Thử: Bố sung Distinct, cast Quantity decimal(28,16)
---- EXEC MP0188 'ANG', 201701, 201701, 'THCR012017', 'BBCN01', 'XOABO'

CREATE PROCEDURE [dbo].[MP0188] 
    @DivisionID NVARCHAR(50),
    @FromPeriod DECIMAL(28,8),
    @ToPeriod DECIMAL(28,8),
    @PeriodID NVARCHAR(50),
    @FromInventoryID NVARCHAR(50),
    @ToInventoryID NVARCHAR(50)
AS

CREATE TABLE #TEMP (APK UNIQUEIDENTIFIER DEFAULT NEWID(), PeriodID VARCHAR(50), ProductID VARCHAR(50), ProductName NVARCHAR(MAX), ProductQuantity DECIMAL(28,8), MaterialID VARCHAR(50),
					MaterialName NVARCHAR(MAX), MaterialTypeID VARCHAR(50), UnitID VARCHAR(50), UserName NVARCHAR(MAX), MaterialQuantity DECIMAL(28,8),
					QuantityUnit DECIMAL(28,8), ConvertedAmount DECIMAL(28,8), ConvertedUnit DECIMAL(28,8), ApportionCostID VARCHAR(50), ExpenseID VARCHAR(50),
					AccountID VARCHAR(50), MaterialUnitID VARCHAR(50))
INSERT INTO #TEMP (PeriodID, ProductID, ProductName, ProductQuantity, MaterialID, MaterialName, MaterialTypeID, UnitID, UserName, MaterialQuantity,
					QuantityUnit, ConvertedAmount, ConvertedUnit, ApportionCostID, ExpenseID,AccountID, MaterialUnitID)

	SELECT
		MT0400.PeriodID,
		MT0400.ProductID,
		AT1302_P.InventoryName AS ProductName,
		MT0400.ProductQuantity,
		(CASE WHEN MT0400.ExpenseID = 'COST001' THEN MT0400.MaterialID ELSE 'Z' + A.AccountID END) AS MaterialID,
		(CASE WHEN MT0400.ExpenseID = 'COST001' THEN AT1302_M.InventoryName ELSE AT1005.AccountName END) AS MaterialName,
		MT0400.MaterialTypeID,
		AT1302_P.UnitID,
		MT0699.UserName,
		MT0400.MaterialQuantity,
		MT1603.QuantityUnit,
		MT0400.ConvertedAmount,
		MT0400.ConvertedUnit,
		MT0400.ApportionCostID,
		MT0400.ExpenseID,
		(CASE WHEN MT0400.ExpenseID = 'COST001' THEN '' ELSE A.AccountID END) AS  AccountID,
		AT1302_M.UnitID AS MaterialUnitID
	FROM MT0400 WITH (NOLOCK)
	LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON AT1302_P.DivisionID = MT0400.DivisionID AND MT0400.ProductID = AT1302_P.InventoryID
	LEFT JOIN AT1302 AT1302_M WITH (NOLOCK) ON AT1302_M.DivisionID = MT0400.DivisionID AND MT0400.MaterialID = AT1302_M.InventoryID
	LEFT JOIN MT0699 WITH (NOLOCK) ON MT0699.DivisionID = MT0400.DivisionID AND MT0699.ExpenseID = MT0400.ExpenseID AND MT0699.MaterialTypeID = MT0400.MaterialTypeID
	LEFT JOIN MT1601 WITH (NOLOCK) ON MT1601.DivisionID = MT0400.DivisionID AND MT1601.PeriodID = MT0400.PeriodID
	LEFT JOIN MT5001 WITH (NOLOCK) ON MT5001.DivisionID = MT1601.DivisionID AND MT5001.DistributionID = MT1601.DistributionID AND MT5001.IsDistributed = 1 
						AND MT5001.MaterialTypeID = 'M02' AND MT5001.ExpenseID = 'COST001'
	LEFT JOIN MT1603 WITH (NOLOCK) ON MT1603.DivisionID = MT5001.DivisionID AND MT1603.ApportionID = MT5001.ApportionID 
						AND MT1603.ProductID = MT0400.ProductID AND MT1603.MaterialID = MT0400.MaterialID
	LEFT JOIN (SELECT DISTINCT MV9000.DivisionID, MV9000.PeriodID,
			(CASE D_C WHEN 'D' then MV9000.DebitAccountID ELSE MV9000.CreditAccountID END) AS AccountID
		FROM MV9000 
		WHERE MV9000.TranMonth + MV9000.TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
			AND MV9000.DivisionID= @DivisionID
			AND MV9000.ExpenseID='COST002' 
			AND MV9000.PeriodID LIKE @PeriodID
			AND ISNULL(MV9000.MaterialTypeID,'') <>'') A ON A.DivisionID = MT0400.DivisionID AND A.PeriodID = MT0400.PeriodID
	LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.DivisionID = A.DivisionID AND AT1005.AccountID = A.AccountID	
	WHERE MT0400.PeriodID LIKE @PeriodID AND MT0400.DivisionID = @DivisionID
		AND TranMonth + TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
		AND MT0400.ProductID BETWEEN @FromInventoryID AND @ToInventoryID
		AND MT0400.ExpenseID IN ( 'COST001', 'COST002')
UNION 

SELECT 
		MT0400.PeriodID,
		MT0400.ProductID,
		AT1302_P.InventoryName AS ProductName,
		MT0400.ProductQuantity,
		('Z' + A.AccountID) AS MaterialID,
		AT1005.AccountName AS MaterialName,
		MT0400.MaterialTypeID,
		AT1302_P.UnitID,
		MT0699.UserName,
		MT0400.MaterialQuantity,
		MT0400.QuantityUnit,
		0 AS ConvertedAmount,
		MT0400.ConvertedUnit,
		MT0400.ApportionCostID,
		MT0400.ExpenseID,
		A.AccountID,
		'' AS MaterialUnitID
FROM MT0400 WITH (NOLOCK)
LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON AT1302_P.DivisionID = MT0400.DivisionID AND MT0400.ProductID = AT1302_P.InventoryID
LEFT JOIN MT0699 WITH (NOLOCK) ON MT0699.DivisionID = MT0400.DivisionID AND MT0699.ExpenseID = MT0400.ExpenseID AND MT0699.MaterialTypeID = MT0400.MaterialTypeID
LEFT JOIN (SELECT DISTINCT MV9000.DivisionID, MV9000.PeriodID,
			(case D_C when  'D' then MV9000.DebitAccountID ELSE MV9000.CreditAccountID END) AS AccountID
		FROM MV9000 
		WHERE MV9000.TranMonth + MV9000.TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
			AND MV9000.DivisionID= @DivisionID
			AND MV9000.ExpenseID='COST003' 
			AND MV9000.PeriodID LIKE @PeriodID
			AND ISNULL(MV9000.MaterialTypeID,'') <>''
		) A ON A.DivisionID = MT0400.DivisionID AND A.PeriodID = MT0400.PeriodID
LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.DivisionID = A.DivisionID AND AT1005.AccountID = A.AccountID																												
WHERE MT0400.ExpenseID = 'COST003'
		AND MT0400.PeriodID LIKE @PeriodID AND MT0400.DivisionID = @DivisionID
		AND TranMonth + TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
		AND MT0400.ProductID BETWEEN @FromInventoryID AND @ToInventoryID

----- Update lại định mức cho NPL thay thế
UPDATE #Temp
SET QuantityUnit = cast(MT0007.CoValues AS decimal(28,16)) * CAST(MT1603.QuantityUnit as decimal(28,16))
FROM #Temp T1
LEFT JOIN MT0400 WITH (NOLOCK) ON T1.ProductID = MT0400.ProductID AND T1.MaterialID = MT0400.MaterialID AND T1.PeriodID = MT0400.PeriodID
LEFT JOIN MT1601 WITH (NOLOCK) ON MT1601.DivisionID = MT0400.DivisionID AND MT1601.PeriodID = MT0400.PeriodID
LEFT JOIN MT5001 WITH (NOLOCK) ON MT5001.DivisionID = MT1601.DivisionID AND MT5001.DistributionID = MT1601.DistributionID AND MT5001.IsDistributed = 1 
					AND MT5001.MaterialTypeID = 'M02' AND MT5001.ExpenseID = 'COST001'
LEFT JOIN MT1603 WITH (NOLOCK) ON MT1603.DivisionID = MT5001.DivisionID AND MT1603.ApportionID = MT5001.ApportionID 
					AND MT1603.ProductID = MT0400.ProductID
INNER JOIN MT0007 WITH (NOLOCK) ON MT1603.DivisionID = MT0007.DivisionID AND MT1603.IsExtraMaterial = 1 And MT1603.MaterialGroupID = MT0007.MaterialGroupID AND MT0400.MaterialID = MT0007.MaterialID
WHERE MT0400.PeriodID LIKE @PeriodID AND MT0400.DivisionID = @DivisionID
		AND MT0400.TranMonth + MT0400.TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
		AND MT0400.ProductID BETWEEN @FromInventoryID AND @ToInventoryID
		AND MT0400.ExpenseID IN ( 'COST001')


DECLARE        @sSQL AS VARCHAR(8000), 
        @SumProductCovalues AS DECIMAL(28, 8), 
        @ProductCoValues AS DECIMAL(28, 8), 
        @ConvertedAmount AS DECIMAL(28, 8), 
        @ListProduct_cur AS CURSOR, 
        @ProductID AS VARCHAR(50), 
        @ProductQuantity AS DECIMAL(28, 8), 
        @ProductOthers AS DECIMAL(28, 8), 
        @ConvertedDecimal AS TINYINT,  --- Bien lam tron
        @AccountID NVARCHAR(50),
		@PeriodIDItem NVARCHAR(50),
		@DistributionID NVARCHAR(50),
		@MethodID VARCHAR(50),
		@CoefficientID VARCHAR(50),
		@ApportionID VARCHAR(50),
		@MaterialTypeID VARCHAR(50),
		@Method_Cur CURSOR,
		@PeriodID1 VARCHAR(50)

SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 where DivisionID = @DivisionID)
---- Tong chi phi

--SET @DistributionID = (SELECT DistributionID FROM MT1601 WHERE PeriodID = @PeriodID AND DivisionID = @DivisionID)

---- Buoc 1. Xac dinh he so phan bo dua vao NVL da phan bo

CREATE TABLE #MV0188 (DivisionID VARCHAR(50), PeriodID VARCHAR(50), ProductID VARCHAR(50), ProductCoValues DECIMAL(28,8))

-- Xác định phương pháp phân bổ chi phí SXC
--SELECT @MethodID=MethodID, @CoefficientID=CoefficientID, @ApportionID=ApportionID, @MaterialTypeID=MaterialTypeID 
--FROM MT5001 WHERE DivisionID = @DivisionID AND DistributionID = @DistributionID AND ExpenseID = 'COST003' AND IsDistributed = 1 

SET @Method_Cur= CURSOR SCROLL KEYSET FOR 
	SELECT DISTINCT MT1601.PeriodID, MT5001.MethodID, MT5001.CoefficientID, MT5001.ApportionID, MT5001.MaterialTypeID 
	FROM MT5001 WITH (NOLOCK) INNER JOIN MT1601 WITH (NOLOCK) ON MT5001.DistributionID = MT1601.DistributionID
	WHERE MT5001.DivisionID = @DivisionID AND MT5001.ExpenseID = 'COST003' AND MT5001.IsDistributed = 1 AND MT1601.PeriodID like @PeriodID
OPEN @Method_Cur
FETCH NEXT FROM @Method_Cur INTO  @PeriodID1, @MethodID, @CoefficientID, @ApportionID, @MaterialTypeID       
WHILE @@Fetch_Status = 0
    BEGIN
		IF @MethodID='D04'
			SET @sSQL ='
			INSERT INTO #MV0188
			SELECT DISTINCT MT0400.DivisionID, MT0400.PeriodID, MT0400.ProductID, SUM(ConvertedAmount) AS ProductCoValues
			FROM MT0400 WITH (NOLOCK) 
			WHERE ExpenseID = ''COST001'' AND MT0400.DivisionID = ''' + @DivisionID + '''
					AND TranMonth + TranYear *100 BETWEEN '+CONVERT(NVARCHAR(50),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(50),@ToPeriod) +'
					AND PeriodID LIKE '''+@PeriodID1+'''
			GROUP BY MT0400.DivisionID, MT0400.PeriodID, MT0400.ProductID'

		ELSE IF @MethodID='D02'
			SET @sSQL ='
				INSERT INTO #MV0188
				SELECT DISTINCT MT0400.DivisionID, MT0400.PeriodID, MT0400.ProductID, MT1605.CoValue*MT0400.ProductQuantity AS ProductCoValues
				FROM MT0400 WITH (NOLOCK) LEFT JOIN MT1605 WITH(NOLOCK) ON MT0400.DivisionID = MT1605.DivisionID AND MT0400.ProductID = MT1605.InventoryID
				WHERE MT0400.DivisionID = ''' + @DivisionID + '''
				AND TranMonth + TranYear *100 BETWEEN '+CONVERT(NVARCHAR(50),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(50),@ToPeriod) +'
				AND PeriodID LIKE '''+@PeriodID1+''' AND CoefficientID LIKE '''+@CoefficientID+'''
			'
		EXEC (@sSQL)
        FETCH NEXT FROM @Method_Cur INTO  @PeriodID1, @MethodID, @CoefficientID, @ApportionID, @MaterialTypeID   
    END

CLOSE @Method_Cur

--IF @MethodID='D04'
--	SET @sSQL ='
--	SELECT  MT0400.DivisionID, MT0400.PeriodID, MT0400.ProductID, SUM(ConvertedAmount) AS ProductCoValues
--	FROM MT0400 WITH (NOLOCK) 
--	WHERE ExpenseID = ''COST001'' AND MT0400.DivisionID = ''' + @DivisionID + '''
--			AND TranMonth + TranYear *100 BETWEEN '+CONVERT(NVARCHAR(50),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(50),@ToPeriod) +'
--			AND PeriodID LIKE '''+@PeriodID+'''
--	GROUP BY MT0400.DivisionID, MT0400.PeriodID, MT0400.ProductID'

--ELSE IF @MethodID='D02'
--	SET @sSQL ='
--		SELECT DISTINCT MT0400.DivisionID, MT0400.PeriodID, MT0400.ProductID, MT1605.CoValue*MT0400.ProductQuantity AS ProductCoValues
--		FROM MT0400 WITH (NOLOCK) LEFT JOIN MT1605 WITH(NOLOCK) ON MT0400.DivisionID = MT1605.DivisionID AND MT0400.ProductID = MT1605.InventoryID
--		WHERE MT0400.DivisionID = ''' + @DivisionID + '''
--		AND TranMonth + TranYear *100 BETWEEN '+CONVERT(NVARCHAR(50),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(50),@ToPeriod) +'
--		AND PeriodID LIKE '''+@PeriodID+''' AND CoefficientID LIKE '''+@CoefficientID+'''
--	'
		
----PRINT @sSQL

------ Tao VIEW he so chung can phan bo cho san pham
--IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV0188' AND Xtype ='V')
--    EXEC ('CREATE VIEW MV0188 AS '+@sSQL)
--ELSE
--    EXEC ('ALTER VIEW MV0188 AS '+@sSQL)


--SET @SumProductCovalues = (SELECT SUM(ISNULL(ProductCovalues, 0)) FROM MV0188)   

SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
    SELECT  MV0188.PeriodID, ProductID, ProductCoValues, A.AccountID, A.ConvertedAmount
FROM #MV0188 MV0188   
LEFT JOIN (SELECT MV9000.DivisionID,
			MV9000.PeriodID,
			(CASE D_C WHEN 'D' then MV9000.DebitAccountID ELSE MV9000.CreditAccountID END) AS AccountID,
			SUM( CASE D_C  WHEN 'D' then ISNULL(MV9000.ConvertedAmount, 0) ELSE - ISNULL(MV9000.ConvertedAmount, 0) END) AS ConvertedAmount
		FROM MV9000 
		LEFT JOIN MT1601 WITH (NOLOCK) ON MV9000.PeriodID = MT1601.PeriodID AND MV9000.DivisionID = MT1601.DivisionID
		LEFT JOIN MT5001 WITH (NOLOCK) ON MT5001.DivisionID = MV9000.DivisionID AND MT5001.MaterialTypeID = MV9000.MaterialTypeID AND MT1601.DistributionID = MT5001.DistributionID
		LEFT JOIN MT1603 WITH (NOLOCK) ON MT1603.DivisionID = MT5001.DivisionID AND MT1603.ApportionID = MT5001.ApportionID AND MV9000.InventoryID = MT1603.MaterialID
		WHERE MV9000.TranMonth + MV9000.TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
			AND MV9000.DivisionID= @DivisionID
			AND MV9000.ExpenseID='COST003' 
			AND MV9000.PeriodID LIKE @PeriodID
			AND ISNULL(MV9000.MaterialTypeID,'') <>''
		GROUP BY MV9000.DivisionID, MV9000.ProductID, MV9000.PeriodID, (CASE D_C when  'D' then MV9000.DebitAccountID ELSE MV9000.CreditAccountID END)) A ON A.DivisionID = MV0188.DivisionID AND A.PeriodID = MV0188.PeriodID
		        
OPEN    @ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO  @PeriodIDItem, @ProductID, @ProductCoValues, @AccountID, @ConvertedAmount
            
WHILE @@Fetch_Status = 0
    BEGIN
		SET @SumProductCovalues = (SELECT SUM(ISNULL(ProductCovalues, 0)) FROM #MV0188 WHERE PeriodID = @PeriodIDItem) 
		IF ISNULL(@SumProductCovalues, 0) <>0 
			BEGIN
				UPDATE #temp
				SET ConvertedAmount = round(((ISNULL(@ConvertedAmount, 0)/@SumProductCovalues)*ISNULL(@ProductCoValues, 0)), @ConvertedDecimal)
				FROM #temp t1
				WHERE t1.ProductID = @ProductID AND ExpenseID = 'COST003' AND AccountID LIKE @AccountID AND PeriodID LIKE @PeriodIDItem
			END      
        FETCH NEXT FROM @ListProduct_cur INTO  @PeriodIDItem, @ProductID, @ProductCoValues, @AccountID, @ConvertedAmount
    END

CLOSE @ListProduct_cur
/*
-- Xu ly lam tron
DECLARE @MaxAccountID AS VARCHAR(20), 
    @Detal DECIMAL(28, 8)
    
SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
    SELECT MT0400.PeriodID, MT0400.ProductID, (MT0400.ConvertedAmount - A.Amount) AS Detal FROM MT0400 WITH (NOLOCK)
	LEFT JOIN (SELECT SUM(ConvertedAmount) AS Amount, ProductID, ExpenseID, PeriodID
				 FROM #temp GROUP BY ExpenseID, ProductID, PeriodID) A ON A.ProductID = MT0400.ProductID AND MT0400.ExpenseID = A.ExpenseID AND MT0400.PeriodID = A.PeriodID
	WHERE MT0400.ExpenseID = 'COST003' AND MT0400.PeriodID LIKE @PeriodID
			AND (MT0400.ConvertedAmount - A.Amount) <> 0        
OPEN    @ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO  @PeriodIDItem, @ProductID, @Detal
            
WHILE @@Fetch_Status = 0
    BEGIN
    	
    	SELECT TOP 1 @MaxAccountID = AccountID FROM #temp WHERE ProductID = @ProductID AND ExpenseID = 'COST003' AND PeriodID = @PeriodIDItem
    	ORDER BY ConvertedAmount DESC 
    	
		UPDATE #temp
		SET ConvertedAmount = ConvertedAmount + @Detal
		WHERE ProductID = @ProductID AND ExpenseID = 'COST003' AND AccountID  = @MaxAccountID AND PeriodID = @PeriodIDItem


	FETCH NEXT FROM @ListProduct_cur INTO @PeriodIDItem, @ProductID, @Detal
    END

CLOSE @ListProduct_cur
*/

-- Xu ly lam tron
---- Số tiền chênh lệch của từng đối tượng THCP
SELECT MT0400.PeriodID, MT0400.ProductID, SUM(ISNULL(MT0400.ConvertedAmount,0))- A.Amount AS Detal INTO #Detal 
FROM MT0400 WITH (NOLOCK)
			INNER JOIN (SELECT SUM(ISNULL(ConvertedAmount,0)) AS Amount, ExpenseID, PeriodID, ProductID FROM #TEMP GROUP BY ExpenseID, PeriodID, ProductID
					) A ON MT0400.ExpenseID = A.ExpenseID AND MT0400.PeriodID = A.PeriodID AND MT0400.ProductID = A.ProductID
WHERE MT0400.ExpenseID = 'COST003' AND MT0400.PeriodID LIKE @PeriodID
GROUP BY MT0400.PeriodID, A.Amount, MT0400.ProductID

--Dòng có chi phí sản xuất chung lớn nhất của từng đối tượng THCP
SELECT DISTINCT A.PeriodID, A.ProductID, A.ConvertedAmount INTO #TEMP2 
FROM #TEMP	OUTER APPLY (SELECT TOP 1 * FROM #TEMP T2 WHERE T2.PeriodID = #TEMP.PeriodID AND T2.ExpenseID = 'COST003' AND T2.ProductID = #temp.ProductID ORDER BY T2.ConvertedAmount DESC) A
WHERE #TEMP.ExpenseID = 'COST003'

-- Cộng phân chênh lệch vào dòng có chi phí sản xuất chung lớn nhất của từng đối tượng THCP
UPDATE T1
SET T1.ConvertedAmount = T1.ConvertedAmount + T3.Detal
FROM #TEMP T1 INNER JOIN #TEMP2 T2 ON T1.PeriodID = T2.PeriodID AND T1.ConvertedAmount = T2.ConvertedAmount AND T1.ProductID = T2.ProductID
INNER JOIN #Detal T3 ON T3.PeriodID = T1.PeriodID AND T1.ProductID = T3.ProductID

-- Xử lý Số tiền chênh lệch của từng tài khoản SXC
SELECT #TEMP.PeriodID, #TEMP.MaterialID, SUM(#TEMP.ConvertedAmount) AS TempAmount, A.ConvertedAmount, (A.ConvertedAmount -  SUM(#TEMP.ConvertedAmount)) AS DiffAmount
INTO #DiffAmount
FROM #TEMP INNER JOIN (SELECT MV9000.DivisionID,
						MV9000.PeriodID, 
						(CASE D_C WHEN 'D' then MV9000.DebitAccountID ELSE MV9000.CreditAccountID END) AS AccountID,
						SUM( CASE D_C  WHEN 'D' then ISNULL(MV9000.ConvertedAmount, 0) ELSE - ISNULL(MV9000.ConvertedAmount, 0) END) AS ConvertedAmount
					FROM MV9000 
					WHERE MV9000.TranMonth + MV9000.TranYear *100 BETWEEN @FromPeriod AND @ToPeriod
						AND MV9000.DivisionID= @DivisionID
						AND MV9000.ExpenseID='COST003' 
						AND MV9000.PeriodID LIKE @PeriodID
						AND ISNULL(MV9000.MaterialTypeID,'') <>''
					GROUP BY MV9000.DivisionID, MV9000.PeriodID, (CASE D_C when  'D' then MV9000.DebitAccountID ELSE MV9000.CreditAccountID END)) A
					ON #TEMP.PeriodID = A.PeriodID AND #TEMP.MaterialID = 'Z'+A.AccountID
GROUP BY #TEMP.PeriodID, #TEMP.MaterialID, A.ConvertedAmount

SELECT DISTINCT A.APK, A.PeriodID, A.MaterialID INTO #TEMP3
FROM #TEMP OUTER APPLY (SELECT TOP 1 APK, PeriodID,ProductID,MaterialID FROM #TEMP T2 WHERE T2.PeriodID=#TEMP.PeriodID AND T2.MaterialID = #TEMP.MaterialID  AND T2.ExpenseID = 'COST003'
						ORDER BY T2.ConvertedAmount DESC) A
WHERE #TEMP.ExpenseID = 'COST003'
ORDER BY  A.PeriodID, A.MaterialID 

UPDATE #TEMP
SET #TEMP.ConvertedAmount= #TEMP.ConvertedAmount + #DiffAmount.DiffAmount
FROM #TEMP INNER JOIN #TEMP3 ON #TEMP.APK = #TEMP3.APK
INNER JOIN #DiffAmount ON #DiffAmount.PeriodID = #TEMP3.PeriodID AND #DiffAmount.MaterialID = #TEMP3.MaterialID

-------------------------------------------------------------------------------------------------
SELECT * FROM #temp
--WHERE (MaterialQuantity <> 0 AND ExpenseID = 'COST001') OR ExpenseID IN ( 'COST002', 'COST003')
ORDER BY PeriodID, ProductID, ExpenseID, MaterialID




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
