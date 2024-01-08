IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Hoang Thi Lan Date 12/11/2003
--Purpose :Tính chi phí dở dang cuối kỳ cho NVL TT theo PP NVL truc triep
--Tinh cho tung NVL
--Edit BY: Vo Thanh Huong, date: 01/03/2006
---- Modified on 21/09/2018 by Bảo Anh: Sửa lỗi CPDD tính sai khi 1 SPDD có nhiều tỷ lệ hoàn thành khác nhau
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- Modified by Kim Thư on 07/05/2019: Không sum số lượng thành phẩm dở dang vì 1 SP có thể có nhiều thành phẩm dở dang với tỷ lệ hoàn thành khác nhau
----									Phân rã số đầu kỳ và phát sinh trong kỳ theo tỷ lệ hoàn thành của từng product
---- Modified by Kim Thư on 25/06/2019: Cast nhưng dữ liệu tính toán về dạng DECIMAL(38, 20) để tránh sai số lẻ
---- Modified by Kim Thư on 25/06/2019: Cast nhưng dữ liệu tính toán về dạng DECIMAL(38, 20) để tránh overflow numeric
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Nhựt Trường on 21/09/2021: Fix lỗi tách dòng khi lấy dữ liệu cho bảng #DELTA2.
---- Modified by Xuân Nguyên on 26/05/2023:[2023/05/IS/0113] Bổ sung ISNULL cho ProductID,MaterialID ở điều kiện lọc khi lấy dữ liệu vào #MT1613
 
CREATE PROCEDURE  [dbo].[MP8103] @DivisionID AS NVARCHAR(50), 
				@UserID AS VARCHAR(50), 
                 @PeriodID AS NVARCHAR(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS NVARCHAR(50), 
                 @VoucherID AS NVARCHAR(50), 
                 @CMonth AS NVARCHAR(50), 
                 @CYear AS NVARCHAR(50),
				 @VoucherNo NVARCHAR(50) 

AS 
SET NOCOUNT OFF
DECLARE @sSQL AS VARCHAR(8000), 
    @BSumConverted621 AS DECIMAL(38, 20), --Chi phí NVL đầu kỳ
    @ISumConverted621 AS DECIMAL(38, 20), --Chi phí NVL trong kỳ
    @Quantity AS DECIMAL(38, 20), --Số lượng thành phẩm
    @QuantityInprocess AS DECIMAL(38, 20), --Số lương dở dang cuối kỳ
    @MaterialRate AS DECIMAL(38, 20), --Tỉ lệ % NVL
    @MaterialID AS NVARCHAR(50), 
    @MaterialQuantity AS DECIMAL(38, 20), 
    @ConvertedAmount AS DECIMAL(38, 20), 
    @ProductQuantity AS DECIMAL(38, 20), 
    @MaterialInprocessCost AS DECIMAL(38, 20), 
    @ProductID AS NVARCHAR(50), 
    @PerfectRate AS DECIMAL(38, 20), 
    @InProcessQuantity AS DECIMAL(38, 20), 
    @ProductQuantityEnd AS DECIMAL(38, 20), 
    @BMaterialQuantity AS DECIMAL(38, 20), --SL NVL DD đầu kỳ
    @HumanResourceRate AS DECIMAL(38, 20), 
    @ConvertedUnitEnd AS DECIMAL(38, 20), 
    @OthersRate AS DECIMAL(38, 20), 
    @QuantityUnit AS DECIMAL(38, 20), 
    @TransactionID AS NVARCHAR(50), 
    @ProductUnitID AS NVARCHAR(50), 
    @MaterialUnitID AS NVARCHAR(50), 
    @ListMaterial_cur AS CURSOR, 
    @ConvertedDecimal INT

SELECT @ConvertedDecimal = ConvertDecimal FROM MT0000

CREATE TABLE #MT1613 
(
	APK UNIQUEIDENTIFIER DEFAULT NEWID()
	, ProductID VARCHAR(50)
	, ProductQuantity DECIMAL(38, 20)
	, MaterialID VARCHAR(50)
	, InProcessQuantity DECIMAL(38, 20)
	, PerfectRate DECIMAL(38, 20)
	, MaterialRate DECIMAL(38, 20)
	, ProductQuantityEnd DECIMAL(38, 20)
	, ProductUnitID VARCHAR(50)
	, MaterialUnitID VARCHAR(50)
	, ConvertedAmount DECIMAL(38, 20)
	, MaterialQuantity DECIMAL(38, 20)
	, BSumConverted621 DECIMAL(38, 20)
	, BMaterialQuantity DECIMAL(38, 20)
	, MaterialInprocessCost DECIMAL(38, 20)
	, ConvertedUnitEnd DECIMAL(38, 20)
	, QuantityUnit DECIMAL(38, 20)
)

INSERT INTO #MT1613 
(
	ProductID
	, ProductQuantity
	, MaterialID
	, InProcessQuantity
	, PerfectRate
	, MaterialRate
	, ProductQuantityEnd
	, ProductUnitID
	, MaterialUnitID
	, ConvertedAmount
	, MaterialQuantity
	, BSumConverted621
	, BMaterialQuantity
	, MaterialInprocessCost
	, ConvertedUnitEnd
	, QuantityUnit
)

SELECT MT0400.ProductID
    , ProductQuantity = ISNULL(
								(SELECT SUM(MT1001.Quantity) 
								 FROM MT1001 WITH(NOLOCK) 
								 INNER JOIN MT0810 WITH(NOLOCK) ON MT0810.VoucherID = MT1001.VoucherID 
								 WHERE MT1001.ProductID = MT0400.ProductID 
								 AND MT0810.ResultTypeID ='R01' 
								 AND MT0810.PeriodID = @PeriodID  
								 AND MT0810.DivisionID=@DivisionID), 
							0)
	, MT0400.MaterialID --So lượng TP được SX trong ky
	, MT2222.ProductQuantity AS InProcessQuantity --- So luong thanh pham do dang 
    , MT2222.PerfectRate AS PerfectRate
	, MT2222.MaterialRate AS MaterialRate
	, MT2222.ProductQuantity AS ProductQuantityEnd
    --SUM(MT2222.ProductQuantity) AS InProcessQuantity, --- So luong thanh pham do dang 
    --MAX(MT2222.PerfectRate) AS PerfectRate, 
    --MAX(MT2222.MaterialRate) AS MaterialRate, 
    --SUM(MT2222.ProductQuantity) AS ProductQuantityEnd, 
    , AT1302_P.UnitID AS ProductUnitID
	, AT1302_M.UnitID AS MaterialUnitID
	--MAX(ISNULL(MT0400.ConvertedAmount, 0)) AS ConvertedAmount, ---  Chi phi phat sinh trong kỳ
    --MAX(ISNULL(MT0400.MaterialQuantity, 0)) AS MaterialQuantity, 
	, ROUND(MAX(ISNULL(MT0400.ConvertedAmount, 0)) * (MT2222.ProductQuantity * MT2222.MaterialRate / 100) / MT0400.ProductQuantity, @ConvertedDecimal) AS ConvertedAmount ---  Chi phi phat sinh trong kỳ
    , ROUND(MAX(ISNULL(MT0400.MaterialQuantity, 0)) * (MT2222.ProductQuantity * MT2222.MaterialRate / 100) / MT0400.ProductQuantity, @ConvertedDecimal) AS MaterialQuantity
	, BSumConverted621 = ROUND(
								(
									(
										ISNULL
										(
											(SELECT SUM(ISNULL(MT1613.ConvertedAmount, 0))
												FROM MT1613 WITH(NOLOCK)
												WHERE MT1613.PeriodID = @PeriodID 
													AND MT1613.TranMonth = @TranMonth 
													AND TranYear = @TranYear  
													AND MT1613.ExpenseID= 'COST001' 
													AND MT1613.MaterialTypeID =  @MaterialTypeID  
													AND MT1613.MaterialID = MT0400.MaterialID 
													AND MT1613.ProductID = MT0400.ProductID  
													AND MT1613.DivisionID = @DivisionID 
													AND Type ='B'
												)
										, 0
										) 
										* (MT2222.ProductQuantity * MT2222.MaterialRate / 100)
									 ) 
									 / MT0400.ProductQuantity
								 )
								 , @ConvertedDecimal
								)
	, BMaterialQuantity = ROUND(
								 (
									(
										ISNULL
										(
											(SELECT SUM(ISNULL(MT1613.MaterialQuantity, 0)) 
											 FROM MT1613 WITH(NOLOCK)
											 WHERE MT1613.PeriodID = @PeriodID  
													AND MT1613.TranMonth = @TranMonth 
													AND MT1613.TranYear = @TranYear   
													AND MT1613.ExpenseID = 'COST001' 
													AND MT1613.MaterialTypeID = @MaterialTypeID  
													AND MT1613.MaterialID =  MT0400.MaterialID 
													AND MT1613.ProductID = MT0400.ProductID 
													AND MT1613.DivisionID = @DivisionID 
													AND MT1613.Type ='B'
											 )
											, 0
										 ) 
										 * (MT2222.ProductQuantity * MT2222.MaterialRate/100)
									) 
									/ MT0400.ProductQuantity),
								  @ConvertedDecimal
								)
	, 0 AS MaterialInprocessCost
	, 0 AS ConvertedUnitEnd
	, 0 AS QuantityUnit
FROM MT0400 WITH(NOLOCK) 
LEFT JOIN MT2222 WITH(NOLOCK) ON MT0400.DivisionID = MT2222.DivisionID 
									AND MT0400.ProductID=MT2222.ProductID
LEFT JOIN AT1302 AT1302_P WITH(NOLOCK) ON MT0400.ProductID = AT1302_P.InventoryID AND AT1302_P.DivisionID IN (MT0400.DivisionID,'@@@')
LEFT JOIN AT1302 AT1302_M WITH(NOLOCK) ON MT0400.MaterialID = AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MT0400.DivisionID,'@@@')
WHERE MT0400.DivisionID = @DivisionID 
		AND MT0400.PeriodID =  @PeriodID 
		AND MT0400.ExpenseID = 'COST001' 
		AND MT0400.MaterialTypeID =  @MaterialTypeID 
		AND MT0400.ProductID IN (SELECT DISTINCT ProductID FROM MT2222 WITH(NOLOCK))		
