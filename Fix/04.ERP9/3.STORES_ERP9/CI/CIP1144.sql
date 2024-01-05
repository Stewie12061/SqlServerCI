IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1144]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1144]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra xóa sửa danh mục kho hàng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 05/03/2018
-- <Example>
---- 
/*-- <Example>
	CIP1144 @DivisionID = 'CH', @APK = 'FA0EBCE7-3241-46BF-AD5D-D6A76C89E6E7', @FormID = 'CIF1140', @Mode = 1, @IsDisable = '', @UserID = ''
	
	CIP1144 @DivisionID, @APK, @FormID, @Mode, @IsDisable, @UserID
----*/

CREATE PROCEDURE CIP1144
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(MAX), 
	@FormID VARCHAR(50),
	@Mode TINYINT, --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, --1: Disable; 0: Enable
	@UserID NVARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N''
IF @Mode = 0 -- Kiểm tra trước khi sửa 
BEGIN
	IF @FormID = 'CIF1140' -- 
	BEGIN 
		SET @sSQL = '
		DECLARE @Cur CURSOR,
				@Params VARCHAR(50) = '''',
				@Params1 VARCHAR(50) = '''',
				@DelDivisionID VARCHAR(50),
				@DelWareHouseID VARCHAR(50),
				@DelIsCommon TINYINT
		SELECT @DelDivisionID = DivisionID, @DelWareHouseID = WareHouseID, @DelIsCommon = ISNULL(IsCommon, 0)
		FROM AT1303 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''
		IF (@DelDivisionID <> '''+@DivisionID+''' AND @DelIsCommon <> 1) 
		BEGIN 
			SET @Params = @DelWareHouseID
		END  
		SELECT 2 AS Status, ''00ML000050'' AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params, '''') <> ''''
		UNION ALL
		SELECT 2 AS Status, ''00ML000052'' AS MessageID, LEFT(@Params1, LEN(@Params1) -1) AS Params1, '''+@FormID+''' AS FormID WHERE ISNULL(@Params1, '''') <> ''''
		'
	END
END 
IF @Mode = 1 --Kiểm tra và xóa
BEGIN
	IF @FormID IN ('CIF1140', 'CIF1142') 
	BEGIN 
		SET @sSQL = '
		DECLARE @Cur CURSOR,
				@DelDivisionID VARCHAR(50),
				@DelWareHouseID VARCHAR(50),
				@DelAPK VARCHAR(50),
				@DelIsCommon TINYINT, 
				@Params VARCHAR(MAX) = '''', 
				@Params1 VARCHAR(MAX) = ''''
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT APK, DivisionID, WareHouseID, IsCommon 
		FROM AT1303 WITH (NOLOCK) WHERE APK IN ('''+@APK+''')
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelWareHouseID, @DelIsCommon
		WHILE @@FETCH_STATUS = 0	
		BEGIN
			IF (@DelDivisionID <> '''+@DivisionID+''' AND  ISNULL(@DelIsCommon, 0) <> 1)  -- Kiểm tra khác đơn vị và không dùng chung
			BEGIN
				SET @Params = ISNULL(@Params,'''') + @DelWareHouseID+'','' 
			END 
			ELSE IF EXISTS (SELECT TOP 1 1 FROM CIT1140 WITH (NOLOCK) WHERE DivisionID IN (@DelDivisionID, ''@@@'') AND WareHouseID = @DelWareHouseID
							UNION ALL
							SELECT TOP 1 1 FROM CIT1141 WITH (NOLOCK) WHERE APKMaster = @DelAPK
							)
			BEGIN 
				SET @Params1 = ISNULL(@Params1,'''') + @DelWareHouseID+'','' 
			END 
			ELSE
			BEGIN
				DELETE AT1303 WHERE APK = @DelAPK
				DELETE CIT1140 WHERE WareHouseID = @DelWareHouseID AND DivisionID IN ('''+@DivisionID+''', ''@@@'')
				DELETE CIT1141 WHERE APKMaster = @DelAPK
				DELETE CIT1142 WHERE WareHouseID = @DelWareHouseID AND DivisionID IN ('''+@DivisionID+''', ''@@@'')
			END	
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelWareHouseID, @DelIsCommon
		END 	
		CLOSE @Cur
		SELECT 2 AS Status, ''00ML000050'' AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params, '''') <> ''''
		UNION ALL
		SELECT 2 AS Status, ''00ML000052'' AS MessageID, LEFT(@Params1,LEN(@Params1) - 1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params1,'''') <> ''''
		'
	END
	ELSE IF @FormID = 'CIT1141' 
	BEGIN 
		SET @sSQL = '
		DECLARE @Cur CURSOR,
				@DelDivisionID VARCHAR(50),
				@DelLevelDetailID VARCHAR(50),
				@DelAPK VARCHAR(50),
				@DelIsCommon TINYINT, 
				@Params VARCHAR(MAX) = '''', 
				@Params1 VARCHAR(MAX) = ''''
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT APK, DivisionID, LevelDetailID, IsCommon 
		FROM CIT1141 WITH (NOLOCK) WHERE APK IN ('''+@APK+''')
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLevelDetailID, @DelIsCommon
		WHILE @@FETCH_STATUS = 0	
		BEGIN
			IF (@DelDivisionID <> '''+@DivisionID+''' AND  ISNULL(@DelIsCommon, 0) <> 1)  -- Kiểm tra khác đơn vị và không dùng chung
			BEGIN
				SET @Params = ISNULL(@Params,'''') + @DelLevelDetailID+'','' 
			END 
			ELSE
			BEGIN
				DELETE CIT1142 WHERE APK = @DelAPK
			END	
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLevelDetailID, @DelIsCommon
		END 	
		CLOSE @Cur
		SELECT 2 AS Status, ''00ML000050'' AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params, '''') <> ''''
		UNION ALL
		SELECT 2 AS Status, ''00ML000052'' AS MessageID, LEFT(@Params1,LEN(@Params1) - 1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params1,'''') <> ''''
		'
	END
END 
IF @Mode = 2 --Kiểm tra trước khi sửa Check Disable/Enable
BEGIN
	IF @FormID = 'CIF1140' 
	BEGIN
		SET @sSQL = N'
		DECLARE @Cur CURSOR,
				@DelDivisionID VARCHAR(50),
				@DelAPK VARCHAR(50),
				@DelWareHouseID VARCHAR(50),
				@DelIsCommon TINYINT, 
				@Params VARCHAR(MAX) = '''', 
				@Params1 VARCHAR(MAX) = ''''
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT APK, DivisionID, StatusErrorID, IsCommon 
		FROM AT1303 WITH (NOLOCK) WHERE APK IN ('''+@APK+''')
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelWareHouseID, @DelIsCommon
		WHILE @@FETCH_STATUS = 0	
		BEGIN
			IF (@DelDivisionID <> '''+@DivisionID+''' AND  ISNULL(@DelIsCommon, 0) <> 1)   -- Kiểm tra khác đơn vị và không dùng chung
				BEGIN
					SET @Params = ISNULL(@Params,'''') + @DelWareHouseID+'','' 
				END
			ELSE
			BEGIN
				IF '+ CAST(@IsDisable AS VARCHAR(50)) +'=1 -- Nếu chọn là Disable
				BEGIN
					UPDATE AT1303 SET Disabled = 1 WHERE APK = @DelAPK
				END		
				ELSE  -- Nếu chọn là Enable
				BEGIN
					UPDATE AT1303 SET Disabled = 0 WHERE APK = @DelAPK 	
				END
			END	
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelWareHouseID, @DelIsCommon
		END 	
		CLOSE @Cur
		SELECT 2 AS Status, ''00ML000050'' AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params, '''') <> ''''
		UNION ALL 
		SELECT 2 AS Status, ''00ML000052'' AS MessageID, LEFT(@Params1, LEN(@Params1) -1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params1, '''') <> ''''
		'							
	END 
END
--PRINT(@sSQL)
EXEC (@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
