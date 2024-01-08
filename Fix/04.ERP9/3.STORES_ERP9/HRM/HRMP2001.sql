IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra Sửa/Xóa Kế hoạch tuyển dụng
---- Xóa Kế hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 01/08/2017
----Updated by Phương Thảo on 28/08/2023 -- Điều chỉnh lại store xóa dữ liệu, set HRMT2000.DeleteFlg = 1
-- <Example>
-- Exec HRMP2001 @DivisionID='CH',@UserID='ASOFTADMIN',@RecruitPlanList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 

CREATE PROCEDURE HRMP2001
( 
 @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX),	-- HRMT2000
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
						@DelRecruitPlanID Varchar(50)
				Declare @HRMT2000temp table (
						Status tinyint,
						MessageID varchar(100),
						Params varchar(4000))
				SET @Status = 0
				SET @Message = ''''
				Insert into @HRMT2000temp (	Status, MessageID, Params) 
											Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, RecruitPlanID
				FROM HRMT2000 WITH (NOLOCK) WHERE Cast(RecruitPlanID as nvarchar(Max)) IN ('''+@APKList+''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitPlanID
				WHILE @@FETCH_STATUS = 0
				BEGIN
	
					IF @DelDivisionID != N'''+@DivisionID+''' --Kiểm tra khác đơn vị
							update @HRMT2000temp set Params = ISNULL(Params,'''') + @DelRecruitPlanID+'','' where MessageID = ''00ML000050''
					ELSE 
						Begin
							UPDATE HRMT2000 SET DeleteFlg = 1 WHERE APK = @DelAPK
							UPDATE OOT9000 SET DeleteFlag = 1 WHERE APK = @DelAPK
						End
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitPlanID
					
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @HRMT2000temp where Params is not null'
			EXEC (@sSQL)
			PRINT(@sSQL)
	END
    ELSE IF @Mode = 0 --Kiểm tra trước khi sửa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Params Varchar(100),
						@DelAPK Varchar(50),
						@DelDivisionID VARCHAR(50),
						@DelRecruitPlanID Varchar(50)
						
				Declare @HRMT2000temp table (
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000))
				SELECT @DelDivisionID = DivisionID, @DelAPK = APK, @DelRecruitPlanID = RecruitPlanID
				FROM HRMT2000 WITH (NOLOCK) WHERE Cast(RecruitPlanID as nvarchar(Max)) = '''+@APK+'''
				
				IF @DelDivisionID != '''+@DivisionID+''' --Kiểm tra khac DivisionID
							Begin
								SET @Message = ''00ML000050'' 
								SET	@Status = 2
								SET @Params = @DelRecruitPlanID
							End
				INSERT INTO @HRMT2000temp (	Status, MessageID, Params) SELECT @Status as Status, @Message as MessageID, @Params as Params 			
				SELECT Status, MessageID,Params From  @HRMT2000temp where Params is not null'
			EXEC (@sSQL)
	END
END

