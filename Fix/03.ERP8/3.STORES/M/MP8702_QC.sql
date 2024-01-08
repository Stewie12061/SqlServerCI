IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8702_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8702_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by Tiểu Mai on 12/01/2016
--Purpose: Tính CP DD cuối kỳ CP SXC theo phương pháp Định mức (theo thiết lập quản lý quy cách hàng hóa).
--- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.


/*
EXEC MP8702_QC 'AS', 'DT.001', 12, 2015, 'M01', 'BDM.TEST', 'IV12201500000001', 12, 2015
*/

CREATE PROCEDURE [dbo].[MP8702_QC]  @DivisionID AS NVARCHAR(50), 
				@UserID AS VARCHAR(50), 
                 @PeriodID AS NVARCHAR(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS NVARCHAR(50), 
                 @ApportionID AS NVARCHAR(50), 
                 @VoucherID AS NVARCHAR(50), 
                 @CMonth AS NVARCHAR(50), 
                 @CYear AS NVARCHAR(50),
				 @VoucherNo NVARCHAR(50) 
AS

DECLARE @sSQL AS  VARCHAR(8000), 
    @MaterialAmount AS DECIMAL(28, 8), --Chi phí NVL đầu kỳ
    @MaterialRate AS DECIMAL(28, 8), --Tỉ lệ % NVL
    @MaterialID AS NVARCHAR(50), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @InprocessCost AS DECIMAL(28, 8), 
    @ProductID AS NVARCHAR(50), 
    @PerfectRate AS DECIMAL(28, 8), 
    @InProcessQuantity AS DECIMAL(28, 8), 
    @HumanResourceRate AS DECIMAL(28, 8), 
    @OthersRate AS DECIMAL(28, 8), 
    @ProductQuantityEnd AS DECIMAL(28, 8), 
    @ConvertedUnitEnd AS DECIMAL(28, 8), 
    @TransactionID AS NVARCHAR(50), 
    @ProductUnitID AS NVARCHAR(50), 
    @MaterialUnitID AS NVARCHAR(50),
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

CREATE TABLE #MV8702(MaterialID NVARCHAR(50), MaterialQuantity DECIMAL(28,8),ConvertedAmount DECIMAL(28,8), ProductID NVARCHAR(50), ProductQuantity DECIMAL(28,8), 
					ProductUnitID NVARCHAR(50), MaterialUnitID NVARCHAR(50), DivisionID NVARCHAR(50), 
					PS01ID NVARCHAR(50), PS02ID NVARCHAR(50), PS03ID NVARCHAR(50), PS04ID NVARCHAR(50), PS05ID NVARCHAR(50),
					PS06ID NVARCHAR(50), PS07ID NVARCHAR(50), PS08ID NVARCHAR(50), PS09ID NVARCHAR(50), PS10ID NVARCHAR(50),
					PS11ID NVARCHAR(50), PS12ID NVARCHAR(50), PS13ID NVARCHAR(50), PS14ID NVARCHAR(50), PS15ID NVARCHAR(50),
					PS16ID NVARCHAR(50), PS17ID NVARCHAR(50), PS18ID NVARCHAR(50), PS19ID NVARCHAR(50), PS20ID NVARCHAR(50))
SET @sSQL='
SELECT MaterialID, 
    SUM(ISNULL(MaterialQuantity, 0)) AS MaterialQuantity, 
    SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, 
    MT0400.ProductID, --- Ma thanh pham
    MT0400.ProductQuantity, ---- So luong thanh pham duoc san xuat trong ky
    AT1302_P.UnitID AS ProductUnitID, 
    AT1302_M.UnitID AS MaterialUnitID, 
    MT0400.DivisionID,
    MT0400.PS01ID, MT0400.PS02ID, MT0400.PS03ID, MT0400.PS04ID, MT0400.PS05ID, MT0400.PS06ID, MT0400.PS07ID, MT0400.PS08ID, MT0400.PS09ID, MT0400.PS10ID,
    MT0400.PS11ID, MT0400.PS12ID, MT0400.PS13ID, MT0400.PS14ID, MT0400.PS15ID, MT0400.PS16ID, MT0400.PS17ID, MT0400.PS18ID, MT0400.PS19ID, MT0400.PS20ID
