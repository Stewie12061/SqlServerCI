IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2091]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP2091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi xóa/sửa phiếu bảo hành
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Hoàng Vũ, Date: 18/09/2018
-- Modify by
-- <Example> EXEC CRMP2091 'AS', 'THT', 'CRMF2090', NULL

CREATE PROCEDURE CRMP2091 ( 
	@DivisionID varchar(50),
	@APKList NVARCHAR(MAX),	
	@FormID nvarchar(50),	--"CRMF2090 or CRMF2092"	
	@UserID Varchar(50)) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	
	SET @sSQL = '
			DECLARE @Status TINYINT,
					@Message NVARCHAR(1000),
					@Cur CURSOR,
					@DelAPK uniqueidentifier,
					@DelDivisionID VARCHAR(50),
					@DelVoucherNo VARCHAR(50)
			Declare @CRMT2090temp table (
					Status tinyint,
					MessageID varchar(100),
					Params varchar(4000))
			SET @Status = 0
			SET @Message = ''''
			Insert into @CRMT2090temp (	Status, MessageID, Params) 
										Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
										union all
										Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
			SET @Cur = CURSOR SCROLL KEYSET FOR
			SELECT APK, DivisionID, VoucherNo FROM CRMT2090 WITH (NOLOCK) WHERE Cast(APK as nvarchar(50)) IN ('''+@APKList+''')
			OPEN @Cur
			FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo
			WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC CRMP90000 @DelDivisionID, '''+@FormID+''', ''CRMT2090'', NULL, @DelVoucherNo, NULL, NULL, @Status OUTPUT
				IF (@DelDivisionID != '''+@DivisionID+''')
						update @CRMT2090temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'','' where MessageID = ''00ML000050''
				ELSE IF (Select @Status) = 1
						update @CRMT2090temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''00ML000052''
				ELSE 
					Begin
						UPDATE CRMT2090 SET DeleteFlg = 1 WHERE APK = @DelAPK	
						UPDATE CRMT2091 SET DeleteFlg = 1 WHERE APKMaster = @DelAPK	
					End
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo
				Set @Status = 0
			END
			CLOSE @Cur
			SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT2090temp where Params is not null'
		EXEC (@sSQL)
END
