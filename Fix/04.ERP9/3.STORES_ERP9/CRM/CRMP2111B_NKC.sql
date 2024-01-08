IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2111B_NKC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2111B_NKC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Láy dữ liệu bảng giá và giá bình quân gia quyền
----</Summary>
-- <Return>
----
-- <Reference>
----
-- <History>
---		[Minh Dũng]  Create on 11/11/2023
---		[Minh Dũng]  Update on 28/11/2023: Lấy giá dựa theo quy cách
---</History>

Create PROCEDURE [dbo].[CRMP2111B_NKC]
(
    @DivisionID VARCHAR(50),
	@MaterialID VARCHAR(50)='',
	@MaterialName VARCHAR(50)='',
	@UnitName VARCHAR(50) = '',
	@XML XML,
	@S01ID VARCHAR(50) = '',
	@S02ID VARCHAR(50) = '',
	@S03ID VARCHAR(50) = '',
	@S04ID VARCHAR(50) = '',
	@S05ID VARCHAR(50) = '',
	@S06ID VARCHAR(50) = '',
	@S07ID VARCHAR(50) = '',
	@S08ID VARCHAR(50) = '',
	@S09ID VARCHAR(50) = '',
	@S10ID VARCHAR(50) = '',
	@S11ID VARCHAR(50) = '',
	@S12ID VARCHAR(50) = '',
	@S13ID VARCHAR(50) = '',
	@S14ID VARCHAR(50) = '',
	@S15ID VARCHAR(50) = '',
	@S16ID VARCHAR(50) = '',
	@S17ID VARCHAR(50) = '',
	@S18ID VARCHAR(50) = '',
	@S19ID VARCHAR(50) = '',
	@S20ID VARCHAR(50) = '',
	@APK VARCHAR(50) = '',
	@NodeTypeName NVARCHAR(50) = '',
	@Quantity DECIMAL(28,8) = 0,
	@UnitPrice DECIMAL (28, 8)= 0,
	@UnitPriceAverage DECIMAL (28, 8) = 0,
	@Amount DECIMAL (28,8) = 0,
	@TranMonth VARCHAR(50),
	@TranYear VARCHAR(50),
	@PriceListID NVARCHAR(50),
	@FromWareHouseID NVARCHAR(50),
	@ToWareHouseID NVARCHAR(50),
	@FromAccountID NVARCHAR(50),
	@ToAccountID NVARCHAR(50)
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL01 NVARCHAR(MAX) = N'',
		@sSQL02 NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@CheckQC INT,
		@masterCursor CURSOR,
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex),
		@FromInventoryID NVARCHAR(50),
		@ToInventoryID NVARCHAR(50),
		@TranMonthStart INT,
		@TranYearStart INT,
		@CurrentMonth INT,
		@CurrentYear INT,
		@Status BIT = 1,
		@Price DECIMAL(28,8)

BEGIN

SELECT 
	X.Data.query('APK').value('.','NVARCHAR(100)') AS APK,
	X.Data.query('MaterialID').value('.','NVARCHAR(50)') AS MaterialID,
	X.Data.query('MaterialName').value('.','NVARCHAR(50)') AS MaterialName,
	X.Data.query('UnitName').value('.','NVARCHAR(50)') AS UnitName,
	X.Data.query('S01ID').value('.','NVARCHAR(50)') AS S01ID,
	X.Data.query('S02ID').value('.','NVARCHAR(50)') AS S02ID,
	X.Data.query('S03ID').value('.','NVARCHAR(50)') AS S03ID,
	X.Data.query('S04ID').value('.','NVARCHAR(50)') AS S04ID,
	X.Data.query('S05ID').value('.','NVARCHAR(50)') AS S05ID,
	X.Data.query('S06ID').value('.','NVARCHAR(50)') AS S06ID,
	X.Data.query('S07ID').value('.','NVARCHAR(50)') AS S07ID,
	X.Data.query('S08ID').value('.','NVARCHAR(50)') AS S08ID,
	X.Data.query('S09ID').value('.','NVARCHAR(50)') AS S09ID,
	X.Data.query('S10ID').value('.','NVARCHAR(50)') AS S10ID,
	X.Data.query('S11ID').value('.','NVARCHAR(50)') AS S11ID,
	X.Data.query('S12ID').value('.','NVARCHAR(50)') AS S12ID,
	X.Data.query('S13ID').value('.','NVARCHAR(50)') AS S13ID,
	X.Data.query('S14ID').value('.','NVARCHAR(50)') AS S14ID,
	X.Data.query('S15ID').value('.','NVARCHAR(50)') AS S15ID,
	X.Data.query('S16ID').value('.','NVARCHAR(50)') AS S16ID,
	X.Data.query('S17ID').value('.','NVARCHAR(50)') AS S17ID,
	X.Data.query('S18ID').value('.','NVARCHAR(50)') AS S18ID,
	X.Data.query('S19ID').value('.','NVARCHAR(50)') AS S19ID,
	X.Data.query('S20ID').value('.','NVARCHAR(50)') AS S20ID,
	X.Data.query('NodeTypeName').value('.','NVARCHAR(50)') AS NodeTypeName,
	COALESCE(X.Data.value('(Quantity/text())[1]', 'decimal(28, 8)'), 0) AS Quantity,
	COALESCE(X.Data.value('(UnitPrice/text())[1]', 'decimal(28, 8)'), 0) AS UnitPrice,
	COALESCE(X.Data.value('(UnitPriceAverage/text())[1]', 'decimal(28, 8)'), 0) AS UnitPriceAverage,
	COALESCE(X.Data.value('(Amount/text())[1]', 'decimal(28, 8)'), 0) AS Amount,

	X.Data.query('NoteDetail').value('.','NVARCHAR(50)') AS NoteDetail
INTO #Data
FROM @XML.nodes('//Data') AS X (Data)

SET @FromInventoryID = (SELECT TOP 1 MaterialID FROM #Data ORDER BY MaterialID ASC)
SET @FromInventoryID = (SELECT TOP 1 MaterialID FROM #Data ORDER BY MaterialID DESC)

--- Tính giá bình quân gia quyền
SELECT *  INTO #AT2007_Result FROM AT2007

EXEC CRMP2111B_1 @DivisionID=@DivisionID, @TranMonth = @TranMonth, @TranYear =@TranYear, @FromInventoryID = @FromInventoryId, @ToInventoryID = @ToInventoryID, @FromWareHouseID = @FromWareHouseID, @ToWareHouseID = @ToWareHouseID, @FromAccountID = @FromAccountID, @ToAccountID = @ToAccountID

-- Đổ giá bình quân gia quyền vào #data
UPDATE #Data SET UnitPriceAverage = B.UnitPrice
FROM #Data A
	INNER JOIN #AT2007_Result B ON  A.MaterialID = B.InventoryID 
		AND B.TranMonth = @TranMonth 
		AND B.TranYear = @TranYear
		AND (A.S01ID = B.S01ID OR (ISNULL(A.S01ID, '') =  ISNULL(B.S01ID, '')))
		AND (A.S02ID = B.S02ID OR (ISNULL(A.S02ID, '') =  ISNULL(B.S02ID, '')))
		AND (A.S03ID = B.S03ID OR (ISNULL(A.S03ID, '') =  ISNULL(B.S03ID, '')))
		AND (A.S04ID = B.S04ID OR (ISNULL(A.S04ID, '') =  ISNULL(B.S04ID, '')))
		AND (A.S05ID = B.S05ID OR (ISNULL(A.S05ID, '') =  ISNULL(B.S05ID, '')))
		AND (A.S06ID = B.S06ID OR (ISNULL(A.S06ID, '') =  ISNULL(B.S06ID, '')))
		AND (A.S07ID = B.S07ID OR (ISNULL(A.S07ID, '') =  ISNULL(B.S07ID, '')))
		AND (A.S08ID = B.S08ID OR (ISNULL(A.S08ID, '') =  ISNULL(B.S08ID, '')))
		AND (A.S09ID = B.S09ID OR (ISNULL(A.S09ID, '') =  ISNULL(B.S09ID, '')))
		AND (A.S10ID = B.S10ID OR (ISNULL(A.S10ID, '') =  ISNULL(B.S10ID, '')))
		AND (A.S11ID = B.S11ID OR (ISNULL(A.S11ID, '') =  ISNULL(B.S11ID, '')))
		AND (A.S12ID = B.S12ID OR (ISNULL(A.S12ID, '') =  ISNULL(B.S12ID, '')))
		AND (A.S13ID = B.S13ID OR (ISNULL(A.S13ID, '') =  ISNULL(B.S13ID, '')))
		AND (A.S14ID = B.S14ID OR (ISNULL(A.S14ID, '') =  ISNULL(B.S14ID, '')))
		AND (A.S15ID = B.S15ID OR (ISNULL(A.S15ID, '') =  ISNULL(B.S15ID, '')))
		AND (A.S16ID = B.S16ID OR (ISNULL(A.S16ID, '') =  ISNULL(B.S16ID, '')))
		AND (A.S17ID = B.S17ID OR (ISNULL(A.S17ID, '') =  ISNULL(B.S17ID, '')))
		AND (A.S18ID = B.S18ID OR (ISNULL(A.S18ID, '') =  ISNULL(B.S18ID, '')))
		AND (A.S19ID = B.S19ID OR (ISNULL(A.S19ID, '') =  ISNULL(B.S19ID, '')))
		AND (A.S20ID = B.S20ID OR (ISNULL(A.S20ID, '') =  ISNULL(B.S20ID, '')))

Create table #SalePrice (
	DivisionID NVARCHAR(MAX),
	InventoryID NVARCHAR(MAX),
	InventoryName NVARCHAR(MAX),
	InventoryTypeID NVARCHAR(MAX),
	UnitID NVARCHAR(MAX),
	UnitName NVARCHAR(MAX),
	IsCommon NVARCHAR(MAX),
	Disable NVARCHAR(MAX),
	UnitPrice DECIMAL(28,8),
	RetailPrice DECIMAL(28,8),
	SalePrice DECIMAL(28, 8),
	VATGroupID NVARCHAR(MAX),
	InventorySearch NVARCHAR(MAX),
	MinPrice DECIMAL(28,8),
	Barcode NVARCHAR(MAX),
	DiscountPercent DECIMAL(28,8),
)
-- Lấy giá bán thị trường
    INSERT INTO #SalePrice EXEC CMNP90041 @InventoryID=N'', @DivisionID=@DivisionID, @ObjectID=N'', @VoucherDate='2023-11-11 00:00:00', @PriceListID=@PriceListID, @CurrencyID=''

--  Đổ dữ liệu giá bán thị trường vào Data
UPDATE #Data SET UnitPrice = B.SalePrice
FROM #Data A
	INNER JOIN #SalePrice B ON A.MaterialID = B.InventoryID AND B.DivisionID = @DivisionID

--- Nếu giá bình quân gia quyền kì hiện tại, lù về kì trước cho tới khi có giá
SET @CurrentMonth = @TranMonth
SET @CurrentYear = @TranYear
SET @masterCursor = CURSOR STATIC FOR
SELECT MaterialID,UnitPriceAverage FROM #Data
OPEN @masterCursor

FETCH NEXT FROM @masterCursor INTO @MaterialID,@UnitPriceAverage
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Nếu giá bình quân gia quyền = 0
	If (@UnitPriceAverage = 0)
	BEGIN
		SELECT TOP 1  @TranMonthStart = TranMonth, @TranYearStart = TranYear From WT9999 ORDER BY TranMonth, TranYear ASC
		SET @CurrentMonth = @CurrentMonth - 1
		IF (@CurrentMonth = 0)
		BEGIN 
			SET @CurrentMonth = 12
			SET @CurrentYear = @CurrentYear - 1
		END

		-- Nếu kì đang kiểm tra bé hơn kì bắt đầu thì
		IF (@CurrentMonth < @TranMonthStart and @CurrentYear <= @TranYearStart OR @CurrentYear < @TranYearStart)
		BEGIN
			UPDATE #Data SET UnitPriceAverage = 0
			FROM #Data A
					INNER JOIN #AT2007_Result B ON  A.MaterialID = B.InventoryID 
					AND B.TranMonth = @CurrentMonth 
					AND B.TranYear = @CurrentYear
							AND (A.S01ID = B.S01ID OR (ISNULL(A.S01ID, '') =  ISNULL(B.S01ID, '')))
							AND (A.S02ID = B.S02ID OR (ISNULL(A.S02ID, '') =  ISNULL(B.S02ID, '')))
							AND (A.S03ID = B.S03ID OR (ISNULL(A.S03ID, '') =  ISNULL(B.S03ID, '')))
							AND (A.S04ID = B.S04ID OR (ISNULL(A.S04ID, '') =  ISNULL(B.S04ID, '')))
							AND (A.S05ID = B.S05ID OR (ISNULL(A.S05ID, '') =  ISNULL(B.S05ID, '')))
							AND (A.S06ID = B.S06ID OR (ISNULL(A.S06ID, '') =  ISNULL(B.S06ID, '')))
							AND (A.S07ID = B.S07ID OR (ISNULL(A.S07ID, '') =  ISNULL(B.S07ID, '')))
							AND (A.S08ID = B.S08ID OR (ISNULL(A.S08ID, '') =  ISNULL(B.S08ID, '')))
							AND (A.S09ID = B.S09ID OR (ISNULL(A.S09ID, '') =  ISNULL(B.S09ID, '')))
							AND (A.S10ID = B.S10ID OR (ISNULL(A.S10ID, '') =  ISNULL(B.S10ID, '')))
							AND (A.S11ID = B.S11ID OR (ISNULL(A.S11ID, '') =  ISNULL(B.S11ID, '')))
							AND (A.S12ID = B.S12ID OR (ISNULL(A.S12ID, '') =  ISNULL(B.S12ID, '')))
							AND (A.S13ID = B.S13ID OR (ISNULL(A.S13ID, '') =  ISNULL(B.S13ID, '')))
							AND (A.S14ID = B.S14ID OR (ISNULL(A.S14ID, '') =  ISNULL(B.S14ID, '')))
							AND (A.S15ID = B.S15ID OR (ISNULL(A.S15ID, '') =  ISNULL(B.S15ID, '')))
							AND (A.S16ID = B.S16ID OR (ISNULL(A.S16ID, '') =  ISNULL(B.S16ID, '')))
							AND (A.S17ID = B.S17ID OR (ISNULL(A.S17ID, '') =  ISNULL(B.S17ID, '')))
							AND (A.S18ID = B.S18ID OR (ISNULL(A.S18ID, '') =  ISNULL(B.S18ID, '')))
							AND (A.S19ID = B.S19ID OR (ISNULL(A.S19ID, '') =  ISNULL(B.S19ID, '')))
							AND (A.S20ID = B.S20ID OR (ISNULL(A.S20ID, '') =  ISNULL(B.S20ID, '')))
			WHERE A.MaterialID = @MaterialID

			SET @CurrentMonth = @TranMonth
			SET @CurrentYear = @TranYear
				-- Fetch dữ liệu tiếp theo
			FETCH NEXT FROM @masterCursor INTO @MaterialID,@UnitPriceAverage
		END

		SET @Price = (SELECT TOP 1 UnitPrice FROM #AT2007_Result WHERE InventoryID = @MaterialID AND TranMonth = @CurrentMonth AND TranYear = @CurrentYear)
		IF @Price <> 0
		BEGIN
			UPDATE #Data SET UnitPriceAverage = B.UnitPrice
			FROM #Data A
					INNER JOIN #AT2007_Result B ON  A.MaterialID = B.InventoryID 
					AND B.TranMonth = @CurrentMonth 
					AND B.TranYear = @CurrentYear
							AND (A.S01ID = B.S01ID OR (ISNULL(A.S01ID, '') =  ISNULL(B.S01ID, '')))
							AND (A.S02ID = B.S02ID OR (ISNULL(A.S02ID, '') =  ISNULL(B.S02ID, '')))
							AND (A.S03ID = B.S03ID OR (ISNULL(A.S03ID, '') =  ISNULL(B.S03ID, '')))
							AND (A.S04ID = B.S04ID OR (ISNULL(A.S04ID, '') =  ISNULL(B.S04ID, '')))
							AND (A.S05ID = B.S05ID OR (ISNULL(A.S05ID, '') =  ISNULL(B.S05ID, '')))
							AND (A.S06ID = B.S06ID OR (ISNULL(A.S06ID, '') =  ISNULL(B.S06ID, '')))
							AND (A.S07ID = B.S07ID OR (ISNULL(A.S07ID, '') =  ISNULL(B.S07ID, '')))
							AND (A.S08ID = B.S08ID OR (ISNULL(A.S08ID, '') =  ISNULL(B.S08ID, '')))
							AND (A.S09ID = B.S09ID OR (ISNULL(A.S09ID, '') =  ISNULL(B.S09ID, '')))
							AND (A.S10ID = B.S10ID OR (ISNULL(A.S10ID, '') =  ISNULL(B.S10ID, '')))
							AND (A.S11ID = B.S11ID OR (ISNULL(A.S11ID, '') =  ISNULL(B.S11ID, '')))
							AND (A.S12ID = B.S12ID OR (ISNULL(A.S12ID, '') =  ISNULL(B.S12ID, '')))
							AND (A.S13ID = B.S13ID OR (ISNULL(A.S13ID, '') =  ISNULL(B.S13ID, '')))
							AND (A.S14ID = B.S14ID OR (ISNULL(A.S14ID, '') =  ISNULL(B.S14ID, '')))
							AND (A.S15ID = B.S15ID OR (ISNULL(A.S15ID, '') =  ISNULL(B.S15ID, '')))
							AND (A.S16ID = B.S16ID OR (ISNULL(A.S16ID, '') =  ISNULL(B.S16ID, '')))
							AND (A.S17ID = B.S17ID OR (ISNULL(A.S17ID, '') =  ISNULL(B.S17ID, '')))
							AND (A.S18ID = B.S18ID OR (ISNULL(A.S18ID, '') =  ISNULL(B.S18ID, '')))
							AND (A.S19ID = B.S19ID OR (ISNULL(A.S19ID, '') =  ISNULL(B.S19ID, '')))
							AND (A.S20ID = B.S20ID OR (ISNULL(A.S20ID, '') =  ISNULL(B.S20ID, '')))
			WHERE A.MaterialID = @MaterialID

			SET @CurrentMonth = @TranMonth
			SET @CurrentYear = @TranYear
				-- Fetch dữ liệu tiếp theo
			FETCH NEXT FROM @masterCursor INTO @MaterialID,@UnitPriceAverage
		END
	END
	ELSE
	BEGIN
		FETCH NEXT FROM @masterCursor INTO @MaterialID,@UnitPriceAverage
	END
END

CLOSE @masterCursor
DEALLOCATE @masterCursor

SELECT * FROM #Data order by MaterialID
DROP TABLE #SalePrice
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO