IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











CREATE PROCEDURE [dbo].[KPIP2031] (
	@DivisionID VARCHAR(50), 	-- Tru?ng h?p @DivisionID dúng v?i DivisionID dang nh?p thì cho xóa
	@APK VARCHAR(50), 			-- Tru?ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tru?ng h?p xóa ho?c x? lý enable/disable
	@TableID NVARCHAR(50), 		-- "KPIT2030"	
	@Mode TINYINT, 				-- 0: S?a, 1: Xóa; 2: S?a (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Ki?m tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPK VARCHAR(50), 
						@DelTableID NVARCHAR(250)

				DECLARE @KPIT2030Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @KPIT2030Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, TableID FROM KPIT2030 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelTableID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC KPIP90000 ''' + @DivisionID + ''', ''' + @TableID + ''', @DelTableID, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''') -- Ki?m tra khác don v?
							UPDATE @KPIT2030Temp SET Params = ISNULL(Params, '''') + @DelTableID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1				   -- Ki?m tra dã s? d?ng
							UPDATE @KPIT2030Temp SET Params = ISNULL(Params, '''') + @DelTableID + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								-- xóa Master h? s? luong m?m
								DELETE FROM KPIT2030 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
								-- xóa Detail h? s? luong m?m
								DELETE FROM KPIT2031 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelTableID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @KPIT2030Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
