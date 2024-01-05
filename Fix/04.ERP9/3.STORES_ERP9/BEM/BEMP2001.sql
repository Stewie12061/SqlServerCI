IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Store xóa BEMT2000
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 16/06/2020
----Modified by: Vĩnh Tâm, Date 19/11/2020: Bổ sung: Khi phiếu đề nghị bị xóa thì cập nhật lại trạng thái kế thừa là chưa kế thừa để có thể tạo phiếu mới

CREATE PROCEDURE [dbo].[BEMP2001] (
	@DivisionID VARCHAR(50), 	-- Tr??ng h?p @DivisionID ?úng v?i DivisionID ??ng nh?p thì cho xóa
	@APK VARCHAR(50), 			-- Tr??ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tr??ng h?p xóa ho?c x? lí enable/disable
	@TableID NVARCHAR(50), 		-- "BEMT2000"	
	@Mode TINYINT, 				-- 0: S?a, 1: Xóa; 2: S?a (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Kiểm tra và xóa.
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPK VARCHAR(50),
						@DelVoucherNo VARCHAR(MAX),
						@APKMaster_9000 VARCHAR(50),
						@ListAPKDInherited VARCHAR(MAX)

				DECLARE @BEMT2000Temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @BEMT2000Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000117'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT B1.APK, B1.DivisionID, B1.VoucherNo, B1.APKMaster_9000 FROM BEMT2000 B1 WITH (NOLOCK)
				WHERE CAST(B1.APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @APKMaster_9000
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC BEMP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, @DelVoucherNo, NULL, NULL, @Status OUTPUT
					IF @Status = 1
						UPDATE @BEMT2000Temp SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000117''
					ELSE 
					BEGIN
						UPDATE BEMT2000 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
						UPDATE BEMT2001 SET DeleteFlg = 1 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
						UPDATE OOT9000 SET DeleteFlag = 1 WHERE CAST(APK AS VARCHAR(50)) = @APKMaster_9000
						UPDATE OOT9001 SET DeleteFlag = 1 WHERE CAST(APKMaster AS VARCHAR(50)) = @APKMaster_9000

						-- Danh sách APK kế thừa từ phiếu DNCT - Thanh toán phí đi lại
						SELECT @ListAPKDInherited = ListAPKDInherited
						FROM BEMT2001 B1 WITH (NOLOCK)
						WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK AND B1.InheritType = ''DNCT'' AND ListAPKDInherited IS NOT NULL

						-- Khi phiếu đề nghị bị xóa thì cập nhật lại trạng thái kế thừa là chưa kế thừa để có thể tạo phiếu mới
						UPDATE BEMT2021 SET IsInherited = 0
						WHERE CAST(APK AS VARCHAR(50)) IN (SELECT Value AS APKInherited FROM StringSplit(@ListAPKDInherited, '',''))
					END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @APKMaster_9000
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @BEMT2000Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			--PRINT (@sSQL)
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