GROUP BY MT0400.ProductID 
	     , MT0400.MaterialID --So lượng TP được SX trong ky
		 -- MT2222.ProductQuantity, --- So luong thanh pham do dang 
		 --  MT2222.PerfectRate, 
		 --MT2222.MaterialRate, 
		 --MT2222.ProductQuantity, 
		, AT1302_P.UnitID
		, AT1302_M.UnitID
		, MT2222.ProductQuantity
		, MT2222.PerfectRate
		, MT2222.MaterialRate
		, MT0400.DivisionID
		, MT0400.productID
		, MT0400.ProductQuantity
UNION
SELECT MT1613.ProductID 
    , ProductQuantity = ISNULL((SELECT SUM(MT1001.Quantity) 
								FROM MT1001 WITH(NOLOCK) 
								INNER JOIN MT0810 WITH(NOLOCK) ON MT0810.VoucherID = MT1001.VoucherID 
								WHERE MT1001.ProductID = MT1613.ProductID 
										AND MT0810.ResultTypeID ='R01' 
										AND MT0810.PeriodID = @PeriodID  
										AND MT0810.DivisionID = @DivisionID)
						, 0)
    , MT1613.MaterialID --So lượng TP được SX trong ky
	, MT2222.ProductQuantity AS InProcessQuantity --- So luong thanh pham do dang 
    , MT2222.PerfectRate AS PerfectRate 
    , MT2222.MaterialRate AS MaterialRate
    , MT2222.ProductQuantity AS ProductQuantityEnd
    --SUM(MT2222.ProductQuantity) AS InProcessQuantity, --- So luong thanh pham do dang 
    --MAX(MT2222.PerfectRate) AS PerfectRate, 
    --MAX(MT2222.MaterialRate) AS MaterialRate, 
    --SUM(MT2222.ProductQuantity) AS ProductQuantityEnd, 
    , AT1302_P.UnitID AS ProductUnitID
    , AT1302_M.UnitID AS MaterialUnitID
    , 0 AS ConvertedAmount ---  Chi phi phat sinh trong kỳ
    , 0 AS MaterialQuantity
    , BSumConverted621 = SUM(ISNULL(ConvertedAmount, 0))
    , BMaterialQuantity = SUM(ISNULL(MaterialQuantity, 0))
	, 0 AS MaterialInprocessCost
	, 0 AS ConvertedUnitEnd, 0 AS QuantityUnit 
