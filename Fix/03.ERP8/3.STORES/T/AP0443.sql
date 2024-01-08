IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0443]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0443]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Xuất excel báo cáo số lượng bán hàng theo kênh
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Phúc on: 30/11/2023
-- <Example>
/*
	EXEC AP0443 'PC',''
*/

CREATE PROCEDURE AP0443
(
	@ReportCode varchar(50),
	@DivisionID nvarchar(50),
	@AnaID nvarchar(MAX),
	@InventoryID nvarchar(MAX),
	@IsDate int,    --0. tháng     1. Quý      2. Năm
	@DateFrom Datetime,
	@DateTo Datetime
)
	
AS
BEGIN
	DECLARE @sSQL nvarchar(max),
			@Where nvarchar(max),
			@sSQL1 nvarchar(max),
			@StartDate DATE = CONVERT(DATE, @DateFrom),
			@EndDate DATE = CONVERT(DATE, @DateTo),
			@cur CURSOR,
			@Period VARCHAR(50)

	CREATE TABLE #temp(DateList VARCHAR(50))
	IF(@IsDate = 0 OR @IsDate = 1)
	BEGIN
		WHILE @StartDate <= @EndDate
		BEGIN	
		INSERT INTO #temp(DateList) VALUES(FORMAT(@StartDate, 'MM/yyyy'))
			SET @StartDate = DATEADD(MONTH, 1, @StartDate)
		END
	END
	ELSE
	BEGIN
		WHILE @StartDate <= @EndDate
		BEGIN	
			INSERT INTO #temp(DateList) VALUES(FORMAT(@StartDate, 'yyyy'))
			SET @StartDate = DATEADD(YEAR, 1, @StartDate)
		END
	END
	select p.DateList from #temp p order by p.DateList asc
	                    drop table #temp

	SELECT s.Value as AnaID, AT1011.AnaName
	into #temp2
	FROM STRINGSPLIT(@AnaID, ''',''') s LEFT JOIN AT1011 ON AT1011.AnaID = s.Value  and AT1011.AnaTypeID = 'A04'
	order by [Value] asc

	delete #temp2 where AnaID = ','
	SELECT * FROM #temp2

	Create table #temp3 (InventoryID NVARCHAR(MAX))

	INSERT INTO #temp3
	SELECT [Value] as InventoryID
	FROM STRINGSPLIT(@InventoryID, ''',''') 
	order by [Value] asc

	delete #temp3 where InventoryID = ','  -- xóa được cái thừa

	SET @InventoryID = '''' + REPLACE(@InventoryID, ',', ''',''') + ''''
	
		SET @sSQL = '
					SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as RowNum,
						ISNULL(V6.SelectionID, '''') AS InventoryID,
						ISNULL(V6.SelectionName, '''') AS InventoryName,
						ISNULL(A0.ConvertedUnitID, '''') AS ConvertedUnitID,
						ISNULL(AT01.StandardID, '''') AS S01ID,
						ISNULL(AT02.StandardID, '''') AS S02ID,
						ISNULL(AT03.StandardID, '''') AS S03ID,
						ISNULL(AT04.StandardID, '''') AS S04ID,
						ISNULL(AT01.StandardName, '''') AS S01Name,
						ISNULL(AT02.StandardName, '''') AS S02Name,
						ISNULL(AT03.StandardName, '''') AS S03Name,
						ISNULL(AT04.StandardName, '''') AS S04Name,
						SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity,
						SUM(ISNULL(A00T04.ConvertedPrice, 0) - ISNULL(A00T24.ConvertedPrice, 0)) AS ConvertedPrice,
						ISNULL(A0.TranMonth, '''') AS TranMonth,
						ISNULL(A0.TranYear, '''') AS TranYear,
						ISNULL(A1.AnaID, '''') AS Ana04ID,
						ISNULL(A1.AnaName, '''') AS Ana04Name,
						ISNULL(CONCAT(A0.TranMonth, ''/'', A0.TranYear),'''') as MonthYear,
						A04.UnitName, ISNULL(SUM(A0.OriginalAmount),0) AS OriginalAmount, ISNULL(SUM(A0.ConvertedAmount),0) AS ConvertedAmount
					FROM #temp3 TMP
					LEFT JOIN AT9000 A0 ON A0.InventoryID like TMP.InventoryID 
					LEFT JOIN AV6666 V6 ON A0.InventoryID = V6.SelectionID AND V6.SelectionType = ''IN''
					LEFT JOIN AT8899 A98 WITH (NOLOCK) ON A98.DivisionID = A0.DivisionID AND A98.VoucherID = A0.VoucherID AND A98.TransactionID = A0.TransactionID
					LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = A98.S01ID AND AT01.StandardTypeID = ''S01''
					LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = A98.S02ID AND AT02.StandardTypeID = ''S02''
					LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = A98.S03ID AND AT03.StandardTypeID = ''S03''
					LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = A98.S04ID AND AT04.StandardTypeID = ''S04''
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = ''T04''
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = ''T24''
					LEFT JOIN AT1011 A1 ON A1.AnaID = A0.Ana04ID AND A1.AnaTypeID = ''A04''
					LEFT JOIN AT1304 A04 ON A0.ConvertedUnitID = A04.UnitID--, ROW_NUMBER() OVER (ORDER BY A0.InventoryID)
					WHERE A0.InventoryID <> '''' AND A0.Ana04ID <> ''''
					GROUP BY V6.SelectionID, V6.SelectionName, A0.ConvertedUnitID, AT01.StandardID, AT02.StandardID, AT03.StandardID, AT04.StandardID, A0.TranMonth, A0.TranYear, A1.AnaID, A1.AnaName, CONCAT(A0.TranMonth, ''/'', A0.TranYear), A04.UnitName, AT01.StandardName, AT02.StandardName, AT03.StandardName, AT04.StandardName
					
					UNION

					-- Lấy các InventoryID từ #temp3 không có trong AT9000
					SELECT  '''' as RowNum, TMP.InventoryID, '''', '''', '''','''','''','''','''', '''', '''', '''',0, 0, '''', '''','''','''','''','''', 0, 0
					FROM #temp3 TMP
					LEFT JOIN AT9000 A0 ON TMP.InventoryID = A0.InventoryID
					WHERE A0.InventoryID IS NULL
					--ORDER BY InventoryID desc, Ana04ID asc

					-- Xóa bảng tạm 
					DROP TABLE #temp3
					DROP TABLE #temp2'
	PRINT(@sSQL)
	EXEC (@sSQL)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO