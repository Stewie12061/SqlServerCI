IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP8000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP8000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra xóa/sửa danh mục module FN
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 17/08/2018
----Modified by on 
-- <Example>
---- 
/*-- <Example>
	FNP8000 @DivisionID, @APK, @APKList, @FormID, @Mode, @IsDisable, @UserID
----*/

CREATE PROCEDURE FNP8000
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50), --Trường hợp sửa
	@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
	@FormID VARCHAR(50),
	@Mode TINYINT, --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, --1: Disable; 0: Enable
	@UserID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)


/*********Danh mục định mức chi phí *************/
IF @FormID IN ('FNF1000', 'FNF1002')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #FNP8000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, NormID, IsCommon
	INTO #FNP8000
	FROM FNT1000 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'FNF1000' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #FNP8000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #FNP8000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, NormID AS Params, ''00ML000050''AS MessageID, APK
		FROM #FNP8000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END '
	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		DELETE T1 FROM FNT1001 T1 INNER JOIN #FNP8000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP8000_Errors T3 WHERE T1.APKMaster = T3.APK) ----Xóa detail

		DELETE T1 FROM FNT1000 T1 INNER JOIN #FNP8000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP8000_Errors T3 WHERE T1.APK = T3.APK)' ----Xóa master 

	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM FNT1000 T1 WITH (NOLOCK) 
		INNER JOIN #FNP8000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP8000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #FNP8000_Errors T2 WITH(NOLOCK) WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #FNP8000_Errors T1 ORDER BY MessageID'
END 



/*********Danh mục mức độ ưu tiên *************/
IF @FormID IN ('FNF1020', 'FNF1022')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #FNP8000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, PriorityID, IsCommon
	INTO #FNP8000
	FROM FNT1020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'FNF1020' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #FNP8000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #FNP8000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, PriorityID AS Params, ''00ML000050''AS MessageID, APK
		FROM #FNP8000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END '
	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		DELETE T1 FROM FNT1020 T1 INNER JOIN #FNP8000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP8000_Errors T3 WHERE T1.APK = T3.APK)'  

	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM FNT1020 T1 WITH (NOLOCK) 
		INNER JOIN #FNP8000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP8000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #FNP8000_Errors T2 WITH(NOLOCK) WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #FNP8000_Errors T1 ORDER BY MessageID'
END 





--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
