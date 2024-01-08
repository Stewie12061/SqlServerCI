IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2050_DEL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2050_DEL]
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
EXEC [QCP2050_DEL] 
	@DivisionID = N'VNP', @TableID = N'QCT2010', @APK = N'', @APKList = N'7011b082-2c4f-43dd-9b5d-34cffbb45a23', @Mode = 1, 
	@IsDisable = 0, @UserID = N'ASOFTADMIN'
----*/

CREATE PROCEDURE QCP2050_DEL
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

SET @FormID = N'QCF2050'

SET @sSQL = N'
	CREATE TABLE #QCP2050_DEL_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo
	INTO #QCP2050_DEL
	FROM QCT2020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'QCF2050' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #QCP2050_DEL WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #QCP2050_DEL_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #QCP2050_DEL WHERE DivisionID <> '''+@DivisionID+'''
	END '

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		Update QCT2002  set DeleteFlg =  1
		from QCT2002 
		join QCT2011 QCT2011 on QCT2011.APK = QCT2002.APKMaster
		join QCT2010 QCT2010 on QCT2010.APK = QCT2011.APKMaster
		where QCT2010.APK IN ('''+@APKList+''')
		UPDATE QCT2011 SET DeleteFlg=1 WHERE APKMaster IN ('''+@APKList+''')
		UPDATE QCT2010 SET DeleteFlg=1 WHERE APK IN ('''+@APKList+''')'
	END
	
	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #QCP2050_DEL_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #QCP2050_DEL_Errors T1 ORDER BY MessageID'
--Print (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO