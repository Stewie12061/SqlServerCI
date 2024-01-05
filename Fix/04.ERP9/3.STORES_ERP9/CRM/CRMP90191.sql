IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90191]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90191]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
---- Kiểm tra Phiếu yêu cầu khách hàng có khác đơn vị không trước khi sửa/xóa
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Học Huy, Date: 14/01/2020
---- Modified by Trần Đình Hoà on 10/08/2020: thêm điều kiện CRMT2111.DeleteFlg = 0 để xét phiếu dự toán chưa bị xoá khi đang kế thừa phiếu yêu cầu
----<Example>
/*
	EXEC CRMP90191 'MT',1, '359B3973-3E52-4C92-85CB-2B603A6D3F93', '<Data><APK>359B3973-3E52-4C92-85CB-2B603A6D3F93</APK></Data>'
	EXEC CRMP90191 @DivisionID, @Mode, @APK, @APKList
*/
CREATE PROCEDURE [dbo].[CRMP90191] 	
(
	@DivisionID VARCHAR(50),
	@Mode		TINYINT, -- 0 sửa, 1 xóa
	@APK	NVARCHAR(500),
	@APKList XML
)
AS

CREATE TABLE #TEMP (APK VARCHAR(50))
INSERT INTO #TEMP (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

CREATE TABLE #TEMP_Errors ([Status] TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

IF @Mode = 0 -- Sửa
	BEGIN
		--- Kiểm tra khác đơn vị
		IF EXISTS (
			SELECT TOP 1 1 
			FROM CRMT2100 WITH (NOLOCK)
			WHERE APK = @APK 
				AND DivisionID != @DivisionID
			)
			BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS [Status], (SELECT VoucherNo FROM CRMT2100 WITH (NOLOCK) WHERE APK = @APK) AS Params, '00ML000050' AS MessageID, @APK
			END
		
		IF EXISTS (
			SELECT TOP 1 1 
			FROM CRMT2111 WITH (NOLOCK)
			WHERE APKMInherited = @APK)
			BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS [Status], (SELECT VoucherNo FROM CRMT2100 WITH (NOLOCK) WHERE APK = @APK) AS Params, '00ML000179' AS MessageID, @APK
			END
	END

IF @Mode = 1 -- Xoá
	BEGIN
		BEGIN
			SELECT APK, DivisionID, VoucherNo
			INTO #TEMPAPK
			FROM CRMT2100 WITH (NOLOCK) 
			WHERE APK IN (SELECT APK FROM #TEMP)
		END

		IF EXISTS (SELECT TOP 1 1 FROM #TEMPAPK WHERE DivisionID != @DivisionID)
			BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params, '00ML000050' AS MessageID, APK
				FROM #TEMPAPK
				WHERE DivisionID = @DivisionID
			END

		IF EXISTS (SELECT TOP 1 1 FROM #TEMPAPK INNER JOIN CRMT2111 WITH (NOLOCK) ON #TEMPAPK.APK = CRMT2111.APKMInherited WHERE CRMT2111.DeleteFlg = 0)
			BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params, '00ML000179' AS MessageID, APK
				FROM #TEMPAPK
				WHERE DivisionID = @DivisionID
			END

		IF EXISTS (SELECT TOP 1 1 FROM #TEMPAPK WHERE DivisionID = @DivisionID)
			BEGIN
				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2100 T1 WITH (NOLOCK)
					INNER JOIN #TEMPAPK T2 ON T1.APK = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)

				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2101 T1 WITH (NOLOCK)
					INNER JOIN #TEMPAPK T2 ON T1.APKMaster = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)

				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2102 T1 
					INNER JOIN #TEMPAPK T2 ON T1.APKMaster = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)
			END
	END

SELECT [Status], Params, MessageID, APK 
FROM #TEMP_Errors


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
