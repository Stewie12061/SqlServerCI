IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP9008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP9008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load grid chọn mặt hàng(CIF9008)
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by Hoài Bảo on 29/04/2022
 ----Modified by Hoài Bảo on 08/06/2022 - Bổ sung load thêm cột VATPercent
 ----Modified by Hoài Bảo on 27/06/2022 - Cập nhật điều kiện search ALL, bổ sung load AccountID
 ----Modified by Thanh Lượng on 16/10/2023 - Cập nhật bổ sung trường Specification
 /*-- <Example>
exec sp_executesql N'EXEC CIP9008 @DivisionID=N''DTI'',@UserID=N''ASOFTADMIN'',@PageNumber=N''1'',@PageSize=N''25'',@InventoryTypeID=N''CC'',@TxtSearch=N'''',
@ConditionIV=N'' (SELECT '''''''' AS DataID UNION ALL SELECT ''''#'''' AS DataID UNION ALL SELECT InventoryID FROM AT1302 WHERE DivisionID IN (''''DTI'''''''',''''''''@@@'''')) '',
@IsUsedConditionIV=''0=0''',N'@CreateUserID nvarchar(10),@LastModifyUserID nvarchar(10),@DivisionID nvarchar(3)',@CreateUserID=N'ASOFTADMIN',@LastModifyUserID=N'ASOFTADMIN',`@DivisionID=N'DTI'
 ----*/
 
CREATE PROCEDURE CIP9008
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @InventoryTypeID VARCHAR(50),
  @TxtSearch NVARCHAR(100),
  @ConditionIV NVARCHAR(1000),
  @IsUsedConditionIV NVARCHAR(1000)
) 
AS

DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sWhere2 NVARCHAR(MAX) = N'',
		@CustomerIndex INT

SELECT TOP 1 @CustomerIndex = CustomerName FROM CustomerIndex

IF ISNULL(@InventoryTypeID,'') <> '' AND @InventoryTypeID <> '%'
	SET @sWhere = ' AND AT1302.InventoryTypeID LIKE ''%'+@InventoryTypeID+'%'' '

IF ISNULL(@TxtSearch,'') <> ''
BEGIN
	SET @sWhere = N'AND (AT1302.InventoryID LIKE N''%'+@TxtSearch+'%'' OR AT1302.InventoryName LIKE N''%'+@TxtSearch+'%'')'
END

SET @OrderBy = N' InventoryID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY  InventoryID)) AS RowNum, COUNT(*) OVER () AS TotalRow, 
	AT1302.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1302.Specification, AT1304.UnitName, AT1301.InventoryTypeName as InventoryTypeID, 
	Convert(Decimal(28,8),0) AS EndQuantity, ISNULL(AT1302.IsSerialized,0) AS IsSerialized, AT1302.VATPercent,
	AT1302.SalePrice01, AT1302.DeliveryPrice, AT1302.IsStocked, AT1302.AccountID, AT1302.AccountID AS DebitAccountID, AT1302.RecievedPrice
	INTO #CIP9008_AT1302
	FROM AT1302 WITH (NOLOCK) 
	INNER JOIN AT1304 WITH (NOLOCK) ON AT1302.UnitID = AT1304.UnitID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1302.InventoryTypeID = AT1301.InventoryTypeID
	WHERE AT1302.Disabled = 0   
	AND (ISNULL(InventoryID, ''#'') IN '+@ConditionIV+' OR '+@IsUsedConditionIV+')
	AND AT1302.DivisionID in ('''+@DivisionID+''',''@@@'')
	'+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
	SET @sSQL1 = N'SELECT * FROM #CIP9008_AT1302'

PRINT(@sSQL)
PRINT(@sSQL1)
EXEC(@sSQL+@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
