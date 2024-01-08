IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Nguyên tắc xuất hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Đoan on 02/11/2019
---- Modified by Huỳnh Thử om 18/12/2019 Thêm điều kiện theo TranSactionID
---- Modified by Huỳnh Thử om 25/06/2020 Thêm điều kiện lọc @WareHouseID
---- 
---- Modified on by 
-- <Example>
/*
    EXEC WP2002 @DivisionID ='EM', @InventoryID ='',@Mode=''
*/


CREATE PROCEDURE [dbo].[WP2002]
	@DivisionID NVARCHAR(50),
	@InventoryID NVARCHAR(50),
	@WareHouseID NVARCHAR(50),
	@Mode INT -- 1 FIF0 --2 Auto

AS
DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 1
BEGIN
SET @sSQL ='
	SELECT T06.WareHouseID,T07.InventoryID, AT1302.InventoryName, T07.UnitID, T06.VoucherNo,
	T07.SourceNo,T06.VoucherDate,T07.LimitDate,T07.ActualQuantity - isnull(G.ActualQuantity,0) AS ActualQuantity, 
	T07.UnitPrice, T07.OriginalAmount,T07.VoucherID as ReVoucherID,
	T07.TransactionID as ReTransactionID
	FROM AT2007 T07 WITH (NOLOCK)
	LEFT JOIN  AT1302 WITH (NOLOCK) ON AT1302.InventoryID = T07.InventoryID
	LEFT JOIN  AT2006  T06 WITH (NOLOCK) ON T06.VoucherID = T07.VoucherID
	LEFT JOIN 
	(
		SELECT 
		WT0096.DivisionID, 
		WT0096.ReVoucherID, 
		WT0096.ReTransactionID,
		WT0096.InventoryID,
		SUM(ISNULL(WT0096.ActualQuantity, 0)) AS ActualQuantity, 
		SUM(ISNULL(WT0096.OriginalAmount, 0)) AS ActualOriginalAmount
		FROM WT0096  WITH (NOLOCK)
		INNER JOIN WT0095 WITH (NOLOCK) ON WT0095.VoucherID = WT0096.VoucherID AND WT0095.DivisionID = WT0096.DivisionID
		WHERE WT0096.InventoryID = '''+@InventoryID +'''
		GROUP BY WT0096.DivisionID, WT0096.ReVoucherID, WT0096.InventoryID,WT0096.ReTransactionID
		) AS G ON G.DivisionID = T07.DivisionID AND G.ReVoucherID = T07.VoucherID  AND G.ReTransactionID = T07.TransactionID
		WHERE 
	   Isnull(T07.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
	   AND T07.InventoryID = '''+@InventoryID +'''
		 AND T06.KindVoucherID = 1 
		 AND T06.WareHouseID = '''+@WareHouseID+'''
	ORDER BY T06.VoucherDate, T07.ActualQuantity
	'
END
ELSE 
BEGIN
SET @sSQL ='
	SELECT T06.WareHouseID,T07.InventoryID, AT1302.InventoryName, T07.UnitID, T06.VoucherNo,
	T07.SourceNo,T06.VoucherDate,T07.LimitDate,T07.ActualQuantity - isnull(G.ActualQuantity,0) AS ActualQuantity, 
	T07.UnitPrice, T07.OriginalAmount,T07.VoucherID as ReVoucherID,
	T07.TransactionID as ReTransactionID
	FROM AT2007 T07 WITH (NOLOCK)
	LEFT JOIN  AT1302 WITH (NOLOCK) ON AT1302.InventoryID = T07.InventoryID
	LEFT JOIN  AT2006  T06 WITH (NOLOCK) ON T06.VoucherID = T07.VoucherID
	LEFT JOIN 
	(
		SELECT 
		WT0096.DivisionID, 
		WT0096.ReVoucherID, 
		WT0096.ReTransactionID,
		WT0096.InventoryID,
		SUM(ISNULL(WT0096.ActualQuantity, 0)) AS ActualQuantity, 
		SUM(ISNULL(WT0096.OriginalAmount, 0)) AS ActualOriginalAmount
		FROM WT0096  WITH (NOLOCK)
		INNER JOIN WT0095 WITH (NOLOCK) ON WT0095.VoucherID = WT0096.VoucherID AND WT0095.DivisionID = WT0096.DivisionID
		WHERE WT0096.InventoryID = '''+@InventoryID +'''
		GROUP BY WT0096.DivisionID, WT0096.ReVoucherID, WT0096.InventoryID,WT0096.ReTransactionID
		) AS G ON G.DivisionID = T07.DivisionID AND G.ReVoucherID = T07.VoucherID  AND G.ReTransactionID = T07.TransactionID
		WHERE 
	   Isnull(T07.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
	   AND T07.InventoryID = '''+@InventoryID +'''
		 AND T06.KindVoucherID = 1 
		 AND T06.WareHouseID = '''+@WareHouseID+'''
	  ORDER BY T07.LimitDate, T07.ActualQuantity
	'

	

END
PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
