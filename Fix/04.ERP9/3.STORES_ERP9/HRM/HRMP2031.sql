IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Lịch phỏng vấn
---- Xóa đợt tuyển dụng
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
	Exec HRMP2031 @DivisionID='CH',@UserID='ASOFTADMIN',@InterviewScheduleList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=0
*/


CREATE PROCEDURE HRMP2031
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @InterviewScheduleList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #InterviewScheduleID (DivisionID VARCHAR(50), InterviewScheduleID VARCHAR(50))
INSERT INTO #InterviewScheduleID (DivisionID, InterviewScheduleID)
SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
	   X.Data.query('InterviewScheduleID').value('.', 'NVARCHAR(50)') AS InterviewScheduleID
FROM	@InterviewScheduleList.nodes('//Data') AS X (Data)
ORDER BY InterviewScheduleID

IF @Mode = 1 
BEGIN
	SET @sSQL = N'
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelInterviewScheduleID VARCHAR(50),
			@DelAPK VARCHAR(50)

	SET @Params1 = ''''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT2030.APK, HRMT2030.DivisionID, HRMT2030.InterviewScheduleID
	FROM HRMT2030 WITH (NOLOCK)
	INNER JOIN #InterviewScheduleID ON HRMT2030.DivisionID = #InterviewScheduleID.DivisionID AND HRMT2030.InterviewScheduleID = #InterviewScheduleID.InterviewScheduleID

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelInterviewScheduleID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF EXISTS (
			SELECT TOP 1 1 FROM HRMT2040 WITH (NOLOCK)
			INNER JOIN HRMT2041 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2041.DivisionID AND HRMT2040.APK = HRMT2041.APKMaster
			INNER JOIN HRMT2031 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2031.DivisionID AND HRMT2040.CandidateID = HRMT2031.CandidateID     
			INNER JOIN HRMT2030 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2030.DivisionID AND HRMT2031.InterviewScheduleID = HRMT2030.InterviewScheduleID  
				AND HRMT2040.RecruitPeriodID = HRMT2030.RecruitPeriodID AND HRMT2041.InterviewLevel = HRMT2030.InterviewLevel      
			WHERE HRMT2030.DivisionID = @DelDivisionID AND HRMT2030.InterviewScheduleID = @DelInterviewScheduleID AND ConfirmID = 1)-- kiểm tra đã được sử dụng	
			SET @Params1 = @Params1 + @DelInterviewScheduleID+ '', ''			
		ELSE
		BEGIN
		
			----DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID =  @DelAPK	 AND RelatedToTypeID = 8 ---Xoa thong tin tab lich su
			----DELETE HRMT2030 WHERE DivisionID = @DelDivisionID AND InterviewScheduleID = @DelInterviewScheduleID
			----DELETE HRMT2031 WHERE DivisionID = @DelDivisionID AND InterviewScheduleID = @DelInterviewScheduleID
			----Thay đổi biến cờ DeleteFlg
		    UPDATE HRMT2030 SET DeleteFlg = 1 WHERE DivisionID = @DelDivisionID AND  InterviewScheduleID = @DelInterviewScheduleID 
			
		END
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelInterviewScheduleID
	END 

	IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
	SELECT 2 AS Status,''HRMFML000001'' AS MessageID, @Params1 AS Params             
	WHERE @Params1 <> ''''	 '
END

IF @Mode = 0 
BEGIN
	SET @sSQL = N'
	DECLARE @Params NVARCHAR(MAX),
			@MessageID VARCHAR(50)
	SET @Params = ''''

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM #InterviewScheduleID) -- kiểm tra khác Division
		BEGIN
			SET @Params = (SELECT TOP 1 DivisionID FROM #InterviewScheduleID)
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
