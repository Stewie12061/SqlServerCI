------------------------------------------------------------------------------------------------------
-- Fix Bổ sung dữ liệu ngầm cho các Module
------------------------------------------------------------------------------------------------------
-- Store Insert dữ liệu vào Table dữ liệu ngầm
------------------------------------------------------------------------------------------------------
-- create by Lê Hoàng Date 12/11/2020
-- Thêm dữ liệu vào bảng Master
-- Modify by Hoài Bảo ON 28/07/2021: Bổ sung cột [CodeMasterName] diễn giải cho [CodeMaster].
-- EXEC AddDataMasterERP9 @TableID,@CodeMaster,@ID,@ID1,@OrderNo,@Description,@DescriptionE,@Disabled,@LanguageID,@CodeMasterName

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AddDataMasterERP9]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AddDataMasterERP9]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE AddDataMasterERP9
(
    @TableID NVARCHAR(4000),
    @CodeMaster VARCHAR(50) = NULL, 
	@ID VARCHAR(50) = NULL, 
	@ID1 VARCHAR(50) = NULL, 
	@OrderNo INT = NULL,
	@Description NVARCHAR(MAX) = NULL, 
	@DescriptionE NVARCHAR(MAX) = NULL, 
	@Disabled TINYINT = NULL, 
	@LanguageID VARCHAR(50) = NULL,
	@CodeMasterName NVARCHAR(MAX) = NULL
)
AS

	--lấy danh sách các cột 
	DECLARE @NAMES VARCHAR(MAX) --cột ở insert 
	DECLARE @NAMES1 VARCHAR(MAX) --cột ở values
	DECLARE @sqlUpdate VARCHAR(MAX) --cột ở update
	SELECT @NAMES = COALESCE(@NAMES + ', ', '') + col.name
	FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = @TableID ORDER BY colorder
	SELECT @NAMES1 = COALESCE(@NAMES1 + ', ', '') + CONCAT('@', col.name) 
	FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = @TableID ORDER BY colorder
	SELECT @sqlUpdate = COALESCE(@sqlUpdate + ', ', '') + col.name + ' = ' + CONCAT('@', col.name) 
	FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = @TableID AND col.name NOT IN ('ID','CodeMaster')
	--
	DECLARE @sSQL NVARCHAR(MAX) = ''

	SET @sSQL = '

	DECLARE @CodeMaster VARCHAR(50) = NULL, 
			@OrderNo INT = NULL, 
			@ID VARCHAR(50) = NULL, 
			@ID1 VARCHAR(50) = NULL, 
			@Description NVARCHAR(MAX) = NULL, 
			@DescriptionE NVARCHAR(MAX) = NULL, 
			@Disabled TINYINT = NULL, 
			@LanguageID VARCHAR(50) = NULL,
			@CodeMasterName NVARCHAR(MAX) = NULL

	SET @CodeMaster = ' + (CASE WHEN @CodeMaster IS NULL THEN 'CAST(NULL AS NVARCHAR(MAX))' ELSE 'N'''+@CodeMaster+'''' END) + ' 
	SET @OrderNo = ' + (CASE WHEN @OrderNo IS NULL THEN 'NULL' ELSE STR(@OrderNo) END) + ' 
	SET @ID = ' + (CASE WHEN @ID IS NULL THEN 'NULL' ELSE ''''+@ID+'''' END) + ' 
	SET @ID1 = ' + (CASE WHEN @ID1 IS NULL THEN 'NULL' ELSE ''''+@ID1+'''' END) + ' 
	SET @Description = ' + (CASE WHEN @Description IS NULL THEN 'CAST(NULL AS NVARCHAR(MAX))' ELSE 'N'''+@Description+'''' END) + ' 
	SET @DescriptionE = ' + (CASE WHEN @DescriptionE IS NULL THEN 'CAST(NULL AS NVARCHAR(MAX))' ELSE 'N'''+@DescriptionE+'''' END) + ' 
	SET @Disabled = ' + (CASE WHEN @Disabled IS NULL THEN 'NULL' ELSE STR(@Disabled) END) + ' 
	SET @LanguageID = ' + (CASE WHEN @LanguageID IS NULL THEN 'CAST(NULL AS NVARCHAR(MAX))' ELSE 'N'''+@LanguageID+'''' END) + ' 
	SET @CodeMasterName = ' + (CASE WHEN @CodeMasterName IS NULL THEN 'CAST(NULL AS NVARCHAR(MAX))' ELSE 'N'''+@CodeMasterName+'''' END) + ' 

	IF NOT EXISTS (SELECT TOP 1 1 FROM ' + @TableID + ' WHERE CodeMaster = @CodeMaster AND ID = @ID) 
	BEGIN
		INSERT INTO ' + @TableID + ' (' + @NAMES + ') 
		VALUES (' + @NAMES1 + ') 
	END
	ELSE 
	BEGIN
		UPDATE ' + @TableID + ' 
		SET ' + @sqlUpdate + '
		WHERE CodeMaster = @CodeMaster AND ID = @ID 
	END'

	--PRINT (@sSQL)
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO