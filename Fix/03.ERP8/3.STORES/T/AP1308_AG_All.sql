IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1308_AG_All]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1308_AG_All]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--------- Created by Tieu Mai on 02/03/2017
--------- Purpose: Áp giá xuất kho cho các phiếu VCNB cho ANGEL
--------- Modified on 26/03/2018 by Bảo Anh: không cập nhật giá cho phiếu VCNB bất kể có phải là phiếu trả lại hàng không
--------- Modified on Huỳnh Thử on 05/05/2020: Tách riêng store cho Angel, Tính giá all kho

--- AP1308 'PL',11,2013,2,2,0
CREATE PROCEDURE [dbo].[AP1308_AG_All] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT, 
    @ConvertedDecimals TINYINT
   
AS

DECLARE 
    @InventoryID NVARCHAR(50), 
    @AccountID NVARCHAR(50), 
    @DetalAmount DECIMAL(28, 8), 
    @UnitPrice DECIMAL(28, 8), 
    @BQGQ_cur CURSOR

SET @BQGQ_Cur = CURSOR SCROLL KEYSET FOR 
	SELECT 
		InventoryID, 
		UnitPrice, 
		InventoryAccountID 
	FROM AV1309
	WHERE EXISTS
	(
		SELECT 1 
		FROM AT20072 WITH (NOLOCK)
		WHERE KindVoucherID = 3 and InventoryID = AV1309.InventoryID
	)
	ORDER BY InventoryID
 
OPEN @BQGQ_cur
FETCH NEXT FROM @BQGQ_cur INTO  @InventoryID, @UnitPrice, @AccountID

WHILE @@Fetch_Status = 0
	BEGIN --- Cap nhat gia xuat kho cho xuat van chuyen noi bo
			
		SET @UnitPrice = 
		(
			SELECT TOP 1 UnitPrice 
			FROM AV1309 
			WHERE InventoryID = @InventoryID 
			AND InventoryAccountID = @AccountID
			AND DivisionID = @DivisionID 
		)

	--	SELECT 
	--	InventoryID, 
	--	UnitPrice, 
	--	InventoryAccountID 
	--FROM AV1309
	--WHERE InventoryID = @InventoryID AND InventoryAccountID = @AccountID

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
				AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0

		FETCH NEXT FROM @BQGQ_cur INTO  @InventoryID, @UnitPrice, @AccountID
	END
CLOSE @BQGQ_cur



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
