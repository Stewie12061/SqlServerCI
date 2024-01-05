IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10402]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP10402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách giai đoạnt thực hiện
-- Nếu mã giai đoạn chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Nguyễn Thị Lệ Huyền, Date: 20/03/2017
-- Modified by : Thị Phượng, 07/04/2017 truyền thêm biến TableID vào Store CRMP90000 ( mặc định giá tri Null)
-- Modify by Thị Phượng on 03/05/2017: trường hợp Disaled/ Enable Trả ra APK thay vì trả mã để lưu bảng Lịch sử
----Editted by: Hoàng Vũ, Date: 23/05/2017  Bổ sung load thêm cột [loại giai đoạn]: StageType, StageTypeName, [Là hệ thống]: IsSystem (quản lý giá trị người dùng nhập hay giá trị của hệ thống)
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
---- Modified by Thị Phượng, Date 14/07/2017 Fix bug exception
---- Modified by Ngọc Long, Date 02/07/2021 Set @Status = 2 để kiểm tra có phải là trạng thái hệ thống không, nếu phải thì không được xóa
-- <Example> EXEC CRMP10402 'A1S', '','Stage1'',''Stage2'',''Stage3', 'CRMF1040', 2, 1, NULL

CREATE PROCEDURE CRMP10402 ( 
	@DivisionID varchar(50), --Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@StageID varchar(50),		--Trường hợp sửa
	@StageIDList NVARCHAR(MAX),	--Trường hợp xóa hoặc xử lý enable/disable
	@FormID nvarchar(50),	-- "CRMF1040"	
	@Mode tinyint,			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable  tinyint,	--1: Disable; 0: Enable
	@UserID Varchar(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKStageID VARCHAR(50),
						@DelStageID VARCHAR(50),
						@DelIsCommon tinyint,
						@DelIsSystem int
				Declare @CRMT10401temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10401temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000091'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK , DivisionID, StageID, IsCommon, IsSystem FROM CRMT10401 WITH (NOLOCK) WHERE StageID IN ('''+@StageIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKStageID, @DelDivisionID, @DelStageID, @DelIsCommon, @DelIsSystem
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', NULL, NULL, @DelStageID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10401temp set Params = ISNULL(Params,'''') + @DelStageID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CRMT10401temp set Params = ISNULL(Params,'''') + @DelStageID+'',''  where MessageID = ''00ML000052''
					ELSE IF @DelIsSystem = 1
							update @CRMT10401temp set Params = ISNULL(Params,'''') + @DelStageID+'',''  where MessageID = ''00ML000091''
					ELSE IF @Status = 2
							UPDATE @CRMT10401temp SET Params = ISNULL(Params, '''') + @DelStageID + '', '' WHERE MessageID = ''00ML000091''
					ELSE 
						Begin
							DELETE FROM CRMT10401 WHERE APK = @DelAPKStageID
								
						End
					FETCH NEXT FROM @Cur INTO @DelAPKStageID, @DelDivisionID, @DelStageID, @DelIsCommon, @DelIsSystem
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT10401temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelStageID Varchar(50), 
						@DelIsCommon tinyint
				Declare @CRMT10401temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelStageID = StageID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM CRMT10401 WITH (NOLOCK) WHERE StageID = '''+@StageID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelStageID
							End 
				INSERT INTO @CRMT10401temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CRMT10401temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKStageID VARCHAR(50),
						@DelStageID VARCHAR(50),
						@DelIsCommon tinyint,
						@DelIsSystem int
				Declare @CRMT10401temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10401temp (	Status, MessageID, Params, UpdateSuccess) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params, Null as UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, StageID, IsCommon, IsSystem FROM CRMT10401 WITH (NOLOCK) WHERE StageID IN ('''+@StageIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKStageID, @DelDivisionID, @DelStageID, @DelIsCommon,@DelIsSystem
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10401temp set Params = ISNULL(Params,'''') + @DelStageID+'','' 
					ELSE IF @DelIsSystem = 1
							update @CRMT10401temp set Params = ISNULL(Params,'''') + @DelStageID+'',''  where MessageID = ''00ML000091''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE CRMT10401 SET Disabled = 1 WHERE APK = @DelAPKStageID		
						ELSE  --Nếu chọn là Enable
							UPDATE CRMT10401 SET Disabled = 0 WHERE APK = @DelAPKStageID			
						--Lưu lịch sử khi Disable/Enable		
						update @CRMT10401temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPKStageID+'',''
					End
					FETCH NEXT FROM @Cur INTO @DelAPKStageID, @DelDivisionID, @DelStageID, @DelIsCommon,@DelIsSystem
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Top 1 Params from @CRMT10401temp) is Null)
				BEGIN
					Update @CRMT10401temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params ,LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) as UpdateSuccess
				From  @CRMT10401temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			print @sSQL
	END
END
