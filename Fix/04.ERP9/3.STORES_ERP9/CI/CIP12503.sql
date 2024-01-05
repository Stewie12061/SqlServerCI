IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12503]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/ Thêm mã chi tiết bảng giá bán
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng On 31/05/2016
-- <Example> EXEC CIP12503 'HT', 'BANGIA01.2015','EV1.5', 'OT1302', 1, NULL

CREATE PROCEDURE CIP12503 ( 
	@DivisionID varchar(50),
	@ID varchar(50),
	@InventoryID varchar(50),
	@TableID nvarchar(50),	-- "OT1302"	
	@Mode tinyint,			--0: Thêm, 1: Xóa
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
						@DelID VARCHAR(50),
						@DelInventoryID VARCHAR(50)
				Declare @OT1302temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @OT1302temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT Distinct DivisionID, ID, InventoryID FROM OT1302 WITH (NOLOCK) WHERE InventoryID IN ('''+@InventoryID+''') and ID = '''+@ID+'''
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelID, @DelInventoryID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID != '''+@DivisionID+''')
							update @OT1302temp set Params = ISNULL(Params,'''') + @DelInventoryID+'','' where MessageID = ''00ML000050''
					ELSE 
							DELETE FROM OT1302 WHERE InventoryID = @DelInventoryID and ID = @DelID
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelID, @DelInventoryID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @OT1302temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi thêm
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelID VARCHAR(50)
				Declare @OT1301temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelID = ID
				FROM OT1301 WITH (NOLOCK) WHERE ID = '''+@ID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' ) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelID
							End 
				INSERT INTO @OT1301temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @OT1301temp where Params is not null'
			EXEC (@sSQL)
	END
	
END