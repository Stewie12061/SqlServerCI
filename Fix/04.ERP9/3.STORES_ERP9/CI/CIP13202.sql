IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP13202]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP13202]
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
-- <Example> EXEC CIP13202 'KC','SOD'',''G1', 'AT1007', 1, 2, NULL

CREATE PROCEDURE CIP13202 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@VoucherTypeID NVARCHAR(MAX),
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
						@DelVoucherTypeID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @AT1007temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @AT1007temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, VoucherTypeID, IsCommon FROM '+@TableID+' WITH (NOLOCK) WHERE VoucherTypeID IN ('''+@VoucherTypeID+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelVoucherTypeID,  @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, '''+@TableID+''',@DelVoucherTypeID, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @AT1007temp set Params = ISNULL(Params,'''') + @DelVoucherTypeID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @AT1007temp set Params = ISNULL(Params,'''') + @DelVoucherTypeID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							DELETE FROM '+@TableID+' WHERE VoucherTypeID = @DelVoucherTypeID 
						End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelVoucherTypeID, @DelIsCommon
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @AT1007temp where Params is not null'
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
						@DelVoucherTypeID varchar(50),
						@DelIsCommon tinyint
				Declare @AT1007temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelVoucherTypeID = VoucherTypeID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM '+@TableID+' WITH (NOLOCK) WHERE VoucherTypeID = '''+@VoucherTypeID+''' 			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelVoucherTypeID
							End 
				INSERT INTO @AT1007temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @AT1007temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelVoucherTypeID VARCHAR(50),
						@DelIsCommon tinyint
				Declare @AT1007temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @AT1007temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, VoucherTypeID, IsCommon FROM '+@TableID+' WITH (NOLOCK) WHERE  VoucherTypeID IN ('''+@VoucherTypeID+''') 
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelVoucherTypeID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @AT1007temp set Params = ISNULL(Params,'''') + @DelVoucherTypeID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
							UPDATE '+@TableID+' SET Disabled = 1 WHERE VoucherTypeID = @DelVoucherTypeID 	
						ELSE  --Nếu chọn là Enable
							UPDATE '+@TableID+' SET Disabled = 0 WHERE VoucherTypeID = @DelVoucherTypeID			

					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelVoucherTypeID, @DelIsCommon
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @AT1007temp where Params is not null'
			EXEC (@sSQL)
	END

END