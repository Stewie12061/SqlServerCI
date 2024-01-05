IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load form TMF0010 - Danh mục thiết lập thời gian làm việc
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng on 17/03/2017
-- <Example>
/*
    EXEC OOP0030 'KY', '','' ,'', 'NV01', 1, 10 
*/

CREATE PROCEDURE [dbo].[OOP0030] ( 
   @DivisionID VARCHAR(50), 
   @YearID nvarchar(50),
   @FromDate DateTime,
   @ToDate DateTime,
   @UserID  VARCHAR(50),
   @PageNumber INT,
   @PageSize INT
   ) 
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ' 1 = 1 '
	SET @OrderBy = ' M.YearID '

	--Check Para DivisionIDList null then get DivisionID 
	IF isnull(@YearID, '') != ''
		SET @sWhere = @sWhere + ' AND M.YearID LIKE N''%'+@YearID+'%''  '
	
	IF isnull(@FromDate, '') != ''
		SET @sWhere = @sWhere + ' AND ( CONVERT(VARCHAR(10),M.FromDate,112) = '''+CONVERT(VARCHAR(10),@FromDate,112)+'''  or ('''+CONVERT(VARCHAR(10),@FromDate,112)+''' Between CONVERT(VARCHAR(10),M.FromDate,112) and CONVERT(VARCHAR(10),M.ToDate,112) ))'
	
	IF isnull(@ToDate, '') != ''
		SET @sWhere = @sWhere + ' AND ( CONVERT(VARCHAR(10),M.FromDate,112) = '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  or ('''+CONVERT(VARCHAR(10),@ToDate,112)+''' Between CONVERT(VARCHAR(10),M.FromDate,112) and CONVERT(VARCHAR(10),M.ToDate,112) ))'

SET @sSQL =	  ' SELECT M.APK, M.DivisionID, M.YearID, M.Description, M.FromDate, M.ToDate
				, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID 
				InTo #TempOOT0030
				FROM OOT0030 M WITH (NOLOCK) 
				WHERE '+@sWhere+'

				DECLARE @count int
				Select @count = Count(YearID) From #TempOOT0030

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow,
					M.APK, M.DivisionID, M.YearID, M.Description, M.FromDate, M.ToDate
					, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID 
				FROM #TempOOT0030 M
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
