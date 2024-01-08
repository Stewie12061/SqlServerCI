IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Tiểu Mai on 16/06/2016
--------- Purpose: Tinh gia binh quan gia quyen cuoi ky theo quy cách
--------- Modify on 18/05/2017 by Bảo Anh: Sửa danh mục dùng chung
--------- Modified by Phương Thảo on 31/08/2016: Bổ sung WITH(ROWLOCK) cho đoạn áp giá phiếu lắp ráp
--------- Modified by Phương Thảo on 16/08/2017: Bổ sung áp giá cho phiếu nhập kho trả lại
--------- Modified by Bảo Anh on 28/12/2017: Trừ thêm tiền giảm giá hàng mua khi tính đơn giá ở AV1309
--------- Modified by Kim Thư on 05/06/2019: Sửa lỗi where @DivisionID bảng AT1101
--------- Modified by Kim Thư on 27/06/2019: Bỏ điều kiện @CountUpdate1 > 0 để xét làm tròn
--------- Modified by Kim Thư on 04/07/2019: Bổ sung điều kiện WarehouseID và AccountID khi kiểm tra làm tròn (vì có trường hợp ko tính giá tất cả kho / mặt hàng / tài khoản)
--------- Modified by Trà Giang on 27/07/2019: Xử lý Tính giá xuất PP bình quân gia quyền cho MH sử dụng quy cách.
--------- Modified by Hoàng Trúc on 24/09/2019: bỏ đoạn update cho giá trị phiếu VCNB = 0
--------- Modified by Huỳnh Thử on 08/11/2019: Trừ độ chênh lệnh giữa giá thành và giá xuất kho cho phiếu xuất có số lượng lớn nhất
--------- Modified by Huỳnh Thử on 26/11/2019: Xử lý làm tròn khi số lượng hết, cộng sôs lệnh cho phiếu xuất có số lượng lớn nhất
--------- Modified by Huỳnh Thử on 10/12/2019: Thêm Điều kiện Theo Kho (WareHouseID)
--------- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

--- exec AP1309_QC @DivisionID=N'AN',@TranMonth=1,@TranYear=2016,@FromInventoryID=N'02J51648-BL',@ToInventoryID=N'WSJEDA',@FromWareHouseID=N'NPL',@ToWareHouseID=N'TPXN5',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN'

CREATE PROCEDURE [dbo].[AP1309_QC] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromWareHouseID NVARCHAR(50), 
    @ToWareHouseID NVARCHAR(50), 
    @FromAccountID NVARCHAR(50), 
    @ToAccountID NVARCHAR(50),
    @UserID NVARCHAR(50),
    @GroupID NVARCHAR (50)
AS

DECLARE 
    @sSQL NVARCHAR(4000), 
    @sSQL1 NVARCHAR(4000),
    @sSQL2 NVARCHAR(4000),
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT,
    @ConvertedDecimals TINYINT,
    @CustomerName INT

SET NOCOUNT ON

SELECT @QuantityDecimals = QuantityDecimals, 
    @UnitCostDecimals = UnitCostDecimals, 
    @ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK)
WHERE DivisionID =@DivisionID

SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)
-- Ghi lai history
Insert into HistoryInfo(TableID, ModifyUserID, ModifyDate, Action, VoucherNo, TransactionTypeID, DivisionID)
Values ('WF0056', @UserID, GETDATE(), 9, @GroupID,'',@DivisionID)

--Cap nhat gia xuat tra lai hang mua = gia cua phieu tra lai hang mua
UPDATE AT2007 
SET AT2007.UnitPrice = (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) ELSE 0 END),
	AT2007.ConvertedPrice =  (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) ELSE 0 END),
    OriginalAmount = AT9000.ConvertedAmount, 
    ConvertedAmount = AT9000.ConvertedAmount
FROM AT2007 
    INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
    INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT2007.DivisionID AND AT9000.VoucherID = AT2007.VoucherID AND AT9000.TransactionID = AT2007.TransactionID
WHERE AT2007.DivisionID =@DivisionID
    AND AT2006.KindVoucherID = 10 
    AND AT2006.TranMonth = @TranMonth 
    AND AT2006.TranYear = @TranYear 
    AND AT9000.TransactionTypeID = 'T25' 
    AND AT9000.TranMonth = @TranMonth 
    AND AT9000.TranYear = @TranYear


