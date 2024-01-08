IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Định biên tuyển dụng
---- Xóa Định biên tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 20/07/2017
----Update by Huỳnh Thử on 11/01/2021 -- Bổ sung ) bị thiếu
-- <Example>
-- Exec HRMP1021 @DivisionID='CT',@UserID='ASOFTADMIN',@BoundaryList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 
CREATE PROCEDURE [dbo].[HRMP1021]
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @BoundaryList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

CREATE TABLE #BoundaryList (BoundaryID VARCHAR(50), DepartmentID VARCHAR(50))
INSERT INTO #BoundaryList (BoundaryID, DepartmentID)
SELECT X.Data.query('BoundaryID').value('.', 'NVARCHAR(50)') AS BoundaryID,
	   X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID
FROM	@BoundaryList.nodes('//Data') AS X (Data)
ORDER BY BoundaryID
IF @Mode = 1 
BEGIN
	SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelBoundaryID VARCHAR(50),
			@DelDepartmentID VARCHAR(50),
			@DelFromDate DATETIME,
			@DelToDate DATETIME,
			@DelDutyID VARCHAR(50),
			@DelAPK VARCHAR(50)
			SET @Params1 = ''''
			SET @Params2 = ''''
			DECLARE @Params NVARCHAR(MAX),
			@MessageID VARCHAR(50)


	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT HRMT1020.APK, HRMT1020.DivisionID, HRMT1020.BoundaryID, HRMT1020.FromDate, HRMT1020.ToDate, HRMT1020.DepartmentID, HRMT1021.DutyID
	FROM HRMT1020 WITH (NOLOCK) 
	INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.APK = HRMT1021.BoundaryID AND HRMT1020.DepartmentID = HRMT1021.DepartmentID
	INNER JOIN #BoundaryList T1 ON HRMT1020.BoundaryID = T1.BoundaryID AND HRMT1020.DepartmentID = T1.DepartmentID

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelBoundaryID, @DelFromDate, @DelToDate, @DelDepartmentID, @DelDutyID
	WHILE @@FETCH_STATUS = 0
	BEGIN	

		IF ('''+@DivisionID+''' <> @DelDivisionID )-- kiểm tra khác Division
			SET @Params1  =  @Params1 +  @DelBoundaryID + '', ''
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT2000 T1 WITH (NOLOCK)
					INNER JOIN HRMT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.RecruitPlanID = T2.RecruitPlanID
					WHERE T1.DivisionID = @DelDivisionID AND T2.DutyID = @DelDutyID AND T1.DepartmentID = @DelDepartmentID
					AND (@DelFromDate Between T1.FromDate and T1.ToDate OR @DelToDate Between T1.FromDate and T1.ToDate
					OR (@DelFromDate <= T1.FromDate AND @DelToDate >= ToDate))) -- kiểm tra đã được sử dụng	
			SET @Params2 = @Params2 + @DelBoundaryID + '', ''		
		ELSE
		BEGIN
			--DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 3 ---Xoa thong tin tab lich su
			--DELETE FROM CRMT00002_REL WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID_REL = 3 ---Xoa thong tin tab dinh kem
			--DELETE HRMT1021 WHERE DivisionID = @DelDivisionID AND BoundaryID = @DelAPK AND DepartmentID = @DelDepartmentID
			UPDATE HRMT1020 SET DeleteFlg = 1 WHERE DivisionID = @DelDivisionID AND BoundaryID = @DelBoundaryID AND DepartmentID = @DelDepartmentID
		END
	
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelBoundaryID, @DelFromDate, @DelToDate, @DelDepartmentID, @DelDutyID
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

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM HRMT1020 WITH (NOLOCK) 
								INNER JOIN #BoundaryList T1 ON HRMT1020.BoundaryID = T1.BoundaryID AND HRMT1020.DepartmentID = T1.DepartmentID)) -- kiểm tra khác Division
		BEGIN
			SET @Params = (SELECT TOP 1 DivisionID FROM HRMT1020 WITH (NOLOCK) 
						  INNER JOIN #BoundaryList T1 ON HRMT1020.BoundaryID = T1.BoundaryID AND HRMT1020.DepartmentID = T1.DepartmentID)
			SET @MessageID = ''00ML000050''
		END


	IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
	SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
	WHERE @Params <> ''''   
	'
END

PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
