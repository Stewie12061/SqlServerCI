IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1308_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1308_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Tieu Mai on 02/03/2017
--------- Purpose: Áp giá xuất kho cho các phiếu VCNB cho ANGEL
--------- Modified on 26/03/2018 by Bảo Anh: không cập nhật giá cho phiếu VCNB bất kể có phải là phiếu trả lại hàng không
--------- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

--- AP1308 'PL',11,2013,2,2,0
CREATE PROCEDURE [dbo].[AP1308_AG] 
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
    @BQGQ_cur CURSOR

SET @BQGQ_Cur = CURSOR SCROLL KEYSET FOR 
	SELECT AV1309.WareHouseID, 
		InventoryID, 
		UnitPrice, 
		InventoryAccountID 
	FROM AV1309
	LEFT JOIN AT1303 ON AT1303.WareHouseID = AV1309.WareHouseID AND AT1303.DivisionID IN ( @DivisionID , '@@@')
	WHERE EXISTS
	(
		SELECT 1 
		FROM AT20072 WITH (NOLOCK)
		WHERE KindVoucherID = 3 and InventoryID = AV1309.InventoryID
	)
	ORDER BY InventoryID,
		Isnull(AT1303.IndexCount,0)  ---- Sắp xếp theo thứ tự kho
 
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
			
		------ ANGEL không làm tròn số lẻ đơn giá theo thiết lập
		
		UPDATE AT2007
		SET UnitPrice = ROUND(@UnitPrice, @UnitCostDecimals), 
			ConvertedPrice =  ROUND(@UnitPrice, @UnitCostDecimals),
			OriginalAmount = ROUND(ROUND(@UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals), 
			ConvertedAmount = ROUND(ROUND(@UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals) 
			FROM AT20072 AT2007 WITH (ROWLOCK)
			WHERE AT2007.KindVoucherID = 3 ---- Xac dinh la xuat van chuyen noi bo
				AND AT2007.InventoryID = @InventoryID
				AND AT2007.CreditAccountID = @AccountID
				AND (CASE WHEN ISNULL(IsReturn,0) = 0 THEN AT2007.WareHouseID2 ELSE AT2007.WareHouseID END) = @WareHouseID
				AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0

		FETCH NEXT FROM @BQGQ_cur INTO @WareHouseID, @InventoryID, @UnitPrice, @AccountID
	END
CLOSE @BQGQ_cur


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
