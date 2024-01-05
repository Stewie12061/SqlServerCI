IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra xóa/sửa và thực hiện xóa nghiệp vụ module T 9.0
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 29/11/2018
----Modified by ... on ... 
-- <Example>
---- 
/*-- <Example>
	EXEC TP9000 @DivisionID, @APK, @APKList, @FormID, @Mode, @UserID
----*/

CREATE PROCEDURE TP9000
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

CREATE TABLE #TP9000 (APK VARCHAR(50))
INSERT INTO #TP9000 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

/********* Ngân sách *************/
IF @FormID = 'TF2000'
BEGIN
	EXEC TP9093 @DivisionID, @Mode, @APK, @APKList
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
