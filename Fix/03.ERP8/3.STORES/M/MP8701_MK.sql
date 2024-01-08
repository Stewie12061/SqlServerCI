IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8701_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP8701_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Tính chi phí dở dang cuối kỳ - chi phí SXC (Customize Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: SP MP8701
-- <History>
---- Create on 27/04/2016 by Phuong Thao
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- Modified by Kim Thu on 25/06/2019: Sua cong thuc tinh do dang cua product co phat sinh trong ky (quay ve cong thuc chuan)
---- Modified by Nhựt Trường on 24/08/2020: Merge code Meiko.
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
-- <Example>
---- 

CREATE PROCEDURE  [dbo].[MP8701_MK] @DivisionID AS NVARCHAR(50), 
                 @PeriodID AS NVARCHAR(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS NVARCHAR(50), 
                 @VoucherID AS NVARCHAR(50), 
                 @CMonth AS NVARCHAR(50), 
                 @CYear AS NVARCHAR(50)
AS 
DECLARE @sSQL AS VARCHAR(8000), 
    @BSumConverted627 AS DECIMAL(28, 8), --Chi phí NVL đầu kỳ
    @ISumConverted627 AS DECIMAL(28, 8), --Chi phí NVL trong kỳ
    @Quantity AS DECIMAL(28, 8), --Số lượng thành phẩm
    @QuantityInprocess AS DECIMAL(28, 8), --Số lương dở dang cuối kỳ
    @MaterialRate AS DECIMAL(28, 8), --Tỉ lệ % NVL
    @MaterialID AS NVARCHAR(50), 
    @ListMaterial_cur AS CURSOR, 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @InprocessCost AS DECIMAL(28, 8), 
    @ProductID AS NVARCHAR(50), 
    @PerfectRate AS DECIMAL(28, 8), 
    @InProcessQuantity AS DECIMAL(28, 8), 
    @TotalInProcessQuantity AS DECIMAL(28, 8), 
    @HumanResourceRate AS DECIMAL(28, 8), 
    @OthersRate AS DECIMAL(28, 8), 
    @ProductQuantityEnd AS DECIMAL(28, 8), 
    @ConvertedUnitEnd AS DECIMAL(28, 8), 
    @TransactionID AS NVARCHAR(50), 
    @ProductUnitID AS NVARCHAR(50), 
    @MaterialUnitID AS NVARCHAR(50), 
    @ListProduct_cur AS CURSOR, 
    @ListMaterial_cur1 AS CURSOR, 
    @ConvertedDecimal INT, 
    @SumInProcessQuantity AS DECIMAL(28, 8),
	@QuantityUnit AS DECIMAL(28, 8),
	@DistributeQty AS DECIMAL(28, 8)

SET NOCOUNT ON
SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 where DivisionID = @DivisionID)

SET @sSQL='
SELECT MaterialID, 
    SUM(ISNULL(MaterialQuantity, 0)) AS MaterialQuantity, 
    SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, 
    ProductID, --- Ma thanh pham
    ---- So luong thanh pham duoc san xuat trong ky
    ProductQuantity = ( SELECT SUM(Quantity) FROM MT1001 INNER JOIN MT0810 ON MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID 
                        WHERE MT1001.ProductID = MT0400.ProductID AND MT0810.ResultTypeID = ''R01'' 
                            AND MT0810.PeriodID = '''+@PeriodID+''' AND MT1001.DivisionID ='''+@DivisionID+'''), 
    AT1302_P.UnitID AS ProductUnitID, 
    AT1302_M.UnitID AS MaterialUnitID, 
	MT0400.ProductQuantity AS DistributeQty,
    MT0400.DivisionID
FROM MT0400 
    LEFT JOIN AT1302 AT1302_P ON MT0400.ProductID = AT1302_P .InventoryID AND AT1302_P .DivisionID IN (MT0400.DivisionID,''@@@'')
    LEFT JOIN AT1302 AT1302_M ON MT0400.MaterialID=AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MT0400.DivisionID,''@@@'')
WHERE MT0400.DivisionID ='''+@DivisionID+''' AND
    PeriodID = '''+@PeriodID+''' AND
    ExpenseID =''COST003'' AND
    MaterialTypeID = '''+@MaterialTypeID+''' AND
    ProductID IN (SELECT ProductID FROM  MT2222) 
GROUP BY MaterialID, ProductID, ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID, MT0400.DivisionID '

IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV8701_MK' AND Xtype ='V')
    EXEC ('CREATE VIEW MV8701_MK AS '+@sSQL)
ELSE
    EXEC ('ALTER VIEW MV8701_MK AS '+@sSQL)

--SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 

--SELECT MT1613.MaterialID, 
--    0 AS MaterialQuantity, 
--    0 AS ConvertedAmount, 
--    MT1613.ProductID, 
--    ProductQuantity = ISNULL((  SELECT SUM(ISNULL(Quantity, 0)) 
--                                FROM MT1001 INNER JOIN MT0810 ON MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID
--                                WHERE MT1001.ProductID = MT1613.ProductID 
--                                    AND MT0810.PeriodID = @PeriodID 
--                                    AND MT0810.ResultTypeID = 'R01' --- ket qua san xuat la thanh pham
--                                    AND MT0810.DivisionID = @DivisionID), 0), 
--    ISNULL(MT2222.ProductQuantity, 0)*ISNULL(MT2222.OthersRate, 0)/100 AS InPocessQuantity, 
--    TotalInProcessQuantity = (select sum(ISNULL(MT22.ProductQuantity, 0)*ISNULL(MT22.OthersRate, 0)/100) as InPocessQuantity from MT2222 MT22
--							Where MT22.DivisionID = MT2222.DivisionID  and MT22.ProductID = MT2222.ProductID
--							group by DivisionID,ProductID),
--							MT2222.PerfectRate, 
--							MT2222.MaterialRate, 
--							MT2222.HumanresourceRate, 
--							MT2222.OthersRate, 
--							MT2222.ProductQuantity *ISNULL(MT2222.OthersRate, 0)/100, 
--							IP.UnitID AS ProductUnitID, 
--							Null  AS MaterialUnitID
--FROM MT1613 INNER JOIN MT2222 ON MT2222.DivisionID = MT1613.DivisionID AND MT2222.ProductID = MT1613.ProductID
--    LEFT JOIN AT1302 AS IP ON IP.DivisionID = MT1613.DivisionID AND IP.InventoryID = MT1613.ProductID 
--WHERE MT1613.ProductID NOT IN (SELECT DISTINCT ProductID FROM MT0400 WHERE DivisionID = @DivisionID AND PeriodID =@PeriodID 
--                                AND MaterialTypeID = @MaterialTypeID AND ExpenseID ='COST003'  )   --- khong co phat sinh duoc phan bo
--    AND MT1613.PeriodID = @PeriodID 
--    AND MT1613.DivisionID = @DivisionID 
--    AND MT1613.MaterialTypeID = @MaterialTypeID 
--    AND MT1613.ExpenseID = 'COST003'
--	AND MT1613.Type = 'B'
--OPEN @ListProduct_cur 
--FETCH NEXT FROM  @ListProduct_cur INTO 
--    @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @TotalInProcessQuantity, @PerfectRate, @MaterialRate, 
--    @HumanResourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID 
--WHILE @@Fetch_Status = 0
--BEGIN    
--    --Bước 1 :Xác định chi phí NC DD đầu kỳ 
--    SET @BSumConverted627 = (SELECT SUM(ISNULL(ConvertedAmount, 0))
--                            FROM MT1613
--                            WHERE PeriodID =  @PeriodID AND TranMonth = @TranMonth AND TranYear = @TranYear 
--                                AND ExpenseID = 'COST003' AND MaterialTypeID = @MaterialTypeID AND  ProductID = @ProductID
--                                AND DivisionID = @DivisionID AND Type ='B')

--    --Bước 2:Xác định chi phí NC phát sinh trong kỳ
--    SET @ISumConverted627 = @ConvertedAmount

    
--    --Bước 3:Tính chi phí DD CKỳ  SXC theo PP Ước lượng tương đương
--    IF (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <> 0 
--        --SET @InprocessCost =(ISNULL(@BSumConverted627, 0) +ISNULL(@ISumConverted627, 0))*ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) 
--         SET @InprocessCost = Round((ISNULL(@BSumConverted627, 0) +ISNULL(@ISumConverted627, 0))
--         *ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@TotalInProcessQuantity, 0)), @ConvertedDecimal)
--    ELSE SET @InprocessCost = 0 

