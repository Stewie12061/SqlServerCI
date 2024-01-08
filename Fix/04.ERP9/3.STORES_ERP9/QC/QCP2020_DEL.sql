IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2020_DEL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2020_DEL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra xóa/sửa 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 12/11/2020 by TAN TAI
-- <Example>
---- 
/*-- <Example>
EXEC QCP2020_DEL @DivisionID='VNP',@TableID=N'QCT2020',  @APK='EE9D8EF0-313D-4814-9F9A-8BDC69306641', @APKList='', @Mode='1', @IsDisable='0', @UserID='ASOFTADMIN'
----*/

CREATE PROCEDURE QCP2020_DEL
( 
	@DivisionID VARCHAR(50),
	@TableID VARCHAR(50),
	@APK VARCHAR(50), --Trường hợp sửa
	@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
	@Mode TINYINT, --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable), 3: Sửa: kiểm tra đã sử dụng để check dùng chung 
	@IsDisable TINYINT, --1: Disable; 0: Enable
	@UserID NVARCHAR(50)  
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)
DECLARE @FormID NVARCHAR(MAX)

SET @FormID = N'QCF2020'

SET @sSQL = N'
	CREATE TABLE #QCP2020_DEL_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo
	INTO #QCP2020_DEL
	FROM QCT2020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'QCF2020' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #QCP2020_DEL WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #QCP2020_DEL_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #QCP2020_DEL WHERE DivisionID <> '''+@DivisionID+'''
	END '

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE QCT2021 SET DeleteFlg=1 WHERE APKMaster IN ('''+@APKList+''')
		UPDATE QCT2020 SET DeleteFlg=1 WHERE APK IN ('''+@APKList+''')'
	END
	
	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #QCP2020_DEL_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #QCP2020_DEL_Errors T1 ORDER BY MessageID'
--Print (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO