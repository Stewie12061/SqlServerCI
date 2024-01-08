IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CUSP0124]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CUSP0124]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo doanh thu - chi phí BourBon
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/12/2014 by Thanh Sơn
---- Update on 19/06/2023 by Xuân Nuyên: [2023/06/IS/0171]Bổ sung điều kiện DivisionID dùng chung
-- <Example>
/*
 EXEC CUSP0124 'BBL', 'ASOFTADMIN', 201502, 201502, '2015-03-01 00:00:00.000', '2015-03-31 00:00:00.000', 1, 'A TOA','TSSL0.0561'
*/ 


CREATE PROCEDURE CUSP0124
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@FromPeriod AS INT,
	@ToPeriod AS INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@TimeMode TINYINT,
	@FromObjectID VARCHAR(50),
	@ToObjectID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX),
	@sWhere NVARCHAR(1000) = '',
	@sWhere1 NVARCHAR(1000) = ''
IF @TimeMode = 0 
	BEGIN
		SET @sWhere = '
		AND O1.TranMonth + O1.TranYear * 100 BETWEEN '+CONVERT(NVARCHAR(10), @FromPeriod)+' AND '+CONVERT(NVARCHAR(10), @ToPeriod)+' '
		SET @sWhere1 = @sWhere
	END
