IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0172]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0172]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- In báo cáo theo dõi hóa đơn tại OP (ANGEL)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tieu Mai on 01/08/2017
---- Modified by Tiểu Mai on 18/10/2017: Chỉnh sửa cách hiển thị mặt hàng còn nợ theo lũy kế hóa đơn
---- Modified by Tiểu Mai on 07/11/2017: Fix bug số lượng hàng nợ chưa hiển thị đúng
---- Modified on 15/05/2018 by Bảo Anh: Sửa lỗi cột Thông tin hàng nợ chưa đúng
---- Modified on 07/02/2022 by Nhật Thanh: Merge code angel
---- Modified on 05/04/2022 by Nhật Thanh: Bổ sung điều kiện DivisionID @@@ khi join bảng
-- <Example>
/*	
	exec OP0172 'ANG', '2017-01-02 00:00:00.000', '2017-07-27 00:00:00.000', 1, 2017, 7, 2017, 0, 'KV11', 'MT', '00022', 'XOABO', '01509', '01509', '01406', '01406'	

*/
CREATE PROCEDURE OP0172
(
	@DivisionID		NVARCHAR(50),
	@FromDate		DATETIME,
	@ToDate			DATETIME,
	@FromMonth		INT,
	@FromYear		INT,
	@ToMonth		INT,
	@ToYear			INT,
	@IsDate			TINYINT,
	@FromArea		NVARCHAR(50),
	@ToArea			NVARCHAR(50),
	@FromObjectID	NVARCHAR(50),
	@ToObjectID		NVARCHAR(50),
	@FromAna03ID	NVARCHAR(50),
	@ToAna03ID		NVARCHAR(50),
	@FromAna05ID	NVARCHAR(50),
	@ToAna05ID		NVARCHAR(50)
	
)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@Cur CURSOR,
		@SOrderID NVARCHAR(50),
		@InventoryID NVARCHAR(50),
		@QuantityOwed DECIMAL(28,8),
		@ProQuantityOwed DECIMAL(28,8)
		
		
SET @sSQL = N''
SET @sSQL1 = N''
SET @sWhere = N''

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + N' AND O01.TranMonth + O01.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+ STR(@ToMonth+@ToYear*100)
END
ELSE
BEGIN
	SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),O01.OrderDate,101) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,101)+''' AND '''+ CONVERT(NVARCHAR(10),@ToDate,101)+''''
END

SET @sSQL = '
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME=''OT0172_TEMP'' AND xtype=''U'')
	DROP TABLE OT0172_TEMP


SELECT A90.OrderID, A90.InvoiceNo, A90.InvoiceDate, MAX(A90.Parameter01) AS Parameter01, A32.InventoryTypeID,
				SUM(ISNULL(A90.OriginalAmount,0) + (CASE WHEN A90.VATGroupID <> ''TS0'' THEN ISNULL(A90.OriginalAmount,0) * CONVERT(decimal(28,8),RIGHT(A90.VATGroupID,2))/100 ELSE 0 END)) AS OriginalAmount, 
				SUM(ISNULL(A90.ConvertedAmount,0) + (CASE WHEN A90.VATGroupID <> ''TS0'' THEN ISNULL(A90.ConvertedAmount,0) * CONVERT(decimal(28,8),RIGHT(A90.VATGroupID,2))/100 ELSE 0 END)) AS ConvertedAmount,
				SUM(ISNULL(A90.DiscountSaleAmountDetail,0)) AS DiscountSaleAmountDetail
INTO #Temp           
FROM AT9000 A90 WITH (NOLOCK) 
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID in (''@@@'',A90.DivisionID) AND A90.InventoryID = A32.InventoryID
WHERE A90.DivisionID = '''+@DivisionID+''' AND A90.TransactionTypeID IN (''T04'') 
GROUP BY A90.OrderID, A90.InvoiceNo, A90.InvoiceDate, A32.InventoryTypeID

SELECT ROW_NUMBER() OVER(ORDER BY A90.InvoiceDate, A90.InvoiceNo) AS Orders, A.*,
	A90.OrderID, A90.InvoiceNo, A90.InvoiceDate, A90.Parameter01, 
				A90.OriginalAmount, 
				A90.ConvertedAmount,
				A90.DiscountSaleAmountDetail
INTO OT0172_TEMP
FROM 
	(
	SELECT O01.OrderDate, O01.ObjectID, A02.ObjectName, A02.Note, O02.SOrderID, I08ID, O01.ShipAmount, O01.Varchar01, O01.Varchar02, A32.InventoryTypeID,
	SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0) - ISNULL(O02.DiscountSaleAmountDetail,0) + ISNULL(O02.VATConvertedAmount,0)) AS SOConvertedAmount,
	SUM(ISNULL(DiscountSaleAmountDetail,0)) AS SODiscountSaleAmountDetail
	FROM OT2002 O02 WITH (NOLOCK)
	LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID in (''@@@'',O01.DivisionID) AND A02.ObjectID = O01.ObjectID
	LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID in (''@@@'',O02.DivisionID) AND A32.InventoryID = O02.InventoryID
	WHERE O01.DivisionID = '''+@DivisionID+''' AND O01.OrderType = 0
		AND A02.O01ID BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		AND O01.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		AND O01.Ana03ID BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		AND O01.Ana05ID BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
		--O02.SOrderID =  ''SO1/06/2017/770'' --''SO3/05/2017/073''
		' + @sWhere + '
	GROUP BY O01.OrderDate, O01.ObjectID, A02.ObjectName, A02.Note, O02.SOrderID, I08ID, O01.ShipAmount, O01.Varchar01, O01.Varchar02, A32.InventoryTypeID
	) A
LEFT JOIN 
	(SELECT A90.OrderID, CONVERT(NVARCHAR(4000),'''') AS InvoiceNo, A90.InvoiceDate, MAX(A90.Parameter01) AS Parameter01, A90.InventoryTypeID,
				SUM(ISNULL(A90.OriginalAmount,0) ) AS OriginalAmount, 
				SUM(ISNULL(A90.ConvertedAmount,0) ) AS ConvertedAmount,
				SUM(ISNULL(A90.DiscountSaleAmountDetail,0)) AS DiscountSaleAmountDetail
           FROM #Temp A90
           GROUP BY A90.OrderID, A90.InvoiceDate, A90.InventoryTypeID
	) A90 ON A90.OrderID = A.SOrderID AND A.InventoryTypeID = A90.InventoryTypeID
