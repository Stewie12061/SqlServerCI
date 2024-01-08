IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8007_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP8007_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- CREATE BY Tiểu Mai on 12/01/2016
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- PURPOSE:     Tinh chi phi do dang dau ky theo PP lay tu doi tuong tap hop chi phi khac (Có thiết lập quản lý mặt hàng theo quy cách)
----        duoc goi tu store MP8001


CREATE PROCEDURE  [dbo].[MP8007_QC] @DivisionID AS nvarchar(50), 
				@UserID AS VARCHAR(50), 
                @PeriodID  nvarchar(50), 
                @TranMonth INT, 
                @TranYear INT,
				@VoucherNo NVARCHAR(50) 
AS

DECLARE @FromPeriodID AS nvarchar(50), 
     @LisProduct_Cur AS CURSOR, 
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
--print 'CPDDDKY 3'
IF @TranMonth >9
    SET @CMonth = ltrim(rtrim(str(@TranMonth)))
ELSE
    SET @CMonth = '0'+ltrim(rtrim(str(@TranMonth)))

SET @CYear =right(Ltrim(rtrim(str(@TranYear))), 2)

DELETE MT8899
FROM MT8899 
INNER JOIN MT1613 ON MT1613.DivisionID = MT8899.DivisionID AND MT1613.VoucherID = MT8899.VoucherID AND MT1613.TransactionID = MT8899.TransactionID AND MT8899.TableID = 'MT1613'
WHERE MT1613.DivisionID= @DivisionID AND PeriodID = @PeriodID AND TranMonth = @TranMonth AND  
        TranYear =@TranYear  AND Type ='B'

DELETE  FROM MT1613  WHERE DivisionID= @DivisionID AND PeriodID = @PeriodID AND TranMonth = @TranMonth AND  TranYear =@TranYear  AND Type ='B'     

EXEC AP0000 @DivisionID, @VoucherID  OUTPUT, 'MT1613', 'IV', @CMonth, @CYear, 16, 3, 0, '-'    

SET @FromPeriodID = (SELECT  FromPeriodID FROM MT1601 WHERE PeriodID = @PeriodID And DivisionID = @DivisionID)
---- Lay tu bang MT1613 roi INSERT vao bang MT1613
--print '@FromPeriodID '+@FromPeriodID

-- Lấy thông tin master cho MT1613
DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
		@UnfinishCostDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @UnfinishCostVoucherTypeID = (SELECT ISNULL(UnfinishCostVoucherTypeID,'CPDD') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @UnfinishCostDescription = (SELECT ISNULL(UnfinishCostDescription + ' ',N'Chi phí dở dang ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END

SET @LisProduct_Cur  = CURSOR SCROLL KEYSET FOR 
    SELECT     ProductID, 
            SUM(MaterialQuantity), --- So luong nguyen vat lieu do dang cho san pham
        SUM(ConvertedAmount), --- Tong chi phi do dang cho san pham
        MaterialID, 
        ExpenseID, 
        MaterialTypeID, 
        SUM(ProductQuantity), 
        ConvertedUnit, ProductUnitID, MaterialUnitID,
		MT1613.PS01ID, MT1613.PS02ID, MT1613.PS03ID, MT1613.PS04ID, MT1613.PS05ID, MT1613.PS06ID, MT1613.PS07ID, MT1613.PS08ID, MT1613.PS09ID, MT1613.PS10ID,
		MT1613.PS11ID, MT1613.PS12ID, MT1613.PS13ID, MT1613.PS14ID, MT1613.PS15ID, MT1613.PS16ID, MT1613.PS17ID, MT1613.PS18ID, MT1613.PS19ID, MT1613.PS20ID,
		MT8899.S01ID, MT8899.S02ID, MT8899.S03ID, MT8899.S04ID, MT8899.S05ID, MT8899.S06ID, MT8899.S07ID, MT8899.S08ID, MT8899.S09ID, MT8899.S10ID,
		MT8899.S11ID, MT8899.S12ID, MT8899.S13ID, MT8899.S14ID, MT8899.S15ID, MT8899.S16ID, MT8899.S17ID, MT8899.S18ID, MT8899.S19ID, MT8899.S20ID 
FROM MT1613
LEFT JOIN MT8899 ON MT8899.DivisionID = MT1613.DivisionID AND MT8899.VoucherID = MT1613.VoucherID AND MT1613.TransactionID = MT8899.TransactionID AND MT8899.TableID = 'MT1613'   
WHERE MT1613.DivisionID = @DivisionID  AND PeriodID =@FromPeriodID AND Type ='E'     --- TranMonth = @TranMonth AND TranYear = @TranYear   
GROUP BY ProductID, MaterialID, ExpenseID, MaterialTypeID, ConvertedUnit, ProductUnitID, MaterialUnitID,
		MT1613.PS01ID, MT1613.PS02ID, MT1613.PS03ID, MT1613.PS04ID, MT1613.PS05ID, MT1613.PS06ID, MT1613.PS07ID, MT1613.PS08ID, MT1613.PS09ID, MT1613.PS10ID,
		MT1613.PS11ID, MT1613.PS12ID, MT1613.PS13ID, MT1613.PS14ID, MT1613.PS15ID, MT1613.PS16ID, MT1613.PS17ID, MT1613.PS18ID, MT1613.PS19ID, MT1613.PS20ID,
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
		@UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE(), @UserID, GETDATE()  )
        
    INSERT INTO MT8899 (DivisionID, VoucherID, TableID, TransactionID, S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,
						S10ID,S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID)
    VALUES (@DivisionID, @VoucherID, 'MT1613', @TransactionID, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID)
        
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