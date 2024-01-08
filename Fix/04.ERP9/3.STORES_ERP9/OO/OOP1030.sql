IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load form TMF102 - Danh mục bước
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng on 03/10/2017
-- <Example>
/*
    EXEC OOP1030 'KY','','','', '','' ,'NV01', 1, 10 
*/

CREATE PROCEDURE OOP1030 
( 
		@DivisionID VARCHAR(50), 
		@DivisionIDList NVARCHAR(MAX), 
		@StepID varchar(50),
		@StepName Nvarchar(250),
		@ProcessID nvarchar(250),
		@Disabled nvarchar(100),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
   ) 
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.Orders, M.ProcessID '
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID = '''+ @DivisionID+''' )'		

	IF isnull(@ProcessID, '') != ''
		SET @sWhere = @sWhere + ' AND ( M.ProcessID LIKE N''%'+@ProcessID+'%''  Or  A2.ProcessName LIKE N''%'+@ProcessID+'%'') '
	
	IF isnull(@Disabled,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
	IF isnull(@StepID,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.StepID,'''') LIKE N''%'+@StepID+'%''  '

	IF isnull(@StepName,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.StepName,'''') LIKE N''%'+@StepName+'%''  '

SET @sSQL =	  ' SELECT M.DivisionID, M.StepID, M.StepName, M.ProcessID, A2.ProcessName, M.Description
				, M.Disabled, M.APK, M.Orders
				, M.CreateDate, M.CreateUserID
				, M.LastModifyDate, M.LastModifyUserID
				Into #TempOOT1030
				FROM OOT1030 M WITH (NOLOCK) 
				LEFT JOIN OOT1020 A2 WITH (NOLOCK) ON A2.ProcessID = M.ProcessID  
				WHERE '+@sWhere+'

				DECLARE @count int
				Select @count = Count(StepID) From #TempOOT1030

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow, M.APK,
				M.DivisionID, M.StepID, M.StepName, M.ProcessID, M.ProcessName, M.Description
				, M.Disabled, M.Orders
				, M.CreateDate, M.CreateUserID
				, M.LastModifyDate, M.LastModifyUserID
				FROM #TempOOT1030 M
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
--print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
