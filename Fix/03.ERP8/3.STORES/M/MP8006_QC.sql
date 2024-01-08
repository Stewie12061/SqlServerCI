IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8006_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8006_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- CREATE BY Tiểu Mai on 12/01/2016
---- PURPOSE:     Tinh chi phi do dang dau ky cho PP cap nhat bang tay. (Có thiết lập quản lý hàng theo quy cách.)
----        duoc goi tu store MP8001
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

CREATE PROCEDURE  [dbo].[MP8006_QC] 
                @DivisionID AS nvarchar(50),
				@UserID AS VARCHAR(50),  
                @PeriodID  nvarchar(50), 
                @TranMonth INT, 
                @TranYear INT,
				@VoucherNo NVARCHAR(50)  

AS
DECLARE @LisProduct_Cur AS CURSOR, 
    @VoucherID AS nvarchar(50), 
    @TransactionID AS nvarchar(50), 
    @CMonth AS nvarchar(20), 
    @CYear AS nvarchar(20), 
    @ProductID AS nvarchar(50), 
    @WipQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @MaterialID AS nvarchar(50), 
    @ExpenseID AS nvarchar(50), 
    @MaterialTypeID AS nvarchar(50), 
    @MaterialUnitID AS nvarchar(50), 
    @ProductUnitID AS nvarchar(50), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @ConvertedUnit AS DECIMAL(28, 8),
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
    @PS20ID NVARCHAR(50),
    @S01ID NVARCHAR(50),
    @S02ID NVARCHAR(50),
    @S03ID NVARCHAR(50),
    @S04ID NVARCHAR(50),
    @S05ID NVARCHAR(50),
    @S06ID NVARCHAR(50),
    @S07ID NVARCHAR(50),
    @S08ID NVARCHAR(50),
    @S09ID NVARCHAR(50),
    @S10ID NVARCHAR(50),
    @S11ID NVARCHAR(50),
    @S12ID NVARCHAR(50),
    @S13ID NVARCHAR(50),
    @S14ID NVARCHAR(50),
    @S15ID NVARCHAR(50),
    @S16ID NVARCHAR(50),
    @S17ID NVARCHAR(50),
    @S18ID NVARCHAR(50),
    @S19ID NVARCHAR(50),
    @S20ID NVARCHAR(50)

---- Lay tu bang MT1612 roi INSERT vao bang MT1613
--print 'Chp DD DKY 2'
IF @TranMonth >9
    SET @CMonth = ltrim(rtrim(str(@TranMonth)))
ELSE
    SET @CMonth = '0'+ltrim(rtrim(str(@TranMonth)))

SET @CYear =right(Ltrim(rtrim(str(@TranYear))), 2)


EXEC AP0000 @DivisionID, @VoucherID  OUTPUT, 'MT1613', 'IV', @CMonth, @CYear, 16, 3, 0, '-'    

DELETE MT8899
FROM MT8899 
INNER JOIN MT1613 WITH (NOLOCK) ON MT1613.DivisionID = MT8899.DivisionID AND MT1613.VoucherID = MT8899.VoucherID AND MT1613.TransactionID = MT8899.TransactionID AND MT8899.TableID = 'MT1613'
WHERE MT1613.DivisionID= @DivisionID AND PeriodID = @PeriodID AND TranMonth = @TranMonth AND  
        TranYear =@TranYear  AND Type ='B'
        
DELETE  FROM MT1613  WHERE DivisionID= @DivisionID AND PeriodID = @PeriodID AND TranMonth = @TranMonth AND  
        TranYear =@TranYear  AND Type ='B'
  
 -- Lấy thông tin master cho MT1613
DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
		@UnfinishCostDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @UnfinishCostVoucherTypeID = (SELECT ISNULL(UnfinishCostVoucherTypeID,'CPDD') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @UnfinishCostDescription = (SELECT ISNULL(UnfinishCostDescription + ' ',N'Chi phí dở dang ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END
 
              
SET @LisProduct_Cur  = CURSOR SCROLL KEYSET FOR 
    SELECT     ProductID,
            SUM(ISNULL(WipQuantity, 0)), --- So luong nguyen vat lieu do dang cho san pham
        SUM(ISNULL(ConvertedAmount, 0)), --- Tong chi phi do dang cho san pham
        MaterialID, 
        ExpenseID, 
        MaterialTypeID, 
        SUM(ISNULL(ProductQuantity, 0)), 
        ConvertedUnit, 
        AT1302_P.UnitID AS ProductUnitID, 
        AT1302_M.UnitID AS MaterialUnitID,
		MT1612.PS01ID, MT1612.PS02ID, MT1612.PS03ID, MT1612.PS04ID, MT1612.PS05ID, MT1612.PS06ID, MT1612.PS07ID, MT1612.PS08ID, MT1612.PS09ID, MT1612.PS10ID,
		MT1612.PS11ID, MT1612.PS12ID, MT1612.PS13ID, MT1612.PS14ID, MT1612.PS15ID, MT1612.PS16ID, MT1612.PS17ID, MT1612.PS18ID, MT1612.PS19ID, MT1612.PS20ID,
		MT8899.S01ID, MT8899.S02ID, MT8899.S03ID, MT8899.S04ID, MT8899.S05ID, MT8899.S06ID, MT8899.S07ID, MT8899.S08ID, MT8899.S09ID, MT8899.S10ID,
		MT8899.S11ID, MT8899.S12ID, MT8899.S13ID, MT8899.S14ID, MT8899.S15ID, MT8899.S16ID, MT8899.S17ID, MT8899.S18ID, MT8899.S19ID, MT8899.S20ID
FROM MT1612 WITH (NOLOCK) 
		LEFT JOIN  AT1302 AT1302_P WITH (NOLOCK) ON MT1612.ProductID = AT1302_P.InventoryID AND AT1302_P.DivisionID IN (MT1612.DivisionID,'@@@')
        LEFT JOIN AT1302 AT1302_M WITH (NOLOCK) ON MT1612.MaterialID = AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MT1612.DivisionID,'@@@')
        LEFT JOIN MT8899 WITH (NOLOCK) ON MT8899.DivisionID = MT1612.DivisionID AND MT8899.VoucherID = MT1612.VoucherID AND MT1612.WipVoucherID = MT8899.TransactionID AND MT8899.TableID = 'MT1612'
WHERE MT1612.DivisionID = @DivisionID  
    AND PeriodID =@PeriodID AND TranMonth = @TranMonth AND TranYear = @TranYear    AND Type = 'B'
GROUP BY ProductID, 
		MaterialID, ExpenseID, MaterialTypeID, ConvertedUnit, AT1302_P.UnitID, AT1302_M.UnitID, 
		MT1612.PS01ID, MT1612.PS02ID, MT1612.PS03ID, MT1612.PS04ID, MT1612.PS05ID, MT1612.PS06ID, MT1612.PS07ID, MT1612.PS08ID, MT1612.PS09ID, MT1612.PS10ID,
		MT1612.PS11ID, MT1612.PS12ID, MT1612.PS13ID, MT1612.PS14ID, MT1612.PS15ID, MT1612.PS16ID, MT1612.PS17ID, MT1612.PS18ID, MT1612.PS19ID, MT1612.PS20ID,
		MT8899.S01ID, MT8899.S02ID, MT8899.S03ID, MT8899.S04ID, MT8899.S05ID, MT8899.S06ID, MT8899.S07ID, MT8899.S08ID, MT8899.S09ID, MT8899.S10ID,
		MT8899.S11ID, MT8899.S12ID, MT8899.S13ID, MT8899.S14ID, MT8899.S15ID, MT8899.S16ID, MT8899.S17ID, MT8899.S18ID, MT8899.S19ID, MT8899.S20ID

OPEN @LisProduct_Cur 
FETCH NEXT FROM @LisProduct_Cur INTO  @ProductID, @WipQuantity, @ConvertedAmount, @MaterialID, 
    @ExpenseID, @MaterialTypeID, @ProductQuantity, @ConvertedUnit, @ProductUnitID, @MaterialUnitID,
    @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
    @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
    @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
    @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
WHILE @@Fetch_Status = 0
BEGIN            
    EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'
    
    INSERT into MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
        ProductID, MaterialID, ExpenseID, MaterialTypeID, 
        ProductUnitID, 
        MaterialUnitID, MaterialQuantity, ConvertedAmount, ProductQuantity, 
        ConvertedUnit, TYPE, 
        PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
		PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID,
		VoucherTypeID, VoucherNo, VoucherDate, EmployeeID, Description, LastModifyUserID, LastModifyDate, CreateUserID, CreateDate )
    VALUES ( @PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
        @ProductID, @MaterialID, @ExpenseID, @MaterialTypeID, 
        @ProductUnitID, 
        @MaterialUnitID, @WipQuantity, @ConvertedAmount, @ProductQuantity, 
        @ConvertedUnit, 'B',
		@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
		@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
		@UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE(), @UserID, GETDATE())
        
    INSERT INTO MT8899 (DivisionID, VoucherID, TableID, TransactionID, S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,
						S10ID,S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID)
    VALUES (@DivisionID, @VoucherID, 'MT1613', @TransactionID, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
			  )    
        
    FETCH NEXT FROM @LisProduct_Cur INTO  @ProductID, @WipQuantity, @ConvertedAmount, @MaterialID, 
            @ExpenseID, @MaterialTypeID, @ProductQuantity, @ConvertedUnit, @ProductUnitID, @MaterialUnitID,
			@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
			@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
			@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
