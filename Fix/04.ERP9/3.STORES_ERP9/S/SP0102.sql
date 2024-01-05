IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Select luoi du lieu cho man hinh xem chi tiết
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Phạm Lê Hoàng, Date: 16/11/2020
-- <Example> EXEC SP0102 'KY', '', '', 'ST0020', 0, NULL

CREATE PROCEDURE SP0102 (
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@CodeMaster VARCHAR(50),
	@TableID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT
)
AS
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = '';
	DECLARE @SQL01 NVARCHAR(MAX)= '';
	DECLARE @SQL02 NVARCHAR(MAX)= '';
	DECLARE @SQL03 NVARCHAR(MAX)= '';
	
	SET @SQL01 = CASE WHEN EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = @TableID AND col.name = 'ID1') THEN  ' M.ID1 ' ELSE ' CAST(NULL AS VARCHAR(50)) ' END
	SET @SQL02 = CASE WHEN EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = @TableID AND col.name = 'OrderNo') THEN ' M.OrderNo ' ELSE ' CAST(NULL AS INT) ' END
	SET @SQL03 = CASE WHEN EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = @TableID AND col.name = 'LanguageID') THEN ' M.LanguageID ' ELSE ' CAST(NULL AS NVARCHAR(MAX)) ' END
	
	--SET @SQL = 'SELECT O.CodeMaster, O.ID, O.Description, O.DescriptionE, O.Disabled,
	--' + @SQL01 + ' AS ID1,
	--' + @SQL02 + ' AS OrderNo,
	--' + @SQL03 + ' AS LanguageID
	--FROM ' + @TableID + ' O WITH (NOLOCK)
	--WHERE CodeMaster = ''' + @CodeMaster + '''
	--ORDER BY ID;'

	SET @SQL = 'SELECT ROW_NUMBER() OVER (ORDER BY  M.ID) AS RowNum, COUNT(*) OVER () AS TotalRow, 
	M.CodeMaster, M.ID, M.Description, M.DescriptionE, M.Disabled,
	' + @SQL01 + ' AS ID1,
	' + @SQL02 + ' AS OrderNo,
	' + @SQL03 + ' AS LanguageID
	FROM ' + @TableID + ' AS M WITH (NOLOCK)
	WHERE M.CodeMaster = ''' + @CodeMaster + '''
	ORDER BY M.ID
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY'

	PRINT (@SQL)
	EXEC (@SQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
