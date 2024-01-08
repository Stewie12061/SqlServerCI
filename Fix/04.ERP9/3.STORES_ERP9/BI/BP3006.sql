IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Biểu đồ Số lượng bán và Doanh số bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ Số lượng bán và Doanh số bán
-- <History>
---- Create on 28/06/2016 by Phuong Thao: 
---- Modified on 28/06/2016 by Phuong Thao
---- Modified on 11/07/2016 by Kim Vu: Mode 2 không lấy divisionid,tranyear, InventoryID, Tranmonth as ChartLabel
---- Modified by Tiểu Mai on 12/01/2017: Sửa cách lấy số tiền Amount
---- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
---- Modified by Tiểu Mai on 06/07/2017: Chỉnh sửa cách lấy dữ liệu theo yêu cầu khách hàng (theo phụ lục 2)
---- Modified by Tiểu Mai on 11/10/2017: Bổ sung sắp xếp lại thứ tự hiển thị
---- Modified by Thành Luân on 14/09/2020: Bổ sung @@@ cho Division, Customize cho khách hàng VNF
-- <Example>
---- EXEC BP3006 'ANG', 1, 2017,  3,2017,'TKUAG100H02','TKUAG100K03','TKUAG80H01','TKUAG80K03','TSTB100S01', 'TSTW100W01', '', '', '', '', '', 0, 'SP11', 'SP11'
CREATE PROCEDURE BP3006
(
	@DivisionID VARCHAR(50), 	
	@FromMonth INT, 
	@FromYear INT, 	
	@ToMonth INT, 
	@ToYear INT, 		
	@FromInventoryID01 VARCHAR(50),
	@ToInventoryID01 VARCHAR(50),
	@FromInventoryID02 VARCHAR(50),
	@ToInventoryID02 VARCHAR(50),
	@FromInventoryID03 VARCHAR(50),
	@ToInventoryID03 VARCHAR(50),
	@FromInventoryID04 VARCHAR(50),
	@ToInventoryID04 VARCHAR(50),
	@FromInventoryID05 VARCHAR(50),
	@ToInventoryID05 VARCHAR(50),
	@AnaID NVARCHAR(50),
	@Type TINYINT,	---- 0: không where theo AnaID
					---- 1: AnaID = AnaID02
					---- 2: AnaID = AnaID03
	@FromInventoryTypeID NVARCHAR(50),
	@ToInventoryTypeID NVARCHAR(50)
) 
AS
SET NOCOUNT ON
DECLARE	@sSQL1 as nvarchar(MAX)='',
		@sSQL2 as nvarchar(MAX)='',
		@EmployeeName NVARCHAR(250),
		@CustomerIndex INT = NULL;

SELECT TOP(1) @CustomerIndex = CustomerName FROM CustomerIndex
	
SELECT @EmployeeName = ISNULl(AnaName,'') FROM OT1002 WHERE AnaID = @AnaID AND DivisionID = @DivisionID

DECLARE @Cur_Ware CURSOR, @GroupID NVARCHAR(50), @FromInventoryID NVARCHAR(50), @ToInventoryID NVARCHAR(50)

SET @Cur_Ware = CURSOR SCROLL KEYSET FOR
	SELECT GroupID, FromInventoryID, ToInventoryID
	FROM (
		SELECT 'Group01' AS GroupID, @FromInventoryID01 AS FromInventoryID, @ToInventoryID01 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE ISNULL(@FromInventoryID01,'') <> '' AND ISNULL(@ToInventoryID01,'') <> '' AND (InventoryID BETWEEN @FromInventoryID01 AND @ToInventoryID01)
		UNION
		SELECT 'Group02' AS GroupID, @FromInventoryID02 AS FromInventoryID, @ToInventoryID02 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE ISNULL(@FromInventoryID02,'') <> '' AND ISNULL(@ToInventoryID02,'') <> '' AND (InventoryID BETWEEN @FromInventoryID02 AND @ToInventoryID02)
		UNION
		SELECT 'Group03' AS GroupID, @FromInventoryID03 AS FromInventoryID, @ToInventoryID03 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE ISNULL(@FromInventoryID03,'') <> '' AND ISNULL(@ToInventoryID03,'') <> '' AND (InventoryID BETWEEN @FromInventoryID03 AND @ToInventoryID03)
		UNION
		SELECT 'Group04' AS GroupID, @FromInventoryID04 AS FromInventoryID, @ToInventoryID04 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE ISNULL(@FromInventoryID04,'') <> '' AND ISNULL(@ToInventoryID04,'') <> '' AND (InventoryID BETWEEN @FromInventoryID04 AND @ToInventoryID04)
		UNION
		SELECT 'Group05' AS GroupID, @FromInventoryID05 AS FromInventoryID, @ToInventoryID05 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE ISNULL(@FromInventoryID05,'') <> '' AND ISNULL(@ToInventoryID05,'') <> '' AND (InventoryID BETWEEN @FromInventoryID05 AND @ToInventoryID05)
	) T
	ORDER BY T.GroupID
OPEN @Cur_Ware
FETCH NEXT FROM @Cur_Ware INTO @GroupID, @FromInventoryID, @ToInventoryID

IF(@CustomerIndex = 107)
BEGIN
WHILE @@Fetch_Status = 0 
	BEGIN
		IF ISNULL(@sSQL1,'') <> ''
			SET @sSQL1 = @sSQL1 + '
				UNION
				SELECT '''+@GroupID+''' as GroupID,
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS  Amount,
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100				
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear '
			
		ELSE 
			SET @sSQL1 = @sSQL1 + '
				SELECT '''+@GroupID+''' as GroupID,  
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS  Amount,	
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID	
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100				
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear'
				
				
		IF ISNULL(@sSQL2,'') <> ''
			SET @sSQL2 = @sSQL2 + '
				UNION
				SELECT '''+@GroupID+''' as GroupID,  
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID	
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100				
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear'
				
		ELSE 
			SET @sSQL2 = @sSQL2 + '
				SELECT '''+@GroupID+''' as GroupID,  
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID	
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE 
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100				
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear'
				
				
		FETCH NEXT FROM @Cur_Ware INTO @GroupID, @FromInventoryID, @ToInventoryID
	END 
END

ELSE
BEGIN
WHILE @@Fetch_Status = 0 
	BEGIN
		IF ISNULL(@sSQL1,'') <> ''
			SET @sSQL1 = @sSQL1 + '
				UNION
				SELECT '''+@GroupID+''' as GroupID, 
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS  Amount,	
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID	
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S02'' ' 
				ELSE
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S03'' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
				AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> ''''
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear '
			
		ELSE 
			SET @sSQL1 = @sSQL1 + '
				SELECT '''+@GroupID+''' as GroupID,  
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS  Amount,	
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID	
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S02'' ' 
				ELSE
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S03'' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
				AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> ''''
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear'
				
				
		IF ISNULL(@sSQL2,'') <> ''
			SET @sSQL2 = @sSQL2 + '
				UNION
				SELECT '''+@GroupID+''' as GroupID,  
					O01.DivisionID, O01.TranMonth, O01.TranYear,
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID	
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S02'' ' 
				ELSE
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S03'' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
				AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> ''''
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear'
				
		ELSE 
			SET @sSQL2 = @sSQL2 + '
				SELECT '''+@GroupID+''' as GroupID,  
					O01.DivisionID, O01.TranMonth, O01.TranYear,	
					SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS Quantity
				FROM OT2001 O01 WITH (NOLOCK)
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID	
				LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (O02.DivisionID, ''@@@'') AND O02.InventoryID = A32.InventoryID
				' + CASE WHEN @Type = 1 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S02'' ' 
				ELSE 
				(CASE WHEN @Type = 2 THEN 'LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND AnaID LIKE '''+@AnaID+''' AND O12.AnaTypeID = ''S03'' ' 
				ELSE '' END) END + '
				WHERE O01.DivisionID = '''+@DivisionID+'''
				AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
				AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> ''''
				AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
				AND A32.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
				AND O01.OrderStatus = 1
				' + CASE WHEN @Type = 1 THEN 'AND O01.Ana02ID LIKE '''+@AnaID+''' ' ELSE (CASE WHEN @Type = 2 THEN 'AND O01.Ana03ID LIKE '''+@AnaID+''' ' ELSE '' END) END + '
				GROUP BY O01.DivisionID, O01.TranMonth, O01.TranYear'
				
				
		FETCH NEXT FROM @Cur_Ware INTO @GroupID, @FromInventoryID, @ToInventoryID
	END 
END

CLOSE @Cur_Ware

IF ISNULL(@sSQL1,'') <> '' AND ISNULL(@sSQL2,'') <> ''
BEGIN 
	EXEC ('
	SELECT GroupID, DivisionID, TranMonth, TranYear,
	SUM(Amount) As Amount, SUM(Quantity) AS AcctualyQuantity
	INTO #BP3006_SALES
	FROM
	(' + @sSQL1 + '
	)	T	
	GROUP BY GroupID, DivisionID, TranMonth, TranYear

	SELECT GroupID, DivisionID, TranMonth, TranYear,
	SUM(Quantity) As ProQuantity
	INTO #BP3006_PRO
	FROM
		('+ @sSQL2 +'
		) T
	GROUP BY GroupID, DivisionID, TranMonth, TranYear

	SELECT T1.GroupID as InventoryID, T1.TranMonth, T1.TranYear, LTRIM(RTRIM(T1.TranMonth))+''/''+  LTRIM(RTRIM(T1.TranYear))  as ChartLabel, 
			T1.AcctualyQuantity, T2.ProQuantity, T1.Amount, CONVERT(NVARCHAR(250),'''') AS EmployeeName
	INTO #TEST
	FROM #BP3006_SALES T1
	LEFT JOIN  #BP3006_PRO T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear AND T1.GroupID = T2.GroupID
	ORDER BY T1.GroupID, LTRIM(RTRIM(T1.TranMonth))+''/''+  LTRIM(RTRIM(T1.TranYear))

	UPDATE #TEST
	SET EmployeeName = N'''+@EmployeeName+'''

	SELECT * FROM #TEST
	ORDER BY InventoryID,  TranYear, TranMonth
	
		')
END 


PRINT (@sSQL1)
PRINT (@sSQL2)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
