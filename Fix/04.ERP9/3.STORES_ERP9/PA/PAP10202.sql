IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[PAP10202]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[PAP10202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa thiết lập bảng đánh giá năng lực từng vị trí
-- Nếu ID chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo messageID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 17/08/2017
-- <Example> EXEC PAP10202 'AS', '', '', 'PAT10201', 1, 0, NULL

CREATE PROCEDURE PAP10202 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@EvaluationKitID NVARCHAR(MAX),
	@EvaluationKitIDList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- PAT10201
	@Mode tinyint,			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable  tinyint,	--1: Disable; 0: Enable
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
						@DelEvaluationKitID Varchar(50),
						@DelIsCommon tinyint
				Declare @PAT10201temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @PAT10201temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, EvaluationKitID, IsCommon
				FROM PAT10201 WITH (NOLOCK) WHERE EvaluationKitID IN ('''+@EvaluationKitIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEvaluationKitID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC PAP90000 @DelDivisionID, '''+@TableID+''', @DelEvaluationKitID, @Status OUTPUT

					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @PAT10201temp set Params = ISNULL(Params,'''') + @DelEvaluationKitID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @PAT10201temp set Params = ISNULL(Params,'''') + @DelEvaluationKitID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM PAT10201 WHERE APK = @DelAPK
							DELETE FROM PAT10202 WHERE APKMaster = @DelAPK
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEvaluationKitID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @PAT10201temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelEvaluationKitID  Varchar(50),
						@DelIsCommon tinyint
				Declare @PAT10201temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelEvaluationKitID = EvaluationKitID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM PAT10201 WITH (NOLOCK) WHERE EvaluationKitID = '''+@EvaluationKitID+'''
				
				IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1) --Kiểm tra khac DivisionID và khác dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelEvaluationKitID
							End 
			
				INSERT INTO @PAT10201temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @PAT10201temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelEvaluationKitID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @PAT10201temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @PAT10201temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, EvaluationKitID, IsCommon FROM PAT10201 WITH (NOLOCK) WHERE EvaluationKitID IN ('''+@EvaluationKitIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEvaluationKitID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @PAT10201temp set Params = ISNULL(Params,'''') + @DelEvaluationKitID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE PAT10201 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE PAT10201 SET Disabled = 0 WHERE APK = @DelAPK	
						--Trả ra những EvaluationKitID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @PAT10201temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				

					End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEvaluationKitID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @PAT10201temp) is Null)
				BEGIN
					Update @PAT10201temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @PAT10201temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
	
END
