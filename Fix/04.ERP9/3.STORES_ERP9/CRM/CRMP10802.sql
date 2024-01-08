IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10802]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP10802]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách hành động
-- Nếu mã hành động chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Nguyễn Thị Lệ Huyền, Date: 22/03/2017
-- Modified by : Thị Phượng, 07/04/2017 truyền thêm biến TableID vào Store CRMP90000 ( mặc định giá tri Null)
-- Modify by Thị Phượng on 03/05/2017: trường hợp Disaled/ Enable Trả ra APK thay vì trả mã để lưu bảng Lịch sử
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
-- <Example> EXEC CRMP10802 'AS', '', '', 'CRMF1080', 2, 0, NULL

CREATE PROCEDURE CRMP10802 ( 
	@DivisionID varchar(50), --Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@NextActionID varchar(50),		--Trường hợp sửa
	@NextActionIDList NVARCHAR(MAX),	--Trường hợp xóa hoặc xử lý enable/disable
	@FormID nvarchar(50),	-- "CRMF1080"	
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
						@DelAPKNextActionID VARCHAR(50),
						@DelNextActionID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT10801temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10801temp (Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK , DivisionID, NextActionID, IsCommon FROM CRMT10801 WITH (NOLOCK) WHERE NextActionID IN ('''+@NextActionIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKNextActionID, @DelDivisionID, @DelNextActionID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', NULL, NULL, @DelNextActionID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10801temp set Params = ISNULL(Params,'''') + @DelNextActionID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CRMT10801temp set Params = ISNULL(Params,'''') + @DelNextActionID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM CRMT10801 WHERE APK = @DelAPKNextActionID
								
						End
					FETCH NEXT FROM @Cur INTO @DelAPKNextActionID, @DelDivisionID, @DelNextActionID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT10801temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelNextActionID Varchar(50), 
						@DelIsCommon tinyint
				Declare @CRMT10801temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelNextActionID = NextActionID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM CRMT10801 WITH (NOLOCK) WHERE NextActionID = '''+@NextActionID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelNextActionID
							End 
				INSERT INTO @CRMT10801temp (Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CRMT10801temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKNextActionID VARCHAR(50),
						@DelNextActionID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT10801temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10801temp (Status, MessageID, Params, UpdateSuccess) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params, Null as UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, NextActionID, IsCommon FROM CRMT10801 WITH (NOLOCK) WHERE NextActionID IN ('''+@NextActionIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKNextActionID, @DelDivisionID, @DelNextActionID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10801temp set Params = ISNULL(Params,'''') + @DelNextActionID+'',''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE CRMT10801 SET Disabled = 1 WHERE APK = @DelAPKNextActionID		
						ELSE  --Nếu chọn là Enable
							UPDATE CRMT10801 SET Disabled = 0 WHERE APK = @DelAPKNextActionID			
					--Lưu lịch sử khi Disable/Enable		
						update @CRMT10801temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPKNextActionID+'',''
					End
					FETCH NEXT FROM @Cur INTO @DelAPKNextActionID, @DelDivisionID, @DelNextActionID, @DelIsCommon
				END
				CLOSE @Cur
				IF ((SELECT Params from @CRMT10801temp) is Null)
				BEGIN
					Update @CRMT10801temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess
				 From  @CRMT10801temp where Params is not null or UpdateSuccess is not null'
				 --Print(@sSQL)
			EXEC (@sSQL)
			
	END
END