IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90111]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP90111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn nhiệm vụ
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 30/03/2017
-- <Example>
/*

	exec sp_executesql N'CRMP90111 @DivisionID=N''AS'',@TxtSearch=N'''',@UserID=N''CALL002'',@PageNumber=N''1'',@PageSize=N''10''',N'@CreateUserID nvarchar(7),@LastModifyUserID nvarchar(7),@DivisionID nvarchar(2)',@CreateUserID=N'CALL002',@LastModifyUserID=N'CALL002',@DivisionID=N'AS'

*/

 CREATE PROCEDURE CRMP90111 (
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
	SET @OrderBy = ' A.TaskID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
							AND (A.Title LIKE N''%'+@TxtSearch+'%'' 
							OR A.Description LIKE N''%'+@TxtSearch+'%'' 
							OR A.StartDate LIKE N''%'+@TxtSearch+'%'' 
							OR A.EndDate LIKE N''%'+@TxtSearch+'%'' 
							OR B.Description LIKE N''%'+@TxtSearch + '%'' 
							OR C.Description LIKE N''%'+@TxtSearch+'%'')'
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, A.TaskID, A.DivisionID
							, A.Title, A.Description
							, A.StartDate, A.EndDate
							, B.Description as TaskStatus
							, C.Description as TypeActive
							, A.PriorityID
							, A.AssignedToUserID
							, A.RelatedToTypeID, A.APK
				FROM CRMT90041 A WITH (NOLOCK)
				Left join CRMT0099 B  WITH (NOLOCK) On A.TaskStatus = B.ID and B.CodeMaster =''CRMT00000003''
				Left join CRMT0099 C  WITH (NOLOCK) On A.TypeActive = C.ID and C.CodeMaster =''CRMT00000005''
				WHERE A.DivisionID = '''+@DivisionID+''' and DeleteFlg = 0  '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
