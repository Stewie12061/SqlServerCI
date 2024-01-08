IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Báo cáo t?ng h?p chi phí theo tháng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Ðoan on 04/11/2019
----Update by Hu?nh Th? on 19/02/2020 -- Thây d?i cách load d? li?u
----Update by Huỳnh Thử on 18/03/2020 -- Tính giá theo hợp đồng (Pallet, trọng lượng, khối)
----Update by Huỳnh Thử on 30/03/2020 -- Thêm Loại chi phí thuê Pallet
----Update by Huỳnh Thử on 14/04/2020 -- Update cách tính chi phí theo trọng lượng
----Update by Huỳnh Thử on 16/04/2020 -- Lấy thêm trường ConvertQuantity
----Update by Huỳnh Thử on 27/08/2020 -- Thêm điều kiện lọc theo Kho
----Update by Huỳnh Thử on 27/08/2020 -- Bổ sung cột mã chi phí, tên chi phí và đơn vị tính
----Update by Huỳnh Thử on 22/12/2020 -- Chi phi luu kho lay tu WT2004
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- 
---- Modified on by 
-- <Example>
/*
    EXEC WP2016 @DivisionID ='EM', @ObjectID ='',@FromMonth='',@FromYear='',@ToMonth='', @FromDate,@ToDate='',@IsDate
	

*/


CREATE PROCEDURE [dbo].[WP2016](
			@DivisionID NVARCHAR(50),
			@ObjectID NVARCHAR(50),
			@FromDate DATETIME,
			@ToDate DATETIME,
			@UserID NVARCHAR(50),
			@Mode INT, -- 0 tổng hợp, 1 bốc xếp, 2 dịch vụ
			@WareHouseID AS Nvarchar(50)
			)
AS

