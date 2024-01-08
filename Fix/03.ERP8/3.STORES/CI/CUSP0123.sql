IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CUSP0123]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CUSP0123]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo tổng hợp doanh thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/12/2014 by Thanh Sơn
---- Modified by Xuân Nguyên on 10/04/2023 : Bổ sung điều kiện Division dùng chung khi join bảng AT1011
-- <Example>
---- EXEC CUSP0123 'BBL', 'ASOFTADMIN','2014-11-01 00:00:00.000', '2014-11-30 00:00:00.000', 'E04','E04', 'KH014.0081', 'KH014.0081'


CREATE PROCEDURE CUSP0123
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,	
	@FromAna01ID VARCHAR(50),
	@ToAna01ID VARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX), @sWhere NVARCHAR(1000) = ''

SET @sSQL = '
SELECT ReceiveDate, Ana01ID, A11.AnaName, SUM(OrderQuantity) OrderQuantity, SUM(TotalAmount) TotalAmount
FROM
(
	SELECT
		A.DivisionID, A.POrderID OrderID, A.ReceiveDate, A.Ana01ID, A.InventoryID,
		0 OriginalQuantity, ISNULL(A.OrderQuantity, 0) OrderQuantity,
		0 SalePrice, ISNULL(A.PurchasePrice, 0) PurchasePrice, A.TotalAmount, 
		ISNULL(A.OrderQuantity, 0) * ISNULL(A.PurchasePrice, 0) TotalOriginalAmount
	FROM
	(
		SELECT O1.DivisionID, O2.POrderID, O2.ReceiveDate, O2.Ana01ID, O2.OrderQuantity, 
		O2.InventoryID, O2.Ana04ID, O2.Ana10ID, O1.SOrderID,
		PurchasePrice, O2.OrderQuantity * PurchasePrice TotalAmount
		FROM OT3001 O1
		LEFT JOIN OT3002 O2 ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID	
		WHERE O2.DivisionID = '''+@DivisionID+'''
		AND ISNULL(O1.KindVoucherID, 0) = 2
		AND ISNULL(O2.Notes01, '''') = ''''
		AND O2.ReceiveDate IS NOT NULL
		AND CONVERT(VARCHAR, O2.ReceiveDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+'''
		AND ISNULL(O2.Ana01ID,'''') <> ''''
		AND ISNULL(O2.Ana01ID,'''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''
		AND ISNULL(O1.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	) A
	
	UNION ALL
	
	SELECT O1.DivisionID, O1.VoucherNo OrderID, O1.VoucherDate ReceiveDate, O2.Ana01ID, O2.InventoryID, OriginalQuantity, 
		OriginalQuantity OrderQuantity, O2.ConvertedPrice SalePrice, 0 PurchasePrice, OriginalAmount TotalAmount, OriginalAmount TotalOriginalAmount
	FROM OT2010 O1
	LEFT JOIN OT2011 O2 ON O2.DivisionID = O1.DivisionID AND O2.SOrderID = O1.SOrderID
	WHERE O1.DivisionID = '''+@DivisionID+'''
	AND CONVERT(VARCHAR, O1.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+'''
	AND ISNULL(O2.Ana01ID,'''') <> ''''
	AND ISNULL(O2.Ana01ID,'''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''
	AND ISNULL(O1.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
)A
LEFT JOIN AT1011 A11 ON A11.DivisionID IN (A.DivisionID,''@@@'') AND A11.AnaID = A.Ana01ID
GROUP BY ReceiveDate, Ana01ID, AnaName
ORDER BY ReceiveDate, Ana01ID
'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
