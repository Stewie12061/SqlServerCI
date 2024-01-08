IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[OOP1051] (
	@DivisionID VARCHAR(50), 	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50), 		-- OOT1050
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
						@DelProjectSampleID NVARCHAR(250)
				DECLARE @OOT1050Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1050Temp (Status, MessageID, Params)
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
				UNION ALL
				SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params

				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProjectSampleID FROM OOT1050 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProjectSampleID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPKID, @DelProjectSampleID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT1050Temp SET Params = ISNULL(Params, '''') + @DelProjectSampleID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT1050Temp SET Params = ISNULL(Params, '''') + @DelProjectSampleID + '', '' WHERE MessageID = ''00ML000052''
					ELSE
						BEGIN
							DELETE FROM OOT1050 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
							DELETE FROM OOT1051 WHERE APKMaster = @DelAPKID
						END
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProjectSampleID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT1050Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
			-- PRINT(@sSQL)
	END
	ELSE IF @Mode = 0 -- Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params VARCHAR(100),
						@DelDivisionID VARCHAR(50),
						@DelProjectSampleID NVARCHAR(250)
				DECLARE @OOT1050Temp TABLE (
								Status TINYINT,
								MessageID VARCHAR(100),
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelProjectSampleID = ProjectSampleID
				FROM OOT1050 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = ''' + @APK + '''
				IF (@DelDivisionID !=''' + @DivisionID + ''') -- Kiểm tra khác DivisionID và không dùng chung
					BEGIN
						SET @Message = ''00ML000050''
						SET	@Status = 2
						SET @Params = @DelProjectSampleID
					END
				INSERT INTO @OOT1050Temp (Status, MessageID, Params) SELECT @Status AS Status, @Message AS MessageID, @Params AS Params
				SELECT Status, MessageID, Params FROM @OOT1050Temp WHERE Params IS NOT NULL'
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
						@DelProjectSampleID NVARCHAR(250)
				DECLARE @OOT1050Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params VARCHAR(4000),
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1050Temp (Status, MessageID, Params, UpdateSuccess)
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params, NULL AS UpdateSuccess

				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProjectSampleID FROM OOT1050 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProjectSampleID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''')
						UPDATE @OOT1050Temp SET Params = ISNULL(Params, '''') + @DelProjectSampleID + '', ''
					ELSE
					BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + '=1 -- Nếu chọn là Disable
							UPDATE OOT1050 SET Disabled = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
						ELSE -- Nếu chọn là Enable
							UPDATE OOT1050 SET Disabled = 0 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
						-- Lưu lịch sử khi Disable/Enable
						UPDATE @OOT1050Temp SET UpdateSuccess = ISNULL(UpdateSuccess, '''') + @DelAPKID + '', ''
					END
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProjectSampleID
				END
				CLOSE @Cur
				IF ((SELECT Params FROM @OOT1050Temp) is NULL)
				BEGIN
					UPDATE @OOT1050Temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params, LEFT(UpdateSuccess, LEN(UpdateSuccess) - 1) AS UpdateSuccess
				FROM @OOT1050Temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
		-- PRINT (@sSQL)
		EXEC (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
