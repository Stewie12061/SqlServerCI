IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5202_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP5202_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Phan bo chi phi Nhan cong theo PP he so (theo QC)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Gọi từ sp MP5202
-- <History>
----Created by: Trương Ngọc Phương Thảo, Date: 24/04/2018
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ
---- Modified by Đức Thông on 24/02/2021 [TOHO] [2020/12/IS/0526] Fix lỗi kết quả thành tiền trong phân bổ chi phí bị lệch với trong kết quả tập hợp chi phí
---- Modified by Viết Toàn on 11/08/2023 [MAITHU] [2023/08/IS/0118] Bỏ kiểm tra quy cách đối với MAITHU
-- <Example>
---- 
/*-- <Example>	
----*/

CREATE PROCEDURE [dbo].[MP5202_QC] 
                 @DivisionID AS NVARCHAR(50),
				 @UserID VARCHAR(50), 
				 @PeriodID AS NVARCHAR(50), 
                @TranMonth AS INT, @TranYear AS INT, 
                @MaterialTypeID AS NVARCHAR(50), 
                @CoefficientID AS NVARCHAR(50) 
AS 

DECLARE @sSQL AS NVARCHAR(max), 
    @SUMProductCovalues AS DECIMAL(28, 8), 
    @ListProduct_cur AS CURSOR, 
    @ProductID AS NVARCHAR(50), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @ProductCovalues AS DECIMAL(28, 8), 
    @ProductHumanRes AS DECIMAL(28, 8), 
    @MaterialID AS NVARCHAR(50), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @QuantityUnit AS DECIMAL(28, 8), 
    @ConvertedUnit AS DECIMAL(28, 8), 
    @UnitID AS VARCHAR(50), 
    @ConvertedAmount1 AS DECIMAL(28, 8), 
    @ConvertedDecimal AS TINYINT, --- Bien lam tron
	@CustomerName INT,
	@InProcessID Varchar(50),
	@ListPeriodID Varchar(50),
	@PS01ID	AS Varchar(50),
	@PS02ID	AS Varchar(50),
	@PS03ID	AS Varchar(50),
	@PS04ID	AS Varchar(50),
	@PS05ID	AS Varchar(50),
	@PS06ID	AS Varchar(50),
	@PS07ID	AS Varchar(50),
	@PS08ID	AS Varchar(50),
	@PS09ID	AS Varchar(50),
	@PS10ID	AS Varchar(50),
	@PS11ID	AS Varchar(50),
	@PS12ID	AS Varchar(50),
	@PS13ID	AS Varchar(50),
	@PS14ID	AS Varchar(50),
	@PS15ID	AS Varchar(50),
	@PS16ID	AS Varchar(50),
	@PS17ID	AS Varchar(50),
	@PS18ID	AS Varchar(50),
	@PS19ID	AS Varchar(50),
	@PS20ID AS Varchar(50)


--Tao  ra VIEW so 1
if(@CoefficientID = null)
	set @CoefficientID = ''

SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 WITH(NOLOCK) where DivisionID = @DivisionID)
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

CREATE TABLE #MP5202_QC (	DivisionID Varchar(50), ProductID Varchar(50), UnitID Varchar(50), CoValue decimal(28, 8), ProductQuantity decimal(28, 8), ProductCoValues decimal(28, 8), CoefficientID Varchar(50),
						S01ID Varchar(50), S02ID Varchar(50),	S03ID Varchar(50),	S04ID Varchar(50),	S05ID Varchar(50),	
						S06ID Varchar(50),	S07ID Varchar(50),	S08ID Varchar(50),	S09ID Varchar(50),	S10ID Varchar(50),
						S11ID Varchar(50),	S12ID Varchar(50),	S13ID Varchar(50),	S14ID Varchar(50),	S15ID Varchar(50),
						S16ID Varchar(50),	S17ID Varchar(50),	S18ID Varchar(50),	S19ID Varchar(50),	S20ID Varchar(50))

IF @CustomerName = 117
BEGIN
	INSERT INTO #MP5202_QC
	SELECT MT1605.DivisionID, 
		(CASE WHEN MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) AS ProductID, 
		MT2222.UnitID,
		ISNULL(CoValue, 0) AS  CoValue, 
		ISNULL(ProductQuantity, 0) AS ProductQuantity, 
		CoValue*ProductQuantity AS ProductCoValues,
		CoefficientID,
		MT8899.S01ID, MT8899.S02ID,	MT8899.S03ID,	MT8899.S04ID,	MT8899.S05ID,	
		MT8899.S06ID,	MT8899.S07ID,	MT8899.S08ID,	MT8899.S09ID,	MT8899.S10ID,
		MT8899.S11ID,	MT8899.S12ID,	MT8899.S13ID,	MT8899.S14ID,	MT8899.S15ID,	
		MT8899.S16ID,	MT8899.S17ID,	MT8899.S18ID,	MT8899.S19ID,	MT8899.S20ID
	FROM MT1605 WITH (NOLOCK)
	LEFT JOIN MT8899 WITH (NOLOCK) ON MT1605.DivisionID = MT8899.DivisionID AND MT1605.CoefficientID = MT8899.VoucherID AND MT1605.DeCoefficientID = MT8899.TransactionID AND MT8899.TableID = 'MT1605'
	FULL JOIN MT2222 WITH (NOLOCK) ON MT2222.DivisionID = MT1605.DivisionID AND MT2222.ProductID = MT1605.InventoryID 
	--AND ISNULL(MT8899.S01ID,'') = ISNULL(MT2222.PS01ID,'') AND ISNULL(MT8899.S02ID,'') = ISNULL(MT2222.PS02ID,'') AND ISNULL(MT8899.S03ID,'') = ISNULL(MT2222.PS03ID,'') AND ISNULL(MT8899.S04ID,'') = ISNULL(MT2222.PS04ID,'') AND ISNULL(MT8899.S05ID,'') = ISNULL(MT2222.PS05ID,'') 
	--AND ISNULL(MT8899.S06ID,'') = ISNULL(MT2222.PS06ID,'') AND ISNULL(MT8899.S07ID,'') = ISNULL(MT2222.PS07ID,'') AND ISNULL(MT8899.S08ID,'') = ISNULL(MT2222.PS08ID,'') AND ISNULL(MT8899.S09ID,'') = ISNULL(MT2222.PS09ID,'') AND ISNULL(MT8899.S10ID,'') = ISNULL(MT2222.PS10ID,'') 
	--AND ISNULL(MT8899.S11ID,'') = ISNULL(MT2222.PS11ID,'') AND ISNULL(MT8899.S12ID,'') = ISNULL(MT2222.PS12ID,'') AND ISNULL(MT8899.S13ID,'') = ISNULL(MT2222.PS13ID,'') AND ISNULL(MT8899.S14ID,'') = ISNULL(MT2222.PS14ID,'') AND ISNULL(MT8899.S15ID,'') = ISNULL(MT2222.PS15ID,'') 
	--AND ISNULL(MT8899.S16ID,'') = ISNULL(MT2222.PS16ID,'') AND ISNULL(MT8899.S17ID,'') = ISNULL(MT2222.PS17ID,'') AND ISNULL(MT8899.S18ID,'') = ISNULL(MT2222.PS18ID,'') AND ISNULL(MT8899.S19ID,'') = ISNULL(MT2222.PS19ID,'') AND ISNULL(MT8899.S20ID,'') = ISNULL(MT2222.PS20ID,'') 
	WHERE CoefficientID LIKE @CoefficientID AND
	MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
END
ELSE
BEGIN
	INSERT INTO #MP5202_QC
	SELECT MT1605.DivisionID, 
		(CASE WHEN MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) AS ProductID, 
		MT2222.UnitID,
		ISNULL(CoValue, 0) AS  CoValue, 
		ISNULL(ProductQuantity, 0) AS ProductQuantity, 
		CoValue*ProductQuantity AS ProductCoValues,
		CoefficientID,
		MT8899.S01ID, MT8899.S02ID,	MT8899.S03ID,	MT8899.S04ID,	MT8899.S05ID,	
		MT8899.S06ID,	MT8899.S07ID,	MT8899.S08ID,	MT8899.S09ID,	MT8899.S10ID,
		MT8899.S11ID,	MT8899.S12ID,	MT8899.S13ID,	MT8899.S14ID,	MT8899.S15ID,	
		MT8899.S16ID,	MT8899.S17ID,	MT8899.S18ID,	MT8899.S19ID,	MT8899.S20ID
	FROM MT1605 WITH (NOLOCK)
	LEFT JOIN MT8899 WITH (NOLOCK) ON MT1605.DivisionID = MT8899.DivisionID AND MT1605.CoefficientID = MT8899.VoucherID AND MT1605.DeCoefficientID = MT8899.TransactionID AND MT8899.TableID = 'MT1605'
	FULL JOIN MT2222 WITH (NOLOCK) ON MT2222.DivisionID = MT1605.DivisionID AND MT2222.ProductID = MT1605.InventoryID 
	AND ISNULL(MT8899.S01ID,'') = ISNULL(MT2222.PS01ID,'') AND ISNULL(MT8899.S02ID,'') = ISNULL(MT2222.PS02ID,'') AND ISNULL(MT8899.S03ID,'') = ISNULL(MT2222.PS03ID,'') AND ISNULL(MT8899.S04ID,'') = ISNULL(MT2222.PS04ID,'') AND ISNULL(MT8899.S05ID,'') = ISNULL(MT2222.PS05ID,'') 
	AND ISNULL(MT8899.S06ID,'') = ISNULL(MT2222.PS06ID,'') AND ISNULL(MT8899.S07ID,'') = ISNULL(MT2222.PS07ID,'') AND ISNULL(MT8899.S08ID,'') = ISNULL(MT2222.PS08ID,'') AND ISNULL(MT8899.S09ID,'') = ISNULL(MT2222.PS09ID,'') AND ISNULL(MT8899.S10ID,'') = ISNULL(MT2222.PS10ID,'') 
	AND ISNULL(MT8899.S11ID,'') = ISNULL(MT2222.PS11ID,'') AND ISNULL(MT8899.S12ID,'') = ISNULL(MT2222.PS12ID,'') AND ISNULL(MT8899.S13ID,'') = ISNULL(MT2222.PS13ID,'') AND ISNULL(MT8899.S14ID,'') = ISNULL(MT2222.PS14ID,'') AND ISNULL(MT8899.S15ID,'') = ISNULL(MT2222.PS15ID,'') 
	AND ISNULL(MT8899.S16ID,'') = ISNULL(MT2222.PS16ID,'') AND ISNULL(MT8899.S17ID,'') = ISNULL(MT2222.PS17ID,'') AND ISNULL(MT8899.S18ID,'') = ISNULL(MT2222.PS18ID,'') AND ISNULL(MT8899.S19ID,'') = ISNULL(MT2222.PS19ID,'') AND ISNULL(MT8899.S20ID,'') = ISNULL(MT2222.PS20ID,'') 
	WHERE CoefficientID LIKE @CoefficientID AND
	MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
END


SET @ConvertedAmount =(SELECT SUM(CASE D_C WHEN 'D' then ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) 
							FROM MV9000 WHERE PeriodID = @PeriodID 								
								AND ExpenseID ='COST002' AND MaterialTypeID = @MaterialTypeID
								AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

SET @SUMProductCovalues = (SELECT SUM(ISNULL(ProductCovalues, 0)) FROM #MP5202_QC)

SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
SELECT	ProductID, UnitID, ProductQuantity, ProductCoValues,
		S01ID, S02ID,	S03ID,	S04ID,	S05ID,	S06ID,	S07ID,	S08ID,	S09ID,	S10ID,
		S11ID,	S12ID,	S13ID,	S14ID,	S15ID,	S16ID,	S17ID,	S18ID,	S19ID,	S20ID
FROM #MP5202_QC  WHERE CoefficientID = @CoefficientID  AND ProductQuantity <> 0   	 
OPEN @ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @UnitID, @ProductQuantity, @ProductCoValues ,
        @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
		@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
WHILE @@Fetch_Status = 0
    BEGIN        
        IF ISNULL(@SUMProductCoValues, 0) <> 0 AND ISNULL(@ProductQuantity, 0) <> 0
             SET  @ProductHumanRes = ((ISNULL(@ConvertedAmount, 0)/@SUMProductCovalues)*ISNULL(@ProductCoValues, 0))/@ProductQuantity        
        ELSE SET @ProductHumanRes = 0 
        
        SET @ProductHumanRes = round(@ProductHumanRes, @ConvertedDecimal)               

        IF ISNULL(@SUMProductCovalues, 0) <>0 
             SET @ConvertedAmount1 = round((ISNULL(@ConvertedAmount, 0)*ISNULL(@ProductCoValues, 0)/@SUMProductCovalues), @ConvertedDecimal)
        ELSE SET @ConvertedAmount1 = 0 

        INSERT MT0621 (	DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit, 
						MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate,
						PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
						PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)
        VALUES (@DivisionID, NULL, @ProductID, @UnitID, 'COST002', NULL, NULL,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
				@MaterialTypeID, @ConvertedAmount1, @ProductHumanRes, @ProductQuantity, NULL,
				@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
				@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
				)
        
        FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @UnitID, @ProductQuantity, @ProductCoValues,
		@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
		@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
    END

CLOSE @ListProduct_cur


-- Xu ly lam tron
DECLARE @MaxProductID AS NVARCHAR(50), 
    @Detal DECIMAL(28, 8)
	

SET @Detal = round(ISNULL(@ConvertedAmount, 0), @ConvertedDecimal) - ISNULL((SELECT SUM(ConvertedAmount) FROM MT0621  WITH (NOLOCK)
                                                                            WHERE MaterialTypeID = @MaterialtypeID 
                                                                                AND ExpenseID = 'COST002'
                                                                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))), 0)
IF @Detal<>0 
    BEGIN
        --- Lam tron
    SET @MaxProductID = (SELECT TOP 1 APK FROM MT0621  WITH (NOLOCK)
                        WHERE ExpenseID ='COST002' AND MaterialTypeID = @MaterialTypeID 
                            AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                        Order BY ConvertedAmount Desc)

        Update MT0621 SET ConvertedAmount = ConvertedAmount + @Detal
        WHERE APK = @MaxProductID AND MaterialTypeID = @MaterialTypeID AND ExpenseID = 'COST002'
            AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
    END

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
					Description, DivisionID, VoucherNo, VoucherDate, MaterialTypeID, VoucherTypeID, EmployeeID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)

SELECT NEWID(), @PeriodID, Quantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID, ExpenseID, @TranMonth, @TranYear,
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
FROM MT0621	
WHERE ExpenseID = 'COST002'  AND MaterialTypeID = @MaterialTypeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

