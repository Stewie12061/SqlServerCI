IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1308_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1308_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Tiểu Mai
--------- Purpose: Tách store Tính giá bình quân gia quyền cuối kỳ cho trường hợp xuất VCNB cho mặt hàng theo quy cách.
--------- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
--------- Modified by Tiểu Mai on 16/06/2016: Fix tính giá xuất kho chưa đúng

--- AP1308_QC 'PL',11,2013,2,2,0
CREATE PROCEDURE [dbo].[AP1308_QC] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT, 
    @ConvertedDecimals TINYINT
   
AS

DECLARE 
    @InventoryID NVARCHAR(50), 
    @WareHouseID NVARCHAR(50), 
    @AccountID NVARCHAR(50), 
    @DetalAmount DECIMAL(28, 8), 
    @UnitPrice DECIMAL(28, 8), 
    @BQGQ_cur CURSOR,
    @S01ID VARCHAR(50),
	@S02ID VARCHAR(50),
    @S03ID VARCHAR(50),
    @S04ID VARCHAR(50),
    @S05ID VARCHAR(50),
    @S06ID VARCHAR(50),
    @S07ID VARCHAR(50),
    @S08ID VARCHAR(50),
    @S09ID VARCHAR(50),
    @S10ID VARCHAR(50),
    @S11ID VARCHAR(50),
    @S12ID VARCHAR(50),
    @S13ID VARCHAR(50),
    @S14ID VARCHAR(50),
    @S15ID VARCHAR(50),
    @S16ID VARCHAR(50),
    @S17ID VARCHAR(50),
    @S18ID VARCHAR(50),
    @S19ID VARCHAR(50),
    @S20ID VARCHAR(50) 

SET @BQGQ_Cur = CURSOR SCROLL KEYSET FOR 
    SELECT WareHouseID, 
        AV1309_QC.InventoryID, 
        UnitPrice, 
        InventoryAccountID,
        AV1309_QC.S01ID, AV1309_QC.S02ID, AV1309_QC.S03ID, AV1309_QC.S04ID, AV1309_QC.S05ID, AV1309_QC.S06ID, AV1309_QC.S07ID, AV1309_QC.S08ID, AV1309_QC.S09ID, AV1309_QC.S10ID,
        AV1309_QC.S11ID, AV1309_QC.S12ID, AV1309_QC.S13ID, AV1309_QC.S14ID, AV1309_QC.S15ID, AV1309_QC.S16ID, AV1309_QC.S17ID, AV1309_QC.S18ID, AV1309_QC.S19ID, AV1309_QC.S20ID
    FROM AV1309_QC
    LEFT JOIN 
    (
        SELECT AT2007.DivisionID, InventoryID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
        O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID 
        FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
        LEFT JOIN WT8899 O99 ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID
        WHERE AT2007.DivisionID = @DivisionID 
        AND AT2007.TranMonth = @TranMonth 
        AND AT2007.TranYear = @TranYear 
        AND KindVoucherID = 3
    ) A ON A.DivisionID = AV1309_QC.DivisionID AND A.InventoryID = AV1309_QC.InventoryID
				AND ISNULL(A.S01ID,'') = Isnull(AV1309_QC.S01ID,'')
				AND ISNULL(A.S02ID,'') = isnull(AV1309_QC.S02ID,'') 
				AND ISNULL(A.S03ID,'') = isnull(AV1309_QC.S03ID,'') 	
				AND ISNULL(A.S04ID,'') = isnull(AV1309_QC.S04ID,'') 
				AND ISNULL(A.S05ID,'') = isnull(AV1309_QC.S05ID,'') 
				AND ISNULL(A.S06ID,'') = isnull(AV1309_QC.S06ID,'') 
				AND ISNULL(A.S07ID,'') = isnull(AV1309_QC.S07ID,'') 
				AND ISNULL(A.S08ID,'') = isnull(AV1309_QC.S08ID,'') 
				AND ISNULL(A.S09ID,'') = isnull(AV1309_QC.S09ID,'') 
				AND ISNULL(A.S10ID,'') = isnull(AV1309_QC.S10ID,'') 
				AND ISNULL(A.S11ID,'') = isnull(AV1309_QC.S11ID,'') 
				AND ISNULL(A.S12ID,'') = isnull(AV1309_QC.S12ID,'') 
				AND ISNULL(A.S13ID,'') = isnull(AV1309_QC.S13ID,'') 
				AND ISNULL(A.S14ID,'') = isnull(AV1309_QC.S14ID,'') 
				AND ISNULL(A.S15ID,'') = isnull(AV1309_QC.S15ID,'') 
				AND ISNULL(A.S16ID,'') = isnull(AV1309_QC.S16ID,'') 
				AND ISNULL(A.S17ID,'') = isnull(AV1309_QC.S17ID,'') 
				AND ISNULL(A.S18ID,'') = isnull(AV1309_QC.S18ID,'') 
				AND ISNULL(A.S19ID,'') = isnull(AV1309_QC.S19ID,'')
				AND ISNULL(A.S20ID,'') = isnull(AV1309_QC.S20ID,'')
