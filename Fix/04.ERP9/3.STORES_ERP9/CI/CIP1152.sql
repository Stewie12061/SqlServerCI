IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1152]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP1152]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách máy
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Nguyễn Hoàng Tấn Tài, Date: 19/10/2017
-- <Example> EXEC CIP1152 'VNP', '', '6486CC3C-4733-4889-BDA4-7FDA1F78DFF9', 'CIT1150', 1, NULL,'ASOFTADMIN'

CREATE PROCEDURE [dbo].[CIP1152] (
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX), 	-- CIP1150
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
						@DelMachineID NVARCHAR(250)
				DECLARE @CIT1150Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @CIT1150Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, MachineID FROM CIT1150 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelMachineID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, ''' + @TableID + ''', @DelAPK, @Status OUTPUT
					
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
							UPDATE @CIT1150Temp SET Params = ISNULL(Params, '''') + @DelMachineID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @CIT1150Temp SET Params = ISNULL(Params, '''') + @DelMachineID + '', '' WHERE MessageID = ''00ML000052''
					ELSE
						BEGIN
							-- danh mục máy
							DELETE FROM CIT1150 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							DELETE FROM CIT1151 WHERE CAST(MachineID AS VARCHAR(50)) = @DelAPK
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelMachineID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @CIT1150Temp WHERE Params IS NOT NULL'
			 EXEC(@sSQL)
			--print(@sSQL)
	END
	ELSE IF @Mode = 0 -- Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params VARCHAR(100),
						@DelDivisionID VARCHAR(50),
						@DelMachineID NVARCHAR(250)
				DECLARE @CIT1150Temp TABLE (
								Status TINYINT,
								MessageID VARCHAR(100),
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelMachineID = MachineID
				FROM CIT1150 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = N''' + @APK + '''
				IF (@DelDivisionID != ''' + @DivisionID + ''') -- Kiểm tra khác DivisionID và không dùng chung
					BEGIN
						SET @Message = ''00ML000050''
						SET	@Status = 2
						SET @Params = @DelMachineID
					END
				INSERT INTO @CIT1150Temp (Status, MessageID, Params) SELECT @Status AS Status, @Message AS MessageID, @Params AS Params 
				SELECT Status, MessageID, Params FROM @CIT1150Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
			--print(@sSQL)
	END
END


