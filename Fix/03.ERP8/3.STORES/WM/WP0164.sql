IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0164]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0164]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load truy vấn ngược chứng từ nhập xuất theo tài khoản
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[WP0164]
       @DivisionID AS nvarchar(50) ,
       @WarehouseID AS nvarchar(50) ,
       @InventoryID AS nvarchar(50) ,
       @InventoryAccountID AS nvarchar(50),
	   @FromMonth AS int ,
	   @FromYear AS int ,
	   @ToMonth AS int ,
	   @ToYear AS int ,
	   @FromDate AS datetime ,
	   @ToDate AS datetime ,
	   @IsDate AS tinyint
AS
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)  
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'  

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + ' AND T1.TranMonth + T1.TranYear*100 BETWEEN '+@FromMonth+@FromYear*100+' AND ' +@ToMonth+@ToYear*100
END
ELSE
BEGIN
	SET @sWhere = @sWhere + N' AND T1.VoucherDate >= '''+@FromDateText+''' AND T1.VoucherDate <='''+@ToDateText+''' '
END 

SET @sSQL = N'
	-- Chứng từ nhập trong kỳ
	SELECT T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.WarehouseID, T3.WarehouseName, T1.KindVoucherID, T1.ObjectID, T4.ObjectName, T1.Description, T2.InventoryID, T2.ActualQuantity, T2.ConvertedAmount
	INTO #IMPORT
	FROM AT2006 T1 WITH (NOLOCK) INNER JOIN AT2007 T2 WITH (NOLOCK) ON T1.VoucherID = T2.VoucherID
								LEFT JOIN AT1303 T3 WITH (NOLOCK) ON T1.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T1.WarehouseID = T3.WarehouseID
								LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T4.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T1.ObjectID = T4.ObjectID
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.KindVoucherID in (1,3,5,7,9) AND T2.InventoryID = '''+@InventoryID+''' AND T2.DebitAccountID = '''+@InventoryAccountID+'''
	AND T1.WarehouseID in ('''+@WarehouseID+''') ' + @sWhere + '
	
	-- Chứng từ xuất trong kỳ
	SELECT T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.WarehouseID, T3.WarehouseName, T1.KindVoucherID, T1.ObjectID, T4.ObjectName, T1.Description, T2.InventoryID, T2.ActualQuantity, T2.ConvertedAmount
	INTO #EXPORT
	FROM AT2006 T1 WITH (NOLOCK) INNER JOIN AT2007 T2 WITH (NOLOCK) ON T1.VoucherID = T2.VoucherID
								LEFT JOIN AT1303 T3 WITH (NOLOCK) ON T1.DivisionID IN ('''+@DivisionID+''',''@@@'') AND CASE WHEN T1.KindVoucherID =3 THEN T1.WarehouseID2 ELSE T1.WarehouseID END = T3.WarehouseID
								LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T4.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T1.ObjectID = T4.ObjectID
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.KindVoucherID in (2,3,4,6,8) AND T2.InventoryID = '''+@InventoryID+''' AND T2.CreditAccountID = '''+@InventoryAccountID+'''
	AND CASE WHEN T1.KindVoucherID =3 THEN T1.WarehouseID2 ELSE T1.WarehouseID END in ('''+@WarehouseID+''')' + @sWhere +'

	SELECT VoucherID, VoucherNo, VoucherDate, WarehouseID, WarehouseName, KindVoucherID, ObjectID, ObjectName, Description, InventoryID, ActualQuantity as ImQuantity, ConvertedAmount as ImAmount, 0 as ExQuantity, 0 as ExAmount
	INTO #TEMP
	FROM #IMPORT
	UNION
	SELECT VoucherID, VoucherNo, VoucherDate, WarehouseID, WarehouseName, KindVoucherID, ObjectID, ObjectName, Description, InventoryID, 0 as ImQuantity, 0 as ImAmount, ActualQuantity as ExQuantity, ConvertedAmount as ExAmount
	FROM #EXPORT

	SELECT * FROM TEMP ORDER BY VoucherDate, VoucherNo
	'
EXEC @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
