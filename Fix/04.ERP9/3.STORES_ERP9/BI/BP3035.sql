IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo SALES
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ SALES
-- <History>
---- Created by Kiều Nga 25/09/2020: Biểu đồ SALES.
---- Modify by Kiều Nga 03/10/2020: Fix lỗi sai giá trị
-- <Example>
/*
 exec BP3035 @DivisionID = 'CM', @DivisionIDList = '', @ObjectID = NULL, @AccountID = NULL, @CurrencyID = NULL, @Date='2020-05-13', @UserID = 'Test'
*/

CREATE PROCEDURE BP3035
(
	@DivisionID		VARCHAR(50),
	@DivisionIDList	NVARCHAR(MAX),
	@IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					---- 1: Radiobutton từ ngày có check
	@FromDate DATETIME, 
	@ToDate DATETIME, 
	@FromMonth INT, 
	@FromYear INT, 
	@ToMonth INT, 
	@ToYear INT,
	@I03ID	NVARCHAR(MAX) = '',
	@I02ID	NVARCHAR(MAX) = '',
	@ObjectID	NVARCHAR(MAX) = '',
	@ReportID NVARCHAR(50) = '1',
	@Date DATETIME
)
AS
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = '',
			@sWhere NVARCHAR(MAX) = '',
			@SQL1 NVARCHAR(MAX) = '',
			@cols NVARCHAR(MAX) = '',
			@cols1 NVARCHAR(MAX) = '',
			@query1 NVARCHAR(MAX) = '',
			@query2 NVARCHAR(MAX) = ''

	-- Bảng Divisions
	DECLARE @Divisions TABLE (
		DivisionID NVARCHAR(50)
	);

	INSERT INTO @Divisions
	SELECT * FROM [dbo].StringSplit(REPLACE(COALESCE(@DivisionIDList, @DivisionID), '''', ''), ',');

	-- Bảng I03ID
	DECLARE @I03IDList TABLE (
		I03ID NVARCHAR(50)
	);

	INSERT INTO @I03IDList
	SELECT * FROM [dbo].StringSplit(REPLACE(@I03ID, '''', ''), ',');
    
	IF ISNULL(@I03ID,'') <> ''
	SET @sWhere = @sWhere + ' AND A1302.I03ID in (''' + @I03ID + ''')'

	IF @ReportID = '1' -- Xu hướng bán hàng
	BEGIN
		IF @IsDate = 0
			SET @sWhere = @sWhere + ' AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
		ELSE
			SET @sWhere = @sWhere + ' AND (Convert(varchar(20),A9000.VoucherDate,103) Between ''' + Convert(varchar(20),@FromDate,103) + ''' AND ''' + Convert(varchar(20),@ToDate,103) + ''')'

		-- Lấy dữ liệu cột động
		SELECT DISTINCT AnaID, AnaName
		INTO #COL
		FROM AT9000 AS A9000 WITH (NOLOCK)
		INNER JOIN AT1302 AS A1302 WITH (NOLOCK) ON A9000.InventoryID = A1302.InventoryID
		LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = 'I03' AND (A1015.DivisionID = '@@@' OR A1015.DivisionID IN (Select DivisionID FROM @Divisions))
		WHERE A9000.TransactionTypeID IN ('T04', 'T24') 
				AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
				AND (ISNULL(@I03ID,'') = '' OR A1302.I03ID IN (Select I03ID FROM @I03IDList))
				AND ISNULL(AnaID,'') <> ''
				AND ((@IsDate = 0 AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN @FromMonth + @FromYear * 100 AND @ToMonth + @ToYear * 100)
					OR (@IsDate = 1 AND Convert(varchar(20),A9000.VoucherDate,103) Between Convert(varchar(20),@FromDate,103) AND Convert(varchar(20),@ToDate,103)))

		SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM (select DISTINCT AnaID
															 FROM #COL
															) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = ''  RETURN

		--- Load caption chi tiết nhóm sản phẩm
		SELECT DISTINCT * FROM #COL

  		SET @SQL = N'SELECT * FROM(
						SELECT A1015.AnaID,LTRIM(A9000.TranMonth) + ''/'' + LTRIM(A9000.TranYear) as Period,A9000.TranMonth,
							ROUND(
								SUM(
									-- Doanh thu hàng bán trả lại thì trừ ra
									CASE WHEN A9000.TransactionTypeID = ''T24'' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
										 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
									END
								),
							0) AS Amount
						FROM AT9000 AS A9000
						 INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
						 LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
						 LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
						WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
							  AND A9000.DivisionID IN ('''+@DivisionIDList+''')
							  '+@sWhere+'
						GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,A9000.TranMonth,A9000.TranYear
						) src
					pivot 
					(
						SUM(Amount) for AnaID in (' + @cols + ')
					) piv
					ORDER BY TranMonth '

		--PRINT @SQL
		EXEC (@SQL)
	END
	IF @ReportID = '2' -- Sản lượng và giá bán
	BEGIN
	   	IF @IsDate = 0
			SET @sWhere = @sWhere + ' AND (A9000.TranMonth + A9000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+')'
		ELSE
			SET @sWhere = @sWhere + ' AND (Convert(varchar(20),A9000.VoucherDate,103) Between ''' + Convert(varchar(20),@FromDate,103) + ''' AND ''' + Convert(varchar(20),@ToDate,103) + ''')'

		-- Lấy dữ liệu cột động
		SELECT DISTINCT AnaID, AnaName
		INTO #COL2
		FROM AT9000 AS A9000 WITH (NOLOCK)
		INNER JOIN AT1302 AS A1302 WITH (NOLOCK) ON A9000.InventoryID = A1302.InventoryID
		LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = 'I03' AND (A1015.DivisionID = '@@@' OR A1015.DivisionID IN (Select DivisionID FROM @Divisions))
		WHERE A9000.TransactionTypeID IN ('T04', 'T24') 
				AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
				AND (ISNULL(@I03ID,'') = '' OR A1302.I03ID IN (Select I03ID FROM @I03IDList))
				AND ISNULL(AnaID,'') <> ''
				AND ((@IsDate = 0 AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN @FromMonth + @FromYear * 100 AND @ToMonth + @ToYear * 100)
					OR (@IsDate = 1 AND Convert(varchar(20),A9000.VoucherDate,103) Between Convert(varchar(20),@FromDate,103) AND Convert(varchar(20),@ToDate,103)))

		SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM (select DISTINCT AnaID +'_Quantity' as AnaID
															 FROM #COL2 
															) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		SELECT @cols1 = @cols1 + QUOTENAME(AnaID) + ',' FROM (select DISTINCT AnaID +'_UnitPrice' as AnaID
															 FROM #COL2
															) as tmp
		SELECT @cols1 = substring(@cols1, 0, len(@cols1))

		IF @cols = '' OR @cols1 = ''  RETURN

		--- Load caption chi tiết nhóm sản phẩm
		SELECT DISTINCT * FROM #COL2

  		SET @query1 = N'SELECT * FROM(
						SELECT A1015.AnaID + ''_Quantity'' as AnaID,LTRIM(A9000.TranMonth) + ''/'' + LTRIM(A9000.TranYear) as Period,A9000.TranMonth,ROUND(SUM(COALESCE(A9000.Quantity, 0.0)),0) AS Quantity							
						FROM AT9000 AS A9000
						 INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
						 LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
						 LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
						WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
							  AND A9000.DivisionID IN ('''+@DivisionIDList+''')
							  '+@sWhere+'
						GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,A9000.TranMonth,A9000.TranYear
						) src
					pivot 
					(
						SUM(Quantity) for AnaID in (' + @cols + ')
					) piv
					'

		SET @query2 = N'SELECT * FROM(
				SELECT A1015.AnaID + ''_UnitPrice'' as AnaID,LTRIM(A9000.TranMonth) + ''/'' + LTRIM(A9000.TranYear) as Period,A9000.TranMonth,ROUND(AVG(COALESCE(A9000.UnitPrice, 0.0)),0) AS UnitPrice						
				FROM AT9000 AS A9000
					INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
					LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
					LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
				WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
						AND A9000.DivisionID IN ('''+@DivisionIDList+''')
						'+@sWhere+'
				GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,A9000.TranMonth,A9000.TranYear
				) src
			pivot 
			(
				AVG(UnitPrice) for AnaID in (' + @cols1 + ')
			) piv
			'

		SET @SQL = N'SELECT T1.Period, '+@cols+' , '+@cols1+'
					FROM ('+@query1+') as T1
					LEFT JOIN ('+@query2+') as T2 ON T1.Period = T2.Period
					ORDER BY T1.TranMonth
					'

		PRINT @SQL
		EXEC (@SQL )

	END
	IF @ReportID = '3' -- Doanh thu
	BEGIN
		IF @IsDate = 0
			SET @sWhere = @sWhere + ' AND (A9000.TranMonth + A9000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+'
											OR A9000.TranMonth + A9000.TranYear * 100 BETWEEN '+STR(@FromMonth + (@FromYear - 1) * 100)+' AND '+STR(@ToMonth + (@ToYear - 1) * 100)+')'
		ELSE
			SET @sWhere = @sWhere + ' AND (Convert(varchar(20),A9000.VoucherDate,103) Between ''' + Convert(varchar(20),@FromDate,103) + ''' AND ''' + Convert(varchar(20),@ToDate,103) + ''')'

		-- Lấy dữ liệu cột động
		SELECT DISTINCT AnaID, AnaName
		INTO #COL3
		FROM AT9000 AS A9000 WITH (NOLOCK)
		INNER JOIN AT1302 AS A1302 WITH (NOLOCK) ON A9000.InventoryID = A1302.InventoryID
		LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = 'I03' AND (A1015.DivisionID = '@@@' OR A1015.DivisionID IN (Select DivisionID FROM @Divisions))
		WHERE A9000.TransactionTypeID IN ('T04', 'T24') 
				AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
				AND (ISNULL(@I03ID,'') = '' OR A1302.I03ID IN (Select I03ID FROM @I03IDList))
				AND ISNULL(AnaID,'') <> ''
				AND ((@IsDate = 0 AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN @FromMonth + @FromYear * 100 AND @ToMonth + @ToYear * 100)
					OR (@IsDate = 0 AND A9000.TranMonth + A9000.TranYear* 100 BETWEEN @FromMonth + (@FromYear - 1) * 100 AND @ToMonth + (@ToYear - 1) * 100))

		SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM (select DISTINCT AnaID
															 FROM #COL3
															) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		--- Load caption chi tiết nhóm sản phẩm
		SELECT DISTINCT * FROM #COL3

  		SET @SQL = N'SELECT * FROM(
						SELECT A1015.AnaID,LTRIM(A9000.TranMonth) + ''/'' + LTRIM(A9000.TranYear) as Period,A9000.TranMonth,
							ROUND(
								SUM(
									-- Doanh thu hàng bán trả lại thì trừ ra
									CASE WHEN A9000.TransactionTypeID = ''T24'' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
										 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
									END
								),
							0) AS Amount
						FROM AT9000 AS A9000
						 INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
						 LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
						 LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
						WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
							  AND A9000.DivisionID IN ('''+@DivisionIDList+''')
							  '+@sWhere+'
						GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,A9000.TranMonth,A9000.TranYear
						) src
					pivot 
					(
						SUM(Amount) for AnaID in (' + @cols + ')
					) piv
					ORDER BY TranMonth'

		PRINT @SQL
		EXEC (@SQL)
	END
	IF @ReportID = '4' -- Thống kê bán hàng
	BEGIN
		IF @IsDate = 0
			SET @sWhere = @sWhere + ' AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
		ELSE
			SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10), A9000.VoucherDate, 120) Between ''' + Convert(VARCHAR(10),@FromDate,120) + ''' AND ''' + Convert(varchar(10),@ToDate,120) + ''')'

		-- Lấy dữ liệu cột động
		SELECT DISTINCT AnaID, AnaName
		INTO #COL4
		FROM AT9000 AS A9000 WITH (NOLOCK)
		INNER JOIN AT1302 AS A1302 WITH (NOLOCK) ON A9000.InventoryID = A1302.InventoryID
		LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = 'I03' AND (A1015.DivisionID = '@@@' OR A1015.DivisionID IN (Select DivisionID FROM @Divisions))
		WHERE A9000.TransactionTypeID IN ('T04', 'T24') 
				AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
				AND (ISNULL(@I03ID,'') = '' OR A1302.I03ID IN (Select I03ID FROM @I03IDList))
				AND ISNULL(AnaID,'') <> ''
				AND ((@IsDate = 0 AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN @FromMonth + @FromYear * 100 AND @ToMonth + @ToYear * 100)
					OR (@IsDate = 1 AND Convert(varchar(10),A9000.VoucherDate,120) Between Convert(varchar(10),@FromDate,120) AND Convert(varchar(10),@ToDate,120)))

		SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM (select DISTINCT AnaID
															 FROM #COL4
															) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		--- Load caption chi tiết nhóm sản phẩm
		SELECT DISTINCT * FROM #COL4

		SET @SQL = N'SELECT * FROM(
						SELECT A1015.AnaID,FORMAT(A9000.VoucherDate,''dd/MM/yyyy'') as Period,A9000.VoucherDate,
						ROUND(SUM(COALESCE(A9000.Quantity, 0.0)),0) AS Quantity
						FROM AT9000 AS A9000
						 INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
						 LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
						 LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
						WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
							  AND A9000.DivisionID IN ('''+@DivisionIDList+''')
							  '+@sWhere+'
						GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,FORMAT(A9000.VoucherDate,''dd/MM/yyyy''),A9000.VoucherDate
						) src
					pivot 
					(
						SUM(Quantity) for AnaID in (' + @cols + ')
					) piv
					Order by VoucherDate
					'
					
  		SET @SQL1 = N'SELECT * FROM(
						SELECT A1015.AnaID,FORMAT(A9000.VoucherDate,''dd/MM/yyyy'') as Period,A9000.VoucherDate,
							ROUND(
								SUM(
									-- Doanh thu hàng bán trả lại thì trừ ra
									CASE WHEN A9000.TransactionTypeID = ''T24'' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
										 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
									END
								),
							0) AS Amount
						FROM AT9000 AS A9000
						 INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
						 LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
						 LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
						WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
							  AND A9000.DivisionID IN ('''+@DivisionIDList+''')
							  '+@sWhere+'
						GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,FORMAT(A9000.VoucherDate,''dd/MM/yyyy''),A9000.VoucherDate
						) src
					pivot 
					(
						SUM(Amount) for AnaID in (' + @cols + ')
					) piv
					Order by VoucherDate
					'

		PRINT @SQL
		PRINT @SQL1

		EXEC (@SQL + @SQL1)
	END
	IF @ReportID = '5' -- Thống kê doanh thu
	BEGIN
		IF @IsDate = 0
			SET @sWhere = @sWhere + ' AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
		ELSE
			SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10), A9000.VoucherDate, 120) Between ''' + Convert(VARCHAR(10),@FromDate,120) + ''' AND ''' + Convert(varchar(10),@ToDate,120) + ''')'

		-- Lấy dữ liệu cột động
		SELECT AnaID, AnaName,ROUND(SUM(-- Doanh thu hàng bán trả lại thì trừ ra
										CASE WHEN A9000.TransactionTypeID = 'T24' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
										 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
									END
								),
							0) AS Amount
		INTO #COL5
		FROM AT9000 AS A9000 WITH (NOLOCK)
		INNER JOIN AT1302 AS A1302 WITH (NOLOCK) ON A9000.InventoryID = A1302.InventoryID
		LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = 'I03' AND (A1015.DivisionID = '@@@' OR A1015.DivisionID IN (Select DivisionID FROM @Divisions))
		LEFT JOIN AT1010 ON (AT1010.DivisionID = '@@@' OR AT1010.DivisionID IN (Select DivisionID FROM @Divisions) AND A9000.VATGroupID = AT1010.VATGroupID)
		WHERE A9000.TransactionTypeID IN ('T04', 'T24') 
				AND A9000.DivisionID IN (Select DivisionID FROM @Divisions)
				AND (ISNULL(@I03ID,'') = '' OR A1302.I03ID IN (Select I03ID FROM @I03IDList))
				AND ISNULL(AnaID,'') <> ''
				AND ((@IsDate = 0 AND A9000.TranMonth + A9000.TranYear * 100 BETWEEN @FromMonth + @FromYear * 100 AND @ToMonth + @ToYear * 100)
					OR (@IsDate = 1 AND Convert(varchar(10),A9000.VoucherDate,120) Between Convert(varchar(10),@FromDate,120) AND Convert(varchar(10),@ToDate,120)))
		Group by AnaID, AnaName		

		SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM (select DISTINCT AnaID
															 FROM #COL5
															) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		--- Load caption chi tiết nhóm sản phẩm
		SELECT DISTINCT * FROM #COL5
					
  		SET @SQL = N'SELECT * FROM(
						SELECT A1015.AnaID,LTRIM(A9000.TranMonth) + ''/'' + LTRIM(A9000.TranYear) as Period,A9000.TranMonth,
							ROUND(
								SUM(
									-- Doanh thu hàng bán trả lại thì trừ ra
									CASE WHEN A9000.TransactionTypeID = ''T24'' THEN -(COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100)))
										 ELSE COALESCE(A9000.ConvertedAmount, 0.0) * (1+(AT1010.VATRate / 100))
									END
								),
							0) AS Amount
						FROM AT9000 AS A9000
						 INNER JOIN AT1302 AS A1302 ON A9000.InventoryID = A1302.InventoryID
						 LEFT JOIN  AT1015 AS A1015 ON A1302.I03ID = A1015.AnaID AND A1015.AnaTypeID = ''I03'' AND (A1015.DivisionID = ''@@@'' OR A1015.DivisionID IN ('''+@DivisionIDList+'''))
						 LEFT JOIN AT1010 ON (AT1010.DivisionID = ''@@@'' OR AT1010.DivisionID IN ('''+@DivisionIDList+''')) AND A9000.VATGroupID = AT1010.VATGroupID
						WHERE A9000.TransactionTypeID IN (''T04'', ''T24'') 
							  AND A9000.DivisionID IN ('''+@DivisionIDList+''')
							  '+@sWhere+'
						GROUP BY A9000.DivisionID, A1015.AnaID, A1015.AnaName,A9000.TranMonth,A9000.TranYear
						) src
					pivot 
					(
						SUM(Amount) for AnaID in (' + @cols + ')
					) piv
					ORDER BY TranMonth'

		PRINT @SQL
		EXEC (@SQL )
	END
	IF @ReportID = '6' -- Thống kê công nợ khách hàng
	BEGIN
		-- Báo cáo tổng công nợ lấy từ mã phân tích nghiệp vụ
		-- Thực thi Store AP0316_V2
		EXEC AP0316_V2 @DivisionID = @DivisionID,
					   @ReportCode = 'NT08',
					   @ObjectID = @ObjectID,
					   @AccountID = NULL,
					   @CurrencyID = NULL,
					   @ReportDate = @Date,
					   @IsBefore = 0,
					   @IsType = 2,
					   @DivisionIDList = @DivisionIDList

		SET @SQL =N'SELECT ObjectID,ObjectName,SUM(COALESCE(OriginalAmount1, 0.0)) as OriginalAmount1,SUM(COALESCE(OriginalAmount2,0.0)) as OriginalAmount2,SUM(COALESCE(OriginalAmount3,0.0)) as OriginalAmount3
					FROM AV0316
					WHERE DivisionID IN ('''+@DivisionIDList+''')
					'+ CASE WHEN ISNULL(@I02ID,'') <> '' THEN ' AND Ana02ID in (''' + @I02ID + ''') '  ELSE '' END +'
					AND ISNULL(Ana02ID,'''') <> ''''
					AND ObjectID IN (SELECT ObjectID FROM AT1202 WHERE IsCustomer = 1 AND (Disabled = 0 OR Disabled IS NULL))
					Group by ObjectID,ObjectName'

		PRINT @SQL
		EXEC (@SQL)
	END
END

