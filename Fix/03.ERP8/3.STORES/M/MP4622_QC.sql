IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP4622_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP4622_QC]
GO
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MV4622]'))			
DROP VIEW [DBO].[MV4622]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by Tiểu Mai
--Date 15/01/2016
--Purpose : Chiet tinh gia thanh (NC & SXC) theo thiết lập quản lý quy cách hàng hóa.
-- Modified by Bảo Thy on 24/05/2016: Bổ sung WITH (NOLOCK)

CREATE PROCEDURE [dbo].[MP4622_QC] 
    @DivisionID AS NVARCHAR(50), 
    @PeriodID AS NVARCHAR(50), 
    @VoucherID AS NVARCHAR(50), 
    @TranMonth AS INT, 
    @TranYear AS INT
AS

DECLARE 
    @sSQL AS NVARCHAR(4000),
    @sSQL1 AS NVARCHAR(4000),
    @DetailCostID AS NVARCHAR(50), 
    @Product_cur AS CURSOR, 
    @ProductID AS NVARCHAR(50), 
    @MaterialTypeID AS NVARCHAR(50), 
    @MaterialID AS NVARCHAR(50), 
    @QuantityUnit AS DECIMAL(28, 8), 
    @ConvertedUnit AS DECIMAL (28, 8), 
    @CMonth AS NVARCHAR(50), 
    @CYear AS NVARCHAR(50), 
    @ExpenseID AS NVARCHAR(50), 
    @ConvertedAmount1 AS DECIMAL(28, 8), 
    @ConvertedAmount2 AS DECIMAL(28, 8), 
    @ProductQuantity AS DECIMAL(28, 8), 
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

SELECT @ConvertedDecimal = ConvertDecimal FROM MT0000 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))

IF @TranMonth >9
    SET @CMonth = LTRIM(RTRIM(STR(@TranMonth)))
ELSE
    SET @CMonth = '0'+LTRIM(RTRIM(STR(@TranMonth)))

SET @CYear =RIGHT(LTRIM(RTRIM(STR(@TranYear))), 2)

--Lay ket qua phan bo chi phi cho doi tuong (NVL)
SET @sSQL ='
SELECT 
    MT0400.DivisionID, 
    MT0400.ProductID, 
    MaterialTypeID, 
    ExpenseID, 
    ConvertedAmount, 
    ProductQuantity = (SELECT SUM(MT1001.Quantity) 
                       FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 ON MT1001.DivisionID = MT0810.DivisionID AND MT1001.VoucherID = MT0810.VoucherID
                       LEFT JOIN MT8899 O89 WITH (NOLOCK) ON O89.DivisionID = MT1001.DivisionID AND O89.VoucherID = MT1001.VoucherID AND O89.TransactionID = MT1001.TransactionID AND O89.TableID = ''MT1001''
                       WHERE MT0810.ResultTypeID = ''R01'' AND MT0810.PeriodID = N'''+ @PeriodID+''' AND ProductID = MT0400.ProductID
							AND ISNULL(MT0400.PS01ID,'''') = ISNULL(O89.S01ID,'''') 
							AND ISNULL(MT0400.PS02ID,'''') = ISNULL(O89.S02ID,'''') 
							AND ISNULL(MT0400.PS03ID,'''') = ISNULL(O89.S03ID,'''') 
							AND ISNULL(MT0400.PS04ID,'''') = ISNULL(O89.S04ID,'''') 
							AND ISNULL(MT0400.PS05ID,'''') = ISNULL(O89.S05ID,'''') 
							AND ISNULL(MT0400.PS06ID,'''') = ISNULL(O89.S06ID,'''') 
							AND ISNULL(MT0400.PS07ID,'''') = ISNULL(O89.S07ID,'''') 
							AND ISNULL(MT0400.PS08ID,'''') = ISNULL(O89.S08ID,'''') 
							AND ISNULL(MT0400.PS09ID,'''') = ISNULL(O89.S09ID,'''') 
							AND ISNULL(MT0400.PS10ID,'''') = ISNULL(O89.S10ID,'''') 
							AND ISNULL(MT0400.PS11ID,'''') = ISNULL(O89.S11ID,'''') 
							AND ISNULL(MT0400.PS12ID,'''') = ISNULL(O89.S12ID,'''') 
							AND ISNULL(MT0400.PS13ID,'''') = ISNULL(O89.S13ID,'''') 
							AND ISNULL(MT0400.PS14ID,'''') = ISNULL(O89.S14ID,'''') 
							AND ISNULL(MT0400.PS15ID,'''') = ISNULL(O89.S15ID,'''') 
							AND ISNULL(MT0400.PS16ID,'''') = ISNULL(O89.S16ID,'''') 
							AND ISNULL(MT0400.PS17ID,'''') = ISNULL(O89.S17ID,'''') 
							AND ISNULL(MT0400.PS18ID,'''') = ISNULL(O89.S18ID,'''') 
							AND ISNULL(MT0400.PS19ID,'''') = ISNULL(O89.S19ID,'''') 
							AND ISNULL(MT0400.PS20ID,'''') = ISNULL(O89.S20ID,'''')
							AND MT1001.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N'''+ @DivisionID+'''))
                       ),
    ISNULL(MT0400.PS01ID,'''') AS PS01ID,
	ISNULL(MT0400.PS02ID,'''') AS PS02ID,
	ISNULL(MT0400.PS03ID,'''') AS PS03ID,
	ISNULL(MT0400.PS04ID,'''') AS PS04ID,
	ISNULL(MT0400.PS05ID,'''') AS PS05ID,
	ISNULL(MT0400.PS06ID,'''') AS PS06ID,
	ISNULL(MT0400.PS07ID,'''') AS PS07ID,
	ISNULL(MT0400.PS08ID,'''') AS PS08ID,
	ISNULL(MT0400.PS09ID,'''') AS PS09ID,
	ISNULL(MT0400.PS10ID,'''') AS PS10ID,
	ISNULL(MT0400.PS11ID,'''') AS PS11ID,
	ISNULL(MT0400.PS12ID,'''') AS PS12ID,
	ISNULL(MT0400.PS13ID,'''') AS PS13ID,
	ISNULL(MT0400.PS14ID,'''') AS PS14ID,
	ISNULL(MT0400.PS15ID,'''') AS PS15ID,
	ISNULL(MT0400.PS16ID,'''') AS PS16ID,
	ISNULL(MT0400.PS17ID,'''') AS PS17ID,
	ISNULL(MT0400.PS18ID,'''') AS PS18ID,
	ISNULL(MT0400.PS19ID,'''') AS PS19ID,
	ISNULL(MT0400.PS20ID,'''') AS PS20ID
	'
	 
SET @sSQL1 = '	              
    FROM MT0400 WITH (NOLOCK)
    LEFT JOIN (SELECT MT1001.DivisionID, ProductID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
							O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID		 
                      FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 ON MT1001.VoucherID = MT0810.VoucherID
                      LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID AND O99.TableID = ''MT1001''
                      WHERE MT0810.ResultTypeID = ''R01'' 
                            AND MT1001.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
                            AND MT0810.PeriodID = N''' + @PeriodID + ''') AS MT1001 ON MT1001.DivisionID = MT0400.DivisionID AND MT1001.ProductID = MT0400.ProductID
                            AND ISNULL(MT0400.PS01ID,'''') = ISNULL(MT1001.S01ID,'''') 
							AND ISNULL(MT0400.PS02ID,'''') = ISNULL(MT1001.S02ID,'''') 
							AND ISNULL(MT0400.PS03ID,'''') = ISNULL(MT1001.S03ID,'''') 
							AND ISNULL(MT0400.PS04ID,'''') = ISNULL(MT1001.S04ID,'''') 
							AND ISNULL(MT0400.PS05ID,'''') = ISNULL(MT1001.S05ID,'''') 
							AND ISNULL(MT0400.PS06ID,'''') = ISNULL(MT1001.S06ID,'''') 
							AND ISNULL(MT0400.PS07ID,'''') = ISNULL(MT1001.S07ID,'''') 
							AND ISNULL(MT0400.PS08ID,'''') = ISNULL(MT1001.S08ID,'''') 
							AND ISNULL(MT0400.PS09ID,'''') = ISNULL(MT1001.S09ID,'''') 
							AND ISNULL(MT0400.PS10ID,'''') = ISNULL(MT1001.S10ID,'''') 
							AND ISNULL(MT0400.PS11ID,'''') = ISNULL(MT1001.S11ID,'''') 
							AND ISNULL(MT0400.PS12ID,'''') = ISNULL(MT1001.S12ID,'''') 
							AND ISNULL(MT0400.PS13ID,'''') = ISNULL(MT1001.S13ID,'''') 
							AND ISNULL(MT0400.PS14ID,'''') = ISNULL(MT1001.S14ID,'''') 
							AND ISNULL(MT0400.PS15ID,'''') = ISNULL(MT1001.S15ID,'''') 
							AND ISNULL(MT0400.PS16ID,'''') = ISNULL(MT1001.S16ID,'''') 
							AND ISNULL(MT0400.PS17ID,'''') = ISNULL(MT1001.S17ID,'''') 
							AND ISNULL(MT0400.PS18ID,'''') = ISNULL(MT1001.S18ID,'''') 
							AND ISNULL(MT0400.PS19ID,'''') = ISNULL(MT1001.S19ID,'''') 
							AND ISNULL(MT0400.PS20ID,'''') = ISNULL(MT1001.S20ID,'''')
    WHERE MT0400.DivisionID = N'''+@DivisionID+''' AND PeriodID = N'''+ @PeriodID+''' AND ExpenseID IN (''COST002'', ''COST003'')
			AND ISNULL(MT1001.DivisionID,'''') <> '''' 
'
--PRINT @sSQL
--PRINT @sSQL1
IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV4622' AND Xtype ='V')
    EXEC ('CREATE VIEW MV4622 AS '+@sSQL + @sSQL1)
ELSE
    EXEC ('ALTER VIEW MV4622 AS '+@sSQL + @sSQL1)

-- Lay hieu so cua do dang dau ky va cuoi ky (NVL)
SET @sSQL ='
SELECT 
    DivisionID, 
    ProductID, 
    MaterialTypeID, 
    ExpenseID, 
    SUM(CASE WHEN Type = ''B'' THEN ProductQuantity ELSE -ProductQuantity END) AS ProductQuantity, 
    SUM(CASE WHEN Type = ''B'' THEN ConvertedAmount ELSE -ConvertedAmount END ) AS ConvertedAmount,
    ISNULL(MT1613.PS01ID, '''') AS PS01ID, 
	ISNULL(MT1613.PS02ID, '''') AS PS02ID, 
	ISNULL(MT1613.PS03ID, '''') AS PS03ID, 
	ISNULL(MT1613.PS04ID, '''') AS PS04ID, 
	ISNULL(MT1613.PS05ID, '''') AS PS05ID, 
	ISNULL(MT1613.PS06ID, '''') AS PS06ID, 
	ISNULL(MT1613.PS07ID, '''') AS PS07ID, 
	ISNULL(MT1613.PS08ID, '''') AS PS08ID, 
	ISNULL(MT1613.PS09ID, '''') AS PS09ID, 
	ISNULL(MT1613.PS10ID, '''') AS PS10ID,
    ISNULL(MT1613.PS11ID, '''') AS PS11ID, 
	ISNULL(MT1613.PS12ID, '''') AS PS12ID, 
	ISNULL(MT1613.PS13ID, '''') AS PS13ID, 
	ISNULL(MT1613.PS14ID, '''') AS PS14ID, 
	ISNULL(MT1613.PS15ID, '''') AS PS15ID, 
	ISNULL(MT1613.PS16ID, '''') AS PS16ID, 
	ISNULL(MT1613.PS17ID, '''') AS PS17ID, 
	ISNULL(MT1613.PS18ID, '''') AS PS18ID, 
	ISNULL(MT1613.PS19ID, '''') AS PS19ID, 
	ISNULL(MT1613.PS20ID, '''') AS PS20ID
FROM MT1613 WITH (NOLOCK)
WHERE PeriodID = N'''+ @PeriodID+''' AND ExpenseID IN (''COST002'', ''COST003'') 
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N'''+ @DivisionID+'''))
GROUP BY DivisionID, ProductID, MaterialTypeID, ExpenseID,
    MT1613.PS01ID, MT1613.PS02ID, MT1613.PS03ID, MT1613.PS04ID, MT1613.PS05ID, MT1613.PS06ID, MT1613.PS07ID, MT1613.PS08ID, MT1613.PS09ID, MT1613.PS10ID,
    MT1613.PS11ID, MT1613.PS12ID, MT1613.PS13ID, MT1613.PS14ID, MT1613.PS15ID, MT1613.PS16ID, MT1613.PS17ID, MT1613.PS18ID, MT1613.PS19ID, MT1613.PS20ID
'

IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV4722' AND Xtype ='V')
    EXEC ('CREATE VIEW MV4722 AS '+@sSQL)
ELSE
    EXEC ('ALTER VIEW MV4722 AS '+@sSQL)

---Chiet tinh

SET @Product_cur = CURSOR SCROLL KEYSET FOR
SELECT 
    ISNULL(V1.ProductID, V2.ProductID ) AS ProductID, 
    ISNULL(V1.MaterialTypeID, V2.MaterialTypeID) AS MaterialTypeID, 
    ISNULL(V1.ExpenseID, V2.ExpenseID) AS ExpenseID, 
    V1.ConvertedAmount, 
    V2.ConvertedAmount, 
    ISNULL( V1.ProductQuantity, V2.ProductQuantity) AS ProductQuantity,
    V1.PS01ID, V1.PS02ID, V1.PS03ID, V1.PS04ID, V1.PS05ID, V1.PS06ID, V1.PS07ID, V1.PS08ID, V1.PS09ID, V1.PS10ID,
    V1.PS11ID, V1.PS12ID, V1.PS13ID, V1.PS14ID, V1.PS15ID, V1.PS16ID, V1.PS17ID, V1.PS18ID, V1.PS19ID, V1.PS20ID 
FROM MV4622 V1 Full JOIN MV4722 V2 ON V2.DivisionID = V1.DivisionID 
AND V1.ProductID = V2.ProductID 
AND V1.MaterialTypeID = V2.MaterialTypeID
AND ISNULL(V1.PS01ID,'') = ISNULL(V2.PS01ID,'') 
AND ISNULL(V1.PS02ID,'') = ISNULL(V2.PS02ID,'') 
AND ISNULL(V1.PS03ID,'') = ISNULL(V2.PS03ID,'') 
AND ISNULL(V1.PS04ID,'') = ISNULL(V2.PS04ID,'') 
AND ISNULL(V1.PS05ID,'') = ISNULL(V2.PS05ID,'') 
AND ISNULL(V1.PS06ID,'') = ISNULL(V2.PS06ID,'') 
AND ISNULL(V1.PS07ID,'') = ISNULL(V2.PS07ID,'') 
AND ISNULL(V1.PS08ID,'') = ISNULL(V2.PS08ID,'') 
AND ISNULL(V1.PS09ID,'') = ISNULL(V2.PS09ID,'') 
AND ISNULL(V1.PS10ID,'') = ISNULL(V2.PS10ID,'') 
AND ISNULL(V1.PS11ID,'') = ISNULL(V2.PS11ID,'') 
AND ISNULL(V1.PS12ID,'') = ISNULL(V2.PS12ID,'') 
AND ISNULL(V1.PS13ID,'') = ISNULL(V2.PS13ID,'') 
AND ISNULL(V1.PS14ID,'') = ISNULL(V2.PS14ID,'') 
AND ISNULL(V1.PS15ID,'') = ISNULL(V2.PS15ID,'') 
AND ISNULL(V1.PS16ID,'') = ISNULL(V2.PS16ID,'') 
AND ISNULL(V1.PS17ID,'') = ISNULL(V2.PS17ID,'') 
AND ISNULL(V1.PS18ID,'') = ISNULL(V2.PS18ID,'') 
AND ISNULL(V1.PS19ID,'') = ISNULL(V2.PS19ID,'') 
AND ISNULL(V1.PS20ID,'') = ISNULL(V2.PS20ID,'')
where V1.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))

OPEN @Product_cur 
FETCH NEXT FROM @Product_cur INTO @ProductID, @MaterialTypeID, @ExpenseID, @ConvertedAmount1, @ConvertedAmount2, @ProductQuantity,
									@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
									@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
WHILE @@Fetch_Status = 0
    BEGIN 
        IF @ProductQuantity <> 0 
            SET @ConvertedUnit = round((ISNULL(@ConvertedAmount1, 0) + ISNULL(@ConvertedAmount2, 0))/@ProductQuantity, @ConvertedDecimal) 
        ELSE
            SET @ConvertedUnit = 0 

        EXEC AP0000 @DivisionID, @DetailCostID OUTPUT, 'MT4000', 'ID', @CMonth, @CYear, 16, 3, 0, '-' 
        
        INSERT INTO MT4000(DetailCostID, PeriodID, ProductID, ExpenseID, MaterialTypeID, ConvertedUnit, VoucherID, CreateDate, DivisionID, TranMonth, TranYear,
							PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)
        VALUES (@DetailCostID, @PeriodID, @ProductID, @ExpenseID, @MaterialTypeID, @ConvertedUnit, @VoucherID, GetDate(), @DivisionID, @TranMonth, @TranYear,
				@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
				@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID)

        FETCH NEXT FROM @Product_cur INTO @ProductID, @MaterialTypeID, @ExpenseID, @ConvertedAmount1, @ConvertedAmount2, @ProductQuantity,
											@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
											@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
    END 
CLOSE @Product_cur

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Xu ly lam tron
DECLARE @Detal AS DECIMAL(28, 8), 
@ID AS NVARCHAR(50)

SET @Product_cur = CURSOR SCROLL KEYSET FOR 
SELECT 
    ExpenseID, 
    ProductID, 
    SUM(ISNULL(ConvertedUnit, 0)) AS ConvertedUnit,
    PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
FROM MT4000  WITH (NOLOCK)
WHERE ExpenseID IN ('COST002', 'COST003') AND PeriodID = @PeriodID AND TranMonth = @TranMonth AND TranYear = @TranYear
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
GROUP BY ProductID, ExpenseID,
		PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID

OPEN @Product_cur 
FETCH NEXT FROM @Product_cur INTO @ExpenseID, @ProductID, @ConvertedUnit, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
								@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
WHILE @@Fetch_Status = 0
    BEGIN
        SELECT @Detal =0, @ID = '', @ConvertedAmount1 = 0, @ProductQuantity = 0 
        
        SET @ConvertedAmount1 = (SELECT SUM(ISNULL(ConvertedAmount, 0)) 
                                 FROM (SELECT SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount 
                                       FROM MT0400 WITH (NOLOCK)
                                       WHERE PeriodID = @PeriodID AND ExpenseID= @ExpenseID AND ProductID = @ProductID
											AND ISNULL(PS01ID,'') = ISNULL(@PS01ID,'') 
											AND ISNULL(PS02ID,'') = ISNULL(@PS02ID,'') 
											AND ISNULL(PS03ID,'') = ISNULL(@PS03ID,'') 
											AND ISNULL(PS04ID,'') = ISNULL(@PS04ID,'') 
											AND ISNULL(PS05ID,'') = ISNULL(@PS05ID,'') 
											AND ISNULL(PS06ID,'') = ISNULL(@PS06ID,'') 
											AND ISNULL(PS07ID,'') = ISNULL(@PS07ID,'') 
											AND ISNULL(PS08ID,'') = ISNULL(@PS08ID,'') 
											AND ISNULL(PS09ID,'') = ISNULL(@PS09ID,'') 
											AND ISNULL(PS10ID,'') = ISNULL(@PS10ID,'') 
											AND ISNULL(PS11ID,'') = ISNULL(@PS11ID,'') 
											AND ISNULL(PS12ID,'') = ISNULL(@PS12ID,'') 
											AND ISNULL(PS13ID,'') = ISNULL(@PS13ID,'') 
											AND ISNULL(PS14ID,'') = ISNULL(@PS14ID,'') 
											AND ISNULL(PS15ID,'') = ISNULL(@PS15ID,'') 
											AND ISNULL(PS16ID,'') = ISNULL(@PS16ID,'') 
											AND ISNULL(PS17ID,'') = ISNULL(@PS17ID,'') 
											AND ISNULL(PS18ID,'') = ISNULL(@PS18ID,'') 
											AND ISNULL(PS19ID,'') = ISNULL(@PS19ID,'') 
											AND ISNULL(PS20ID,'') = ISNULL(@PS20ID,'') 
                                           AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                       Union
                                       SELECT SUM(CASE WHEN Type = 'B' THEN ConvertedAmount ELSE (-ConvertedAmount) END ) AS ConvertedAmount
                                       FROM MT1613 WITH (NOLOCK)
                                       WHERE PeriodID = @PeriodID AND ExpenseID= @ExpenseID AND ProductID = @ProductID 
											AND ISNULL(PS01ID,'') = ISNULL(@PS01ID,'') 
											AND ISNULL(PS02ID,'') = ISNULL(@PS02ID,'') 
											AND ISNULL(PS03ID,'') = ISNULL(@PS03ID,'') 
											AND ISNULL(PS04ID,'') = ISNULL(@PS04ID,'') 
											AND ISNULL(PS05ID,'') = ISNULL(@PS05ID,'') 
											AND ISNULL(PS06ID,'') = ISNULL(@PS06ID,'') 
											AND ISNULL(PS07ID,'') = ISNULL(@PS07ID,'') 
											AND ISNULL(PS08ID,'') = ISNULL(@PS08ID,'') 
											AND ISNULL(PS09ID,'') = ISNULL(@PS09ID,'') 
											AND ISNULL(PS10ID,'') = ISNULL(@PS10ID,'') 
											AND ISNULL(PS11ID,'') = ISNULL(@PS11ID,'') 
											AND ISNULL(PS12ID,'') = ISNULL(@PS12ID,'') 
											AND ISNULL(PS13ID,'') = ISNULL(@PS13ID,'') 
											AND ISNULL(PS14ID,'') = ISNULL(@PS14ID,'') 
											AND ISNULL(PS15ID,'') = ISNULL(@PS15ID,'') 
											AND ISNULL(PS16ID,'') = ISNULL(@PS16ID,'') 
											AND ISNULL(PS17ID,'') = ISNULL(@PS17ID,'') 
											AND ISNULL(PS18ID,'') = ISNULL(@PS18ID,'') 
											AND ISNULL(PS19ID,'') = ISNULL(@PS19ID,'') 
											AND ISNULL(PS20ID,'') = ISNULL(@PS20ID,'')
											AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                 ) MV)

        SET @ProductQuantity = (SELECT SUM(MT1001.Quantity) 
                                FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 WITH (NOLOCK) ON MT1001.DivisionID = MT0810.DivisionID AND MT1001.VoucherID = MT0810.VoucherID
                                LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID AND O99.TableID = 'MT1001'
                                WHERE MT0810.ResultTypeID = 'R01' AND MT0810.PeriodID = @PeriodID AND ProductID = @ProductID
											AND ISNULL(S01ID,'') = ISNULL(@PS01ID,'') 
											AND ISNULL(S02ID,'') = ISNULL(@PS02ID,'') 
											AND ISNULL(S03ID,'') = ISNULL(@PS03ID,'') 
											AND ISNULL(S04ID,'') = ISNULL(@PS04ID,'') 
											AND ISNULL(S05ID,'') = ISNULL(@PS05ID,'') 
											AND ISNULL(S06ID,'') = ISNULL(@PS06ID,'') 
											AND ISNULL(S07ID,'') = ISNULL(@PS07ID,'') 
											AND ISNULL(S08ID,'') = ISNULL(@PS08ID,'') 
											AND ISNULL(S09ID,'') = ISNULL(@PS09ID,'') 
											AND ISNULL(S10ID,'') = ISNULL(@PS10ID,'') 
											AND ISNULL(S11ID,'') = ISNULL(@PS11ID,'') 
											AND ISNULL(S12ID,'') = ISNULL(@PS12ID,'') 
											AND ISNULL(S13ID,'') = ISNULL(@PS13ID,'') 
											AND ISNULL(S14ID,'') = ISNULL(@PS14ID,'') 
											AND ISNULL(S15ID,'') = ISNULL(@PS15ID,'') 
											AND ISNULL(S16ID,'') = ISNULL(@PS16ID,'') 
											AND ISNULL(S17ID,'') = ISNULL(@PS17ID,'') 
											AND ISNULL(S18ID,'') = ISNULL(@PS18ID,'') 
											AND ISNULL(S19ID,'') = ISNULL(@PS19ID,'') 
											AND ISNULL(S20ID,'') = ISNULL(@PS20ID,'')
											AND MT1001.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

		IF Isnull(@ProductQuantity,0) <> 0
			SET @Detal = round(@ConvertedAmount1/ @ProductQuantity, @ConvertedDecimal) - @ConvertedUnit
		ELSE
			SET @Detal = 0

        IF @Detal<>0
            BEGIN
                SET @ID = (SELECT TOP 1 DetailCostID 
                           FROM MT4000  WITH (NOLOCK)
                           WHERE ExpenseID = @ExpenseID AND ProductID = @ProductID AND PeriodID = @PeriodID
								AND ISNULL(PS01ID,'') = ISNULL(@PS01ID,'') 
								AND ISNULL(PS02ID,'') = ISNULL(@PS02ID,'') 
								AND ISNULL(PS03ID,'') = ISNULL(@PS03ID,'') 
								AND ISNULL(PS04ID,'') = ISNULL(@PS04ID,'') 
								AND ISNULL(PS05ID,'') = ISNULL(@PS05ID,'') 
								AND ISNULL(PS06ID,'') = ISNULL(@PS06ID,'') 
								AND ISNULL(PS07ID,'') = ISNULL(@PS07ID,'') 
								AND ISNULL(PS08ID,'') = ISNULL(@PS08ID,'') 
								AND ISNULL(PS09ID,'') = ISNULL(@PS09ID,'') 
								AND ISNULL(PS10ID,'') = ISNULL(@PS10ID,'') 
								AND ISNULL(PS11ID,'') = ISNULL(@PS11ID,'') 
								AND ISNULL(PS12ID,'') = ISNULL(@PS12ID,'') 
								AND ISNULL(PS13ID,'') = ISNULL(@PS13ID,'') 
								AND ISNULL(PS14ID,'') = ISNULL(@PS14ID,'') 
								AND ISNULL(PS15ID,'') = ISNULL(@PS15ID,'') 
								AND ISNULL(PS16ID,'') = ISNULL(@PS16ID,'') 
								AND ISNULL(PS17ID,'') = ISNULL(@PS17ID,'') 
								AND ISNULL(PS18ID,'') = ISNULL(@PS18ID,'') 
								AND ISNULL(PS19ID,'') = ISNULL(@PS19ID,'') 
								AND ISNULL(PS20ID,'') = ISNULL(@PS20ID,'')
                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                           Order BY ConvertedUnit Desc )
                           
                IF @ID is NOT NULL
                    Update MT4000 SET ConvertedUnit = ConvertedUnit + @Detal 
                    WHERE DetailCostID =@ID
                        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
            END
        FETCH NEXT FROM @Product_cur INTO @ExpenseID, @ProductID, @ConvertedUnit, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
    END 



SET @Product_cur = CURSOR SCROLL KEYSET FOR 
SELECT 
    ProductID, 
    SUM(ISNULL(ConvertedUnit, 0)) AS ConvertedUnit,
    PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
FROM MT4000  WITH (NOLOCK)
WHERE PeriodID = @PeriodID AND TranMonth = @TranMonth AND TranYear = @TranYear
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
GROUP BY ProductID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID

OPEN @Product_cur 
FETCH NEXT FROM @Product_cur INTO @ProductID, @ConvertedUnit, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
								@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
WHILE @@Fetch_Status = 0
    BEGIN
        SELECT @Detal =0, @ID = '', @ConvertedAmount1 = 0, @ProductQuantity = 0 
        
        SET @ConvertedAmount1 =(SELECT SUM(ISNULL(ConvertedAmount, 0)) 
                                FROM(SELECT SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount 
                                     FROM MT0400 WITH (NOLOCK)
                                     WHERE PeriodID = @PeriodID AND ProductID = @ProductID
											AND ISNULL(PS01ID,'') = ISNULL(@PS01ID,'') 
											AND ISNULL(PS02ID,'') = ISNULL(@PS02ID,'') 
											AND ISNULL(PS03ID,'') = ISNULL(@PS03ID,'') 
											AND ISNULL(PS04ID,'') = ISNULL(@PS04ID,'') 
											AND ISNULL(PS05ID,'') = ISNULL(@PS05ID,'') 
											AND ISNULL(PS06ID,'') = ISNULL(@PS06ID,'') 
											AND ISNULL(PS07ID,'') = ISNULL(@PS07ID,'') 
											AND ISNULL(PS08ID,'') = ISNULL(@PS08ID,'') 
											AND ISNULL(PS09ID,'') = ISNULL(@PS09ID,'') 
											AND ISNULL(PS10ID,'') = ISNULL(@PS10ID,'') 
											AND ISNULL(PS11ID,'') = ISNULL(@PS11ID,'') 
											AND ISNULL(PS12ID,'') = ISNULL(@PS12ID,'') 
											AND ISNULL(PS13ID,'') = ISNULL(@PS13ID,'') 
											AND ISNULL(PS14ID,'') = ISNULL(@PS14ID,'') 
											AND ISNULL(PS15ID,'') = ISNULL(@PS15ID,'') 
											AND ISNULL(PS16ID,'') = ISNULL(@PS16ID,'') 
											AND ISNULL(PS17ID,'') = ISNULL(@PS17ID,'') 
											AND ISNULL(PS18ID,'') = ISNULL(@PS18ID,'') 
											AND ISNULL(PS19ID,'') = ISNULL(@PS19ID,'') 
											AND ISNULL(PS20ID,'') = ISNULL(@PS20ID,'')
											AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                     Union
                                     SELECT SUM(CASE WHEN Type = 'B' THEN ConvertedAmount ELSE (-ConvertedAmount) END ) AS ConvertedAmount
                                     FROM MT1613 WITH (NOLOCK)
                                     WHERE PeriodID = @PeriodID AND ProductID = @ProductID
											AND ISNULL(PS01ID,'') = ISNULL(@PS01ID,'') 
											AND ISNULL(PS02ID,'') = ISNULL(@PS02ID,'') 
											AND ISNULL(PS03ID,'') = ISNULL(@PS03ID,'') 
											AND ISNULL(PS04ID,'') = ISNULL(@PS04ID,'') 
											AND ISNULL(PS05ID,'') = ISNULL(@PS05ID,'') 
											AND ISNULL(PS06ID,'') = ISNULL(@PS06ID,'') 
											AND ISNULL(PS07ID,'') = ISNULL(@PS07ID,'') 
											AND ISNULL(PS08ID,'') = ISNULL(@PS08ID,'') 
											AND ISNULL(PS09ID,'') = ISNULL(@PS09ID,'') 
											AND ISNULL(PS10ID,'') = ISNULL(@PS10ID,'') 
											AND ISNULL(PS11ID,'') = ISNULL(@PS11ID,'') 
											AND ISNULL(PS12ID,'') = ISNULL(@PS12ID,'') 
											AND ISNULL(PS13ID,'') = ISNULL(@PS13ID,'') 
											AND ISNULL(PS14ID,'') = ISNULL(@PS14ID,'') 
											AND ISNULL(PS15ID,'') = ISNULL(@PS15ID,'') 
											AND ISNULL(PS16ID,'') = ISNULL(@PS16ID,'') 
											AND ISNULL(PS17ID,'') = ISNULL(@PS17ID,'') 
											AND ISNULL(PS18ID,'') = ISNULL(@PS18ID,'') 
											AND ISNULL(PS19ID,'') = ISNULL(@PS19ID,'') 
											AND ISNULL(PS20ID,'') = ISNULL(@PS20ID,'') 
											AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                ) MV)

        SET @ProductQuantity = (SELECT SUM(MT1001.Quantity) 
                                FROM MT1001 WITH (NOLOCK) INNER JOIN MT0810 WITH (NOLOCK) ON MT1001.DivisionID = MT0810.DivisionID AND MT1001.VoucherID = MT0810.VoucherID
                                LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID AND O99.TableID = 'MT1001'
                                WHERE MT0810.ResultTypeID = 'R01' AND MT0810.PeriodID = @PeriodID AND ProductID = @ProductID
									AND ISNULL(S01ID,'') = ISNULL(@PS01ID,'') 
									AND ISNULL(S02ID,'') = ISNULL(@PS02ID,'') 
									AND ISNULL(S03ID,'') = ISNULL(@PS03ID,'') 
									AND ISNULL(S04ID,'') = ISNULL(@PS04ID,'') 
									AND ISNULL(S05ID,'') = ISNULL(@PS05ID,'') 
									AND ISNULL(S06ID,'') = ISNULL(@PS06ID,'') 
									AND ISNULL(S07ID,'') = ISNULL(@PS07ID,'') 
									AND ISNULL(S08ID,'') = ISNULL(@PS08ID,'') 
									AND ISNULL(S09ID,'') = ISNULL(@PS09ID,'') 
									AND ISNULL(S10ID,'') = ISNULL(@PS10ID,'') 
									AND ISNULL(S11ID,'') = ISNULL(@PS11ID,'') 
									AND ISNULL(S12ID,'') = ISNULL(@PS12ID,'') 
									AND ISNULL(S13ID,'') = ISNULL(@PS13ID,'') 
									AND ISNULL(S14ID,'') = ISNULL(@PS14ID,'') 
									AND ISNULL(S15ID,'') = ISNULL(@PS15ID,'') 
									AND ISNULL(S16ID,'') = ISNULL(@PS16ID,'') 
									AND ISNULL(S17ID,'') = ISNULL(@PS17ID,'') 
									AND ISNULL(S18ID,'') = ISNULL(@PS18ID,'') 
									AND ISNULL(S19ID,'') = ISNULL(@PS19ID,'') 
									AND ISNULL(S20ID,'') = ISNULL(@PS20ID,'')
                                    AND MT1001.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                )
		IF Isnull(@ProductQuantity,0) <> 0
			SET @Detal = round(@ConvertedAmount1/ @ProductQuantity, @ConvertedDecimal) - @ConvertedUnit
		ELSE
			SET @Detal = 0
			
        IF @Detal<>0
            BEGIN
                SET @ID = (SELECT TOP 1 DetailCostID 
                           FROM MT4000 WITH (NOLOCK)
                           WHERE ProductID = @ProductID AND PeriodID = @PeriodID
								AND ISNULL(PS01ID,'') = ISNULL(@PS01ID,'') 
								AND ISNULL(PS02ID,'') = ISNULL(@PS02ID,'') 
								AND ISNULL(PS03ID,'') = ISNULL(@PS03ID,'') 
								AND ISNULL(PS04ID,'') = ISNULL(@PS04ID,'') 
								AND ISNULL(PS05ID,'') = ISNULL(@PS05ID,'') 
								AND ISNULL(PS06ID,'') = ISNULL(@PS06ID,'') 
								AND ISNULL(PS07ID,'') = ISNULL(@PS07ID,'') 
								AND ISNULL(PS08ID,'') = ISNULL(@PS08ID,'') 
								AND ISNULL(PS09ID,'') = ISNULL(@PS09ID,'') 
								AND ISNULL(PS10ID,'') = ISNULL(@PS10ID,'') 
								AND ISNULL(PS11ID,'') = ISNULL(@PS11ID,'') 
								AND ISNULL(PS12ID,'') = ISNULL(@PS12ID,'') 
								AND ISNULL(PS13ID,'') = ISNULL(@PS13ID,'') 
								AND ISNULL(PS14ID,'') = ISNULL(@PS14ID,'') 
								AND ISNULL(PS15ID,'') = ISNULL(@PS15ID,'') 
								AND ISNULL(PS16ID,'') = ISNULL(@PS16ID,'') 
								AND ISNULL(PS17ID,'') = ISNULL(@PS17ID,'') 
								AND ISNULL(PS18ID,'') = ISNULL(@PS18ID,'') 
								AND ISNULL(PS19ID,'') = ISNULL(@PS19ID,'') 
								AND ISNULL(PS20ID,'') = ISNULL(@PS20ID,'') 
                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                           Order BY ConvertedUnit Desc)
                IF @ID is NOT NULL
                    Update MT4000 SET ConvertedUnit = ConvertedUnit + @Detal 
                    WHERE DetailCostID =@ID
                        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
            END
        FETCH NEXT FROM @Product_cur INTO @ProductID, @ConvertedUnit, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
    END
    
