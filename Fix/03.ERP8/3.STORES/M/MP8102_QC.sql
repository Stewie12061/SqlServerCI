IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8102_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP8102_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- Created by Tiểu Mai on 12/01/2016
-- Purpose: Tính CPDD cuối kỳ NVL TT theo phương pháp định mức (theo quy cách).
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID và @VoucherNo để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

/*
EXEC MP8102_QC 'AS', 'DT.001', 12, 2015, 'M01', 'BDM.TEST', 'IV12201500000001', 12, 2015
*/
CREATE PROCEDURE [dbo].[MP8102_QC]  @DivisionID AS nvarchar(50), 
				@UserID AS VARCHAR(50), 
                 @PeriodID AS nvarchar(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @MaterialTypeID AS nvarchar(50), 
                 @ApportionID AS nvarchar(50), 
                 @VoucherID AS nvarchar(50), 
                 @CMonth AS nvarchar(50), 
                 @CYear AS nvarchar(50),
				 @VoucherNo NVARCHAR(50)

AS
DECLARE @sSQL AS  nvarchar(4000), 
    @MaterialAmount AS DECIMAL(28, 8), --Chi phÝ NVL ®Çu kú
    @Quantity AS DECIMAL(28, 8), --Sè l­îng thµnh phÈm
    @MaterialRate AS DECIMAL(28, 8), --TØ lÖ % NVL
    @MaterialID AS nvarchar(50), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @MaterialInprocessCost AS DECIMAL(28, 8), 
    @ProductID AS nvarchar(50), 
    @PerfectRate AS DECIMAL(28, 8), 
    @InProcessQuantity AS DECIMAL(28, 8), 
    @HumanResourceRate AS DECIMAL(28, 8), 
    @OthersRate AS DECIMAL(28, 8), 
    @QuantityUnit AS  DECIMAL(28, 8), 
    @BMaterialQuantity AS DECIMAL(28, 8), 
    @ProductQuantityEnd AS DECIMAL(28, 8), 
    @ConvertedUnitEnd AS  DECIMAL(28, 8), 
    @ProductQuantityCoe AS DECIMAL(28, 8), --Sè l­îng NVL ®Þnh møc    
    @TransactionID AS nvarchar(50), 
    @ProductUnitID AS nvarchar(50), 
    @MaterialUnitID AS nvarchar(50), 
    @ListMaterial_cur AS CURSOR, 
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

SELECT @ConvertedDecimal = ConvertDecimal FROM MT0000

CREATE TABLE #MV8102(MaterialID NVARCHAR(50), MaterialQuantity DECIMAL(28,8),ConvertedAmount DECIMAL(28,8), ProductID NVARCHAR(50), ProductQuantity DECIMAL(28,8), 
					ProductUnitID NVARCHAR(50), MaterialUnitID NVARCHAR(50), DivisionID NVARCHAR(50), 
					PS01ID NVARCHAR(50), PS02ID NVARCHAR(50), PS03ID NVARCHAR(50), PS04ID NVARCHAR(50), PS05ID NVARCHAR(50),
					PS06ID NVARCHAR(50), PS07ID NVARCHAR(50), PS08ID NVARCHAR(50), PS09ID NVARCHAR(50), PS10ID NVARCHAR(50),
					PS11ID NVARCHAR(50), PS12ID NVARCHAR(50), PS13ID NVARCHAR(50), PS14ID NVARCHAR(50), PS15ID NVARCHAR(50),
					PS16ID NVARCHAR(50), PS17ID NVARCHAR(50), PS18ID NVARCHAR(50), PS19ID NVARCHAR(50), PS20ID NVARCHAR(50),
					S01ID NVARCHAR(50), S02ID NVARCHAR(50), S03ID NVARCHAR(50), S04ID NVARCHAR(50), S05ID NVARCHAR(50),
					S06ID NVARCHAR(50), S07ID NVARCHAR(50), S08ID NVARCHAR(50), S09ID NVARCHAR(50), S10ID NVARCHAR(50),
					S11ID NVARCHAR(50), S12ID NVARCHAR(50), S13ID NVARCHAR(50), S14ID NVARCHAR(50), S15ID NVARCHAR(50),
					S16ID NVARCHAR(50), S17ID NVARCHAR(50), S18ID NVARCHAR(50), S19ID NVARCHAR(50), S20ID NVARCHAR(50))
--print 'da vao1'
SET @sSQL=N'
    SELECT     MaterialID, SUM(ISNULL(MaterialQuantity, 0)) AS MaterialQuantity, 
        SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, 
        MT0400.ProductID, --- Ma thanh pham
        MT0400.ProductQuantity, ---- So luong thanh pham duoc san xuat trong ky
        AT1302_P.UnitID AS ProductUnitID, 
        AT1302_M.UnitID AS MaterialUnitID, 
        MT0400.DivisionID,
        MT0400.PS01ID, MT0400.PS02ID, MT0400.PS03ID, MT0400.PS04ID, MT0400.PS05ID, MT0400.PS06ID, MT0400.PS07ID, MT0400.PS08ID, MT0400.PS09ID, MT0400.PS10ID,
        MT0400.PS11ID, MT0400.PS12ID, MT0400.PS13ID, MT0400.PS14ID, MT0400.PS15ID, MT0400.PS16ID, MT0400.PS17ID, MT0400.PS18ID, MT0400.PS19ID, MT0400.PS20ID,
        O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
        O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
     FROM MT0400 WITH (NOLOCK)  
			LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON MT0400.ProductID = AT1302_P .InventoryID AND AT1302_P.DivisionID IN (MT0400.DivisionID,''@@@'')
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
    WHERE MT0400.DivisionID ='''+@DivisionID+''' AND
        PeriodID = '''+@PeriodID+''' AND
        ExpenseID =''COST001'' AND
        Isnull(MT2222.DivisionID,'''') <> '''' AND        
        MaterialTypeID ='''+@MaterialTypeID+''' 
    GROUP BY MaterialID, MT0400.ProductID, MT0400.ProductQuantity, AT1302_P.UnitID, AT1302_M.UnitID, MT0400.DivisionID,
        MT0400.PS01ID, MT0400.PS02ID, MT0400.PS03ID, MT0400.PS04ID, MT0400.PS05ID, MT0400.PS06ID, MT0400.PS07ID, MT0400.PS08ID, MT0400.PS09ID, MT0400.PS10ID,
        MT0400.PS11ID, MT0400.PS12ID, MT0400.PS13ID, MT0400.PS14ID, MT0400.PS15ID, MT0400.PS16ID, MT0400.PS17ID, MT0400.PS18ID, MT0400.PS19ID, MT0400.PS20ID,
        O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
        O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID '

INSERT INTO #MV8102 
EXEC (@sSQL)

-- Lấy thông tin master cho MT1613
DECLARE @UnfinishCostVoucherTypeID VARCHAR(50),
		@UnfinishCostDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @UnfinishCostVoucherTypeID = (SELECT ISNULL(UnfinishCostVoucherTypeID,'CPDD') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @UnfinishCostDescription = (SELECT ISNULL(UnfinishCostDescription + ' ',N'Chi phí dở dang ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END


SET @ListMaterial_cur  = CURSOR SCROLL KEYSET FOR 
    SELECT         MV8102.MaterialID, 
            MV8102.MaterialQuantity, ---So luong NVL phat sinh trong ky
            MV8102.ConvertedAmount, ---- Chi phi cua NVL phat sinh trong ky
            MV8102.ProductID, --- Ma san pham
            MV8102.ProductQuantity, -- So luong thanh pham hoan thanh
            ISNULL(MT2222.ProductQuantity, 0)*ISNULL(MT2222.MaterialRate, 0)/100 AS InPocessQuantity, --- So luong thanh pham do dang quy doi
            MT2222.ProductQuantity, --Sè l­îng SPDD
            MT2222.PerfectRate, MT2222.MaterialRate, MT2222.HumanResourceRate, MT2222.OthersRate, 
            MV8102.ProductUnitID, MV8102.MaterialUnitID,
			MV8102.PS01ID, MV8102.PS02ID, MV8102.PS03ID, MV8102.PS04ID, MV8102.PS05ID, MV8102.PS06ID, MV8102.PS07ID, MV8102.PS08ID, MV8102.PS09ID, MV8102.PS10ID,
			MV8102.PS11ID, MV8102.PS12ID, MV8102.PS13ID, MV8102.PS14ID, MV8102.PS15ID, MV8102.PS16ID, MV8102.PS17ID, MV8102.PS18ID, MV8102.PS19ID, MV8102.PS20ID,
			MV8102.S01ID, MV8102.S02ID, MV8102.S03ID, MV8102.S04ID, MV8102.S05ID, MV8102.S06ID, MV8102.S07ID, MV8102.S08ID, MV8102.S09ID, MV8102.S10ID,
			MV8102.S11ID, MV8102.S12ID, MV8102.S13ID, MV8102.S14ID, MV8102.S15ID, MV8102.S16ID, MV8102.S17ID, MV8102.S18ID, MV8102.S19ID, MV8102.S20ID
        FROM #MV8102 MV8102 LEFT JOIN MT2222 WITH (NOLOCK) ON MV8102.DivisionID = MT2222.DivisionID AND MV8102.ProductID  = MT2222.ProductID AND 
										ISNULL(MV8102.PS01ID,'') = ISNULL(MT2222.PS01ID,'') AND
										ISNULL(MV8102.PS02ID,'') = ISNULL(MT2222.PS02ID,'') AND
										ISNULL(MV8102.PS03ID,'') = ISNULL(MT2222.PS03ID,'') AND
										ISNULL(MV8102.PS04ID,'') = ISNULL(MT2222.PS04ID,'') AND
										ISNULL(MV8102.PS05ID,'') = ISNULL(MT2222.PS05ID,'') AND
										ISNULL(MV8102.PS06ID,'') = ISNULL(MT2222.PS06ID,'') AND
										ISNULL(MV8102.PS07ID,'') = ISNULL(MT2222.PS07ID,'') AND
										ISNULL(MV8102.PS08ID,'') = ISNULL(MT2222.PS08ID,'') AND
										ISNULL(MV8102.PS09ID,'') = ISNULL(MT2222.PS09ID,'') AND
										ISNULL(MV8102.PS10ID,'') = ISNULL(MT2222.PS10ID,'') AND
										ISNULL(MV8102.PS11ID,'') = ISNULL(MT2222.PS11ID,'') AND
										ISNULL(MV8102.PS12ID,'') = ISNULL(MT2222.PS12ID,'') AND
										ISNULL(MV8102.PS13ID,'') = ISNULL(MT2222.PS13ID,'') AND
										ISNULL(MV8102.PS14ID,'') = ISNULL(MT2222.PS14ID,'') AND
										ISNULL(MV8102.PS15ID,'') = ISNULL(MT2222.PS15ID,'') AND
										ISNULL(MV8102.PS16ID,'') = ISNULL(MT2222.PS16ID,'') AND
										ISNULL(MV8102.PS17ID,'') = ISNULL(MT2222.PS17ID,'') AND
										ISNULL(MV8102.PS18ID,'') = ISNULL(MT2222.PS18ID,'') AND
										ISNULL(MV8102.PS19ID,'') = ISNULL(MT2222.PS19ID,'') AND
										ISNULL(MV8102.PS20ID,'') = ISNULL(MT2222.PS20ID,'')
        UNION
         SELECT         
            MT1613.MaterialID, 
            0 AS MaterialQuantity, 
            0 AS ConvertedAmount, 
            MT1613.ProductID, 
            ProductQuantity = ISNULL((SELECT SUM(ISNULL(Quantity, 0))     
                                FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID
                                    WHERE     MT1001.ProductID = MT1613.ProductID AND
                                        MT0810.PeriodID =@PeriodID AND
                                        MT0810.ResultTypeID = 'R01' AND --- ket qua san xuat la thanh pham
                                        MT1001.DivisionID =@DivisionID), 0), 
            MT2222.ProductQuantity*MT2222.MaterialRate/100 AS InPocessQuantity, 
            MT2222.PerfectRate, MT2222.MaterialRate, MT2222.HumanresourceRate, MT2222.OthersRate, 
            MT2222.ProductQuantity, 
            IP.UnitID AS ProductUnitID, 
            IM.UnitID AS MaterialUnitID,
			MT1613.PS01ID, MT1613.PS02ID, MT1613.PS03ID, MT1613.PS04ID, MT1613.PS05ID, MT1613.PS06ID, MT1613.PS07ID, MT1613.PS08ID, MT1613.PS09ID, MT1613.PS10ID,
			MT1613.PS11ID, MT1613.PS12ID, MT1613.PS13ID, MT1613.PS14ID, MT1613.PS15ID, MT1613.PS16ID, MT1613.PS17ID, MT1613.PS18ID, MT1613.PS19ID, MT1613.PS20ID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
    FROM  MT1613 WITH (NOLOCK)
			LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1613.DivisionID AND O99.VoucherID = MT1613.VoucherID AND O99.TransactionID = MT1613.TransactionID AND O99.TableID = 'MT1613'
			LEFT JOIN MT2222 WITH (NOLOCK) ON MT2222.DivisionID = MT1613.DivisionID AND MT2222.ProductID = MT1613.ProductID AND 
									ISNULL(MT1613.PS01ID,'') = ISNULL(MT2222.PS01ID,'') AND
									ISNULL(MT1613.PS02ID,'') = ISNULL(MT2222.PS02ID,'') AND
									ISNULL(MT1613.PS03ID,'') = ISNULL(MT2222.PS03ID,'') AND
									ISNULL(MT1613.PS04ID,'') = ISNULL(MT2222.PS04ID,'') AND
									ISNULL(MT1613.PS05ID,'') = ISNULL(MT2222.PS05ID,'') AND
									ISNULL(MT1613.PS06ID,'') = ISNULL(MT2222.PS06ID,'') AND
									ISNULL(MT1613.PS07ID,'') = ISNULL(MT2222.PS07ID,'') AND
									ISNULL(MT1613.PS08ID,'') = ISNULL(MT2222.PS08ID,'') AND
									ISNULL(MT1613.PS09ID,'') = ISNULL(MT2222.PS09ID,'') AND
									ISNULL(MT1613.PS10ID,'') = ISNULL(MT2222.PS10ID,'') AND
									ISNULL(MT1613.PS11ID,'') = ISNULL(MT2222.PS11ID,'') AND
									ISNULL(MT1613.PS12ID,'') = ISNULL(MT2222.PS12ID,'') AND
									ISNULL(MT1613.PS13ID,'') = ISNULL(MT2222.PS13ID,'') AND
									ISNULL(MT1613.PS14ID,'') = ISNULL(MT2222.PS14ID,'') AND
									ISNULL(MT1613.PS15ID,'') = ISNULL(MT2222.PS15ID,'') AND
									ISNULL(MT1613.PS16ID,'') = ISNULL(MT2222.PS16ID,'') AND
									ISNULL(MT1613.PS17ID,'') = ISNULL(MT2222.PS17ID,'') AND
									ISNULL(MT1613.PS18ID,'') = ISNULL(MT2222.PS18ID,'') AND
									ISNULL(MT1613.PS19ID,'') = ISNULL(MT2222.PS19ID,'') AND
									ISNULL(MT1613.PS20ID,'') = ISNULL(MT2222.PS20ID,'')
            LEFT JOIN AT1302 AS IM WITH (NOLOCK) ON IM.InventoryID = MT1613.MaterialID AND IM.DivisionID IN (MT1613.DivisionID,'@@@')
            LEFT JOIN AT1302 AS IP WITH (NOLOCK) ON IP.InventoryID = MT1613.ProductID AND IP.DivisionID IN (MT1613.DivisionID,'@@@')
            LEFT JOIN (SELECT DISTINCT DivisionID, ProductID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
										PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
						FROM MT0400 WITH (NOLOCK) 
						WHERE DivisionID =@DivisionID AND PeriodID =@PeriodID AND 
							MaterialTypeID = @MaterialTypeID AND ExpenseID ='COST001'  ) AS G ON G.DivisionID = MT1613.DivisionID AND G.ProductID = MT1613.ProductID AND 
									Isnull(G.PS01ID,'') = Isnull(MT1613.PS01ID,'') AND Isnull(G.PS02ID,'') = Isnull(MT1613.PS02ID,'') AND
									Isnull(G.PS03ID,'') = Isnull(MT1613.PS03ID,'') AND Isnull(G.PS04ID,'') = Isnull(MT1613.PS04ID,'') AND
									Isnull(G.PS05ID,'') = Isnull(MT1613.PS05ID,'') AND Isnull(G.PS06ID,'') = Isnull(MT1613.PS06ID,'') AND
									Isnull(G.PS07ID,'') = Isnull(MT1613.PS07ID,'') AND Isnull(G.PS08ID,'') = Isnull(MT1613.PS08ID,'') AND
									Isnull(G.PS09ID,'') = Isnull(MT1613.PS09ID,'') AND Isnull(G.PS10ID,'') = Isnull(MT1613.PS10ID,'') AND
									Isnull(G.PS11ID,'') = Isnull(MT1613.PS11ID,'') AND Isnull(G.PS12ID,'') = Isnull(MT1613.PS12ID,'') AND
									Isnull(G.PS13ID,'') = Isnull(MT1613.PS13ID,'') AND Isnull(G.PS14ID,'') = Isnull(MT1613.PS14ID,'') AND
									Isnull(G.PS15ID,'') = Isnull(MT1613.PS15ID,'') AND Isnull(G.PS16ID,'') = Isnull(MT1613.PS16ID,'') AND
									Isnull(G.PS17ID,'') = Isnull(MT1613.PS17ID,'') AND Isnull(G.PS18ID,'') = Isnull(MT1613.PS18ID,'') AND 
									Isnull(G.PS19ID,'') = Isnull(MT1613.PS19ID,'') AND Isnull(G.PS20ID,'') = Isnull(MT1613.PS20ID,'')
    WHERE   Isnull(G.DivisionID,'') = ''  AND --- khong co phat sinh duoc phan bo
        MT1613.PeriodID = @PeriodID AND
        MT1613.DivisionID = @DivisionID AND
        MT1613.MaterialTypeID = @MaterialTypeID AND
        MT1613.ExpenseID = 'COST001'

        OPEN @ListMaterial_cur 
        FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @ProductQuantityEnd, @PerfectRate, 
                    @MaterialRate, @HumanResourceRate, @OthersRate, @ProductUnitID, @MaterialUnitID,
					@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
					@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
					@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
					@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
        WHILE @@Fetch_Status = 0
            BEGIN    

        
        --B­íc 1 :X¸c ®Þnh chi phÝ NVL ®Þnh møc

        SELECT     @MaterialAmount = MT0137.MaterialAmount, 
            @ProductQuantityCoe = MT0136.ProductQuantity        
                    FROM     MT0136 WITH (NOLOCK)  
                    INNER JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
                    INNER JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ProductID = MT0136.ProductID AND MT0137.ReTransactionID = MT0136.TransactionID
                    WHERE   MT0135.Disabled = 0 AND MT0135.IsBOM=1 AND
                        MT0136.ProductID= @ProductID AND MT0137.ExpenseID='COST001'
						AND MaterialID= @MaterialID AND MT0136.DivisionID = @DivisionID AND 
						Isnull(MT0136.S01ID,'') = Isnull(@PS01ID,'') AND Isnull(MT0136.S02ID,'') = Isnull(@PS02ID,'') AND
						Isnull(MT0136.S03ID,'') = Isnull(@PS03ID,'') AND Isnull(MT0136.S04ID,'') = Isnull(@PS04ID,'') AND
						Isnull(MT0136.S05ID,'') = Isnull(@PS05ID,'') AND Isnull(MT0136.S06ID,'') = Isnull(@PS06ID,'') AND
						Isnull(MT0136.S07ID,'') = Isnull(@PS07ID,'') AND Isnull(MT0136.S08ID,'') = Isnull(@PS08ID,'') AND
						Isnull(MT0136.S09ID,'') = Isnull(@PS09ID,'') AND Isnull(MT0136.S10ID,'') = Isnull(@PS10ID,'') AND
						Isnull(MT0136.S11ID,'') = Isnull(@PS11ID,'') AND Isnull(MT0136.S12ID,'') = Isnull(@PS12ID,'') AND
						Isnull(MT0136.S13ID,'') = Isnull(@PS13ID,'') AND Isnull(MT0136.S14ID,'') = Isnull(@PS14ID,'') AND
						Isnull(MT0136.S15ID,'') = Isnull(@PS15ID,'') AND Isnull(MT0136.S16ID,'') = Isnull(@PS16ID,'') AND
						Isnull(MT0136.S17ID,'') = Isnull(@PS17ID,'') AND Isnull(MT0136.S18ID,'') = Isnull(@PS18ID,'') AND 
						Isnull(MT0136.S19ID,'') = Isnull(@PS19ID,'') AND Isnull(MT0136.S20ID,'') = Isnull(@PS20ID,'') AND
						Isnull(MT0137.DS01ID,'') = Isnull(@S01ID,'') AND Isnull(MT0137.DS02ID,'') = Isnull(@S02ID,'') AND
						Isnull(MT0137.DS03ID,'') = Isnull(@S03ID,'') AND Isnull(MT0137.DS04ID,'') = Isnull(@S04ID,'') AND
						Isnull(MT0137.DS05ID,'') = Isnull(@S05ID,'') AND Isnull(MT0137.DS06ID,'') = Isnull(@S06ID,'') AND
						Isnull(MT0137.DS07ID,'') = Isnull(@S07ID,'') AND Isnull(MT0137.DS08ID,'') = Isnull(@S08ID,'') AND
						Isnull(MT0137.DS09ID,'') = Isnull(@S09ID,'') AND Isnull(MT0137.DS10ID,'') = Isnull(@S10ID,'') AND
						Isnull(MT0137.DS11ID,'') = Isnull(@S11ID,'') AND Isnull(MT0137.DS12ID,'') = Isnull(@S12ID,'') AND
						Isnull(MT0137.DS13ID,'') = Isnull(@S13ID,'') AND Isnull(MT0137.DS14ID,'') = Isnull(@S14ID,'') AND
						Isnull(MT0137.DS15ID,'') = Isnull(@S15ID,'') AND Isnull(MT0137.DS16ID,'') = Isnull(@S16ID,'') AND
						Isnull(MT0137.DS17ID,'') = Isnull(@S17ID,'') AND Isnull(MT0137.DS18ID,'') = Isnull(@S18ID,'') AND 
						Isnull(MT0137.DS19ID,'') = Isnull(@S19ID,'') AND Isnull(MT0137.DS20ID,'') = Isnull(@S20ID,'')

        --B­íc 2: TÝnh Chi  phÝ SPDD  theo NVL
            SET @MaterialInprocessCost = round(ISNULL(@MaterialAmount, 0)*ISNULL(@InProcessQuantity, 0), @ConvertedDecimal)
            
            IF @ProductQuantityEnd  <>0 
                BEGIN
                    SET @ConvertedUnitEnd = ISNULL(@MaterialInprocessCost, 0)/@ProductQuantityEnd
                    SET @QuantityUnit = ISNULL(@ProductQuantityCoe, 0) * ISNULL(@InProcessQuantity, 0)/@ProductQuantityEnd
                END
              ELSE 
                BEGIN
                    SET @QuantityUnit = 0
                    SET @ConvertedUnitEnd =  0    
                END
        --B­íc 3: TÝnh SL SPDD  NVL/1SP DD
                                
        
        EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT1613', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

    INSERT MT1613 (PeriodID, TranMonth, TranYear, DivisionID, VoucherID, TransactionID, 
				ProductID, MaterialID, ExpenseID, MaterialTypeID, ProductUnitID, MaterialUnitID, PerfectRate, --- ProductUnitID
				MaterialQuantity, ConvertedAmount, 
				ProductQuantity, QuantityUnit, ConvertedUnit, 
				CreateDate, CreateUserID, Type, MaterialRate, HumanResourceRate, OthersRate, 
				PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
				PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID,
				VoucherTypeID, VoucherNo, VoucherDate, EmployeeID, Description, LastModifyUserID, LastModifyDate  )

    VALUES  (@PeriodID, @TranMonth, @TranYear, @DivisionID, @VoucherID, @TransactionID, 
        @ProductID, @MaterialID, 'COST001', @MaterialTypeID, @ProductUnitID, @MaterialUnitID, @PerfectRate, 
        @MaterialQuantity, @MaterialInprocessCost, 
        @ProductQuantityEnd, @QuantityUnit, @ConvertedUnitEnd, 
        Getdate(), @UserID, 'E', @MaterialRate, @HumanResourceRate, @OthersRate,
		@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
		@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
		@UnfinishCostVoucherTypeID, @VoucherNo, GETDATE(), @UserID, @UnfinishCostDescription + @PeriodStr, @UserID, GETDATE() )
		
	INSERT INTO MT8899 (DivisionID, VoucherID, TableID, TransactionID, S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,
						S10ID,S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID)
    VALUES (@DivisionID, @VoucherID, 'MT1613', @TransactionID, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID)	

    FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @InProcessQuantity, @ProductQuantityEnd, @PerfectRate, 
    @MaterialRate, @HumanResourceRate, @OthersRate, @ProductUnitID, @MaterialUnitID,
    @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
    @PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
    @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
    @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
    END
    CLOSE @ListMaterial_cur
    
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO    