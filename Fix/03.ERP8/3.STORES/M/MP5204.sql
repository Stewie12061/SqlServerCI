IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5204]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP5204]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Hoang Thi Lan
--Date :10/11/2003
--Purpose:Phan bo chi phi Nhan cong theo NVL
-- Edit BY Quoc Hoai

--Edited BY: Vo Thanh Huong, date: 20/05/2005, Xu ly lam tron
/********************************************
'* Edited BY: [GS] [Thành Nguyên] [03/08/2010]
'********************************************/
--- Modified by Tiểu Mai on 22/01/2016: Fix bug phân bổ chưa đúng.
--- Modify on 25/02/2016 by Bảo Anh: Bỏ Where theo PeriodID cho MT2222 vì đã bổ sung where ở store MP5000
--- Modified by Bảo Thy on 24/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ
---- Modified by Đức Thông on 24/02/2021 [TOHO] [2020/12/IS/0526] Fix lỗi kết quả thành tiền trong phân bổ chi phí bị lệch với trong kết quả tập hợp chi phí
---- Modified by Nhựt Trường on 15/11/2021: Bổ sung điều kiện DivisionID khi lấy dữ liệu từ MT0621 insert vào MT0400.
		
CREATE PROCEDURE  [dbo].[MP5204] @DivisionID AS NVARCHAR(50),
				 @UserID VARCHAR(50),  
                 @PeriodID AS NVARCHAR(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS NVARCHAR(50)
AS 
DECLARE @sSQL AS NVARCHAR(4000), 
        @SUMProductCovalues AS DECIMAL(28, 8), 
        @QuantityUnit AS DECIMAL(28, 8), 
        @ProductCoValues AS DECIMAL(28, 8), 
        @ConvertedUnit AS DECIMAL(28, 8), 
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
        @UnitID AS NVARCHAR(50), @ApportionID AS NVARCHAR(50), 
        @SUMConvertedAmountH AS DECIMAL(28, 8), 
        @ProductHumanRes AS DECIMAL(28, 8), 
        @CoefficientID AS NVARCHAR(50), 
        @ConvertedDecimal INT

SET @ConvertedDecimal = (Select ConvertDecimal FROM MT0000 where DivisionID = @DivisionID)
---- Tong chi phi

---- Buoc 1. Xac dinh he so phan bo dua vao NVL da phan bo
SET @sSQL ='
SELECT MT0621.DivisionID, 
    MT0621.ProductID, 
    SUM(ConvertedUnit) AS ConvertedUnit, 
    MT2222.ProductQuantity, 
    MT2222.UnitID, 
    SUM(ConvertedUnit)*MT2222.ProductQuantity AS ProductCoValues
FROM MT0621 WITH (NOLOCK) FULL JOIN MT2222 WITH (NOLOCK) ON MT0621.DivisionID = MT2222.DivisionID AND MT0621.ProductID = MT2222.ProductID
WHERE ExpenseID = ''COST001''
	AND MT0621.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID('''+@DivisionID+'''))
GROUP BY MT0621.DivisionID, MT0621.ProductID, MT2222.UnitID, MT2222.ProductQuantity '

---- Tao VIEW he so chung can phan bo cho san pham
IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV5204' AND Xtype ='V')
    EXEC ('CREATE VIEW MV5204 AS '+@sSQL)
ELSE
    EXEC ('ALTER VIEW MV5204 AS '+@sSQL)
/*
--Tao  ra VIEW so 1

SET @sSQL='
SELECT     (CASE WHEN MT1605.InventoryID is NULL then MT2222.ProductID 
        ELSE MT1605.InventoryID END) AS ProductID, 
    ISNULL(CoValue, 0) AS  CoValue, 
    ISNULL(ProductQuantity, 0) AS ProductQuantity, 
     CoValue*ProductQuantity AS ProductCoValues 
FROM MT1605  FULL JOIN MT2222 ON MT2222.ProductID = MT1605.InventoryID
WHERE CoefficientID =N'''+@CoefficientID+''' '

IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'MV6204' AND Xtype ='V')
    EXEC ('CREATE VIEW MV6204 AS '+@sSQL)
ELSE
    EXEC ('ALTER VIEW MV6204 AS '+@sSQL)


--Duyet  tung mat hang
*/
SET @ConvertedAmount = (SELECT SUM(CASE D_C WHEN 'D' then ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END)
                        FROM MV9000 
                        WHERE PeriodID = @PeriodID AND ExpenseID ='COST002' AND MaterialTypeID =@MaterialTypeID
                            AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

SET @SUMProductCovalues = (SELECT SUM(ISNULL(ProductCovalues, 0)) FROM MV5204)

SET @ListProduct_cur = CURSOR SCROLL KEYSET FOR 
    SELECT ProductID, ProductQuantity, ProductCoValues
    FROM MV5204        
OPEN @ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @ProductQuantity, @ProductCoValues
            
WHILE @@Fetch_Status = 0
    BEGIN
        IF ISNULL(@SUMProductCoValues, 0) <> 0 AND ISNULL(@ProductQuantity, 0) <> 0
             SET  @ProductHumanRes = ((ISNULL(@ConvertedAmount, 0)/@SUMProductCovalues)*ISNULL(@ProductCoValues, 0))/@ProductQuantity        
        ELSE SET @ProductHumanRes = 0 

        IF @ProductHumanRes <> 0 AND ISNULL(@SUMProductCovalues, 0) <>0 
            INSERT MT0621 (DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit, MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate  )
            VALUES (@DivisionID, NULL, @ProductID, @UnitID, 'COST002', NULL, NULL, @MaterialTypeID, Round(((ISNULL(@ConvertedAmount, 0)/@SUMProductCovalues)*ISNULL(@ProductCoValues, 0)), @ConvertedDecimal), @ProductHumanRes, @ProductQuantity, NULL)
                
        FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @ProductQuantity, @ProductCoValues
    END
CLOSE @ListProduct_cur


---- Xu ly lam tron

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
					Description, DivisionID, VoucherNo, VoucherDate, MaterialTypeID, VoucherTypeID, EmployeeID)

SELECT NEWID(), @PeriodID, Quantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID, ExpenseID, @TranMonth, @TranYear,
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID
FROM MT0621	
WHERE ExpenseID = 'COST002'  AND MaterialTypeID = @MaterialTypeID
AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO