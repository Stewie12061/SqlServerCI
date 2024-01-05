IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP15202]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP15202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa mã chương trình khuyến mãi theo điều kiện
-- Nếu mã hàng khuyến mãi chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Lê Thanh Lượng, Date: 11/05/2023
----Modify  by: Lê Thanh Lượng, Date: 07/11/2023 - [2023/10/IS/0095]: Bổ sung phiếu đã duyệt không được sửa/xóa.
-- <Example>
-- <Example> EXEC CIP15202 'HT', 'OOO', 'OOO', 'CIT1220', 1, 1, NULL

CREATE PROCEDURE CIP15202 ( 
	 @DivisionID nvarchar(50),
	 @PromoteID nvarchar(50),
	 @PromoteIDList nvarchar(Max),
	 @TableID nvarchar(50),
	 @Mode tinyint,   --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	 @IsDisable  tinyint, --1: Disable; 0: Enable
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
						@DelPromoteID VARCHAR(50),
						@DelIsCommon tinyint,
						@DelStatusSS tinyint
				Declare @CIT1220temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CIT1220temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
												union all
											Select 2 as Status, ''CIFML00101'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, PromoteID, IsCommon, StatusSS  FROM CIT1220 WITH (NOLOCK) WHERE PromoteID IN ('''+@PromoteIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelPromoteID, @DelIsCommon, @DelStatusSS
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, '''+@TableID+''',@DelPromoteID, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CIT1220temp set Params = ISNULL(Params,'''') + @DelPromoteID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CIT1220temp set Params = ISNULL(Params,'''') + @DelPromoteID+'',''  where MessageID = ''00ML000052''
					ELSE IF (Select @DelStatusSS) = 1
					BEGIN
							update @CIT1220temp set Params = ISNULL(Params,'''') + @DelPromoteID+'',''  where MessageID = ''CIFML00101''
					END
					ELSE 
						Begin
							DELETE FROM CIT1222 WHERE APKMaster  = (Select APK From CIT1221 Where PromoteID = @DelPromoteID)
							DELETE FROM CIT1221 WHERE PromoteID = @DelPromoteID
							DELETE FROM CIT1220 WHERE PromoteID = @DelPromoteID
						End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelPromoteID, @DelIsCommon, @DelStatusSS
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CIT1220temp where Params is not null'
			print (@sSQL)
			EXEC (@sSQL)
			
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelPromoteID Varchar(50), 
						@DelIsCommon tinyint
				Declare @CIT1220temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelPromoteID = PromoteID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM CIT1220 WITH (NOLOCK) WHERE PromoteID = '''+@PromoteID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelPromoteID
							End 
				INSERT INTO @CIT1220temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CIT1220temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelPromoteID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @CIT1220temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CIT1220temp (	Status, MessageID, Params) 
				Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, PromoteID, IsCommon FROM CIT1220 WITH (NOLOCK) WHERE PromoteID IN ('''+@PromoteIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelPromoteID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @CIT1220temp set Params = ISNULL(Params,'''') + @DelPromoteID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
						Begin	
							UPDATE CIT1220 SET Disabled = 1 WHERE PromoteID = @DelPromoteID		
							UPDATE CIT1221 SET Disabled = 1 WHERE PromoteID = @DelPromoteID
						End
						ELSE  --Nếu chọn là Enable
						begin
							UPDATE CIT1220 SET Disabled = 0 WHERE PromoteID = @DelPromoteID			
							UPDATE CIT1221 SET Disabled = 0 WHERE PromoteID = @DelPromoteID			
						End

					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelPromoteID, @DelIsCommon
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CIT1220temp where Params is not null'
			EXEC (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
