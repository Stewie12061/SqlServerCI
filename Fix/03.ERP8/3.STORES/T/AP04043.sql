IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP04043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP04043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---		Xuất excel báo cáo so sánh theo phân loại sản phẩm
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Viết Toàn on: 13/12/2023
-- <Example>
/*
	EXEC AP04043 'PC',''
*/

CREATE PROCEDURE AP04043
(
	@DivisionID NVARCHAR(50),
	@AnaID NVARCHAR(MAX),
	@IsDate INT,    --0. Tháng     1. Quý      2. Năm
	@DateFrom NVARCHAR(50),
	@DateTo NVARCHAR(50)
)
	
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@sWhere1 NVARCHAR(MAX) = N'',
			@sWhere2 NVARCHAR(MAX) = N'',
			@sQuarterFrom VARCHAR(500) = N'',
			@sQuarterTo VARCHAR(500) = N'',
			@TranMonth VARCHAR(10),
			@TranYear VARCHAR(10),
			@dataCol VARCHAR(50),
			@Value DECIMAL(28,8),
			@Quantity DECIMAL(28,8)

	SELECT [Value]
	INTO #AnaTBL
	FROM StringSplit(REPLACE(@AnaID, '''', ''), ',')

	IF @IsDate = 0		-- Tháng
	BEGIN
		SET @sWhere1 = @sWhere1 + N' AND A90.TranMonth = '+LEFT(@DateFrom, 2)+' AND A90.TranYear = ' + RIGHT(@DateFrom, 4)
		SET @sWhere2 = @sWhere2 + N' AND A90.TranMonth = '+LEFT(@DateTo, 2)+' AND A90.TranYear = ' + RIGHT(@DateTo, 4)
	END
	ELSE IF @IsDate = 1	-- Quý
		BEGIN
			SET @TranMonth = LEFT(@DateFrom, 2)
			SET @TranYear = RIGHT(@DateFrom, 4)

			IF @TranMonth = '01'
				SET @sWhere1 = @sWhere1 + N' AND A90.TranMonth IN (1, 2, 3) AND A90.TranYear = ' + @TranYear
			ELSE IF @TranMonth = '02'
				SET @sWhere1 = @sWhere1 + N' AND A90.TranMonth IN (4, 5, 6) AND A90.TranYear = ' + @TranYear
			ELSE IF @TranMonth = '03'
				SET @sWhere1 = @sWhere1 + N' AND A90.TranMonth IN (7, 8, 9) AND A90.TranYear = ' + @TranYear
			ELSE
				SET @sWhere1 = @sWhere1 + N' AND A90.TranMonth IN (10, 11, 12) AND A90.TranYear = ' + @TranYear

			------------------------

			SET @TranMonth = LEFT(@DateTo, 2)
			SET @TranYear = RIGHT(@DateTo, 4)

			IF @TranMonth = '01'
				SET @sWhere2 = @sWhere2 + N' AND A90.TranMonth IN (1, 2, 3) AND A90.TranYear = ' + @TranYear
			ELSE IF @TranMonth = '02'
				SET @sWhere2 = @sWhere2 + N' AND A90.TranMonth IN (4, 5, 6) AND A90.TranYear = ' + @TranYear
			ELSE IF @TranMonth = '03'
				SET @sWhere2 = @sWhere2 + N' AND A90.TranMonth IN (7, 8, 9) AND A90.TranYear = ' + @TranYear
			ELSE
				SET @sWhere2 = @sWhere2 + N' AND A90.TranMonth IN (10, 11, 12) AND A90.TranYear = ' + @TranYear


		END
	ELSE -- Năm
	BEGIN
		SET @sWhere1 = @sWhere1 + N' AND A90.TranYear = ' + @DateFrom
		SET @sWhere2 = @sWhere2 + N' AND A90.TranYear = ' + @DateTo
	END

	IF ISNULL(@DivisionID, '') <> ''
	BEGIN
		SET @sWhere1 = @sWhere1 + N' AND A90.DivisionID IN (SELECT [Value] FROM StringSplit('''+@DivisionID+''', '','') UNION ALL SELECT ''@@@'')'
		SET @sWhere2 = @sWhere2 + N' AND A90.DivisionID IN (SELECT [Value] FROM StringSplit('''+@DivisionID+''', '','') UNION ALL SELECT ''@@@'')'
	END

	
	IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AP04043TBL]') AND TYPE IN (N'U'))
	BEGIN	
		DROP TABLE AP04043TBL
	END

	CREATE TABLE AP04043TBL 
	(
		--TimeCompare		VARCHAR(10),
		AnaID			NVARCHAR(50) NULL,
		AnaName			NVARCHAR(1000) NULL,
		Quantity1		DECIMAL(28,8) NULL,
		Value1			DECIMAL(28,8) NULL,
		Quantity2		DECIMAL(28,8) NULL,
		Value2			DECIMAL(28,8) NULL
	)

	--EXEC(@sSQL)

	WHILE EXISTS (SELECT TOP 1 1 FROM #AnaTBL)
	BEGIN
		SET @dataCol = (SELECT TOP 1 [Value] FROM #AnaTBL)
		SET @sSQL = '
			DECLARE @Value1 DECIMAL(28,8),
					@Quantity1 DECIMAL(28,8),
					@Value2 DECIMAL(28,8),
					@Quantity2 DECIMAL(28,8)

			SELECT @Quantity1 = ISNULL(SUM(ISNULL(A90.ConvertedQuantity, 0)), 0) - ISNULL(SUM(ISNULL(AT901.ConvertedQuantity, 0)), 0),
				@Value1 = ISNULL(SUM(ISNULL(A90.ConvertedAmount, 0)), 0) - ISNULL(SUM(ISNULL(AT901.ConvertedAmount, 0)), 0)
			FROM AT9000 A90
			LEFT JOIN AV1322 A22 WITH (NOLOCK) ON A90.InventoryID = A22.InventoryID
			OUTER APPLY (
				SELECT A00.InventoryID, A00.ConvertedQuantity, A00.ConvertedAmount
				FROM AT9000 A00
				WHERE A00.TransactionTypeID IN (''T24'',''T74'',''T04'')
				AND A00.TableID in (''AT9000'', ''AT1326'', ''MT1603'')
				AND A00.InventoryID = A22.InventoryID
			) AS AT901 --ON AT901.InventoryID = A90.InventoryID
			WHERE A22.I01ID = '''+@dataCol+'''
			AND A90.TransactionTypeID IN (''T04'',''T64'')
			'+@sWhere1+'

			SELECT @Quantity2 = ISNULL(SUM(ISNULL(A90.ConvertedQuantity, 0)), 0) - ISNULL(SUM(ISNULL(AT901.ConvertedQuantity, 0)), 0),
				@Value2 = ISNULL(SUM(ISNULL(A90.ConvertedAmount, 0)), 0) - ISNULL(SUM(ISNULL(AT901.ConvertedAmount, 0)), 0)
			FROM AT9000 A90
			LEFT JOIN AV1322 A22 WITH (NOLOCK) ON A90.InventoryID = A22.InventoryID
			OUTER APPLY (
				SELECT A00.InventoryID, A00.ConvertedQuantity, A00.ConvertedAmount
				FROM AT9000 A00
				WHERE A00.TransactionTypeID IN (''T24'',''T74'',''T04'')
				AND A00.TableID in (''AT9000'', ''AT1326'', ''MT1603'')
				AND A00.InventoryID = A22.InventoryID
			) AS AT901 --ON AT901.InventoryID = A90.InventoryID
			WHERE A22.I01ID = '''+@dataCol+'''
			AND A90.TransactionTypeID IN (''T04'',''T64'')
			'+@sWhere2+'

			INSERT INTO AP04043TBL
			SELECT '''+@dataCol+''' AS AnaID
			, CONCAT(AT1015.AnaID, '' - '', AT1015.AnaName) AS AnaName
			, @Quantity1 AS Quantity1
			, @Value1 AS Value1
			, @Quantity2 AS Quantity2
			, @Value2 AS Value2
			FROM AT1015
			WHERE AnaTypeID = N''I01''
			AND AnaID = '''+@dataCol+'''
			AND DivisionID IN (SELECT [Value] FROM StringSplit('''+@DivisionID+''', '','') UNION ALL SELECT ''@@@'')
		'
		PRINT(@sSQL)
		EXEC(@sSQL)
		DELETE #AnaTBL WHERE [Value] = @dataCol
	END

	IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype='V' AND Name ='AV0404')
		EXEC('CREATE VIEW AV0404 	--Created by AP04043
			AS SELECT * FROM AP04043TBL')
	Else	
		EXEC('ALTER VIEW AV0404 		--Created by AP04043
		AS  SELECT * FROM AP04043TBL')

	SELECT * FROM AP04043TBL
	--DROP TABLE AP04043TBL
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
