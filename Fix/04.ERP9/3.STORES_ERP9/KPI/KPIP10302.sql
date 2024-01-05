IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10302]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[KPIP10302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa nguồn đo
-- Nếu ID chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo messageID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 15/08/2017
-- <Example> EXEC KPIP10302 'AS', '', '', 'KPIT10301', 1, 0, NULL

CREATE PROCEDURE KPIP10302 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@SourceID NVARCHAR(MAX),
	@SourceIDList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- KPIT10301
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
						@DelSourceID Varchar(50),
						@DelIsCommon tinyint
				Declare @KPIT10301temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @KPIT10301temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, SourceID, IsCommon 
				FROM KPIT10301 WITH (NOLOCK) WHERE SourceID IN ('''+@SourceIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelSourceID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC KPIP90000 @DelDivisionID, '''+@TableID+''', @DelSourceID, @Status OUTPUT

					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @KPIT10301temp set Params = ISNULL(Params,'''') + @DelSourceID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @KPIT10301temp set Params = ISNULL(Params,'''') + @DelSourceID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM KPIT10301 WHERE APK = @DelAPK	
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelSourceID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @KPIT10301temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelSourceID  Varchar(50), 
						@DelIsCommon tinyint
				Declare @KPIT10301temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelSourceID = SourceID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM KPIT10301 WITH (NOLOCK) WHERE SourceID = '''+@SourceID+'''
				
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelSourceID
							End 
			
				INSERT INTO @KPIT10301temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @KPIT10301temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelSourceID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @KPIT10301temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @KPIT10301temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, SourceID, IsCommon FROM KPIT10301 WITH (NOLOCK) WHERE SourceID IN ('''+@SourceIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelSourceID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @KPIT10301temp set Params = ISNULL(Params,'''') + @DelSourceID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE KPIT10301 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE KPIT10301 SET Disabled = 0 WHERE APK = @DelAPK	
						--Trả ra những SourceID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @KPIT10301temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				

					End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelSourceID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @KPIT10301temp) is Null)
				BEGIN
					Update @KPIT10301temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @KPIT10301temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
END
