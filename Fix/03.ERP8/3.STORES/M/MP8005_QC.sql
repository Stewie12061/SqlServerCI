IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8005_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8005_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by Tiểu Mai 
--Date 14/01/2016
--Purpose :Tính giá thành sản phẩm theo thiết lập quản lý quy cách hàng hóa.
--Modified by Viết Toàn on [11/08/2023]: Bỏ check quy cách khi tính giá thành - Customize MAITHU


CREATE PROCEDURE [dbo].[MP8005_QC] 
    @DivisionID NVARCHAR(50), 
    @PeriodID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT
AS

DECLARE 
    @BeginningInprocessCost DECIMAL(28, 8), 
    @EndInprocessCost DECIMAL(28, 8), 
    @AriseCost DECIMAL(28, 8), 
    @ProductQuantity DECIMAL(28, 8), 
    @Cost DECIMAL(28, 8), 
    @CostUnit DECIMAL(28, 8), 
    @ProductID NVARCHAR(50), 
    @LisProduct_Cur CURSOR, 
    @CMonth NVARCHAR(20), 
    @CYear NVARCHAR(20), 
    @VoucherID NVARCHAR(50), 
    @TransactionID NVARCHAR(50), 
    @Cost621 DECIMAL(28, 8), 
    @Cost622 DECIMAL(28, 8), 
    @Cost627 DECIMAL(28, 8), 
    @BCost621 DECIMAL(28, 8), 
    @ICost621 DECIMAL(28, 8), 
    @ECost621 DECIMAL(28, 8), 
    @BCost622 DECIMAL(28, 8), 
    @ICost622 DECIMAL(28, 8), 
    @ECost622 DECIMAL(28, 8), 
    @BCost627 DECIMAL(28, 8), 
    @ICost627 DECIMAL(28, 8), 
    @ECost627 DECIMAL(28, 8),
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT, 
    @ConvertedDecimals TINYINT,
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
	@CustomerName INT

SELECT	@QuantityDecimals = QuantityDecimal, 
		@UnitCostDecimals = UnitPriceDecimal, 
		@ConvertedDecimals = ConvertDecimal
FROM MT0000
WHERE DivisionID =@DivisionID

SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)

IF @TranMonth > 9
    SET @CMonth = LTRIM(RTRIM(STR(@TranMonth)))
ELSE
    SET @CMonth = '0' + LTRIM(RTRIM(STR(@TranMonth)))

SET @CYear = RIGHT(LTRIM(RTRIM(STR(@TranYear))), 2)

DELETE FROM MT1614 WHERE PeriodID = @PeriodID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))

EXEC AP0000 @DivisionID, @VoucherID OUTPUT, 'MT1614', 'IV', @CMonth, @CYear, 16, 3, 0, '-' 

SET @LisProduct_Cur = CURSOR SCROLL KEYSET FOR 
    SELECT ProductID, SUM(ISNULL(Quantity, 0)),
    O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
    O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
    FROM MT1001
    INNER JOIN MT0810 ON MT0810.DivisionID = MT1001.DivisionID AND MT1001.VoucherID = MT0810.VoucherID
    LEFT JOIN MT8899 O99 ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
    WHERE MT0810.PeriodID = @PeriodID 
    AND MT1001.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
    AND MT0810.ResultTypeID = 'R01' --- Thanh pham nhap kho
    GROUP BY ProductID,
    O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
    O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID

OPEN @LisProduct_Cur 
FETCH NEXT FROM @LisProduct_Cur INTO @ProductID, @ProductQuantity, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
									@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID 
WHILE @@Fetch_Status = 0
    BEGIN 
		IF @CustomerName = 117
		BEGIN
			--Bước 1:Lấy chi phí dở dang đầu kỳ
			SELECT 
				@BeginningInprocessCost = SUM(ConvertedAmount), 
				@BCost621 = SUM(CASE WHEN ExpenseID = 'COST001' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@BCost622 = SUM(CASE WHEN ExpenseID = 'COST002' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@BCost627 = SUM(CASE WHEN ExpenseID = 'COST003' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) 
			FROM MT1613
			WHERE PeriodID = @PeriodID 
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
				AND ProductID = @ProductID 
				AND Type = 'B' --- Chi phi dau ky
				--AND ISNULL(MT1613.PS01ID,'') = ISNULL(@PS01ID,'') 
				--AND ISNULL(MT1613.PS02ID,'') = ISNULL(@PS02ID,'') 
				--AND ISNULL(MT1613.PS03ID,'') = ISNULL(@PS03ID,'') 
				--AND ISNULL(MT1613.PS04ID,'') = ISNULL(@PS04ID,'') 
				--AND ISNULL(MT1613.PS05ID,'') = ISNULL(@PS05ID,'') 
				--AND ISNULL(MT1613.PS06ID,'') = ISNULL(@PS06ID,'') 
				--AND ISNULL(MT1613.PS07ID,'') = ISNULL(@PS07ID,'') 
				--AND ISNULL(MT1613.PS08ID,'') = ISNULL(@PS08ID,'') 
				--AND ISNULL(MT1613.PS09ID,'') = ISNULL(@PS09ID,'') 
				--AND ISNULL(MT1613.PS10ID,'') = ISNULL(@PS10ID,'') 
				--AND ISNULL(MT1613.PS11ID,'') = ISNULL(@PS11ID,'') 
				--AND ISNULL(MT1613.PS12ID,'') = ISNULL(@PS12ID,'') 
				--AND ISNULL(MT1613.PS13ID,'') = ISNULL(@PS13ID,'') 
				--AND ISNULL(MT1613.PS14ID,'') = ISNULL(@PS14ID,'') 
				--AND ISNULL(MT1613.PS15ID,'') = ISNULL(@PS15ID,'') 
				--AND ISNULL(MT1613.PS16ID,'') = ISNULL(@PS16ID,'') 
				--AND ISNULL(MT1613.PS17ID,'') = ISNULL(@PS17ID,'') 
				--AND ISNULL(MT1613.PS18ID,'') = ISNULL(@PS18ID,'') 
				--AND ISNULL(MT1613.PS19ID,'') = ISNULL(@PS19ID,'') 
				--AND ISNULL(MT1613.PS20ID,'') = ISNULL(@PS20ID,'')

			--Bước 2:Lấy chi phí phát sinh trong kỳ
			SELECT 
				@AriseCost = SUM(ConvertedAmount), 
				@ICost621 = SUM(CASE WHEN ExpenseID = 'COST001' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ICost622 = SUM(CASE WHEN ExpenseID = 'COST002' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ICost627 = SUM(CASE WHEN ExpenseID = 'COST003' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) 
			FROM MT0400
			WHERE PeriodID = @PeriodID 
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
				AND ProductID = @ProductID 
				--AND ISNULL(MT0400.PS01ID,'') = ISNULL(@PS01ID,'') 
				--AND ISNULL(MT0400.PS02ID,'') = ISNULL(@PS02ID,'') 
				--AND ISNULL(MT0400.PS03ID,'') = ISNULL(@PS03ID,'') 
				--AND ISNULL(MT0400.PS04ID,'') = ISNULL(@PS04ID,'') 
				--AND ISNULL(MT0400.PS05ID,'') = ISNULL(@PS05ID,'') 
				--AND ISNULL(MT0400.PS06ID,'') = ISNULL(@PS06ID,'') 
				--AND ISNULL(MT0400.PS07ID,'') = ISNULL(@PS07ID,'') 
				--AND ISNULL(MT0400.PS08ID,'') = ISNULL(@PS08ID,'') 
				--AND ISNULL(MT0400.PS09ID,'') = ISNULL(@PS09ID,'') 
				--AND ISNULL(MT0400.PS10ID,'') = ISNULL(@PS10ID,'') 
				--AND ISNULL(MT0400.PS11ID,'') = ISNULL(@PS11ID,'') 
				--AND ISNULL(MT0400.PS12ID,'') = ISNULL(@PS12ID,'') 
				--AND ISNULL(MT0400.PS13ID,'') = ISNULL(@PS13ID,'') 
				--AND ISNULL(MT0400.PS14ID,'') = ISNULL(@PS14ID,'') 
				--AND ISNULL(MT0400.PS15ID,'') = ISNULL(@PS15ID,'') 
				--AND ISNULL(MT0400.PS16ID,'') = ISNULL(@PS16ID,'') 
				--AND ISNULL(MT0400.PS17ID,'') = ISNULL(@PS17ID,'') 
				--AND ISNULL(MT0400.PS18ID,'') = ISNULL(@PS18ID,'') 
				--AND ISNULL(MT0400.PS19ID,'') = ISNULL(@PS19ID,'') 
				--AND ISNULL(MT0400.PS20ID,'') = ISNULL(@PS20ID,'')

			--Bước 3:Lấy chi phí dở dang cuối kỳ
			SELECT 
				@EndInprocessCost = SUM(ConvertedAmount), 
				@ECost621 = SUM(CASE WHEN ExpenseID = 'COST001' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ECost622 = SUM(CASE WHEN ExpenseID = 'COST002' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ECost627 = SUM(CASE WHEN ExpenseID = 'COST003' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) 
			FROM MT1613
			WHERE PeriodID = @PeriodID 
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
				AND ProductID = @ProductID 
				AND Type = 'E'
				--AND ISNULL(MT1613.PS01ID,'') = ISNULL(@PS01ID,'') 
				--AND ISNULL(MT1613.PS02ID,'') = ISNULL(@PS02ID,'') 
				--AND ISNULL(MT1613.PS03ID,'') = ISNULL(@PS03ID,'') 
				--AND ISNULL(MT1613.PS04ID,'') = ISNULL(@PS04ID,'') 
				--AND ISNULL(MT1613.PS05ID,'') = ISNULL(@PS05ID,'') 
				--AND ISNULL(MT1613.PS06ID,'') = ISNULL(@PS06ID,'') 
				--AND ISNULL(MT1613.PS07ID,'') = ISNULL(@PS07ID,'') 
				--AND ISNULL(MT1613.PS08ID,'') = ISNULL(@PS08ID,'') 
				--AND ISNULL(MT1613.PS09ID,'') = ISNULL(@PS09ID,'') 
				--AND ISNULL(MT1613.PS10ID,'') = ISNULL(@PS10ID,'') 
				--AND ISNULL(MT1613.PS11ID,'') = ISNULL(@PS11ID,'') 
				--AND ISNULL(MT1613.PS12ID,'') = ISNULL(@PS12ID,'') 
				--AND ISNULL(MT1613.PS13ID,'') = ISNULL(@PS13ID,'') 
				--AND ISNULL(MT1613.PS14ID,'') = ISNULL(@PS14ID,'') 
				--AND ISNULL(MT1613.PS15ID,'') = ISNULL(@PS15ID,'') 
				--AND ISNULL(MT1613.PS16ID,'') = ISNULL(@PS16ID,'') 
				--AND ISNULL(MT1613.PS17ID,'') = ISNULL(@PS17ID,'') 
				--AND ISNULL(MT1613.PS18ID,'') = ISNULL(@PS18ID,'') 
				--AND ISNULL(MT1613.PS19ID,'') = ISNULL(@PS19ID,'') 
				--AND ISNULL(MT1613.PS20ID,'') = ISNULL(@PS20ID,'')
		END
		ELSE
		BEGIN
			--Bước 1:Lấy chi phí dở dang đầu kỳ
			SELECT 
				@BeginningInprocessCost = SUM(ConvertedAmount), 
				@BCost621 = SUM(CASE WHEN ExpenseID = 'COST001' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@BCost622 = SUM(CASE WHEN ExpenseID = 'COST002' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@BCost627 = SUM(CASE WHEN ExpenseID = 'COST003' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) 
			FROM MT1613
			WHERE PeriodID = @PeriodID 
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
				AND ProductID = @ProductID 
				AND Type = 'B' --- Chi phi dau ky
				AND ISNULL(MT1613.PS01ID,'') = ISNULL(@PS01ID,'') 
				AND ISNULL(MT1613.PS02ID,'') = ISNULL(@PS02ID,'') 
				AND ISNULL(MT1613.PS03ID,'') = ISNULL(@PS03ID,'') 
				AND ISNULL(MT1613.PS04ID,'') = ISNULL(@PS04ID,'') 
				AND ISNULL(MT1613.PS05ID,'') = ISNULL(@PS05ID,'') 
				AND ISNULL(MT1613.PS06ID,'') = ISNULL(@PS06ID,'') 
				AND ISNULL(MT1613.PS07ID,'') = ISNULL(@PS07ID,'') 
				AND ISNULL(MT1613.PS08ID,'') = ISNULL(@PS08ID,'') 
				AND ISNULL(MT1613.PS09ID,'') = ISNULL(@PS09ID,'') 
				AND ISNULL(MT1613.PS10ID,'') = ISNULL(@PS10ID,'') 
				AND ISNULL(MT1613.PS11ID,'') = ISNULL(@PS11ID,'') 
				AND ISNULL(MT1613.PS12ID,'') = ISNULL(@PS12ID,'') 
				AND ISNULL(MT1613.PS13ID,'') = ISNULL(@PS13ID,'') 
				AND ISNULL(MT1613.PS14ID,'') = ISNULL(@PS14ID,'') 
				AND ISNULL(MT1613.PS15ID,'') = ISNULL(@PS15ID,'') 
				AND ISNULL(MT1613.PS16ID,'') = ISNULL(@PS16ID,'') 
				AND ISNULL(MT1613.PS17ID,'') = ISNULL(@PS17ID,'') 
				AND ISNULL(MT1613.PS18ID,'') = ISNULL(@PS18ID,'') 
				AND ISNULL(MT1613.PS19ID,'') = ISNULL(@PS19ID,'') 
				AND ISNULL(MT1613.PS20ID,'') = ISNULL(@PS20ID,'')

			--Bước 2:Lấy chi phí phát sinh trong kỳ
			SELECT 
				@AriseCost = SUM(ConvertedAmount), 
				@ICost621 = SUM(CASE WHEN ExpenseID = 'COST001' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ICost622 = SUM(CASE WHEN ExpenseID = 'COST002' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ICost627 = SUM(CASE WHEN ExpenseID = 'COST003' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) 
			FROM MT0400
			WHERE PeriodID = @PeriodID 
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
				AND ProductID = @ProductID 
				AND ISNULL(MT0400.PS01ID,'') = ISNULL(@PS01ID,'') 
				AND ISNULL(MT0400.PS02ID,'') = ISNULL(@PS02ID,'') 
				AND ISNULL(MT0400.PS03ID,'') = ISNULL(@PS03ID,'') 
				AND ISNULL(MT0400.PS04ID,'') = ISNULL(@PS04ID,'') 
				AND ISNULL(MT0400.PS05ID,'') = ISNULL(@PS05ID,'') 
				AND ISNULL(MT0400.PS06ID,'') = ISNULL(@PS06ID,'') 
				AND ISNULL(MT0400.PS07ID,'') = ISNULL(@PS07ID,'') 
				AND ISNULL(MT0400.PS08ID,'') = ISNULL(@PS08ID,'') 
				AND ISNULL(MT0400.PS09ID,'') = ISNULL(@PS09ID,'') 
				AND ISNULL(MT0400.PS10ID,'') = ISNULL(@PS10ID,'') 
				AND ISNULL(MT0400.PS11ID,'') = ISNULL(@PS11ID,'') 
				AND ISNULL(MT0400.PS12ID,'') = ISNULL(@PS12ID,'') 
				AND ISNULL(MT0400.PS13ID,'') = ISNULL(@PS13ID,'') 
				AND ISNULL(MT0400.PS14ID,'') = ISNULL(@PS14ID,'') 
				AND ISNULL(MT0400.PS15ID,'') = ISNULL(@PS15ID,'') 
				AND ISNULL(MT0400.PS16ID,'') = ISNULL(@PS16ID,'') 
				AND ISNULL(MT0400.PS17ID,'') = ISNULL(@PS17ID,'') 
				AND ISNULL(MT0400.PS18ID,'') = ISNULL(@PS18ID,'') 
				AND ISNULL(MT0400.PS19ID,'') = ISNULL(@PS19ID,'') 
				AND ISNULL(MT0400.PS20ID,'') = ISNULL(@PS20ID,'')

			--Bước 3:Lấy chi phí dở dang cuối kỳ
			SELECT 
				@EndInprocessCost = SUM(ConvertedAmount), 
				@ECost621 = SUM(CASE WHEN ExpenseID = 'COST001' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ECost622 = SUM(CASE WHEN ExpenseID = 'COST002' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END), 
				@ECost627 = SUM(CASE WHEN ExpenseID = 'COST003' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) 
			FROM MT1613
			WHERE PeriodID = @PeriodID 
				AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
				AND ProductID = @ProductID 
				AND Type = 'E'
				AND ISNULL(MT1613.PS01ID,'') = ISNULL(@PS01ID,'') 
				AND ISNULL(MT1613.PS02ID,'') = ISNULL(@PS02ID,'') 
				AND ISNULL(MT1613.PS03ID,'') = ISNULL(@PS03ID,'') 
				AND ISNULL(MT1613.PS04ID,'') = ISNULL(@PS04ID,'') 
				AND ISNULL(MT1613.PS05ID,'') = ISNULL(@PS05ID,'') 
				AND ISNULL(MT1613.PS06ID,'') = ISNULL(@PS06ID,'') 
				AND ISNULL(MT1613.PS07ID,'') = ISNULL(@PS07ID,'') 
				AND ISNULL(MT1613.PS08ID,'') = ISNULL(@PS08ID,'') 
				AND ISNULL(MT1613.PS09ID,'') = ISNULL(@PS09ID,'') 
				AND ISNULL(MT1613.PS10ID,'') = ISNULL(@PS10ID,'') 
				AND ISNULL(MT1613.PS11ID,'') = ISNULL(@PS11ID,'') 
				AND ISNULL(MT1613.PS12ID,'') = ISNULL(@PS12ID,'') 
				AND ISNULL(MT1613.PS13ID,'') = ISNULL(@PS13ID,'') 
				AND ISNULL(MT1613.PS14ID,'') = ISNULL(@PS14ID,'') 
				AND ISNULL(MT1613.PS15ID,'') = ISNULL(@PS15ID,'') 
				AND ISNULL(MT1613.PS16ID,'') = ISNULL(@PS16ID,'') 
				AND ISNULL(MT1613.PS17ID,'') = ISNULL(@PS17ID,'') 
				AND ISNULL(MT1613.PS18ID,'') = ISNULL(@PS18ID,'') 
				AND ISNULL(MT1613.PS19ID,'') = ISNULL(@PS19ID,'') 
				AND ISNULL(MT1613.PS20ID,'') = ISNULL(@PS20ID,'')
		END
        

        --Bước 4:Lấy số lượng thành phẩm 
        --SELECT @ProductQuantity = SUM(MT1001.Quantity) 
        --FROM MT1001 INNER JOIN MT0810 ON MT1001.VoucherID = MT0810.VoucherID
        --WHERE MT1001.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) AND MT0810.PeriodID = @PeriodID AND MT1001.ProductID = @ProductID AND Resul

        --Bước 5: Tính giá thành sản phẩm 
        SET @Cost = ROUND(ISNULL(@BeginningInprocessCost, 0),@ConvertedDecimals) + ROUND(ISNULL(@AriseCost, 0),@ConvertedDecimals) - ROUND(ISNULL(@EndInprocessCost, 0),@ConvertedDecimals)
        SET @Cost621 = ROUND(ISNULL(@BCost621, 0),@ConvertedDecimals) + ROUND(ISNULL(@ICost621, 0),@ConvertedDecimals) - ROUND(ISNULL(@ECost621, 0),@ConvertedDecimals)
        SET @Cost622 = ROUND(ISNULL(@BCost622, 0),@ConvertedDecimals) + ROUND(ISNULL(@ICost622, 0),@ConvertedDecimals) - ROUND(ISNULL(@ECost622, 0),@ConvertedDecimals)
        SET @Cost627 = ROUND(ISNULL(@BCost627, 0),@ConvertedDecimals) + ROUND(ISNULL(@ICost627, 0),@ConvertedDecimals) - ROUND(ISNULL(@ECost627, 0),@ConvertedDecimals)

        --Bước 6: Tính giá thành đơn vị
        IF @ProductQuantity > 0 
            SET @CostUnit = (ROUND(ISNULL(@BeginningInprocessCost, 0),@ConvertedDecimals) + ROUND(ISNULL(@AriseCost, 0),@ConvertedDecimals) - ROUND(ISNULL(@EndInprocessCost, 0),@UnitCostDecimals)) / ROUND(@ProductQuantity,@QuantityDecimals)
        ELSE SET @Cost = 0 

        EXEC AP0000 @DivisionID, @TransactionID OUTPUT, 'MT1614', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

        INSERT INTO MT1614(DivisionID, PeriodID, ProductID, Cost, CostUnit, ProductQuantity, EmployeeID, VoucherDate, VoucherID, VoucherNo, TransactionID, LastModifyDate, 
        CreateDate, CreateUserID, LastModifyUserID, TranMonth, TranYear, VoucherTypeID, Cost621, Cost622, Cost627, BeginningInprocessCost, AriseCost, EndInprocessCost,
        PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)
        VALUES (@DivisionID, @PeriodID, @ProductID, ROUND(@Cost,@ConvertedDecimals), ROUND(@CostUnit,@UnitCostDecimals), ROUND(@ProductQuantity,@QuantityDecimals), NULL, NULL, @VoucherID, NULL, @TransactionID, NULL, 
        GETDATE(), NULL, NULL, @TranMonth, @TranYear, NULL, ROUND(@Cost621,@ConvertedDecimals), ROUND(@Cost622,@ConvertedDecimals), ROUND(@Cost627,@ConvertedDecimals), ROUND(@BeginningInprocessCost,@ConvertedDecimals), ROUND(@AriseCost,@ConvertedDecimals), ROUND(@EndInprocessCost,@ConvertedDecimals), 
        @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID, @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID )

        FETCH NEXT FROM @LisProduct_Cur INTO @ProductID, @ProductQuantity, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										   @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID 
    END

CLOSE @LisProduct_Cur


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO