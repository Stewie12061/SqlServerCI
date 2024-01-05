
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In Tinh hinh thuc hien don hang ban
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 04/11/2004 by Vo Thanh Huong
---- 
---- Modified on 16/05/2013 by Le Thi Thu Hien : Chỉnh sửa Unicode
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified on 28/09/2020 by Huỳnh Thử  : Bổ sung danh mục dùng chung
---- Modified on 19/06/2017 by Hải Long: Loại bỏ ngày 01/01/1900
---- Modified on 08/10/2022 by Đình Định: Lấy tình hình giao hàng
---- Modified on 13/10/2022 by Hoài Bảo: Bổ sung truyền danh sách đơn vị
---- Modified on 17/10/2022 by Hoài Bảo: Fix lỗi khi in báo cáo mẫu 2, 3
---- Modified on 17/01/2023 by Anh Đô: Select thêm cột Notes, ObjectName
-- <Example>
CREATE PROCEDURE [dbo].[OP3013]
(
		@DivisionID			NVARCHAR(50),	--Biến môi trường
		@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
		@OrderID NVARCHAR(50),
		@ReportID VARCHAR(50)
)
AS
DECLARE 
		@VoucherNo NVARCHAR(50),
		@VoucherDate DATETIME,
		@ReAccountID AS NVARCHAR(50), -- lay tai khoan phai thu mac dinh
		@ObjectName AS NVARCHAR(250),
		@DueDate DATETIME

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	SET @DivisionID = @DivisionIDList

SELECT	@VoucherNo = VoucherNo, 
		@VoucherDate = OrderDate , 
		@ObjectName = AT1202.ObjectName, 
		@ReAccountID = ISNULL (ReAccountID,' ') ,
		@DueDate = ISNULL (DueDate, ' ')
FROM	OT2001 WITH (NOLOCK)
INNER JOIN  AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
WHERE	SOrderID = @OrderID

--- Lấy dữ liệu ngày giao
SELECT DISTINCT 
	OT03.DivisionID
	,ROW_NUMBER() OVER (ORDER BY OT03.Date) AS Times
	,[Date] AS Dates
INTO #OP3013_OV2102
FROM OT2003_MT OT03 WITH (NOLOCK)
WHERE DivisionID IN (@DivisionID, '@@@')
	  AND SOrderID = @OrderID
ORDER BY OT03.[Date]

--- lấy ngày, mặt hàng, đơn vị, thông số
SELECT	T00.DivisionID
		,V00.Dates
		,V00.Times
		,T00. InventoryID
		,A00.InventoryName
		,A01.UnitName
		,A00.Specification
		,A00.InventoryTypeID
		,SUM(OrderQuantity)AS OrderQuantity
		,T00.Orders
		,(ISNULL(SUM(T00.ConvertedAmount),0) +  ISNULL(SUM(T00.VATConvertedAmount),0)) AS OrderConvertedAmount
		,(ISNULL(SUM(T00.OriginalAmount),0)  +  ISNULL(SUM(T00.OriginalAmount),0)) AS OrderOriginalAmount
		,
		SUM(
		CASE WHEN Times = 1 THEN Quantity01 
		when Times = 2 THEN Quantity02 
		when Times = 3 THEN Quantity03 
		when Times = 4 THEN Quantity04 
		when Times = 5 THEN Quantity05 
		when Times = 6 THEN Quantity06 
		when Times = 7 THEN Quantity07 
		when Times = 8 THEN Quantity08 
		when Times = 9 THEN Quantity09 
		when Times = 10 THEN Quantity10 
		when Times = 11 THEN Quantity11 
		when Times = 12 THEN Quantity12 
		when Times = 13 THEN Quantity13 
		when Times = 14 THEN Quantity14 
		when Times = 15 THEN Quantity15 
		when Times = 16 THEN Quantity16 
		when Times = 17 THEN Quantity17 
		when Times = 18 THEN Quantity18 
		when Times = 19 THEN Quantity19 
		when Times = 20 THEN Quantity20 
		when Times = 21 THEN Quantity21 
		when Times = 22 THEN Quantity22 
		when Times = 23 THEN Quantity23 
		when Times = 24 THEN Quantity24 
		when Times = 25 THEN Quantity25 
		when Times = 26 THEN Quantity26 
		when Times = 27 THEN Quantity27 
		when Times = 28 THEN Quantity28 
		when Times = 29 THEN Quantity29 
		when Times = 30 THEN Quantity30  end
	) AS Quantity
	, A02.Notes
INTO #OP3013_OV2103
FROM OT2002 T00 WITH (NOLOCK) 
CROSS JOIN #OP3013_OV2102 V00 
INNER JOIN AT1302 A00 WITH (NOLOCK) ON A00.DivisionID IN ('@@@', V00.DivisionID) 
		AND A00.InventoryID = T00.InventoryID
INNER JOIN AT1304 A01 WITH (NOLOCK) ON A00.UnitID = A01.UnitID
LEFT JOIN AT2007 A02 WITH (NOLOCK) ON A02.OTransactionID = T00.TransactionID
WHERE T00.DivisionID IN (@DivisionID, '@@@')
		AND T00.SOrderID =  @OrderID
GROUP BY	
	T00.DivisionID
	,V00.Dates
	,V00.Times
	,T00.InventoryID
	,A00.InventoryName
	,A01.UnitName
	,T00.Orders
	,A00.Specification
	,A00.InventoryTypeID 
	,A02.Notes

SELECT  A00.DivisionID
		, A00.OrderID
		, A00.InventoryID
		, ISNULL(SUM(ActualQuantity), 0) AS ActualQuantity
		, (
			SELECT	SUM(ISNULL(ConvertedAmount, 0)) 
			FROM		AT9000 WITH (NOLOCK) 
			WHERE		OrderID = A00.OrderID AND InventoryID = A00.InventoryID)
		  + 
		  (
			 (SELECT	SUM(ISNULL(ConvertedAmount, 0)) 
				FROM AT9000  WITH (NOLOCK)
				WHERE OrderID = A00.OrderID 
		  		AND InventoryID = A00.InventoryID
			)
			*ISNULL(
				(SELECT ISNULL(VATRate,0) 
		  		 FROM AT1010 WITH (NOLOCK) 
		  		 WHERE VATGroupID IN
				 (
					 SELECT TOP 1 VATGroupID 
		  			 FROM	AT9000 WITH (NOLOCK) 
		  			WHERE	OrderID = A00.OrderID 
		  			AND    TransactiontypeID = 'T04')), 0) / 100
				  ) 
			AS ActualConvertedAmount
		, (SELECT SUM(ISNULL(OriginalAmount, 0)) FROM AT9000 WITH (NOLOCK) WHERE OrderID = A00.OrderID And InventoryID = A00.InventoryID)
		  + 
		  (
			(SELECT SUM(ISNULL(OriginalAmount, 0)) FROM AT9000 WITH (NOLOCK) WHERE OrderID = A00.OrderID And InventoryID = A00.InventoryID)
			*
			ISNULL
			(
				(SELECT ISNULL(VATRate,0) 
		         FROM at1010 WITH (NOLOCK) 
		         WHERE VATGroupID IN
				 (SELECT TOP 1 VATGroupID 
		          FROM AT9000 WITH (NOLOCK) 
		          WHERE OrderID = A00.OrderID 
				 AND TransactiontypeID = 'T04')), 0)/100
			)
			AS ActualOriginalAmount
		, A09.T01OriginalAmount
		, A09.T01ConvertedAmount
		, SumActualConvertedAmount
		, SumActualOriginalAmount
INTO #OP3013_OV2104
FROM AT2007 A00  WITH (NOLOCK)
INNER JOIN AT2006 A01 WITH (NOLOCK) ON A01.DivisionID = A00.DivisionID 
										AND A00.VoucherID = A01.VoucherID 
										AND A01.KindVoucherID IN (2, 4)
LEFT JOIN (SELECT DivisionID, OrderID, 
					ISNULL(SUM(OriginalAmount),0) AS T01OriginalAmount , 
					isnull (SUM(ConvertedAmount),0) AS T01ConvertedAmount
			FROM	AT9000  WITH (NOLOCK)
            WHERE	CreditAccountID = @ReAccountID
					AND OrderID = @OrderID
            GROUP BY OrderID, DivisionID
		  )  A09 ON A09.DivisionID = A00.DivisionID 
					AND A09.OrderID = A00.OrderID
