IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2211]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2211]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[CRMP2211] (
	@DivisionID VARCHAR(50), 	-- Trường hơp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lí enable/disable
	@TableID NVARCHAR(50), 		-- "OOT2210"	
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
						@DelSourceID NVARCHAR(250),
						@DelSourceName NVARCHAR(250),
						@DelIsCommon TINYINT

				DECLARE @CRMP2211Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @CRMP2211Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID,SourceID, SourceName, IsCommon FROM CRMT2210 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelSourceID, @DelSourceName, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelSourceID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelIsCommon != 1)
							UPDATE @CRMP2211Temp SET Params = ISNULL(Params, '''') + @DelSourceName + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @CRMP2211Temp SET Params = ISNULL(Params, '''') + @DelSourceName + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								-- Xóa màn hình danh sách nguồn dữ liệu online
								UPDATE CRMT2210 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK

						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelSourceID, @DelSourceName, @DelIsCommon
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @CRMP2211Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
