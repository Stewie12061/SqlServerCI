IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5704_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP5704_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Phan bo chi phi SXC theo NVL (theo QC)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Gọi từ sp MP5704
-- <History>
----Created by: Trương Ngọc Phương Thảo, Date: 24/04/2018
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ
---- Modified by Đức Thông on 01/03/2021 [TOHO] [2020/12/IS/0526] Fix lỗi kết quả thành tiền trong phân bổ chi phí bị lệch với trong kết quả tập hợp chi phí
---- Modified by Đức Thông on 02/03/2021 [TOHO] [2020/12/IS/0526] Minor fix
-- <Example>
---- 
/*-- <Example>	
----*/

CREATE PROCEDURE [dbo].[MP5704_QC]  @DivisionID AS VARCHAR(50), 
				@UserID VARCHAR(50), 
                 @PeriodID AS VARCHAR(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS VARCHAR(50)
AS 
DECLARE        @sSQL AS VARCHAR(8000), 
        @SumProductCovalues AS DECIMAL(28, 8), 
        @QuantityUnit AS DECIMAL(28, 8), 
        @ProductCoValues AS DECIMAL(28, 8), 
        @ConvertedUnit AS DECIMAL(28, 8), 
        @ListMaterial_cur AS CURSOR, 
        @SumConvertedAmount AS DECIMAL(28, 8), 
        @MaterialID AS VARCHAR(50), 
        @ConvertedAmount AS DECIMAL(28, 8), 
        @MaterialQuantity AS DECIMAL(28, 8), 
        @ProductConvertedUnit AS DECIMAL(28, 8), 
        @MaterialQuantityUnit AS DECIMAL(28, 8), 
        @SumProductQuantity AS DECIMAL(28, 8), 
        @SumProductConverted AS DECIMAL(28, 8), 
        @MaterialConvertedUnit AS DECIMAL(28, 8), 
        @ListProduct_cur AS CURSOR, 
        @ProductID AS VARCHAR(50), 
        @ProductQuantity AS DECIMAL(28, 8), 
        @ProductQuantityUnit AS DECIMAL(28, 8), 
        @UnitID AS VARCHAR(50), @ApportionID AS VARCHAR(50), 
        @SumConvertedAmountH AS DECIMAL(28, 8), 
        @CoefficientID AS VARCHAR(50), 
        @ProductOthers AS DECIMAL(28, 8), 
        @ConvertedDecimal AS tinyint,  --- Bien lam tron
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

SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 where DivisionID = @DivisionID)
---- Tong chi phi

---- Buoc 1. Xac dinh he so phan bo dua vao NVL da phan bo
SET @sSQL ='
SELECT  MT0621.DivisionID, MT0621.ProductID, SUM(ConvertedUnit) AS ConvertedUnit, 
    MT2222.ProductQuantity, 
    MT2222.UnitID, 
    SUM(ConvertedUnit)*MT2222.ProductQuantity AS ProductCoValues,
	MT0621.PS01ID, MT0621.PS02ID, MT0621.PS03ID, MT0621.PS04ID, MT0621.PS05ID, MT0621.PS06ID, MT0621.PS07ID, MT0621.PS08ID, MT0621.PS09ID, MT0621.PS10ID,
	MT0621.PS11ID, MT0621.PS12ID, MT0621.PS13ID, MT0621.PS14ID, MT0621.PS15ID, MT0621.PS16ID, MT0621.PS17ID, MT0621.PS18ID, MT0621.PS19ID, MT0621.PS20ID
FROM MT0621 
Full JOIN MT2222 ON MT0621.ProductID = MT2222.ProductID AND MT0621.DivisionID = MT2222.DivisionID
AND ISNULL(MT0621.PS01ID,'''')  = ISNULL(MT2222.PS01ID,'''') AND ISNULL(MT0621.PS02ID,'''')  = ISNULL(MT2222.PS02ID,'''') AND ISNULL(MT0621.PS03ID,'''')  = ISNULL(MT2222.PS03ID,'''') AND ISNULL(MT0621.PS04ID,'''')  = ISNULL(MT2222.PS04ID,'''') AND ISNULL(MT0621.PS05ID,'''')  = ISNULL(MT2222.PS05ID,'''') 
AND ISNULL(MT0621.PS06ID,'''')  = ISNULL(MT2222.PS06ID,'''') AND ISNULL(MT0621.PS07ID,'''')  = ISNULL(MT2222.PS07ID,'''') AND ISNULL(MT0621.PS08ID,'''')  = ISNULL(MT2222.PS08ID,'''') AND ISNULL(MT0621.PS09ID,'''')  = ISNULL(MT2222.PS09ID,'''') AND ISNULL(MT0621.PS10ID,'''')  = ISNULL(MT2222.PS10ID,'''') 
AND ISNULL(MT0621.PS11ID,'''')  = ISNULL(MT2222.PS11ID,'''') AND ISNULL(MT0621.PS12ID,'''')  = ISNULL(MT2222.PS12ID,'''') AND ISNULL(MT0621.PS13ID,'''')  = ISNULL(MT2222.PS13ID,'''') AND ISNULL(MT0621.PS14ID,'''')  = ISNULL(MT2222.PS14ID,'''') AND ISNULL(MT0621.PS15ID,'''')  = ISNULL(MT2222.PS15ID,'''') 
AND ISNULL(MT0621.PS16ID,'''')  = ISNULL(MT2222.PS16ID,'''') AND ISNULL(MT0621.PS17ID,'''')  = ISNULL(MT2222.PS17ID,'''') AND ISNULL(MT0621.PS18ID,'''')  = ISNULL(MT2222.PS18ID,'''') AND ISNULL(MT0621.PS19ID,'''')  = ISNULL(MT2222.PS19ID,'''') AND ISNULL(MT0621.PS20ID,'''')  = ISNULL(MT2222.PS20ID,'''') 
WHERE ExpenseID = ''COST001'' AND MT0621.DivisionID = ''' + @DivisionID + '''
GROUP BY MT0621.DivisionID, MT0621.ProductID, MT2222.UnitID, MT2222.ProductQuantity,  
		MT0621.PS01ID, MT0621.PS02ID, MT0621.PS03ID, MT0621.PS04ID, MT0621.PS05ID, MT0621.PS06ID, MT0621.PS07ID, MT0621.PS08ID, MT0621.PS09ID, MT0621.PS10ID,
		MT0621.PS11ID, MT0621.PS12ID, MT0621.PS13ID, MT0621.PS14ID, MT0621.PS15ID, MT0621.PS16ID, MT0621.PS17ID, MT0621.PS18ID, MT0621.PS19ID, MT0621.PS20ID
'

---- Tao VIEW he so chung can phan bo cho san pham
IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV5704_QC' AND Xtype ='V')
    EXEC ('CREATE VIEW MV5704_QC AS '+@sSQL)
ELSE
    EXEC ('ALTER VIEW MV5704_QC AS '+@sSQL)
	

SET @ConvertedAmount=(SELECT SUM(Case D_C when 'D' then ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END)
						--SUM(ISNULL(ConvertedAmount,0))
                      FROM MV9000 WHERE      DivisionID =@DivisionID AND PeriodID = @PeriodID AND
                                        ExpenseID ='COST003' AND    MaterialTypeID =@MaterialTypeID )
										
SET @SumProductCovalues = (SELECT SUM(ISNULL(ProductCovalues, 0)) FROM MV5704_QC)
 
SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
    SELECT	ProductID, UnitID, ProductQuantity, ProductCoValues, 
			PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
			PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
    FROM MV5704_QC AS  MV5704      
OPEN    @ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO  @ProductID, @UnitID, @ProductQuantity, @ProductCoValues,
			@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
			@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
            
WHILE @@Fetch_Status = 0
    BEGIN        
        IF ISNULL(@SumProductCoValues, 0) <> 0 AND ISNULL(@ProductQuantity, 0) <> 0
            SET  @ProductOthers = ((ISNULL(@ConvertedAmount, 0)/@SumProductCovalues)*ISNULL(@ProductCoValues, 0))/@ProductQuantity        
        ELSE
            SET @ProductOthers= 0 

        IF @ProductOthers<>0
		BEGIN
			IF ISNULL(@SumProductCovalues, 0) <>0 
			BEGIN           
					INSERT MT0621 (	DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit, 
									MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate,
									PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
									PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)
					VALUES (@DivisionID, NULL, @ProductID, @UnitID, 'COST003', NULL, NULL, @MaterialTypeID, 
							round(((ISNULL(@ConvertedAmount, 0)/@SumProductCovalues)*ISNULL(@ProductCoValues, 0)), @ConvertedDecimal), @ProductOthers, @ProductQuantity, NULL,
							@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
							@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
							)
			END
		END
                
        FETCH NEXT FROM @ListProduct_cur INTO  @ProductID, @UnitID, @ProductQuantity, @ProductCoValues,
						@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
						@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
    END

CLOSE @ListProduct_cur

---- Xu ly lam tron

DECLARE @MaxProductID AS UNIQUEIDENTIFIER, 
    @Detal DECIMAL(28, 8)

SET @Detal = round(ISNULL(@ConvertedAmount, 0), @ConvertedDecimal) - ISNULL((SELECT SUM(ConvertedAmount) FROM MT0621 
                    WHERE  MaterialTypeID = @MaterialtypeID AND ExpenseID =  'COST003' ), 0)
IF @Detal<>0 
    BEGIN
        --- Lam tron
    SET @MaxProductID = (SELECT TOP 1 APK
        FROM MT0621 WHERE ExpenseID ='COST003' AND MaterialTypeID = @MaterialTypeID
        Order BY ConvertedAmount Desc)

        Update MT0621 SET ConvertedAmount = ConvertedAmount + @Detal
        WHERE     APK = @MaxProductID AND
            MaterialTypeID = @MaterialTypeID AND
            ExpenseID = 'COST003'
            
    
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
WHERE ExpenseID = 'COST003'  AND MaterialTypeID = @MaterialTypeID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

