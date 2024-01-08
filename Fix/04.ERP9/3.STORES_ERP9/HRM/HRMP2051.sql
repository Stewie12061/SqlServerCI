IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Quyết định tuyển dụng
---- Xóa Quyết định tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Bảo Thy on 28/08/2017
---- Modified by Trọng Kiên on 31/08/2020: Fix lỗi load dữ liệu màn hình xem chi tiết HRMF2052
---  Modified by: Thu Hà on  17/10/2023 :Thay đổi update cờ xóa = 1
---- Modified by on
-- <Example>
/*
	Exec HRMP2051 @DivisionID='CH',@UserID='ASOFTADMIN',@RecDecisionList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
*/


CREATE PROCEDURE HRMP2051
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @RecDecisionList XML,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

CREATE TABLE #RecDecisionID (DivisionID VARCHAR(50), RecDecisionID VARCHAR(50))
INSERT INTO #RecDecisionID (DivisionID, RecDecisionID)
SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
	   X.Data.query('RecDecisionID').value('.', 'NVARCHAR(50)') AS RecDecisionID
FROM	@RecDecisionList.nodes('//Data') AS X (Data)
ORDER BY DivisionID, RecDecisionID

IF @Mode = 1 SET @sSQL = N'
DECLARE @Cur CURSOR,
		@Params1 NVARCHAR(MAX),
		@DelDivisionID VARCHAR(50),
		@DelRecDecisionID VARCHAR(50),
		@DelAPK VARCHAR(50)

SET @Params1 = ''''
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT HRMT2050.APK, HRMT2050.DivisionID, HRMT2050.RecDecisionID
FROM HRMT2050 WITH (NOLOCK)
INNER JOIN #RecDecisionID T2 ON HRMT2050.DivisionID = T2.DivisionID AND HRMT2050.RecDecisionID = T2.RecDecisionID

OPEN @Cur
FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecDecisionID
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF EXISTS (SELECT TOP 1 1 FROM HRMT2050 WITH (NOLOCK) WHERE DivisionID = @DelDivisionID AND RecDecisionID = @DelRecDecisionID AND ISNULL(Status,0) = 1)
		SET @Params1 = @Params1+@DelRecDecisionID+ '', ''			
	ELSE
	BEGIN
	----DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 10 ---Xoa thong tin tab lich su
	----DELETE FROM CRMT00002_REL WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID_REL = 10 ---Xoa thong tin tab dinh kem
	----DELETE HRMT2050 WHERE DivisionID = @DelDivisionID AND RecDecisionID = @DelRecDecisionID
	----DELETE HRMT2051 WHERE DivisionID = @DelDivisionID AND RecDecisionID = @DelRecDecisionID
	----Thay đổi biến cờ DeleteFlg
	UPDATE HRMT2050 SET DeleteFlg = 1 WHERE DivisionID = @DelDivisionID  AND RecDecisionID = @DelRecDecisionID
	END

FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelRecDecisionID
END 

IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
SELECT 2 AS Status,''HRMFML000024'' AS MessageID, @Params1 AS Params             
WHERE @Params1 <> '''' 

DROP TABLE #RecDecisionID
'

IF @Mode = 0 SET @sSQL = N'
DECLARE @Params NVARCHAR(MAX),
		@MessageID VARCHAR(50)
SET @Params = ''''

IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM #RecDecisionID)) -- kiểm tra khác Division
	BEGIN
		SET @Params = (SELECT TOP 1 DivisionID FROM #RecDecisionID)
		SET @MessageID = ''00ML000050''
	END
IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   

DROP TABLE #RecDecisionID
'
--PRINT(@sSQL)

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