LEFT JOIN (SELECT	DivisionID, OrderID, 
					ISNULL(SUM(ConvertedAmount),0) AS SumActualConvertedAmount, 
					ISNULL(SUM(OriginalAmount),0) AS SumActualOriginalAmount
	       FROM		AT9000  WITH (NOLOCK) 
           WHERE	OrderID = @OrderID
					AND TransactiontypeID in ('T04', 'T14') 
           GROUP BY OrderID, DivisionID
		  )  A02 ON	A02.DivisionID = A00.DivisionID AND A02.OrderID = A00.OrderID
WHERE A00.DivisionID IN (@DivisionID, '@@@')
		AND A00.OrderID = @OrderID
GROUP BY	A00.DivisionID, A00.OrderID,  A00.InventoryID, 
			A09.T01OriginalAmount, A09.T01ConvertedAmount,
			SumActualConvertedAmount, 
			SumActualOriginalAmount


SELECT	T00.DivisionID
		, T00.InventoryID
		, InventoryName
		, A01.UnitName
		, A00.Specification
		, A00.InventoryTypeID
		, VoucherDate AS Dates
		, V00.ActualQuantity
		,  V00.ActualConvertedAmount
		, V00.ActualOriginalAmount
		, SUM(T00.ActualQuantity) AS Quantity
		, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount
		, ISNULL(SUM(OriginalAmount), 0) AS OriginalAmount
		, V00.T01OriginalAmount
		, V00.T01ConvertedAmount
		, SumActualConvertedAmount
		, SumActualOriginalAmount
INTO #OP3013_OV2105
FROM	AT2007  T00 WITH (NOLOCK)   
INNER JOIN AT2006 T01 WITH (NOLOCK) ON T01.DivisionID = T00.DivisionID 
		AND T00.VoucherID = T01.VoucherID 
		AND T01.KindVoucherID in(2,4)
INNER JOIN #OP3013_OV2104 V00 ON V00.DivisionID = T00.DivisionID 
		AND T00.InventoryID = V00.InventoryID
INNER JOIN AT1302 A00 WITH (NOLOCK) ON A00.DivisionID IN ('@@@', T00.DivisionID) 
		AND T00.InventoryID = A00.InventoryID
INNER JOIN AT1304 A01 WITH (NOLOCK) ON A00.UnitID = A01.UnitID
WHERE	T00.OrderID = @OrderID
		AND T00.DivisionID IN (@DivisionID, '@@@')
GROUP BY	T00.DivisionID, T00.InventoryID, InventoryName,  
			A01.UnitName, Voucherdate , V00.ActualQuantity,  
			A00.Specification, A00.InventoryTypeID,  
			V00.ActualConvertedAmount , V00.ActualOriginalAmount,
			V00.T01OriginalAmount, V00.T01ConvertedAmount,
			SumActualConvertedAmount, SumActualOriginalAmount


---Tat ca ngay  trong ke hoach san xuat va thuc te thuc hien
SELECT *
INTO #OP3013_OV2106
FROM 
(
	SELECT DivisionID
		  ,Dates

	FROM #OP3013_OV2102 
	UNION
		SELECT DISTINCT DivisionID 
					, Dates 
			
		FROM #OP3013_OV2105
) TB
WHERE Dates <> '01/01/1900'

SELECT	V00.DivisionID
		, @VoucherNo AS VoucherNo
		, CONVERT(VARCHAR(10), @VoucherDate, 103) AS VoucherDate
		, @ObjectName AS ObjectName
		, CONVERT(VARCHAR(10), @DueDate, 103) AS DueDate
		, V00.InventoryID
		, V00.InventoryName
		, V00.UnitName
		, V00.Specification
		, V00.InventoryTypeID
		, Dates
		, 1 AS Types
		, 'OFML000183' AS TypeName
		, OrderQuantity
		, OrderConvertedAmount
		, OrderOriginalAmount
		, V01.ActualQuantity
		, ActualConvertedAmount
		, ActualOriginalAmount
		, Quantity
		, 0 AS ConvertedAmount
		, 0 AS OriginalAmount
		, V01.T01OriginalAmount
		, V01.T01ConvertedAmount 
		, SumActualConvertedAmount
		, SumActualOriginalAmount
		, Notes
