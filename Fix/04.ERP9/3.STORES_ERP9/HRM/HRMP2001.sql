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
-- <Example>
-- Exec HRMP2001 @DivisionID='CH',@UserID='ASOFTADMIN',@RecruitPlanList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 

CREATE PROCEDURE HRMP2001
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @RecruitPlanList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #RecruitPlanList (RecruitPlanID VARCHAR(50))
INSERT INTO #RecruitPlanList (RecruitPlanID)
SELECT X.Data.query('RecruitPlanID').value('.', 'NVARCHAR(50)') AS RecruitPlanID
FROM	@RecruitPlanList.nodes('//Data') AS X (Data)
ORDER BY RecruitPlanID

IF @Mode = 1 
BEGIN
	SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelRecruitPlanID VARCHAR(50),
			@DelAPK VARCHAR(50)
	SET @Params1 = ''''
	SET @Params2 = ''''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT2000.APK, HRMT2000.DivisionID, HRMT2000.RecruitPlanID
	FROM HRMT2000 WITH (NOLOCK) 
	INNER JOIN #RecruitPlanList T1 ON HRMT2000.RecruitPlanID = T1.RecruitPlanID

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitPlanID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF ('''+@DivisionID+''' <> @DelDivisionID) -- kiểm tra khác Division
		BEGIN
			SET @Params1 = @Params1 + @DelRecruitPlanID + '', ''	
		END
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2020 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecruitPlanID = @DelRecruitPlanID) -- kiểm tra đã được sử dụng	
				SET @Params2 = @Params2 + @DelRecruitPlanID + '', ''			
		ELSE
		BEGIN
			DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 5 ---Xoa thong tin tab lich su
			DELETE HRMT2000 WHERE DivisionID = @DelDivisionID AND RecruitPlanID = @DelRecruitPlanID
			DELETE HRMT2001 WHERE DivisionID = @DelDivisionID AND RecruitPlanID = @DelRecruitPlanID
		END
		
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecruitPlanID
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

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM HRMT2000 WITH (NOLOCK) 
								INNER JOIN #RecruitPlanList T1 ON HRMT2000.RecruitPlanID = T1.RecruitPlanID)) -- kiểm tra khác Division
		BEGIN
			SET @Params = (SELECT TOP 1 DivisionID FROM HRMT2000 WITH (NOLOCK) 
						  INNER JOIN #RecruitPlanList T1 ON HRMT2000.RecruitPlanID = T1.RecruitPlanID)
			SET @MessageID = ''00ML000050''
		END
	IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
	SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
	WHERE @Params <> ''''   '
END


--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
