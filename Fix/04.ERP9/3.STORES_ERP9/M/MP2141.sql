IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Xóa Phiếu Kế hoạch sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên
----Modified by Lê Hoàng on 04/06/2021 : Xóa thêm bảng MT2141, MT2142, MT2143
----Modified by ... on ... :
-- <Example>

CREATE PROCEDURE [dbo].[MP2141] (
	@DivisionID VARCHAR(50), 	-- Truờng hợp @DivisionID d?ng v?i DivisionID dang nh?p th? cho x?a
	@APK VARCHAR(50), 			-- Tru?ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tru?ng h?p x?a ho?c x? l? enable/disable
	@TableID NVARCHAR(50), 		-- "MT2140"	
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
						@DelVoucherNo NVARCHAR(250)

				DECLARE @MT2140Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @MT2140Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000165'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, VoucherNo FROM MT2140 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo
				WHILE @@FETCH_STATUS = 0
				BEGIN
					--EXEC MP9000  ''' + @DivisionID + ''', 01, 02, @DelVoucherNo, ''' + @TableID + ''', 0
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @MT2140Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @MT2140Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
								IF EXISTS (SELECT TOP 1 1 FROM MT2160 M60 WITH(NOLOCK) WHERE M60.MPlanID = @DelVoucherNo AND M60.DeleteFlg = 0)
								BEGIN
									-- Đã sử dụng, không cho xóa
									UPDATE @MT2140Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000165''
								END
								ELSE
								BEGIN
									-- Xóa chi tiết công đoạn
									UPDATE MT2143 SET DeleteFlg = 1 WHERE CONVERT(NVARCHAR(50),APK_MT2140) = @DelAPK
									-- Xóa danh sách công đoạn
									UPDATE MT2142 SET DeleteFlg = 1 WHERE CONVERT(NVARCHAR(50),APKMaster) = @DelAPK
									-- Xóa thông tin thành phẩm
									UPDATE MT2141 SET DeleteFlg = 1 WHERE CONVERT(NVARCHAR(50),APKMaster) = @DelAPK
									-- Xóa màn hình kế hoạch sản xuất
									UPDATE MT2140 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
								END
						END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @MT2140Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END




















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