--    --Bước 4:Tính chi phí DD CKỳ  SXC/1SP
--    IF (@ProductQuantityEnd <>0)
--         SET @ConvertedUnitEnd = ISNULL(@InprocessCost, 0)/@ProductQuantityEnd
--    ELSE SET @ConvertedUnitEnd = 0
    
--    EXEC AP0002 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

--    INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
--            ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
--                      MaterialQuantity, ConvertedAmount, 
--              ProductQuantity, QuantityUnit, ConvertedUnit, 
--             CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate     )

--    VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
--        @ProductID, @MaterialID, 'COST003', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
--        @MaterialQuantity, @InprocessCost, 
--        @ProductQuantityEnd, Null, @ConvertedUnitEnd, 
--        Getdate(), NULL, 'E', @MaterialRate, @HumanResourceRate, @OthersRate     )
--    FETCH NEXT FROM  @ListProduct_cur INTO 
--    @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @TotalInProcessQuantity, @PerfectRate, @MaterialRate, 
--    @HumanResourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID 

--End 
--Close @ListProduct_cur
--print @VoucherID


SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
SELECT MV8701.MaterialID, 
     MV8701.MaterialQuantity, ---So luong NVL phat sinh trong ky
     MV8701.ConvertedAmount, ---- Chi phi cua NVL phat sinh trong ky
     MV8701.ProductID, --- Ma san pham
     MV8701.ProductQuantity, -- So luong thanh pham hoan thanh
     ISNULL(MT2222.ProductQuantity, 0)*ISNULL(MT2222.OthersRate, 0)/100 as InProcessQuantity, --- So luong thanh pham do dang quy doi
     TotalInProcessQuantity = 
			(select sum(ISNULL(MT22.ProductQuantity, 0)*ISNULL(MT22.OthersRate, 0)/100) as InProcessQuantity 
			from MT2222 MT22
			Where MT22.DivisionID = MT2222.DivisionID  and MT22.ProductID = MT2222.ProductID
			group by MT22.DivisionID,MT22.ProductID),
     MT2222.PerfectRate, --Tỉ lệ % hoàn thành
     MT2222.MaterialRate, --%NVL
     MT2222.HumanResourceRate, --%NC
     MT2222.OthersRate, --%SXC
     --MT2222.ProductQuantity, --Số lượng SPDD cuối kỳ
	  (Select sum(MT22.ProductQuantity*MT22.OthersRate/100)
				From MT2222 MT22 Where MT22.DivisionID = MT2222.DivisionID And MT22.ProductID = MT2222.ProductID) AS ProductQuantity,
     MV8701.ProductUnitID, 
     MV8701.MaterialUnitID,
	 MV8701.DistributeQty,
	 ( SELECT    SUM(ConvertedAmount)
					  FROM     MT1613
					  WHERE     DivisionID = @DivisionID AND  PeriodID =  @PeriodID
							AND TranMonth = @TranMonth AND TranYear = @TranYear
							AND ProductID=MV8701.ProductID
							AND MaterialTypeID = @MaterialTypeID  
							AND ExpenseID='COST003'          
							AND Type ='B')  AS BSumConverted627
FROM MV8701_MK AS MV8701 LEFT JOIN MT2222 ON MV8701.DivisionID = MT2222.DivisionID AND MV8701.ProductID = MT2222.ProductID 

OPEN @ListProduct_cur 
FETCH NEXT FROM  @ListProduct_cur INTO 
    @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @TotalInProcessQuantity, @PerfectRate, @MaterialRate, 
    @HumanResourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID, @DistributeQty, @BSumConverted627 
