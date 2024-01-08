IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách dự án/nhóm công việc
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 26/06/2017
-- Modified by: Khâu Vĩnh Tâm, Date: 20/05/2019 - Xóa Công việc của dự án tại bảng OOT2110 khi xóa Dự án
-- <Example> EXEC OOP2101 'KY', '', '7505750C-120D-432A-B8FF-3392BA9AF221', 'OOT2100', 0, 0, NULL

CREATE PROCEDURE OOP2101 (
	@DivisionID VARCHAR(50), --Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 		--Trường hợp sửa
	@APKList NVARCHAR(MAX), 	--Trường hợp xóa hoặc xử lý enable/disable
	@TableID nVARCHAR(50), 	-- "OOT2100"	
	@Mode TINYINT, 			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, 	--1: Disable; 0: Enable
	@UserID VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelProjectID VARCHAR(50),
						@DelOpportunityID VARCHAR(50)
				DECLARE @OOT2100temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT2100temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProjectID, OpportunityID FROM OOT2100 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelProjectID, @DelOpportunityID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, @DelProjectID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT2100temp SET Params = ISNULL(Params, '''') + @DelProjectID + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OOT2100temp SET Params = ISNULL(Params, '''') + @DelProjectID + '', '' WHERE MessageID = ''00ML000052''
					ELSE
						BEGIN
							-- Table Dự án/nhóm công việc
							DELETE FROM OOT2100 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							-- Table Người tham gia
							DELETE FROM OOT2101 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
							-- Table Chi tiết dự án/nhóm công việc
							DELETE FROM OOT2102 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
							-- Table Công việc
							DELETE FROM OOT2110 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
							-- Table dữ liệu mã phân tích
							DELETE FROM AT1011 WHERE AnaID = @DelProjectID
								AND AnaTypeID = (SELECT ProjectAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DelDivisionID)
							EXEC OOP2108 @DivisionID = @DelDivisionID, @ProjectID = @DelProjectID, @OpportunityID = @DelOpportunityID
						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelProjectID, @DelOpportunityID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OOT2100temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params VARCHAR(100),
						@DelDivisionID VARCHAR(50),
						@DelProjectID NVARCHAR(250)
				DECLARE @OOT2100temp TABLE (
								Status TINYINT,
								MessageID VARCHAR(100),
								Params VARCHAR(4000))
				SELECT @DelDivisionID = DivisionID, @DelProjectID = ProjectID
				FROM OOT2100 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = ''' + @APK + '''			
				IF (@DelDivisionID != ''' + @DivisionID + ''') --Kiểm tra khac DivisionID và không dùng chung
							BEGIN
								SET @Message = ''00ML000050''
								SET	@Status = 2
								SET @Params = @DelProjectID
							END
				INSERT INTO @OOT2100temp (	Status, MessageID, Params) SELECT @Status AS Status, @Message AS MessageID, @Params AS Params 			
				SELECT Status, MessageID, Params FROM @OOT2100temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelProjectID NVARCHAR(250)
				DECLARE @OOT2100temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params VARCHAR(4000),
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT2100temp (Status, MessageID, Params, UpdateSuccess)
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params, NULL AS UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, ProjectID FROM OOT2100 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelProjectID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT2100temp SET Params = ISNULL(Params, '''') + @DelProjectID + '', ''
					ELSE
					BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + ' = 1 -- Nếu chọn là Disable
							UPDATE OOT2100 SET Disabled = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK	
						ELSE -- Nếu chọn là Enable
							UPDATE OOT2100 SET Disabled = 0 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK			
					-- Lưu lịch sử khi Disable/Enable		
						UPDATE @OOT2100temp SET UpdateSuccess = ISNULL(UpdateSuccess, '''') + @DelAPK + '', ''
					END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelProjectID
				END
				CLOSE @Cur
				IF ((SELECT Params FROM @OOT2100temp) IS NULL)
				BEGIN
					UPDATE @OOT2100temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params, LEFT(UpdateSuccess, LEN(UpdateSuccess) - 1) AS UpdateSuccess
				FROM @OOT2100temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
			--PRINT (@sSQL)
			EXEC (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
