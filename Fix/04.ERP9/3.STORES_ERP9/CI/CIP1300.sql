IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1300]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1300]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra xóa/sửa thông tin xe vận chuyển
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 24/10/2023 by Trọng Phúc
-- <Example>
---- 

CREATE PROCEDURE CIP1300
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
BEGIN
DECLARE @sSQL NVARCHAR(MAX)


SET @sSQL = '
		CREATE TABLE #CIT1300temp (
			Status TINYINT,
			MessageID VARCHAR(100),
			Params VARCHAR(4000),
			APK VARCHAR(50)
		)

		SELECT APK, DivisionID, AssetID
		INTO #CIP1300
		FROM CIT1300 CT30
		WHERE CT30.APK IN ('''+@APKList+''')
				
		IF EXISTS (SELECT TOP 1 1 FROM #CIP1300 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN
			INSERT INTO #CIT1300temp (Status, MessageID, Params, APK)
			SELECT 2 AS Status, ''00ML000050'' AS MessageID, VoucherNo AS Params, APK
			FROM #CIP1300
			WHERE DivisionID <> '''+@DivisionID+'''
		END'

IF @Mode = 1 --Kiểm tra và xóa
BEGIN
	SET @sSQL = @sSQL + N'
		UPDATE CIT1300 
		SET DeleteFlg = 1
		WHERE APK IN ('''+@APKList+''')

		UPDATE CIT1301 
		SET DeleteFlg = 1
		WHERE APKMaster IN ('''+@APKList+''')
	'
END

SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #CIT1300temp T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #CIT1300temp T1 ORDER BY MessageID'

END
--Print (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO