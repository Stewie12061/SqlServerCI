IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0412]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0412]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Create by Tiểu Mai on 24/02/2017
--- Purpose: Load danh sách chi tiết chi phí giống báo cáo đặc thù OP cho BourBon (CustomizeIndex = 38)
--- Modified by Tiểu Mai on 26/05/2017: Chỉnh sửa danh mục dùng chung
--- Modified on 01/10/2020 by Đức Thông: Bổ sung điều kiện where DivisionID IN bảng AT1302
--- Modified on 12/10/2020 by Nhựt Trường:(Sửa danh mục dùng chung) Bổ sung DivisionID IN cho AT1302.
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * EXEC HP0412 'BBL', 'ASOFTADMIN', '2016-12-01', '2017-02-23', 'A TOA', 'TSSL0.0718', ''
 * EXEC HP0412 'BBL', 'ASOFTADMIN', '2016-12-01', '2017-02-23', 'A TOA', 'TSSL0.0718', 'CC.001'
 * 
 */

CREATE PROCEDURE HP0412
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@FromObjectID VARCHAR(50),
		@ToObjectID VARCHAR(50),
		@TrackingID NVARCHAR(50) = ''
		
) 
AS 

DECLARE @sSQL NVARCHAR(MAX)='', @sSQL1 NVARCHAR(MAX) = '', @sWhere NVARCHAR(1000) = '', @InheritTransactionID NVARCHAR(50)

