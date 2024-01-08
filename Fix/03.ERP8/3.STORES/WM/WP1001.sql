IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Danh mục Pallet
-- <History>
---- Create on 21/09/2019 by Khánh Đoan 
---- Modified on 14/11/2019 by Huỳnh Thử thay đổi điệu kiện Room
---- Modified on 27/03/2020 by Huỳnh Thử Lấy thêm trường IsMove
---- Modified on 13/04/2020 by Huỳnh Thử Lấy thêm trường IsRent
---- Modified on 17/04/2020 by Huỳnh Thử Bổ sung lọc theo đối tượng
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Huỳnh Thử on 06/11/2020 : Check xuất hết kho dựa vào AT2007 bỏ check tới bảng WT2003
---- Modified by Huỳnh Thử on 29/12/2020 : Cải tiến tốc độ
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

---- <Example>

CREATE PROCEDURE [WP1001]
	@DivisionID NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@WareHouseID NVARCHAR(50),
	@InventoryTypeID NVARCHAR(50),
	@LocationID NVARCHAR(50),
	@UserID VARCHAR(50),
	@ObjectID NVARCHAR(50)
	
AS

Declare 
		@sSQL VARCHAR(MAX)

SET @sSQL='

		select LNK.VoucherID,SUM (AT2007.ActualQuantity) AS ActualQuantity 
		INTO #temp
		From AT2007 with (Nolock) 
		left join WT2002 LXK with (Nolock) on LXK.VoucherID  = AT2007.InheritVoucherID AND LXK.TransactionID  = AT2007.InheritTransactionID
		left join WT2002 LNK with (Nolock) on LNK.VoucherID  = LXK.RePVoucherID AND LNK.TransactionID  = LXK.RePTransactionID
		--where LNK.VoucherID is not null
		group by LNK.VoucherID

	select * from (
		SELECT DISTINCT WT2001.APK,
	WT2001.VoucherTypeID, WT2001.VoucherDate,WT2001.VoucherNo,WT2001.CreateUserID,
	WT2001.Description,WT2001.LocationID,WT2001.VoucherID, AT2006.VoucherNo  AS ReVoucherNo, 
	CASE WHEN (SUM (ISNULL(WT2002.ActualQuantity,0)) - ISNULL(A.ActualQuantity,0)) = 0 THEN 1 ELSE 0 END AS IsOutStock, IsNULL(WT2001.IsMove,0) AS IsMove,IsNULL(WT2001.IsRent,0) AS IsRent
	FROM WT2001  WITH (NOLOCK)
	LEFT JOIN WT2002 WITH (NOLOCK) ON WT2002.VoucherID = WT2001.VoucherID
	INNER JOIN CT0199  WITH (NOLOCK) ON CT0199.LocationID = WT2001.LocationID
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', CT0199.DivisionID) AND AT1302.InventoryID = CT0199.InventoryTypeID
	INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND AT1303.WareHouseID = CT0199.WareHouseID
	LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = WT2002.ReVoucherID AND AT2006.KindVoucherID =1
	LEFT JOIN #temp A on A.VoucherID = WT2001.VoucherID
	WHERE WT2001.DivisionID = ''' + @DivisionID + '''
	AND  Convert(NVARCHAR(10),WT2001.VoucherDate,21)   Between '''+ Convert(NVARCHAR(10),@FromDate,21)+''' and '''+convert(NVARCHAR(10), @ToDate,21)+''' AND 
	ISNULL(AT1303.WarehouseID,''%'') LIKE ('''+@WarehouseID+''') AND 
	ISNULL(CT0199.LocationID,''%'') LIKE ('''+@LocationID+''') AND
	ISNULL(AT1302.InventoryID,''%'') LIKE ('''+CASE WHEN @InventoryTypeID = N'Tất cả' THEN '%' ELSE @InventoryTypeID END+''') AND
	ISNULL(AT2006.ObjectID,''%'') LIKE ('''+@ObjectID+''') 
	group by WT2001.APK,
	WT2001.VoucherTypeID, WT2001.VoucherDate,WT2001.VoucherNo,WT2001.CreateUserID,
	WT2001.Description,WT2001.LocationID,WT2001.VoucherID, AT2006.VoucherNo  ,
	WT2001.IsMove,WT2001.IsRent,A.ActualQuantity
	) B 
	 order by VoucherNo
	'
	 

PRINT @sSQL
EXEC (@sSQL )

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
