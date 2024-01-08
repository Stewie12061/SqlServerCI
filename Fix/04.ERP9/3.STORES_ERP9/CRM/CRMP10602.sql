IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10602]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP10602]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa danh sách loại hình bán hàng
-- Nếu mã loại hình chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Nguyễn Thị Lệ Huyền, Date: 20/03/2017
-- Modified by : Thị Phượng, 07/04/2017 truyền thêm biến TableID vào Store CRMP90000 ( mặc định giá tri Null)
-- Modify by Thị Phượng on 03/05/2017: trường hợp Disaled/ Enable Trả ra APK thay vì trả mã để lưu bảng Lịch sử
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
-- <Example> EXEC CRMP10602 'AS', '', '', 'CRMF1060', 2, 0, NULL

CREATE PROCEDURE CRMP10602 ( 
	@DivisionID varchar(50), --Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@SalesTagID varchar(50),		--Trường hợp sửa
	@SalesTagIDList NVARCHAR(MAX),	--Trường hợp xóa hoặc xử lý enable/disable
	@FormID nvarchar(50),	-- "CRMF1060"	
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
						@DelAPKSalesTagID VARCHAR(50),
						@DelSalesTagID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT10601temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10601temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK , DivisionID, SalesTagID, IsCommon FROM CRMT10601 WITH (NOLOCK) WHERE SalesTagID IN ('''+@SalesTagIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKSalesTagID, @DelDivisionID, @DelSalesTagID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', NULL, NULL, @DelSalesTagID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10601temp set Params = ISNULL(Params,'''') + @DelSalesTagID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CRMT10601temp set Params = ISNULL(Params,'''') + @DelSalesTagID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM CRMT10601 WHERE APK = @DelAPKSalesTagID
								
						End					
					FETCH NEXT FROM @Cur INTO @DelAPKSalesTagID, @DelDivisionID, @DelSalesTagID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT10601temp where Params is not null'
			EXEC (@sSQL)
			--print (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelSalesTagID Varchar(50), 
						@DelIsCommon tinyint
				Declare @CRMT10601temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelSalesTagID = SalesTagID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM CRMT10601 WITH (NOLOCK) WHERE SalesTagID = '''+@SalesTagID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelSalesTagID
							End 
				INSERT INTO @CRMT10601temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CRMT10601temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKSalesTagID VARCHAR(50),
						@DelSalesTagID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT10601temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10601temp (Status, MessageID, Params, UpdateSuccess) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params, Null as UpdateSuccess
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, SalesTagID, IsCommon FROM CRMT10601 WITH (NOLOCK) WHERE SalesTagID IN ('''+@SalesTagIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKSalesTagID, @DelDivisionID, @DelSalesTagID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10601temp set Params = ISNULL(Params,'''') + @DelSalesTagID+'',''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE CRMT10601 SET Disabled = 1 WHERE APK = @DelAPKSalesTagID		
						ELSE  --Nếu chọn là Enable
							UPDATE CRMT10601 SET Disabled = 0 WHERE APK = @DelAPKSalesTagID			
					--Lưu lịch sử khi Disable/Enable		
						update @CRMT10601temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPKSalesTagID+'',''
					End
					FETCH NEXT FROM @Cur INTO @DelAPKSalesTagID, @DelDivisionID, @DelSalesTagID, @DelIsCommon
				END
				CLOSE @Cur
				IF ((SELECT Params from @CRMT10601temp) is Null)
				BEGIN
					Update @CRMT10601temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess
				 From  @CRMT10601temp where Params is not null or UpdateSuccess is not null'
				 --Print (@sSQL)
			EXEC (@sSQL)
			
	END
END
