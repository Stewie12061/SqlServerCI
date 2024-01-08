IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP21102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HRMP21102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa nhóm tính cách cá nhân- HRMF2110/HRMF2112
-- Nếu ID chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo messageID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng vũ, Date: 27/09/2017
-- <Example> EXEC HRMP21102 'AS', '', '', 'HRMT21101', 0, NULL

CREATE PROCEDURE HRMP21102 ( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- HRMT21101
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
						@DelEmployeeID Varchar(50),
						@DelEvaluationDate Datetime
				Declare @HRMT21101temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @HRMT21101temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, EmployeeID, EvaluationDate
				FROM HRMT21101 WITH (NOLOCK) WHERE Cast(APK as nvarchar(Max)) IN ('''+@APKList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEmployeeID, @DelEvaluationDate
				WHILE @@FETCH_STATUS = 0
				BEGIN
	
					IF @DelDivisionID != N'''+@DivisionID+''' --Kiểm tra khác đơn vị
							update @HRMT21101temp set Params = ISNULL(Params,'''') + @DelEmployeeID+'','' where MessageID = ''00ML000050''
					ELSE 
						Begin
							UPDATE HRMT21101 SET DeleteFlg = 1 WHERE APK = @DelAPK
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEmployeeID, @DelEvaluationDate
					
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @HRMT21101temp where Params is not null'
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
						@DelEmployeeID Varchar(50),
						@DelEvaluationDate Datetime
						
				Declare @HRMT21101temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelAPK = APK, @DelEmployeeID = EmployeeID, @DelEvaluationDate = EvaluationDate
				FROM HRMT21101 WITH (NOLOCK) WHERE Cast(APK as nvarchar(Max)) = '''+@APK+'''
				
				IF @DelDivisionID != '''+@DivisionID+''' --Kiểm tra khac DivisionID
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelEmployeeID
							End
				INSERT INTO @HRMT21101temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @HRMT21101temp where Params is not null'
			EXEC (@sSQL)
	END
	
END
