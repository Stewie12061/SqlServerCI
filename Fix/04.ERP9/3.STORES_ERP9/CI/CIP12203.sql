IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP12203') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP12203
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12203 Danh mục quốc gia
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 25/04/2016
-- <Example>
----    EXEC CIP12203 '','AS'',''Q7','','', 'ASOFTADMIN', 1, 10

CREATE PROCEDURE CIP12203 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @AreaID nvarchar(50),
        @AreaName nvarchar(100),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'A.CreateDate DESC'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + '(A.DivisionID = '''+ @DivisionID+''' or IsCommon =1)  '
	Else 
		SET @sWhere = @sWhere + '(A.DivisionID IN ('''+@DivisionIDList+''')or IsCommon =1) '
	IF @AreaID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.AreaID LIKE N''%'+@AreaID+'%'' '
	IF @AreaName IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.AreaName LIKE N''%'+@AreaName+'%'' '
SET @sSQL = '
	SELECT count(*) OVER() as TotalRow, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,
	A.APK, Case when A.DivisionID =''@@@'' then '''' else A.DivisionID end as DivisionID
	, A.AreaID, A.AreaName, A.[Disabled],  A.IsCommon, A.CreateDate, A.CreateUserID
    FROM AT1003 A
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'

EXEC (@sSQL)
