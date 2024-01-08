IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Hải Long on 08/02/2017: Load Master đơn hàng sản xuất để lập phiếu điều chỉnh đơn hàng sản xuất (CustomizeIndex = 71 ---- HHP)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
exec OP0052 @DivisionID = 'SC', @FromPeriod = 201605, @ToPeriod = 201701, @FromDate = '01/05/2016', @ToDate = '01/31/2017', @TimeMode = 0
*/
 

CREATE PROCEDURE [dbo].[OP0052] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@TimeMode TINYINT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = ''

IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + '
	AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)										
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + '
	AND OT2001.OrderDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''							
END	


SET @sSQL = '
	SELECT  OT2001.DivisionID, OT2001.SOrderID, OT2001.VoucherNo, OT2001.OrderDate, OT2001.ObjectID, AT1202.ObjectName, OT2001.Notes
	FROM OT2001 WITH (NOLOCK) 
	INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND OT2001.ObjectID = AT1202.ObjectID
	INNER JOIN OT2002 A01 WITH (NOLOCK) ON A01.DivisionID = OT2002.DivisionID AND A01.SOrderID = OT2002.RefSOrderID AND A01.TransactionID = OT2002.RefSTransactionID
	INNER JOIN OT2001 B01 WITH (NOLOCK) ON A01.DivisionID = B01.DivisionID AND A01.SOrderID = B01.SOrderID AND B01.OrderType = 0
	INNER JOIN OT2002 A02 WITH (NOLOCK) ON A02.DivisionID = A01.DivisionID AND A02.InheritVoucherID = A01.SOrderID AND A02.InheritTransactionID = A01.TransactionID AND A02.InheritTableID = ''OT2001''
	INNER JOIN OT2001 B02 WITH (NOLOCK) ON A02.DivisionID = B02.DivisionID AND A02.SOrderID = B02.SOrderID AND B02.OrderType = 0 AND B02.OrderTypeID = 1
	WHERE  
	OT2001.DivisionID = ''' + @DivisionID + '''
	AND OT2001.OrderStatus not in (0, 9)
	AND OT2001.Disabled = 0 --- not in (0, 3, 4, 9)
	AND OT2001.OrderType = 1
	AND ISNULL(OT2001.OrderTypeID, 0) = 0' + @sWhere +'
	GROUP BY OT2001.DivisionID, OT2001.SOrderID, OT2001.VoucherNo, OT2001.OrderDate, OT2001.ObjectID, AT1202.ObjectName, OT2001.Notes
	ORDER BY OT2001.OrderDate, OT2001.VoucherNo
'


PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