SET @sWhere = '
	AND CONVERT(VARCHAR, O2.ReceiveDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+''' ' 

SELECT @InheritTransactionID = InheritPTransactionID FROM HT0410 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TrackingID = @TrackingID

SELECT DivisionID, InheritPTransactionID 
INTO #TEMP
FROM HT0410 WITH (NOLOCK)
WHERE DivisionID = @DivisionID

IF ISNULL(@InheritTransactionID,'') = ''
BEGIN 
	SET @sSQL = N'
		SELECT 0 as IsCheck, B.DivisionID, A.POrderID, A.SOrderID, A.TransactionID as InheritTransactionID, A.ObjectID AObjectID, A01.ObjectName AObjectName, A01.TradeName ATradeName,
		A.Notes01, A.InventoryID AInventoryID, A32.InventoryName AInventoryName,  A.Transport,
		B.Notes04 BInventoryID, A30.InventoryName BInventoryName,
		A.Notes04 InventoryID, A33.InventoryName, A.ReceiveDate, A.OrderDate as SOrderDate, A.ShipDate,
		A.Ana04ID, Ana04.AnaName Ana04Name, A.Ana07ID, Ana07.AnaName Ana07Name, B.ObjectID, A22.ObjectName, A22.TradeName BTradeName,
		ISNULL(A.OrderQuantity, 0) OrderQuantity, 
		ISNULL(B.PurchasePrice, 0) PurchasePrice,
		ISNULL(A.OrderQuantity, 0) * ISNULL(B.PurchasePrice, 0) TotalAmount
		FROM
		( -- Xác nhận hoàn thành
			SELECT O1.DivisionID, O1.POrderID, O1.SOrderID, O2.TransactionID, O1.ObjectID, O2.Notes01, O2.InventoryID, 
			O2.Notes04, O2.ReceiveDate, O2.OrderQuantity, o2.Ana04ID, o2.Ana07ID, o2.Ana10ID, O1.Transport, O21.OrderDate, O21.ShipDate
			FROM OT3001 O1  WITH (NOLOCK)
			LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
			LEFT JOIN OT2001 O21 WITH (NOLOCK) ON O21.DivisionID = O1.DivisionID AND O21.SOrderID = O1.SOrderID
			WHERE O1.DivisionID = '''+@DivisionID+'''
			AND O1.KindVoucherID = 2
			AND O2.ReceiveDate IS NOT NULL
			AND ISNULL(O2.Notes01,'''') <> '''' AND ISNULL(O2.Ana03ID,'''') <> '''' '+@sWhere+'
		)A
		LEFT JOIN
		( -- Lệnh điều động
			SELECT O1.DivisionID, O1.SOrderID, O1.ObjectID, O1.VoucherNo, O1.POrderID, O2.Notes04, O2.InventoryID,
			O2.Notes03, O2.PurchasePrice, o2.Ana04ID, o2.Ana10ID
			FROM OT3001 O1 WITH (NOLOCK)
			LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
			WHERE O1.DivisionID = '''+@DivisionID+'''
			AND O1.KindVoucherID = 1
		)B ON B.Notes03 = A.SOrderID AND B.POrderID = A.Notes01 AND B.Notes04 = A.InventoryID 
		AND B.InventoryID = A.Notes04 AND A.Ana04ID = B.Ana04ID AND A.Ana10ID = B.Ana10ID
		LEFT JOIN AT1202 A01 WITH (NOLOCK)	ON A01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A01.ObjectID = A.ObjectID
		LEFT JOIN AT1202 A02 WITH (NOLOCK)	ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = B.ObjectID
		LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON A.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON A.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = ''A07''
		LEFT JOIN AT1302 A32 WITH (NOLOCK)	ON A32.InventoryID= A.InventoryID AND A32.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1302 A30 WITH (NOLOCK)	ON A30.InventoryID= B.Notes04 AND A30.DivisionID IN (B.DivisionID,''@@@'')
		LEFT JOIN AT1302 A33 WITH (NOLOCK)	ON A33.InventoryID= A.Notes04 AND A33.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1202 A22 WITH (NOLOCK)	ON A22.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A22.ObjectID = B.ObjectID
		LEFT JOIN #TEMP t1 ON t1.DivisionID = A.DivisionID AND t1.InheritPTransactionID = A.TransactionID
		WHERE B.ObjectID BETWEEN ISNULL('''+@FromObjectID+''', '''') AND ISNULL('''+@ToObjectID+''', '''')
			AND ISNULL(t1.InheritPTransactionID,'''') = ''''
		ORDER BY B.ObjectID, A.ReceiveDate'
END 
ELSE
BEGIN
	SET @sSQL = N'
		SELECT 1 as IsCheck, B.DivisionID, A.POrderID, A.SOrderID, A.TransactionID as InheritTransactionID, A.ObjectID AObjectID, A01.ObjectName AObjectName, A01.TradeName ATradeName,
		A.Notes01, A.InventoryID AInventoryID, A32.InventoryName AInventoryName,  A.Transport,
		B.Notes04 BInventoryID, A30.InventoryName BInventoryName,
		A.Notes04 InventoryID, A33.InventoryName, A.ReceiveDate, A.OrderDate as SOrderDate, A.ShipDate, 
		A.Ana04ID, Ana04.AnaName Ana04Name, A.Ana07ID, Ana07.AnaName Ana07Name, B.ObjectID, A22.ObjectName, A22.TradeName BTradeName,
		ISNULL(A.OrderQuantity, 0) OrderQuantity, 
		ISNULL(B.PurchasePrice, 0) PurchasePrice,
		ISNULL(A.OrderQuantity, 0) * ISNULL(B.PurchasePrice, 0) TotalAmount
		FROM
		( -- Xác nhận hoàn thành
			SELECT O1.DivisionID, O1.POrderID, O1.SOrderID, O2.TransactionID, O1.ObjectID, O2.Notes01, O2.InventoryID, 
			O2.Notes04, O2.ReceiveDate, O2.OrderQuantity, o2.Ana04ID, o2.Ana07ID, o2.Ana10ID, O1.Transport, O21.OrderDate, O21.ShipDate
			FROM OT3001 O1 WITH (NOLOCK)
			LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
			LEFT JOIN OT2001 O21 WITH (NOLOCK) ON O21.DivisionID = O1.DivisionID AND O21.SOrderID = O1.SOrderID
			WHERE O1.DivisionID = '''+@DivisionID+'''
			AND O1.KindVoucherID = 2
			AND O2.ReceiveDate IS NOT NULL
			AND ISNULL(O2.Notes01,'''') <> '''' AND ISNULL(O2.Ana03ID,'''') <> '''' 
			
		)A
		LEFT JOIN
		( -- Lệnh điều động
			SELECT O1.DivisionID, O1.SOrderID, O1.ObjectID, O1.VoucherNo, O1.POrderID, O2.Notes04, O2.InventoryID,
			O2.Notes03, O2.PurchasePrice, o2.Ana04ID, o2.Ana10ID
			FROM OT3001 O1 WITH (NOLOCK)
			LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
			WHERE O1.DivisionID = '''+@DivisionID+'''
			AND O1.KindVoucherID = 1
		)B ON B.Notes03 = A.SOrderID AND B.POrderID = A.Notes01 AND B.Notes04 = A.InventoryID 
		AND B.InventoryID = A.Notes04 AND A.Ana04ID = B.Ana04ID AND A.Ana10ID = B.Ana10ID
		LEFT JOIN AT1202 A01 WITH (NOLOCK)	ON A01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A01.ObjectID = A.ObjectID
		LEFT JOIN AT1202 A02 WITH (NOLOCK)	ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = B.ObjectID
		LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON A.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON A.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = ''A07''
		LEFT JOIN AT1302 A32 WITH (NOLOCK)	ON A32.InventoryID= A.InventoryID AND A32.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1302 A30 WITH (NOLOCK)	ON A30.InventoryID= B.Notes04 AND A30.DivisionID IN (B.DivisionID,''@@@'')
		LEFT JOIN AT1302 A33 WITH (NOLOCK)	ON A33.InventoryID= A.Notes04 AND A33.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1202 A22 WITH (NOLOCK)	ON A22.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A22.ObjectID = B.ObjectID
		WHERE --B.ObjectID BETWEEN ISNULL('''+@FromObjectID+''', '''') AND ISNULL('''+@ToObjectID+''', '''')
			--AND 
			A.TransactionID = '''+@InheritTransactionID+'''
			'
	
	SET @sSQL1 = N'
		UNION
		SELECT 0 as IsCheck, B.DivisionID, A.POrderID, A.SOrderID, A.TransactionID as InheritTransactionID, A.ObjectID AObjectID, A01.ObjectName AObjectName, A01.TradeName ATradeName,
		A.Notes01, A.InventoryID AInventoryID, A32.InventoryName AInventoryName,  A.Transport,
		B.Notes04 BInventoryID, A30.InventoryName BInventoryName,
		A.Notes04 InventoryID, A33.InventoryName, A.ReceiveDate, A.OrderDate as SOrderDate, A.ShipDate, 
		A.Ana04ID, Ana04.AnaName Ana04Name, A.Ana07ID, Ana07.AnaName Ana07Name, B.ObjectID, A22.ObjectName, A22.TradeName BTradeName,
		ISNULL(A.OrderQuantity, 0) OrderQuantity, 
		ISNULL(B.PurchasePrice, 0) PurchasePrice,
		ISNULL(A.OrderQuantity, 0) * ISNULL(B.PurchasePrice, 0) TotalAmount
		FROM
		( -- Xác nhận hoàn thành
			SELECT O1.DivisionID, O1.POrderID, O1.SOrderID, O2.TransactionID, O1.ObjectID, O2.Notes01, O2.InventoryID, 
			O2.Notes04, O2.ReceiveDate, O2.OrderQuantity, o2.Ana04ID, o2.Ana07ID, o2.Ana10ID, O1.Transport, O21.OrderDate, O21.ShipDate
			FROM OT3001 O1 WITH (NOLOCK)
			LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
			LEFT JOIN OT2001 O21 WITH (NOLOCK) ON O21.DivisionID = O1.DivisionID AND O21.SOrderID = O1.SOrderID
			WHERE O1.DivisionID = '''+@DivisionID+'''
			AND O1.KindVoucherID = 2
			AND O2.ReceiveDate IS NOT NULL
			AND ISNULL(O2.Notes01,'''') <> '''' AND ISNULL(O2.Ana03ID,'''') <> '''' '+@sWhere+'
		)A
		LEFT JOIN
		( -- Lệnh điều động
			SELECT O1.DivisionID, O1.SOrderID, O1.ObjectID, O1.VoucherNo, O1.POrderID, O2.Notes04, O2.InventoryID,
			O2.Notes03, O2.PurchasePrice, o2.Ana04ID, o2.Ana10ID
			FROM OT3001 O1 WITH (NOLOCK)
			LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
			WHERE O1.DivisionID = '''+@DivisionID+'''
			AND O1.KindVoucherID = 1
		)B ON B.Notes03 = A.SOrderID AND B.POrderID = A.Notes01 AND B.Notes04 = A.InventoryID 
		AND B.InventoryID = A.Notes04 AND A.Ana04ID = B.Ana04ID AND A.Ana10ID = B.Ana10ID
		LEFT JOIN AT1202 A01 WITH (NOLOCK)	ON A01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A01.ObjectID = A.ObjectID
		LEFT JOIN AT1202 A02 WITH (NOLOCK)	ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = B.ObjectID
		LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON A.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON A.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = ''A07''
		LEFT JOIN AT1302 A32 WITH (NOLOCK)	ON A32.InventoryID= A.InventoryID AND A32.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1302 A30 WITH (NOLOCK)	ON A30.InventoryID= B.Notes04 AND A30.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1302 A33 WITH (NOLOCK)	ON A33.InventoryID= A.Notes04 AND A33.DivisionID IN (A.DivisionID,''@@@'')
		LEFT JOIN AT1202 A22 WITH (NOLOCK)	ON A22.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A22.ObjectID = B.ObjectID
		LEFT JOIN #TEMP t1 ON t1.DivisionID = A.DivisionID AND t1.InheritPTransactionID = A.TransactionID
		WHERE B.ObjectID BETWEEN ISNULL('''+@FromObjectID+''', '''') AND ISNULL('''+@ToObjectID+''', '''')
			AND ISNULL(t1.InheritPTransactionID,'''') = ''''
		ORDER BY B.ObjectID, A.ReceiveDate'		
END
--PRINT (@sSQL)
--PRINT (@sSQL1)
EXEC (@sSQL + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
