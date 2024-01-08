IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP13102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP13102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa mã phân tích
-- Nếu mã mặt hàng chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 18/05/2016
-- <Example> EXEC CIP13102 'KC', 'A02'',''A03', '07003'',''03006'',''08003'',''1K001-032',4,  'AT1011',1, 0, 'Asoft'

CREATE PROCEDURE CIP13102 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@AnaTypeID NVARCHAR(MAX),
	@AnaID varchar(50),
	@GroupID nvarchar(50),	--1:Nghiệp vụ (AT1011), 2 và 3: Đối tượng/mặt hàng
	@TableID nvarchar(50)=null,		
	@Mode tinyint,			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable  tinyint,	--1: Disable; 0: Enable
	@UserID Varchar(50)) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)
	IF @GroupID =1 --Kiểm tra nhóm
		SET @sSQL1='SELECT DivisionID, AnaTypeID, AnaID, IsCommon, ''AT1011'' AS TableID FROM AT1011 With (NOLOCK) WHERE AnaTypeID IN ('''+@AnaTypeID+''') AND AnaID IN ('''+@AnaID+''')
'
	ELSE  IF (@GroupID =2 OR @GroupID =3)
		SET @sSQL1='SELECT DivisionID, AnaTypeID, AnaID, IsCommon, ''AT1015'' AS TableID FROM AT1015 With (NOLOCK) WHERE AnaTypeID IN ('''+@AnaTypeID+''') AND AnaID IN ('''+@AnaID+''')
'	ELSE 
		SET @sSQL1='SELECT DivisionID, AnaTypeID, AnaID, IsCommon, ''AT1011'' AS TableID FROM AT1011 With (NOLOCK) WHERE AnaTypeID IN ('''+@AnaTypeID+''') AND AnaID IN ('''+@AnaID+''')
					Union ALL
					SELECT DivisionID, AnaTypeID, AnaID, IsCommon, ''AT1015'' AS TableID FROM AT1015 With (NOLOCK) WHERE AnaTypeID IN ('''+@AnaTypeID+''') AND AnaID IN ('''+@AnaID+''')
'
	IF @Mode = 1 --Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAnaTypeID VARCHAR(50),
						@DelAnaID VARCHAR(50),
						@DelIsCommon tinyint,
						@DelTableID VARCHAR(50)
				Declare @AT0005temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @AT0005temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				'+@sSQL1+'
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAnaTypeID, @DelAnaID, @DelIsCommon, @DelTableID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, @DelTableID ,@DelAnaID, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @AT0005temp set Params = ISNULL(Params,'''') + @DelAnaID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @AT0005temp set Params = ISNULL(Params,'''') + @DelAnaID+'',''  where MessageID = ''00ML000052''
					ELSE 
					Begin
						If (@DelTableID=''AT1011'')
							DELETE FROM AT1011 WHERE AnaTypeID = @DelAnaTypeID and AnaID = @DelAnaID
						else DELETE FROM AT1015 WHERE AnaTypeID = @DelAnaTypeID and AnaID = @DelAnaID
					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAnaTypeID, @DelAnaID, @DelIsCommon, @DelTableID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @AT0005temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @StatusOUTPUT TINYINT,
						@Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelAnaTypeID VARCHAR(50),
						@DelAnaID Varchar(50), 
						@DelIsCommon tinyint
				Declare @AT0005temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				If ('+@GroupID+'=1)
					SELECT @DelDivisionID = DivisionID, @DelAnaTypeID =AnaTypeID,  @DelAnaID = AnaID, @DelIsCommon = Isnull(IsCommon, 0)
					FROM AT1011 With (NOLOCK) WHERE AnaTypeID = '''+@AnaTypeID+''' and AnaID = '''+@AnaID+'''	
				If ('+@GroupID+'=2 or '+@GroupID+'=3 )	
					SELECT @DelDivisionID = DivisionID, @DelAnaTypeID =AnaTypeID,  @DelAnaID = AnaID, @DelIsCommon = Isnull(IsCommon, 0)
					FROM AT1015 With (NOLOCK) WHERE AnaTypeID = '''+@AnaTypeID+''' and AnaID = '''+@AnaID+'''
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelAnaID
							End 
				INSERT INTO @AT0005temp (Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @AT0005temp where Params is not null'
			EXEC (@sSQL)

	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAnaTypeID VARCHAR(50),
						@DelAnaID Varchar(50),
						@DelIsCommon tinyint,
						@DelTableID VARCHAR(50)
				Declare @AT0005temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @AT0005temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				'+@sSQL1+'
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAnaTypeID, @DelAnaID, @DelIsCommon, @DelTableID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, @DelTableID ,@DelAnaID, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @AT0005temp set Params = ISNULL(Params,'''') + @DelAnaID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						If(@DelTableID=''AT1011'')
							IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
								UPDATE AT1011 
								SET Disabled = 1 ,
								LastModifyUserID = '''+Isnull(@UserID, '''')+''', 
								LastModifyDate = GETDATE()
								WHERE AnaTypeID = @DelAnaTypeID and AnaID = @DelAnaID		
							ELSE  --Nếu chọn là Enable
								UPDATE AT1011 
								SET Disabled = 0 ,
								LastModifyUserID = '''+Isnull(@UserID, '''')+''', 
								LastModifyDate = GETDATE()
								WHERE AnaTypeID = @DelAnaTypeID and AnaID = @DelAnaID			
						Else 
							IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
								UPDATE AT1015 
								SET Disabled = 1,
								LastModifyUserID = '''+Isnull(@UserID, '''')+''', 
								LastModifyDate = GETDATE() 
								WHERE AnaTypeID = @DelAnaTypeID and AnaID = @DelAnaID		
							ELSE  --Nếu chọn là Enable
								UPDATE AT1015 
								SET Disabled = 0,
								LastModifyUserID = '''+Isnull(@UserID, '''')+''', 
								LastModifyDate = GETDATE()
								WHERE AnaTypeID = @DelAnaTypeID and AnaID = @DelAnaID
					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAnaTypeID, @DelAnaID, @DelIsCommon, @DelTableID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @AT0005temp where Params is not null'
			EXEC (@sSQL)
	END

END