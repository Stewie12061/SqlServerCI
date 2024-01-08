IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP6203]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP6203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created BY  Tiểu Mai
----- Created Date 31/12/2015
----- Purpose: Phan bo chi phi nhan cong theo PP dinh muc cho san pham theo quy cach
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ


CREATE PROCEDURE  [dbo].[MP6203]     @DivisionID AS NVARCHAR(50), 
					@UserID VARCHAR(50), 
                    @PeriodID AS NVARCHAR(50), 
                    @TranMonth AS INT, 
                    @TranYear AS INT, 
                    @MaterialTypeID AS NVARCHAR(50), 
                    @ApportionID AS NVARCHAR(50)

AS

DECLARE @sSQL AS NVARCHAR(4000), 
        @ListMaterial_cur AS CURSOR, 
        @SUMConvertedAmount AS DECIMAL(28, 8), 
        @MaterialID AS NVARCHAR(50), 
        @ConvertedAmount AS DECIMAL(28, 8), 
        @MaterialQuantity AS DECIMAL(28, 8), 
        @ProductConvertedUnit AS DECIMAL(28, 8), 
        @MaterialQuantityUnit AS DECIMAL(28, 8), 
        @SUMProductQuantity AS DECIMAL(28, 8), 
        @SUMProductConverted AS DECIMAL(28, 8), 
        @MaterialConvertedUnit AS DECIMAL(28, 8), 
        @ListProduct_cur AS CURSOR, 
        @ProductID AS NVARCHAR(50), 
        @ProductQuantity AS DECIMAL(28, 8), 
        @ProductQuantityUnit AS DECIMAL(28, 8), 
        @UnitID AS NVARCHAR(50), 
        @ConvertedUnit AS DECIMAL(28, 8), 
        @ConvertedDecimal INT,
        @PS01ID NVARCHAR(50),
        @PS02ID NVARCHAR(50),
        @PS03ID NVARCHAR(50),
        @PS04ID NVARCHAR(50),
        @PS05ID NVARCHAR(50),
        @PS06ID NVARCHAR(50),
        @PS07ID NVARCHAR(50),
        @PS08ID NVARCHAR(50),
        @PS09ID NVARCHAR(50),
        @PS10ID NVARCHAR(50),
        @PS11ID NVARCHAR(50),
        @PS12ID NVARCHAR(50),
        @PS13ID NVARCHAR(50),
        @PS14ID NVARCHAR(50),
        @PS15ID NVARCHAR(50),
        @PS16ID NVARCHAR(50),
        @PS17ID NVARCHAR(50),
        @PS18ID NVARCHAR(50),
        @PS19ID NVARCHAR(50),
        @PS20ID NVARCHAR(50)

SET @ConvertedDecimal = (SELECT ConvertDecimal FROM MT0000 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))
---- Tong chi phi
 SET @SUMConvertedAmount = (SELECT SUM(CASE D_C WHEN 'D' then ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) 
                            FROM MV9000 
                            WHERE ExpenseID ='COST002' AND PeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID
                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

---- Xac dinh tong he so chung

	SET @SUMProductConverted = (SELECT SUM(ISNULL(ConvertedUnit, 0)*ISNULL(MT2222.ProductQuantity, 0))
								FROM MT0136
								LEFT JOIN MT0137 ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ProductID = MT0136.ProductID AND MT0137.ReTransactionID = MT0136.TransactionID
								INNER JOIN MT2222 ON MT2222.DivisionID = MT0136.DivisionID AND MT2222.ProductID = MT0136.ProductID AND 
											ISNULL(MT0136.S01ID,'') = ISNULL(MT2222.PS01ID,'') AND
											ISNULL(MT0136.S02ID,'') = ISNULL(MT2222.PS02ID,'') AND
											ISNULL(MT0136.S03ID,'') = ISNULL(MT2222.PS03ID,'') AND
											ISNULL(MT0136.S04ID,'') = ISNULL(MT2222.PS04ID,'') AND
											ISNULL(MT0136.S05ID,'') = ISNULL(MT2222.PS05ID,'') AND
											ISNULL(MT0136.S06ID,'') = ISNULL(MT2222.PS06ID,'') AND
											ISNULL(MT0136.S07ID,'') = ISNULL(MT2222.PS07ID,'') AND
											ISNULL(MT0136.S08ID,'') = ISNULL(MT2222.PS08ID,'') AND
											ISNULL(MT0136.S09ID,'') = ISNULL(MT2222.PS09ID,'') AND
											ISNULL(MT0136.S10ID,'') = ISNULL(MT2222.PS10ID,'') AND
											ISNULL(MT0136.S11ID,'') = ISNULL(MT2222.PS11ID,'') AND
											ISNULL(MT0136.S12ID,'') = ISNULL(MT2222.PS12ID,'') AND
											ISNULL(MT0136.S13ID,'') = ISNULL(MT2222.PS13ID,'') AND
											ISNULL(MT0136.S14ID,'') = ISNULL(MT2222.PS14ID,'') AND
											ISNULL(MT0136.S15ID,'') = ISNULL(MT2222.PS15ID,'') AND
											ISNULL(MT0136.S16ID,'') = ISNULL(MT2222.PS16ID,'') AND
											ISNULL(MT0136.S17ID,'') = ISNULL(MT2222.PS17ID,'') AND
											ISNULL(MT0136.S18ID,'') = ISNULL(MT2222.PS18ID,'') AND
											ISNULL(MT0136.S19ID,'') = ISNULL(MT2222.PS19ID,'') AND
											ISNULL(MT0136.S20ID,'') = ISNULL(MT2222.PS20ID,'')		
								WHERE ApportionID = @ApportionID AND ExpenseID = 'COST002' AND MaterialTypeID = @MaterialTypeID
									AND MT2222.PeriodID = @PeriodID
									AND MT0136.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

	SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR 
	SELECT MT0136.ProductID, ISNULL(ConvertedUnit, 0)*ISNULL(MT2222.ProductQuantity, 0), MT2222.ProductQuantity, MT2222.UnitID,
		    MT0136.S01ID, MT0136.S02ID, MT0136.S03ID, MT0136.S04ID, MT0136.S05ID, MT0136.S06ID, MT0136.S07ID, MT0136.S08ID, MT0136.S09ID, MT0136.S10ID,
		    MT0136.S11ID, MT0136.S12ID, MT0136.S13ID, MT0136.S14ID, MT0136.S15ID, MT0136.S16ID, MT0136.S17ID, MT0136.S18ID, MT0136.S19ID, MT0136.S20ID
	FROM MT0136
	LEFT JOIN MT0137 ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ProductID = MT0136.ProductID AND MT0137.ReTransactionID = MT0136.TransactionID
	INNER JOIN MT2222 ON MT2222.DivisionID = MT0136.DivisionID AND MT2222.ProductID = MT0136.ProductID AND 
				ISNULL(MT0136.S01ID,'') = ISNULL(MT2222.PS01ID,'') AND
				ISNULL(MT0136.S02ID,'') = ISNULL(MT2222.PS02ID,'') AND
				ISNULL(MT0136.S03ID,'') = ISNULL(MT2222.PS03ID,'') AND
				ISNULL(MT0136.S04ID,'') = ISNULL(MT2222.PS04ID,'') AND
				ISNULL(MT0136.S05ID,'') = ISNULL(MT2222.PS05ID,'') AND
				ISNULL(MT0136.S06ID,'') = ISNULL(MT2222.PS06ID,'') AND
				ISNULL(MT0136.S07ID,'') = ISNULL(MT2222.PS07ID,'') AND
				ISNULL(MT0136.S08ID,'') = ISNULL(MT2222.PS08ID,'') AND
				ISNULL(MT0136.S09ID,'') = ISNULL(MT2222.PS09ID,'') AND
				ISNULL(MT0136.S10ID,'') = ISNULL(MT2222.PS10ID,'') AND
				ISNULL(MT0136.S11ID,'') = ISNULL(MT2222.PS11ID,'') AND
				ISNULL(MT0136.S12ID,'') = ISNULL(MT2222.PS12ID,'') AND
				ISNULL(MT0136.S13ID,'') = ISNULL(MT2222.PS13ID,'') AND
				ISNULL(MT0136.S14ID,'') = ISNULL(MT2222.PS14ID,'') AND
				ISNULL(MT0136.S15ID,'') = ISNULL(MT2222.PS15ID,'') AND
				ISNULL(MT0136.S16ID,'') = ISNULL(MT2222.PS16ID,'') AND
				ISNULL(MT0136.S17ID,'') = ISNULL(MT2222.PS17ID,'') AND
				ISNULL(MT0136.S18ID,'') = ISNULL(MT2222.PS18ID,'') AND
				ISNULL(MT0136.S19ID,'') = ISNULL(MT2222.PS19ID,'') AND
				ISNULL(MT0136.S20ID,'') = ISNULL(MT2222.PS20ID,'')		
	WHERE ApportionID = @ApportionID AND ExpenseID = 'COST002' AND MaterialTypeID = @MaterialTypeID
		AND MT2222.PeriodID = @PeriodID   
		AND MT0136.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
 
	OPEN @ListMaterial_cur 
	FETCH NEXT FROM @ListMaterial_cur INTO @ProductID, @ProductConvertedUnit, @ProductQuantity, @UnitID, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										   @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID  
	WHILE @@Fetch_Status = 0
		BEGIN    
			IF ISNULL(@SUMProductConverted, 0)<>0
				 SET @MaterialConvertedUnit = round((ISNULL(@SUMConvertedAmount, 0)/@SUMProductConverted)*ISNULL(@ProductConvertedUnit, 0), @ConvertedDecimal)
			ELSE SET @MaterialConvertedUnit = 0
			IF ISNULL(@ProductQuantity, 0)<>0 
				 SET @ConvertedUnit = ISNULL(@MaterialConvertedUnit, 0)/@ProductQuantity
			ELSE SET @ConvertedUnit = 0
        
			INSERT MT0621 (DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit, MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate,
						   PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
						   PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)
			VALUES (@DivisionID, NULL, @ProductID, @UnitID, 'COST002', NULL, NULL, @MaterialTypeID, @MaterialConvertedUnit, @ConvertedUnit, @ProductQuantity, NULL,
					@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
					@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID)
    
			FETCH NEXT FROM @ListMaterial_cur INTO @ProductID, @ProductConvertedUnit, @ProductQuantity, @UnitID, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										   @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID   
		END            
	CLOSE @ListMaterial_cur

---- Xu ly lam tron

	DECLARE @MaxProductID AS NVARCHAR(50), 
			@Detal DECIMAL(28, 8)

	SET @Detal = round(ISNULL(@SUMConvertedAmount, 0), @ConvertedDecimal) - ISNULL((SELECT SUM(ConvertedAmount) FROM MT0621 
																					WHERE MaterialTypeID = @MaterialtypeID 
																						AND ExpenseID = 'COST002'
																						AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))), 0)
	IF @Detal<>0 
		BEGIN
			--- Lam tron
		SET @MaxProductID = (SELECT TOP 1 APK FROM MT0621 
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
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, 
				@PS07ID, @PS08ID, @PS09ID, @PS10ID, @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
FROM MT0621	
WHERE ExpenseID = 'COST002'  AND MaterialTypeID = @MaterialTypeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO