IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1308]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1308]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Nguyen Van Nhan, Date 06/09/2003
--------- Purpose: Tinh gia binh quan gia quyen cuoi ky cho truong hop xuat van chuyen noi bo
--------- Edit by: Dang Le Bao Quynh; Date 01/08/2008
--------- Purpose: Chuyen tat cac xu ly lam tron ra ngoai store AP1309
--------- Edit by: Dang Le Bao Quynh; Date 22/12/2008
--------- Purpose: Sap xep thu tu truoc khi tinh gia, uu tien gia cao tinh truoc
--------- Modify on 27/12/2013 by Bảo Anh: Dùng biến table @AV1309 thay AV1309 để cải thiện tốc độ
--------- Modify on 20/02/2014 by Bảo Anh: Không dùng biến table @AV1309 thay AV1309 nữa vì tính giá xuất không đúng
--------- Modify on 18/08/2015 by Tiểu Mai: Bổ sung đơn giá quy đổi = đơn giá chuẩn
--------- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
--------- Modified by Bảo Anh on 11/07/2016: Bổ sung WITH (ROWLOCK)
--------- Modified by Tiểu Mai on 14/11/2016: Bổ sung chỉnh sửa cho ANGEL (ko làm tròn số lẻ đơn giá)
--------- Modified by Tiểu Mai on 29/06/2017: Bổ sung tham số @TransProcessesID (quy trình chuyển kho)
--------- Modified by Bảo Anh on 21/05/2018: Sắp xếp thứ tự kho trước khi tính giá
--------- Modified by Nhật Thanh on 16/02/2023: Bỏ điều kiện áp giá theo Orders
/********************************************
'* Edited by: [GS] [Việt Khánh] [29/07/2010]
'********************************************/
--- AP1308 'PL',11,2013,2,2,0
CREATE PROCEDURE [dbo].[AP1308] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT, 
    @ConvertedDecimals TINYINT,
    @TransProcessesID NVARCHAR(50)
   
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
    @BQGQ_cur CURSOR,
	@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 58 --- Customize Ngan Ha
	EXEC AP1308_NH @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
ELSE 
IF @CustomerName = 57 --- Customize Angel
	EXEC AP1308_AG @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
ELSE 
BEGIN
	IF ISNULL(@TransProcessesID,'') <> ''   ----- Chọn quy trình chuyển kho
	BEGIN 
		SET @BQGQ_Cur = CURSOR SCROLL KEYSET FOR 
			SELECT AV1309.WareHouseID, 
				AV1309.InventoryID, 
				UnitPrice, 
				InventoryAccountID 
			FROM AV1309
			LEFT JOIN AT1332 WITH (NOLOCK) ON AT1332.InventoryID = AV1309.InventoryID AND AT1332.DivisionID = AV1309.DivisionID AND AT1332.VoucherID = @TransProcessesID
			LEFT JOIN AT1333 WITH (NOLOCK) ON AT1333.DivisionID = AT1332.DivisionID AND AT1333.VoucherID = AT1332.VoucherID AND AT1333.WareHouseID = AV1309.WareHouseID
			WHERE AV1309.InventoryID IN 
			(
				SELECT InventoryID 
				FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
				WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranMonth = @TranMonth
				AND AT2007.TranYear = @TranYear 
				AND KindVoucherID = 3
			)
			ORDER BY ISNULL(AT1333.Orders,0), AV1309.WareHouseID
	END 
	ELSE  -------- Sắp xếp như cách cũ
	BEGIN
		--- lấy danh sách các phiếu VCNB trong tháng
		SELECT distinct InventoryID, CreditAccountID as InventoryAccountID, WareHouseID2, WareHouseID, NULL AS Orders
		INTO #AT2007
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
		WHERE AT2007.DivisionID = @DivisionID AND AT2007.TranMonth = @TranMonth and AT2007.TranYear = @TranYear	and AT2006.KindVoucherID = 3
		AND EXISTS (Select 1 From AV1309 Where InventoryID = AT2007.InventoryID)			

		--- Update thứ tự = min đối với các kho chỉ có xuất, không nhập
		UPDATE #AT2007 SET Orders = 0
		WHERE NOT EXISTS (Select 1 From #AT2007 T1 Where T1.InventoryID = #AT2007.InventoryID And T1.WareHouseID = #AT2007.WareHouseID2)

		--- Update thứ tự = max đối với các kho chỉ có nhập, không xuất
		UPDATE #AT2007 SET Orders = 9999
		WHERE NOT EXISTS (Select 1 From #AT2007 T1 Where T1.InventoryID = #AT2007.InventoryID And T1.WareHouseID2 = #AT2007.WareHouseID)

		SET @BQGQ_Cur = CURSOR SCROLL KEYSET FOR 
			SELECT AV1309.WareHouseID, 
				AV1309.InventoryID, 
				AV1309.UnitPrice, 
				AV1309.InventoryAccountID 
			FROM AV1309
			INNER JOIN #AT2007 ON AV1309.InventoryID = #AT2007.InventoryID AND AV1309.InventoryAccountID = #AT2007.InventoryAccountID AND AV1309.WareHouseID = #AT2007.WareHouseID2
			ORDER BY AV1309.InventoryID,
				ISNULL(#AT2007.Orders, 1),
				ActBegTotal DESC, 
				ActBegQty DESC, 
				UnitPrice DESC, 
				ActReceivedQty DESC
	END 
	
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
					WHERE AT2006.KindVoucherID = 3 ---- Xac dinh la xuat van chuyen noi bo
						AND AT2007.InventoryID = @InventoryID 
						AND AT2007.TranMonth = @TranMonth 
						AND AT2007.TranYear = @TranYear 
						AND AT2007.DivisionID = @DivisionID 
						AND AT2007.CreditAccountID = @AccountID 
						AND AT2006.WareHouseID2 = @WareHouseID
                
			SET @DetalAmount = 0
			
			FETCH NEXT FROM @BQGQ_cur INTO @WareHouseID, @InventoryID, @UnitPrice, @AccountID
		END
	CLOSE @BQGQ_cur
	
END	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
