IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Hoang Thi Lan Date 12/11/2003
--Purpose :TÝnh chi phÝ dë dang cuèi kú cho NVL TT theo PP ¦íc l­îng t­¬ng ®­¬ng
--Tinh cho tung NVL
--Edit BY : Nguyen Quoc Huy
--Edit BY: Dang Le Bao Quynh; Date 16/03/2007
--Purpose: Sua loi tinh do dang cuoi ky khi ket qua san xuat khong co thanh pham ma chi co do dang.
--Edit BY: Dang Le Bao Quynh; Date 29/06/2007
--Purpose: Bo rem dong 141 (--AND MaterialID = @MaterialID)
--Edit BY: Dang Le Bao Quynh; Date: 13/09/2007
--Purpose: Bo sung them nhom NVL phat sinh trong ky truoc nhung khong phat sinh trong ky nay
--Edit BY: Dang Le Bao Quynh; Date: 16/05/2008
--Purpose: Sua lai cach lay cac san pham do dang dau ky
--Edit BY: Dang Le Bao Quynh; Date: 29/07/2008
--Purpose: Sua lai cach tinh cac san pham do dang dau ky
--- Modify on 11/06/2014 by Bảo Anh: Sửa cách tính @MaterialInprocessCost
--- Modify on 12/06/2014 by Tấn Phú: Them tong so san pham do dang trong ky @@TotalInProcessQuantity
--- Modify on 02/12/2020 by Đức Thông: Lấy lại điều kiện lọc theo MaterialID cho query lấy chi phí dở dang đầu kì để tính chi phí dở dang cuối kì (Fix bug cho  PT2000)
/********************************************
'* Edited BY: [GS] [Hoàng Phước] [02/08/2010]
'********************************************/
----- Modify on 20/04/2014 by Phương Thảo: Customize KH Meiko : Gọi store MP8101_MK
--- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
--- Modify on 30/06/2017 by Bảo Anh: Bổ sung stote customize GodRej
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
--- Modify on 27/09/2019 by Hoàng Trúc: Sửa lỗi tính sai CP NVL dở dang cuối kì, bỏ điều kiện MaterialID (lấy thiếu giá trị CPDD đầu kì)
--- Modify on 24/08/2020 by Nhựt Trường: Merge code Meiko: Điều chỉnh cách gọi store MP8101_MK.
--- Modify on 13/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
--- Modify on 12/10/2021 by Lê Hoàng: Kiểm tra ISNULL MaterialID khi lấy số dư dở dang đầu kỳ.


CREATE PROCEDURE  [dbo].[MP8101] @DivisionID AS nvarchar(50), 
					@UserID AS VARCHAR(50), 
                 @PeriodID AS nvarchar(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS nvarchar(50), 
                 @VoucherID AS nvarchar(50), 
                 @CMonth AS nvarchar(50), 
                 @CYear AS nvarchar(50),
				 @VoucherNo NVARCHAR(50) 
AS 
SET NOCOUNT ON
DECLARE @sSQL1 AS nvarchar(4000), 
    @sSQL2 AS nvarchar(4000), 
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
	@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

IF (@CustomerName = 50)
BEGIN
	
	EXEC MP8101_MK @DivisionID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @VoucherID, @CMonth, @CYear
END
ELSE IF (@CustomerName = 74)
BEGIN
	EXEC MP8101_GOD @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @VoucherID, @CMonth, @CYear, @VoucherNo
END
ELSE
BEGIN 
	SELECT @ConvertedDecimal= ConvertDecimal FROM MT0000 Where DivisionID = @DivisionID
--print ' ---- Chi phi phat sinh trong ky da duoc phan bo '
	SET @sSQL1=N'
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
		MT0400.DivisionID
	FROM MT0400 WITH (NOLOCK) 
			LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON MT0400.ProductID = AT1302_P .InventoryID AND AT1302_P.DivisionID IN (MT0400.DivisionID,''@@@'')
			LEFT JOIN AT1302 AT1302_M WITH (NOLOCK) ON MT0400.MaterialID=AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MT0400.DivisionID,''@@@'')
	WHERE MT0400.DivisionID ='''+@DivisionID+''' AND
		PeriodID = '''+@PeriodID+''' AND
		ExpenseID =''COST001'' AND
		ProductID IN (SELECT ProductID FROM  MT2222) AND        
		MaterialTypeID ='''+@MaterialTypeID+''' 
	GROUP BY MaterialID, ProductID, ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID, MT0400.DivisionID
	UNION ALL'

	SET @sSQL2=N'
	SELECT DISTINCT MaterialID,  sum(MaterialQuantity), 0 AS ConvertedAmount, ProductID, 
		ProductQuantity = (SELECT SUM(Quantity)  
							FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.VoucherID = MT1001.VoucherID 
							WHERE MT1001.ProductID = MT1613.ProductID AND MT0810.ResultTypeID =''R01'' 
								AND MT0810.PeriodID = '''+@PeriodID+'''  
								AND MT0810.DivisionID ='''+@DivisionID+'''), 
		ProductUnitID, MaterialUnitID, DivisionID 
	FROM MT1613 WITH (NOLOCK) 
	WHERE Type = ''B'' AND ExpenseID =''COST001'' AND DivisionID = ''' + @DivisionID + '''  
		AND ProductID IN (SELECT ProductID FROM  MT2222) 
		AND PeriodID = ''' + @PeriodID + ''' AND MaterialTypeID = ''' + @MaterialTypeID + ''' 
		AND ProductID + ''_'' + MaterialID NOT IN 
		(SELECT ProductID + ''_'' + MaterialID FROM MT0400 
		WHERE     DivisionID =''' + @DivisionID + ''' AND 
			PeriodID = ''' + @PeriodID + ''' AND 
			ExpenseID = ''COST001'' AND
			MaterialTypeID =''' + @MaterialTypeID + ''' ) GROUP BY MaterialID,ProductID,ProductUnitID,MaterialUnitID, DivisionID  '

	IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV8101' AND Xtype ='V')
		EXEC ('CREATE VIEW MV8101 AS '+@sSQL1+@sSQL2)
	ELSE
		EXEC ('ALTER VIEW MV8101 AS '+@sSQL1+@sSQL2)

	--print @sSQL

	-- Lấy thông tin master cho MT1613
	DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
			@UnfinishCostDescription NVARCHAR(1000),
			@PeriodStr VARCHAR(20)

	SET @UnfinishCostVoucherTypeID = (SELECT ISNULL(UnfinishCostVoucherTypeID,'CPDD') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	SET @UnfinishCostDescription = (SELECT ISNULL(UnfinishCostDescription + ' ',N'Chi phí dở dang ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END


	SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR 
 
		SELECT         MV8101.MaterialID, 
				MV8101.MaterialQuantity, --    So luong NVL phat sinh trong ky
				MV8101.ConvertedAmount, --     Chi phi cua NVL phat sinh trong ky
				MV8101.ProductID, ---     Ma san pham
				MV8101.ProductQuantity, --     So luong thanh pham hoan thanh
				MT2222.ProductQuantity*MT2222.MaterialRate/100 AS InPocessQuantity, --- So luong thanh pham do dang quy doi
				MT2222.PerfectRate, MT2222.MaterialRate, MT2222.HumanresourceRate, MT2222.OthersRate, 
				MT2222.ProductQuantity, MV8101.ProductUnitID, MV8101.MaterialUnitID,
				(Select sum(MT22.ProductQuantity*MT22.MaterialRate/100)
				From MT2222 MT22 WITH (NOLOCK) Where MT22.DivisionID = MT2222.DivisionID And MT22.ProductID = MT2222.ProductID)
			FROM MV8101 LEFT JOIN MT2222 WITH (NOLOCK) ON MV8101.DivisionID  = MT2222.DivisionID AND MV8101.ProductID  = MT2222.ProductID 

			OPEN @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, 
										@ProductQuantity, @InProcessQuantity, @PerfectRate, @MaterialRate, 
										 @HumanresourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID, @TotalInProcessQuantity


			WHILE @@Fetch_Status = 0
				BEGIN    

            
			--B­íc 1 :X¸c ®Þnh chi phÝ NVL DD ®Çu kú cho tõng NVL
                    
					  SELECT     @BSumConverted621 = SUM(ConvertedAmount), 
						@BMaterialQuantity = SUM(MaterialQuantity)
					  FROM     MT1613 WITH (NOLOCK)
					  WHERE     DivisionID= @DivisionID AND  PeriodID =  @PeriodID 
							AND TranMonth=@TranMonth AND TranYear = @TranYear 
							AND MaterialTypeID = @MaterialTypeID             
							AND ProductID =@ProductID 
							AND ISNULL(MaterialID,'') = ISNULL(@MaterialID,'') 
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
						SET @MaterialInprocessCost =round((ISNULL(@BSumConverted621, 0) 
						+ISNULL(@ISumConverted621, 0)) *ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0)
						+ISNULL(@TotalInProcessQuantity, 0)), @ConvertedDecimal)
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
        
						SET @QuantityUnit  =((ISNULL(@BMaterialQuantity, 0)  + ISNULL(@MaterialQuantity, 0))*ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)))/ @ProductQuantityEnd
					ELSE 
						SET @QuantityUnit  = 0
                
					EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
    
					--PRINT '@TransactionID' + @TransactionID
            
					INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
							ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
									  MaterialQuantity, ConvertedAmount, 
							 ProductQuantity, QuantityUnit, ConvertedUnit, 
							 CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate, VoucherTypeID, VoucherNo, VoucherDate, EmployeeID, Description, LastModifyUserID, LastModifyDate  )
            
					VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
						@ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
						((ISNULL(@BMaterialQuantity, 0)  + ISNULL(@MaterialQuantity, 0)) * ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0))), 
						@MaterialInprocessCost, 
						@ProductQuantityEnd, @QuantityUnit, @ConvertedUnitEnd, 
						Getdate(), @UserID, 'E', @MaterialRate, @HumanResourceRate, @OthersRate, @UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE() )
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

END


SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