WHILE @@Fetch_Status = 0
BEGIN    
     --B­íc 3:TÝnh chi phÝ DD CKú  NVL theo PP ¦íc l­îng t­¬ng ®­¬ng
	--IF ( ISNULL(@DistributeQty,0) <>0)
	--BEGIN
	--	SET @InprocessCost =round((ISNULL(@ConvertedAmount, 0)* ISNULL(@InProcessQuantity,0)/@DistributeQty), @ConvertedDecimal)
	--END    
	--ELSE
	--	SET @InprocessCost = 0
     
	IF (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <>0
	BEGIN
		SET @InprocessCost =round(((ISNULL(CAST(@BSumConverted627 AS DECIMAL(28,20)), 0) +ISNULL(CAST(@ConvertedAmount AS DECIMAL(28,20)), 0)) *ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0))/
										(ISNULL(CAST(@ProductQuantity AS DECIMAL(28,20)), 0)+ISNULL(CAST(@TotalInProcessQuantity AS DECIMAL(28,20)),0)), @ConvertedDecimal)
	END    
	ELSE
		SET @InprocessCost = 0  
	    
	---Chi phi NVL/1SPDD
	IF (ISNULL(@InProcessQuantity, 0) <>0)
	SET @ConvertedUnitEnd = ( ISNULL(@InprocessCost, 0)/@InProcessQuantity)
	ELSE 
	SET @ConvertedUnitEnd = 0
	----So luong NVL/1SPDD
	--IF( (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <> 0  AND  ISNULL(@ProductQuantityEnd, 0) <>0)
        
	--	SET @QuantityUnit  =((ISNULL(@BMaterialQuantity, 0)  + ISNULL(@MaterialQuantity, 0))*ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)))/ @ProductQuantityEnd
	--ELSE 
		SET @QuantityUnit  = 0
    
    EXEC AP0002 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

    INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
            ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
                      MaterialQuantity, ConvertedAmount, 
              ProductQuantity, QuantityUnit, ConvertedUnit, 
             CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate     )

    VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
        @ProductID, @MaterialID, 'COST003', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
        @MaterialQuantity, @InprocessCost, 
        @ProductQuantityEnd, Null, @ConvertedUnitEnd, 
        Getdate(), NULL, 'E', @MaterialRate, @HumanResourceRate, @OthersRate     )
    FETCH NEXT FROM  @ListProduct_cur INTO 
    @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @TotalInProcessQuantity, @PerfectRate, @MaterialRate, 
    @HumanResourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID, @DistributeQty, @BSumConverted627 

End 
Close @ListProduct_cur

------------- Customize Meiko -------------------

SELECT DISTINCT MaterialID,  sum(MaterialQuantity) AS MaterialQuantity, SUM(ConvertedAmount) AS ConvertedAmount, ProductID, 
    SUM(ProductQuantity) AS ProductQuantity, 
	PerfectRate, MaterialRate, HumanresourceRate, OthersRate,
    ProductUnitID, MaterialUnitID, DivisionID,
	QuantityUnit, ConvertedUnit	  
INTO #MP8701_MT1613
FROM MT1613 
WHERE Type = 'B' AND ExpenseID ='COST003' AND DivisionID = @DivisionID  
   -- AND ProductID NOT IN (SELECT ProductID FROM  MT2222) 
   AND MT1613.ProductID NOT IN (SELECT DISTINCT ProductID FROM MT0400 WHERE DivisionID = @DivisionID AND PeriodID =@PeriodID 
                                AND MaterialTypeID = @MaterialTypeID AND ExpenseID ='COST003'  )   --- khong co phat sinh duoc phan bo
   --and  MT1613.ProductID NOT IN (	  
			--						SELECT DISTINCT ProductID
			--						FROM MT1001 D10 WITH (NOLOCK) 
			--						INNER JOIN MT0810 D08 WITH (NOLOCK) ON D08.VoucherID = D10.VoucherID AND D08.DivisionID = D10.DivisionID
			--						WHERE D08.DivisionID = @DivisionID AND PeriodID =@PeriodID
			--						AND D08.TranMonth+D08.TranYear*100 =    @TranMonth + @TranYear*100
			--						AND D08.ResultTypeID ='R01' 
			--					)	  -- khong co KQSX thanh pham trong ky 
    AND MT1613.PeriodID = @PeriodID 
    AND MT1613.DivisionID = @DivisionID 
    AND MT1613.MaterialTypeID = @MaterialTypeID 
    AND MT1613.ExpenseID = 'COST003'
GROUP BY MaterialID,ProductID, 
		PerfectRate, MaterialRate, HumanresourceRate, OthersRate,
		ProductUnitID, MaterialUnitID, DivisionID, QuantityUnit, ConvertedUnit	  


SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR 
 
    SELECT  MaterialID, 
            MaterialQuantity, --    So luong NVL phat sinh trong ky
            ConvertedAmount, --     Chi phi cua NVL phat sinh trong ky
            ProductID, ---     Ma san pham
            ProductQuantity, --     So luong thanh pham hoan thanh  
			PerfectRate, MaterialRate, HumanresourceRate, OthersRate,         
			ProductUnitID, MaterialUnitID , QuantityUnit, ConvertedUnit	      
	FROM #MP8701_MT1613 T1 

        OPEN @ListMaterial_cur 
        FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, 
                                    @ProductQuantity, @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate, @ProductUnitID, @MaterialUnitID, @QuantityUnit, @ConvertedUnitEnd


        WHILE @@Fetch_Status = 0
        BEGIN    
		                
                EXEC AP0002 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
    
                --PRINT '@TransactionID' + @TransactionID
            
                INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
                        ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, --- ProductUnitID
                                  MaterialQuantity, ConvertedAmount, 
                         ProductQuantity, QuantityUnit, ConvertedUnit, 
                         CreateDate, CreateUserID, Type, PerfectRate, MaterialRate, HumanResourceRate, OthersRate )
            
                VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
                    @ProductID, @MaterialID, 'COST003', @MaterialTypeID, @ProductUnitID, @MaterialUnitID,
                    @MaterialQuantity, 
                    @ConvertedAmount, 
                    @ProductQuantity, @QuantityUnit, @ConvertedUnitEnd, 
                    Getdate(), Null, 'E', @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate)

    FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, 
                                    @ProductQuantity, @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate, @ProductUnitID, @MaterialUnitID, @QuantityUnit, @ConvertedUnitEnd
    END
    CLOSE @ListMaterial_cur


-- Bo sung lam tron 
-- kiem tra so lieu trong ky
--SELECT MT0400.PeriodID, MT0400.ProductID, sum(ConvertedAmount) as SumConvertedAmount
--FROM MT0400
--WHERE MT0400.DivisionID =@DivisionID AND
--    PeriodID = @PeriodID  AND
--    ExpenseID ='COST003' AND
--    ProductID IN (SELECT ProductID FROM  MT2222) AND        
--    MaterialTypeID = @MaterialTypeID 
--GROUP BY MT0400.PeriodID, MT0400.ProductID, MT0400.MaterialID

---- kiem tra so lieu dau ky
--select mt1613.PeriodID, MT1613.ProductID, sum(ConvertedAmount) as SumConvertedAmount
--from mt1613
--Where MT1613.ExpenseID= N'COST003' And MT1613.PeriodID = @PeriodID  And MT1613.DivisionID = @DivisionID
--      And MT1613.Type='B' and  MaterialTypeID = @MaterialTypeID
--group by mt1613.PeriodID, MT1613.ProductID

---- kiem tra so lieu cuoi ky
--select mt1613.PeriodID, MT1613.ProductID, sum(ConvertedAmount) as SumConvertedAmount
--from mt1613
--Where MT1613.ExpenseID= N'COST003' And MT1613.PeriodID = @PeriodID  And MT1613.DivisionID = @DivisionID
--      And MT1613.Type='E' and  MaterialTypeID = @MaterialTypeID  
--group by mt1613.PeriodID, MT1613.ProductID

-- tim do chenh lech
--SELECT T1.PeriodID, T1.ProductID, SUM(ISNULL(T1.ConvertedAmount,0)) as B_ConvertedAmount, ISNULL(T2.C_ConvertedAmount,0) AS C_ConvertedAmount, 
--		ISNULL(T3.E_ConvertedAmount,0) AS E_ConvertedAmount, (SUM(T1.ConvertedAmount)+ISNULL(T2.C_ConvertedAmount,0))-ISNULL(T3.E_ConvertedAmount,0) AS Diff_ConvertedAmount
--INTO #TEMP
--FROM MT1613 T1 WITH (NOLOCK)

--LEFT JOIN (SELECT MT0400.PeriodID, MT0400.ProductID, SUM(ISNULL(ConvertedAmount,0)) as C_ConvertedAmount
--			FROM MT0400 WITH(NOLOCK)
--			WHERE MT0400.DivisionID =@DivisionID AND
--				PeriodID = @PeriodID  AND
--				ExpenseID ='COST003' AND
--				ProductID IN (SELECT ProductID FROM  MT2222) AND        
--				MaterialTypeID = @MaterialTypeID
--			GROUP BY MT0400.PeriodID, MT0400.ProductID
--			) T2 ON T1.PeriodID = T2.PeriodID AND T1.ProductID = T2.ProductID

--LEFT JOIN (SELECT MT1613.PeriodID, MT1613.ProductID, sum(ISNULL(ConvertedAmount,0)) as E_ConvertedAmount
--			FROM MT1613
--			WHERE MT1613.ExpenseID= N'COST003' And MT1613.PeriodID = @PeriodID  And MT1613.DivisionID = @DivisionID
--				  And MT1613.Type='E' and  MaterialTypeID =@MaterialTypeID 
--			GROUP BY mt1613.PeriodID, MT1613.ProductID
--			) T3 ON T1.PeriodID = T3.PeriodID AND T1.ProductID = T3.ProductID
--WHERE T1.ExpenseID= N'COST003' And T1.PeriodID = @PeriodID  And T1.DivisionID = @DivisionID
--      And T1.Type='B' and  T1.MaterialTypeID =@MaterialTypeID  
--GROUP BY T1.PeriodID, T1.ProductID, T2.C_ConvertedAmount, T3.E_ConvertedAmount

-- --tim ra dong can update cua moi product
--SELECT T1.APK, T1.PeriodID, T1.ProductID, T1.MaterialID, T1.ConvertedAmount, T3.Diff_ConvertedAmount
--FROM MT1613 T1 WITH(NOLOCK) INNER JOIN #TEMP T3 ON T1.PeriodID = T3.PeriodID and T1.ProductID = T3.ProductID
--OUTER APPLY (SELECT TOP 1 APK, MT1613.PeriodID, MT1613.ProductID, MT1613.ConvertedAMount 
--				FROM MT1613 WITH (NOLOCK) INNER JOIN #TEMP T2 ON MT1613.PeriodID = T2.PeriodID and MT1613.ProductID = T2.ProductID
--				WHERE MT1613.PeriodID = T3.PeriodID and MT1613.ProductID=T3.ProductID
--						AND MT1613.ExpenseID='COST003' AND MT1613.Type='E' AND MT1613.MaterialTypeID=@MaterialTypeID
--				ORDER BY MT1613.ConvertedAmount DESC) A

--WHERE T1.ExpenseID= N'COST003' And T1.PeriodID = @PeriodID And T1.DivisionID = @DivisionID
--				  And T1.Type='E' and  T1.MaterialTypeID =@MaterialTypeID and T1.APK = A.APK

--SELECT * FROM #TEMP
--UPDATE T1
--SET T1.ConvertedAmount=T1.ConvertedAmount+T3.Diff_ConvertedAmount
--FROM MT1613 T1 WITH(NOLOCK)  INNER JOIN #TEMP T3 ON T1.PeriodID = T3.PeriodID and T1.ProductID = T3.ProductID
--OUTER APPLY (SELECT TOP 1 APK, MT1613.PeriodID, MT1613.ProductID, MT1613.ConvertedAMount 
--				FROM MT1613 WITH (NOLOCK) INNER JOIN #TEMP T2 ON MT1613.PeriodID = T2.PeriodID and MT1613.ProductID = T2.ProductID
--				WHERE MT1613.PeriodID = T3.PeriodID and MT1613.ProductID=T3.ProductID
--						AND MT1613.ExpenseID='COST003' AND MT1613.Type='E' AND MT1613.MaterialTypeID=@MaterialTypeID
--				ORDER BY MT1613.ConvertedAmount DESC) A
--WHERE T1.APK = A.APK


SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

