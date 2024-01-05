IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP11503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].CIP11503
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa đối tượng
-- Nếu mã mặt hàng chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Trần Đình Hoà, Date: 10/08/2020
-- Modified by: Hoài Bảo, Date: 31/08/2022 - Cập nhật xóa đối tượng, khách hàng theo cột DeleteFlg
------------------Kết quả trả về: Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 2 (Loại Message Error)
----------------------MessageID: 00ML000050 (Kiểm tra khác DivisionID), 00ML000052 (Kiểm tra đã sử dụng)
-- Modify [Đình Hoà] [07/09/2020] Xoá đối tượng ở bảng POST0011 và địa chỉ giao hàng CRMT101011

CREATE PROCEDURE CIP11503 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@ObjectIDList NVARCHAR(MAX) = '',
	@ObjectID varchar(50),
	@TableName nvarchar(50),	-- "AT1202"	
	@Mode tinyint,			--1: Xóa
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
						@DelObjectID VARCHAR(50),
						@DelIsCommon tinyint
				DECLARE @AT1202temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @AT1202temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT DivisionID, ObjectID, IsCommon FROM AT1202 WITH (NOLOCK) WHERE ObjectID IN ('''+@ObjectIDList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelObjectID, @DelIsCommon
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC CIP90000 @DelDivisionID, NULL, '''+@TableName+''',@DelObjectID, @Status OUTPUT
					IF (@DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1)
							update @AT1202temp set Params = ISNULL(Params,'''') + @DelObjectID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1
							update @AT1202temp set Params = ISNULL(Params,'''') + @DelObjectID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							--DELETE FROM AT1202 WHERE ObjectID = @DelObjectID
		
							--DELETE FROM CRMT101011 WHERE APKMaster IN (SELECT APK FROM POST0011 WHERE MemberID = @DelObjectID)

							--DELETE FROM POST0011 WHERE MemberID = @DelObjectID

							UPDATE AT1202 SET DeleteFlg = 1 WHERE ObjectID = @DelObjectID

							UPDATE POST0011 SET DeleteFlg = 1 WHERE MemberID = @DelObjectID
						End
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelObjectID, @DelIsCommon
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @AT1202temp where Params is not null'
			--PRINT(@sSQL)
			EXEC (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
