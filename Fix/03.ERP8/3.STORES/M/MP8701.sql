IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8701]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8701]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Hoang Thi Lan Date 12/11/2003
--Purpose :Tính chi phí dở dang cuối kỳ cho SXC theo PP Ước lượng tương đương
--Edit BY Nguyen Quoc Huy, Date 06/03/2004
--Edit BY: Dang Le Bao Quynh, Date 30/05/2007
--Purpose: Sua cach lay so lieu do dang dau ky tu bang MT1613 thay cho MT1612
--- Modify on 12/06/2014 by Tấn Phú: Them tong so san pham do dang trong ky @@TotalInProcessQuantity
----- Modify on 20/04/2014 by Phương Thảo: Customize KH Meiko : Gọi store MP8701_MK
--- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
--- Modify on 30/06/2017 by Bảo Anh: Bổ sung stote customize GodRej
--- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
--- Modified by Kim Thư on 24/06/2019: Phân rã số đầu kỳ và phát sinh trong kỳ theo tỷ lệ hoàn thành của từng product có làm tròn để tính dở dang ko bị sai số
----									Viết lại update tính dở dang vào bảng tạm
--- Modified by Hoàng Trúc on 08/08/2019: Bổ sung câu drop view AV8701
--- Modified by Văn Tài on 01/11/2019: Sửa lỗi không chạy vòng lặp bảng tạm để tạo TransactionID mới.
--- Modified by Huỳnh Thử on 16/06/2020: Thay đổi IsNULL thành NULLIF - Lỗi: Divide by zero error encountered
--- Modified by Huỳnh Thử on 25/07/2020: Fix lỗi Run tool all Fix
--- Modified by Nhựt Trường on 24/08/2020: Merge code Meiko - Điều chỉnh cách gọi store MP8701_MK.
--- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
--- Modified by Nhựt Trường on 19/03/2021: Fix lỗi thiếu EXEC (@sSQL1) để insert dữ liệu vào bảng tạm #MT1613_003.
--- Modified by Nhựt Trường on 15/08/2022: [2022/05/IS/0084] - Fix lỗi chia 0.
--- Modified by Nhựt Trường on 26/04/2023: [2023/04/IS/0115] - Fix lỗi lấy sai lại loại tỉ lệ khi xác định CP DD cho CP SXC.


CREATE PROCEDURE  [dbo].[MP8701] @DivisionID AS NVARCHAR(50), 
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
DECLARE @sSQL AS VARCHAR(8000), 
    @BSumConverted627 AS DECIMAL(38, 20), --Chi phí NVL đầu kỳ
    @ISumConverted627 AS DECIMAL(38, 20), --Chi phí NVL trong kỳ
    @Quantity AS DECIMAL(38, 20), --Số lượng thành phẩm
    @QuantityInprocess AS DECIMAL(38, 20), --Số lương dở dang cuối kỳ
    @MaterialRate AS DECIMAL(38, 20), --Tỉ lệ % NVL
    @MaterialID AS NVARCHAR(50), 
    @ListMaterial_cur AS CURSOR, 
    @MaterialQuantity AS DECIMAL(38, 20), 
    @ConvertedAmount AS DECIMAL(38, 20), 
    @ProductQuantity AS DECIMAL(38, 20), 
    @InprocessCost AS DECIMAL(38, 20), 
    @ProductID AS NVARCHAR(50), 
    @PerfectRate AS DECIMAL(38, 20), 
    @InProcessQuantity AS DECIMAL(38, 20), 
    @TotalInProcessQuantity AS DECIMAL(38, 20), 
    @HumanResourceRate AS DECIMAL(38, 20), 
    @OthersRate AS DECIMAL(38, 20), 
    @ProductQuantityEnd AS DECIMAL(38, 20), 
    @ConvertedUnitEnd AS DECIMAL(38, 20), 
    @TransactionID AS NVARCHAR(50), 
    @ProductUnitID AS NVARCHAR(50), 
    @MaterialUnitID AS NVARCHAR(50), 
    @ListProduct_cur AS CURSOR, 
    @ListMaterial_cur1 AS CURSOR, 
    @ConvertedDecimal INT, 
    @SumInProcessQuantity AS DECIMAL(38, 20),
	@CustomerName INT,
	@sSQL1 NVARCHAR(MAX)

SET NOCOUNT ON

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

SET NOCOUNT ON
SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 WITH (NOLOCK) where DivisionID = @DivisionID)


IF (@CustomerName = 50)
BEGIN	
	EXEC MP8701_MK @DivisionID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @VoucherID, @CMonth, @CYear
END
ELSE IF (@CustomerName = 74)
BEGIN
	EXEC MP8701_GOD @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @VoucherID, @CMonth, @CYear, @VoucherNo
END
ELSE
BEGIN 
	SET @sSQL='
	SELECT MaterialID, 
		SUM(ISNULL(MaterialQuantity, 0)) AS MaterialQuantity, 
		SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, 
		ProductID, --- Ma thanh pham
		---- So luong thanh pham duoc san xuat trong ky
		ProductQuantity = ( SELECT SUM(Quantity) FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID 
							WHERE MT1001.ProductID = MT0400.ProductID AND MT0810.ResultTypeID = ''R01'' 
								AND MT0810.PeriodID = '''+@PeriodID+''' AND MT1001.DivisionID ='''+@DivisionID+'''), 
		AT1302_P.UnitID AS ProductUnitID, 
		AT1302_M.UnitID AS MaterialUnitID, 
		MT0400.DivisionID,
		MT0400.ProductQuantity as ActualProductQuantity
	FROM MT0400 WITH (NOLOCK) 
		LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON MT0400.ProductID = AT1302_P .InventoryID AND AT1302_P.DivisionID IN ('''+@DivisionID+''',''@@@'')
		LEFT JOIN AT1302 AT1302_M WITH (NOLOCK) ON MT0400.MaterialID=AT1302_M.InventoryID AND AT1302_M.DivisionID IN ('''+@DivisionID+''',''@@@'')
	WHERE MT0400.DivisionID ='''+@DivisionID+''' AND
		PeriodID = '''+@PeriodID+''' AND
		ExpenseID =''COST003'' AND
		MaterialTypeID = '''+@MaterialTypeID+''' AND
		ProductID IN (SELECT ProductID FROM  MT2222) 
	GROUP BY MaterialID, ProductID, ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID, MT0400.DivisionID, MT0400.ProductQuantity '

IF EXISTS (SELECT TOP 1 1  FROM SYSOBJECTS WHERE XTYPE='V' AND NAME ='MV8701')
DROP VIEW MV8701

EXEC('CREATE VIEW MV8701 as '+@sSQL)

	--SELECT * FROM MV8701 WHERE ProductID='M-HSP-25'

	-- Lấy thông tin master cho MT1613
	DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
			@UnfinishCostDescription NVARCHAR(1000),
			@PeriodStr VARCHAR(20)

	SET @UnfinishCostVoucherTypeID = (SELECT ISNULL(UnfinishCostVoucherTypeID,'CPDD') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	SET @UnfinishCostDescription = (SELECT ISNULL(UnfinishCostDescription + ' ',N'Chi phí dở dang ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END

	CREATE TABLE #MT1613_003 (APK UNIQUEIDENTIFIER DEFAULT NEWID(), MaterialID VARCHAR(50), MaterialQuantity DECIMAL(38, 20) DEFAULT (0), ConvertedAmount DECIMAL(38, 20) DEFAULT (0), 
							ProductID VARCHAR(50), ProductQuantity DECIMAL(38, 20) DEFAULT (0), InProcessQuantity DECIMAL(38, 20) DEFAULT (0), 
							TotalInProcessQuantity DECIMAL(38, 20) DEFAULT (0), PerfectRate DECIMAL(28,8) DEFAULT (0), MaterialRate DECIMAL(38, 20) DEFAULT (0), 
							HumanResourceRate DECIMAL(38, 20) DEFAULT (0), OthersRate DECIMAL(38, 20) DEFAULT (0), ProductQuantityEnd DECIMAL(38, 20) DEFAULT (0), 
							ProductUnitID VARCHAR(50), MaterialUnitID VARCHAR(50), BSumConverted627 DECIMAL(38, 20) DEFAULT (0), InProcessCost DECIMAL(38, 20) DEFAULT (0),
							ConvertedUnitEnd DECIMAL(38, 20) DEFAULT (0))
	
	SET @sSQL1 = N'
	INSERT INTO #MT1613_003 (MaterialID, MaterialQuantity, ConvertedAmount, ProductID, ProductQuantity, InProcessQuantity, TotalInProcessQuantity, PerfectRate, MaterialRate, 
							HumanResourceRate, OthersRate, ProductQuantityEnd, ProductUnitID, MaterialUnitID)
	SELECT MV8701.MaterialID, 
		 MV8701.MaterialQuantity, ---So luong NVL phat sinh trong ky
		 --MV8701.ConvertedAmount, ---- Chi phi cua NVL phat sinh trong ky
		 ConvertedAmount= ROUND(NULLIF(MV8701.ConvertedAmount,0) * (NULLIF(MT2222.ProductQuantity,0) * NULLIF(MT2222.OthersRate,0)/100) / NULLIF(MV8701.ActualProductQuantity,0),8), ---- Chi phi cua NVL phat sinh trong ky
		 MV8701.ProductID, --- Ma san pham
		 MV8701.ProductQuantity, -- So luong thanh pham hoan thanh
		 NULLIF(MT2222.ProductQuantity, 0)*NULLIF(MT2222.OthersRate, 0)/100 as InProcessQuantity, --- So luong thanh pham do dang quy doi
		 TotalInProcessQuantity = (select sum(NULLIF(MT22.ProductQuantity, 0)*NULLIF(MT22.OthersRate, 0)/100) as InProcessQuantity from MT2222 MT22
									Where MT22.DivisionID = MT2222.DivisionID  and MT22.ProductID = MT2222.ProductID
									group by MT22.DivisionID,MT22.ProductID),
		 MT2222.PerfectRate, --Tỉ lệ % hoàn thành
		 MT2222.MaterialRate, --%NVL
		 MT2222.HumanResourceRate, --%NC
		 MT2222.OthersRate, --%SXC
		 MT2222.ProductQuantity, --Số lượng SPDD cuối kỳ
		 MV8701.ProductUnitID, 
		 MV8701.MaterialUnitID
	FROM MV8701 LEFT JOIN MT2222 WITH (NOLOCK) ON MV8701.DivisionID = MT2222.DivisionID AND MV8701.ProductID = MT2222.ProductID 
	UNION ALL 
	SELECT MT1613.MaterialID, 
		0 AS MaterialQuantity, 
		0 AS ConvertedAmount, 
		MT1613.ProductID, 
		ProductQuantity = ISNULL((  SELECT SUM(ISNULL(Quantity, 0)) 
									FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID
									WHERE MT1001.ProductID = MT1613.ProductID 
										AND MT0810.PeriodID = '''+@PeriodID+''' 
										AND MT0810.ResultTypeID = ''R01'' --- ket qua san xuat la thanh pham
										AND MT0810.DivisionID = '''+@DivisionID+'''), 0), 
		ISNULL(MT2222.ProductQuantity, 0)*ISNULL(MT2222.OthersRate, 0)/100 AS InProcessQuantity, 
		TotalInProcessQuantity = (select sum(NULLIF(MT22.ProductQuantity, 0)*NULLIF(MT22.OthersRate, 0)/100) as InProcessQuantity from MT2222 MT22 WITH (NOLOCK)
		Where MT22.DivisionID = MT2222.DivisionID  and MT22.ProductID = MT2222.ProductID
	group by DivisionID,ProductID),
		MT2222.PerfectRate, 
		MT2222.MaterialRate, 
		MT2222.HumanresourceRate, 
		MT2222.OthersRate, 
		MT2222.ProductQuantity, 
		IP.UnitID AS ProductUnitID, 
		Null  AS MaterialUnitID
	FROM MT1613 WITH (NOLOCK) LEFT JOIN MT2222 WITH (NOLOCK) ON MT2222.DivisionID = MT1613.DivisionID AND MT2222.ProductID = MT1613.ProductID
		LEFT JOIN AT1302 AS IP WITH (NOLOCK) ON IP.InventoryID = MT1613.ProductID AND IP.DivisionID IN ('''+@DivisionID+''',''@@@'')
	WHERE MT1613.ProductID NOT IN (SELECT DISTINCT ProductID FROM MT0400 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND PeriodID = '''+@PeriodID +'''
									AND MaterialTypeID = '''+@MaterialTypeID+''' AND ExpenseID =''COST003''  )   --- khong co phat sinh duoc phan bo
		AND MT1613.PeriodID = '''+@PeriodID+''' 
		AND MT1613.DivisionID = '''+@DivisionID +'''
		AND MT1613.MaterialTypeID = '''+@MaterialTypeID+'''
		AND MT1613.ExpenseID = ''COST003''
	'
	EXEC (@sSQL1)
	--SELECT * FROM #MT1613_003 WHERE ProductID='M-HSP-25'
	---------------------------------------------Update số đầu kỳ--------------------------------------------------------------
	UPDATE #MT1613_003
	SET BSumConverted627 = ROUND((SELECT SUM(ISNULL(ConvertedAmount, 0)) FROM MT1613 WITH (NOLOCK) 
								WHERE DivisionID = @DivisionID AND PeriodID = @PeriodID AND TranMonth = @TranMonth AND TranYear = @TranYear 
								AND ExpenseID = 'COST003' AND MaterialTypeID = @MaterialTypeID AND ProductID = #MT1613_003.productID
								AND Type ='B') * (ProductQuantityEnd * OthersRate/100) / TotalInProcessQuantity,@ConvertedDecimal)
	--SELECT * FROM #MT1613_003 WHERE ProductID='M-HSP-25'
	-----------------------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------Làm tròn số đầu kỳ và số phát sinh do sai số--------------------------------------------------
	SELECT T1.ProductID, ISNULL(ISNULL(T2.ConvertedAmount,0) - SUM(T1.ConvertedAmount),0) AS ConvertedAmount_delta
	INTO #DELTA -- CHÊNH LỆCH PS TRONG KỲ
	FROM #MT1613_003 T1 inner JOIN MV8701 T2 WITH (NOLOCK)  ON T1.ProductID = T2.ProductID
	GROUP BY T1.ProductID, T2.ConvertedAmount--, T3.ConvertedAmount

	SELECT T1.ProductID,
	ISNULL((SELECT SUM(ISNULL(ConvertedAmount,0)) FROM MT1613 T3 WITH (NOLOCK) WHERE T3.ProductID=T1.ProductID AND T3.ExpenseID = 'COST003' AND T3.Type='B' 
			and T3.PeriodID=@periodID AND T3.MaterialTypeID = @MaterialTypeID)
	-SUM(T1.BSumConverted627),0) AS BSumConverted627_delta
	INTO #DELTA2 -- CHÊNH LỆCH ĐẦU KỲ
	FROM #MT1613_003 T1 
	GROUP BY T1.ProductID

	--SELECT * FROM #DELTA2  WHERE ProductID='M-HSP-25'

	UPDATE T1
	SET T1.ConvertedAmount=T1.ConvertedAmount+T2.ConvertedAmount_delta
	FROM #MT1613_003 T1 INNER JOIN #DELTA T2 ON T1.ProductID = T2.ProductID
	OUTER APPLY (SELECT TOP 1 APK, ProductID, ConvertedAmount FROM #MT1613_003 A WHERE A.ProductID = T1.ProductID Order By ConvertedAmount DESC) T3
	WHERE T1.APK=T3.APK

	UPDATE T1
	SET T1.BSumConverted627=T1.BSumConverted627+T2.BSumConverted627_delta
	FROM #MT1613_003 T1 INNER JOIN #DELTA2 T2 ON T1.ProductID = T2.ProductID
	OUTER APPLY (SELECT TOP 1 APK, ProductID, BSumConverted627 FROM #MT1613_003 A WHERE A.ProductID = T1.ProductID Order By BSumConverted627 DESC) T3
	WHERE T1.APK=T3.APK

	--SELECT * FROM #MT1613_003 WHERE ProductID='M-HSP-25'
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	--Tính chi phí DD CKỳ  SXC theo PP Ước lượng tương đương
	UPDATE #MT1613_003
	SET InprocessCost = CASE WHEN (ISNULL(CAST(ProductQuantity AS DECIMAL(38, 20)), 0) +ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0)) <> 0
						THEN  Round(((ISNULL(CAST(BSumConverted627 AS DECIMAL(38, 20)), 0) +ISNULL(CAST(ConvertedAmount AS DECIMAL(38, 20)), 0))*ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0))/
						(ISNULL(CAST(ProductQuantity AS DECIMAL(38, 20)), 0) +ISNULL(CAST(InProcessQuantity AS DECIMAL(38, 20)), 0)), 8)
						ELSE 0 END

	--SELECT * FROM #MT1613_003 WHERE ProductID='M-HSP-25'

	--Tính chi phí DD CKỳ  SXC/1SP
	UPDATE #MT1613_003
	SET ConvertedUnitEnd = CASE WHEN (ProductQuantityEnd <>0) THEN ISNULL(InprocessCost, 0)/ProductQuantityEnd ELSE 0 END

	SELECT * FROM #MT1613_003

	Declare @key_Loop NVARCHAR(MAX)
	-- Duyệt từng dòng bằng WHILE
	WHILE EXISTS(SELECT 1 FROM #MT1613_003)
	BEGIN
		EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

		--Gán dữ liệu khóa chính: ProductID
		SELECT TOP 1 @key_Loop = ProductID FROM #MT1613_003

		INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
				ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
							MaterialQuantity, ConvertedAmount, 
					ProductQuantity, QuantityUnit, ConvertedUnit, 
					CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate,
					VoucherTypeID, VoucherNo, VoucherDate, EmployeeID, Description, LastModifyUserID, LastModifyDate     )

		SELECT TOP 1 @PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
			ProductID, MaterialID, 'COST003', @MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, 
			MaterialQuantity, InprocessCost, 
			ProductQuantityEnd, Null, ConvertedUnitEnd, 
			Getdate(), @UserID, 'E', MaterialRate, HumanResourceRate, OthersRate,
			@UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE() 
		FROM #MT1613_003
		WHERE ProductID = @key_Loop

		--Xóa dần dữ liệu bảng tạm
		DELETE FROM #MT1613_003 WHERE ProductID = @key_Loop
	END
	/*
	SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
		SELECT MaterialID, MaterialQuantity, ConvertedAmount, ProductID, ProductQuantity, InProcessQuantity, TotalInProcessQuantity, PerfectRate, MaterialRate, 
								HumanResourceRate, OthersRate, ProductQuantityEnd, ProductUnitID, MaterialUnitID
		FROM #MT1613_003
	OPEN @ListProduct_cur 
	FETCH NEXT FROM  @ListProduct_cur INTO 
		@MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @TotalInProcessQuantity, @PerfectRate, @MaterialRate, 
		@HumanResourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID 
	WHILE @@Fetch_Status = 0
	BEGIN    
		--Bước 1 :Xác định chi phí NC DD đầu kỳ 
		--SET @BSumConverted627 = (SELECT SUM(ISNULL(ConvertedAmount, 0))
		--						FROM MT1613 WITH (NOLOCK)
		--						WHERE PeriodID =  @PeriodID AND TranMonth = @TranMonth AND TranYear = @TranYear 
		--							AND ExpenseID = 'COST003' AND MaterialTypeID = @MaterialTypeID AND  ProductID = @ProductID
		--							AND DivisionID = @DivisionID AND Type ='B')

		--Bước 2:Xác định chi phí NC phát sinh trong kỳ
		SET @ISumConverted627 = @ConvertedAmount

    
		--Bước 3:Tính chi phí DD CKỳ  SXC theo PP Ước lượng tương đương
		IF (ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) <> 0 
			--SET @InprocessCost =(ISNULL(@BSumConverted627, 0) +ISNULL(@ISumConverted627, 0))*ISNULL(@InProcessQuantity, 0)/(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)) 
			 SET @InprocessCost = Round(((ISNULL(@BSumConverted627, 0) +ISNULL(@ISumConverted627, 0))*ISNULL(@InProcessQuantity, 0))/
									(ISNULL(@ProductQuantity, 0) +ISNULL(@InProcessQuantity, 0)), @ConvertedDecimal)
		ELSE SET @InprocessCost = 0 

		--Bước 4:Tính chi phí DD CKỳ  SXC/1SP
		IF (@ProductQuantityEnd <>0)
			 SET @ConvertedUnitEnd = ISNULL(@InprocessCost, 0)/@ProductQuantityEnd
		ELSE SET @ConvertedUnitEnd = 0
    
		EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

		INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
				ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
						  MaterialQuantity, ConvertedAmount, 
				  ProductQuantity, QuantityUnit, ConvertedUnit, 
				 CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate,
				 VoucherTypeID, VoucherNo, VoucherDate, EmployeeID, Description, LastModifyUserID, LastModifyDate     )

		VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
			@ProductID, @MaterialID, 'COST003', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
			@MaterialQuantity, @InprocessCost, 
			@ProductQuantityEnd, Null, @ConvertedUnitEnd, 
			Getdate(), @UserID, 'E', @MaterialRate, @HumanResourceRate, @OthersRate,
			@UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE()     )
		FETCH NEXT FROM  @ListProduct_cur INTO 
		@MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @TotalInProcessQuantity, @PerfectRate, @MaterialRate, 
		@HumanResourceRate, @OthersRate, @ProductQuantityEnd, @ProductUnitID, @MaterialUnitID 

	End 
	Close @ListProduct_cur
	*/
--print @VoucherID
END

SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