FROM MT1613 WITH (NOLOCK)
LEFT JOIN MT2222 WITH(NOLOCK) ON MT1613.DivisionID = MT2222.DivisionID 
									AND MT1613.ProductID = MT2222.ProductID
LEFT JOIN AT1302 AT1302_P WITH(NOLOCK) ON MT1613.ProductID = AT1302_P.InventoryID AND AT1302_P.DivisionID IN (MT1613.DivisionID,'@@@')
LEFT JOIN AT1302 AT1302_M WITH(NOLOCK) ON MT1613.MaterialID = AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MT1613.DivisionID,'@@@')    
WHERE MT1613.DivisionID = @DivisionID 
		AND MT1613.PeriodID = @PeriodID 
		AND MT1613.ExpenseID = 'COST001' 
		AND MT1613.MaterialTypeID = @MaterialTypeID 
		AND MT1613.Type='B' 
		AND MT1613.ProductID IN (SELECT DISTINCT ProductID FROM  MT2222 WITH(NOLOCK))  
		AND ISNULL(MT1613.ProductID,'') + ISNULL(MT1613.MaterialID,'')  NOT IN (SELECT DISTINCT ISNULL(MT0400.ProductID,'') + ISNULL(MT0400.MaterialID,'') 
															FROM MT0400 WITH(NOLOCK)
															WHERE 
																MT0400.DivisionID = @DivisionID
																AND MT0400.PeriodID = @PeriodID  
																AND MT0400.ExpenseID ='COST001'
																AND MT0400.MaterialTypeID = @MaterialTypeID
														)
GROUP BY MT1613.ProductID
     , MT1613.MaterialID --So lượng TP được SX trong ky
     --MT2222.ProductQuantity, --- So luong thanh pham do dang 
     --MT2222.PerfectRate, 
     --MT2222.MaterialRate, 
     --MT2222.ProductQuantity, 
     , AT1302_P.UnitID 
     , AT1302_M.UnitID
	 , MT2222.ProductQuantity
	 , MT2222.PerfectRate
	 , MT2222.MaterialRate

------------------------------------------------------ Làm tròn các giá trị chênh lệch----------------------------------------------------------------------------------------------
SELECT T1.ProductID
		, T1.MaterialID
		, ISNULL(T2.ConvertedAmount,0) - SUM(T1.ConvertedAmount) AS ConvertedAmount_delta
		, ISNULL(T2.MaterialQuantity,0) - SUM(T1.MaterialQuantity) AS MaterialQuantity_delta
INTO #DELTA
FROM #MT1613 T1 WITH(NOLOCK)
LEFT JOIN MT0400 T2 WITH(NOLOCK) ON T1.ProductID = T2.ProductID 
										AND T1.MaterialID = T2.MaterialID 
										AND T2.PeriodID = @PeriodID 
										AND T2.ExpenseID = 'COST001'
										AND T2.MaterialTypeID = @MaterialTypeID
GROUP BY T1.ProductID
		, T1.MaterialID
		, T2.ConvertedAmount
		, T2.MaterialQuantity

--SELECT T1.ProductID
--		, T1.MaterialID
--		, ISNULL(T3.ConvertedAmount, 0) - SUM(T1.BSumConverted621) AS BSumConverted621_delta
--		, ISNULL(T3.MaterialQuantity, 0) - SUM(T1.BMaterialQuantity) AS BMaterialQuantity_delta
--INTO #DELTA2
--FROM #MT1613 T1
--LEFT JOIN MT1613 T3 WITH(NOLOCK) ON T1.ProductID = T3.ProductID 
--										AND T1.MaterialID = T3.MaterialID 
--										AND T3.PeriodID = @PeriodID 
--										AND T3.Type='B' 
--										AND T3.ExpenseID = 'COST001' 
--										AND T3.MaterialTypeID=@MaterialTypeID
--GROUP BY T1.ProductID
--			, T1.MaterialID
--			, T3.ConvertedAmount
--			, T3.MaterialQuantity;

SELECT A.ProductID, A.MaterialID
	 , SUM(ISNULL(T3.ConvertedAmount, 0)) - (BSumConverted621_delta) AS BSumConverted621_delta
	 , SUM(ISNULL(T3.MaterialQuantity, 0)) - (BMaterialQuantity_delta) AS BMaterialQuantity_delta
