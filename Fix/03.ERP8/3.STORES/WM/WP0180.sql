IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0180]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0180]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo chi tiết phí thuê kho
-- <History>
---- Create on 15/12/2022 by Nhật Thanh
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 18/08/2023: BBL - Không lấy dòng trùng.
---- Modified by Kiều Nga on 31/08/2023: [2023/08/IS/0328] BBL - Lấy thêm các cột FirstMonthday, FirstMonthAmount, NextMonthQuanity.
---- Modified by Nhựt Trường on 30/11/2023: [2023/11/IS/0212] - Fix lỗi không lấy được dữ liệu từ bảng tính phí thuê kho nếu khác kỳ với phiếu kho.

CREATE PROCEDURE [dbo].[WP0180] 	
				@DivisionID nvarchar(50),
				@FromMonth int,
				@FromYear int,
				@ToMonth int,
				@ToYear int,
				@ObjectID nvarchar(100),
				@OrderID nvarchar(100)
AS

SELECT DISTINCT A07.DivisionID, A07.OrderID, A02.ObjectID, A02.ObjectName,A06.VoucherDate, A03.InventoryID, A03.InventoryName, A07.Unitprice,

	CASE WHEN (SELECT ISNULL(SUM(CASE WHEN AT2006.KindVoucherID in (1,3,5,7,9) THEN ISNULL(ActualQuantity,0) ELSE ISNULL(-ActualQuantity,0) END),0)
			   FROM AT2007 WITH(NOLOCK)
			   INNER JOIN AT2006 WITH(NOLOCK) on AT2007.VoucherID = AT2006.VoucherID
			   WHERE AT2007.OrderID = A07.OrderID AND AT2007.InventoryID=A07.InventoryID AND VoucherDate<A06.VoucherDate) = 0
	THEN NextMonthQuantity
	ELSE (SELECT ISNULL(SUM(CASE WHEN AT2006.KindVoucherID in (1,3,5,7,9) THEN ISNULL(ActualQuantity,0) ELSE ISNULL(-ActualQuantity,0) END),0)
			   FROM AT2007 WITH(NOLOCK)
			   INNER JOIN AT2006 WITH(NOLOCK) on AT2007.VoucherID = AT2006.VoucherID
			   WHERE AT2007.OrderID = A07.OrderID AND AT2007.InventoryID=A07.InventoryID AND VoucherDate<A06.VoucherDate) END AS BeginQuantity,
	CASE WHEN A06.KindVoucherID in (1,3,5,7,9) THEN SUM(ISNULL(ActualQuantity,0)) ELSE 0 END AS ImQuantity,
	CASE WHEN A06.KindVoucherID in (2,4,6,8,10) THEN SUM(ISNULL(ActualQuantity,0)) ELSE 0 END AS ExQuantity,
	(SELECT ISNULL(SUM(CASE WHEN AT2006.KindVoucherID in (1,3,5,7,9) THEN ISNULL(ActualQuantity,0) ELSE ISNULL(-ActualQuantity,0) END),0)
			   FROM AT2007
			   INNER JOIN AT2006 on AT2007.VoucherID = AT2006.VoucherID
			   WHERE AT2007.OrderID = A07.OrderID AND AT2007.InventoryID=A07.InventoryID AND VoucherDate<=A06.VoucherDate) AS ENDQuantity,
	NextHalfMonthQuantity, NextHalfMonthAmount,  FirstMonthQuantity,  FirstMonthDays,  FirstMonthAmount,  NextMonthQuantity,  NextMonthAmount
	FROM WT0056 W56 WITH(NOLOCK)
	LEFT JOIN AT2007 A07 WITH (NOLOCK) on W56.DivisionID IN (@DivisionID, '@@@') AND A07.OrderID = W56.OrderID
	LEFT JOIN AT2006 A06 WITH (NOLOCK) on A06.DivisionID IN (@DivisionID, '@@@') AND A07.VoucherID = A06.VoucherID AND A06.TranMonth = W56.TranMonth AND A06.TranYear = W56.TranYear
	LEFT JOIN OT2001 O01 WITH (NOLOCK) on A07.OrderID = O01.SOrderID AND (A06.VoucherDate = W56.VoucherDate OR W56.VoucherDate IS NULL)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) on A02.DivisionID IN (@DivisionID, '@@@') AND A06.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) on A03.DivisionID IN (@DivisionID, '@@@') AND A07.InventoryID = A03.InventoryID
	WHERE W56.DivisionID = @DivisionID AND W56.OrderID LIKE @OrderID 
	AND O01.VoucherTypeID = 'PTK' 
	AND W56.TranMonth = @FromMonth AND W56.TranYear = @FromYear 
	GROUP BY A07.DivisionID, A07.OrderID, A02.ObjectID, A02.ObjectName,A06.VoucherDate, A03.InventoryID, A03.InventoryName, A07.Unitprice,A07.InventoryID,
	A06.KindVoucherID, W56.NextHalfMonthQuantity, W56.NextHalfMonthAmount, W56.FirstMonthQuantity, W56.FirstMonthDays, W56.FirstMonthAmount, W56.NextMonthQuantity, W56.NextMonthAmount

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
