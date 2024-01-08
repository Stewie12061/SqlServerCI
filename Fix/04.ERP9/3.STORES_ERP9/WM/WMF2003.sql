IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMF2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMF2003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---Tính số lượng quy đổi
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----[Minh Dũng] - Create
-- <Example>
-- <Example>

CREATE PROCEDURE WMF2003 ( 
	@XML XML) 
AS

DECLARE
	@DivisionID NVARCHAR(50),
	@InventoryID NVARCHAR(50),
	@UnitID NVARCHAR(50),
	@S01ID NVARCHAR(50),
	@S02ID NVARCHAR(50),
	@S03ID NVARCHAR(50),
	@S04ID NVARCHAR(50),
	@S05ID NVARCHAR(50),
	@S06ID NVARCHAR(50),
	@S07ID NVARCHAR(50),
	@S08ID NVARCHAR(50),
	@S09ID NVARCHAR(50),
	@S10ID NVARCHAR(50),
	@S11ID NVARCHAR(50),
	@S12ID NVARCHAR(50),
	@S13ID NVARCHAR(50),
	@S14ID NVARCHAR(50),
	@S15ID NVARCHAR(50),
	@S16ID NVARCHAR(50),
	@S17ID NVARCHAR(50),
	@S18ID NVARCHAR(50),
	@S19ID NVARCHAR(50),
	@S20ID NVARCHAR(50),
	@T01 DECIMAL(28,8),
	@T02 DECIMAL(28,8),
	@T03 DECIMAL(28,8),
	@T04 DECIMAL(28,8),
	@T05 DECIMAL(28,8),
	@Quantity DECIMAL(28, 8),
	@ConversionFactor Decimal(28, 8),
	@Operator TINYINT,
	@DataType TINYINT,
	@FormulaID NVARCHAR(50),
	@FormulaDes NVARCHAR(MAX),
	@QuantityConvertor Decimal(28,8)
	
BEGIN
SELECT 
    NULLIF(X.Data.query('DivisionID').value('.','NVARCHAR(50)'), '') AS DivisionID,
    NULLIF(X.Data.query('InventoryID').value('.','NVARCHAR(50)'), '') AS InventoryID,
    NULLIF(X.Data.query('UnitID').value('.','NVARCHAR(50)'), '') AS UnitID,
    NULLIF(X.Data.query('S01ID').value('.','NVARCHAR(50)'), '') AS S01ID,
    NULLIF(X.Data.query('S02ID').value('.','NVARCHAR(50)'), '') AS S02ID,
    NULLIF(X.Data.query('S03ID').value('.','NVARCHAR(50)'), '') AS S03ID,
    NULLIF(X.Data.query('S04ID').value('.','NVARCHAR(50)'), '') AS S04ID,
    NULLIF(X.Data.query('S05ID').value('.','NVARCHAR(50)'), '') AS S05ID,
    NULLIF(X.Data.query('S06ID').value('.','NVARCHAR(50)'), '') AS S06ID,
    NULLIF(X.Data.query('S07ID').value('.','NVARCHAR(50)'), '') AS S07ID,
    NULLIF(X.Data.query('S08ID').value('.','NVARCHAR(50)'), '') AS S08ID,
    NULLIF(X.Data.query('S09ID').value('.','NVARCHAR(50)'), '') AS S09ID,
    NULLIF(X.Data.query('S10ID').value('.','NVARCHAR(50)'), '') AS S10ID,
    NULLIF(X.Data.query('S11ID').value('.','NVARCHAR(50)'), '') AS S11ID,
    NULLIF(X.Data.query('S12ID').value('.','NVARCHAR(50)'), '') AS S12ID,
    NULLIF(X.Data.query('S13ID').value('.','NVARCHAR(50)'), '') AS S13ID,
    NULLIF(X.Data.query('S14ID').value('.','NVARCHAR(50)'), '') AS S14ID,
    NULLIF(X.Data.query('S15ID').value('.','NVARCHAR(50)'), '') AS S15ID,
    NULLIF(X.Data.query('S16ID').value('.','NVARCHAR(50)'), '') AS S16ID,
    NULLIF(X.Data.query('S17ID').value('.','NVARCHAR(50)'), '') AS S17ID,
    NULLIF(X.Data.query('S18ID').value('.','NVARCHAR(50)'), '') AS S18ID,
    NULLIF(X.Data.query('S19ID').value('.','NVARCHAR(50)'), '') AS S19ID,
    NULLIF(X.Data.query('S20ID').value('.','NVARCHAR(50)'), '') AS S20ID,
    ISNULL(NULLIF(X.Data.value('(Quantity/text())[1]', 'decimal(28, 8)'), 0), 0) AS Quantity,
    ISNULL(NULLIF(X.Data.value('(T01/text())[1]', 'decimal(28, 8)'), 0), 0) AS T01,
    ISNULL(NULLIF(X.Data.value('(T02/text())[1]', 'decimal(28, 8)'), 0), 0) AS T02,
    ISNULL(NULLIF(X.Data.value('(T03/text())[1]', 'decimal(28, 8)'), 0), 0) AS T03,
    ISNULL(NULLIF(X.Data.value('(T04/text())[1]', 'decimal(28, 8)'), 0), 0) AS T04,
    ISNULL(NULLIF(X.Data.value('(T05/text())[1]', 'decimal(28, 8)'), 0), 0) AS T05
INTO #Data
FROM @XML.nodes('//Data') AS X (Data)

	SELECT 
    @DivisionID = DivisionID,
    @InventoryID = InventoryID,
    @UnitID = UnitID,
    @S01ID = S01ID,
    @S02ID = S02ID,
    @S03ID = S03ID,
    @S04ID = S04ID,
    @S05ID = S05ID,
    @S06ID = S06ID,
    @S07ID = S07ID,
    @S08ID = S08ID,
    @S09ID = S09ID,
    @S10ID = S10ID,
    @S11ID = S11ID,
    @S12ID = S12ID,
    @S13ID = S13ID,
    @S14ID = S14ID,
    @S15ID = S15ID,
    @S16ID = S16ID,
    @S17ID = S17ID,
    @S18ID = S18ID,
    @S19ID = S19ID,
    @S20ID = S20ID,
    @T01 = T01,
    @T02 = T02,
    @T03 = T03,
    @T04 = T04,
    @T05 = T05,
    @Quantity = Quantity
FROM #Data;



	--- Tạo bảng chứa kết quả trả về
	CREATE TABLE #ResultTable (
    DivisionID NVARCHAR(50),
    InventoryID NVARCHAR(50),
    UnitID NVARCHAR(50),
    S01ID NVARCHAR(50),
    S02ID NVARCHAR(50),
    S03ID NVARCHAR(50),
    S04ID NVARCHAR(50),
    S05ID NVARCHAR(50),
    S06ID NVARCHAR(50),
    S07ID NVARCHAR(50),
    S08ID NVARCHAR(50),
    S09ID NVARCHAR(50),
    S10ID NVARCHAR(50),
    S11ID NVARCHAR(50),
    S12ID NVARCHAR(50),
    S13ID NVARCHAR(50),
    S14ID NVARCHAR(50),
    S15ID NVARCHAR(50),
    S16ID NVARCHAR(50),
    S17ID NVARCHAR(50),
    S18ID NVARCHAR(50),
    S19ID NVARCHAR(50),
    S20ID NVARCHAR(50),
    T01 DECIMAL(28,8),
    T02 DECIMAL(28,8),
    T03 DECIMAL(28,8),
    T04 DECIMAL(28,8),
    T05 DECIMAL(28,8),
    Quantity DECIMAL(28, 8),
    QuantityConvertor DECIMAL(28,8)
);
	-- Lấy thông tin chuyển đổi của sản phẩm theo quy cách
	SELECT TOP 1 * INTO #AT1309 FROM AT1309
	WHERE InventoryID = @InventoryID AND UnitID = @UnitID 
			AND (S01ID = @S01ID OR (S01ID IS NULL AND @S01ID IS NULL))
			AND (S02ID = @S02ID OR (S02ID IS NULL AND @S02ID IS NULL))
			AND (S03ID = @S03ID OR (S03ID IS NULL AND @S03ID IS NULL))
			AND (S04ID = @S04ID OR (S04ID IS NULL AND @S04ID IS NULL))
			AND (S05ID = @S05ID OR (S05ID IS NULL AND @S05ID IS NULL))
			AND (S06ID = @S06ID OR (S06ID IS NULL AND @S06ID IS NULL))
			AND (S07ID = @S07ID OR (S07ID IS NULL AND @S07ID IS NULL))
			AND (S08ID = @S08ID OR (S08ID IS NULL AND @S08ID IS NULL))
			AND (S09ID = @S09ID OR (S09ID IS NULL AND @S09ID IS NULL))
			AND (S10ID = @S10ID OR (S10ID IS NULL AND @S10ID IS NULL))
			AND (S11ID = @S11ID OR (S11ID IS NULL AND @S11ID IS NULL))
			AND (S12ID = @S12ID OR (S12ID IS NULL AND @S12ID IS NULL))
			AND (S13ID = @S13ID OR (S13ID IS NULL AND @S13ID IS NULL))
			AND (S14ID = @S14ID OR (S14ID IS NULL AND @S14ID IS NULL))
			AND (S15ID = @S15ID OR (S15ID IS NULL AND @S15ID IS NULL))
			AND (S16ID = @S16ID OR (S16ID IS NULL AND @S16ID IS NULL))
			AND (S17ID = @S17ID OR (S17ID IS NULL AND @S17ID IS NULL))
			AND (S18ID = @S18ID OR (S18ID IS NULL AND @S18ID IS NULL))
			AND (S19ID = @S19ID OR (S19ID IS NULL AND @S19ID IS NULL))
			AND (S20ID = @S20ID OR (S20ID IS NULL AND @S20ID IS NULL))
	
	SELECT @ConversionFactor =  ConversionFactor, @Operator=Operator,@DataType = DataType, @FormulaID= FormulaID   from #AT1309
	
	IF (@DataType = 0) -- Tính theo tỉ lệ
	BEGIN
		IF (@Operator =0) -- Phép nhân
		BEGIN
			SET @QuantityConvertor = @Quantity*@ConversionFactor
		END
		ELSE IF (@Operator = 1) -- Phép chia
		BEGIN
			IF (@ConversionFactor <> 0)
			BEGIN
				SET @QuantityConvertor = @Quantity/@ConversionFactor
			END
		END
	END

	ELSE IF(@DataType = 1) -- Tính theo công thức
	BEGIN
		-- Lấy công thức
		SELECT @FormulaDes = FormulaDes FROM AT1319 WHERE FormulaID = @FormulaID
		PRINT(@FormulaDes)
		SET @FormulaDes = REPLACE(@FormulaDes, '@T01', CAST(@T01 AS NVARCHAR(50)))
		SET @FormulaDes = REPLACE(@FormulaDes, '@T02', CAST(@T02 AS NVARCHAR(50)))
		SET @FormulaDes = REPLACE(@FormulaDes, '@T03', CAST(@T03 AS NVARCHAR(50)))
		SET @FormulaDes = REPLACE(@FormulaDes, '@T04', CAST(@T04 AS NVARCHAR(50)))
		SET @FormulaDes = REPLACE(@FormulaDes, '@T05', CAST(@T05 AS NVARCHAR(50)))
		PRINT(@FormulaDes)
		DECLARE @Result DECIMAL(28, 8)
		DECLARE @SqlStatement NVARCHAR(MAX)
		SET @SqlStatement = 'SELECT @Result = ' + @FormulaDes
		EXEC sp_executesql @SqlStatement, N'@Result DECIMAL(28, 8) OUTPUT', @Result OUTPUT
		SET @QuantityConvertor = @Result*@Quantity/@T01
	END
	
	-- Insert into the result table using parameters
	INSERT INTO #ResultTable (
		DivisionID, InventoryID, UnitID,
		S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID,
		S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,
		T01, T02, T03, T04, T05, Quantity, QuantityConvertor
	)
	VALUES (
		@DivisionID, @InventoryID, @UnitID,
		@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID,
		@S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
		@T01, @T02, @T03, @T04, @T05, @Quantity, @QuantityConvertor
	);

	SELECT *FROM #ResultTable
END
