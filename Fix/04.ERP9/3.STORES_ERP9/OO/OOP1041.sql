IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách trạng thái
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 26/06/2017
-- <Example> EXEC OOP1041 'AS', '', '', 'OOT1040', 2, 0, NULL

CREATE PROCEDURE OOP1041 (
	@DivisionID VARCHAR(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 		--Trường hợp sửa
	@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50), 	-- "OOT1040"	
	@Mode TINYINT, 			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, 	--1: Disable; 0: Enable
	@UserID VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKID VARCHAR(50),
						@DelStatusID NVARCHAR(250),
						@DelIsCommon TINYINT
				DECLARE @OOT1040temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1040temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
											UNION ALL
											-- {0} là Trạng thái của hệ thống, bạn không thể Sửa/Xóa!
											SELECT 2 AS Status, ''OOFML000208'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, StatusID, IsCommon FROM OOT1040 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStatusID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPKID, @DelStatusID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1)
						UPDATE @OOT1040temp SET Params = ISNULL(Params, '''') + @DelStatusID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
						UPDATE @OOT1040temp SET Params = ISNULL(Params, '''') + @DelStatusID + '', '' WHERE MessageID = ''00ML000052''
					ELSE IF @Status = 2
						UPDATE @OOT1040temp SET Params = ISNULL(Params, '''') + @DelStatusID + '', '' WHERE MessageID = ''OOFML000208''
					ELSE
					BEGIN
						DELETE FROM OOT1040 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
					END					
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStatusID, @DelIsCommon
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT1040temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			--PRINT (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params VARCHAR(100),
						@DelDivisionID VARCHAR(50),
						@DelStatusID NVARCHAR(250),
						@DelIsCommon TINYINT
				DECLARE @OOT1040temp TABLE (
								Status TINYINT,
								MessageID VARCHAR(100),
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelStatusID = StatusID, @DelIsCommon = IsNULL(IsCommon, 0)
				FROM OOT1040 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = ''' + @APK + '''			
				IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1) --Kiểm tra khác DivisionID và không dùng chung
				BEGIN
					SET @Message = ''00ML000050''
					SET	@Status = 2
					SET @Params = @DelStatusID
				END

				EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelStatusID, NULL, NULL, @Status OUTPUT
				IF @Status = 2
				BEGIN
					SET @Message = ''OOFML000208''
					SET	@Status = 2
					SET @Params = @DelStatusID
				END

				INSERT INTO @OOT1040temp (Status, MessageID, Params) SELECT @Status AS Status, @Message AS MessageID, @Params AS Params 			
				SELECT Status, MessageID, Params FROM @OOT1040temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2 --Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKID VARCHAR(50),
						@DelStatusID NVARCHAR(250),
						@DelIsCommon TINYINT
				DECLARE @OOT1040temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params VARCHAR(4000),
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1040temp (Status, MessageID, Params, UpdateSuccess)
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params, NULL AS UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, StatusID, IsCommon FROM OOT1040 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStatusID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1)
						UPDATE @OOT1040temp SET Params = ISNULL(Params, '''') + @DelStatusID + '', ''
					ELSE
					BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + ' = 1 --Nếu chọn là Disable
							UPDATE OOT1040 SET Disabled = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
						ELSE --Nếu chọn là Enable
							UPDATE OOT1040 SET Disabled = 0 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID			
					--Lưu lịch sử khi Disable/Enable		
						UPDATE @OOT1040temp SET UpdateSuccess = ISNULL(UpdateSuccess, '''') + @DelAPKID + '', ''
					END
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStatusID, @DelIsCommon
				END
				CLOSE @Cur
				IF ((SELECT Params FROM @OOT1040temp) IS NULL)
				BEGIN
					UPDATE @OOT1040temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params, LEFT(UpdateSuccess, LEN(UpdateSuccess) - 1) AS UpdateSuccess
				FROM @OOT1040temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
			--PRINT (@sSQL)
			EXEC (@sSQL)
			
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
