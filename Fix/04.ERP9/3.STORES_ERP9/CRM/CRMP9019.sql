IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP9019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP9019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra xóa/sửa và thực hiện xóa nghiệp vụ module CRM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Học Huy, Date: 14/01/2020
----Modified by ... on ... 
-- <Example>
---- 
/*-- <Example>
	EXEC CRMP9019 @DivisionID, @APK, @APKList, @FormID, @Mode, @UserID
----*/

CREATE PROCEDURE CRMP9019
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKList XML,
	@FormID VARCHAR(50),
	@Mode TINYINT, -- 0: Sửa, 1: Xóa
	@UserID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

CREATE TABLE #CRMP9019 (APK VARCHAR(50))
INSERT INTO #CRMP9019 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

/********* Phiếu yêu cầu khách hàng *************/
IF (@FormID = 'CRMF2100' OR @FormID = 'CRMF2102')
BEGIN
	EXEC CRMP90191 @DivisionID, @Mode, @APK, @APKList
END

IF (@FormID = 'CRMF2110' OR @FormID = 'CRMF2112' OR @FormID = 'CRMF2112C' OR @FormID = 'CRMF2110A')
BEGIN
	EXEC CRMP90192 @DivisionID, @Mode, @APK, @APKList
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