INTO #DELTA2
FROM (
		SELECT DISTINCT T1.ProductID
				, T1.MaterialID
				, SUM(T1.BSumConverted621) AS BSumConverted621_delta
				, SUM(T1.BMaterialQuantity) AS BMaterialQuantity_delta
		FROM #MT1613 T1
		GROUP BY T1.ProductID, T1.MaterialID) A
LEFT JOIN MT1613 T3 WITH(NOLOCK) ON A.ProductID = T3.ProductID 
									AND A.MaterialID = T3.MaterialID 
									AND T3.PeriodID = @PeriodID 
									AND T3.Type='B' 
									AND T3.ExpenseID = 'COST001' 
									AND T3.MaterialTypeID=@MaterialTypeID
GROUP BY A.ProductID
	   , A.MaterialID
	   , A.BSumConverted621_delta
	   , A.BMaterialQuantity_delta;

UPDATE T1
SET T1.ConvertedAmount = T1.ConvertedAmount + T2.ConvertedAmount_delta
FROM #MT1613 T1
    INNER JOIN #DELTA T2
        ON T1.ProductID = T2.ProductID
           AND T1.MaterialID = T2.MaterialID
    OUTER APPLY
(
    SELECT TOP 1
           APK,
           ProductID,
           MaterialID,
           ConvertedAmount
    FROM #MT1613 A
    WHERE A.ProductID = T1.ProductID
          AND A.MaterialID = T1.MaterialID
    ORDER BY A.ConvertedAmount DESC
) T3
WHERE T1.APK = T3.APK;

UPDATE T1
SET T1.BSumConverted621 = T1.BSumConverted621 + T2.BSumConverted621_delta
FROM #MT1613 T1
    INNER JOIN #DELTA2 T2
        ON T1.ProductID = T2.ProductID
           AND T1.MaterialID = T2.MaterialID
    OUTER APPLY
(
    SELECT TOP 1
           APK,
           ProductID,
           MaterialID,
           BSumConverted621
    FROM #MT1613 A
    WHERE A.ProductID = T1.ProductID
          AND A.MaterialID = T1.MaterialID
    ORDER BY A.BSumConverted621 DESC
) T3
WHERE T1.APK = T3.APK;

UPDATE T1
SET T1.MaterialQuantity = T1.MaterialQuantity + T2.MaterialQuantity_delta
FROM #MT1613 T1
    INNER JOIN #DELTA T2
        ON T1.ProductID = T2.ProductID
           AND T1.MaterialID = T2.MaterialID
    OUTER APPLY
(
    SELECT TOP 1
           APK,
           ProductID,
           MaterialID,
           MaterialQuantity
    FROM #MT1613 A
    WHERE A.ProductID = T1.ProductID
          AND A.MaterialID = T1.MaterialID
    ORDER BY A.MaterialQuantity DESC
) T3
WHERE T1.APK = T3.APK;

UPDATE T1
SET T1.BMaterialQuantity = T1.BMaterialQuantity + T2.BMaterialQuantity_delta
FROM #MT1613 T1
    INNER JOIN #DELTA2 T2
        ON T1.ProductID = T2.ProductID
           AND T1.MaterialID = T2.MaterialID
    OUTER APPLY
(
    SELECT TOP 1
           APK,
           ProductID,
           MaterialID,
           BMaterialQuantity
    FROM #MT1613 A
    WHERE A.ProductID = T1.ProductID
          AND A.MaterialID = T1.MaterialID
    ORDER BY A.BMaterialQuantity DESC
) T3
WHERE T1.APK = T3.APK;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Tính chi phí DD CKỳ NVL theo PP NVLTT
UPDATE #MT1613
--SET MaterialInprocessCost = CASE WHEN ProductQuantity + InProcessQuantity = 0 THEN 0
--							ELSE round((ISNULL(BSumConverted621, 0) +ISNULL(ConvertedAmount, 0)) *ISNULL(InProcessQuantity, 0)/(ISNULL(ProductQuantity, 0) +ISNULL(InProcessQuantity, 0)), @ConvertedDecimal)
--							END

