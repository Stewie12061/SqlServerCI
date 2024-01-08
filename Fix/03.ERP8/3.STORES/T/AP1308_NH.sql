IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1308_NH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1308_NH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NOCOUNT ON
GO
--------- Created by Lê Thị Mỹ Tuyền, Date 22/03/2016: 
--------- Purpose: Tinh gia binh quan gia quyen cuoi ky cho truong hop xuat van chuyen noi bo (Customize Ngân Hà)
--------- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
--------- Modified by Bảo Anh on 11/07/2016: Bổ sung WITH (ROWLOCK)
--------- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

--- AP1308 'PL',11,2013,2,2,0
CREATE PROCEDURE [dbo].[AP1308_NH] 
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
    @TransactionID NVARCHAR(50), 
    @WareHouseID1 NVARCHAR(50), 
    @InventoryID1 NVARCHAR(50), 
    @DetalAmount DECIMAL(28, 8), 
    @DetalQuantity DECIMAL(28, 8), 
    @UnitPrice DECIMAL(28, 8), 
    @ActEndTotal DECIMAL(28, 8), 
    @BQGQ_cur CURSOR 

SET @BQGQ_Cur = CURSOR SCROLL KEYSET FOR 
    SELECT AV1309.WareHouseID, 
        InventoryID, 
        UnitPrice, 
        InventoryAccountID 
    FROM AV1309
    Left Join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (@DivisionID,'@@@') AND AV1309.WarehouseID = AT1303.WarehouseID
    WHERE EXISTS 
    (
        SELECT 1 
        FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
        WHERE AT2007.DivisionID = @DivisionID 
        AND AT2007.TranMonth = @TranMonth 
        AND AT2007.TranYear = @TranYear
		AND AT2007.InventoryID = AV1309.InventoryID
        AND AT2006.KindVoucherID = 3
    )
    ORDER BY cast (AT1303.Address as int),
        InventoryID, 
        ActBegTotal DESC, 
        ActBegQty DESC, 
        UnitPrice DESC, 
        ActReceivedQty DESC 
 
OPEN @BQGQ_cur
FETCH NEXT FROM @BQGQ_cur INTO @WareHouseID, @InventoryID, @UnitPrice, @AccountID

WHILE @@Fetch_Status = 0
    BEGIN --- Cap nhat gia xuat kho cho xuat van chuyen noi bo
        SET @UnitPrice = 
        (
            SELECT TOP 1 UnitPrice 
            FROM AV1309 
            WHERE WareHouseID = @WareHouseID 
            AND InventoryID = @InventoryID 
            AND InventoryAccountID = @AccountID
            AND DivisionID = @DivisionID 
        )
        
        UPDATE AT2007
        SET UnitPrice = ROUND(@UnitPrice, @UnitCostDecimals), 
			ConvertedPrice =  ROUND(@UnitPrice, @UnitCostDecimals),
            OriginalAmount = ROUND(ROUND(@UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals), 
            ConvertedAmount = ROUND(ROUND(@UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals) 
            FROM AT2007 WITH (ROWLOCK)
			INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
            WHERE	AT2007.DivisionID = @DivisionID
				AND AT2007.TranMonth = @TranMonth 
                AND AT2007.TranYear = @TranYear
				AND AT2007.InventoryID = @InventoryID
				AND AT2007.CreditAccountID = @AccountID
				AND AT2006.KindVoucherID = 3 ---- Xac dinh la xuat van chuyen noi bo                
                AND AT2006.WareHouseID2 = @WareHouseID
                
        SET @DetalAmount = 0
/* 
SET @DetalAmount = ISNULL((SELECT EndAmount FROM AT2008
WHERE DivisionID = @DivisionID AND 
TranMonth = @TranMonth AND
TranYear = @TranYear AND
InventoryID = @InventoryID AND
WareHouseID = @WareHouseID AND
InventoryAccountID = @AccountID AND
ROUND(EndQuantity, 2) = 0 AND
EndAmount <>0), 0)
SET @DetalQuantity = ISNULL((SELECT EndQuantity FROM AT2008
WHERE DivisionID = @DivisionID AND 
TranMonth = @TranMonth AND
TranYear = @TranYear AND
InventoryID = @InventoryID AND
WareHouseID = @WareHouseID AND
InventoryAccountID = @AccountID AND
ROUND(EndQuantity, 2) = 0 AND
EndAmount <>0), 0)
IF @DetalAmount <> 0 ---- 
Exec AP1306 @TranMonth, @TranYear, @DivisionID, @WareHouseID, @InventoryID, 
@AccountID, @DetalAmount, @DetalQuantity --- Xu ly so le
*/ 
        FETCH NEXT FROM @BQGQ_cur INTO @WareHouseID, @InventoryID, @UnitPrice, @AccountID
    END
CLOSE @BQGQ_cur

GO
SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON