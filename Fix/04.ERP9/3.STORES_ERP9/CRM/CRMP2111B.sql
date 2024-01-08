IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2111B]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2111B]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



/********************************************

-- <Summary>
--- Tính giá bình quân gia quyền
-- <History>
---		[Minh Dũng]  Create on 11/11/2023
---		[Minh Dũng]  Update on 28/11/2023: Lấy giá dựa theo quy cách
---</History>
----</Summary>

'********************************************/

CREATE PROCEDURE  [dbo].[CRMP2111B]
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT, 
    @ConvertedDecimals TINYINT, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromWareHouseID NVARCHAR(50), 
    @ToWareHouseID NVARCHAR(50), 
    @FromAccountID NVARCHAR(50), 
    @ToAccountID NVARCHAR(50)
AS

DECLARE
    @WareHouseID NVARCHAR(50), 
    @InventoryID NVARCHAR(50), 
    @AccountID NVARCHAR(50), 
    @TransactionID NVARCHAR(50), 
    @Indexs INT, 
    @VoucherID NVARCHAR(50), 
    @VoucherDate DATETIME, 
    @BeginQty DECIMAL(28, 8), 
    @BeginAmount DECIMAL(28, 8), 
    @DebitQty DECIMAL(28, 8), 
    @DebitAmount DECIMAL(28, 8), 
    @CreditQty DECIMAL(28, 8), 
    @CreditAmount DECIMAL(28, 8), 
    @UnitPrice DECIMAL(28, 8), 
    @CustomerName INT ,
    @cur CURSOR,
	@S01ID NVARCHAR (50),
	@S02ID NVARCHAR (50),
	@S03ID NVARCHAR (50),
	@S04ID NVARCHAR (50),
	@S05ID NVARCHAR (50),
	@S06ID NVARCHAR (50),
	@S07ID NVARCHAR (50),
	@S08ID NVARCHAR (50),
	@S09ID NVARCHAR (50),
	@S10ID NVARCHAR (50),
	@S11ID NVARCHAR (50),
	@S12ID NVARCHAR (50),
	@S13ID NVARCHAR (50),
	@S14ID NVARCHAR (50),
	@S15ID NVARCHAR (50),
	@S16ID NVARCHAR (50),
	@S17ID NVARCHAR (50),
	@S18ID NVARCHAR (50),
	@S19ID NVARCHAR (50),
	@S20ID NVARCHAR (50),

	@SQL nvarchar(max)
    
SET @SQL = ''   
    
    --Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 26 --- Customize PrintTech
	Exec AP1410_PT @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID
ELSE IF @CustomerName = 49 --- FIGLA
	Exec AP1410_FL @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID
ELSE
 BEGIN
	SELECT T6.DivisionID, 
		T6.KindVoucherID, 
		T6.WareHouseID, 
		T6.WareHouseID2, 
		T7.InventoryID, 
		T7.ActualQuantity, 
		T7.OriginalAmount, 
		T7.DebitAccountID, 
		T7.CreditAccountID, 
		T6.VoucherID, 
		T6.VoucherDate, 
		T7.TransactionID, 
		T7.S01ID,
		T7.S02ID,
		T7.S03ID,
		T7.S04ID,
		T7.S05ID,
		T7.S06ID,
		T7.S07ID,
		T7.S08ID,
		T7.S09ID,
		T7.S10ID,
		T7.S11ID,
		T7.S12ID,
		T7.S13ID,
		T7.S14ID,
		T7.S15ID,
		T7.S16ID,
		T7.S17ID,
		T7.S18ID,
		T7.S19ID,
		T7.S20ID,
		CASE WHEN T6.KindVoucherID IN (1, 5, 7) THEN 1
			WHEN T6.KindVoucherID = 3 THEN 2
			ELSE 3
		END AS Orders ,
		T6.CreateDate,
		T6.VoucherNo
	INTO #AT2007_Tmp1 
	FROM AT2006 T6 WITH (NOLOCK), 
		#AT2007_result T7 WITH (NOLOCK)
	WHERE T6.VoucherID = T7.VoucherID
		AND T6.DivisionID = T7.DivisionID
		AND T6.DivisionID = @DivisionID
		AND T6.TranMonth = @TranMonth
		AND T6.TranYear = @TranYear
		AND T7.InventoryID IN (SELECT InventoryID FROM AT1302 WITH (NOLOCK) WHERE MethodID = 5 AND DivisionID IN (@DivisionID,'@@@'))

SELECT TOP 0 * INTO #AT2007_Tmp FROM #AT2007_Tmp1
ALTER TABLE #AT2007_Tmp ADD Indexs INT NULL

	SET @SQL = 'INSERT INTO #AT2007_Tmp (DivisionID, KindVoucherID, WareHouseID, WareHouseID2, InventoryID,
	ActualQuantity, OriginalAmount, DebitAccountID, CreditAccountID, VoucherID, VoucherDate, TransactionID, Orders, CreateDate, Indexs,
	S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
	SELECT DivisionID, KindVoucherID, WareHouseID, WareHouseID2, InventoryID,
			ActualQuantity, OriginalAmount, DebitAccountID, CreditAccountID, VoucherID, VoucherDate, TransactionID, Orders, CreateDate, 
			ROW_NUMBER() over (order by VoucherDate,Orders,VoucherNo) AS Indexs,
			S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	FROM #AT2007_Tmp1
	ORDER BY VoucherDate,
			Orders,
				VoucherNo'
	EXEC(@SQL)

	DROP TABLE #AT2007_Tmp1

	SET @cur = CURSOR STATIC FOR
	SELECT VoucherID, 
		VoucherDate, 
		TransactionID, 
		CASE WHEN KindVoucherID = 3 THEN WarehouseID2 
			ELSE WarehouseID 
		END AS WarehouseID, 
		InventoryID, 
		CreditAccountID, 
		Indexs,
		S01ID,
		S02ID,
		S03ID,
		S04ID,
		S05ID,
		S06ID,
		S07ID,
		S08ID,
		S09ID,
		S10ID,
		S11ID,
		S12ID,
		S13ID,
		S14ID,
		S15ID,
		S16ID,
		S17ID,
		S18ID,
		S19ID,
		S20ID
	FROM #AT2007_Tmp
	WHERE KindVoucherID IN (2, 3, 4, 6, 8, 10)
		AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
		AND (CASE WHEN KindVoucherID = 3 THEN WarehouseID2 ELSE WarehouseID END) BETWEEN @FromWareHouseID AND @ToWareHouseID
		AND CreditAccountID BETWEEN @FromAccountID AND @ToAccountID 
	ORDER BY Indexs
	OPEN @Cur

	FETCH NEXT FROM @Cur INTO @VoucherID, @VoucherDate, @TransactionID, @WarehouseID, @InventoryID, @AccountID, @Indexs,
		@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

		print (@InventoryID)
		print (@WarehouseID)
		print (@VoucherID)

		
	WHILE @@Fetch_Status = 0
		BEGIN
			SELECT @BeginQty = ROUND(BeginQuantity, @QuantityDecimals), 
				@BeginAmount = ROUND(BeginAmount, @ConvertedDecimals) 
			FROM At2008 WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranMonth = @TranMonth
				AND TranYear = @TranYear
				AND WarehouseID = @WarehouseID
				AND InventoryID = @InventoryID 
				AND InventoryAccountID = @AccountID
				AND (S01ID = @S01ID OR (ISNULL(S01ID, '') =  ISNULL(@S01ID, '')))
				AND (S02ID = @S02ID OR (ISNULL(S02ID, '') =  ISNULL(@S02ID, '')))
				AND (S03ID = @S03ID OR (ISNULL(S03ID, '') =  ISNULL(@S03ID, '')))
				AND (S04ID = @S04ID OR (ISNULL(S04ID, '') =  ISNULL(@S04ID, '')))
				AND (S05ID = @S05ID OR (ISNULL(S05ID, '') =  ISNULL(@S05ID, '')))
				AND (S06ID = @S06ID OR (ISNULL(S06ID, '') =  ISNULL(@S06ID, '')))
				AND (S07ID = @S07ID OR (ISNULL(S07ID, '') =  ISNULL(@S07ID, '')))
				AND (S08ID = @S08ID OR (ISNULL(S08ID, '') =  ISNULL(@S08ID, '')))
				AND (S09ID = @S09ID OR (ISNULL(S09ID, '') =  ISNULL(@S09ID, '')))
				AND (S10ID = @S10ID OR (ISNULL(S10ID, '') =  ISNULL(@S10ID, '')))
				AND (S11ID = @S11ID OR (ISNULL(S11ID, '') =  ISNULL(@S11ID, '')))
				AND (S12ID = @S12ID OR (ISNULL(S12ID, '') =  ISNULL(@S12ID, '')))
				AND (S13ID = @S13ID OR (ISNULL(S13ID, '') =  ISNULL(@S13ID, '')))
				AND (S14ID = @S14ID OR (ISNULL(S14ID, '') =  ISNULL(@S14ID, '')))
				AND (S15ID = @S15ID OR (ISNULL(S15ID, '') =  ISNULL(@S15ID, '')))
				AND (S16ID = @S16ID OR (ISNULL(S16ID, '') =  ISNULL(@S16ID, '')))
				AND (S17ID = @S17ID OR (ISNULL(S17ID, '') =  ISNULL(@S17ID, '')))
				AND (S18ID = @S18ID OR (ISNULL(S18ID, '') =  ISNULL(@S18ID, '')))
				AND (S19ID = @S19ID OR (ISNULL(S19ID, '') =  ISNULL(@S19ID, '')))
				AND (S20ID = @S20ID OR (ISNULL(S20ID, '') =  ISNULL(@S20ID, '')))

			SELECT @DebitQty = ROUND(ISNULL(SUM(ISNULL(ActualQuantity, 0)), 0), @QuantityDecimals), 
				@DebitAmount = ROUND(ISNULL(SUM(ISNULL(OriginalAmount, 0)), 0), @ConvertedDecimals)
			FROM #AT2007_Tmp
			WHERE KindVoucherID IN (1, 3, 5, 7)
				AND WareHouseID = @WarehouseID
				AND InventoryID = @InventoryID
				AND DebitAccountID = @AccountID
				AND VoucherDate < = @VoucherDate
				AND Indexs < @Indexs
				AND (S01ID = @S01ID OR (ISNULL(S01ID, '') =  ISNULL(@S01ID, '')))
				AND (S02ID = @S02ID OR (ISNULL(S02ID, '') =  ISNULL(@S02ID, '')))
				AND (S03ID = @S03ID OR (ISNULL(S03ID, '') =  ISNULL(@S03ID, '')))
				AND (S04ID = @S04ID OR (ISNULL(S04ID, '') =  ISNULL(@S04ID, '')))
				AND (S05ID = @S05ID OR (ISNULL(S05ID, '') =  ISNULL(@S05ID, '')))
				AND (S06ID = @S06ID OR (ISNULL(S06ID, '') =  ISNULL(@S06ID, '')))
				AND (S07ID = @S07ID OR (ISNULL(S07ID, '') =  ISNULL(@S07ID, '')))
				AND (S08ID = @S08ID OR (ISNULL(S08ID, '') =  ISNULL(@S08ID, '')))
				AND (S09ID = @S09ID OR (ISNULL(S09ID, '') =  ISNULL(@S09ID, '')))
				AND (S10ID = @S10ID OR (ISNULL(S10ID, '') =  ISNULL(@S10ID, '')))
				AND (S11ID = @S11ID OR (ISNULL(S11ID, '') =  ISNULL(@S11ID, '')))
				AND (S12ID = @S12ID OR (ISNULL(S12ID, '') =  ISNULL(@S12ID, '')))
				AND (S13ID = @S13ID OR (ISNULL(S13ID, '') =  ISNULL(@S13ID, '')))
				AND (S14ID = @S14ID OR (ISNULL(S14ID, '') =  ISNULL(@S14ID, '')))
				AND (S15ID = @S15ID OR (ISNULL(S15ID, '') =  ISNULL(@S15ID, '')))
				AND (S16ID = @S16ID OR (ISNULL(S16ID, '') =  ISNULL(@S16ID, '')))
				AND (S17ID = @S17ID OR (ISNULL(S17ID, '') =  ISNULL(@S17ID, '')))
				AND (S18ID = @S18ID OR (ISNULL(S18ID, '') =  ISNULL(@S18ID, '')))
				AND (S19ID = @S19ID OR (ISNULL(S19ID, '') =  ISNULL(@S19ID, '')))
				AND (S20ID = @S20ID OR (ISNULL(S20ID, '') =  ISNULL(@S20ID, '')))

			SELECT @CreditQty = ROUND(ISNULL(SUM(ISNULL(ActualQuantity, 0)), 0), @QuantityDecimals), 
				@CreditAmount = ROUND(ISNULL(SUM(ISNULL(OriginalAmount, 0)), 0), @ConvertedDecimals)
			FROM #AT2007_Tmp
			WHERE KindVoucherID IN (2, 3, 4, 6, 8, 10)
				AND @WarehouseID = (CASE WHEN KindVoucherID = 3 THEN WareHouseID2 ELSE WarehouseID END)
				AND InventoryID = @InventoryID
				AND CreditAccountID = @AccountID
				AND VoucherDate < = @VoucherDate
				AND Indexs < @Indexs


			IF @BeginQty + @DebitQty - @CreditQty <> 0
				BEGIN
					SET @UnitPrice = ROUND(((@BeginAmount + @DebitAmount - @CreditAmount)/(@BeginQty + @DebitQty - @CreditQty)), @UnitCostDecimals)
	                
					UPDATE #AT2007_Result1 WITH (ROWLOCK)
					SET UnitPrice = @UnitPrice,
						ConvertedPrice =  @UnitPrice,
						OriginalAmount = ROUND((@UnitPrice * ROUND(ActualQuantity, @QuantityDecimals)), @ConvertedDecimals), 
						ConvertedAmount = ROUND((@UnitPrice * ROUND(ActualQuantity, @QuantityDecimals)), @ConvertedDecimals) 
					from #AT2007_result
					left join AT2006 ON AT2006.VoucherID = #AT2007_result.VoucherID
					WHERE #AT2007_result.VoucherID = @VoucherID 
						AND TransactionID = @TransactionID
						AND #AT2007_result.DivisionID = @DivisionID
						AND KindVoucherID <> 10

					UPDATE #AT2007_Tmp
					SET OriginalAmount = ROUND((@UnitPrice * ROUND(ActualQuantity, @QuantityDecimals)), @ConvertedDecimals)
					from #AT2007_Tmp
					left join AT2006 ON AT2006.VoucherID = #AT2007_Tmp.VoucherID
					WHERE #AT2007_Tmp.VoucherID = @VoucherID 
						AND  TransactionID = @TransactionID
						AND AT2006.KindVoucherID <> 10
				END
			ELSE
				BEGIN
					SET @UnitPrice = 0
					UPDATE #AT2007_result WITH (ROWLOCK)
					SET UnitPrice = @UnitPrice,
						ConvertedPrice =  @UnitPrice, 
						OriginalAmount = 0, 
						ConvertedAmount = 0 
					from #AT2007_result
					left join AT2006 ON AT2006.VoucherID = #AT2007_result.VoucherID
					WHERE #AT2007_result.VoucherID = @VoucherID 
						AND TransactionID = @TransactionID
						AND #AT2007_result.DivisionID = @DivisionID
						AND KindVoucherID <> 10

					UPDATE #AT2007_Tmp
					SET OriginalAmount = 0
					from #AT2007_Tmp
					left join AT2006 ON AT2006.VoucherID = #AT2007_Tmp.VoucherID
					WHERE #AT2007_Tmp.VoucherID = @VoucherID 
						AND  TransactionID = @TransactionID
						AND AT2006.KindVoucherID <> 10
				END

			FETCH NEXT FROM @Cur INTO @VoucherID, @VoucherDate, @TransactionID, @WarehouseID, @InventoryID, @AccountID, @Indexs,
		@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
		END
END