IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[KPIP10102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa nhóm chỉ tiêu KPI/DGNL
-- Nếu xếp loại chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 11/08/2017
-- Edited by: Hoàng vũ, Date: 03/10/2017: Do nghiệp vụ đặt biệt chỉ, DivisionID chỉ lưu lưới lưới Detail phụ thuộc vào check [Dung chung], nên bỏ qua chức năng kiểm tra khác DivisionID
-- <Example> EXEC KPIP10102 'AS', '', '', 'KPIT10101', 2, 0, NULL

CREATE PROCEDURE KPIP10102 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@TargetsGroupID NVARCHAR(MAX),
	@TargetsGroupIDList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- KPIT10101
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
						@DelTargetsGroupID Varchar(50),
						@DelIsCommon tinyint
				Declare @KPIT10101temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @KPIT10101temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, TargetsGroupID, IsCommon 
				FROM KPIT10101 WITH (NOLOCK) WHERE TargetsGroupID IN ('''+@TargetsGroupIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsGroupID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC KPIP90000 NULL, '''+@TableID+''', @DelTargetsGroupID, @Status OUTPUT

					IF (Select @Status) = 1
							update @KPIT10101temp set Params = ISNULL(Params,'''') + @DelTargetsGroupID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM KPIT10101 WHERE APK = @DelAPK	
							DELETE FROM KPIT10102 WHERE APKMaster = @DelAPK	
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsGroupID, @DelIsCommon
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @KPIT10101temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelTargetsGroupID  Varchar(50), 
						@DelIsCommon tinyint
				Declare @KPIT10101temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				
				SET @Message = ''00ML000050'' 
				SET	@Status = 2
				SET @Params = NULL

				SELECT Status, MessageID,Params From  @KPIT10101temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelTargetsGroupID VARCHAR(50),
						@DelAPK VARCHAR(50),
						@DelIsCommon tinyint
				Declare @KPIT10101temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000),
						UpdateSuccess varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @KPIT10101temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, TargetsGroupID, IsCommon FROM KPIT10101 WITH (NOLOCK) WHERE TargetsGroupID IN ('''+@TargetsGroupIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsGroupID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE KPIT10101 SET Disabled = 1 WHERE APK = @DelAPK		
						ELSE  --Nếu chọn là Enable
							UPDATE KPIT10101 SET Disabled = 0 WHERE APK = @DelAPK	
						--Trả ra những TargetsGroupID update thành công để Dev Lưu lịch sử cho trường hợp Disable/Enable		
						update @KPIT10101temp set UpdateSuccess = ISNULL(UpdateSuccess,'''') + @DelAPK+'',''				
					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelTargetsGroupID, @DelIsCommon
				END
				CLOSE @Cur
				--Kiểm tra trường hợp nếu không có ID nào ở Params thì không trả về messageID
				IF ((SELECT Params from @KPIT10101temp) is Null)
				BEGIN
					Update @KPIT10101temp set MessageID = Null, Status = Null
				END
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params, LEFT(UpdateSuccess,LEN(UpdateSuccess) - 1) AS UpdateSuccess 
				From  @KPIT10101temp where Params is not null or UpdateSuccess is not null'
			EXEC (@sSQL)
			
	END
END
