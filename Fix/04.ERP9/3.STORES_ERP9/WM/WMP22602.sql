IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22602]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22602]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----<Summary>
---- Xóa dữ liệu Số dư đầu hàng tồn kho
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
---- Created by Hoài Bảo on 22/04/2022
---- Modified by Hoài Bảo on 24/11/2022 - Bổ sung xóa phần chi tiết
---- <Example>
---- EXEC WMP22602 @DivisionID=N'DTI',@TableID=N'AT2016',@APK=NULL,@APKList=N'd16d8618-9cf3-4c0d-8a4b-5754017ee587',@Mode=1,@IsDisable=0,@UserID=N'ASOFTADMIN'
---- <Example>

CREATE PROCEDURE [dbo].[WMP22602] (
	@DivisionID VARCHAR(50), 	-- Trường hơp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lí enable/disable
	@TableID NVARCHAR(50), 		-- "AT2016"
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
						@DelVoucherNo NVARCHAR(250),
						@DelVoucherID NVARCHAR(250)

				DECLARE @WMP22602Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @WMP22602Temp (	Status, MessageID, Params)
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, VoucherNo, VoucherID FROM AT2016 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @DelVoucherID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @WMP22602Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000050''
					ELSE
						BEGIN
								-- Xóa dữ liệu chi tiết
								DELETE AT2017 WHERE VoucherID IN (SELECT VoucherID FROM AT2016 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = @DelAPK)

								-- Xóa dữ liệu master
								DELETE AT2016 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @DelVoucherID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @WMP22602Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
