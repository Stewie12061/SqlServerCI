IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Xóa dữ liệu ngầm
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Phạm Lê Hoàng, Date: 28/10/2020
-- Modified by Lê Hoàng on 03/11/2020 : các trường họp phân hệ đặc biệt thì bảng dữ liệu ngầm sẽ có mã khác ASOFTT - AT0099, ASOFTHRM - HT0099,..
-- <Example> EXEC SP0101 'KY', '', '', 'ST0020', 0, NULL

CREATE PROCEDURE SP0101 (
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX), 	-- ST0020
	@Mode TINYINT,				-- 0: Sửa, 1: Xóa
	@IsDisable TINYINT,
	@UserID VARCHAR(50))
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelModuleID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@CodeMaster VARCHAR(50),
						@TableName VARCHAR(50),
						@ModuleID VARCHAR(50)
				DECLARE @ST0020Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @ST0020Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT CodeMaster, ModuleID FROM ST0020 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelModuleID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					--EXEC OOP9000 @DelModuleID, NULL, ''' + @TableID + ''', @DelAPK, NULL, NULL, @Status OUTPUT
					
					--IF (SELECT @Status) = 1
					--		UPDATE @ST0020Temp SET Params = ISNULL(Params, '''') + @DelAPK + '', '' WHERE MessageID = ''00ML000052''
					--ELSE
					--	
					BEGIN
							SET @DelModuleID = CASE WHEN @DelModuleID = ''ASOFTT'' THEN ''ASOFTA''
													WHEN @DelModuleID = ''ASOFTOP'' THEN ''ASOFTO''
													WHEN @DelModuleID = ''ASOFTHRM'' THEN ''ASOFTH''
													ELSE @DelModuleID
											   END
							PRINT @DelModuleID
							-- Xóa thiết bị
							SET @TableName = CONCAT(REPLACE(@DelModuleID, ''ASOFT'', ''''),''T0099'')

							DELETE FROM ST0020 WHERE CAST(CodeMaster AS VARCHAR(50)) = @DelAPK AND ModuleID = @DelModuleID
							EXEC (''DELETE FROM '' + @TableName + '' WHERE CodeMaster = '''''' + @DelAPK + '''''''') 

					END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelModuleID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @ST0020Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
			PRINT(@sSQL)
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
