IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2222]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP2222]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa đơn hàng sản xuất
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình Hòa, Date: 17/05/2017

CREATE PROCEDURE MP2222 ( 
	@DivisionID VARCHAR(50), 	-- Truờng hợp @DivisionID d?ng v?i DivisionID dang nh?p th? cho x?a
	@APK VARCHAR(50), 			
	@APKList NVARCHAR(MAX), 	
	@TableID NVARCHAR(50), 		-- "OT2001"	
	@Mode TINYINT, 				-- 0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
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
						@DelVoucherNo NVARCHAR(250)

				DECLARE @OT2001Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OT2001Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, VoucherNo FROM OT2001 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC MP9000  ''' + @DivisionID + ''', 01, 02, @DelVoucherNo, ''' + @TableID + ''', 0
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OT2001Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OT2001Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN

								DELETE OT2002 WHERE SOrderID = (SELECT SOrderID FROM OT2001 WITH(NOLOCK) WHERE CAST(APK AS VARCHAR(50)) = @DelAPK  AND OrderType = ''1'')

								-- Xóa Đơn hàng sản xuất
								DELETE OT2001 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK AND OrderType = ''1''

						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OT2001Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END
	
PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO