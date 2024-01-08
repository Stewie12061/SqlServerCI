IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10202]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP10202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa phân loại đầu mối
-- Nếu mã phân loại đầu mối chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thị Phượng, Date: 15/03/2017
-- Modify by Thị Phượng on 03/05/2017: trường hợp Disaled/ Enable Trả ra APK thay vì trả mã để lưu bảng Lịch sử
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
--- Modify by Thị Phượng, Date 11/10/2017 Comment out Xóa trong bảng Lịch sử
-- <Example> EXEC CRMP10202 'AS', 'THT', 'THT', 'CRMF10201', 2, 1, NULL

CREATE PROCEDURE CRMP10202 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@LeadTypeID varchar(50),
	@LeadTypeIDList NVARCHAR(MAX),
	@FormID nvarchar(50),	-- "CRMF10201"	
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
						@DelLeadTypeID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT10201temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10201temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, LeadTypeID, IsCommon FROM CRMT10201 WITH (NOLOCK) WHERE LeadTypeID IN ('''+@LeadTypeIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadTypeID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', ''CRMT10201'', NULL, @DelLeadTypeID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10201temp set Params = ISNULL(Params,'''') + @DelLeadTypeID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CRMT10201temp set Params = ISNULL(Params,'''') + @DelLeadTypeID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM CRMT10201 WHERE LeadTypeID = @DelLeadTypeID	
							--DELETE FROM CRMT00003 WHERE RelatedToID = convert(varchar(50), @DelAPK)
									
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadTypeID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT10201temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelLeadTypeID Varchar(50), 
						@DelIsCommon tinyint
				Declare @CRMT10201temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelLeadTypeID = LeadTypeID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM CRMT10201 WITH (NOLOCK) WHERE LeadTypeID = '''+@LeadTypeID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelLeadTypeID
							End 
				INSERT INTO @CRMT10201temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CRMT10201temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelLeadTypeID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT10201temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT10201temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, LeadTypeID, IsCommon FROM CRMT10201 WITH (NOLOCK) WHERE LeadTypeID IN ('''+@LeadTypeIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadTypeID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT10201temp set Params = ISNULL(Params,'''') + @DelLeadTypeID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE CRMT10201 SET Disabled = 1 WHERE LeadTypeID = @DelLeadTypeID		
						ELSE  --Nếu chọn là Enable
							UPDATE CRMT10201 SET Disabled = 0 WHERE LeadTypeID = @DelLeadTypeID	
						--Trả ra những LeadTypeID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @CRMT10201temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				

					End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadTypeID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @CRMT10201temp) is Null)
				BEGIN
					Update @CRMT10201temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @CRMT10201temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
END
