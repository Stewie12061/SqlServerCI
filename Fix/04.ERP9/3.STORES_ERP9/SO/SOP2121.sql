IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2121]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP2121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa phiếu báo giá Sale
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình Hòa, Date: 03/08/2017

CREATE PROCEDURE SOP2121 ( 
	@DivisionID VARCHAR(50),
	@TableID VARCHAR(50),
	@APK VARCHAR(50),		--Trường hợp sửa
	@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
	@Mode TINYINT,			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable), 3: Sửa: kiểm tra đã sử dụng để check dùng chung 
	@IsDisable TINYINT,		--1: Disable; 0: Enable
	@UserID NVARCHAR(50)  
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N''

IF @Mode = 1 
BEGIN 
	SET @sSQL = '
			DECLARE @Status TINYINT,
					@Message NVARCHAR(1000),
					@Cur CURSOR,
					@DelDivisionID VARCHAR(50),
					@DelAPK VARCHAR(50),
					@VoucherNo NVARCHAR(250)
			DECLARE @SOT2120Temp TABLE (
					Status TINYINT,
					MessageID VARCHAR(100),
					Params NVARCHAR(4000))
			SET @Status = 0
			SET @Message = ''''
			INSERT INTO @SOT2120Temp (	Status, MessageID, Params)
										SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
										UNION ALL
										SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
										UNION ALL
										SELECT 2 AS Status, ''SOFML000028'' AS MessageID, NULL AS Params
			SET @Cur = CURSOR SCROLL KEYSET FOR
			SELECT APK, DivisionID, VoucherNo FROM SOT2120 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
			OPEN @Cur
			FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @VoucherNo
			WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC SOP90000 @DelDivisionID, NULL, NULL, @DelAPK,''' + @TableID + ''', 0, @Status OUTPUT, @Message OUTPUT
					
				IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
						UPDATE @SOT2120Temp SET Params = ISNULL(Params, '''') + @VoucherNo + '', '' WHERE MessageID = ''00ML000050''
				ELSE IF (SELECT @Status) = 1
						UPDATE @SOT2120Temp SET Params = ISNULL(Params, '''') + @VoucherNo + '', '' WHERE MessageID = ''00ML000052''
				ELSE IF (SELECT @Status) = 2
					BEGIN
						UPDATE @SOT2120Temp SET Params = ISNULL(Params, '''') + @VoucherNo + '', '' WHERE MessageID = ''SOFML000028''
					END
				ELSE
					BEGIN
						-- Xóa người duyệt
						DELETE FROM OOT9000 WHERE APK = (SELECT APKMaster_9000 FROM SOT2110 WITH(NOLOCK) WHERE APK = @DelAPK)
						DELETE FROM OOT9001 WHERE APKMaster = (SELECT APKMaster_9000 FROM SOT2120 WITH(NOLOCK) WHERE APK = @DelAPK)

						-- Xóa phiếu báo giá Sale
						DELETE FROM SOT2121 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
						DELETE FROM SOT2120 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
					END
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @VoucherNo
				SET @Status = 0
			END
			CLOSE @Cur
			SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @SOT2120Temp WHERE Params IS NOT NULL'

END	
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO