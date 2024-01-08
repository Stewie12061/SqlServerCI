IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5702]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP5702]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created BY Nguyen Van Nhan AND Hoang Thi Lan     Date:5/11/2003 
---- Purpose: Phan bo chi phi SXC theo PP he so
-- Edit BY Quoc Hoai
---Created BY : VO THANH HUONG, date: 20/05/2005, Xu ly lam tron
--- Modify on 30/12/2013 by Bảo Anh: Sửa kiểu dữ liệu các biến truyền vào store từ nvarchar(20) thành nvarchar(50)
/********************************************
'* Edited BY: [GS] [Việt Khánh] [29/07/2010]
'********************************************/
----- Modify on 02/12/2015 by Phương Thảo: Customize KH Meiko - Phan bo tren tat ca cac mat hang chu ko di theo Doi tuong tap hop
----- Modify on 25/04/2016 by Phương Thảo: Customize KH Meiko - Trừ bớt số lượng đầu kỳ trước
----- Modify on 21/06/2016 by Phương Thảo: Cải tiến tốc độ Meiko
----- Modify on 30/06/2017 by Bảo Anh: Bổ sung stote customize GodRej
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ
---- Modified by Huỳnh Thử on 08/07/2020 - Làm tròn MekiO
---- Modified by Đức Thông on 01/03/2021 [TOHO] [2020/12/IS/0526] Fix lỗi kết quả thành tiền trong phân bổ chi phí bị lệch với trong kết quả tập hợp chi phí
---- Modified by Huỳnh Thử on 15/06/2021 -- Bổ sung where theo DivisionID

CREATE PROCEDURE [dbo].[MP5702] 
    @DivisionID AS NVARCHAR(50),
	@UserID AS VARCHAR(50), 
    @PeriodID AS NVARCHAR(50), 
    @TranMonth AS INT, @TranYear AS INT, 
    @MaterialTypeID AS NVARCHAR(50), 
    @CoefficientID AS NVARCHAR(50) 
AS 
DECLARE 
    @sSQL AS NVARCHAR(4000), 
    @SUMProductCovalues AS DECIMAL(28, 8), 
    @ListProduct_cur AS CURSOR, 
    @ProductID AS NVARCHAR(50), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @ProductCovalues AS DECIMAL(28, 8), 
    @ProductOthers AS DECIMAL(28, 8), 
    @MaterialID AS NVARCHAR(50), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @QuantityUnit AS DECIMAL(28, 8), 
    @ConvertedUnit AS DECIMAL(28, 8), 
    @UnitID AS NVARCHAR(50), 
    @Detal AS DECIMAL(28, 8), 
    @ConvertedAmount1 AS DECIMAL(28, 8), 
    @ConvertedDecimal AS TINYINT,  --- Bien lam tron
	@CustomerName INT,
	@InProcessID Varchar(50),
	@ListPeriodID Varchar(50)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF(@CustomerName = 74)
BEGIN
	EXEC MP5702_GOD @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @CoefficientID
END
ELSE
BEGIN
IF(@CustomerName = 50)
begin
	DECLARE @ListPeriod_cur CURSOR
	IF NOT EXISTS (SELECT TOP 1 1 FROM MT1613 WHERE TranMonth = @TranMonth and TranYear = @TranYear and DivisionID = @DivisionID AND Type ='B'  )
	BEGIN 

		SET @ListPeriod_cur = CURSOR SCROLL KEYSET FOR 
			SELECT DISTINCT PeriodID, InProcessID FROM MT1601 WITH(NOLOCK) WHERE FromMonth = @TranMonth and FromYear = @TranYear and DivisionID = @DivisionID
		OPEN @ListPeriod_cur
		FETCH NEXT FROM @ListPeriod_cur INTO @ListPeriodID, @InProcessID    	   
		WHILE @@Fetch_Status = 0
		BEGIN
			--SELECT @InProcessID = ( SELECT InprocessID FROM MT1601 WITH(NOLOCK) 
			--						WHERE PeriodID = @ListPeriodID AND DivisionID = @DivisionID)
			
			DELETE MT1613 WHERE PeriodID = @ListPeriodID AND DivisionID = @DivisionID AND Type ='B'   
			EXEC MP8001 @DivisionID, @ListPeriodID, @TranMonth, @TranYear, @InProcessID


		FETCH NEXT FROM @ListPeriod_cur INTO @ListPeriodID, @InProcessID
			END

		CLOSE @ListPeriod_cur
	END
end

--Tao  ra VIEW so 1

SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 WITH(NOLOCK) where DivisionID = @DivisionID)

CREATE TABLE #MP5702 (DivisionID Varchar(50), ProductID Varchar(50), CoValue decimal(28, 8), ProductQuantity decimal(28, 8), 
						ProductCoValues decimal(28, 8), CoefficientID Varchar(50))


IF(@CustomerName = 50)
begin
	INSERT INTO #MP5702
	SELECT MT1605.DivisionID, 
		(CASE WHEN MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) AS ProductID, 
		ISNULL(CoValue, 0) AS  CoValue, 
		ISNULL(MT2222.ProductQuantity, 0) - ISNULL(MT13.ProductQuantity,0) AS ProductQuantity, 
		CoValue* (ISNULL(MT2222.ProductQuantity, 0) - ISNULL(MT13.ProductQuantity,0)) AS ProductCoValues,
		MT1605.CoefficientID	
	FROM MT5001 WITH(NOLOCK)
	INNER JOIN MT1605 WITH(NOLOCK) ON MT5001.CoefficientID = MT1605.CoefficientID AND MT5001.MaterialTypeID = @MaterialTypeID  
	LEFT JOIN MT1601 WITH(NOLOCK) ON MT5001.DistributionID = MT1601.DistributionID
	LEFT JOIN MT2222 WITH(NOLOCK) ON MT2222.DivisionID = MT1605.DivisionID AND MT2222.ProductID = MT1605.InventoryID  AND MT1601.PeriodID = MT2222.PeriodID 
	LEFT JOIN (	SELECT DivisionID, PeriodID, ProductID , ISNULL(MAX(ProductQuantity),0) AS ProductQuantity
				FROM MT1613 WITH(NOLOCK)
				WHERE DivisionID = @DivisionID and ExpenseID = 'COST003' AND Type = 'B'
				GROUP BY DivisionID, PeriodID, ProductID) MT13 
						ON  MT13.DivisionID = MT1605.DivisionID AND MT2222.PeriodID = MT13.PeriodID AND (Case  when MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) = MT13.ProductID
	WHERE MT1605.CoefficientID LIKE '%' AND
	MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
	--AND MT2222.PeriodID in (SELECT DISTINCT PeriodID FROM MV9000 where Isnull(PeriodID,'') <> '' and Isnull(ExpenseID,'') <> '' and Isnull(MaterialTypeID,'') <> '')

END 
ELSE 
begin
	INSERT INTO #MP5702
	SELECT MT1605.DivisionID, 
		(CASE WHEN MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) AS ProductID, 
		ISNULL(CoValue, 0) AS  CoValue, 
		ISNULL(ProductQuantity, 0) AS ProductQuantity, 
		CoValue*ProductQuantity AS ProductCoValues,
		CoefficientID	
	FROM MT1605 WITH(NOLOCK) FULL JOIN MT2222 WITH(NOLOCK) ON MT2222.DivisionID = MT1605.DivisionID AND MT2222.ProductID = MT1605.InventoryID	
	WHERE CoefficientID LIKE @CoefficientID AND
	MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
	
END 

--Duyet  tung mat hang
IF(@CustomerName = 50)
BEGIN
	SET @ConvertedAmount=(	SELECT SUM(CASE D_C WHEN 'D' THEN ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) 
							FROM MV9000 
							WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND ExpenseID ='COST003' AND MaterialTypeID =@MaterialTypeID
								AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))
END
ELSE
BEGIN
	SET @ConvertedAmount=(	SELECT SUM(CASE D_C WHEN 'D' THEN ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) 
							FROM MV9000 
							WHERE PeriodID = @PeriodID AND ExpenseID ='COST003' AND MaterialTypeID =@MaterialTypeID
								AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

	
END




SET @SUMProductCovalues = (SELECT SUM(ISNULL(ProductCovalues, 0)) FROM #MP5702)

--SELECT * FROM #MP5702  WHERE CoefficientID = @CoefficientID   
--SELECT * FROM #MP5702 
--select * from MT1613
--select @ConvertedAmount as ConvertedAmoun
--select @SUMProductCovalues as SUMProductCovalue

SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
    SELECT ProductID, ProductQuantity, ProductCoValues
    FROM #MP5702    
	WHERE CoefficientID = @CoefficientID AND ProductQuantity <> 0     
OPEN @ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @ProductQuantity, @ProductCoValues
            
WHILE @@Fetch_Status = 0
    BEGIN
        
        IF ISNULL(@SUMProductCoValues, 0) <> 0 AND ISNULL(@ProductQuantity, 0) <> 0            
            SET  @ProductOthers = ((ISNULL(@ConvertedAmount, 0)/@SUMProductCovalues)*ISNULL(@ProductCoValues, 0))/@ProductQuantity        
        ELSE
            SET @ProductOthers= 0 
    
        SET @ProductOthers = ROUND(@ProductOthers, @ConvertedDecimal)

        IF ISNULL(@SUMProductCovalues, 0) <>0 
            SET @ConvertedAmount1 = (ROUND((ISNULL(@ConvertedAmount, 0)*ISNULL(@ProductCoValues, 0)/@SUMProductCovalues), @ConvertedDecimal))
        ELSE 
            SET @ConvertedAmount1 = 0 
            
        INSERT MT0621 (DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit, MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate)
        VALUES (@DivisionID, NULL, @ProductID, @UnitID, 'COST003', NULL, NULL, @MaterialTypeID, @ConvertedAmount1, @ProductOthers, @ProductQuantity, NULL)
                
        FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @ProductQuantity, @ProductCoValues
    END

CLOSE @ListProduct_cur

DECLARE @PeriodNotDistribute Int,
		@PeriodDistribute Int,
		@TotalPeriod Int
IF @CustomerName = 50
BEGIN
SELECT @PeriodNotDistribute = COUNT(PeriodID) 
FROM MT1601
WHERE DivisionID = @DivisionID AND PeriodID <> @PeriodID
AND FromMonth = @TranMonth and FromYear = @TranYear AND ToMonth = @TranMonth and ToYear = @TranYear
AND NOT EXISTS (SELECT TOP 1 1 FROM MT1001 INNER JOIN MT0810 ON MT1001.VoucherID = MT0810.VoucherID AND MT1001.DivisionID = MT0810.DivisionID
                WHERE MT0810.PeriodID = MT1601.PeriodID AND MT0810.ResultTypeID IN ('R03', 'R01') AND MT1001.DivisionID = @DivisionID
				and MT1001.TranMonth = @TranMonth and MT1001.TranYear = @TranYear )

SELECT @PeriodDistribute = COUNT(PeriodID)
FROM MT1601
WHERE IsDistribute = 1 AND DivisionID = @DivisionID AND FromMonth = @TranMonth and FromYear = @TranYear AND ToMonth = @TranMonth and ToYear = @TranYear

SELECT @TotalPeriod = COUNT(PeriodID)
FROM MT1601
WHERE DivisionID = @DivisionID AND PeriodID <> @PeriodID
AND FromMonth = @TranMonth and FromYear = @TranYear AND ToMonth = @TranMonth and ToYear = @TranYear

END
IF(@CustomerName <> 50)
begin
---- Xu ly lam tron
DECLARE @MaxProductID AS UNIQUEIDENTIFIER

SET @Detal = ROUND(ISNULL(@ConvertedAmount, 0), @ConvertedDecimal) - ISNULL((SELECT SUM(ConvertedAmount) 
                                                                            FROM MT0621 WITH(NOLOCK)
                                                                            WHERE MaterialTypeID = @MaterialtypeID 
                                                                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                                                                AND ExpenseID = 'COST003'), 0)
IF @Detal <> 0 
    BEGIN
            --- Lam tron
        SET @MaxProductID = (SELECT TOP 1 APK
                                FROM MT0621 WITH(NOLOCK)
                                WHERE ExpenseID ='COST003' AND MaterialTypeID = @MaterialTypeID
                                    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                ORDER BY ConvertedAmount Desc)

        Update MT0621 SET ConvertedAmount = ConvertedAmount + @Detal
        WHERE APK = @MaxProductID 
            AND MaterialTypeID = @MaterialTypeID 
            AND ExpenseID = 'COST003'               
            AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))    
    END
