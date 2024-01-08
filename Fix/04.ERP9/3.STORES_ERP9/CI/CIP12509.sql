IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12509]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP12509]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load grid chọn Bảng giá dự kiến()
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by Thanh Lượng on 07/27/2023
 /*-- <Example>
 EXEC CIP12509 @DivisionID = 'Gree-SI', @UserID = '', @TranMonth=12, @TranYear=2023,@PageNumber = 1, @PageSize = 25, @WarehouseID = '', @InventoryTypeID = 'KHO',@IsSerialized = 0, @FormID = 'SOF1259', 
 @TxtSearch = 'a', @ConditionIV = N'('''')', @IsUsedConditionIV= N' (0=0) '
 ----*/
 
CREATE PROCEDURE CIP12509
( 
  @DivisionID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @TranMonth INT,
  @TranYear INT,
  @InventoryTypeID VARCHAR(50) = '',
  @TxtSearch NVARCHAR(100)
) 
AS

DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'', 
		@sSQL2 NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N''

IF ISNULL(@TxtSearch,'') <> ''
BEGIN
	SET @sWhere = N'AND (ID LIKE ''%'+@TxtSearch+'%'' OR Description LIKE ''%'+@TxtSearch+'%'')'
END
SET @OrderBy = N'ID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N' 
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,  '+@TotalRow+' AS TotalRow
					  ,* From CIT1550
				WHERE 1=1' + @sWhere + '
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	
PRINT(@sSQL)

EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
