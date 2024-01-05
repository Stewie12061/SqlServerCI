IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2221]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2221]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load grid chọn mặt hàng(WMF2221)
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by Bảo Thy on 02/03/2018
 ----Modified by on 03/12/2018 by Bảo Anh: Sửa lỗi thực thi store khi chưa thiết lập hệ thống ở CSM
  ----Modified by on 12/10/2023 by Thanh Lượng:[2023/10/IS/0053] - Bổ sung cột Specification khi kế thừa.
  ----Modified by on 05/12/2023 by Nhật Thanh:Bổ sung Accountname
  ----Modified by on 03/01/2023 by Viết Toàn: Chỉnh sửa: Lấy mã và tên tài khoản nợ/có
 /*-- <Example>
 EXEC WMP2221 @DivisionID = 'VF', @UserID = '', @TranMonth=12, @TranYear=2017,@PageNumber = 1, @PageSize = 25, @WarehouseID = '', @InventoryTypeID = 'KHO',@IsSerialized = 0, @FormID = 'WMF2021', 
 @TxtSearch = 'a', @ConditionIV = N'('''')', @IsUsedConditionIV= N' (0=0) '
 ----*/
 
CREATE PROCEDURE WMP2221
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @TranMonth INT,
  @TranYear INT,
  @WarehouseID VARCHAR(50),
  @InventoryTypeID VARCHAR(50) = '',
  @FormID VARCHAR(20),
  @TxtSearch NVARCHAR(100),
  @ConditionIV NVARCHAR(1000),
  @IsUsedConditionIV NVARCHAR(1000)
) 
AS

DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'', 
		@sSQL2 NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sWhere2 NVARCHAR(MAX) = N'',
		@FirmAna VARCHAR(50),
		@ModelAna VARCHAR(50),
		@ProductTypeAna VARCHAR(50),
		@CustomerIndex INT

SELECT TOP 1 @CustomerIndex = CustomerName FROM CustomerIndex

IF ISNULL(@CustomerIndex,-1) = 88 --VIETFIRST
SELECT TOP 1 @FirmAna = FirmAnalyst, @ProductTypeAna = ProductTypeAnalyst, @ModelAna = ModelAnalyst FROM CSMT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID

IF ISNULL(@TxtSearch,'') <> ''
BEGIN
	SET @sWhere = N'AND (InventoryID LIKE ''%'+@TxtSearch+'%'' OR InventoryName LIKE ''%'+@TxtSearch+'%'')'
	SET @sWhere2 = N'AND (T2.InventoryID LIKE ''%'+@TxtSearch+'%'' OR T3.InventoryName LIKE ''%'+@TxtSearch+'%'')'
