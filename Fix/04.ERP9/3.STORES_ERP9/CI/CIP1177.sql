IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1177]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1177]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Chọn dự án 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 16/08/2018
-- <Example>
---- 
/*-- <Example>
	CIP1177 @DivisionID = 'AS', @UserID = '', @PageNumber = 1, @PageSize = 25, @txtSearch = '', @ScreenID = 'CIF1176',@AnaTypeID=N'A01'
	
	CIP1177 @DivisionID, @UserID, @PageNumber, @PageSize, @XML
----*/
CREATE PROCEDURE CIP1177
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @txtSearch NVARCHAR(100), 
	 @ScreenID VARCHAR(50)


)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N''

SET @OrderBy = N'T1.AnaID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
AND (AnaID LIKE N''%'+@txtSearch+'%'' OR AnaName LIKE N''%'+@txtSearch+'%'')'

IF @ScreenID IN ('CIF1176')
	BEGIN 
		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.AnaID, T1.AnaName
		FROM AT1011 T1 WITH (NOLOCK) 
		INNER JOIN CIT1176 T2 WITH (NOLOCK) ON T2.ASCProjectID=T1.AnaID AND T1.AnaTypeID = ''A05''
		WHERE T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND  AnaTypeID = ''A05''
		'+@sWhere+'
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END 
--PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
