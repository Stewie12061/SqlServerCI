IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12702]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP12702]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load grid chọn loại đối tượng(CIF1273)
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by Hoài Bảo on 13/06/2022
 ----Modified by ...
-- <Example>
/*
	EXEC CIP12702 @DivisionID=N''DTI'',@UserID=N''ASOFTADMIN'',@PageNumber=N''1'',@PageSize=N''25'',@TxtSearch=N''''
*/
 
CREATE PROCEDURE CIP12702
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @TxtSearch NVARCHAR(100)
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',  
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N''

IF ISNULL(@TxtSearch,'') <> ''
BEGIN
	SET @sWhere = N'AND (ObjectTypeID LIKE ''%'+@TxtSearch+'%'' OR ObjectTypeName LIKE ''%'+@TxtSearch+'%'')'
END
SET @OrderBy = N' ObjectTypeID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY  ObjectTypeID)) AS RowNum, COUNT(*) OVER () AS TotalRow, 
	AT1201.DivisionID, AT1201.ObjectTypeID, AT1201.ObjectTypeName, AT1201.IsCommon, AT1201.[Disabled]
	FROM AT1201 WITH (NOLOCK)
	WHERE AT1201.Disabled = 0 AND AT1201.DivisionID IN ('''+@DivisionID+''',''@@@'')
	'+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'

PRINT(@sSQL)
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO