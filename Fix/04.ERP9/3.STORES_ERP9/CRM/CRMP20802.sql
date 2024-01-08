IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20802]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20802]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa yêu cầu
-- Nếu mã yêu cầu chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thị Phượng, Date: 15/03/2017
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
--- Modify by Thị Phượng, Date 11/10/2017 Comment out Xóa trong bảng Lịch sử
--- Modify by Anh Tuấn, Date 31/12/2021: Thay cách xóa mới (thay đổi giá trị DeleteFlg = 1)
-- <Example> EXEC CRMP20802 'AS', '60', '60', 'CRMF20801', 1, NULL

CREATE PROCEDURE CRMP20802 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@RequestID varchar(50),
	@RequestIDList NVARCHAR(MAX),
	@FormID nvarchar(50),	-- "CRMF20801"	
	@Mode tinyint,			--0: Sửa, 1: Xóa
	@IsDisable tinyint = 0,
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
						@DelAPK VARCHAR(50),
						@DelDivisionID VARCHAR(50),
						@DelRequestID VARCHAR(50),
						@DelRequestSubject NVARCHAR(50)
				Declare @CRMT20801temp table (
						Status tinyint,
						MessageID varchar(100),
						Params Nvarchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @CRMT20801temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, RequestID, RequestSubject FROM CRMT20801 WITH (NOLOCK) WHERE RequestID IN ('''+@RequestIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRequestID, @DelRequestSubject
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', ''CRMT20801'', NULL, @DelAPK, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' )
							update @CRMT20801temp set Params = ISNULL(Params,'''') + @DelRequestSubject+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @CRMT20801temp set Params = ISNULL(Params,'''') + @DelRequestSubject+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							-- Thay đổi biến cờ DeleteFlg
							UPDATE CRMT20801 SET DeleteFlg = 1 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK

							--DELETE FROM CRMT20801 WHERE RequestID = @DelRequestID	
							--DELETE FROM CRMT00003 WHERE RelatedToID = convert(varchar(50), @DelAPK)
							--DELETE FROM CRMT00002_REL WHERE convert(varchar(50), RelatedToID) = convert(varchar(50), @DelAPK)
							--DELETE FROM CRMT20801_CRMT10101_REL WHERE RequestID = @DelRequestID
							--DELETE FROM CRMT90031_REL WHERE convert(varchar(50), RelatedToID) = convert(varchar(50), @DelAPK)
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRequestID, @DelRequestSubject
				Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT20801temp where Params is not null'
			EXEC (@sSQL)
			print @sSQL
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelDivisionID Varchar(50), 
						@DelRequestID Varchar(50),
						@DelRequestSubject NVARCHAR(50)
				Declare @CRMT20801temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelRequestID = RequestID, @DelRequestSubject = RequestSubject 
				FROM CRMT20801 WITH (NOLOCK) WHERE RequestID = '''+@RequestID+'''			
				IF (@DelDivisionID !='''+ @DivisionID+''' ) --Kiểm tra khac DivisionID và không dùng chung
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelRequestSubject
							End 
				INSERT INTO @CRMT20801temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @CRMT20801temp where Params is not null'
			EXEC (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
