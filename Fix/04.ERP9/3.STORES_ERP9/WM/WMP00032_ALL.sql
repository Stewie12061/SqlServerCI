IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP00032_ALL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP00032_ALL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by Hoài Bảo on 26/07/2022
---- Purpose: Tính giá xuất kho trường hợp tất cả kho - Kế thừa từ store AP1309_ALL
---- Modify on ... by ...
--- exec WMP00032_ALL @DivisionID=N'NH',@TranMonth=3,@TranYear=2016,@FromInventoryID=N'BS04K004',@ToInventoryID=N'BS04K004',@FromWareHouseID=N'DN010',@ToWareHouseID=N'ZS003',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN'

CREATE PROCEDURE [dbo].[WMP00032_ALL] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @FromInventoryID NVARCHAR(50) = '',
	@ToInventoryID NVARCHAR(50) = '',
    @WareHouseID NVARCHAR(MAX),
    @UserID NVARCHAR(50),
    @GroupID NVARCHAR (50),
    @TransProcessesID NVARCHAR(50),
	@IsAllWareHouse TINYINT = 0 -- Tính giá không phân biệt kho ( 1: check, 0: không check)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	-- Thay thế store AP1309_QC
	EXEC WMP00032_QC @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @WareHouseID, @UserID, @GroupID
ELSE
BEGIN
	DECLARE 
		@sSQL NVARCHAR(4000), 
		@sSQL1 NVARCHAR(4000),
		@sSQL2 NVARCHAR(4000),
		@QuantityDecimals TINYINT, 
		@UnitCostDecimals TINYINT,
		@ConvertedDecimals TINYINT,
		@CustomerName INT

	--Tao bang tam de kiem tra day co phai la khach hang TBIV khong (CustomerName = 29)
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

		SELECT @QuantityDecimals = QuantityDecimals, 
				@UnitCostDecimals = UnitCostDecimals, 
				@ConvertedDecimals = ConvertedDecimals
		FROM AT1101 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID

		SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
		SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
		SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)

		-- Ghi lai history
		INSERT INTO HistoryInfo(TableID, ModifyUserID, ModifyDate, Action, VoucherNo, TransactionTypeID, DivisionID)
		VALUES ('WMF0003', @UserID, GETDATE(), 9, @GroupID,'',@DivisionID)

		--Cap nhat gia xuat tra lai hang mua = gia cua phieu tra lai hang mua
		UPDATE AT2007 
		SET AT2007.UnitPrice = (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) ELSE 0 END),
			AT2007.ConvertedPrice =  (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) ELSE 0 END),
			OriginalAmount = AT9000.ConvertedAmount, 
			ConvertedAmount = AT9000.ConvertedAmount
		FROM AT2007 WITH (ROWLOCK)
			INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
			INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT2007.DivisionID AND AT9000.VoucherID = AT2007.VoucherID AND AT9000.TransactionID = AT2007.TransactionID

		WHERE AT2007.DivisionID =@DivisionID
			AND AT2007.TranMonth = @TranMonth 
			AND AT2007.TranYear = @TranYear 
			AND AT2006.KindVoucherID = 10
			AND AT9000.TransactionTypeID = 'T25' 
			AND AT9000.TranMonth = @TranMonth 
			AND AT9000.TranYear = @TranYear
	
		IF @CustomerName <> 49 --- <> FIGLA
		BEGIN
			-- Reset giá các phiếu VCNB với các mặt hàng tính giá theo phương pháp bình quân
			UPDATE AT2007
					SET UnitPrice = 0,
						ConvertedPrice = 0, 
						OriginalAmount = 0, 
						ConvertedAmount = 0
			FROM AT2007 WITH (ROWLOCK) INNER JOIN AT2006  WITH (NOLOCK) ON AT2006.VOUCHERID = AT2007.VOUCHERID
			INNER JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT2007.InventoryID = AT1302.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranMonth = @TranMonth 
				AND AT2007.TranYear = @TranYear
				AND AT2007.CreditAccountID LIKE N'%'
				AND AT1302.MethodID IN (5)
				AND AT2006.KindVoucherID = 3
		END

		------------ Xu ly chi tiet gia 
		
		------ Ap gia nhap nhap nguyen vat lieu phat sinh tu dong tu xuat thanh pham
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007  WITH (NOLOCK)
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON  AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranMonth = @TranMonth 
			AND AT2007.TranYear = @TranYear 
			AND KindVoucherID = 1 
			AND At1302.MethodID = 4
			AND (IsGoodsRecycled = 1 OR AT2006.IsReturn = 1)
		) 
		BEGIN
			PRINT (N'Ap gia nhap nhap nguyen vat lieu phat sinh tu dong tu xuat thanh pham')
			EXEC AP13082 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
		END

	
		----------- Tinh gia xuat kho binh quan lien hoan
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON  AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranMonth = @TranMonth 
			AND AT2007.TranYear = @TranYear 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND AT1302.MethodID = 5
		)
		BEGIN 
			PRINT (N'Tinh gia xuat kho binh quan lien hoan')
			-- Thay thế cho store AP1410_ALL
			EXEC WMP00034_ALL @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals, 
				@FromInventoryID, @ToInventoryID, @WareHouseID
		END

		----------- Tinh gia TTDD
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON  AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranMonth = @TranMonth 
			AND AT2007.TranYear = @TranYear 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND At1302.MethodID = 3
		) 
		BEGIN
			PRINT (N'Tinh gia TTDD')
			-- Mặc định tính giá TTDD cho tất cả tài khoản
			EXEC AP1305 @DivisionID, @TranMonth, @TranYear
		END
		
		------------ Tinh gia xuat kho theo PP FIFO 
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007  WITH (NOLOCK)
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON  AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranMonth = @TranMonth 
				AND AT2007.TranYear = @TranYear 
				AND KindVoucherID IN (2, 3, 4, 6, 8) 
				AND At1302.MethodID = 1
		) 
		BEGIN
			--Thay thế store AP1303
			EXEC WMP00033 @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @WareHouseID
			--return -- da xu ly lam trong trong store AP1303 nen thoat luon khong vo doan lam trong ben duoi nua
		END
	END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
