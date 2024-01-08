IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1831]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1831]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Delete master và detail Nguyên liệu thay thế.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 10/12/2020 by Đình Ly

CREATE PROCEDURE [dbo].[MP1831] 
(
	@DivisionID VARCHAR(50), 	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50), 		-- "OOT2140"	
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
						@DelMaterialGroupID NVARCHAR(250),
						@CountMaterialGroupID INT

				DECLARE @MT0006 TABLE 
				(
					Status TINYINT, 
					MessageID VARCHAR(100), 
					Params NVARCHAR(4000)
				)

				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @MT0006 (Status, MessageID, Params) 
					SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
					UNION ALL
					SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
					UNION ALL
					SELECT 2 AS Status, ''OOFML000206'' AS MessageID, NULL AS Params

				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, MaterialGroupID FROM MT0006 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelMaterialGroupID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SELECT @CountMaterialGroupID = COUNT(MaterialGroupID) FROM MT2121 WHERE MaterialGroupID = @DelMaterialGroupID

					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, @DelMaterialGroupID, NULL, NULL, @Status OUTPUT

					IF (@DelDivisionID != ''' + @DivisionID + ''' AND @DelDivisionID != ''@@@'')
						UPDATE @MT0006 SET Params = ISNULL(Params, '''') + @DelMaterialGroupID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
						UPDATE @MT0006 SET Params = ISNULL(Params, '''') + @DelMaterialGroupID + '', '' WHERE MessageID = ''00ML000052''
					ELSE IF (@CountMaterialGroupID > 0)
						UPDATE @MT0006 SET Params = ISNULL(Params, '''') + @DelMaterialGroupID + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
							-- Delete master Nhóm nguyên liệu thay thế (MT0006)
							DELETE FROM MT0006 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							-- Delete details Nhóm nguyên liệu thay thế (MT0007)
							DELETE FROM MT0007 WHERE MaterialGroupID = @DelMaterialGroupID 
						END					
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelMaterialGroupID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @MT0006 WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
