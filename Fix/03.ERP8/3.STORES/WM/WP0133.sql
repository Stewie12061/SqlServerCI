IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0133]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0133]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Lấy thông tin mặt hàng khi kế thừa hợp đồng (EIMSKIP)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 07/02/2016
---- Modified by Phương Thảo on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 15/06/2017: Bổ sung thông tin đối tượng
---- Modified by Bảo Thy on 04/07/2017: Lấy thông tin nhập xuất left từ 2 bảng, ko lấy chung nữa
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
	EXEC WP0133 'ESP', '%', '','','','' ,1
	SELECT * FROM WQ0133
*/

CREATE PROCEDURE WP0133
(
    @DivisionID NVARCHAR(50),
	@InventoryTypeID VARCHAR(50),
	@ObjectID VARCHAR(50),
	@VoucherID VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Mode TINYINT ---1:YCNK, 2: YCXK
)
AS
DECLARE @sSQL NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = ''

IF ISNULL(@VoucherID,'') <> '' SET @sWhere = 'AND ISNULL(WT95.VoucherID,'''') <> '''+ISNULL(@VoucherID,'')+''''

SET @sSQL = '
SELECT AT1302.DivisionID, T2.ObjectID, T3.ObjectName, T1.ContractID, T2.ContractNo, T2.ContractName, T2.[Description], T2.SignDate, T2.BeginDate, T2.EndDate, AT1302.Barcode,AT1302.InventoryID,
AT1302.InventoryName,AT1302.UnitID,AT1302.DeliveryPrice,AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,AT1302.AccountID,AT1302.PrimeCostAccountID,AT1302.MethodID,
ActualQuantity = CASE WHEN '+STR(@Mode)+' = 1 THEN ISNULL(T1.ContractQuantity,0) - ISNULL(T1.ImQuantity,0)
					WHEN '+STR(@Mode)+' = 2 THEN ISNULL(T1.ImQuantity,0) - ISNULL(T4.ExQuantity,0) END,
1 AS ConversionFactor,0 AS Operator,0 AS DataType,'''' AS FormulaDes,AT1302.UnitID AS ConvertedUnitID, T1.UnitPrice
FROM AT1302 WITH (NOLOCK)
LEFT JOIN 
	(
		SELECT AT1025.DivisionID, AT1025.InventoryID, ISNULL(SUM(AT1025.Quantity),0) AS ContractQuantity, SUM(ISNULL(WT96.ActualQuantity,0)) AS ImQuantity, 
		 AT1025.UnitPrice, AT1025.ContractID
		FROM AT1025 WITH (NOLOCK)
		LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON AT1025.DivisionID = WT95.DivisionID AND AT1025.ContractID = WT95.ContractID AND WT95.KindVoucherID IN (1,3,5,7,9)
		LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.DivisionID = WT95.DivisionID AND WT96.VoucherID = WT95.VoucherID AND AT1025.InventoryID = WT96.InventoryID
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT1025.DivisionID) AND AT1302.InventoryID =  AT1025.InventoryID
		LEFT JOIN AT1020 WITH (NOLOCK) ON AT1025.DivisionID =  AT1020.DivisionID AND AT1025.ContractID =  AT1020.ContractID
		WHERE AT1025.DivisionID = '''+@DivisionID+'''
		AND AT1302.InventoryTypeID LIKE '''+@InventoryTypeID+'''
		AND AT1020.ObjectID LIKE '''+@ObjectID+'''
		AND ('''+CONVERT(VARCHAR(50),@FromDate,120)+'''  BETWEEN AT1020.BeginDate AND AT1020.EndDate   
			OR '''+CONVERT(VARCHAR(50),@ToDate,120)+''' BETWEEN AT1020.BeginDate AND AT1020.EndDate  )
		'+@sWhere+'
		GROUP BY AT1025.DivisionID, AT1025.InventoryID, AT1025.UnitPrice, AT1025.ContractID
	) T1  ON AT1302.DivisionID IN (''@@@'', T1.DivisionID) AND AT1302.InventoryID =  T1.InventoryID
LEFT JOIN 
	(
		SELECT AT1025.DivisionID, AT1025.InventoryID, ISNULL(SUM(AT1025.Quantity),0) AS ContractQuantity, SUM(ISNULL(WT96.ActualQuantity,0)) AS ExQuantity,
		AT1025.UnitPrice, AT1025.ContractID
		FROM AT1025 WITH (NOLOCK)
		LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON AT1025.DivisionID = WT95.DivisionID AND AT1025.ContractID = WT95.ContractID AND WT95.KindVoucherID IN (2,4,6,8,10)
		LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.DivisionID = WT95.DivisionID AND WT96.VoucherID = WT95.VoucherID AND AT1025.InventoryID = WT96.InventoryID
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT1025.DivisionID) AND AT1302.InventoryID =  AT1025.InventoryID
		LEFT JOIN AT1020 WITH (NOLOCK) ON AT1025.DivisionID =  AT1020.DivisionID AND AT1025.ContractID =  AT1020.ContractID
		WHERE AT1025.DivisionID = '''+@DivisionID+'''
		AND AT1302.InventoryTypeID LIKE '''+@InventoryTypeID+'''
		AND AT1020.ObjectID LIKE '''+@ObjectID+'''
		AND ('''+CONVERT(VARCHAR(50),@FromDate,120)+'''  BETWEEN AT1020.BeginDate AND AT1020.EndDate   
			OR '''+CONVERT(VARCHAR(50),@ToDate,120)+''' BETWEEN AT1020.BeginDate AND AT1020.EndDate  )
		'+@sWhere+'
		GROUP BY AT1025.DivisionID, AT1025.InventoryID, AT1025.UnitPrice, AT1025.ContractID
	) T4  ON AT1302.DivisionID IN (''@@@'', T4.DivisionID) AND AT1302.InventoryID =  T4.InventoryID AND T1.ContractID = T4.ContractID
LEFT JOIN AT1020 T2 WITH (NOLOCK) ON T2.ContractID =  T1.ContractID
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T2.ObjectID =  T3.ObjectID
WHERE AT1302.DivisionID in ('''+@DivisionID+''',''@@@'')
AND AT1302.Disabled = 0
AND AT1302.IsStocked = 1
AND AT1302.InventoryTypeID LIKE '''+@InventoryTypeID+'''
AND T2.ObjectID LIKE '''+@ObjectID+'''
AND CASE WHEN '+STR(@Mode)+' = 1 THEN T1.ContractQuantity - T1.ImQuantity
	WHEN '+STR(@Mode)+' = 2 THEN T1.ImQuantity - T4.ExQuantity END > 0
'
PRINT (@sSQL)

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='WQ0133')
	EXEC ('CREATE VIEW WQ0133  ---TAO BOI WP0133
		AS '+@sSQL )
ELSE
	EXEC( 'ALTER VIEW WQ0133  ---TAO BOI WP0133
		AS '+@sSQL )



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
