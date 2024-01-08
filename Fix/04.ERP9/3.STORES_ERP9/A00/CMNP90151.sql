IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90151]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- ANGEL: Load màn hình chọn khu vực
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường
----Modified on 24/05/2023 by Anh Đô: Cập nhật điều kiện lọc
-- <Example>
/*
    EXEC CMNP90151 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE CMNP90151 (
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
	SET @OrderBy = 'AnaID, AnaName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere + '
									AND (AnaID LIKE N''%' + @TxtSearch + '%'' 
									OR AnaName LIKE N''%' + @TxtSearch + '%'')'
	
	
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM (
				SELECT '''+@DivisionID+''' AS DivisionID, ''%'' AS AnaID, N'''+@All+''' AS AnaName
				UNION ALL
				
				SELECT DivisionID, AnaID, AnaName
				FROM AT1015 WITH (NOLOCK)
				WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND [Disabled] = 0 AND AnaTypeID =''I04''	
				'+@sWhere+' ) AT1015
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
