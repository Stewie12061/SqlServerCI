IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn nguyen lieu/ dich vu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>/
----Created by: Trà Giang on 18/09/2018
-- <Example>
/*
    EXEC NMP2034 'BS', '',null,1,25,1
*/

 CREATE PROCEDURE NMP2034 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @Type VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 


	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'InventoryID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
									AND (InventoryID LIKE N''%'+@TxtSearch+'%'' '
									
	IF @Type =0
	BEGIN
	
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, APK
							, DivisionID,  InventoryID, InventoryName
						
				FROM AT1302 N
				WHERE DivisionID  IN ('''+@DivisionID+''' ,''@@@'') and IsStocked=0 
						  '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
				END
				ELSE
		SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, APK
							, DivisionID,  InventoryID, InventoryName
						
				FROM AT1302 N
				WHERE DivisionID  IN ('''+@DivisionID+''' ,''@@@'') and IsStocked=1
				  '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
