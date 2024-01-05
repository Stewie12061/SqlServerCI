IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách thiết bị
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Phạm Lê Hoàng, Date: 15/10/2020
-- <Example> EXEC OOP1091 'KY', '', '', 'OOT1090', 0, NULL

CREATE PROCEDURE OOP1091 (
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX), 	-- OOT1090
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
						@DelDeviceID NVARCHAR(250)
				DECLARE @OOT1090Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1090Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, DeviceID FROM OOT1090 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelDeviceID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 @DelDivisionID, NULL, ''' + @TableID + ''', @DelAPK, @DelDeviceID, NULL, NULL, @Status OUTPUT
					
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
							UPDATE @OOT1090Temp SET Params = ISNULL(Params, '''') + @DelDeviceID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT1090Temp SET Params = ISNULL(Params, '''') + @DelDeviceID + '', '' WHERE MessageID = ''00ML000052''
					ELSE
						BEGIN
							-- Xóa thiết bị
							DELETE FROM OOT1090 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelDeviceID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT1090Temp WHERE Params IS NOT NULL'
			EXEC(@sSQL)
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