INTO #OP3013_OV2117
FROM		#OP3013_OV2103 V00 
LEFT JOIN	#OP3013_OV2104 V01 
			ON V01.DivisionID = V00.DivisionID 
			AND V00.InventoryID = V01.InventoryID

SELECT DISTINCT V00.DivisionID
		, @VoucherNo AS VoucherNo
		, convert(nvarchar(10), @VoucherDate, 103) AS VoucherDate
		, @ObjectName AS ObjectName
		, convert(nvarchar(10), @DueDate, 103) AS DueDate
		, V00.InventoryID
		, V00.InventoryName
		, V00.UnitName
		, V00.Specification
		, V00.InventoryTypeID
		, V00.Dates
		, 1 AS Types
		, 'OFML000183' AS TypeName
		, V01.OrderQuantity AS OrderQuantity
		, OrderConvertedAmount
		, OrderOriginalAmount
		, ActualQuantity
		, ActualConvertedAmount
		, ActualOriginalAmount
		, 0 AS Quantity
		, 0 AS ConvertedAmount
		, 0 AS OriginalAmount
		, V00.T01OriginalAmount
		, V00.T01ConvertedAmount
		, SumActualConvertedAmount
		, SumActualOriginalAmount
		, Notes
INTO #OP3013_OV2127
FROM	#OP3013_OV2105  V00 
LEFT JOIN (
		SELECT DISTINCT DivisionID
						, InventoryID
						, OrderQuantity
						, OrderConvertedAmount 
						, OrderOriginalAmount
						, Notes
					FROM #OP3013_OV2103) V01 
		   ON V01.DivisionID = V00.DivisionID
		   AND V00.InventoryID = V01.InventoryID
WHERE V00.Dates NOT IN (SELECT DISTINCT Dates FROM #OP3013_OV2102) 

 SELECT V00.DivisionID
		, @VoucherNo AS VoucherNo
		, convert(nvarchar(10), @VoucherDate, 103) AS VoucherDate
		, @ObjectName AS ObjectName
		, convert(nvarchar(10), @DueDate, 103) AS DueDate
		, V00.InventoryID
		, V00.InventoryName
		, V00.UnitName
		, V00.Specification
		, V00.InventoryTypeID
		, Dates
		, 2 AS Types
		, 'OFML000184' AS TypeName
		, V01.OrderQuantity
		, OrderConvertedAmount
		, OrderOriginalAmount
		, ActualQuantity
		, ActualConvertedAmount
		, ActualOriginalAmount
		, Quantity
		, ConvertedAmount
		, OriginalAmount
		, V00.T01OriginalAmount
		, V00.T01ConvertedAmount
		, SumActualConvertedAmount
		, SumActualOriginalAmount
		, Notes
INTO #OP3013_OV2137
FROM #OP3013_OV2105 V00 
INNER JOIN(
			SELECT Distinct DivisionID
							, InventoryID
							, OrderQuantity
							, OrderConvertedAmount
							, OrderOriginalAmount
							, Notes
          	 FROM	#OP3013_OV2103
		  ) V01 
				ON V01.DivisionID = V00.DivisionID 
				AND V00.InventoryID = V01.InventoryID

-- #OP3013_OV2147 FROM #OP3013_OV2103 LEFT JOIN #OP3013_OV2104
SELECT DISTINCT V00.DivisionID
		, @VoucherNo AS VoucherNo
		, convert(nvarchar(10), @VoucherDate, 103) AS VoucherDate
		, @ObjectName AS ObjectName
		, convert(nvarchar(10), @DueDate, 103) AS DueDate
		, V00.InventoryID
		, V00.InventoryName
		, V00.UnitName
		, V00.Specification
		, V00.InventoryTypeID
		, V00.Dates
		, 2 AS Types
		, 'OFML000184' AS TypeName
		, OrderQuantity
		, OrderConvertedAmount
		, OrderOriginalAmount
		, V01.ActualQuantity
		, ActualConvertedAmount
		, ActualOriginalAmount
		, 0 AS Quantity
		, 0 AS ConvertedAmount
		, 0 AS OriginalAmount
		, V01.T01OriginalAmount
		, V01.T01ConvertedAmount
		, SumActualConvertedAmount
		, SumActualOriginalAmount
		, V00.Notes
INTO #OP3013_OV2147
FROM	#OP3013_OV2103 V00 
LEFT JOIN #OP3013_OV2104 V01 ON V01.DivisionID = V00.DivisionID 
	AND V00.InventoryID = V01.InventoryID
WHERE Dates NOT IN (SELECT DISTINCT Dates FROM #OP3013_OV2105)

SELECT * 
INTO #OP3013_OV2107
FROM 
( 
	SELECT * FROM #OP3013_OV2117
	UNION
	SELECT * FROM #OP3013_OV2127 
	UNION
	SELECT * FROM #OP3013_OV2137 
	UNION
	SELECT * FROM #OP3013_OV2147
) Result
WHERE Dates <> '01/01/1900'

--- Xử lý Result
BEGIN
	
		DECLARE @sSQL NVARCHAR(max)=''
			   ,@query AS NVARCHAR(MAX)= ''
			   ,@cols  AS NVARCHAR(MAX)= ''
			   ,@cols1  AS NVARCHAR(MAX)= ''

			-- Tình hình giao hàng (mẫu 1)
		IF @ReportID = 'OR6001' 
		BEGIN

			SELECT @cols = @cols + QUOTENAME(Dates) + ',' 
			FROM
			(
				-- lấy ngày xuất kho
				SELECT DISTINCT  CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) + '_KH' 
					AS Dates
				FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
				WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
					AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
			) AS tmp

			-- substring :đang lấy chuỗi , len: lấy chuỗi nhưng không lấy khoảng trắng
			-- đang lấy chuỗi của ????
			SELECT @cols = SUBSTRING(@cols, 0, LEN(@cols))

			-- lấy ngày 2
			SELECT @cols1 = @cols1 + QUOTENAME(Dates) + ','
			FROM 
			(
				SELECT DISTINCT CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) +'_TT' AS Dates
				FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
				WHERE #OP3013_OV2107.Dates =  #OP3013_OV2106.Dates
					AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
			) AS tmp

			SELECT @cols1 = SUBSTRING(@cols1, 0, LEN(@cols1))

			IF @cols = '' OR @cols1 = ''
				RETURN

			SET @sSQL = 
				' SELECT * FROM 
					(
						SELECT DISTINCT
							#OP3013_OV2107.VoucherNo
							, #OP3013_OV2107.VoucherDate
							, #OP3013_OV2107.InventoryID
							, #OP3013_OV2107.InventoryName
							, #OP3013_OV2107.UnitName
							, #OP3013_OV2107.OrderQuantity 
							, #OP3013_OV2107.ActualQuantity
							,CASE
								WHEN #OP3013_OV2107.Types = 1
								THEN CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) + ''_KH'' 
							    ELSE CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) + ''_TT''
								END AS Dates1
							,CASE 
								WHEN #OP3013_OV2107.Types = 1 OR Types = 2 
								THEN ISNULL(#OP3013_OV2107.Quantity,0) 
								ELSE 0 END AS Quantity1 
							, #OP3013_OV2107.Notes
							, #OP3013_OV2107.ObjectName
							FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
								WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates 
								AND #OP3013_OV2107.DivisionID 
								IN (''' + @DivisionID + ''',''@@@'')
					) src
				PIVOT 
				(
					SUM(Quantity1)
					FOR Dates1 IN (' + @cols + ',' + @cols1 + ')
				) piv1 '

	    --- Load caption
		SELECT * FROM (
				SELECT DISTINCT CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) + '_KH' AS ID
					, CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) AS Dates
					,N' Kế hoạch ' AS [Name]
				FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
				WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
					AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
				UNION ALL
				SELECT DISTINCT CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) +'_TT' AS ID 
					, CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) AS Dates
					, N' Thực tế' AS [Name]
				FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
				WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
					AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
			) AS p
			ORDER BY Dates

		PRINT @sSQL
		EXEC (@sSQL)
	END


		IF @ReportID = 'OR6003' -- Tình hình giao hàng (mẫu 2)
	BEGIN
		SELECT @cols = @cols + QUOTENAME(Dates) + ',' FROM (SELECT DISTINCT  CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) AS Dates
																		From #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
																		Where #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
																		AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
																) AS tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		SET @sSQL = 
				' SELECT * FROM 
					(
						SELECT
							#OP3013_OV2107.VoucherNo
							,#OP3013_OV2107.VoucherDate
							,#OP3013_OV2107.InventoryID
							,#OP3013_OV2107.InventoryName
							,#OP3013_OV2107.UnitName
							,#OP3013_OV2107.OrderQuantity
							,CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) AS Dates1
							,CASE WHEN #OP3013_OV2107.Types = 2 AND #OP3013_OV2107.Quantity > 0
								THEN ISNULL(#OP3013_OV2107.Quantity,0)
								ELSE ISNULL(#OP3013_OV2107.ActualQuantity,0) end AS TQuantity
							, #OP3013_OV2107.Notes
							, #OP3013_OV2107.ObjectName
							From #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
							WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates 
							AND #OP3013_OV2107.Types = 2
							AND #OP3013_OV2107.DivisionID IN ('''+@DivisionID+''',''@@@'')
					) src
				pivot 
				(
					SUM(TQuantity)
					for Dates1 in ('+@cols+')
				) piv1
				'

		--- Load caption
		select * from (SELECT DISTINCT CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) as Dates
								From #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
								Where #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
								AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
						) as p
						order by Dates

		print @sSQL
		Exec (@sSQL)
	END
		IF @ReportID = 'OR6005' -- Chi tiết tình hình giao hàng (mẫu 3)
	BEGIN

		SELECT @cols = @cols + QUOTENAME(Dates) + ',' FROM 
		(
			SELECT DISTINCT  CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103)
			AS Dates
			FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
			WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
			AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
		) AS tmp

		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		SET @sSQL = 
				' SELECT * FROM 
					(
						SELECT
							#OP3013_OV2107.VoucherNo
							,#OP3013_OV2107.VoucherDate
							,#OP3013_OV2107.DueDate
							,#OP3013_OV2107.ObjectName
							,#OP3013_OV2107.T01OriginalAmount
							,#OP3013_OV2107.InventoryID
							,#OP3013_OV2107.InventoryName
							,#OP3013_OV2107.UnitName
							,#OP3013_OV2107.OrderQuantity
							,#OP3013_OV2107.OrderConvertedAmount
							,#OP3013_OV2107.ActualQuantity
							,#OP3013_OV2107.ActualConvertedAmount
							,CASE 
								WHEN #OP3013_OV2107.ActualQuantity is null 
									THEN #OP3013_OV2107.OrderQuantity 
								ELSE #OP3013_OV2107.OrderQuantity - #OP3013_OV2107.ActualQuantity end AS RemainQty
							,CASE 
								WHEN #OP3013_OV2107.ActualConvertedAmount IS NULL
								THEN #OP3013_OV2107.OrderConvertedAmount 
							ELSE
								#OP3013_OV2107.OrderConvertedAmount - #OP3013_OV2107.ActualConvertedAmount END AS RemainAmount
							,CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) AS Dates1
							,CASE WHEN #OP3013_OV2107.Types = 2 AND #OP3013_OV2107.Quantity > 0 
								THEN ISNULL(#OP3013_OV2107.Quantity,0) 
								ELSE ISNULL(#OP3013_OV2107.ActualQuantity,0) END AS TQuantity
							, #OP3013_OV2107.Notes
							FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
								WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
									AND #OP3013_OV2107.Types = 2
								AND #OP3013_OV2107.DivisionID IN ('''+@DivisionID+''',''@@@'')
					) src
				PIVOT 
				(
					SUM(TQuantity)
					FOR Dates1 IN ('+@cols+')
				) piv1'

		--- Load caption
		SELECT * FROM 
		(
			SELECT DISTINCT CONVERT(CHAR(10), #OP3013_OV2107.Dates, 103) AS Dates
			FROM #OP3013_OV2107 CROSS JOIN #OP3013_OV2106
			WHERE #OP3013_OV2107.Dates = #OP3013_OV2106.Dates
			AND #OP3013_OV2107.DivisionID IN (@DivisionID,'@@@')
		) AS p
		ORDER BY Dates

		PRINT @sSQL
		EXEC (@sSQL)
	END


END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

