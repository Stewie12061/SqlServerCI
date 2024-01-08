IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP9007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP9007]
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
----Created by: Như Hàn on 06/12/2018
-- <Example>
---- 
/*-- <Example>
	exec sp_executesql N'CMNP9007 @DivisionID=N''AIC'',@TxtSearch=N'''',@UserID=N''ASOFTADMIN'',@PageNumber=N''1'',@PageSize=N''100'',@ScreenID=N''CIF1176''',N'@CreateUserID nvarchar(10),@LastModifyUserID nvarchar(10),@DivisionID nvarchar(3)',@CreateUserID=N'ASOFTADMIN',@LastModifyUserID=N'ASOFTADMIN',@DivisionID=N'AIC'
	CMNP9007 
----*/
CREATE PROCEDURE CMNP9007
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

SET @OrderBy = N'AnaID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
AND (AnaID LIKE N''%'+@txtSearch+'%'' OR AnaName LIKE N''%'+@txtSearch+'%'')'

IF @ScreenID IN ('CIF1176', 'POF2033')
	BEGIN 
		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		AnaID,AnaName, T76.ASCProJBeginDate As BeginDate , T76.ASCProJEndDate As EndDate
		FROM AT1011 WITH (NOLOCK) 
		INNER JOIN (SELECT DISTINCT ASCProjectID, ASCProJBeginDate, ASCProJEndDate from CIT1176 WITH (NOLOCK)) T76 ON T76.ASCProjectID = AT1011.AnaID AND AT1011.AnaTypeID = ''A05''
		WHERE AT1011.DivisionID IN ('''+@DivisionID+''', ''@@@'')
		'+@sWhere+'
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END 
------PRINT @sSQL
 EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
