IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[PAP10002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[PAP10002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa từ điển năng lực KPI/DGNL
-- Nếu xếp loại chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 25/08/2017
-- <Example> EXEC PAP10002 'AS', '', '', 'PAT10001', 1, 0, NULL

CREATE PROCEDURE PAP10002 ( 
	 @DivisionID  varchar(50),					--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	 @AppraisalDictionaryID  NVARCHAR(MAX),
	 @AppraisalDictionaryIDList  NVARCHAR(MAX),
	 @TableID   varchar(50),					--PAT10001
	 @Mode tinyint,								--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	 @IsDisable  tinyint,						--1: Disable; 0: Enable
	 @UserID Varchar(50))  
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelAPK Varchar(50),
						@DelDivisionID VARCHAR(50),
						@DelAppraisalDictionaryID Varchar(50),
						@DelIsCommon tinyint
				Declare @PAT10001temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @PAT10001temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, AppraisalDictionaryID, IsCommon 
				FROM PAT10001 WITH (NOLOCK) WHERE AppraisalDictionaryID IN ('''+@AppraisalDictionaryIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelAppraisalDictionaryID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC PAP90000 @DelDivisionID, '''+@TableID+''', @DelAppraisalDictionaryID, @Status OUTPUT

					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @PAT10001temp set Params = ISNULL(Params,'''') + @DelAppraisalDictionaryID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @PAT10001temp set Params = ISNULL(Params,'''') + @DelAppraisalDictionaryID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM PAT10001 WHERE AppraisalDictionaryID = @DelAppraisalDictionaryID
							DELETE FROM PAT10002 WHERE AppraisalDictionaryID = @DelAppraisalDictionaryID	
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelAppraisalDictionaryID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @PAT10001temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelAppraisalDictionaryID  Varchar(50), 
						@DelIsCommon tinyint
				Declare @PAT10001temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelAppraisalDictionaryID = AppraisalDictionaryID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM PAT10001 WITH (NOLOCK) WHERE AppraisalDictionaryID = '''+@AppraisalDictionaryID+'''
				
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelAppraisalDictionaryID
							End 
				
				INSERT INTO @PAT10001temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @PAT10001temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAppraisalDictionaryID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @PAT10001temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @PAT10001temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, AppraisalDictionaryID, IsCommon FROM PAT10001 WITH (NOLOCK) WHERE AppraisalDictionaryID IN ('''+@AppraisalDictionaryIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelAppraisalDictionaryID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @PAT10001temp set Params = ISNULL(Params,'''') + @DelAppraisalDictionaryID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE PAT10001 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE PAT10001 SET Disabled = 0 WHERE APK = @DelAPK	
						--Trả ra những AppraisalDictionaryID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @PAT10001temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				

					End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelAppraisalDictionaryID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @PAT10001temp) is Null)
				BEGIN
					Update @PAT10001temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @PAT10001temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
END
