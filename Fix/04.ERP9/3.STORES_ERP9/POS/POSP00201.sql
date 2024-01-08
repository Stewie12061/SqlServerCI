IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00201]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<MaiVu>
-- Create date: <15/05/2014>
-- Description:	<Xóa / sửa dữ liệu Thẻ hội viên>
-- Modify by Thị Phượng: Cải tiến store, thêm chức năng ẩn hiện
-- EX: EXEC POSP00201 'AS', 'HT00001', 'POSF0020', 3, 'UserID'
-- TypeNo: '01'',''02'
-- MemberID: 'MC01'
-- MemberCardID: 'MC0301'',''MC0302'',''MC0303', 'MC0304'
-- =============================================
CREATE PROCEDURE [dbo].[POSP00201]
(
		  @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa/ sửa
		  @IDList NVARCHAR(MAX),
		  @FormID nvarchar(50),
		  @Mode TINYINT, -- 3: Ẩn, 2: Hiện, 1: Xóa
		  @UserID VARCHAR(50)
)
AS DECLARE @sSQL nvarchar (max)

SET @sSQL = ' 
	DECLARE @Status TINYINT,
			@Message NVARCHAR(1000),
			@Cur CURSOR,
			@DelDivisionID VARCHAR(50),
			@DelShopID VARCHAR(50),
			@MemberID varchar (50) = null,
			@DelMemberCardID varchar(50),
			@TranMonth int = null,
			@TranYear int = null,
			@APK uniqueidentifier = NULL,
			@DelIsCommon int
		Declare @POST0020temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
	SET @Status = 0
	SET @Message = ''''
	Insert into @POST0020temp (	Status, MessageID, Params) 
								Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params	
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DivisionID, MemberID, MemberCardID, IsCommon FROM POST0020 With (NOLOCK) WHERE MemberCardID IN ('''+@IDList+''')

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelDivisionID, @MemberID, @DelMemberCardID, @DelIsCommon
	WHILE @@FETCH_STATUS = 0
	BEGIN
			Exec POSP9000   @DelDivisionID, @MemberID, @TranMonth, @TranYear,  @DelMemberCardID, @APK , '''+@FormID+''', @Status OUTPUT 
			IF @DelDivisionID != '''+@DivisionID+''' and @DelIsCommon !=1
				Begin
					UPDATE @POST0020temp set Params = ISNULL(Params,'''') + @MemberID + @DelMemberCardID+'','' where MessageID = ''00ML000050''
				End

			IF (Select @Status) = 1
				BEGIN
					IF '+STR(@Mode)+' = 3
					UPDATE @POST0020temp set Params = ISNULL(Params,'''') + @MemberID + @DelMemberCardID+'',''  where MessageID = ''00ML000052''
					IF '+STR(@Mode)+' = 2
						BEGIN
							UPDATE POST0020 SET [Disabled] = 0,
												 LastModifyUserID = '''+@UserID+''',
												 LastModifyDate = GETDATE()
							WHERE  MemberCardID = @DelMemberCardID
						END	
					IF '+STR(@Mode)+' = 1
						UPDATE @POST0020temp set Params = ISNULL(Params,'''') + @MemberID+ @DelMemberCardID+'',''  where MessageID = ''00ML000052''
				END
				
			IF (Select @Status) = 0
				BEGIN
					IF '+STR(@Mode)+' = 3
						BEGIN
							UPDATE POST0020 SET [Disabled] = 1, 
							LastModifyUserID = '''+@UserID+''', 
							LastModifyDate = GETDATE()
							WHERE  MemberCardID = @DelMemberCardID
						END
					IF '+STR(@Mode)+' = 2
						BEGIN
							UPDATE POST0020 SET [Disabled] = 0,
												 LastModifyUserID = '''+@UserID+''',
												 LastModifyDate = GETDATE()
							WHERE MemberCardID = @DelMemberCardID
						END	
					IF '+STR(@Mode)+' = 1
					BEGIN
						DELETE FROM POST0020 
						WHERE MemberCardID = @DelMemberCardID	
					END
				END
		FETCH NEXT FROM @Cur INTO @DelDivisionID, @MemberID, @DelMemberCardID, @DelIsCommon 		
	END
	CLOSE @Cur
	SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST0020temp where Params is not null'

EXEC (@sSQL)
---PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO