IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8101_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP8101_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Tính chi phí dở dang cuối kỳ - chi phí SXNVL (Customize Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: SP MP8101
-- <History>
---- Create on 27/04/2016 by Phuong Thao
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- Modified by Kim Thu on 25/06/2019: Sua cong thuc tinh do dang cua product co phat sinh trong ky (quay ve cong thuc chuan)
---- Modified by Nhựt Trường on 24/08/2020: Merge code Meiko.
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
-- <Example>
---- 

CREATE PROCEDURE  [dbo].[MP8101_MK] @DivisionID AS nvarchar(50), 
                 @PeriodID AS nvarchar(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS nvarchar(50), 
                 @VoucherID AS nvarchar(50), 
                 @CMonth AS nvarchar(50), 
                 @CYear AS nvarchar(50)
AS 
SET NOCOUNT ON
DECLARE @sSQL1 AS nvarchar(4000), 
    @sSQL2 AS nvarchar(4000), 
	@sSQL3 AS nvarchar(4000), 
    @BSumConverted621 AS DECIMAL(28, 8), --Chi phÝ NVL ®Çu kú
    @ISumConverted621 AS DECIMAL(28, 8), --Chi phÝ NVL trong kú
    @Quantity AS DECIMAL(28, 8), --Sè l­îng thµnh phÈm
    @QuantityInprocess AS DECIMAL(28, 8), --Sè l­¬ng dë dang cuèi kú
    @MaterialRate AS DECIMAL(28, 8), --TØ lÖ % NVL
    @MaterialID AS nvarchar(50), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @MaterialInprocessCost AS DECIMAL(28, 8), 
    @ProductID AS nvarchar(50), 
    @PerfectRate AS DECIMAL(28, 8), 
    @InProcessQuantity AS DECIMAL(28, 8), 
    @ProductQuantityEnd AS DECIMAL(28, 8), ---Sè l­îng DD cuèi kú
    @HumanResourceRate AS DECIMAL(28, 8), 
    @OthersRate AS DECIMAL(28, 8), 
    @ConvertedUnitEnd AS DECIMAL(28, 8), 
    @QuantityUnit AS  DECIMAL(28, 8), 
    @BMaterialQuantity AS DECIMAL(28, 8), 
    @TransactionID AS nvarchar(50), 
    @ProductUnitID AS nvarchar(50), 
    @MaterialUnitID AS nvarchar(50), 
    @ListMaterial_cur1 AS CURSOR, 
    @ListMaterial_cur AS CURSOR, 
    @ConvertedDecimal INT, 
    @TotalInProcessQuantity AS DECIMAL(28, 8),
	@ConvertedUnit AS DECIMAL(28, 8),
	@DistributeQty AS DECIMAL(28, 8),
	@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 


SELECT @ConvertedDecimal= ConvertDecimal FROM MT0000 Where DivisionID = @DivisionID
--print ' ---- Chi phi phat sinh trong ky da duoc phan bo '

--NVL co so dau ky nhung ko phat sinh trong ky
SET @sSQL1=N'
SELECT DISTINCT MaterialID,  sum(MaterialQuantity)  AS MaterialQuantity, 0 AS ConvertedAmount, ProductID, 
    ProductQuantity = (SELECT SUM(Quantity)  
                        FROM MT1001 INNER JOIN MT0810 ON MT0810.VoucherID = MT1001.VoucherID 
                        WHERE MT1001.ProductID = MT1613.ProductID AND MT0810.ResultTypeID =''R01'' 
                            AND MT0810.PeriodID = '''+@PeriodID+'''  
                            AND MT0810.DivisionID ='''+@DivisionID+'''), 
    ProductUnitID, MaterialUnitID, DivisionID 
FROM MT1613 
WHERE Type = ''B'' AND ExpenseID =''COST001'' AND DivisionID = ''' + @DivisionID + '''  
    AND ProductID IN (SELECT ProductID FROM  MT2222) 
    AND PeriodID = ''' + @PeriodID + ''' AND MaterialTypeID = ''' + @MaterialTypeID + ''' 
    AND ProductID + ''_'' + MaterialID NOT IN 
    (SELECT ProductID + ''_'' + MaterialID FROM MT0400 
    WHERE     DivisionID =''' + @DivisionID + ''' AND 
        PeriodID = ''' + @PeriodID + ''' AND 
        ExpenseID = ''COST001'' AND
        MaterialTypeID =''' + @MaterialTypeID + ''' ) 
GROUP BY MaterialID,ProductID,ProductUnitID,MaterialUnitID, DivisionID  
		'
IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV8101_MK' AND Xtype ='V')
    EXEC ('CREATE VIEW MV8101_MK  -- tao boi MP8101_MK
			AS '+@sSQL1)
ELSE
    EXEC ('ALTER VIEW MV8101_MK  -- tao boi MP8101_MK
			AS '+@sSQL1)

SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR 
 
		SELECT         MV8101.MaterialID, 
				MV8101.MaterialQuantity, --    So luong NVL phat sinh trong ky
				MV8101.ConvertedAmount, --     Chi phi cua NVL phat sinh trong ky
				MV8101.ProductID, ---     Ma san pham
				MV8101.ProductQuantity, --     So luong thanh pham hoan thanh
				MT2222.ProductQuantity*MT2222.MaterialRate/100 AS InPocessQuantity, --- So luong thanh pham do dang quy doi
				MT2222.PerfectRate, MT2222.MaterialRate, MT2222.HumanresourceRate, MT2222.OthersRate, 
				(Select sum(MT22.ProductQuantity*MT22.MaterialRate/100)
				From MT2222 MT22 Where MT22.DivisionID = MT2222.DivisionID And MT22.ProductID = MT2222.ProductID) AS ProductQuantity,
				-- MT2222.ProductQuantity, 
				MV8101.ProductUnitID, MV8101.MaterialUnitID,
				(Select sum(MT22.ProductQuantity*MT22.MaterialRate/100)
				From MT2222 MT22 Where MT22.DivisionID = MT2222.DivisionID And MT22.ProductID = MT2222.ProductID)
			FROM MV8101_MK  MV8101 LEFT JOIN MT2222 ON MV8101.DivisionID  = MT2222.DivisionID AND MV8101.ProductID  = MT2222.ProductID 

			OPEN @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, 
										@ProductQuantity, @InProcessQuantity, @PerfectRate, @MaterialRate, 
										 @HumanresourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID, @TotalInProcessQuantity

			WHILE @@Fetch_Status = 0
				BEGIN    

			--B­íc 1 :X¸c ®Þnh chi phÝ NVL DD ®Çu kú cho tõng NVL
                    
					  SELECT     @BSumConverted621 = SUM(ConvertedAmount), 
						@BMaterialQuantity = SUM(MaterialQuantity)
					  FROM     MT1613
					  WHERE     DivisionID= @DivisionID AND  PeriodID =  @PeriodID 
							AND TranMonth=@TranMonth AND TranYear = @TranYear 
							AND MaterialTypeID = @MaterialTypeID             
							AND ProductID =@ProductID 
							AND MaterialID = @MaterialID 
							AND Type ='B'
            
                
					--PRINT     '@MaterialTypeID' + @MaterialTypeID            
					--PRINT     '@ProductID' + @ProductID
					--PRINT     '@MaterialID' + @MaterialID

			--B­íc 2:X¸c ®Þnh chi phÝ NVL ph¸t sinh trong kú

			SET @ISumConverted621 = @ConvertedAmount
			/*
			IF EXISTS (SELECT TOP 1 1 FROM MT0400 
					WHERE     DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) AND 
					PeriodID = @PeriodID AND 
					ExpenseID = 'COST001' AND
					MaterialTypeID = @MaterialTypeID AND
					ProductID = @ProductID AND
					MaterialID = @MaterialID)
				BEGIN        
				*/
					--B­íc 3:TÝnh chi phÝ DD CKú  NVL theo PP ¦íc l­îng t­¬ng ®­¬ng
					IF (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <>0
					BEGIN
						SET @MaterialInprocessCost =round((ISNULL(CAST(@BSumConverted621 AS DECIMAL(28,20)), 0) 
						+ISNULL(CAST(@ISumConverted621 AS DECIMAL(28,20)), 0)) *ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0)/(ISNULL(CAST(@ProductQuantity AS DECIMAL(28,20)), 0)
						+ISNULL(CAST(@TotalInProcessQuantity AS DECIMAL(28,20)), 0)), @ConvertedDecimal)
					END    
					ELSE
						SET @MaterialInprocessCost = 0
        
					---Chi phi NVL/1SPDD
					IF (ISNULL(@ProductQuantityEnd, 0) <>0)
					SET @ConvertedUnitEnd = ( ISNULL(@MaterialInprocessCost, 0)/@ProductQuantityEnd)
					ELSE 
					SET @ConvertedUnitEnd = 0
					--So luong NVL/1SPDD
					IF( (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <> 0  AND  ISNULL(@ProductQuantityEnd, 0) <>0)
        
						SET @QuantityUnit  =((ISNULL(CAST(@BMaterialQuantity AS DECIMAL(28,20)), 0)  + ISNULL(CAST(@MaterialQuantity AS DECIMAL(28,20)), 0))*ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0)/(ISNULL(CAST(@ProductQuantity AS DECIMAL(28,20)), 0) +ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0)))/ CAST(@ProductQuantityEnd AS DECIMAL(28,20))
					ELSE 
						SET @QuantityUnit  = 0
                
					EXEC AP0002 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
    
					--PRINT '@TransactionID' + @TransactionID
            
					INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
							ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
									  MaterialQuantity, ConvertedAmount, 
							 ProductQuantity, QuantityUnit, ConvertedUnit, 
							 CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate     )
            
					VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
						@ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
						((ISNULL(CAST(@BMaterialQuantity AS DECIMAL(28,20)), 0)  + ISNULL(CAST(@MaterialQuantity AS DECIMAL(28,20)), 0)) * ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0)/(ISNULL(CAST(@ProductQuantity AS DECIMAL(28,20)), 0) +ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0))), 
						@MaterialInprocessCost, 
						@ProductQuantityEnd, @QuantityUnit, @ConvertedUnitEnd, 
						Getdate(), 'ASOFTADMIN', 'E', @MaterialRate, @HumanResourceRate, @OthersRate)
	/*
				END
			ELSE
				BEGIN
					EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
					INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
							ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, 
									  MaterialQuantity, ConvertedAmount, 
							 ProductQuantity, QuantityUnit, ConvertedUnit, 
							 CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate     )
					SELECT     @PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
						@ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
						MaterialQuantity, ConvertedAmount, 
						ProductQuantity, QuantityUnit, ConvertedUnit, 
						Getdate(), 'ASOFTADMIN', 'E', @MaterialRate, @HumanResourceRate, @OthersRate
					FROM MT1613 
					WHERE     DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) AND 
						PeriodID = @PeriodID AND 
						ExpenseID = 'COST001' AND
						MaterialTypeID = @MaterialTypeID AND
						ProductID = @ProductID AND
						MaterialID = @MaterialID
				END    
	  */  


    FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID, @TotalInProcessQuantity
    END
    CLOSE @ListMaterial_cur

SET @sSQL2=N'
SELECT MaterialID, SUM(MaterialQuantity) AS MaterialQuantity, 
    SUM(convertedAmount) AS ConvertedAmount, 
    ProductID, --- Ma thanh pham
    --- So luong thanh pham duoc san xuat trong ky
    ProductQuantity = (SELECT SUM(Quantity) 
                        FROM MT1001 INNER JOIN MT0810 ON MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID 
                        WHERE MT1001.ProductID = MT0400.ProductID AND MT0810.ResultTypeID =''R01'' AND MT0810.PeriodID = '''+@PeriodID+'''  
                            AND MT1001.DivisionID ='''+@DivisionID+'''), 
    AT1302_P.UnitID AS ProductUnitID, 
    AT1302_M.UnitID AS MaterialUnitID, 
	MT0400.ProductQuantity as DistributeQty,
    MT0400.DivisionID
FROM MT0400 LEFT JOIN AT1302 AT1302_P ON AT1302_P .DivisionID IN (MT0400.DivisionID,''@@@'') AND MT0400.ProductID = AT1302_P .InventoryID
        LEFT JOIN AT1302 AT1302_M ON AT1302_M.DivisionID IN (MT0400.DivisionID,''@@@'') AND MT0400.MaterialID=AT1302_M.InventoryID
WHERE MT0400.DivisionID ='''+@DivisionID+''' AND
    PeriodID = '''+@PeriodID+''' AND
    ExpenseID =''COST001'' AND
    ProductID IN (SELECT ProductID FROM  MT2222) AND        
    MaterialTypeID ='''+@MaterialTypeID+''' 
GROUP BY MaterialID, ProductID, ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID, MT0400.DivisionID
'
IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV8102_MK' AND Xtype ='V')
    EXEC ('CREATE VIEW MV8102_MK  -- tao boi MP8101_MK
			AS '+ @sSQL2)
ELSE
    EXEC ('ALTER VIEW MV8102_MK  -- tao boi MP8101_MK
			AS '+ @sSQL2)

SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR  
		SELECT  MV8102.MaterialID, 
				MV8102.MaterialQuantity, --    So luong NVL phat sinh trong ky
				MV8102.ConvertedAmount, --     Chi phi cua NVL phat sinh trong ky
				MV8102.ProductID, ---     Ma san pham
				MV8102.ProductQuantity, --     So luong thanh pham hoan thanh
				MT2222.ProductQuantity*MT2222.MaterialRate/100 AS InProcessQuantity, --- So luong thanh pham do dang quy doi
				MT2222.PerfectRate, MT2222.MaterialRate, MT2222.HumanresourceRate, MT2222.OthersRate, 
				MT2222.ProductQuantity, MV8102.ProductUnitID, MV8102.MaterialUnitID,
				MV8102.DistributeQty, 
				(Select sum(MT22.ProductQuantity*MT22.MaterialRate/100)
				From MT2222 MT22 Where MT22.DivisionID = MT2222.DivisionID And MT22.ProductID = MT2222.ProductID) AS TotalInProcessQuantity
			FROM MV8102_MK MV8102 LEFT JOIN MT2222 ON MV8102.DivisionID  = MT2222.DivisionID AND MV8102.ProductID  = MT2222.ProductID 

			OPEN @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, 
										@ProductQuantity, @InProcessQuantity, @PerfectRate, @MaterialRate, 
										 @HumanresourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID, @DistributeQty, @TotalInProcessQuantity


			WHILE @@Fetch_Status = 0
				BEGIN                
				SELECT     @BSumConverted621 = SUM(ConvertedAmount), 
						@BMaterialQuantity = SUM(MaterialQuantity)
					  FROM     MT1613
					  WHERE     DivisionID= @DivisionID AND  PeriodID =  @PeriodID 
							AND TranMonth=@TranMonth AND TranYear = @TranYear 
							AND MaterialTypeID = @MaterialTypeID             
							AND ProductID =@ProductID 
							AND MaterialID = @MaterialID 
							AND Type ='B'
					
					--B­íc 3:TÝnh chi phÝ DD CKú  NVL theo PP ¦íc l­îng t­¬ng ®­¬ng
					--IF ( ISNULL(@DistributeQty,0) <>0)
					--BEGIN
					--	SET @MaterialInprocessCost =round((ISNULL(@ConvertedAmount, 0)* ISNULL(@InProcessQuantity,0))/@DistributeQty, @ConvertedDecimal)
					--END    
					--ELSE
					--	SET @MaterialInprocessCost = 0
					
					IF (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <>0
					BEGIN
						SET @MaterialInprocessCost =round(((ISNULL(CAST(@BSumConverted621 AS DECIMAL(28,20)), 0) +ISNULL(CAST(@ConvertedAmount AS DECIMAL(28,20)), 0)) *ISNULL(CAST(@InProcessQuantity AS DECIMAL(28,20)), 0))/
														(ISNULL(CAST(@ProductQuantity AS DECIMAL(28,20)), 0)+ISNULL(CAST(@TotalInProcessQuantity AS DECIMAL(28,20)),0)), @ConvertedDecimal)
					END    
					ELSE
						SET @MaterialInprocessCost = 0

					---Chi phi NVL/1SPDD
					IF (ISNULL(@InProcessQuantity, 0) <>0)
					SET @ConvertedUnitEnd = ( ISNULL(@MaterialInprocessCost, 0)/@InProcessQuantity)
					ELSE 
					SET @ConvertedUnitEnd = 0
					----So luong NVL/1SPDD
					--IF( (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <> 0  AND  ISNULL(@ProductQuantityEnd, 0) <>0)
        
					--	SET @QuantityUnit  =((ISNULL(@BMaterialQuantity, 0)  + ISNULL(@MaterialQuantity, 0))*ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)))/ @ProductQuantityEnd
					--ELSE 
						SET @QuantityUnit  = 0
                
					EXEC AP0002 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
    
					--PRINT '@TransactionID' + @TransactionID
            
					INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
							ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
									  MaterialQuantity, ConvertedAmount, 
							 ProductQuantity, QuantityUnit, ConvertedUnit, 
							 CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate     )
            
					VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
						@ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
						null, 
						@MaterialInprocessCost, 
						@InProcessQuantity, @QuantityUnit, @ConvertedUnitEnd, 
						Getdate(), 'ASOFTADMIN', 'E', @MaterialRate, @HumanResourceRate, @OthersRate)
	/*
				END
			ELSE
				BEGIN
					EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
					INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
							ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, 
									  MaterialQuantity, ConvertedAmount, 
							 ProductQuantity, QuantityUnit, ConvertedUnit, 
							 CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate     )
					SELECT     @PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
						@ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
						MaterialQuantity, ConvertedAmount, 
						ProductQuantity, QuantityUnit, ConvertedUnit, 
						Getdate(), 'ASOFTADMIN', 'E', @MaterialRate, @HumanResourceRate, @OthersRate
					FROM MT1613 
					WHERE     DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) AND 
						PeriodID = @PeriodID AND 
						ExpenseID = 'COST001' AND
						MaterialTypeID = @MaterialTypeID AND
						ProductID = @ProductID AND
						MaterialID = @MaterialID
				END    
	  */  


    FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, 
											@PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate, @ProductQuantityEnd, 
											@ProductUnitID, @MaterialUnitID, @DistributeQty, @TotalInProcessQuantity
    END
    CLOSE @ListMaterial_cur
------------- Customize Meiko -------------------

SELECT DISTINCT MaterialID,  sum(MaterialQuantity) AS MaterialQuantity, SUM(ConvertedAmount) AS ConvertedAmount, ProductID, 
    QuantityUnit, ConvertedUnit, SUM(ProductQuantity) AS ProductQuantity, 
	PerfectRate, MaterialRate, HumanresourceRate, OthersRate,
    ProductUnitID, MaterialUnitID, DivisionID 
INTO #MP8101_MT1613
FROM MT1613 
WHERE Type = 'B' AND ExpenseID ='COST001' AND DivisionID = @DivisionID  
    -- Không có KQDD trong kỳ
	AND ProductID NOT IN (SELECT ProductID FROM  MT2222) 
    AND PeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID
    -- Không phân bổ trong kỳ
	--AND ProductID NOT IN 
 --   (SELECT ProductID FROM MT0400 
 --   WHERE     DivisionID = @DivisionID AND 
 --       PeriodID = @PeriodID AND 
 --       ExpenseID = 'COST001' AND
 --       MaterialTypeID = @MaterialTypeID) 
	 and  MT1613.ProductID NOT IN (	  
									SELECT DISTINCT ProductID
									FROM MT1001 D10 WITH (NOLOCK) 
									INNER JOIN MT0810 D08 WITH (NOLOCK) ON D08.VoucherID = D10.VoucherID AND D08.DivisionID = D10.DivisionID
									WHERE D08.DivisionID = @DivisionID AND PeriodID =@PeriodID
									AND D08.TranMonth+D08.TranYear*100 =    @TranMonth + @TranYear*100
									AND D08.ResultTypeID ='R01' 
								)	  -- khong co KQSX thanh pham trong ky 
GROUP BY MaterialID,ProductID, QuantityUnit, ConvertedUnit,
		PerfectRate, MaterialRate, HumanresourceRate, OthersRate,
		ProductUnitID, MaterialUnitID, DivisionID 


SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR 
 
    SELECT  MaterialID, 
            MaterialQuantity, --    So luong NVL phat sinh trong ky
            ConvertedAmount, --     Chi phi cua NVL phat sinh trong ky
            ProductID, ---     Ma san pham
			QuantityUnit, ConvertedUnit,
            ProductQuantity, --     So luong thanh pham hoan thanh  
			PerfectRate, MaterialRate, HumanresourceRate, OthersRate,         
			ProductUnitID, MaterialUnitID      
	FROM #MP8101_MT1613 T1 

        OPEN @ListMaterial_cur 
        FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @QuantityUnit, @ConvertedUnit,
                                    @ProductQuantity, @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate, @ProductUnitID, @MaterialUnitID


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
                    @ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID,
                    @MaterialQuantity, 
                    @ConvertedAmount, 
                    @ProductQuantity, @QuantityUnit, @ConvertedUnit, 
                    Getdate(), 'ASOFTADMIN', 'E', @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate)


    FETCH NEXT FROM @ListMaterial_cur INTO   @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @QuantityUnit, @ConvertedUnit,
                                    @ProductQuantity, @PerfectRate, @MaterialRate, @HumanresourceRate, @OthersRate, @ProductUnitID, @MaterialUnitID
    END
    CLOSE @ListMaterial_cur

