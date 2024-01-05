IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tuyển dụng: Load danh sách người nhận mail (CMNF9005: ToReveiver)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 21/09/2017
---- Modified by on
-- <Example>
---- 
/*
   EXEC CMNP90052 @DivisionID, @UserID, @TranMonth, @TranYear, @TemplateID, @ID
   EXEC CMNP90052 'CH', 'ASOFTADMIN', 9, 2017, 'aaa', 'abc'
*/
CREATE PROCEDURE CMNP90052
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@TemplateID VARCHAR(50),
	@ID VARCHAR(50) ---Mã phiếu cần gửi mail
)
AS

DECLARE @sSQL NVARCHAR(MAX) = '',
		@sSQL1 NVARCHAR(MAX) = ''
		
DECLARE @TransactionTypeID VARCHAR(50) = ''

SELECT @TransactionTypeID = TransactionTypeID 
FROM CMNT1041 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND TemplateID = @TemplateID

IF ISNULL(@TransactionTypeID,'') = 'LPV' ---Nghiệp vụ lịch phỏng vấn
BEGIN
	SET @sSQL = '
	SELECT T1.CandidateID, LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(T1.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(T1.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(T1.FirstName,''''))),''  '','' ''))) AS CandidateName,
	T1.Email
	FROM HRMT1030 T1 WITH (NOLOCK)
	INNER JOIN HRMT2031 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.CandidateID = T2.CandidateID
	WHERE T1.DivisionID = '''+@DivisionID+'''
	AND T2.InterviewScheduleID = '''+ISNULL(@ID,'')+'''
	'
END
ELSE
IF ISNULL(@TransactionTypeID,'') = 'KQPV' ---Nghiệp vụ kết quả phỏng vấn
BEGIN
	SET @sSQL = '
	SELECT T1.CandidateID, LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(T1.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(T1.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(T1.FirstName,''''))),''  '','' ''))) AS CandidateName,
	T1.Email
	FROM HRMT1030 T1 WITH (NOLOCK)
	INNER JOIN HRMT2040 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.CandidateID = T2.CandidateID
	WHERE T1.DivisionID = '''+@DivisionID+'''
	AND T2.APK = '''+ISNULL(@ID,'')+'''
	'
END
ELSE
IF ISNULL(@TransactionTypeID,'') = 'QDTD' ---Nghiệp vụ quyết định
BEGIN
	SET @sSQL = '
	SELECT T1.CandidateID, LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(T1.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(T1.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(T1.FirstName,''''))),''  '','' ''))) AS CandidateName,
	T1.Email
	FROM HRMT1030 T1 WITH (NOLOCK)
	INNER JOIN HRMT2051 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.CandidateID = T2.CandidateID
	INNER JOIN HRMT2050 T3 WITH (NOLOCK) ON T2.DivisionID = T3.DivisionID AND T2.RecDecisionID = T3.RecDecisionID
	WHERE T2.DivisionID = '''+@DivisionID+'''
	AND T2.RecDecisionID = '''+ISNULL(@ID,'')+'''
	AND ISNULL(T3.Status,0) = 1 AND ISNULL(T2.Status,0) = 1
	AND NOT EXISTS (SELECT TOP 1 1 FROM HRMT1031 WITH (NOLOCK) 
					WHERE T2.DivisionID = HRMT1031.DivisionID 
					AND T2.CandidateID = HRMT1031.CandidateID AND HRMT1031.RecruitStatus NOT IN (''5'',''6''))
	'
END

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
