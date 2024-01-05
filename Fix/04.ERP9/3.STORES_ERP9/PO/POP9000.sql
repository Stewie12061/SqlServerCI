IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra xóa sửa Module PO
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 08/12/2018
-- <Example>
/*-- <Example>
	EXEC POP9000 @DivisionID, @APK, @APKList, @FormID, @Mode, @UserID
----*/

CREATE PROCEDURE POP9000
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

CREATE TABLE #POP9000 (APK VARCHAR(50))
INSERT INTO #POP9000 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

IF @FormID IN ('POF2030', 'POF2040')
EXEC POP2036 @DivisionID, @APK, @APKList, @Mode, @FormID

IF @FormID IN (N'POF2060')
EXEC POP2062 @DivisionID, @APK, @APKList, @Mode, @FormID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
