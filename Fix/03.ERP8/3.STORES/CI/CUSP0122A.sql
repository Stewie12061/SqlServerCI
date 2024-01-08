IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CUSP0122A]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CUSP0122A]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo chi phí BourBon - Bảng kê chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 10/02/2015 by Trí Thiện
---- Modified on 10/04/2023 by Đình Định : BOURBON - Hiển thị tên Khách hàng khi in Bảng kê chi tiết chi phí.
---- Modified on ....		by
-- <Example>
---- EXEC CUSP0122A 'BBL', 'ASOFTADMIN', 201501, 201501, '2013-12-01 00:00:00.000', '2013-12-31 00:00:00.000', 0, 'A TOA','TSSL0.0521'


CREATE PROCEDURE CUSP0122A
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
DECLARE @sSQL NVARCHAR(MAX), @sWhere NVARCHAR(1000) = ''
IF @TimeMode = 0 
	SET @sWhere = '
AND O1.TranMonth + O1.TranYear * 100 BETWEEN '+ CONVERT(NVARCHAR(10), @FromPeriod) +' AND '+ CONVERT(NVARCHAR(10), @ToPeriod) +' '
ELSE 
	SET @sWhere = '
AND CONVERT(VARCHAR, O2.ReceiveDate, 112) BETWEEN '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND '''+CONVERT(VARCHAR, @ToDate, 112)+''' ' 


SET @sSQL = N'
	SELECT B.DivisionID, A.POrderID, A.SOrderID, A.ObjectID AS AObjectID, A01.ObjectName AS AObjectName, A01.TradeName AS ATradeName,
		   A.Notes01, A.InventoryID AS AInventoryID, A32.InventoryName AS AInventoryName, A.Transport,
		   B.Notes04 BInventoryID, A30.InventoryName AS BInventoryName,
		   A.Notes04 InventoryID, A33.InventoryName, A.ReceiveDate, 
		   A.Ana04ID, Ana04.AnaName AS Ana04Name, B.ObjectID, A22.ObjectName, A22.TradeName AS BTradeName,
		   ISNULL(A.OrderQuantity, 0) OrderQuantity, 
		   ISNULL(B.PurchasePrice, 0) PurchasePrice,
		   ISNULL(A.OrderQuantity, 0) * ISNULL(B.PurchasePrice, 0) TotalAmount
	 FROM ( -- Xác nhận hoàn thành
		    SELECT O1.DivisionID, O1.POrderID, O1.SOrderID, O1.ObjectID, O1.ObjectName, O1.Transport,
				   O2.Notes01, O2.InventoryID, O2.Notes04, O2.ReceiveDate, O2.OrderQuantity, O2.Ana04ID, O2.Ana10ID 
		      FROM OT3001 O1 WITH (NOLOCK)
		      LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID
		     WHERE O1.DivisionID = '''+@DivisionID+'''
		       AND O1.KindVoucherID = 2
		       AND O2.ReceiveDate IS NOT NULL 
		       AND ISNULL(O2.Notes01,'''') <> '''' AND ISNULL(O2.Ana03ID,'''') <> '''' '+@sWhere+'
	      ) A
	LEFT JOIN
	( -- Lệnh điều động
		SELECT O1.DivisionID, O1.SOrderID, O1.ObjectID, O1.VoucherNo, O1.POrderID, 
			   O2.Notes04, O2.InventoryID, O2.Notes03, O2.PurchasePrice, O2.Ana04ID, O2.Ana10ID
		  FROM OT3001 O1 WITH (NOLOCK)
		  LEFT JOIN OT3002 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID AND O2.POrderID = O1.POrderID		  
		 WHERE O1.DivisionID = '''+@DivisionID+'''
		   AND O1.KindVoucherID = 1
	)B ON B.Notes03 = A.SOrderID AND B.POrderID = A.Notes01 AND B.Notes04 = A.InventoryID 
	  AND B.InventoryID = A.Notes04 AND A.Ana04ID = B.Ana04ID AND A.Ana10ID = B.Ana10ID
	  LEFT JOIN AT1202 A01 WITH (NOLOCK) ON A01.DivisionID IN (A.DivisionID,''@@@'') AND A01.ObjectID = A.ObjectID
	  LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (B.DivisionID,''@@@'') AND A02.ObjectID = B.ObjectID
	  LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON A.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
	  LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.InventoryID = A.InventoryID
	  LEFT JOIN AT1302 A30 WITH (NOLOCK) ON A30.InventoryID = B.Notes04
	  LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.InventoryID = A.Notes04
	  LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.ObjectID = B.ObjectID
	WHERE B.ObjectID BETWEEN ISNULL('''+@FromObjectID+''', '''') AND ISNULL('''+@ToObjectID+''', '''')
	ORDER BY B.ObjectID, A.ReceiveDate'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
