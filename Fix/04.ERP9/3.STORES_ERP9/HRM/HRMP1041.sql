IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Kiểm tra xóa/sửa lĩnh vực đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 15/09/2017
-- <Example>
---- 
/*-- <Example>
	HRMP1041 @DivisionID='ANG',@ID='CNTT',@IDList='CNTT',@FormID='HRMF1040',@Mode=2,@IsDisable=1,@UserID='ASOFTADMIN'
----*/
CREATE PROCEDURE [HRMP1041] 
( 
	@DivisionID NVARCHAR(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@ID NVARCHAR(50),
	@IDList NVARCHAR(MAX),
	@FormID NVARCHAR(50),	
	@Mode TINYINT,		--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT,	--1: Disable; 0: Enable
	@UserID NVARCHAR(50)

) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	SET @sSQL = '
	DECLARE @Status TINYINT,
			@Params NVARCHAR(100),
			@Message NVARCHAR(1000),
			@Cur CURSOR,
			@DelAPK VARCHAR(50),
			@DelDivisionID NVARCHAR(50),
			@DelID NVARCHAR(50),
			@DelIsCommon TINYINT	
	
	DECLARE @HRMF1040TEMP TABLE 
	(
			Status TINYINT,
			MessageID NVARCHAR(100),
			Params NVARCHAR(4000),
			UpdateSuccess VARCHAR(4000)
	)'

	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = @sSQL + N'
				SET @Status = 0
				SET @Message = ''''
				
				INSERT INTO @HRMF1040TEMP (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
				union all
				SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, TrainingFieldID, IsCommon FROM HRMT1040 WITH (NOLOCK) WHERE APK IN ('''+@IDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC HRMP90000 @DelDivisionID, '''+@FormID+''', ''HRMT1040'', NULL, @DelID, NULL, NULL, @Status OUTPUT
					
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
					BEGIN
						UPDATE @HRMF1040TEMP SET Params = ISNULL(Params,'''') + @DelID + '','' WHERE MessageID = ''00ML000050''						
					END
					ELSE IF (Select @Status) = 1
					BEGIN
						UPDATE @HRMF1040TEMP SET Params = ISNULL(Params,'''') + @DelID + '',''  WHERE MessageID = ''00ML000052''						
					END
					ELSE 
					BEGIN
						UPDATE HRMT1040 SET DeleteFlg = 1 WHERE APK = @DelAPK
						--DELETE FROM CRMT00003 WHERE RelatedToID = CONVERT(NVARCHAR(50), @DelAPK)			
					END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @HRMF1040TEMP WHERE Params IS NOT NULL'
				
		--PRINT @sSQL		
		EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = @sSQL + '
				INSERT INTO @HRMF1040TEMP (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
				union all
				SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				
				SELECT @DelDivisionID = DivisionID, @DelID = TrainingFieldID, @DelIsCommon = ISNULL(IsCommon, 0)
				FROM HRMT1040 WITH (NOLOCK) WHERE TrainingFieldID = ''' + @ID + '''						
				
				EXEC HRMP90000 @DelDivisionID, '''+@FormID+''', ''HRMT1040'', NULL, @DelID, NULL, NULL, @Status OUTPUT
							
				IF (@DelDivisionID !='''+@DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
				BEGIN
					UPDATE @HRMF1040TEMP SET Params = @DelID WHERE MessageID = ''00ML000050''		
				END 
				ELSE IF (Select @Status) = 1
				BEGIN	
					UPDATE @HRMF1040TEMP SET Params = @DelID WHERE MessageID = ''00ML000052''
				END								
				
				INSERT INTO @HRMF1040TEMP (Status, MessageID, Params) 
				SELECT @Status as Status, @Message as MessageID, @Params as Params 		
					
				SELECT Status, MessageID,Params FROM @HRMF1040TEMP WHERE Params IS NOT NULL'
		--PRINT @sSQL		
		EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = @sSQL + '
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @HRMF1040TEMP (	Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, TrainingFieldID, IsCommon FROM HRMT1040 WITH (NOLOCK) WHERE TrainingFieldID IN ('''+@IDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon != 1)
					BEGIN
						UPDATE @HRMF1040TEMP SET Params = ISNULL(Params,'''') + @DelID + '','' WHERE MessageID = ''00ML000050''						
					END
					ELSE 
					BEGIN
						IF '+CONVERT(NVARCHAR(50), @IsDisable)+' = 1 --Nếu chọn là Disable
						BEGIN
							UPDATE HRMT1040 SET Disabled = 1 WHERE TrainingFieldID = @DelID									
						END
						ELSE  --Nếu chọn là Enable
						BEGIN
							UPDATE HRMT1040 SET Disabled = 0 WHERE TrainingFieldID = @DelID
							--Trả ra những TrainingFieldID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
							UPDATE @HRMF1040TEMP SET UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK + '',''								
						END				
					END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelID, @DelIsCommon
				END
				CLOSE @Cur
				
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @HRMF1040TEMP) IS NULL)
				BEGIN
					UPDATE @HRMF1040TEMP SET MessageID = NULL, Status = NULL
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				FROM @HRMF1040TEMP WHERE Params IS NOT NULL OR UpdateSuccess IS NOT NULL'
		
		--PRINT @sSQL			
		EXEC (@sSQL)	
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

