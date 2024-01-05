IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE PROCEDURE [dbo].[OOP2091] (
	@DivisionID VARCHAR(50), 	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50), 		-- "OOT1001"	
	@Mode TINYINT, 				-- 0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPKID VARCHAR(50), 
						@DelInformName NVARCHAR(250)
				DECLARE @OOT2090Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT2090Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, InformName FROM OOT2090 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelInformName
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelAPKID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT2090Temp SET Params = ISNULL(Params, '''') + @DelInformName + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT2090Temp SET Params = ISNULL(Params, '''') + @DelInformName + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								-- Xóa thông báo chung trong bảng OOT9002 và OOT9003
								EXEC OOP9002 @APK = @DelAPKID
								-- Xóa thông báo trong bảng OOT2090
								UPDATE OOT2090 SET DeleteFlag = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
								-- Xóa nhân viên trong bảng OOT0098
								DELETE FROM OOT0098 WHERE APKRel = @DelAPKID
						END					
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelInformName
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT2090Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			-- PRINT (@sSQL)
	END
	ELSE IF @Mode = 0 -- Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Params VARCHAR(100), 
						@DelDivisionID VARCHAR(50), 
						@DelInformName NVARCHAR(250)
				DECLARE @OOT2090Temp TABLE (
								Status TINYINT, 
								MessageID VARCHAR(100), 
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelInformName = InformName
				FROM OOT2090 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = ''' + @APK + '''			
				IF (@DelDivisionID != ''' + @DivisionID + ''') -- Kiểm tra khac DivisionID và không dùng chung
							BEGIN
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelInformName
							END 
				INSERT INTO @OOT2090Temp (Status, MessageID, Params)
				SELECT @Status AS Status, @Message AS MessageID, @Params AS Params
				SELECT Status, MessageID, Params FROM @OOT2090Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2 -- Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPKID VARCHAR(50), 
						@DelInformName NVARCHAR(250)
				DECLARE @OOT2090Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params VARCHAR(4000), 
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT2090Temp (Status, MessageID, Params, UpdateSuccess) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params, NULL AS UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, InformName FROM OOT2090 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelInformName
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT2090Temp SET Params = ISNULL(Params, '''') + @DelInformName + '', ''
					ELSE 
					BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + ' = 1 -- Nếu chọn là Disable
							UPDATE OOT2090 SET Disabled = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID		
						ELSE -- Nếu chọn là Enable
							UPDATE OOT2090 SET Disabled = 0 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID			
					-- Lưu lịch sử khi Disable/Enable		
						UPDATE @OOT2090Temp SET UpdateSuccess = ISNULL(UpdateSuccess, '''') + @DelAPKID + '', ''
					END
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelInformName
				END
				CLOSE @Cur
				IF ((SELECT Params FROM @OOT2090Temp) IS NULL)
				BEGIN
					UPDATE @OOT2090Temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params, LEFT(UpdateSuccess, LEN(UpdateSuccess) - 1) AS UpdateSuccess
				FROM @OOT2090Temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
			EXEC (@sSQL)
	END
END









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
