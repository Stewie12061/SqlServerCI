IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP9010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP9010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn quy cách
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo Date 23/06/2022
-- <Example>
/*
	EXEC CIP9010 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@StandardTypeID=N'',@PageNumber=N'1',@PageSize=N'25'
*/

 CREATE PROCEDURE CIP9010 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @StandardTypeID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF ISNULL(@StandardTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND StandardTypeID = ''' +@StandardTypeID+ ''' '
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (AT0128.StandardID LIKE N''%'+@TxtSearch+'%'' 
								OR AT0128.StandardName LIKE N''%'+@TxtSearch+'%'' 
								OR AT0128.StandardTypeID LIKE N''%'+@TxtSearch+'%'' 
								OR AT0128.Notes LIKE N''%'+@TxtSearch+'%'')'

		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY StandardID) AS RowNum, '+@TotalRow+' AS TotalRow
			   , APK, DivisionID, StandardID, StandardName, StandardTypeID, Notes, [Disabled], IsCommon
		FROM AT0128 WITH (NOLOCK)  
		WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND ISNULL([Disabled], 0) = 0
		' + @sWhere + '
		ORDER BY StandardID
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	
PRINT (@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO