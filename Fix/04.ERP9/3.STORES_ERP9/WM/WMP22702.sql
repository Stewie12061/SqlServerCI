IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22702]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22702]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----<Summary>
---- Xóa dữ liệu Kết chuyển số dư cuối kỳ
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
---- Created by Hoài Bảo on 19/07/2022
---- Modified by Hoài Bảo on 02/12/2022 - Fix lỗi xóa nhiều dòng
---- <Example>
---- EXEC WMP22702 @DivisionID=N'DTI',@TableID=N'AT2008',@APK=NULL,@APKList=N'd16d8618-9cf3-4c0d-8a4b-5754017ee587',@Mode=1,@IsDisable=0,@UserID=N'ASOFTADMIN'
---- <Example>

CREATE PROCEDURE [dbo].[WMP22702] (
	@DivisionID VARCHAR(50), 	-- Trường hơp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lí enable/disable
	@TableID NVARCHAR(50), 		-- "AT2008"
	@Mode TINYINT, 				-- 0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
)
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sSQL1 NVARCHAR(MAX)

	IF @Mode = 1 -- Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50), 
						@DelPeriodID NVARCHAR(250)

				DECLARE @WMP22702Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @WMP22702Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DISTINCT APK, M.DivisionID, (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear))
										   ELSE RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear)) END) AS PeriodID
				FROM AT2008 M WITH (NOLOCK)
				INNER JOIN ( SELECT DivisionID, TranMonth, TranYear, WareHouseID
							 FROM AT2008 WITH (NOLOCK)
							 WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')) x ON M.DivisionID = x.DivisionID AND M.TranMonth = x.TranMonth AND M.TranYear = x.TranYear AND x.WareHouseID = M.WareHouseID
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelPeriodID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @WMP22702Temp SET Params = ISNULL(Params, '''') + @DelPeriodID + '', '' WHERE MessageID = ''00ML000050''
					ELSE
						BEGIN
							-- Xóa màn hình danh sách kết chuyển số dư cuối kỳ
							DELETE AT2008 WHERE APK = @DelAPK AND DivisionID = @DelDivisionID
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelPeriodID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @WMP22702Temp WHERE Params IS NOT NULL'

		SET @sSQL1 = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50), 
						@DelPeriodID NVARCHAR(250)

				DECLARE @WMP22702Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @WMP22702Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, M.DivisionID, (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear))
										   ELSE RTRIM(LTRIM(M.TranMonth)) + ''/'' + LTRIM(RTRIM(M.TranYear)) END) AS PeriodID
				FROM AT2008_QC M WITH (NOLOCK)
				INNER JOIN ( SELECT DivisionID, TranMonth, TranYear, WareHouseID
							 FROM AT2008_QC WITH (NOLOCK)
							 WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')) x ON M.DivisionID = x.DivisionID AND M.TranMonth = x.TranMonth AND M.TranYear = x.TranYear AND x.WareHouseID = M.WareHouseID
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelPeriodID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @WMP22702Temp SET Params = ISNULL(Params, '''') + @DelPeriodID + '', '' WHERE MessageID = ''00ML000050''
					ELSE
						BEGIN
							-- Xóa màn hình danh sách kết chuyển số dư cuối kỳ
							DELETE AT2008_QC WHERE APK = @DelAPK AND DivisionID = @DelDivisionID
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelPeriodID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @WMP22702Temp WHERE Params IS NOT NULL'
	END

	-- Kiểm tra có sử dụng thiết lập quy cách hay không
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN
		PRINT (@sSQL1)
		EXEC (@sSQL1)
	END
	ELSE
	BEGIN
		PRINT (@sSQL)
		EXEC (@sSQL)
	END
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
