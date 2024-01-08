IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Select luoi du lieu cho man hinh cap nhat
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Phạm Lê Hoàng, Date: 16/11/2020
-- <Example> EXEC SP0100 'KY', '', '', 'ST0020', 0, NULL

CREATE PROCEDURE SP0100 (
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@CodeMaster VARCHAR(50),
	@TableID VARCHAR(50)
)
AS
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = '';
	DECLARE @SQL01 NVARCHAR(MAX)= '';
	DECLARE @SQL02 NVARCHAR(MAX)= '';
	DECLARE @SQL03 NVARCHAR(MAX)= '';
	
	SET @SQL01 = CASE WHEN EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = @TableID AND col.name = 'ID1') THEN  'O.ID1 ' ELSE ' CAST(NULL AS VARCHAR(50)) ' END
	SET @SQL02 = CASE WHEN EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = @TableID AND col.name = 'OrderNo') THEN ' O.OrderNo ' ELSE ' CAST(NULL AS INT) ' END
	SET @SQL03 = CASE WHEN EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = @TableID AND col.name = 'LanguageID') THEN ' O.LanguageID ' ELSE ' CAST(NULL AS NVARCHAR(MAX)) ' END
	
	SET @SQL = 'SELECT O.CodeMaster, O.ID, O.Description, O.DescriptionE, O.Disabled,
	' + @SQL01 + ' AS ID1,
	' + @SQL02 + ' AS OrderNo,
	' + @SQL03 + ' AS LanguageID
	FROM ' + @TableID + ' O WITH (NOLOCK)
	WHERE CodeMaster = ''' + @CodeMaster + '''
	ORDER BY ID;'
	PRINT (@SQL)
	EXEC (@SQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
