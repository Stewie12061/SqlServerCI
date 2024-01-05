IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Kết quả phỏng vấn
---- Xóa Kết quả tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Bảo Thy on 22/08/2017
---- Modified by on
---  Modified by: Thu Hà, Date: 17/10/2023 -Thay đổi update cờ xóa = 1
-- <Example>
/*
	Exec HRMP2041 @DivisionID='CH',@UserID='ASOFTADMIN',@InterviewScheduleList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=0
*/


CREATE PROCEDURE HRMP2041
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @InterviewFileList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #InterviewFileID (APK VARCHAR(50), DivisionID VARCHAR(50))
INSERT INTO #InterviewFileID (APK, DivisionID)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK,
	   X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID
FROM	@InterviewFileList.nodes('//Data') AS X (Data)

IF @Mode = 1 
BEGIN
	SET @sSQL = N'
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelAPKMaster VARCHAR(50),
			@DelReAPK VARCHAR(50),
			@DelAPK VARCHAR(50),
			@DelCandidateID VARCHAR(50),
			@DelRecruitPeriodID VARCHAR(50)

	SET @Params1 = ''''
	SET @Params2 = ''''

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT T1.DivisionID,CONVERT(VARCHAR(50),T1.APK) AS APKMaster, CONVERT(VARCHAR(50), T2.APK) AS ReAPK, CONVERT(VARCHAR(50),T3.APK) AS APK,  T1.CandidateID, T1.RecruitPeriodID
	FROM  HRMT2040 T1 WITH (NOLOCK)
	LEFT JOIN HRMT2041 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
	LEFT JOIN HRMT2042 T3 WITH (NOLOCK) ON T3.DivisionID = T2.DivisionID AND T3.APKMaster = T1.APK AND T3.ReAPK = T2.APK
	INNER JOIN #InterviewFileID T4 ON T1.DivisionID = T4.DivisionID AND T1.APK = T4.APK


	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAPKMaster, @DelReAPK, @DelAPK, @DelCandidateID, @DelRecruitPeriodID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF EXISTS (SELECT TOP 1 1 FROM HRMT2041 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND APK = @DelAPKMaster AND InterviewStatus IS NOT NULL)
			SET @Params1 = @Params1 + @DelCandidateID+ '', ''			
		ELSE
	
		IF EXISTS (SELECT TOP 1  1 FROM HRMT2051 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecruitPeriodID = @DelRecruitPeriodID AND CandidateID = @DelCandidateID)
		BEGIN 
			SET @Params2 = @Params2 + @DelCandidateID + '', ''	
		END
		ELSE
		BEGIN
			--DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPKMaster AND RelatedToTypeID = 9 ---Xoa thong tin tab lich su
			--DELETE FROM CRMT00002_REL WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPKMaster AND RelatedToTypeID_REL = 9 ---Xoa thong tin tab dinh kem
			--DELETE HRMT2040 WHERE DivisionID = @DelDivisionID AND CONVERT(VARCHAR(50), APK) = @DelAPKMaster
			--DELETE HRMT2041 WHERE DivisionID = @DelDivisionID AND CONVERT(VARCHAR(50), APK) = @DelReAPK
			--DELETE HRMT2042 WHERE DivisionID = @DelDivisionID AND CONVERT(VARCHAR(50), APK) = @DelAPK
			--Thay đổi biến cờ DeleteFlg
		    UPDATE HRMT2040 SET DeleteFlg = 1 WHERE DivisionID = @DelDivisionID AND  CONVERT(VARCHAR(50), APK) = @DelAPKMaster
		END

	FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAPKMaster, @DelReAPK, @DelAPK, @DelCandidateID, @DelRecruitPeriodID
	END 

	IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
	IF @Params2 <> '''' SET @Params2 = LEFT(@Params2, LEN(@Params2)- 1)
	SELECT * FROM
	(
	SELECT 2 AS Status,''00ML000050'' AS MessageID, @Params1 AS Params             
	UNION ALL 
	SELECT 2 AS Status,''HRMFML000001'' AS MessageID, @Params2 AS Params
	)A WHERE A.Params <> '''' 
	
	DROP TABLE #InterviewFileID
	'	
	
END

IF @Mode = 0 
BEGIN
SET @sSQL = N'
DECLARE @Params NVARCHAR(MAX),
		@MessageID VARCHAR(50)
SET @Params = ''''

IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM #InterviewFileID)) -- kiểm tra khác Division
	BEGIN
		SET @Params = (SELECT TOP 1 DivisionID FROM #InterviewFileID)
		SET @MessageID = ''00ML000050''
	END
IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   

DROP TABLE #InterviewFileID
'
END

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
