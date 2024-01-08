IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10502]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP10502]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa chỉ tiêu KPI 
-- Nếu xếp loại chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 11/08/2017
-- Edited by: Hoàng vũ, Date: 03/10/2017: Do nghiệp vụ đặt biệt chỉ, DivisionID chỉ lưu lưới lưới Detail phụ thuộc vào check [Dung chung], nên bỏ qua chức năng kiểm tra khác DivisionID
-- <Example> EXEC KPIP10502 'AS', '', '', 'KPIT10501', 2, 1, NULL

CREATE PROCEDURE KPIP10502 ( 
	 @DivisionID  VARCHAR(50), 					--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	 @TargetsID  NVARCHAR(MAX), 
	 @TargetsIDList  NVARCHAR(MAX), 
	 @TABLEID   VARCHAR(50), 					--KPIT10501
	 @Mode TINYINT, 								--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	 @IsDisable  TINYINT, 						--1: Disable; 0: Enable
	 @UserID VARCHAR(50))  
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelAPK VARCHAR(50), 
						@DelTargetsID VARCHAR(50), 
						@DelIsCommon TINYINT
				DECLARE @KPIT10501temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @KPIT10501temp (Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, TargetsID, IsCommon 
				FROM KPIT10501 WITH (NOLOCK) WHERE TargetsID IN (''' + @TargetsIDList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC KPIP90000 NULL, ''' + @TABLEID + ''', @DelTargetsID, @Status OUTPUT

					IF @DelTargetsID = ''CT.DTI.QL01''
							UPDATE @KPIT10501temp SET Params = ISNULL(Params, '''') + @DelTargetsID + '', ''  WHERE MessageID = ''00ML000052''
					ELSE IF (SELECT @Status) = 1
							UPDATE @KPIT10501temp SET Params = ISNULL(Params, '''') + @DelTargetsID + '', ''  WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
							--DELETE FROM KPIT10501 WHERE APK = @DelAPK	
							--DELETE FROM KPIT10502 WHERE APKMaster = @DelAPK
							UPDATE KPIT10501 SET DeleteFlg = 1 WHERE APK = @DelAPK
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsID, @DelIsCommon
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM  @KPIT10501temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Params VARCHAR(100), 
						@DelDivisionID VARCHAR(50), 
						@DelTargetsID  VARCHAR(50), 
						@DelIsCommon TINYINT
				DECLARE @KPIT10501temp TABLE (
								Status TINYINT, 
								MessageID VARCHAR(100), 
								Params VARCHAR(4000))
				SELECT Status, MessageID, Params FROM  @KPIT10501temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelTargetsID VARCHAR(50), 
						@DelAPK VARCHAR(50), 
						@DelIsCommon TINYINT
				DECLARE @KPIT10501temp TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params VARCHAR(4000), 
						UpdateSuccess VARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @KPIT10501temp (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, TargetsID, IsCommon FROM KPIT10501 WITH (NOLOCK) WHERE TargetsID IN (''' + @TargetsIDList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
						IF ' + CAST(@IsDisable AS VARCHAR(50)) + '=1 --Nếu chọn là Disable
							UPDATE KPIT10501 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE KPIT10501 SET Disabled = 0 WHERE APK = @DelAPK	
						-- Trả ra những TargetsID UPDATE thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						UPDATE @KPIT10501temp SET UpdateSuccess = ISNULL(UpdateSuccess, '''') + @DelAPK + '', ''				

					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params FROM @KPIT10501temp) IS NULL)
				BEGIN
					UPDATE @KPIT10501temp SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params, LEFT(UpdateSuccess, LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				FROM  @KPIT10501temp WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
			EXEC (@sSQL)
			
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
