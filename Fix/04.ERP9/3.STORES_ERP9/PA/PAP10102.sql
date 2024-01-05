IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[PAP10102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[PAP10102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa năng lực
-- Nếu xếp loại chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 25/08/2017
-- Edited by: hoàng vũ, Date: 06/10/2017 Chỉnh sửa năng lực từ bảng master thành master-Detail, quản lý theo kỳ
-- <Example> EXEC PAP10102 'AS', '', '', 'PAT10101', 2, 1, NULL

CREATE PROCEDURE PAP10102 ( 
	 @DivisionID  varchar(50),					--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	 @AppraisalID  NVARCHAR(MAX),
	 @AppraisalIDList  NVARCHAR(MAX),
	 @TableID   varchar(50),					--PAT10101
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
						@Message NVARCHAR(1010),
						@Cur CURSOR,
						@DelAPK Varchar(50),
						@DelAppraisalID Varchar(50),
						@DelIsCommon tinyint
				Declare @PAT10101temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @PAT10101temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, AppraisalID, IsCommon 
				FROM PAT10101 WITH (NOLOCK) WHERE AppraisalID IN ('''+@AppraisalIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelAppraisalID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC PAP90000 NULL, '''+@TableID+''', @DelAppraisalID, @Status OUTPUT

					IF (Select @Status) = 1
							update @PAT10101temp set Params = ISNULL(Params,'''') + @DelAppraisalID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM PAT10101 WHERE APK = @DelAPK
							DELETE FROM PAT10102 WHERE APKMaster = @DelAPK
							DELETE FROM PAT10103 WHERE APKMaster = @DelAPK	
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelAppraisalID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @PAT10101temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1010),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelAppraisalID  Varchar(50), 
						@DelIsCommon tinyint
				Declare @PAT10101temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT Status, MessageID,Params From  @PAT10101temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1010),
						@Cur CURSOR,
						@DelAppraisalID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @PAT10101temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @PAT10101temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, AppraisalID, IsCommon FROM PAT10101 WITH (NOLOCK) WHERE AppraisalID IN ('''+@AppraisalIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelAppraisalID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE PAT10101 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE PAT10101 SET Disabled = 0 WHERE APK = @DelAPK	
						--Trả ra những AppraisalID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @PAT10101temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				

					FETCH NEXT FROM @Cur INTO @DelAPK, @DelAppraisalID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @PAT10101temp) is Null)
				BEGIN
					Update @PAT10101temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @PAT10101temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
	Print (@sSQL)
END