--UPDATE AT2007 
--SET UnitPrice = 0,
--	ConvertedPrice = 0, 
--	OriginalAmount = 0, 
--	ConvertedAmount = 0
--FROM AT2007 
--	INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
--	INNER Join AT1302 WITH (NOLOCK) ON AT2007.InventoryID = AT1302.InventoryID
--WHERE AT2007.TranMonth = @TranMonth 
--	AND AT2007.TranYear = @TranYear
--	AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
--	AND MethodID IN (4, 5)
--	AND WareHouseID2 BETWEEN @FromWareHouseID AND @ToWareHouseID 
--	AND CreditAccountID BETWEEN @FromAccountID AND @ToAccountID 
--	AND KindVoucherID = 3
--	AND AT2007.DivisionID = @DivisionID


------------ Xu ly chi tiet gia 

------ Ap gia nhap nhap nguyen vat lieu phat sinh tu dong tu xuat thanh pham
	IF EXISTS 
	(
		SELECT TOP 1 1 
		FROM AT2007  WITH (NOLOCK)
			INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
		WHERE AT2007.DivisionID = @DivisionID 
		AND AT2007.TranMonth = @TranMonth 
		AND AT2007.TranYear = @TranYear 
		AND KindVoucherID = 1 
		AND At1302.MethodID = 4
		AND (IsGoodsRecycled = 1 OR AT2006.IsReturn = 1)
	) 
		EXEC AP13082 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals


----------- Tinh gia xuat kho binh quan lien hoan
IF EXISTS 
(
    SELECT TOP 1 1 
    FROM AT2007 WITH (NOLOCK) 
        INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
    WHERE AT2007.DivisionID = @DivisionID 
    AND AT2007.TranMonth = @TranMonth 
    AND AT2007.TranYear = @TranYear 
    AND KindVoucherID IN (2, 3, 4, 6, 8) 
    AND AT1302.MethodID = 5
)
BEGIN 
    EXEC AP1410_QC @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals, 
    @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID
END

/*	UPDATE AT2008_QC
SET AT2008_QC.UnitPrice = AV1309_QC.UnitPrice
FROM AT2008_QC 
INNER JOIN AV1309_QC ON AV1309_QC.DivisionID = AT2008_QC.DivisionID AND AV1309_QC.InventoryID = AT2008_QC.InventoryID AND AV1309_QC.WareHouseID = AT2008_QC.WareHouseID AND AV1309_QC.InventoryAccountID = AT2008_QC.InventoryAccountID
WHERE AT2008_QC.TranMonth = @TranMonth 
    AND AT2008_QC.TranYear = @TranYear 
    AND AT2008_QC.DivisionID = @DivisionID
    AND ISNULL(AT2008_QC.S01ID,'') = Isnull(AV1309_QC.S01ID,'')
	AND ISNULL(AT2008_QC.S02ID,'') = isnull(AV1309_QC.S02ID,'') 
	AND ISNULL(AT2008_QC.S03ID,'') = isnull(AV1309_QC.S03ID,'') 	
	AND ISNULL(AT2008_QC.S04ID,'') = isnull(AV1309_QC.S04ID,'') 
	AND ISNULL(AT2008_QC.S05ID,'') = isnull(AV1309_QC.S05ID,'') 
	AND ISNULL(AT2008_QC.S06ID,'') = isnull(AV1309_QC.S06ID,'') 
	AND ISNULL(AT2008_QC.S07ID,'') = isnull(AV1309_QC.S07ID,'') 
	AND ISNULL(AT2008_QC.S08ID,'') = isnull(AV1309_QC.S08ID,'') 
	AND ISNULL(AT2008_QC.S09ID,'') = isnull(AV1309_QC.S09ID,'') 
	AND ISNULL(AT2008_QC.S10ID,'') = isnull(AV1309_QC.S10ID,'') 
	AND ISNULL(AT2008_QC.S11ID,'') = isnull(AV1309_QC.S11ID,'') 
	AND ISNULL(AT2008_QC.S12ID,'') = isnull(AV1309_QC.S12ID,'') 
	AND ISNULL(AT2008_QC.S13ID,'') = isnull(AV1309_QC.S13ID,'') 
	AND ISNULL(AT2008_QC.S14ID,'') = isnull(AV1309_QC.S14ID,'') 
	AND ISNULL(AT2008_QC.S15ID,'') = isnull(AV1309_QC.S15ID,'') 
	AND ISNULL(AT2008_QC.S16ID,'') = isnull(AV1309_QC.S16ID,'') 
	AND ISNULL(AT2008_QC.S17ID,'') = isnull(AV1309_QC.S17ID,'') 
	AND ISNULL(AT2008_QC.S18ID,'') = isnull(AV1309_QC.S18ID,'') 
	AND ISNULL(AT2008_QC.S19ID,'') = isnull(AV1309_QC.S19ID,'')
	AND ISNULL(AT2008_QC.S20ID,'') = isnull(AV1309_QC.S20ID,'')    
*/
----------- Tinh gia TTDD
IF EXISTS 
(
    SELECT TOP 1 1 
    FROM AT2007 WITH (NOLOCK) 
        INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
    WHERE AT2007.DivisionID = @DivisionID 
    AND AT2007.TranMonth = @TranMonth 
    AND AT2007.TranYear = @TranYear 
    AND KindVoucherID IN (2, 3, 4, 6, 8) 
    AND At1302.MethodID = 3
) 
	EXEC AP1305 @DivisionID, @TranMonth, @TranYear


------------ Tinh gia xuat kho theo PP FIFO 
IF EXISTS 
(
    SELECT TOP 1 1 
    FROM AT2007  WITH (NOLOCK)
        INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
    WHERE AT2007.DivisionID = @DivisionID 
        AND AT2007.TranMonth = @TranMonth 
        AND AT2007.TranYear = @TranYear 
        AND KindVoucherID IN (2, 3, 4, 6, 8) 
        AND At1302.MethodID = 1
) 
begin
    EXEC AP1303 @DivisionID, @TranMonth, @TranYear,   @FromInventoryID,   @ToInventoryID, @FromWareHouseID, @ToWareHouseID
	return -- da xu ly lam trong trong store AP1303 nen thoat luon khong vo doan lam trong ben duoi nua
end

----- XU LY LAM TRON	
DECLARE 
    @InventoryID AS NVARCHAR(50), 
    @AccountID AS NVARCHAR(50), 
    @Amount AS DECIMAL(28, 8), 
    @WareHouseID AS NVARCHAR(50), 
    @Cur AS CURSOR, 
    @TransactionID AS NVARCHAR(50), 
    @Cur_Ware AS CURSOR, 
    @CountUpdate INT,
    @CountUpdate1 INT,
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
    @S20ID VARCHAR(50),
    @TotalOriginAmout AS DECIMAL(28, 8), 
	@TotalConverAmout AS DECIMAL(28, 8),  
	@CreditAmount AS DECIMAL(28, 8), 
	@DebitAmount AS DECIMAL(28, 8)

Recal: 

	SET @CountUpdate1 = 0
	SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
		SELECT WareHouseID, 
			AT2008.InventoryID, 
			InventoryAccountID, 
			EndAmount,
			AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID,
			AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID 
		FROM AT2008_QC AT2008 WITH (NOLOCK) ---inner join AT1302 on AT2008.DivisionID = AT1302.DivisionID and AT2008.InventoryID = AT1302.InventoryID
		WHERE TranMonth = @TranMonth 
			AND TranYear = @TranYear 
			AND EndQuantity = 0 
			AND AT2008.EndAmount <> 0 
			AND AT2008.DivisionID = @DivisionID 
			AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
			AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
			AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)

	OPEN @Cur_Ware
	FETCH NEXT FROM @Cur_Ware INTO  @WareHouseID, @InventoryID, @AccountID, @Amount, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

	WHILE @@Fetch_Status = 0 
		BEGIN
				SET @TransactionID = 
				(
					SELECT TOP 1 D11.TransactionID
					FROM AT2007 D11 WITH (NOLOCK)
						LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
						INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
						LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D11.DivisionID AND WT8899.VoucherID = D11.VoucherID AND WT8899.TransactionID = D11.TransactionID
					WHERE D11.InventoryID = @InventoryID 
						AND D11.TranMonth = @TranMonth
						AND D11.TranYear = @TranYear
						AND D11.DivisionID = @DivisionID
						AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID 
						AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 
						AND D11.CreditAccountID = @AccountID
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
					ORDER BY CASE WHEN D9.KindVoucherID = 3 THEN 1 ELSE 0 END,  
							 CASE WHEN D11.ActualQuantity = D12.ActualQuantity AND D11.ConvertedAmount < D12.ConvertedAmount THEN 0 ELSE 1 END, D11.ActualQuantity DESC
				)			
				IF @TransactionID IS NOT NULL
					BEGIN
						UPDATE AT2007 
						SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @Amount, 
							OriginalAmount = ISNULL(OriginalAmount, 0) + @Amount
						FROM AT2007 
						WHERE AT2007.TransactionID = @TransactionID and AT2007.DivisionID = @DivisionID
						SET @CountUpdate1 = @CountUpdate1 + 1
						
						UPDATE WT8899 
						SET QC_ConvertedAmount = ISNULL(QC_ConvertedAmount, 0) + @Amount, 
							QC_OriginalAmount = ISNULL(QC_OriginalAmount, 0) + @Amount
						FROM WT8899 
						WHERE WT8899.TransactionID = @TransactionID and WT8899.DivisionID = @DivisionID
						SET @CountUpdate1 = @CountUpdate1 + 1

					END

			
			FETCH NEXT FROM @Cur_Ware INTO @WareHouseID, @InventoryID, @AccountID, @Amount, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
		END 

	CLOSE @Cur_Ware