END
SET @OrderBy = N' InventoryID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, 
	AT1302.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, Convert(Decimal(28,8),0) AS EndQuantity, ISNULL(AT1302.IsSerialized,0) AS IsSerialized,
	AT1302.SalePrice01 as SalePrice, AT1302.AccountID AS DebitAccountID, AT1302.PrimeCostAccountID AS CreditAccountID, AT1005.AccountName AS DebitAccountName, A05.AccountName AS CreditAccountName, AT1302.Specification, AT1302.AccountID, AT1005.AccountName
	'+CASE WHEN ISNULL(@CustomerIndex,-1) = 88 THEN 
		',
		'+CASE WHEN ISNULL(@FirmAna,'') = '' THEN 'NULL' ELSE 'AT1302.'+@FirmAna+'ID' END + ' AS FirmID,
		'+CASE WHEN ISNULL(@FirmAna,'') = '' THEN 'NULL' ELSE 'AT1302.'+@FirmAna+'ID+'' - ''+T1.AnaName' END + ' AS FirmName,
		'+CASE WHEN ISNULL(@ProductTypeAna,'') = '' THEN 'NULL' ELSE 'AT1302.'+@ProductTypeAna+'ID' END + ' AS ProductTypeID,
		'+CASE WHEN ISNULL(@ProductTypeAna,'') = '' THEN 'NULL' ELSE 'AT1302.'+@ProductTypeAna+'ID+'' - ''+T2.AnaName' END + ' AS ProductTypeName,
		'+CASE WHEN ISNULL(@ModelAna,'') = '' THEN 'NULL' ELSE 'AT1302.'+@ModelAna+'ID' END + ' AS Model,
		'+CASE WHEN ISNULL(@ModelAna,'') = '' THEN 'NULL' ELSE 'AT1302.'+@ModelAna+'ID+'' - ''+T3.AnaName' END + ' AS ModelName'
	ELSE '' END +'
	INTO #WMP2221_AT1302
	FROM AT1302 WITH (NOLOCK) 
	INNER JOIN AT1304 WITH (NOLOCK) ON AT1302.UnitID = AT1304.UnitID
	LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.DivisionID in (AT1302.DivisionID,''@@@'') and AT1302.AccountId = AT1005.AccountID
	LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN (AT1302.DivisionID, ''@@@'') AND AT1302.PrimeCostAccountID = A05.AccountID
	'+CASE WHEN ISNULL(@CustomerIndex,-1) = 88 THEN '
	'+CASE WHEN ISNULL(@FirmAna,'') = '' THEN '' ELSE 'LEFT JOIN AT1015 T1 WITH (NOLOCK) ON T1.AnaID = AT1302.'+@FirmAna+'ID AND T1.AnaTypeID = '''+@FirmAna+'''' END + '
	'+CASE WHEN ISNULL(@ProductTypeAna,'') = '' THEN '' ELSE 'LEFT JOIN AT1015 T2 WITH (NOLOCK) ON T2.AnaID = AT1302.'+@ProductTypeAna+'ID AND T2.AnaTypeID = '''+@ProductTypeAna+'''' END + '
	'+CASE WHEN ISNULL(@ModelAna,'') = '' THEN '' ELSE 'LEFT JOIN AT1015 T3 WITH (NOLOCK) ON T3.AnaID = AT1302.'+@ModelAna+'ID AND T3.AnaTypeID = '''+@ModelAna+'''' END
	ELSE '' END +'
	WHERE AT1302.Disabled = 0
	AND AT1302.IsStocked = 1      
	AND (ISNULL(InventoryID, ''#'') IN '+@ConditionIV+' OR '+@IsUsedConditionIV+')
	AND AT1302.DivisionID in ('''+@DivisionID+''',''@@@'')	
	'+CASE WHEN ISNULL(@InventoryTypeID,'') <> '' THEN 'AND AT1302.InventoryTypeID LIKE '''+@InventoryTypeID+'''' ELSE '' END+'
	'+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'

IF (@FormID in('WMF2031','WMF2041', 'WMF2003', 'WMF2007') )
BEGIN
	---- Lay so ton kho
	SET @sSQL1 =N'
	SELECT InventoryID, SUM(Quantity) AS EndQuantity
	INTO #WMP2221_EndQuantity
	FROM
	(
		SELECT T2.InventoryID, SUM(T2.ActualQuantity) AS Quantity
		FROM AT2016 T1 WITH(NOLOCK) 
		INNER JOIN AT2017 T2 WITH(NOLOCK) ON T1.VoucherID = T2.VoucherID AND T1.DivisionID = T2.DivisionID
		INNER JOIN AT1302 T3 WITH(NOLOCK) ON T2.InventoryID = T3.InventoryID
		WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.WarehouseID = '''+@WarehouseID+'''
		'+CASE WHEN ISNULL(@InventoryTypeID,'') <> '' THEN 'AND T3.InventoryTypeID LIKE '''+@InventoryTypeID+'''' ELSE '' END+'
		'+@sWhere2+'
		GROUP BY T2.InventoryID
		UNION ALL
		SELECT	T2.InventoryID, 
				SUM(CASE WHEN (T1.KindVoucherID = 1 OR (T1.KindVoucherID = 3 AND T1.WarehouseID = '''+@WarehouseID+''')) THEN T2.ActualQuantity
					ELSE CASE WHEN (T1.KindVoucherID = 2 OR (T1.KindVoucherID = 3 AND T1.WarehouseID2 = '''+@WarehouseID+''')) THEN T2.ActualQuantity * (-1)
					ELSE 0 END END ) AS Quantity
		FROM AT2006 T1 
		INNER JOIN AT2007 T2 ON T1.VoucherID = T2.VoucherID AND T1.DivisionID = T2.DivisionID
		INNER JOIN AT1302 T3 WITH(NOLOCK) ON T2.InventoryID = T3.InventoryID
		WHERE T1.DivisionID = '''+@DivisionID+''' AND (T1.WarehouseID = '''+@WarehouseID+''' OR T1.WarehouseID2 = '''+@WarehouseID+''')
		'+CASE WHEN ISNULL(@InventoryTypeID,'') <> '' THEN 'AND T3.InventoryTypeID LIKE '''+@InventoryTypeID+'''' ELSE '' END+'
		'+@sWhere2+'
		AND T1.TranMonth + T1.TranYear*100 <= '+STR(@TranMonth)+' + '+STR(@TranYear)+'*100
		GROUP BY T2.InventoryID
	) T
	GROUP BY InventoryID

	UPDATE	T1
	SET		T1.EndQuantity = T2.EndQuantity		
	FROM #WMP2221_AT1302 T1
	INNER JOIN #WMP2221_EndQuantity T2 ON T1.InventoryID = T2.InventoryID	
	'
	
END

	SET @sSQL2 = N'SELECT * FROM #WMP2221_AT1302'

PRINT(@sSQL)
PRINT(@sSQL1)
PRINT(@sSQL2)
EXEC(@sSQL+@sSQL1+@sSQL2)











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