ORDER BY A90.InvoiceDate, A90.InvoiceNo
'

SET @sSQL1 = '
UPDATE OT0172_TEMP
SET InvoiceNo = 
STUFF((SELECT DISTINCT '', '' + InvoiceNo FROM (SELECT * 
FROM ( SELECT DISTINCT InvoiceNo FROM #Temp T
       WHERE T.OrderID = O.SOrderID AND T.InvoiceDate = O.InvoiceDate ) A ) A FOR XML PATH ('''')), 1, 1, ''''
)
FROM OT0172_TEMP O
'

PRINT @sSQL
PRINT @sSQL1
EXEC (@sSQL + @sSQL1)

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT0172_TEMP2' AND xtype='U')
	DROP TABLE OT0172_TEMP2

---- Lấy danh sách mặt hàng kế thừa và mặt hàng còn lại
SELECT  ROW_NUMBER() OVER(ORDER BY A.OrderID, A.InvoiceDate, A.InventoryID) AS Orders, ISNULL(A.OrderID,B.SOrderID) AS OrderID, 
		A.InvoiceDate, 
		ISNULL(A.InventoryID,B.InventoryID) AS InventoryID, 
		ISNULL(A.InheritQuantity,0) AS InheritQuantity, ISNULL(A.InheritProQuantity,0) AS InheritProQuantity, B.Quantity, B.ProQuantity, 
		0 AS QuantityOwed, 0 AS ProQuantityOwed  
INTO #TEST
FROM
(SELECT O02.SOrderID, O02.InventoryID, SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN O02.OrderQuantity ELSE 0 END) AS Quantity,
			SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN O02.OrderQuantity ELSE 0 END) AS ProQuantity
	FROM OT2002 O02 WITH (NOLOCK)
	LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
	WHERE O01.SOrderID IN (SELECT SOrderID FROM OT0172_TEMP) 
	GROUP BY O02.SOrderID, O02.InventoryID
	) B
LEFT JOIN (SELECT A90.OrderID, A90.InvoiceDate, A90.InventoryID, SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(Quantity,0) ELSE 0 END) AS InheritQuantity,
			SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN Quantity ELSE 0 END) AS InheritProQuantity
	FROM AT9000 A90 WITH (NOLOCK) 
	WHERE A90.DivisionID = @DivisionID AND A90.TransactionTypeID IN ('T04') AND A90.OrderID IN (SELECT SOrderID FROM OT0172_TEMP)
	GROUP BY A90.OrderID, A90.InventoryID, A90.InvoiceDate	
	
) A ON B.InventoryID = A.InventoryID AND A.OrderID = B.SOrderID
ORDER BY A.OrderID, A.InvoiceDate, A.InventoryID

---- Update cho những dòng chưa được kế thừa
--UPDATE #TEST
--SET InvoiceDate = A.InvoiceDate
--FROM #TEST T
--LEFT JOIN (SELECT OrderID, MIN(InvoiceDate) AS InvoiceDate FROM #TEST 
--           WHERE ISNULL(InvoiceDate,'') <> '' 
--           GROUP BY OrderID) A ON A.OrderID = T.OrderID
--WHERE ISNULL(T.InvoiceDate,'') = '' AND InheritQuantity = 0 AND InheritProQuantity = 0 

---- Lấy số lượng hàng đã kế thừa và hàng nợ theo lũy kế
SELECT Orders, OrderID, InvoiceDate, InventoryID, InheritQuantity, InheritProQuantity, Quantity, ProQuantity, 
		ISNULL(QuantityOwed,0) AS QuantityOwed, ISNULL(ProQuantityOwed,0) AS ProQuantityOwed
INTO OT0172_TEMP2
FROM #TEST
UNION
SELECT DISTINCT 0 AS Orders, B.OrderID, A.InvoiceDate, B.InventoryID,
		0 AS InheritQuantity, 0 AS InheritProQuantity, B.Quantity, B.ProQuantity, 0 AS QuantityOwed, 0 AS ProQuantityOwed
FROM #TEST B
LEFT JOIN  #TEST A ON A.OrderID = B.OrderID AND A.InvoiceDate < B.InvoiceDate AND A.InventoryID <> B.InventoryID
WHERE  ISNULL(B.OrderID,'') <> ''
AND NOT EXISTS (SELECT TOP 1 1 FROM #TEST A WHERE A.OrderID = B.OrderID AND A.InvoiceDate < B.InvoiceDate AND A.InventoryID = B.InventoryID)
AND A.InvoiceDate IS NOT NULL

---- Update vào table chính những mặt hàng với số lượng còn nợ
UPDATE OT0172_TEMP2
SET QuantityOwed = ISNULL(T.Quantity,0) - ISNULL((SELECT SUM(InheritQuantity) FROM OT0172_TEMP2 
								WHERE OT0172_TEMP2.Orders <= T.Orders AND OT0172_TEMP2.OrderID = T.OrderID AND OT0172_TEMP2.InventoryID = T.InventoryID ),0),
	ProQuantityOwed = ISNULL(T.ProQuantity,0) - ISNULL((SELECT SUM(InheritProQuantity) FROM OT0172_TEMP2 
									 WHERE OT0172_TEMP2.Orders <= T.Orders AND OT0172_TEMP2.OrderID = T.OrderID AND OT0172_TEMP2.InventoryID = T.InventoryID),0)
FROM OT0172_TEMP2 AS T

---- Lấy ra dữ liệu cho báo cáo
SELECT ObjectID, ObjectName, Note, T.SOrderID, T.OrderDate, I08ID, A15.AnaName AS I08Name, ShipAmount, Varchar01, Varchar02,
	InvoiceNo, T.InvoiceDate,	T.InvoiceDate AS VoucherDate, Parameter01, InventoryTypeID, 
	SOConvertedAmount, SODiscountSaleAmountDetail, OriginalAmount,	ConvertedAmount, DiscountSaleAmountDetail,
	SOConvertedAmount - (SELECT SUM(OriginalAmount) FROM OT0172_TEMP T1 WHERE T1.Orders <= T.Orders AND T1.SOrderID = T.SOrderID AND T.InventoryTypeID = T1.InventoryTypeID) AS ReOriginalAmount,
	SOConvertedAmount - (SELECT SUM(ConvertedAmount) FROM OT0172_TEMP T1 WHERE T1.Orders <= T.Orders AND T1.SOrderID = T.SOrderID AND T.InventoryTypeID = T1.InventoryTypeID) AS ReConvertedAmount,
	(SELECT DISTINCT SUM(ISNULL(SODiscountSaleAmountDetail,0)) FROM OT0172_TEMP T1 WHERE T1.SOrderID = T.SOrderID) 
				- (SELECT SUM(ISNULL(DiscountSaleAmountDetail,0)) FROM OT0172_TEMP T1 WHERE T1.SOrderID = T.SOrderID) AS ReDiscountSaleAmountDetail,
	ISNULL(S.InventoryOwed,'') AS InventoryOwed
FROM OT0172_TEMP T 
LEFT JOIN (SELECT DISTINCT T.OrderID, T.InvoiceDate, ISNULL(A.InventoryOwed,'') AS InventoryOwed
			FROM OT0172_TEMP2 T
			LEFT JOIN (
			SELECT DISTINCT OrderID, InvoiceDate,
				SUBSTRING(
					(
						SELECT CHAR(10) +C1.InventoryID + ': ' + CONVERT(NVARCHAR(50),CONVERT(FLOAT,C1.QuantityOwed)) + '; ' + CONVERT(NVARCHAR(50),CONVERT(FLOAT,C1.ProQuantityOwed))
						FROM dbo.OT0172_TEMP2 C1
						WHERE C1.OrderID = C2.OrderID AND ISNULL(C1.InvoiceDate,C2.InvoiceDate) = C2.InvoiceDate
							AND (C1.QuantityOwed <> 0 OR C1.ProQuantityOwed <> 0)
						ORDER BY C1.Orders, C1.OrderID
						FOR XML PATH ('')
					), 2, 4000) InventoryOwed
			FROM dbo.OT0172_TEMP2 C2 ) A ON A.OrderID = T.OrderID AND A.InvoiceDate IS NOT NULL AND A.InvoiceDate = T.InvoiceDate 
	) S ON T.SOrderID = S.OrderID AND S.InvoiceDate = T.InvoiceDate
LEFT JOIN AT1015 A15 WITH (NOLOCK) ON T.I08ID = A15.AnaID AND A15.AnaTypeID = 'I08'
ORDER BY T.OrderDate, T.SOrderID, T.InvoiceDate, InvoiceNo 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
