IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP01202]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP01202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa mức hoa hồng 
-- Nếu xếp loại chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thị Phượng, Date: 17/08/2017
-- <Example> EXEC POSP01202 'KY', '', '9CD29FCA-786F-420D-BF9B-B8A845952023', 'POST01201',1, 0, NULL

CREATE PROCEDURE POSP01202 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),
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
						@DelAPK uniqueidentifier,
						@DelDivisionID VARCHAR(50),
						@DelCommissionRate VARCHAR(50),
						@DelIsCommon tinyint
				Declare @POST01201temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @POST01201temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, CommissionRate, IsCommon FROM POST01201 WITH (NOLOCK) WHERE Cast(APK as nvarchar(100)) IN ('''+@APKList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelCommissionRate, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @POST01201temp set Params = ISNULL(Params,'''') + @DelCommissionRate+'','' where MessageID = ''00ML000050''
					ELSE 
						Begin
							DELETE FROM POST01201 WHERE APK = @DelAPK	
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelCommissionRate, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST01201temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelCommissionRate  Varchar(50), 
						@DelIsCommon tinyint
				Declare @POST01201temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelCommissionRate = CommissionRate, @DelIsCommon = Isnull(IsCommon, 0)
				FROM POST01201 WITH (NOLOCK) WHERE Cast(APK as nvarchar(100)) = '''+@APK+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelCommissionRate
							End 
				INSERT INTO @POST01201temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @POST01201temp where Params is not null'
			EXEC (@sSQL)
			
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelCommissionRate VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @POST01201temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @POST01201temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, CommissionRate, IsCommon FROM POST01201 WITH (NOLOCK) WHERE Cast(APK as nvarchar(100)) IN ('''+@APKList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelCommissionRate, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @POST01201temp set Params = ISNULL(Params,'''') + @DelCommissionRate+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE POST01201 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE POST01201 SET Disabled = 0 WHERE APK = @DelAPK	
						--Trả ra những CommissionRate update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @POST01201temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				

					End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelCommissionRate, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @POST01201temp) is Null)
				BEGIN
					Update @POST01201temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @POST01201temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			print (@sSQL)
			
	END
END
