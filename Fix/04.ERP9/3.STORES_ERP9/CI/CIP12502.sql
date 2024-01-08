IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12502]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12502]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa mã loại chứng từ
-- Nếu mã mặt hàng chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 18/05/2016
-- Modified by: Hoài Bảo, Date: 29/08/2022 - Bổ sung DivisionID vào điều kiện xóa
-- <Example> EXEC CIP12502 'KC','BGBIGC11', 'OT1301', 1, 1, NULL

CREATE PROCEDURE CIP12502 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@ID NVARCHAR(MAX),
	@TableID nvarchar(50),		
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
						@DelDivisionID VARCHAR(50),
						@DelID VARCHAR(50)
				Declare @OT1301temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @OT1301temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											Union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, ID FROM OT1301 WITH (NOLOCK) WHERE ID IN ('''+@ID+''') AND DivisionID = ''' + @DivisionID + '''
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelID 
				WHILE @@FETCH_STATUS = 0
				
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, '''+@TableID+''',@DelID, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''')
							update @OT1301temp set Params = ISNULL(Params,'''') + @DelID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @OT1301temp set Params = ISNULL(Params,'''') + @DelID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM OT1301 WHERE ID = @DelID AND DivisionID = ''' + @DivisionID + '''
							DELETE FROM OT1302 WHERE ID = @DelID AND DivisionID = ''' + @DivisionID + '''
						End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @OT1301temp where Params is not null'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @StatusOUTPUT TINYINT,
						@Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelID varchar(50)
				Declare @OT1301temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelID = ID
				FROM OT1301 WITH (NOLOCK) WHERE ID = '''+@ID+''' 			
				IF (@DelDivisionID !='''+ @DivisionID+''') --Kiểm tra khac DivisionID 
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelID
							End 
				INSERT INTO @OT1301temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @OT1301temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelID VARCHAR(50)
				Declare @OT1301temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @OT1301temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, ID FROM '+@TableID+' WITH (NOLOCK) WHERE  ID IN ('''+@ID+''') 
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' )
							update @OT1301temp set Params = ISNULL(Params,'''') + @DelID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE OT1301 SET Disabled = 1 WHERE ID = @DelID 	
						ELSE  --Nếu chọn là Enable
							UPDATE OT1301 SET Disabled = 0 WHERE ID = @DelID			

					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @OT1301temp where Params is not null'
			EXEC (@sSQL)
	END

END