Declare 
		@sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQLA nvarchar(max),
		@UnitType INT
		
		SELECT TOP 1 @UnitType = UnitType  FROM AT1020 WHERE ObjectID = @ObjectID ORDER BY ContractID DESC
		SET @sSQL1  = ''
		set @sSQLA = ''
		IF(@Mode = 0)
		BEGIN
				SET @sSQL = N' 

				SELECT  SUM(A.OriginalAmount) AS OriginalAmount, A.ObjectName, A.VATNo, A.Address, CASE when A.Type= 1 THEN N''PHÍ LƯU KHO'' WHEN A.Type = 2 THEN N''PHÍ BỐC XẾP'' WHEN A.Type = 3 THEN N''PHÍ DỊCH VỤ'' WHEN A.Type = 4 THEN N''PHÍ THUÊ PALLET'' ELSE '''' END AS ServiceName, A.WareHouseID From(
				--SELECT  AT1302.InventoryTypeID, SUM(OriginalAmount) AS OriginalAmount, WT0097.VoucherDate, AT1202.ObjectName, AT1202.Address, 1 AS Type
				--FROM WT0098  WITH (NOLOCK) 
				--LEFT JOIN WT0097  WITH (NOLOCK) ON WT0098.VoucherID = WT0097.VoucherID
				--LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.InventoryID = WT0098.CostID
				--LEFT JOIN AT1301  WITH (NOLOCK) ON AT1301.InventoryTypeID = AT1302.InventoryTypeID
				--LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.ObjectID= WT0097.ObjectID
				--WHERE WT0097.ObjectID = '''+@ObjectID+''' AND IsRoomCost = 1
				--GROUP BY  AT1302.InventoryTypeID, WT0097.VoucherDate, AT1202.ObjectName, AT1202.VATNo, AT1202.Address, IsRoomCost
				--UNION ALL
				SELECT  WT0098.WareHouseID,AT1302.InventoryTypeID, SUM(OriginalAmount) AS OriginalAmount, WT0097.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address,  2  AS Type
				FROM WT0098  WITH (NOLOCK) 
				LEFT JOIN WT0097  WITH (NOLOCK) ON WT0098.VoucherID = WT0097.VoucherID
				LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.InventoryID = WT0098.CostID
				LEFT JOIN AT1301  WITH (NOLOCK) ON AT1301.InventoryTypeID = AT1302.InventoryTypeID
				LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID= WT0097.ObjectID
				WHERE WT0097.ObjectID = '''+@ObjectID+''' AND IsLoadingCost = 1
				AND WT0098.WareHouseID LIKE '''+@WareHouseID+'''
				GROUP BY  WT0098.WareHouseID,AT1302.InventoryTypeID, WT0097.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address, IsLoadingCost
				UNION ALL
				SELECT   WT0098.WareHouseID,AT1302.InventoryTypeID, SUM(OriginalAmount) AS OriginalAmount, WT0097.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address, 3  AS Type
				FROM WT0098  WITH (NOLOCK) 
				LEFT JOIN WT0097  WITH (NOLOCK) ON WT0098.VoucherID = WT0097.VoucherID
				LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.InventoryID = WT0098.CostID
				LEFT JOIN AT1301  WITH (NOLOCK) ON AT1301.InventoryTypeID = AT1302.InventoryTypeID
				LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID= WT0097.ObjectID
				WHERE WT0097.ObjectID = '''+@ObjectID+''' AND IsServiceCost = 1
				AND WT0098.WareHouseID LIKE '''+@WareHouseID+'''
				GROUP BY   WT0098.WareHouseID,AT1302.InventoryTypeID, WT0097.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address, IsServiceCost'
				SET @sSQLA = '
				UNION ALL
				SELECT CT0199.WarehouseID, '''' AS InventoryTypeID ,  ( '+ CASE ISNULL(@UnitType,0)  WHEN 2 THEN 'WT2004.EndingPallet * WT2004.[UnitPrice] + WT2004.CreditPallet * WT2004.[UnitPrice]'
																				   WHEN 1 THEN '(WT2004.EndingWeight * WT2004.[UnitPrice] + WT2004.CreditWeight * WT2004.[UnitPrice])/1000.0'
																			       WHEN 3 THEN 'WT2004.EndingGradeLevel * WT2004.[UnitPrice] + WT2004.GradeLevel * WT2004.[UnitPrice]' ELSE '0' end  +' ) AS OriginalAmount,WT2004.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address, 1 AS Type
				FROM WT2004 WITH (NOLOCK) 
				LEFT JOIN WT0099 WITH (NOLOCK)  ON WT0099.VoucherID = WT2004.VoucherID
				LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = WT0099.ObjectID
				LEFT JOIN CT0199  WITH (NOLOCK) ON CT0199.InventoryTypeID = WT2004.RoomID
				WHERE WT0099.ObjectID ='''+@ObjectID+''' AND ISNULL(WT0099.IsRent,0) <> 1
				AND CT0199.WareHouseID LIKE '''+@WareHouseID+'''
				GROUP BY  CT0199.WarehouseID,WT2004.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address,
				 '+ CASE ISNULL(@UnitType,0)  WHEN 2 THEN 'WT2004.EndingPallet , WT2004.[UnitPrice] , WT2004.CreditPallet , WT2004.[UnitPrice]'
																				   WHEN 1 THEN 'WT2004.EndingWeight , WT2004.[UnitPrice] , WT2004.CreditWeight , WT2004.[UnitPrice]'
																			       WHEN 3 THEN 'WT2004.EndingGradeLevel , WT2004.[UnitPrice] , WT2004.GradeLevel , WT2004.[UnitPrice]' ELSE '' end  +' 
				UNION ALL
				SELECT CT0199.WarehouseID,'''' AS InventoryTypeID ,  ( WT2004.EndingPallet * WT2004.[UnitPrice] + WT2004.CreditPallet * WT2004.[UnitPrice] ) AS OriginalAmount,WT2004.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address, 4 AS Type
				FROM WT2004 WITH (NOLOCK) 
				LEFT JOIN WT0099 WITH (NOLOCK)  ON WT0099.VoucherID = WT2004.VoucherID
				LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = WT0099.ObjectID
				LEFT JOIN CT0199  WITH (NOLOCK) ON CT0199.InventoryTypeID = WT2004.RoomID
				WHERE WT0099.ObjectID ='''+@ObjectID+''' AND ISNULL(WT0099.IsRent,0) = 1
				AND CT0199.WareHouseID LIKE '''+@WareHouseID+'''
				GROUP BY  CT0199.WarehouseID,WT2004.VoucherDate, AT1202.ObjectName,AT1202.VATNo, AT1202.Address, WT2004.EndingPallet , WT2004.[UnitPrice] , WT2004.CreditPallet , WT2004.[UnitPrice] '

				SET @sSQL1 += '
				--UNION ALL
				--SELECT AT1302.InventoryTypeID , SUM (WT2004.EndingPallet * WT2004.[UnitPrice ]) AS OriginalAmount,WT2004.VoucherDate, AT1202.ObjectName, AT1202.Address, 3 AS Type
				--FROM WT2004 WITH (NOLOCK) 
				--LEFT JOIN WT0099 WITH (NOLOCK)  ON WT0099.VoucherID = WT2004.VoucherID
				--LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.InventoryID = WT2004.RoomID
				--LEFT JOIN AT1301  WITH (NOLOCK) ON AT1301.InventoryTypeID = AT1302.InventoryTypeID
				--LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = WT0099.ObjectID
				--WHERE WT0099.ObjectID ='''+@ObjectID+''' AND IsServiceCost = 1
				--GROUP BY  AT1302.InventoryTypeID,WT2004.VoucherDate, AT1202.ObjectName, AT1202.Address, IsServiceCost
				) A
				WHERE FORMAT(A.VoucherDate,''yyyy/MM/dd'')  Between '''+ CONVERT(VARCHAR, @FromDate,111)+''' AND '''+ CONVERT(VARCHAR, @ToDate,111)+'''
				GROUP BY A.ObjectName, A.VATNo, A.Address, A.TYPE, A.WareHouseID'

	END

ELSE IF @Mode = 1
	BEGIN
		SET @sSQL =N'
				SELECT  WT0098.CostID,AT1302.InventoryName as CostName,AT1304.UNITname as UnitID,AT2006.WareHouseID,WT0097.VoucherDate,AT2006.VoucherNo,Quantity as ConvertQuantity,ConvertCoefficient,WT0098.OriginalAmount,WT0098.CostUnitPrice* ConvertCoefficient as CostUnitPrice ,WT0097.Description, AT1202.ObjectName, AT1202.Address
				FROM WT0098  WITH (NOLOCK) 
				LEFT JOIN WT0097  WITH (NOLOCK) ON WT0098.VoucherID = WT0097.VoucherID
				LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.InventoryID = WT0098.CostID
				LEFT JOIN AT1301  WITH (NOLOCK) ON AT1301.InventoryTypeID = AT1302.InventoryTypeID
				LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID= WT0097.ObjectID
				LEFT JOIN AT2006  WITH (NOLOCK) ON AT2006.VoucherID = WT0098.InheritVoucherID 
				LEFT JOIN AT1304  WITH (NOLOCK) ON AT1304.UNITID = AT1302.UNITID
				WHERE WT0097.ObjectID = '''+@ObjectID+''' AND IsLoadingCost = 1
				AND AT2006.WareHouseID LIKE '''+@WareHouseID+'''
				AND FORMAT(WT0097.VoucherDate,''yyyy/MM/dd'')  Between '''+ CONVERT(VARCHAR, @FromDate,111)+''' AND '''+ CONVERT(VARCHAR, @ToDate,111)+'''
				GROUP BY  WT0098.CostID,AT1302.InventoryName,AT1304.UnitName,AT2006.WareHouseID,WT0097.VoucherDate,AT2006.VoucherNo,Quantity,WT0098.ConvertCoefficient,WT0098.OriginalAmount,WT0098.CostUnitPrice,WT0097.Description, AT1202.ObjectName, AT1202.Address, IsLoadingCost'
	END
ELSE
	BEGIN
		SET @sSQL =N'
				SELECT WT0098.CostID,AT1302.InventoryName as CostName,AT1304.UNITname as UnitID,WT0098.WareHouseID,AT1302.InventoryName, WT0097.VoucherNo,WT0097.VoucherDate,dbo.AT1302.UnitID,UnitName,WT0098.Quantity,WT0098.CostUnitPrice* ConvertCoefficient as CostUnitPrice,WT0097.Description, AT1202.ObjectName, AT1202.Address
				FROM WT0098  WITH (NOLOCK) 
				LEFT JOIN WT0097  WITH (NOLOCK) ON WT0098.VoucherID = WT0097.VoucherID
				LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.InventoryID = WT0098.CostID
				LEFT JOIN AT1304  WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
				LEFT JOIN AT1301  WITH (NOLOCK) ON AT1301.InventoryTypeID = AT1302.InventoryTypeID
				LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID= WT0097.ObjectID
				LEFT JOIN AT2006  WITH (NOLOCK) ON AT2006.VoucherID = WT0098.InheritVoucherID 
				WHERE WT0097.ObjectID = '''+@ObjectID+''' AND IsServiceCost = 1
				AND WT0098.WareHouseID LIKE '''+@WareHouseID+'''
				AND FORMAT(WT0097.VoucherDate,''yyyy/MM/dd'')   Between '''+ CONVERT(VARCHAR, @FromDate,111)+''' AND '''+ CONVERT(VARCHAR, @ToDate,111)+'''
				GROUP BY WT0098.CostID,AT1302.InventoryName,AT1304.UnitName,WT0098.WareHouseID, AT1302.InventoryName, WT0097.VoucherNo,WT0097.VoucherDate,dbo.AT1302.UnitID,AT1304.UnitName,WT0098.Quantity,WT0098.ConvertCoefficient,WT0098.CostUnitPrice,WT0097.Description, AT1202.ObjectName, AT1202.Address, IsServiceCost'
	END

	
PRINT @sSQL 
PRINT @sSQLA 
PRINT  @sSQL1
EXEC ( @sSQL+@sSQLA+@sSQL1)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


