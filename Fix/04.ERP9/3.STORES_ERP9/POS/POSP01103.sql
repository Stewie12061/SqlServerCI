IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP01103]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP01103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn hội viên
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thị Phượng Date 09/08/2017
/*
	exec POSP01103 @DivisionID=N'MS',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE POSP01103 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
DECLARE @CustomerName INT
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

	
	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (MemberID LIKE N''%'+@TxtSearch+'%'' 
								OR MemberName LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'' 
								OR Email LIKE N''%'+@TxtSearch+'%'')'
	
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY MemberID, MemberName) AS RowNum, '+@TotalRow+' AS TotalRow, POST0011.APK,
	POST0011.DivisionID, MemberID, MemberName,
	Address,  Tel, Email, IsCommon, Disabled,  Description
    From POST0011 With (NOLOCK)
    WHERE  POST0011.Disabled =0
    AND POST0011.DivisionID in ( '''+@DivisionID+''',''@@@'') ' + @sWhere +'
    ORDER BY MemberID, MemberName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON