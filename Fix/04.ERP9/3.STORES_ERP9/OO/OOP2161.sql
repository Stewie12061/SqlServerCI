IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













CREATE PROCEDURE [dbo].[OOP2161] (
	@DivisionID VARCHAR(50), 	-- Tru?ng h?p @DivisionID d?ng v?i DivisionID dang nh?p th? cho x?a
	@APK VARCHAR(50), 			-- Tru?ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tru?ng h?p x?a ho?c x? l? enable/disable
	@TableID NVARCHAR(50), 		-- "OOT2160"	
	@Mode TINYINT, 				-- 0: S?a, 1: X?a; 2: S?a (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Ki?m tra v? x?a
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPK VARCHAR(50), 
						@DelIssuesID NVARCHAR(250)

				DECLARE @OOT2160Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT2160Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, IssuesID FROM OOT2160 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelIssuesID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelIssuesID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT2160Temp SET Params = ISNULL(Params, '''') + @DelIssuesID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT2160Temp SET Params = ISNULL(Params, '''') + @DelIssuesID + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								-- Xóa màn hình qu?n lý v?n d?
								UPDATE OOT2160 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK

						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelIssuesID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT2160Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END

















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
