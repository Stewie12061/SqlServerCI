IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12302]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12302]
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
-- <Example> EXEC CIP12302 'Q7','AQ-3C', 'AT1314', 0, 2, NULL

CREATE PROCEDURE CIP12302 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@InventoryID NVARCHAR(MAX),
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
						@DelInventoryID VARCHAR(50)
				Declare @AT1314temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @AT1314temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, InventoryID FROM AT1314 WITH (NOLOCK) WHERE InventoryID IN ('''+@InventoryID+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelInventoryID 
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelDivisionID !=''@@@'')
							update @AT1314temp set Params = ISNULL(Params,'''') + @DelInventoryID+'','' where MessageID = ''00ML000050''
					ELSE 
						Begin
							DELETE FROM AT1314 WHERE InventoryID = @DelInventoryID
						End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelInventoryID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @AT1314temp where Params is not null'
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
						@DelInventoryID varchar(50)
				Declare @AT1314temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelInventoryID = InventoryID
				FROM AT1314 WITH (NOLOCK) WHERE InventoryID = '''+@InventoryID+''' 			
				IF (@DelDivisionID !='''+ @DivisionID+''' and @DelDivisionID !=''@@@'') --Kiểm tra khac DivisionID 
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelInventoryID
							End 
				INSERT INTO @AT1314temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @AT1314temp where Params is not null'
			EXEC (@sSQL)
	END

END