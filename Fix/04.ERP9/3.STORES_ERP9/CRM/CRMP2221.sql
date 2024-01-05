IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2221]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2221]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----<Summary>
---- Xóa dữ liệu quản lý Server
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
---- Created by Hoài Bảo on 25/03/2022
---- <Example>
---- EXEC CRMP2221 @DivisionID=N'DTI',@TableID=N'AT0015',@APK=NULL,@APKList=N'ee4a3f9f-5bea-4e64-8100-71cadd3be940',@Mode=1,@IsDisable=0,@UserID=N'ASOFTADMIN'
CREATE PROCEDURE [dbo].[CRMP2221] (
	@DivisionID VARCHAR(50), 	-- Trường hơp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lí enable/disable
	@TableID NVARCHAR(50), 		-- "AT0015"
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
						@DelAPK VARCHAR(50), 
						@DelServerID NVARCHAR(250)

				DECLARE @CRMP2221Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @CRMP2221Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ServerID FROM AT0015 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelServerID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelServerID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @CRMP2221Temp SET Params = ISNULL(Params, '''') + @DelServerID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @CRMP2221Temp SET Params = ISNULL(Params, '''') + @DelServerID + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								-- Xóa màn hình danh sách nguồn dữ liệu online
								UPDATE AT0015 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK

						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelServerID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @CRMP2221Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
