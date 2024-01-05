IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra xóa/sửa đề xuất đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 20/09/2017
---- Modified by Khả Vi on 16/01/2018: Fix lỗi 
-- <Example>
---- 
/*-- <Example>
	HRMP2091 @DivisionID='ANG',@ID='TP0001',@IDList='TP0001',@FormID='HRMF2090',@Mode=1,@UserID='ASOFTADMIN'
----*/

CREATE PROCEDURE [HRMP2091] 
( 
	@DivisionID NVARCHAR(50), 
	@ID NVARCHAR(MAX),
	@IDList NVARCHAR(MAX),
	@FormID NVARCHAR(50),	
	@Mode TINYINT, --0: Sửa, 1: Xóa
	@UserID NVARCHAR(50)
) 
AS 


DECLARE @sSQL NVARCHAR(MAX)	= N''	
			
IF @Mode = 1 --Kiểm tra và xóa
BEGIN
	SET @sSQL = @sSQL + N'
	DECLARE @Cur CURSOR,
			@DelDivisionID VARCHAR(50),
			@DelTrainingProposeID VARCHAR(50),
			@DelAPK VARCHAR(50),
			@Params VARCHAR(MAX) = '''', 
			@Params1 VARCHAR(MAX) = ''''		
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT APK, DivisionID, TrainingProposeID 
	FROM HRMT2090 WITH (NOLOCK) 
	WHERE TrainingProposeID IN ('''+@IDList+''')
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelTrainingProposeID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF  (@DelDivisionID <> '''+@DivisionID+''') ---- Kiểm tra khác đơn vị 
		BEGIN 
			SET @Params = ISNULL(@Params,'''') + @DelTrainingProposeID+'','' 
		END 
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2091 WHERE TrainingProposeID = @DelTrainingProposeID
						UNION
						SELECT TOP 1 1 FROM HRMT2100 WHERE TrainingProposeID = @DelTrainingProposeID)
		BEGIN
			SET @Params1 = ISNULL(@Params1,'''') + @DelTrainingProposeID+'','' 
		END 
		ELSE 
		BEGIN
			DELETE FROM HRMT2090 WHERE APK = @DelAPK
			DELETE FROM HRMT2091 WHERE TrainingProposeID = @DelTrainingProposeID	
			DELETE FROM CRMT00003 WHERE RelatedToID = CONVERT(NVARCHAR(50), @DelAPK)			
		END
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelTrainingProposeID
	END
	CLOSE @Cur
	SELECT 2 AS Status, ''00ML000050'' AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params, '''') <> ''''
	UNION ALL
	SELECT 2 AS Status, ''00ML000052'' AS MessageID, LEFT(@Params1,LEN(@Params1) - 1) AS Params, '''+@FormID+''' AS FormID WHERE ISNULL(@Params1,'''') <> ''''
	'
END
ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
BEGIN
	SET @sSQL = @sSQL + '
	INSERT INTO @HRMF2090TEMP (Status, MessageID, Params) 
	SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
	union all
	SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				
	EXEC HRMP90000 @DelDivisionID, '''+@FormID+''', ''HRMT2090'', NULL, @DelID, NULL, NULL, @Status OUTPUT
						
	SELECT @DelDivisionID = DivisionID, @DelID = TrainingProposeID
	FROM HRMT2090 WITH (NOLOCK) 
	WHERE TrainingProposeID = ''' + @ID + '''	
						
	IF @DelDivisionID !='''+@DivisionID+'''  --Kiểm tra khac DivisionID
	BEGIN
		UPDATE @HRMF2090TEMP SET Params = @DelID WHERE MessageID = ''00ML000050''		
	END 
	ELSE IF (Select @Status) = 1
	BEGIN	
		UPDATE @HRMF2090TEMP SET Params = @DelID WHERE MessageID = ''00ML000052''
	END								
				
	INSERT INTO @HRMF2090TEMP (Status, MessageID, Params) 
	SELECT @Status as Status, @Message as MessageID, @Params as Params 		
					
	SELECT Status, MessageID,Params FROM @HRMF2090TEMP WHERE Params IS NOT NULL'
		
END
PRINT @sSQL		
EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
