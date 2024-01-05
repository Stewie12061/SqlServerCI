IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra xóa/sửa lịch đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 20/09/2017
-- <Example>
---- 
/*-- <Example>
	HRMP2101 @DivisionID='ANG',@ID='TS0001',@IDList='TS0001',@FormID='HRMF2100',@Mode=0,@UserID='ASOFTADMIN'
----*/

CREATE PROCEDURE [HRMP2101] 
( 
	@DivisionID NVARCHAR(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@ID NVARCHAR(50),
	@IDList NVARCHAR(MAX),
	@FormID NVARCHAR(50),	
	@Mode TINYINT, --0: Sửa, 1: Xóa
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
			@DelID NVARCHAR(50)
	
	DECLARE @HRMF2100TEMP TABLE 
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
				
				INSERT INTO @HRMF2100TEMP (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
				union all
				SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, TrainingScheduleID FROM HRMT2100 WITH (NOLOCK) WHERE TrainingScheduleID IN ('''+@IDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC HRMP90000 @DelDivisionID, '''+@FormID+''', ''HRMT2100'', NULL, @DelID, NULL, NULL, @Status OUTPUT
					
					IF @DelDivisionID != '''+@DivisionID+'''
					BEGIN
						UPDATE @HRMF2100TEMP SET Params = ISNULL(Params,'''') + @DelID + '','' WHERE MessageID = ''00ML000050''						
					END
					ELSE IF (Select @Status) = 1
					BEGIN
						UPDATE @HRMF2100TEMP SET Params = ISNULL(Params,'''') + @DelID + '',''  WHERE MessageID = ''00ML000052''						
					END
					ELSE 
					BEGIN
						DELETE FROM HRMT2100 WHERE TrainingScheduleID = @DelID	
						DELETE FROM HRMT2101 WHERE TrainingScheduleID = @DelID							
						DELETE FROM CRMT00003 WHERE RelatedToID = CONVERT(NVARCHAR(50), @DelAPK)			
					END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelID
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @HRMF2100TEMP WHERE Params IS NOT NULL'
				
		--PRINT @sSQL		
		EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = @sSQL + '
				INSERT INTO @HRMF2100TEMP (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
				union all
				SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				
				EXEC HRMP90000 @DelDivisionID, '''+@FormID+''', ''HRMT2100'', NULL, @DelID, NULL, NULL, @Status OUTPUT
						
				SELECT @DelDivisionID = DivisionID, @DelID = TrainingScheduleID
				FROM HRMT2100 WITH (NOLOCK) 
				WHERE TrainingScheduleID = ''' + @ID + '''	
						
				IF @DelDivisionID !='''+@DivisionID+'''  --Kiểm tra khac DivisionID
				BEGIN
					UPDATE @HRMF2100TEMP SET Params = @DelID WHERE MessageID = ''00ML000050''		
				END 
				ELSE IF (Select @Status) = 1
				BEGIN	
					UPDATE @HRMF2100TEMP SET Params = @DelID WHERE MessageID = ''00ML000052''
				END								
				
				INSERT INTO @HRMF2100TEMP (Status, MessageID, Params) 
				SELECT @Status as Status, @Message as MessageID, @Params as Params 		
					
				SELECT Status, MessageID,Params FROM @HRMF2100TEMP WHERE Params IS NOT NULL'
		--PRINT @sSQL		
		EXEC (@sSQL)
	END
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