FROM MT0400 WITH (NOLOCK) 
    LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON MT0400.ProductID = AT1302_P.InventoryID AND AT1302_P.DivisionID IN (MT0400.DivisionID,''@@@'')
    LEFT JOIN AT1302 AT1302_M WITH (NOLOCK) ON MT0400.MaterialID=AT1302_M.InventoryID AND AT1302_M.DivisionID IN (MT0400.DivisionID,''@@@'')
    LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT0400.DivisionID AND O99.VoucherID = MT0400.PeriodID AND O99.TransactionID = MT0400.ApportionCostID
    LEFT JOIN MT2222 WITH (NOLOCK) ON MT0400.DivisionID = MT2222.DivisionID AND MT0400.ProductID = MT2222.ProductID AND
							ISNULL(MT0400.PS01ID,'''') = ISNULL(MT2222.PS01ID, '''') AND
							ISNULL(MT0400.PS02ID,'''') = ISNULL(MT2222.PS02ID, '''') AND
							ISNULL(MT0400.PS03ID,'''') = ISNULL(MT2222.PS03ID, '''') AND
							ISNULL(MT0400.PS04ID,'''') = ISNULL(MT2222.PS04ID, '''') AND
							ISNULL(MT0400.PS05ID,'''') = ISNULL(MT2222.PS05ID, '''') AND
							ISNULL(MT0400.PS06ID,'''') = ISNULL(MT2222.PS06ID, '''') AND
							ISNULL(MT0400.PS07ID,'''') = ISNULL(MT2222.PS07ID, '''') AND
							ISNULL(MT0400.PS08ID,'''') = ISNULL(MT2222.PS08ID, '''') AND
							ISNULL(MT0400.PS09ID,'''') = ISNULL(MT2222.PS09ID, '''') AND
							ISNULL(MT0400.PS10ID,'''') = ISNULL(MT2222.PS10ID, '''') AND
							ISNULL(MT0400.PS11ID,'''') = ISNULL(MT2222.PS11ID, '''') AND
							ISNULL(MT0400.PS12ID,'''') = ISNULL(MT2222.PS12ID, '''') AND
							ISNULL(MT0400.PS13ID,'''') = ISNULL(MT2222.PS13ID, '''') AND
							ISNULL(MT0400.PS14ID,'''') = ISNULL(MT2222.PS14ID, '''') AND
							ISNULL(MT0400.PS15ID,'''') = ISNULL(MT2222.PS15ID, '''') AND
							ISNULL(MT0400.PS16ID,'''') = ISNULL(MT2222.PS16ID, '''') AND
							ISNULL(MT0400.PS17ID,'''') = ISNULL(MT2222.PS17ID, '''') AND
							ISNULL(MT0400.PS18ID,'''') = ISNULL(MT2222.PS18ID, '''') AND
							ISNULL(MT0400.PS19ID,'''') = ISNULL(MT2222.PS19ID, '''') AND
							ISNULL(MT0400.PS20ID,'''') = ISNULL(MT2222.PS20ID, '''')
WHERE PeriodID = '''+@PeriodID+''' AND 
	ExpenseID =''COST003'' AND
    Isnull(MT2222.DivisionID,'''') <> '''' AND  
    MaterialTypeID = '''+@MaterialTypeID+''' AND 
    MT0400.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID('''+@DivisionID+'''))
GROUP BY MaterialID, MT0400.ProductID, MT0400.ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID, MT0400.DivisionID,
		MT0400.PS01ID, MT0400.PS02ID, MT0400.PS03ID, MT0400.PS04ID, MT0400.PS05ID, MT0400.PS06ID, MT0400.PS07ID, MT0400.PS08ID, MT0400.PS09ID, MT0400.PS10ID,
		MT0400.PS11ID, MT0400.PS12ID, MT0400.PS13ID, MT0400.PS14ID, MT0400.PS15ID, MT0400.PS16ID, MT0400.PS17ID, MT0400.PS18ID, MT0400.PS19ID, MT0400.PS20ID  
'

INSERT INTO #MV8702
EXEC (@sSQL)

--PRINT @sSQL

-- Lấy thông tin master cho MT1613
DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
		@UnfinishCostDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @UnfinishCostVoucherTypeID = (SELECT ISNULL(UnfinishCostVoucherTypeID,'CPDD') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @UnfinishCostDescription = (SELECT ISNULL(UnfinishCostDescription + ' ',N'Chi phí dở dang ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END


    SELECT  @MaterialID = MV8702.MaterialID, 
            @MaterialQuantity = MV8702.MaterialQuantity, ---So luong NVL phat sinh trong ky
            @ConvertedAmount = MV8702.ConvertedAmount, ---- Chi phi cua NVL phat sinh trong ky
            @ProductID = MV8702.ProductID, --- Ma san pham
            @ProductQuantity = MV8702.ProductQuantity, -- So luong thanh pham hoan thanh
            @InProcessQuantity = ISNULL(MT2222.ProductQuantity, 0)*ISNULL(MT2222.OthersRate, 0)/100, --- So luong thanh pham do dang quy doi
            @PerfectRate = MT2222.PerfectRate, --Tỉ lệ % hoàn thành
            @MaterialRate = MT2222.MaterialRate, --%NVL
            @HumanResourceRate = MT2222.HumanResourceRate, --%NC
            @OthersRate = MT2222.OthersRate, --%SXC
            @ProductQuantityEnd = MT2222.ProductQuantity, --Số lượng Thành phẩm dở dang cuôi kỳ
            @ProductUnitID = MV8702.ProductUnitID, 
            @MaterialUnitID = MV8702.MaterialUnitID,
            @PS01ID = MV8702.PS01ID,
            @PS02ID = MV8702.PS02ID,
            @PS03ID = MV8702.PS03ID,
            @PS04ID = MV8702.PS04ID,
            @PS05ID = MV8702.PS05ID,
            @PS06ID = MV8702.PS06ID,
            @PS07ID = MV8702.PS07ID,
            @PS08ID = MV8702.PS08ID,
            @PS09ID = MV8702.PS09ID,
            @PS10ID = MV8702.PS10ID,
            @PS11ID = MV8702.PS11ID,
            @PS12ID = MV8702.PS12ID,
            @PS13ID = MV8702.PS13ID,
            @PS14ID = MV8702.PS14ID,
            @PS15ID = MV8702.PS15ID,
            @PS16ID = MV8702.PS16ID,
            @PS17ID = MV8702.PS17ID,
            @PS18ID = MV8702.PS18ID,
            @PS19ID = MV8702.PS19ID,
            @PS20ID = MV8702.PS20ID
    FROM #MV8702 MV8702 LEFT JOIN MT2222 WITH (NOLOCK) ON MV8702.DivisionID = MT2222.DivisionID 
    AND MV8702.ProductID  = MT2222.ProductID AND 
    ISNULL(MV8702.PS01ID,'') = ISNULL(MT2222.PS01ID,'') AND
	ISNULL(MV8702.PS02ID,'') = ISNULL(MT2222.PS02ID,'') AND
	ISNULL(MV8702.PS03ID,'') = ISNULL(MT2222.PS03ID,'') AND
	ISNULL(MV8702.PS04ID,'') = ISNULL(MT2222.PS04ID,'') AND
	ISNULL(MV8702.PS05ID,'') = ISNULL(MT2222.PS05ID,'') AND
	ISNULL(MV8702.PS06ID,'') = ISNULL(MT2222.PS06ID,'') AND
	ISNULL(MV8702.PS07ID,'') = ISNULL(MT2222.PS07ID,'') AND
	ISNULL(MV8702.PS08ID,'') = ISNULL(MT2222.PS08ID,'') AND
	ISNULL(MV8702.PS09ID,'') = ISNULL(MT2222.PS09ID,'') AND
	ISNULL(MV8702.PS10ID,'') = ISNULL(MT2222.PS10ID,'') AND
	ISNULL(MV8702.PS11ID,'') = ISNULL(MT2222.PS11ID,'') AND
	ISNULL(MV8702.PS12ID,'') = ISNULL(MT2222.PS12ID,'') AND
	ISNULL(MV8702.PS13ID,'') = ISNULL(MT2222.PS13ID,'') AND
	ISNULL(MV8702.PS14ID,'') = ISNULL(MT2222.PS14ID,'') AND
	ISNULL(MV8702.PS15ID,'') = ISNULL(MT2222.PS15ID,'') AND
	ISNULL(MV8702.PS16ID,'') = ISNULL(MT2222.PS16ID,'') AND
	ISNULL(MV8702.PS17ID,'') = ISNULL(MT2222.PS17ID,'') AND
	ISNULL(MV8702.PS18ID,'') = ISNULL(MT2222.PS18ID,'') AND
	ISNULL(MV8702.PS19ID,'') = ISNULL(MT2222.PS19ID,'') AND
	ISNULL(MV8702.PS20ID,'') = ISNULL(MT2222.PS20ID,'')
        
    --Bước 1 :Xác định chi phí SXC định mức
    SET @MaterialAmount = (SELECT MT0137.MaterialAmount
        FROM MT0135 WITH (NOLOCK) INNER JOIN  MT0136 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
        INNER JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ProductID = MT0136.ProductID AND MT0137.ReTransactionID = MT0136.TransactionID
        WHERE MT0135.Disabled = 0 AND MT0135.IsBOM=1 AND MT0136.ProductID= @ProductID AND MT0137.ExpenseID = 'COST003'
            AND MT0135.DivisionID = @DivisionID AND
            Isnull(MT0136.S01ID,'') = Isnull(@PS01ID,'') AND Isnull(MT0136.S02ID,'') = Isnull(@PS02ID,'') AND
			Isnull(MT0136.S03ID,'') = Isnull(@PS03ID,'') AND Isnull(MT0136.S04ID,'') = Isnull(@PS04ID,'') AND
			Isnull(MT0136.S05ID,'') = Isnull(@PS05ID,'') AND Isnull(MT0136.S06ID,'') = Isnull(@PS06ID,'') AND
			Isnull(MT0136.S07ID,'') = Isnull(@PS07ID,'') AND Isnull(MT0136.S08ID,'') = Isnull(@PS08ID,'') AND
			Isnull(MT0136.S09ID,'') = Isnull(@PS09ID,'') AND Isnull(MT0136.S10ID,'') = Isnull(@PS10ID,'') AND
			Isnull(MT0136.S11ID,'') = Isnull(@PS11ID,'') AND Isnull(MT0136.S12ID,'') = Isnull(@PS12ID,'') AND
			Isnull(MT0136.S13ID,'') = Isnull(@PS13ID,'') AND Isnull(MT0136.S14ID,'') = Isnull(@PS14ID,'') AND
			Isnull(MT0136.S15ID,'') = Isnull(@PS15ID,'') AND Isnull(MT0136.S16ID,'') = Isnull(@PS16ID,'') AND
			Isnull(MT0136.S17ID,'') = Isnull(@PS17ID,'') AND Isnull(MT0136.S18ID,'') = Isnull(@PS18ID,'') AND 
			Isnull(MT0136.S19ID,'') = Isnull(@PS19ID,'') AND Isnull(MT0136.S20ID,'') = Isnull(@PS20ID,''))

    --Bước 2: Tính Chi  phí SPDD  SXC theo PP dinh muc
    SET @InprocessCost =ISNULL(@MaterialAmount, 0)*ISNULL(@InProcessQuantity, 0)
    
    --Bước3: Tính Chi  phí SPDD  SXC /1SP
    IF (@ProductQuantityEnd<>0)
         SET @ConvertedUnitEnd = ISNULL(@InprocessCost, 0)/@ProductQuantityEnd
    ELSE SET @ConvertedUnitEnd = 0 
            
    EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

    INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, 
    PerfectRate, MaterialQuantity, ConvertedAmount, ProductQuantity, QuantityUnit, ConvertedUnit, CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate, 
	PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
	PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID,
	VoucherTypeID, VoucherNo, VoucherDate, EmployeeID, Description, LastModifyUserID, LastModifyDate )
    
    VALUES (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, @ProductID, @MaterialID, 'COST003', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, 
    @PerfectRate, @MaterialQuantity, @InprocessCost, @ProductQuantityEnd, Null, @ConvertedUnitEnd, Getdate(), @UserID, 'E', @MaterialRate, @HumanResourceRate, @OthersRate,
	@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
	@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
	@UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE() )

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
