IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20302]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa đầu mối
-- Nếu mã đầu mối chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thị Phượng, Date: 15/03/2017
-- Modify by Thị Phượng on 03/05/2017: trường hợp Disaled/ Enable Trả ra APK thay vì trả mã để lưu bảng Lịch sử
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
--- Modify by Thị Phượng, Date 11/10/2017 Comment out Xóa trong bảng Lịch sử
--- Modify by Trọng Kiên, Date 06/10/2020: Fix lỗi xóa đầu mối (Invalid column RelatedToID) --> vì Email thay đổi cấu trúc
--- Modify by Anh Tuấn, Date 31/12/2021: Thay đổi giá trị DeleteFlg = 1 khi xóa
-- <Example> EXEC CRMP20302 'AS', null, 'DM01', 'CRMF2032', 2, 1, NULL

CREATE PROCEDURE CRMP20302 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@LeadID varchar(50),
	@LeadIDList NVARCHAR(MAX),
	@FormID nvarchar(50),	-- "CRMF2030"	
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
						@DelLeadID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT20301temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT20301temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, LeadID, IsCommon FROM CRMT20301 WITH (NOLOCK) WHERE LeadID IN ('''+@LeadIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', ''CRMT20301'', NULL, @DelLeadID, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT20301temp set Params = ISNULL(Params,'''') + @DelLeadID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CRMT20301temp set Params = ISNULL(Params,'''') + @DelLeadID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							-- Thay đổi biến DeleteFlg
							UPDATE CRMT20301 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK

							--DELETE FROM CRMT20301 WHERE LeadID = @DelLeadID	
							--DELETE FROM CRMT20301_CRMT20401_REL WHERE LeadID = convert(varchar(50), @DelAPK)
							--DELETE FROM AT1103_REL WHERE RelatedToID = convert(varchar(50),(select EventID From CRMT90051_REL where RelatedToID =convert(varchar(50), @DelAPK)))
							--DELETE FROM CRMT90051_REL WHERE RelatedToID = convert(varchar(50), @DelAPK)	
							--DELETE FROM CMNT90051_REL WHERE RelatedToID = convert(varchar(50), @DelAPK)	
							--DELETE FROM CRMT00002_REL WHERE RelatedToID = convert(varchar(50), @DelAPK)	
							--DELETE FROM CRMT00003 WHERE RelatedToID = convert(varchar(50), @DelAPK)	
							--DELETE FROM CRMT90031_REL WHERE RelatedToID = convert(varchar(50), @DelAPK)	
							--DELETE FROM CRMT90041_REL WHERE RelatedToID = convert(varchar(50), @DelAPK)

							--Xóa các định vị của Lead
							--IF EXISTS(SELECT TOP 1 * FROM CustomerIndex WHERE CustomerName = 130)
							--BEGIN
								--DELETE FROM CRMT20302 WHERE APKMaster = @DelAPK
							--END
									
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadID, @DelIsCommon
				Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT20301temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelLeadID Varchar(50), 
						@DelIsCommon tinyint
				Declare @CRMT20301temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelLeadID = LeadID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM CRMT20301 WITH (NOLOCK) WHERE LeadID = '''+@LeadID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelLeadID
							End 
				INSERT INTO @CRMT20301temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CRMT20301temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelLeadID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CRMT20301temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT20301temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, LeadID, IsCommon FROM CRMT20301 WITH (NOLOCK) WHERE LeadID IN ('''+@LeadIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CRMT20301temp set Params = ISNULL(Params,'''') + @DelLeadID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE CRMT20301 SET Disabled = 1 WHERE LeadID = @DelLeadID		
						ELSE  --Nếu chọn là Enable
							UPDATE CRMT20301 SET Disabled = 0 WHERE LeadID = @DelLeadID	
						
						--Trả ra những LeadID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @CRMT20301temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''			

					End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelLeadID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @CRMT20301temp) is Null)
				BEGIN
					Update @CRMT20301temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @CRMT20301temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
