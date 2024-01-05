IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Delete master và detail định mức dự án
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 09/08/2019 by Đình Ly

CREATE PROCEDURE [dbo].[OOP2141] (
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
						@DelProjectID NVARCHAR(250),
						@DelAPKMaster_9000 VARCHAR(50),
						@StatusApproval INT

				DECLARE @OOT2140 TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT2140 (Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''OOFML000206'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProjectID, APKMaster_9000 FROM OOT2140 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelProjectID, @DelAPKMaster_9000
				WHILE @@FETCH_STATUS = 0
				BEGIN
					-- Kiểm tra định mức đã được xét duyệt hay chưa
					SELECT @StatusApproval = (SELECT TOP 1 O2.Status) 
					FROM OOT9000 O
						INNER JOIN OOT9001 O2 ON O2.APKMaster = O.APK
						INNER JOIN OOT2140 O1 ON O1.APKMaster_9000 = O.APK
					WHERE CAST(O1.APK AS VARCHAR(50)) IN (''' + @APKList + ''') AND O2.STATUS = 1

					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, @DelProjectID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT2140 SET Params = ISNULL(Params, '''') + @DelProjectID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT2140 SET Params = ISNULL(Params, '''') + @DelProjectID + '', '' WHERE MessageID = ''00ML000052''
					ELSE IF (SELECT @StatusApproval) = 1
							UPDATE @OOT2140 SET Params = ISNULL(Params, '''') + @DelProjectID + '', '' WHERE MessageID = ''00ML000001''
					ELSE 
						BEGIN
							-- Xóa master định mức dự án (OOT2140)
							DELETE FROM OOT2140 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							-- Xóa detail định mức dự án
							DELETE FROM OOT2141 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK 
							-- Xóa master xét duyệt (OOT9000)
							DELETE FROM OOT9000 WHERE APK = @DelAPKMaster_9000
							-- Xóa detail xét duyệt (OOT9001)
							DELETE FROM OOT9001 WHERE APKMaster = @DelAPKMaster_9000 
						END					
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelProjectID, @DelAPKMaster_9000
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT2140 WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