WHERE ISNULL(A.DivisionID,'') <> ''
ORDER BY AV1309_QC.InventoryID, 
        ActBegTotal DESC, 
        ActBegQty DESC, 
        UnitPrice DESC, 
        ActReceivedQty DESC 
 
OPEN @BQGQ_cur
FETCH NEXT FROM @BQGQ_cur INTO @WareHouseID, @InventoryID, @UnitPrice, @AccountID, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
    @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

WHILE @@Fetch_Status = 0
    BEGIN --- Cap nhat gia xuat kho cho xuat van chuyen noi bo
    ---- Chưa hiểu đoạn này
        --SET @UnitPrice = 
        --(
        --    SELECT *
        --    FROM AV1309_QC 
        --    WHERE WareHouseID = @WareHouseID 
        --    AND InventoryID = @InventoryID 
        --    AND InventoryAccountID = @AccountID
        --    AND DivisionID = @DivisionID
        --    AND S01ID = @S01ID		AND S02ID = @S02ID		AND S03ID = @S03ID		AND S04ID = @S04ID		AND S05ID = @S05ID
        --    AND S06ID = @S06ID		AND S07ID = @S07ID		AND S08ID = @S08ID		AND S09ID = @S09ID		AND S10ID = @S10ID
        --    AND S11ID = @S11ID		AND S12ID = @S12ID		AND S13ID = @S13ID		AND S14ID = @S14ID		AND S15ID = @S15ID
        --    AND S16ID = @S16ID		AND S17ID = @S17ID		AND S18ID = @S18ID		AND S19ID = @S19ID		AND S20ID = @S20ID 
        --)
        
        UPDATE AT2007
        SET UnitPrice = ROUND(@UnitPrice, @UnitCostDecimals), 
			ConvertedPrice =  ROUND(@UnitPrice, @UnitCostDecimals),
            OriginalAmount = ROUND(ROUND(@UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals), 
            ConvertedAmount = ROUND(ROUND(@UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals) 
            FROM AT2007 WITH (ROWLOCK)  INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
            LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = AT2007.DivisionID AND WT8899.VoucherID = AT2007.VoucherID AND WT8899.TransactionID = AT2007.TransactionID
            WHERE AT2006.KindVoucherID = 3 ---- Xac dinh la xuat van chuyen noi bo
                AND AT2007.InventoryID = @InventoryID 
                AND AT2007.TranMonth = @TranMonth 
                AND AT2007.TranYear = @TranYear 
                AND AT2007.DivisionID = @DivisionID 
                AND AT2007.CreditAccountID = @AccountID 
                AND AT2006.WareHouseID2 = @WareHouseID
                AND ISNULL(WT8899.S01ID,'') = Isnull(@S01ID,'')
				AND ISNULL(WT8899.S02ID,'') = isnull(@S02ID,'') 
				AND ISNULL(WT8899.S03ID,'') = isnull(@S03ID,'') 	
				AND ISNULL(WT8899.S04ID,'') = isnull(@S04ID,'') 
				AND ISNULL(WT8899.S05ID,'') = isnull(@S05ID,'') 
				AND ISNULL(WT8899.S06ID,'') = isnull(@S06ID,'') 
				AND ISNULL(WT8899.S07ID,'') = isnull(@S07ID,'') 
				AND ISNULL(WT8899.S08ID,'') = isnull(@S08ID,'') 
				AND ISNULL(WT8899.S09ID,'') = isnull(@S09ID,'') 
				AND ISNULL(WT8899.S10ID,'') = isnull(@S10ID,'') 
				AND ISNULL(WT8899.S11ID,'') = isnull(@S11ID,'') 
				AND ISNULL(WT8899.S12ID,'') = isnull(@S12ID,'') 
				AND ISNULL(WT8899.S13ID,'') = isnull(@S13ID,'') 
				AND ISNULL(WT8899.S14ID,'') = isnull(@S14ID,'') 
				AND ISNULL(WT8899.S15ID,'') = isnull(@S15ID,'') 
				AND ISNULL(WT8899.S16ID,'') = isnull(@S16ID,'') 
				AND ISNULL(WT8899.S17ID,'') = isnull(@S17ID,'') 
				AND ISNULL(WT8899.S18ID,'') = isnull(@S18ID,'') 
				AND ISNULL(WT8899.S19ID,'') = isnull(@S19ID,'')
				AND ISNULL(WT8899.S20ID,'') = isnull(@S20ID,'')
                
        SET @DetalAmount = 0
		--PRINT @UnitPrice
		
        FETCH NEXT FROM @BQGQ_cur INTO @WareHouseID, @InventoryID, @UnitPrice, @AccountID, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
    @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
    END
CLOSE @BQGQ_cur
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