END
ELSE  -- Làm tròn MEKIO
IF (@CustomerName = 50 and @TotalPeriod - @PeriodDistribute - @PeriodNotDistribute = 0)
begin	

	SET @Detal = round(ISNULL(@ConvertedAmount, 0), @ConvertedDecimal) - ISNULL((SELECT SUM(ConvertedAmount) FROM MT0400  WITH (NOLOCK)
																				WHERE MaterialTypeID = @MaterialtypeID 
																					AND ExpenseID = 'COST003'
																					AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
																					AND TranMonth = @TranMonth AND TranYear = @TranYear), 0)	
																		- ISNULL((SELECT SUM(ConvertedAmount) 
                                                                            FROM MT0621 WITH(NOLOCK)
                                                                            WHERE MaterialTypeID = @MaterialtypeID 
                                                                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                                                                AND ExpenseID = 'COST003'), 0)

	IF @Detal<>0 
		BEGIN
		
			--- Lam tron
		SET @MaxProductID = (SELECT TOP 1 APK FROM MT0400  WITH (NOLOCK)
							WHERE ExpenseID ='COST003' AND MaterialTypeID = @MaterialTypeID 
								AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
								AND TranMonth = @TranMonth AND TranYear = @TranYear
							Order BY ConvertedAmount Desc)

			Update MT0400 SET ConvertedAmount = ConvertedAmount + @Detal
			WHERE APK = @MaxProductID AND MaterialTypeID = @MaterialTypeID AND ExpenseID = 'COST003'
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				AND TranMonth = @TranMonth AND TranYear = @TranYear
		END
end

-- SINH SỐ CHỨNG TỪ PHÂN BỔ TỰ ĐỘNG
DECLARE @Enabled1 TINYINT,
		@Enabled2 TINYINT,
		@Enabled3 TINYINT,
		@S1 NVARCHAR(50),
		@S2 NVARCHAR(50),
		@S3 NVARCHAR(50),
		@S1Type TINYINT,
		@S2Type TINYINT,
		@S3Type TINYINT,
		@VoucherNo NVARCHAR(50),
		@StringKey1 nvarchar(50),
		@StringKey2 nvarchar(50),
		@StringKey3 nvarchar(50), 
		@OutputLen int, 
		@OutputOrder int,
		@Separated int, 
		@Separator char(1),
		@ExpenseVoucherTypeID VARCHAR(50),
		@DistributeDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @ExpenseVoucherTypeID = (SELECT ISNULL(ExpenseVoucherTypeID,'PBO') FROM MT0000 WHERE DivisionID = @DivisionID)
SET @DistributeDescription = (SELECT ISNULL(DistributeDescription + ' ',N'Phân bổ chi phí ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END

--LẤY CHỈ SỐ TĂNG SỐ CHỨNG TỪ
Select	@Enabled1=Enabled1, @Enabled2=Enabled2, @Enabled3=Enabled3, @S1=S1, @S2=S2, @S3=S3, @S1Type=S1Type, @S2Type=S2Type, @S3Type=S3Type,
		@OutputLen=OutputLength, @OutputOrder=OutputOrder, @Separated=Separated, @Separator=Separator
From AT1007 WITH (NOLOCK) Where DivisionID = @DivisionID AND VoucherTypeID = @ExpenseVoucherTypeID

If @Enabled1 = 1
	SET @StringKey1 = 
	Case @S1Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S1
	Else '' End
Else
	SET @StringKey1 = ''

If @Enabled2 = 1
	SET @StringKey2 = 
	Case @S2Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S2
	Else '' End
Else
	SET @StringKey2 = ''

If @Enabled3 = 1
	SET @StringKey3 = 
	Case @S3Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S3
	Else '' End
Else
	SET @StringKey3 = ''

Recal:
--- SINH SỐ CHỨNG TỪ PHÂN BỔ
Exec AP0000  @DivisionID, @VoucherNo OUTPUT, 'MT0400', @StringKey1, @StringKey2, @StringKey3, @OutputLen, @OutputOrder, @Separated, @Separator

IF EXISTS (SELECT 1 FROM MT0400 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo)
	GOTO Recal

--INSERT VÀO BẢNG KẾT QUẢ PHÂN BỔ - MT0400
INSERT INTO MT0400 (ApportionCostID, PeriodID, MaterialQuantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID,ExpenseID, TranMonth, TranYear,
					Description, DivisionID, VoucherNo, VoucherDate, MaterialTypeID, VoucherTypeID, EmployeeID)

SELECT NEWID(), @PeriodID, Quantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID, ExpenseID, @TranMonth, @TranYear,
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID
FROM MT0621	
WHERE DivisionID = @DivisionID AND ExpenseID = 'COST003'  AND MaterialTypeID = @MaterialTypeID

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
