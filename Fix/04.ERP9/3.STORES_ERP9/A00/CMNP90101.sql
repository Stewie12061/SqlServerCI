IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn nhà cung cấp
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường
----Modified on 11/08/2022 by Nhựt Trường: [2022/08/IS/0030] - Nếu User đăng nhập là ObjectID thuộc nhóm npp (IsDealer = 1) thì chỉ load dữ liệu thuộc ObjectID đó.
----Modified on 24/05/2023 by Anh Đô: Cập nhật điều kiện lọc
-- <Example>
/*
    EXEC CMNP90101 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE CMNP90101 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @UserID2 VARCHAR(50) =''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@All NVARCHAR(50) = N'Tất cả'

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'ObjectID, ObjectName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere + '
									AND (ObjectID LIKE N''%' + @TxtSearch + '%'' 
									OR ObjectName LIKE N''%' + @TxtSearch + '%'')'
	
	
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM (
				SELECT '''+@DivisionID+''' AS DivisionID, ''%'' AS ObjectID, N'''+@All+''' AS ObjectName, ''Dealer'' AS ObjectTypeID
				UNION ALL
				SELECT DivisionID, ObjectID, ObjectName, ''Dealer'' AS ObjectTypeID 
				FROM AT1202 WITH (NOLOCK)
				WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND IsDealer = 1
				'+@sWhere+' ) AT1202
				WHERE CASE WHEN '''+@UserID+''' IN (SELECT ObjectID FROM AT1202 WITH (NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND IsDealer = 1 AND Disabled = 0)
					THEN ObjectID ELSE '''+@UserID+''' END = '''+@UserID+'''
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
				'
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO