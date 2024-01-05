IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách bước
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 04/10/2017
-- <Example> EXEC OOP1031 'AS', '', '', 'OOT1030', 1, 0, NULL

CREATE PROCEDURE [dbo].[OOP1031] ( 
	@DivisionID VARCHAR(50),-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50),		-- Trường hợp sửa
	@APKList NVARCHAR(MAX),	-- Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50),	-- "OOT1030"	
	@Mode TINYINT,			-- 0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT,	-- 1: Disable; 0: Enable
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
						@DelStepID NVARCHAR(250)
				DECLARE @OOT1030Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1030Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, StepID FROM OOT1030 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStepID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPKID, @DelStepID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
						UPDATE @OOT1030Temp SET Params = ISNULL(Params,'''') + @DelStepID + '','' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
						UPDATE @OOT1030Temp SET Params = ISNULL(Params,'''') + @DelStepID + '','' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
							DELETE FROM OOT1030 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
							DELETE FROM OOT1031 WHERE APKMaster = @DelAPKID
								
						END					
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStepID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @OOT1030Temp WHERE Params IS NOT NULL'
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
						@DelStepID NVARCHAR(250)
				DECLARE @OOT1030Temp TABLE (
								Status TINYINT,
								MessageID VARCHAR(100),
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelStepID = StepID
				FROM OOT1030 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = ''' + @APK + '''			
				IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + ''')) -- Kiểm tra khac DivisionID và không dùng chung
							BEGIN
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelStepID
							END 
				INSERT INTO @OOT1030Temp (Status, MessageID, Params) SELECT @Status AS Status, @Message AS MessageID, @Params AS Params 			
				SELECT Status, MessageID,Params FROM @OOT1030Temp WHERE Params IS NOT NULL'
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
						@DelStepID NVARCHAR(250)
				DECLARE @OOT1030Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params VARCHAR(4000),
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1030Temp (Status, MessageID, Params, UpdateSuccess) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params, NULL AS UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, StepID FROM OOT1030 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStepID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
							UPDATE @OOT1030Temp SET Params = ISNULL(Params,'''') + @DelStepID + '',''
					ELSE 
					BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + ' = 1 -- Nếu chọn là Disable
							UPDATE OOT1030 SET Disabled = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID		
						ELSE -- Nếu chọn là Enable
							UPDATE OOT1030 SET Disabled = 0 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID			
					-- Lưu lịch sử khi Disable/Enable		
						UPDATE @OOT1030Temp SET UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPKID + '',''
					END
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelStepID
				END
				CLOSE @Cur
				IF ((SELECT Params FROM @OOT1030Temp) is NULL)
				BEGIN
					UPDATE @OOT1030Temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess
				 FROM @OOT1030Temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
				 -- PRINT (@sSQL)
			EXEC (@sSQL)
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
