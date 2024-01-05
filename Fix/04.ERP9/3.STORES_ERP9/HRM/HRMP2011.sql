IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Yêu cầu tuyển dụng
---- Xóa yêu cầu tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 10/08/2017
-- <Example>
-- Exec HRMP2011 @DivisionID='CTY',@UserID='ASOFTADMIN',@@RecruitRequireID='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 

CREATE PROCEDURE HRMP2011
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @RecruitRequireID XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #RecruitRequireID (DivisionID VARCHAR(50), RecruitRequireID VARCHAR(50))
INSERT INTO #RecruitRequireID (DivisionID, RecruitRequireID)
SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
	   X.Data.query('RecruitRequireID').value('.', 'NVARCHAR(50)') AS RecruitRequireID
FROM	@RecruitRequireID.nodes('//Data') AS X (Data)
ORDER BY RecruitRequireID

IF @Mode = 1 
BEGIN
	SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelRecruitRequireID VARCHAR(50),
			@DelAPK VARCHAR(50),
			@DelIsCommon VARCHAR(1)

	SET @Params1 = ''''
	SET @Params2 = ''''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT2010.APK, HRMT2010.DivisionID, HRMT2010.RecruitRequireID
	FROM  HRMT2010 WITH (NOLOCK)
	INNER JOIN #RecruitRequireID ON #RecruitRequireID.DivisionID = HRMT2010.DivisionID AND #RecruitRequireID.RecruitRequireID = HRMT2010.RecruitRequireID

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitRequireID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF (@DelDivisionID <> '''+@DivisionID+''' )   --kiểm tra khác DivisionID
			SET @Params1 = @Params1 + @DelRecruitRequireID + '', ''
		ELSE
		BEGIN
			DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 6 ---Xoa thong tin tab lich su
			DELETE HRMT2010 WHERE DivisionID = @DelDivisionID AND RecruitRequireID = @DelRecruitRequireID
		END
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitRequireID
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

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM #RecruitRequireID )) -- kiểm tra khác Division
	BEGIN
		SET @Params = (SELECT TOP 1 DivisionID FROM #RecruitRequireID)
		SET @MessageID = ''00ML000050''
	END
	IF @Params <> '''' 	SET @Params = LEFT(@Params, LEN(@Params)- 1)
	
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
