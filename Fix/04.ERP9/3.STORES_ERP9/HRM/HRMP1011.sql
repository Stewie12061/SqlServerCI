IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Danh mục Hình thức phỏng vấn
---- Xóa danh mục Hình thức phỏng vấn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 17/07/2017
---Modified by: Thu Hà, Date: 17/10/2023 -Thay đổi update cờ xóa = 1
-- <Example>
-- Exec HRMP1011 @DivisionID='CH',@UserID='ASOFTADMIN',@InterviewTypeList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 

CREATE PROCEDURE HRMP1011
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @InterviewTypeList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #InterviewType (InterviewTypeID VARCHAR(50), DutyID VARCHAR(50))
INSERT INTO #InterviewType (InterviewTypeID, DutyID)
SELECT X.Data.query('InterviewTypeID').value('.', 'NVARCHAR(50)') AS InterviewTypeID,
	   X.Data.query('DutyID').value('.', 'NVARCHAR(50)') AS DutyID
FROM	@InterviewTypeList.nodes('//Data') AS X (Data)
ORDER BY InterviewTypeID

IF @Mode = 1 
BEGIN
	SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelInterviewTypeID VARCHAR(50),
			@DelDutyID VARCHAR(50),
			@DelAPK VARCHAR(50),
			@DelIsCommon VARCHAR(1)
	SET @Params1 = ''''
	SET @Params2 = ''''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT1010.APK, HRMT1010.DivisionID, HRMT1010.InterviewTypeID, HRMT1010.DutyID, HRMT1010.IsCommon 
	FROM HRMT1010 WITH (NOLOCK) 
	INNER JOIN #InterviewType T1 ON HRMT1010.InterviewTypeID = T1.InterviewTypeID AND HRMT1010.DutyID = T1.DutyID

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelInterviewTypeID, @DelDutyID, @DelIsCommon
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@DelDivisionID <> '''+@DivisionID+''' AND @DelIsCommon <> 1)   --kiểm tra khác DivisionID và khong dung chung
			SET @Params1 = @Params1 + @DelInterviewTypeID+''-''+@DelDutyID+ '', ''
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2021 WHERE InterviewTypeID = @DelInterviewTypeID)
			OR EXISTS (SELECT TOP 1 1 FROM HRMT2042 WHERE InterviewTypeID = @DelInterviewTypeID) -- kiểm tra đã được sử dụng	
			SET @Params2 = @Params2 +@DelInterviewTypeID+''-''+@DelDutyID+ '', ''				
		ELSE
		BEGIN
		
			--DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 2 ---Xoa thong tin tab lich su
			--DELETE HRMT1011 WHERE DivisionID = @DelDivisionID AND InterviewTypeID = @DelInterviewTypeID AND DutyID = @DelDutyID
			--DELETE HRMT1010 WHERE APK = @DelAPK
			--Thay đổi biến cờ DeleteFlg
		    UPDATE HRMT1010 SET DeleteFlg = 1 WHERE DivisionID = @DelDivisionID AND APK = @DelAPK AND InterviewTypeID = @DelInterviewTypeID AND DutyID = @DelDutyID

		END

	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelInterviewTypeID, @DelDutyID, @DelIsCommon
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
	SET @sSQL = '
	DECLARE @Params NVARCHAR(MAX),
			@MessageID VARCHAR(50)
	SET @Params = ''''

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM HRMT1010 WITH (NOLOCK) 
								INNER JOIN #InterviewType T1 ON HRMT1010.InterviewTypeID = T1.InterviewTypeID AND HRMT1010.DutyID = T1.DutyID) 
		AND (SELECT ISNULL(IsCommon,0) FROM HRMT1010 WITH (NOLOCK) 
		INNER JOIN #InterviewType T1 ON HRMT1010.InterviewTypeID = T1.InterviewTypeID AND HRMT1010.DutyID = T1.DutyID)
	   <> 1 ) -- kiểm tra khác Division va khong dung chung
		BEGIN
			SET @Params = (SELECT TOP 1 DivisionID FROM HRMT1010 WITH (NOLOCK) 
						  INNER JOIN #InterviewType T1 ON HRMT1010.InterviewTypeID = T1.InterviewTypeID AND HRMT1010.DutyID = T1.DutyID)
			SET @MessageID = ''00ML000050''
		END
	IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
	SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
	WHERE @Params <> '''' '

END

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