SET MaterialInprocessCost = 
CASE WHEN ProductQuantity + InProcessQuantity = 0 THEN 0
ELSE round(
			(
				ISNULL(CAST(BSumConverted621 AS DECIMAL(38, 20)), 0) 
				+ ISNULL(CAST(ConvertedAmount AS DECIMAL(38, 20)), 0)
			) 
			* 
			(
				ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0)
				* (CAST(MaterialRate AS DECIMAL(38, 20))/100)
			)
			 /
			(
				ISNULL(CAST(ProductQuantity AS DECIMAL(38, 20)), 0) 
				+ (ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0)
				* CAST(MaterialRate AS DECIMAL(38, 20)) / 100)
			), 
			@ConvertedDecimal)
END

---- Tính chi phí DD CKỳ  NVL theo PP Ước lượng tương đương/1SP
UPDATE #MT1613
SET ConvertedUnitEnd = CASE
                           WHEN ProductQuantityEnd = 0 THEN
                               0
                           ELSE
                               ISNULL(CAST(MaterialInprocessCost AS DECIMAL(38, 20)), 0)
                               / CAST(ProductQuantityEnd AS DECIMAL(38, 20))
                       END;

---- Tính  SL NVL theo PP Ước lượng tương đương/1SP
UPDATE #MT1613
SET QuantityUnit = CASE
                       WHEN (ISNULL(ProductQuantity, 0) + ISNULL(InProcessQuantity, 0)) <> 0
                            AND ProductQuantityEnd <> 0 THEN
    ((ISNULL(CAST(BMaterialQuantity AS DECIMAL(38, 20)), 0) + ISNULL(CAST(MaterialQuantity AS DECIMAL(38, 20)), 0))
     * ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0)
     / (ISNULL(CAST(ProductQuantity AS DECIMAL(38, 20)), 0) + ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0))
    )
    / CAST(ProductQuantityEnd AS DECIMAL(38, 20))
                       ELSE
                           0
                   END;

-- Lấy thông tin master cho MT1613
DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
		@UnfinishCostDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @UnfinishCostVoucherTypeID =
(
    SELECT ISNULL(UnfinishCostVoucherTypeID, 'CPDD')
    FROM MT0000 WITH (NOLOCK)
    WHERE DivisionID = @DivisionID
);

SET @UnfinishCostDescription =
(
    SELECT ISNULL(UnfinishCostDescription + ' ', N'Chi phí dở dang ')
    FROM MT0000 WITH (NOLOCK)
    WHERE DivisionID = @DivisionID
);

SET @PeriodStr = CASE
                     WHEN @TranMonth < 10 THEN
                         '0' + LTRIM(@TranMonth) + LTRIM(@TranYear)
                     ELSE
                         LTRIM(@TranMonth) + LTRIM(@TranYear)
                 END;


--- Cập nhật vào bảng dở dang MT1613
INSERT MT1613
(
    PeriodID,
    TranMonth,
    TranYear,
    DivisionID,
    VoucherID,
    TransactionID,
    ProductID,
    MaterialID,
    ExpenseID,
    MaterialTypeID,
    ProductUnitID,
    MaterialUnitID,
    PerfectRate, --- ProductUnitID
    MaterialQuantity,
    ConvertedAmount,
    ProductQuantity,
    QuantityUnit,
    ConvertedUnit,
    CreateDate,
    CreateUserID,
    Type,
    MaterialRate,
    VoucherTypeID,
    VoucherNo,
    VoucherDate,
    EmployeeID,
    Description,
    LastModifyUserID,
    LastModifyDate
)
SELECT @PeriodID,
       @TranMonth,
       @TranYear,
       @DivisionID,
       @VoucherID,
       NEWID(),
       ProductID,
       MaterialID,
       'COST001',
       @MaterialTypeID,
       ProductUnitID,
       MaterialUnitID,
       PerfectRate,
       MaterialQuantity + BMaterialQuantity,
       MaterialInprocessCost,
       ProductQuantityEnd,
       QuantityUnit,
       ConvertedUnitEnd,
       GETDATE(),
       @UserID,
       'E',
       MaterialRate,
       @UnfinishCostVoucherTypeID,
       @VoucherNo,
       GETDATE(),
       @UserID,
       @UnfinishCostDescription + @PeriodStr,
       @UserID,
       GETDATE()
FROM #MT1613;

SELECT 'MT1613' AS TABLEID, * FROM #MT1613
      
GO
SET NOCOUNT OFF

