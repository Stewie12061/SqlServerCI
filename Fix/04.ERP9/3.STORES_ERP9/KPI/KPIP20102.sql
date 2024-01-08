IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP20102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[KPIP20102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa tính thưởng
-- Nếu ID chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo messageID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 22/08/2017
-- <Example> EXEC KPIP20102 'AS', '', '', 'KPIT20101', 1, NULL

CREATE PROCEDURE KPIP20102 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- KPIT20101
	@Mode tinyint,			--0: Sửa, 1: Xóa
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
						@DelAPK Varchar(50),
						@DelDivisionID VARCHAR(50),
						@DelEvaluationPhaseID Varchar(50),
						@DelDepartmentID Varchar(50)
				Declare @KPIT20101temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @KPIT20101temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, EvaluationPhaseID, DepartmentID
				FROM KPIT20101 WITH (NOLOCK) WHERE Cast(APK as nvarchar(Max)) IN ('''+@APKList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEvaluationPhaseID, @DelDepartmentID
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC KPIP90000 @DelDivisionID, '''+@TableID+''', @DelAPK, @Status OUTPUT
					
					IF @DelDivisionID != N'''+@DivisionID+''' --Kiểm tra khác đơn vị
							update @KPIT20101temp set Params = ISNULL(Params,'''') + @DelEvaluationPhaseID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1			  --Kiểm tra Đã sử dụng
							update @KPIT20101temp set Params = ISNULL(Params,'''') + @DelEvaluationPhaseID+'',''  where MessageID = ''00ML000052''
					ELSE 
						Begin
							UPDATE KPIT20101 SET DeleteFlg = 1 WHERE APK = @DelAPK
							UPDATE KPIT20102 SET DeleteFlg = 1 WHERE APKMaster = @DelAPK
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEvaluationPhaseID, @DelDepartmentID
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @KPIT20101temp where Params is not null'
			EXEC (@sSQL)
	END
	ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelAPK Varchar(50),
						@DelDivisionID VARCHAR(50),
						@DelEvaluationPhaseID Varchar(50),
						@DelDepartmentID Varchar(50)
				Declare @KPIT20101temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelAPK = APK, @DelEvaluationPhaseID = EvaluationPhaseID, @DelDepartmentID = DepartmentID
				FROM KPIT20101 WITH (NOLOCK) WHERE Cast(APK as nvarchar(Max)) = '''+@APK+'''
				
				EXEC KPIP90000 @DelDivisionID, '''+@TableID+''', @DelAPK, @Status OUTPUT
				IF @DelDivisionID != '''+@DivisionID+''' --Kiểm tra khac DivisionID
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelEvaluationPhaseID
							End
				INSERT INTO @KPIT20101temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				
				IF (Select @Status) = 1 --Kiểm tra đã sử dụng
							Begin
								SET @Message = ''00ML000052'' 
								SET	@Status = 2
								SET @Params = @DelEvaluationPhaseID
							End
				INSERT INTO @KPIT20101temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				
				SELECT Status, MessageID,Params From  @KPIT20101temp where Params is not null'
			EXEC (@sSQL)
	END
END
