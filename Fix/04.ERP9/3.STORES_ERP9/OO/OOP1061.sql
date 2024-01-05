IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách công việc
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Phan thanh hoàng vũ, Date: 19/10/2017
-- <Example> EXEC OOP1061 'KY', '', '', 'OOT1060', 0, NULL

CREATE PROCEDURE OOP1061 (
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX), 	-- OOT1060
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
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelTaskSampleID NVARCHAR(250)
				DECLARE @OOT1061Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1061Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, TaskSampleID FROM OOT1060 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelTaskSampleID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 @DelDivisionID, NULL, ''' + @TableID + ''', @DelAPK, @DelTaskSampleID, NULL, NULL, @Status OUTPUT
					
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
							UPDATE @OOT1061Temp SET Params = ISNULL(Params, '''') + @DelTaskSampleID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT1061Temp SET Params = ISNULL(Params, '''') + @DelTaskSampleID + '', '' WHERE MessageID = ''00ML000052''
					ELSE
						BEGIN
							-- Xóa công việc
							DELETE FROM OOT1060 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							-- Xóa checklist công việc
							UPDATE OOT2111 SET DeleteFlg = 1 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelTaskSampleID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT1061Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
	END
	ELSE IF @Mode = 0 -- Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params VARCHAR(100),
						@DelDivisionID VARCHAR(50),
						@DelTaskSampleID NVARCHAR(250)
				DECLARE @OOT1061Temp TABLE (
								Status TINYINT,
								MessageID VARCHAR(100),
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelTaskSampleID = TaskSampleID
				FROM OOT1060 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = N''' + @APK + '''
				IF (@DelDivisionID != ''' + @DivisionID + ''') -- Kiểm tra khác DivisionID và không dùng chung
					BEGIN
						SET @Message = ''00ML000050''
						SET	@Status = 2
						SET @Params = @DelTaskSampleID
					END
				INSERT INTO @OOT1061Temp (Status, MessageID, Params) SELECT @Status AS Status, @Message AS MessageID, @Params AS Params 
				SELECT Status, MessageID, Params FROM @OOT1061Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
