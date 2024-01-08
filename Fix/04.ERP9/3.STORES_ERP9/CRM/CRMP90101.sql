IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90101]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP90101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn sự kiện
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 30/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
-- <Example>
/*

	exec 
	CRMP90101 @DivisionID=N'AS',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10', @ConditionEventID= N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'

*/

 CREATE PROCEDURE CRMP90101 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionEventID nvarchar(max)
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
	SET @OrderBy = ' x.EventID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (A.EventSubject LIKE N''%'+@TxtSearch+'%'' 
							OR A.Description LIKE N''%'+@TxtSearch+'%'' 
							OR A.EventStartDate LIKE N''%'+@TxtSearch+'%'' 
							OR A.EventEndDate LIKE N''%'+@TxtSearch+'%'' 
							OR B.Description LIKE N''%'+@TxtSearch+'%'' 
							OR C.Description LIKE N''%'+@TxtSearch+'%''
							OR D.Description LIKE N''%'+@TxtSearch+'%'')'
	IF Isnull(@ConditionEventID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(F.UserID, A.CreateUserID) in (N'''+@ConditionEventID+''' )'
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
				From
							(Select Distinct  A.EventID, A.DivisionID
							, A.EventSubject, A.Description
							, A.EventStartDate, A.EventEndDate
							, C.Description as TypeActive
							, A.PriorityID
							, A.Location
							, A.RelatedToTypeID, A.APK
							, Case when A.TypeID = 1 then B.Description else D.Description end as EventStatus
							, A.TypeID, E.Description as TypeName
				FROM CRMT90051 A WITH (NOLOCK)
				Left join AT1103_REL F WITH (NOLOCK) ON F.RelatedToID =convert(Varchar(50),A.EventID)
				Left join CRMT0099 B  WITH (NOLOCK) On A.EventStatus = B.ID and B.CodeMaster =''CRMT00000017''
				Left join CRMT0099 D  WITH (NOLOCK) On A.EventStatus = D.ID and D.CodeMaster =''CRMT00000003''
				Left join CRMT0099 C  WITH (NOLOCK) On A.TypeActive = C.ID and C.CodeMaster =''CRMT00000005''
				Left join CRMT0099 E  WITH (NOLOCK) On A.TypeID = E.ID and E.CodeMaster =''CRMT00000018''
				WHERE A.DivisionID = '''+@DivisionID+''' and DeleteFlg = 0  '+@sWhere+')x
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