ELSE
	BEGIN
		SET @sWhere = '
		AND CONVERT(VARCHAR, O2.ReceiveDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+''' ' 
		SET @sWhere1 = '
		AND CONVERT(VARCHAR, O1.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+''' ' 
	END 
	
SET @sSQL = N'
SELECT ObjectID, ObjectName, Ana08ID InventoryTypeID, AnaName InventoryTypeName, SUM(OrderQuantity) OrderQuantity,
	SUM(DTAmount) DTAmount, SUM(FeeAmount) FeeAmount
FROM
(
	SELECT A.POrderID, A.ReceiveDate, A.ObjectID, A.ObjectName, B.ObjectID BObjectID, B.ObjectName BObjectName, B.POrderID BPOrderID, A.Ana08ID, A.AnaName,
		A.Ana04ID, A.Ana04Name, A.Ana10ID, A.Ana10Name, A.InventoryID, A.InventoryName, A.Ana01ID, A.Ana01Name, B.Ana03ID, B.Ana03Name, A.SOrderID, A.Notes01,
		(CASE WHEN ISNULL(A.Notes01,'''') = '''' THEN ISNULL(A.OrderQuantity, 0) ELSE 0 END) OrderQuantity, ISNULL(A.PurchasePrice, 0) PurchasePrice,
		CASE WHEN ISNULL(A.Notes01,'''') <> '''' AND ISNULL(B.Ana03ID, '''') <> '''' THEN ISNULL(A.OrderQuantity, 0) ELSE 0 END BOrderQuantity, ISNULL(B.PurchasePrice, 0) BPurchasePrice,
		(CASE WHEN ISNULL(A.Notes01,'''') = '''' THEN ISNULL(A.OrderQuantity, 0) ELSE 0 END) * ISNULL(A.PurchasePrice, 0) DTAmount,
		(CASE WHEN ISNULL(A.Notes01,'''') <> '''' AND ISNULL(B.Ana03ID, '''') <> '''' THEN ISNULL(A.OrderQuantity, 0) ELSE 0 END) * ISNULL(B.PurchasePrice, 0) FeeAmount
	FROM
	( 
		-- Xac nhan hoan thanh
		SELECT O1.ObjectID, O2.ReceiveDate, A02.ObjectName, O2.Ana08ID, A08.AnaName, O2.PurchasePrice,
		O1.POrderID, O1.SOrderID, O2.Notes01, O2.InventoryID, A32.InventoryName, O2.Notes04, O2.OrderQuantity,
		O2.Ana04ID, A04.AnaName Ana04Name, O2.Ana10ID, A10.AnaName Ana10Name, O2.Ana01ID, A01.AnaName Ana01Name, OriginalAmount
		FROM OT3001 O1
		LEFT JOIN OT3002 O2 ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
		LEFT JOIN AT1011 A08 ON A08.DivisionID IN (O2.DivisionID,''@@@'') AND A08.AnaID = O2.Ana08ID AND A08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 A01 ON A01.DivisionID IN (O2.DivisionID,''@@@'') AND A01.AnaID = O2.Ana01ID AND A01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 A04 ON A04.DivisionID IN (O2.DivisionID,''@@@'') AND A04.AnaID = O2.Ana04ID AND A04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 A10 ON A10.DivisionID IN (O2.DivisionID,''@@@'') AND A10.AnaID = O2.Ana10ID AND A10.AnaTypeID = ''A10''
		LEFT JOIN AT1302 A32 ON A32.DivisionID IN (O2.DivisionID,''@@@'') AND A32.InventoryID = O2.InventoryID
		LEFT JOIN AT1202 A02 ON A02.DivisionID IN (O1.DivisionID,''@@@'') AND A02.ObjectID = O1.ObjectID
		WHERE O1.DivisionID =  '''+@DivisionID+'''
		AND O1.KindVoucherID = 2
		AND O1.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		AND O2.ReceiveDate IS NOT NULL '+@sWhere+'
		
		UNION ALL'
SET @sSQL1 = '
		SELECT O1.ObjectID, O1.VoucherDate ReceiveDate, A02.ObjectName, O2.Ana08ID, A08.AnaName, O2.ConvertedPrice PurchasePrice,
			'''' POrderID, O1.VoucherNo SOrderID, O2.Notes01, O2.InventoryID, A32.InventoryName, O2.Notes04, O2.OriginalQuantity OrderQuantity,
			O2.Ana04ID, A04.AnaName Ana04Name, O2.Ana10ID, A10.AnaName Ana10Name, O2.Ana01ID, A01.AnaName Ana01Name, O2.OriginalAmount
		FROM OT2010 O1
		LEFT JOIN OT2011 O2 ON O2.DivisionID = O1.DivisionID AND O2.SOrderID = O1.SOrderID
		LEFT JOIN AT1011 A08 ON A08.DivisionID IN (O2.DivisionID,''@@@'') AND A08.AnaID = O2.Ana08ID AND A08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 A01 ON A01.DivisionID IN (O2.DivisionID,''@@@'') AND A01.AnaID = O2.Ana01ID AND A01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 A04 ON A04.DivisionID IN (O2.DivisionID,''@@@'') AND A04.AnaID = O2.Ana04ID AND A04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 A10 ON A10.DivisionID IN (O2.DivisionID,''@@@'') AND A10.AnaID = O2.Ana10ID AND A10.AnaTypeID = ''A10''
		LEFT JOIN AT1302 A32 ON A32.DivisionID IN (O2.DivisionID,''@@@'') AND A32.InventoryID = O2.InventoryID
		LEFT JOIN AT1202 A02 ON A02.DivisionID IN (O1.DivisionID,''@@@'') AND A02.ObjectID = O1.ObjectID
		WHERE O1.DivisionID =  '''+@DivisionID+'''
		AND O1.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		AND O1.VoucherDate IS NOT NULL '+@sWhere1+'
		
	)A
	LEFT JOIN
	( 
		-- Lenh dieu dong
		SELECT O1.DivisionID, O1.POrderID, O2.Notes04, O2.InventoryID,
		O2.Notes03, O2.PurchasePrice, O1.ObjectID, O1.ObjectName, O2.Ana04ID, O2.Ana10ID, O2.Ana03ID, A03.AnaName Ana03Name
		FROM OT3001 O1
		LEFT JOIN OT3002 O2 ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
		LEFT JOIN AT1011 A03 ON A03.DivisionID = O2.DivisionID AND A03.AnaID = O2.Ana03ID AND A03.AnaTypeID = ''A03''
		WHERE O1.DivisionID =  '''+@DivisionID+'''
		AND O1.KindVoucherID = 1
	)B ON B.Notes03 = A.SOrderID AND B.POrderID = A.Notes01 AND B.Notes04 = A.InventoryID AND B.InventoryID = A.Notes04	
	AND A.Ana04ID = B.Ana04ID AND A.Ana10ID = B.Ana10ID
)C
GROUP BY ObjectID, ObjectName, Ana08ID, AnaName
ORDER BY ObjectID'

EXEC (@sSQL + @sSQL1)
PRINT @sSQL
print @sSQL1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
