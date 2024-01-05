IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách thông báo
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 26/06/2017
-- <Example> EXEC OOP1021 'AS', '', '', 'OOT1020', 2, 0, NULL

CREATE PROCEDURE [dbo].[OOP1021] ( 
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50),			-- Trường hợp sửa
	@APKList NVARCHAR(MAX),		-- Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50),		-- OOT1020	
	@Mode TINYINT,				-- 0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT,		-- 1: Disable; 0: Enable
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
						@DelProcessID NVARCHAR(250), 
						@DelIsCommon TINYINT
				DECLARE @OOT1020Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1020Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProcessID, IsCommon FROM OOT1020 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProcessID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPKID, @DelProcessID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1)
						UPDATE @OOT1020Temp SET Params = ISNULL(Params, '''') + @DelProcessID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
						UPDATE @OOT1020Temp SET Params = ISNULL(Params, '''') + @DelProcessID + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						DELETE FROM OOT1020 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
						DELETE FROM OOT1021 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPKID
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProcessID, @DelIsCommon
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT1020Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
			-- PRINT (@sSQL)
	END
	ELSE IF @Mode = 0 -- Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Params VARCHAR(100), 
						@DelDivisionID VARCHAR(50), 
						@DelProcessID NVARCHAR(250), 
						@DelIsCommon TINYINT
				DECLARE @OOT1020Temp TABLE (
								Status TINYINT, 
								MessageID VARCHAR(100), 
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelProcessID = ProcessID, @DelIsCommon = IsNULL(IsCommon, 0)
				FROM OOT1020 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = ''' + @APK + '''			
				IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1) -- Kiểm tra khác DivisionID và không dùng chung
							BEGIN
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelProcessID
							END 
				INSERT INTO @OOT1020Temp (Status, MessageID, Params)
				SELECT @Status AS Status, @Message AS MessageID, @Params AS Params 			
				
				SELECT Status, MessageID, Params FROM @OOT1020Temp WHERE Params IS NOT NULL'
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
						@DelProcessID NVARCHAR(250), 
						@DelIsCommon TINYINT
				DECLARE @OOT1020Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params VARCHAR(4000), 
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1020Temp (Status, MessageID, Params, UpdateSuccess) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params, NULL AS UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProcessID, IsCommon FROM OOT1020 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProcessID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1)
						UPDATE @OOT1020Temp SET Params = ISNULL(Params, '''') + @DelProcessID + '', ''
					ELSE 
					BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + ' = 1 -- Nếu chọn là Disable
							UPDATE OOT1020 SET Disabled = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID		
						ELSE -- Nếu chọn là Enable
							UPDATE OOT1020 SET Disabled = 0 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID			
						-- Lưu lịch sử khi Disable/Enable		
						UPDATE @OOT1020Temp SET UpdateSuccess = ISNULL(UpdateSuccess, '''') + @DelAPKID + '', ''
					END
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelProcessID, @DelIsCommon
				END
				CLOSE @Cur
				IF ((SELECT Params FROM @OOT1020Temp) IS NULL)
				BEGIN
					UPDATE @OOT1020Temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params, LEFT(UpdateSuccess, LEN(UpdateSuccess) - 1) AS UpdateSuccess
				FROM @OOT1020Temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
				-- PRINT (@sSQL)
			EXEC(@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
