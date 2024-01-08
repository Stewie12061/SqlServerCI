IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Đợt tuyển dụng
---- Xóa đợt tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Bảo Thy on 14/08/2017
---- Modified by Lê Hoàng on 04/06/2021 : WORKFLOW.HRM.ContentMaster.DeleteBussinessStore.HRMF2020MainExecute trả XML ra thì RecruitPeriodID là APK => sửa lại join RecruitPeriodID thành APK
---- Modified by: Phương Thảo, Date: 12/03/2023 -[2023/09/IS/0029] Thay đổi update cờ xóa = 1
---- Modified by ... on ...
-- <Example>
/*
	Exec HRMP2021 @DivisionID='CH',@UserID='ASOFTADMIN',@RecruitPeriodID='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=0
*/


CREATE PROCEDURE HRMP2021
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @RecruitPeriodID XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #RecruitPeriodID (DivisionID VARCHAR(50), RecruitPeriodID VARCHAR(50))
INSERT INTO #RecruitPeriodID (DivisionID, RecruitPeriodID)
SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
	   X.Data.query('RecruitPeriodID').value('.', 'NVARCHAR(50)') AS RecruitPeriodID
FROM	@RecruitPeriodID.nodes('//Data') AS X (Data)
ORDER BY RecruitPeriodID

IF @Mode = 1 
BEGIN
	SET @sSQL = N'
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelRecruitPeriodID VARCHAR(50),
			@DelAPK VARCHAR(50)

	SET @Params1 = ''''
	SET @Params2 = ''''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT2020.APK, HRMT2020.DivisionID, HRMT2020.RecruitPeriodID
	FROM  HRMT2020 WITH (NOLOCK)
	INNER JOIN #RecruitPeriodID ON #RecruitPeriodID.DivisionID = HRMT2020.DivisionID AND (#RecruitPeriodID.RecruitPeriodID = HRMT2020.APK OR #RecruitPeriodID.RecruitPeriodID = HRMT2020.RecruitPeriodID)

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitPeriodID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF ('''+@DivisionID+''' <> (SELECT TOP 1 T1.DivisionID FROM HRMT2020 WITH (NOLOCK) 
								INNER JOIN #RecruitPeriodID T1 ON HRMT2020.RecruitPeriodID = T1.RecruitPeriodID)) -- kiểm tra khác Division
			SET @Params1 = @Params1 + @DelRecruitPeriodID+ '', ''
		
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2020 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND InheritRecruitPeriodID = @DelRecruitPeriodID AND RecruitPeriodID <> @DelRecruitPeriodID)
			SET @Params2 = @Params2 + @DelRecruitPeriodID+ '', ''			
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT1031 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecPeriodID = @DelRecruitPeriodID)  -- kiểm tra đã được sử dụng	
			SET @Params2 = @Params2 + @DelRecruitPeriodID+ '', ''			
		ELSE IF	EXISTS (SELECT TOP 1 1 FROM HRMT2030 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID)
			SET @Params2 = @Params2 + @DelRecruitPeriodID+ '', ''
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2040 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID)
			SET @Params2 = @Params2 + @DelRecruitPeriodID+ '', ''
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2051 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID)
				SET @Params2 = @Params2 + @DelRecruitPeriodID+ '', ''
		ELSE
			BEGIN
			    -- Thay đổi biến cờ DeleteFlg
				  UPDATE HRMT2020 SET DeleteFlg = 1 WHERE APK = @DelAPK 
				--DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 7 ---Xoa thong tin tab lich su
				--DELETE FROM CRMT00002_REL WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID_REL = 7 ---Xoa thong tin tab dinh kem
				--DELETE HRMT2020 WHERE APK = @DelAPK
				--DELETE HRMT2021 WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID
				--DELETE HRMT2022 WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID
				--DELETE HRMT2023 WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID
				--DELETE HRMT2024 WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID
			END
			
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitPeriodID
	END 

	IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
	IF @Params2 <> '''' SET @Params2 = LEFT(@Params2, LEN(@Params2)- 1)
	SELECT * FROM
	(
	SELECT 2 AS Status,''00ML000050'' AS MessageID, @Params1 AS Params             
	UNION ALL 
	SELECT 2 AS Status,''HRMFML000001'' AS MessageID, @Params2 AS Params
	)A WHERE A.Params <> '''' '

END
IF @Mode = 0 
BEGIN 
	SET @sSQL = N'
	DECLARE @Params NVARCHAR(MAX),
			@MessageID VARCHAR(50)
	SET @Params = ''''

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM #RecruitPeriodID) -- kiểm tra khác Division
		BEGIN
			SET @Params = (SELECT TOP 1 DivisionID FROM #RecruitPeriodID)
			SET @MessageID = ''00ML000050''
		END
	IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
	SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
	WHERE @Params <> '''' 
	 '
END
--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
