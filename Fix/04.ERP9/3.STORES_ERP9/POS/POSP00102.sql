IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa cửa hàng
-- Nếu mã mặt hàng chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 17/05/2016
-- Created by: Hoàng Vũ, Date: 20/12/2017 xử lý bổ sung check cho màn hình sửa  3: Sửa (Đóng/Mở sự kiện)
-- <Example> EXEC POSP00102 'TMQ3', 'CK', 'POSF0010', 2, 1, NULL

CREATE PROCEDURE POSP00102 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@ShopID varchar(50),
	@FormID nvarchar(50),	-- "POSF0010"	
	@Mode tinyint,			--0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable), 3: Sửa (Đóng/Mở sự kiện)
	@IsDisable  tinyint,	--1: Disable; 0: Enable
	@UserID Varchar(50)) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelShopID Varchar(50), 
						@DelIsCommon tinyint
				Declare @POST0010temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelShopID = ShopID, @DelIsCommon = Isnull(IsCommon, 0)
				FROM POST0010 WITH (NOLOCK) WHERE ShopID = '''+@ShopID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelIsCommon != 1) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelShopID
							End 
				INSERT INTO @POST0010temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @POST0010temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 2--Kiểm tra trước khi sửa Check Disable/Enable cửa hàng
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelShopID VARCHAR(50),
						@TranMonth int = null,
						@TranYear int = null,
						@APK uniqueidentifier=NULL
				Declare @POST0010temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @POST0010temp (	Status, MessageID, Params) 
								Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
							
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, ShopID FROM POST0010 WITH (NOLOCK) WHERE ShopID IN ('''+@ShopID+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelShopID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC POSP9000   @DelDivisionID, @DelShopID, @TranMonth, @TranYear,  @DelShopID, @APK , '''+@FormID+''', @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''')
							update @POST0010temp set Params = ISNULL(Params,'''') + @DelShopID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
						BEGIN
							IF (Select @Status) = 1 --Kiểm tra đã sử dụng
									update @POST0010temp set Params = ISNULL(Params,'''') + @DelShopID+'','' where MessageID = ''00ML000052''
							ELSE 
								UPDATE POST0010 SET Disabled = 1 WHERE ShopID = @DelShopID		
						END
						ELSE  --Nếu chọn là Enable
							UPDATE POST0010 SET Disabled = 0 WHERE ShopID = @DelShopID			

					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelShopID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST0010temp where Params is not null'
			EXEC (@sSQL)
			
	END
	ELSE IF @Mode = 3--Kiểm tra trước khi sửa Check Đóng/Mở event
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelShopID VARCHAR(50),
						@DelIsEvents  int = null,
						@TranMonth int = null,
						@TranYear int = null,
						@APK uniqueidentifier=NULL
				Declare @POST0010temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @POST0010temp (	Status, MessageID, Params) 
								Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000102'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, ShopID, IsEvents FROM POST0010 WITH (NOLOCK) WHERE ShopID IN ('''+@ShopID+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelShopID, @DelIsEvents
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''')
							update @POST0010temp set Params = ISNULL(Params,'''') + @DelShopID+'','' where MessageID = ''00ML000050''
					ELSE 
					Begin
						IF '+ Cast(@IsDisable as varchar(50)) +'=1 --Nếu chọn là Disable
						BEGIN
							EXEC POSP00103 @DelDivisionID, @DelShopID, NULL, @Status  output
							IF (Select @Status) = 1 --Kiểm tra--Event {0} tính đến thời điểm hiện tại vẫn còn tồn kho. Bạn phải kiểm tra xử lý hết tồn kho trước khi đóng event!
									update @POST0010temp set Params = ISNULL(Params,'''') + @DelShopID+'','' where MessageID = ''POSFML000102''
							ELSE 
								UPDATE POST0010 SET Disabled = 1 WHERE ShopID = @DelShopID and IsEvents = @DelIsEvents
						END
						ELSE  --Nếu chọn là Enable
							UPDATE POST0010 SET Disabled = 0 WHERE ShopID = @DelShopID and IsEvents = @DelIsEvents

					End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelShopID, @DelIsEvents
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST0010temp where Params is not null'
		
		
		
			EXEC (@sSQL)
			
	END
END