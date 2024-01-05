IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE PROCEDURE [dbo].[KPIP2021] (
	@DivisionID VARCHAR(50), 	-- Tru?ng h?p @DivisionID d�ng v?i DivisionID dang nh?p th� cho x�a
	@APK VARCHAR(50), 			-- Tru?ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tru?ng h?p x�a ho?c x? l� enable/disable
	@TableID NVARCHAR(50), 		-- "KPIT2030"	
	@Mode TINYINT, 				-- 0: S?a, 1: X�a; 2: S?a (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Ki?m tra v� x�a
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPK VARCHAR(50), 
						@DelEmployeeID NVARCHAR(250)

				DECLARE @KPIT2020Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @KPIT2020Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, EmployeeID FROM KPIT2020 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEmployeeID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC KPIP90000 ''' + @DivisionID + ''', ''' + @TableID + ''', @DelEmployeeID, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @KPIT2020Temp SET Params = ISNULL(Params, '''') + @DelEmployeeID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @KPIT2020Temp SET Params = ISNULL(Params, '''') + @DelEmployeeID + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								-- x�a Master Quy chu?n d�nh gi� KPI
								DELETE FROM KPIT2020 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
								
						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEmployeeID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @KPIT2020Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