-- Bo sung lam tron 
-- kiem tra so lieu trong ky
--SELECT MT0400.PeriodID, MT0400.ProductID, sum(ConvertedAmount) as SumConvertedAmount
--FROM MT0400
--WHERE MT0400.DivisionID =@DivisionID AND
--    PeriodID = @PeriodID  AND
--    ExpenseID ='COST001' AND
--    ProductID IN (SELECT ProductID FROM  MT2222) AND        
--    MaterialTypeID = @MaterialTypeID 
--GROUP BY MT0400.PeriodID, MT0400.ProductID, MT0400.MaterialID

---- kiem tra so lieu dau ky
--select mt1613.PeriodID, MT1613.ProductID, sum(ConvertedAmount) as SumConvertedAmount
--from mt1613
--Where MT1613.ExpenseID= N'COST001' And MT1613.PeriodID = @PeriodID  And MT1613.DivisionID = @DivisionID
--      And MT1613.Type='B' and  MaterialTypeID = @MaterialTypeID
--group by mt1613.PeriodID, MT1613.ProductID

---- kiem tra so lieu cuoi ky
--select mt1613.PeriodID, MT1613.ProductID, sum(ConvertedAmount) as SumConvertedAmount
--from mt1613
--Where MT1613.ExpenseID= N'COST001' And MT1613.PeriodID = @PeriodID  And MT1613.DivisionID = @DivisionID
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
--				ExpenseID ='COST001' AND
--				ProductID IN (SELECT ProductID FROM  MT2222) AND        
--				MaterialTypeID = @MaterialTypeID
--			GROUP BY MT0400.PeriodID, MT0400.ProductID
--			) T2 ON T1.PeriodID = T2.PeriodID AND T1.ProductID = T2.ProductID

--LEFT JOIN (SELECT MT1613.PeriodID, MT1613.ProductID, sum(ISNULL(ConvertedAmount,0)) as E_ConvertedAmount
--			FROM MT1613
--			WHERE MT1613.ExpenseID= N'COST001' And MT1613.PeriodID = @PeriodID  And MT1613.DivisionID = @DivisionID
--				  And MT1613.Type='E' and  MaterialTypeID =@MaterialTypeID 
--			GROUP BY mt1613.PeriodID, MT1613.ProductID
--			) T3 ON T1.PeriodID = T3.PeriodID AND T1.ProductID = T3.ProductID
--WHERE T1.ExpenseID= N'COST001' And T1.PeriodID = @PeriodID  And T1.DivisionID = @DivisionID
--      And T1.Type='B' and  T1.MaterialTypeID =@MaterialTypeID  
--GROUP BY T1.PeriodID, T1.ProductID, T2.C_ConvertedAmount, T3.E_ConvertedAmount

-- --tim ra dong can update cua moi product
--SELECT T1.APK, T1.PeriodID, T1.ProductID, T1.MaterialID, T1.ConvertedAmount, T3.Diff_ConvertedAmount
--FROM MT1613 T1 WITH(NOLOCK) INNER JOIN #TEMP T3 ON T1.PeriodID = T3.PeriodID and T1.ProductID = T3.ProductID
--OUTER APPLY (SELECT TOP 1 APK, MT1613.PeriodID, MT1613.ProductID, MT1613.ConvertedAMount 
--				FROM MT1613 WITH (NOLOCK) INNER JOIN #TEMP T2 ON MT1613.PeriodID = T2.PeriodID and MT1613.ProductID = T2.ProductID
--				WHERE MT1613.PeriodID = T3.PeriodID and MT1613.ProductID=T3.ProductID
--						AND MT1613.ExpenseID='COST001' AND MT1613.Type='E' AND MT1613.MaterialTypeID=@MaterialTypeID
--				ORDER BY MT1613.ConvertedAmount DESC) A

--WHERE T1.ExpenseID= N'COST001' And T1.PeriodID = @PeriodID And T1.DivisionID = @DivisionID
--				  And T1.Type='E' and  T1.MaterialTypeID =@MaterialTypeID and T1.APK = A.APK

--SELECT * FROM #TEMP
--UPDATE T1
--SET T1.ConvertedAmount=T1.ConvertedAmount+T3.Diff_ConvertedAmount
--FROM MT1613 T1 WITH(NOLOCK)  INNER JOIN #TEMP T3 ON T1.PeriodID = T3.PeriodID and T1.ProductID = T3.ProductID
--OUTER APPLY (SELECT TOP 1 APK, MT1613.PeriodID, MT1613.ProductID, MT1613.ConvertedAMount 
--				FROM MT1613 WITH (NOLOCK) INNER JOIN #TEMP T2 ON MT1613.PeriodID = T2.PeriodID and MT1613.ProductID = T2.ProductID
--				WHERE MT1613.PeriodID = T3.PeriodID and MT1613.ProductID=T3.ProductID
--						AND MT1613.ExpenseID='COST001' AND MT1613.Type='E' AND MT1613.MaterialTypeID=@MaterialTypeID
--				ORDER BY MT1613.ConvertedAmount DESC) A
--WHERE T1.APK = A.APK



SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
