IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP20008]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[KPIP20008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra và xóa kết quả thực hiện KPI
-- Nếu ID chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo messageID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created on 26/02/2019 by Bảo Anh
-- <Example> EXEC KPIP20008 'NTY', '', '', 'KPIT20003', 0, NULL

CREATE PROCEDURE KPIP20008
( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- KPIT20003
	@Mode tinyint,			--0: Sửa, 1: Xóa
	@UserID Varchar(50)
)

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
						@DelDivisionID NVARCHAR(50),
						@DelEmployeeID NVarchar(50),
						@DelDelEmployeeID_PhaseID_KitID nvarchar(4000),
						@DelConfirmUserID Varchar(50),
						@DelTotalReevaluatedPoint decimal(28,8)
						
				Declare @KPIT20003temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @KPIT20003temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
											union all
											Select 2 as Status, ''00ML000117'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT M.APK, M.DivisionID, M.EmployeeID, M.ConfirmUserID
				, ''[''+M.EmployeeID+''].[''+M.EvaluationPhaseID+'']''
				FROM KPIT20003 M WITH (NOLOCK)
				WHERE Cast(M.APK as nvarchar(Max)) IN ('''+@APKList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEmployeeID, @DelConfirmUserID, @DelDelEmployeeID_PhaseID_KitID
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC KPIP90000 @DelDivisionID, '''+@TableID+''', @DelAPK, @Status OUTPUT
					
					IF @DelDivisionID != N'''+@DivisionID+''' --Kiểm tra khác đơn vị
							update @KPIT20003temp set Params = ISNULL(Params,'''') + @DelDelEmployeeID_PhaseID_KitID+'','' where MessageID = ''00ML000050''
					ELSE IF (Select @Status) = 1			  --Kiểm tra Đã sử dụng
							update @KPIT20003temp set Params = ISNULL(Params,'''') + @DelDelEmployeeID_PhaseID_KitID+'',''  where MessageID = ''00ML000052''
					ELSE IF (@DelTotalReevaluatedPoint !=0  and @DelConfirmUserID  != N'''+@UserID+''')	  --Kiểm tra Đã duyệt
							update @KPIT20003temp set Params = ISNULL(Params,'''') + @DelDelEmployeeID_PhaseID_KitID+'',''  where MessageID = ''00ML000117''
					ELSE 
						Begin
							UPDATE KPIT20003 SET DeleteFlg = 1 WHERE APK = @DelAPK
							UPDATE KPIT20004 SET DeleteFlg = 1 WHERE APKMaster = @DelAPK
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelEmployeeID, @DelConfirmUserID, @DelDelEmployeeID_PhaseID_KitID
					Set @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @KPIT20003temp where Params is not null'
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
						@DelConfirmUserID Varchar(50)
						
				Declare @KPIT20003temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelAPK = APK, @DelEmployeeID = EmployeeID, @DelConfirmUserID = ConfirmUserID
				FROM KPIT20003 WITH (NOLOCK) WHERE Cast(APK as nvarchar(Max)) = '''+@APK+'''
				
				EXEC KPIP90000 @DelDivisionID, '''+@TableID+''', @DelAPK, @Status OUTPUT
				IF @DelDivisionID != '''+@DivisionID+''' --Kiểm tra khac DivisionID
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelEmployeeID
							End
				INSERT INTO @KPIT20003temp (Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				
				IF (Select @Status) = 1 --Kiểm tra đã sử dụng
							Begin
								SET @Message = ''00ML000052'' 
								SET	@Status = 2
								SET @Params = @DelEmployeeID
							End
				INSERT INTO @KPIT20003temp (Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				
				IF (@DelTotalReevaluatedPoint !=0 and @DelConfirmUserID  != N'''+@UserID+''') --Kiểm tra đã duyệt
							Begin
								SET @Message = ''00ML000117'' 
								SET	@Status = 2
								SET @Params = @DelEmployeeID
							End
				INSERT INTO @KPIT20003temp (Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			

				SELECT Status, MessageID,Params From  @KPIT20003temp where Params is not null'
			EXEC (@sSQL)
	END
END
