IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra xóa/sửa và thực hiện xóa nghiệp vụ module FN
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Anh, Date: 05/11/2018
----Modified by Như Hàn on 05/11/2018: Kiểm tra xóa gọi từ FNF2000 
-- <Example>
---- 
/*-- <Example>
	EXEC FNP9000 @DivisionID, @APK, @APKList, @FormID, @Mode, @UserID
----*/

CREATE PROCEDURE FNP9000
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50), --Trường hợp sửa
	@APKList XML, --Trường hợp xóa
	@FormID VARCHAR(50),
	@Mode TINYINT, --0: Sửa, 1: Xóa
	@UserID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

CREATE TABLE #FNP9000 (APK VARCHAR(50))
INSERT INTO #FNP9000 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

/********* Kết quả thu chi thực tế *************/
IF @FormID = 'FNF2010'
BEGIN
	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET DeleteFlag = 1
		FROM FNT2010 T1 INNER JOIN #FNP9000 T2 ON T1.APK = T2.APK
		
		UPDATE T1 SET DeleteFlag = 1
		FROM FNT2011 T1 INNER JOIN #FNP9000 T2 ON T1.APKMaster = T2.APK
		'
	END
	EXEC (@sSQL)
END

/********* Kế hoạch thu chi *************/
IF @FormID = 'FNF2000'
	EXEC FNP2009 @DivisionID, @APK, @APKList, @Mode, @UserID

--PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