----- Trừ Độ Chênh Lệnh Cho Phiếu Có Số Lượng Xuất Cao Nhất

	SET @CountUpdate1 = 0
	SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
		SELECT WareHouseID, 
			AT2008.InventoryID, 
			InventoryAccountID, 
			AT2008.CreditAmount,
			AT2008.DebitAmount,
			AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID,
			AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID 
		FROM AT2008_QC AT2008 WITH (NOLOCK) ---inner join AT1302 on AT2008.DivisionID = AT1302.DivisionID and AT2008.InventoryID = AT1302.InventoryID
		WHERE TranMonth = @TranMonth 
			AND TranYear = @TranYear 
			AND AT2008.DivisionID = @DivisionID 
			AND AT2008.EndAmount = 0
			AND AT2008.EndQuantity = 0
			AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
			AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
			AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
            AND ( AT2008.DebitAmount <> 0 or AT2008.CreditAmount <> 0)

	OPEN @Cur_Ware
	FETCH NEXT FROM @Cur_Ware INTO  @WareHouseID, @InventoryID, @AccountID, @CreditAmount, @DebitAmount, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

	WHILE @@Fetch_Status = 0 
		BEGIN
				SET @TransactionID = 
				(
					SELECT TOP 1 D11.TransactionID
					FROM AT2007 D11 WITH (NOLOCK)
						LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
						INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
						LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D11.DivisionID AND WT8899.VoucherID = D11.VoucherID AND WT8899.TransactionID = D11.TransactionID
					WHERE D11.InventoryID = @InventoryID 
						AND D11.TranMonth = @TRANMONTH
						AND D11.TranYear = @TRANYEAR
						AND D11.DivisionID = @DivisionID
						AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID 
						AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 
						AND D11.CreditAccountID = @AccountID
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
					ORDER BY CASE WHEN D9.KindVoucherID = 3 THEN 1 ELSE 0 END,  
							 CASE WHEN D11.ActualQuantity = D12.ActualQuantity AND D11.ConvertedAmount < D12.ConvertedAmount THEN 0 ELSE 1 END, D11.ActualQuantity DESC
				)			
				IF @TransactionID IS NOT NULL
					BEGIN
						--- Trừ độ chênh lệnh cho phiếu xuất có số lượng lớn nhất

						SELECT @TotalOriginAmout = SUM(OriginalAmount), @TotalConverAmout = SUM(ConvertedAmount) FROM AT2007 
						LEFT JOIN	AT2006 ON	AT2006.VoucherID = AT2007.VoucherID
						WHERE AT2006.TRANMONTH = @TranMonth
							 AND AT2006.TRANYEAR = @TranYear
							 AND AT2006.DIVISIONID = @DIVISIONID
							 AND InventoryID = @InventoryID
							 AND KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 
						AND CreditAccountID = @AccountID
						AND (CASE WHEN AT2006.KindVoucherID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) = @WareHouseID
						DECLARE @Differrence AS DECIMAL(28,8)
						SET @Differrence = @TotalConverAmout - @DebitAmount
						UPDATE AT2007 
						SET ConvertedAmount = ISNULL(ConvertedAmount, 0) -  ( ISNULL(@TotalConverAmout, 0) -ISNULL(@CreditAmount, 0) ) , 
							OriginalAmount = ISNULL(OriginalAmount, 0) -  ( ISNULL(@TotalOriginAmout, 0)  - ISNULL(@CreditAmount, 0) )
						FROM AT2007 
						WHERE AT2007.TransactionID = @TransactionID and AT2007.DivisionID = @DivisionID
						SET @CountUpdate1 = @CountUpdate1 + 1
					END

			
			FETCH NEXT FROM @Cur_Ware INTO @WareHouseID, @InventoryID, @AccountID, @CreditAmount,@DebitAmount, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
		END 

	CLOSE @Cur_Ware



--IF EXISTS (SELECT TOP 1 1 
--    FROM AT2008_QC   WITH (NOLOCK)
--    WHERE TranMonth = @TranMonth 
--        AND TranYear = @TranYear 
--        AND EndQuantity = 0 
--        AND EndAmount <> 0 
--        AND DivisionID = @DivisionID
--		AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
--		AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
--		AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
--) 
--    --AND @CountUpdate1 > 0
--    BEGIN
--	GOTO ReCal
--	END
SET NOCOUNT OFF











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
