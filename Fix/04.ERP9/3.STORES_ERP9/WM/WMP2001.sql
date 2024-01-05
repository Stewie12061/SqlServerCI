IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load dropdown mặt hàng theo hợp đồng (EIMSKIP)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 03/01/2016
----Modified on by 
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
-- <Example>
/*
	EXEC WMP2001 @DivisionID=N'ESP', @PageNumber=1,@PageSize=50, @ContractID='CT20170000000007', @TxtSearch='',
	@InventoryTypeID = '%',@Mode=1,@ListInventoryID = 'ONGNHOM', @VoucheriD=''
*/

CREATE PROCEDURE WMP2001
(
    @DivisionID NVARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
	@ContractID VARCHAR(50),
	@InventoryTypeID VARCHAR(50),
	@VoucherID VARCHAR(50),
	@TxtSearch VARCHAR(250),
	@ListInventoryID VARCHAR(MAX),
	@Mode TINYINT ---1:YCNK, 2: YCXK
)
AS
DECLARE @ContractQuantity DECIMAL(28,8),
		@ImQuantity DECIMAL(28,8),
		@ExQuantity DECIMAL(28,8),
		@sSQL NVARCHAR(MAX)='',
		@sSQL1 NVARCHAR(MAX)='',
		@sSQL2 NVARCHAR(MAX)='',
		@sWhere NVARCHAR(MAX)='',
		@sWhere1 NVARCHAR(MAX)='',
		@TotalRow NVARCHAR(50) = ''

IF @PageNumber <> 0 
	SET @TotalRow = 'COUNT(*) OVER ()'
ELSE 
	SET @TotalRow = ''

IF ISNULL(@ListInventoryID,'') <> ''
SET @sSQL1 = ' AND AT1302.InventoryID NOT IN ('''+@ListInventoryID+''') '

IF ISNULL(@VoucherID,'') <> ''
BEGIN
	SET @sWhere = 'AND ISNULL(WT95.VoucherID,'''') <> '''+ISNULL(@VoucherID,'')+''''
	
	SET @sWhere1 = 'AND ISNULL(WT951.VoucherID,'''') <> '''+ISNULL(@VoucherID,'')+''''

END
SET @sSQL = 'SELECT  ROW_NUMBER() OVER (ORDER BY BT.InventoryID) AS RowNum, '+@TotalRow+' AS TotalRow, BT.*
FROM
(
	SELECT AT1302.DivisionID, T2.ObjectID, T3.ObjectName, T1.ContractID, T2.ContractNo, T2.ContractName, T2.[Description], T2.SignDate, T2.BeginDate, T2.EndDate, AT1302.Barcode,AT1302.InventoryID,
	AT1302.InventoryName,AT1302.UnitID,AT1302.DeliveryPrice,AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,AT1302.AccountID,AT1302.PrimeCostAccountID,AT1302.MethodID,
	ActualQuantity = CASE WHEN '+STR(@Mode)+' = 1 THEN ISNULL(T1.ContractQuantity,0) - ISNULL(T1.ImQuantity,0)
						WHEN '+STR(@Mode)+' = 2 THEN ISNULL(T1.ImQuantity,0) - ISNULL(T4.ExQuantity,0) END,
	1 AS ConversionFactor,0 AS Operator,0 AS DataType,'''' AS FormulaDes,AT1302.UnitID AS ConvertedUnitID, T1.UnitPrice
	FROM AT1302 WITH (NOLOCK)
	LEFT JOIN 
		(
			SELECT AT1025.DivisionID, AT1025.InventoryID, ISNULL(AT1025.Quantity,0) AS ContractQuantity, SUM(ISNULL(WT96.ActualQuantity,0)) AS ImQuantity, 
			 AT1025.UnitPrice, AT1025.ContractID
			FROM AT1025 WITH (NOLOCK)
			LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON AT1025.DivisionID = WT95.DivisionID AND AT1025.ContractID = WT95.ContractID AND WT95.KindVoucherID IN (1,3,5,7,9)
			LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.DivisionID = WT95.DivisionID AND WT96.VoucherID = WT95.VoucherID AND AT1025.InventoryID = WT96.InventoryID
			LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID =  AT1025.InventoryID
			LEFT JOIN AT1020 WITH (NOLOCK) ON AT1025.DivisionID =  AT1020.DivisionID AND AT1025.ContractID =  AT1020.ContractID
			WHERE AT1025.DivisionID = '''+@DivisionID+'''
			AND AT1302.InventoryTypeID LIKE '''+@InventoryTypeID+'''
			AND AT1020.ContractID = '''+@ContractID+'''
			'+@sWhere+'
			GROUP BY AT1025.DivisionID, AT1025.InventoryID, AT1025.UnitPrice, AT1025.ContractID, AT1025.Quantity
		) T1  ON AT1302.InventoryID =  T1.InventoryID
	LEFT JOIN 
		(
			SELECT AT1025.DivisionID, AT1025.InventoryID, ISNULL(AT1025.Quantity,0) AS ContractQuantity, SUM(ISNULL(WT96.ActualQuantity,0)) AS ExQuantity,
			AT1025.UnitPrice, AT1025.ContractID
			FROM AT1025 WITH (NOLOCK)
			LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON AT1025.DivisionID = WT95.DivisionID AND AT1025.ContractID = WT95.ContractID AND WT95.KindVoucherID IN (2,4,6,8,10)
			LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.DivisionID = WT95.DivisionID AND WT96.VoucherID = WT95.VoucherID AND AT1025.InventoryID = WT96.InventoryID
			LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID =  AT1025.InventoryID
			LEFT JOIN AT1020 WITH (NOLOCK) ON AT1025.DivisionID =  AT1020.DivisionID AND AT1025.ContractID =  AT1020.ContractID
			WHERE AT1025.DivisionID = '''+@DivisionID+'''
			AND AT1020.ContractID = '''+@ContractID+'''
			'+@sWhere+'
			GROUP BY AT1025.DivisionID, AT1025.InventoryID, AT1025.UnitPrice, AT1025.ContractID, AT1025.Quantity
		) T4  ON AT1302.InventoryID =  T4.InventoryID AND T1.ContractID = T4.ContractID
	LEFT JOIN AT1020 T2 WITH (NOLOCK) ON T2.ContractID =  T1.ContractID
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T2.ObjectID =  T3.ObjectID
	WHERE AT1302.DivisionID in ('''+@DivisionID+''',''@@@'')
	AND AT1302.Disabled = 0
	AND AT1302.IsStocked = 1
	AND AT1302.InventoryTypeID LIKE '''+@InventoryTypeID+'''
	AND T2.ContractID = '''+ISNULL(@ContractID,'')+'''
	'+@sSQL1+'
	AND ISNULL(AT1302.InventoryID,'''') LIKE ''%'+@TxtSearch+'%'' 
	AND CASE WHEN '+STR(@Mode)+' = 1 THEN T1.ContractQuantity - T1.ImQuantity
		WHEN '+STR(@Mode)+' = 2 THEN T1.ImQuantity - T4.ExQuantity END > 0
	)BT
	ORDER BY BT.InventoryID
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS	
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	
	'

PRINT (@sSQL2)
PRINT (@sSQL)
EXEC (@sSQL2+@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
