IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Hổ sơ ứng viên
---- Xóa Hồ sơ ứng viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 26/07/2017
-- <Example>
-- Exec HRMP1031 @DivisionID='CTY',@UserID='ASOFTADMIN',@CandidateList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 

CREATE PROCEDURE HRMP1031
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @CandidateList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #CandidateList (CandidateID VARCHAR(50))
INSERT INTO #CandidateList (CandidateID)
SELECT X.Data.query('CandidateID').value('.', 'NVARCHAR(50)') AS CandidateID
FROM	@CandidateList.nodes('//Data') AS X (Data)
ORDER BY CandidateID


IF @Mode = 1 
BEGIN
	SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelCandidateID VARCHAR(50),
			@DelDepartmentID VARCHAR(50),
			@DelAPK VARCHAR(50)
	SET @Params1 = ''''
	SET @Params2 = ''''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT1030.APK, HRMT1030.DivisionID, HRMT1030.CandidateID
	FROM HRMT1030 WITH (NOLOCK) 
	INNER JOIN #CandidateList ON HRMT1030.CandidateID = #CandidateList.CandidateID

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelCandidateID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF (@DelDivisionID <> '''+@DivisionID+''')   --kiểm tra khác DivisionID
			SET @Params1 = @Params1 + @DelCandidateID + '', ''
		IF EXISTS (SELECT TOP 1 1 FROM HRMT2031 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID) -- kiểm tra đã được sử dụng	
			OR EXISTS (SELECT TOP 1 1 FROM HRMT2040 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID)
			OR EXISTS (SELECT TOP 1 1 FROM HRMT2051 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID)
				SET @Params2 = @Params2 + @DelCandidateID + '', ''		
		ELSE
		BEGIN
			DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 4 ---Xoa thong tin tab lich su
			DELETE FROM CRMT00002_REL WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID_REL = 4 ---Xoa thong tin tab dinh kem
			DELETE HRMT1030 WHERE APK = @DelAPK
			DELETE HRMT1031 WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID
			DELETE HRMT1032 WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID
			DELETE HRMT1033 WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID
			DELETE HRMT1034 WHERE DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID
			select * from HRMT1030 where DivisionID = @DelDivisionID AND CandidateID = @DelCandidateID
		END
		
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelCandidateID
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

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM HRMT1030 WITH (NOLOCK) 
								INNER JOIN #CandidateList ON HRMT1030.CandidateID = #CandidateList.CandidateID)) -- kiểm tra khác Division
		BEGIN
			SET @Params = (SELECT TOP 1 DivisionID FROM HRMT1030 WITH (NOLOCK) 
						  INNER JOIN #CandidateList ON HRMT1030.CandidateID = #CandidateList.CandidateID)
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
