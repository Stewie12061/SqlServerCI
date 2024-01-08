IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90192]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90192]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
---- Kiểm tra sửa/xóa dự toán 
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Kiều Nga, Date: 13/02/2020
---- Modified by ... on ...:
---- Modified by Minh Dũng on 15/11/2023: Bổ sung xóa bảng detail danh mục chi phí
----<Example>
/*
	EXEC CRMP90192 'MT',1, '359B3973-3E52-4C92-85CB-2B603A6D3F93', '<Data><APK>359B3973-3E52-4C92-85CB-2B603A6D3F93</APK></Data>'
	EXEC CRMP90192 @DivisionID, @Mode, @APK, @APKList
*/
CREATE PROCEDURE [dbo].[CRMP90192] 	
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
			FROM CRMT2110 WITH (NOLOCK)
			WHERE APK = @APK 
				AND DivisionID != @DivisionID
			)
			BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS [Status], (SELECT VoucherNo FROM CRMT2110 WITH (NOLOCK) WHERE APK = @APK) AS Params, '00ML000050' AS MessageID, @APK
			END
		
		--- Kiểm tra phiếu đã duyệt
		IF EXISTS (
			SELECT TOP 1 1 
			FROM CRMT2110 WITH (NOLOCK)
			WHERE APK = @APK 
				AND Status = 1 and APKMaster_9000 IS NOT NULL
			)
		BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS [Status], (SELECT VoucherNo FROM CRMT2110 WITH (NOLOCK) WHERE APK = @APK) AS Params, '00ML000117' AS MessageID, @APK
		END

	END

IF @Mode = 1 -- Xoá
	BEGIN
		BEGIN
			SELECT APK, DivisionID, VoucherNo,[Status],APKMaster_9000
			INTO #TEMPAPK
			FROM CRMT2110 WITH (NOLOCK) 
			WHERE APK IN (SELECT APK FROM #TEMP)
		END

		IF EXISTS (SELECT TOP 1 1 FROM #TEMPAPK WHERE DivisionID != @DivisionID)
			BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params, '00ML000050' AS MessageID, APK
				FROM #TEMPAPK
				WHERE DivisionID != @DivisionID
			END

		--- Kiểm tra phiếu đã duyệt
		IF EXISTS (SELECT TOP 1 1 FROM #TEMPAPK WITH (NOLOCK) WHERE [Status] = 1 and APKMaster_9000 IS NOT NULL)
		BEGIN
				INSERT INTO #TEMP_Errors ([Status], Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params, '00ML000117' AS MessageID, APK
				FROM #TEMPAPK
				WHERE [Status] = 1 AND APKMaster_9000 IS NOT NULL
		END

		IF EXISTS (SELECT TOP 1 1 FROM #TEMPAPK WHERE DivisionID = @DivisionID)
			BEGIN
				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2110 T1 WITH (NOLOCK)
					INNER JOIN #TEMPAPK T2 ON T1.APK = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)

				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2111 T1 WITH (NOLOCK)
					INNER JOIN #TEMPAPK T2 ON T1.APKMaster = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)

				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2112 T1 
					INNER JOIN #TEMPAPK T2 ON T1.APKMaster = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)

				UPDATE T1 SET DeleteFlg = 1
				FROM CRMT2114 T1 
					INNER JOIN #TEMPAPK T2 ON T1.APKMaster = T2.APK
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)

				IF (SELECT CustomerName FROM CustomerIndex) = 166 -- NKC
					BEGIN 
						UPDATE T1 SET DeleteFlg = 1
					FROM CRMT2115 T1 
						INNER JOIN #TEMPAPK T2 ON T1.APKMaster = T2.APK
					WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TEMP_Errors T3 WHERE T1.APK = T3.APK)
				END
			END
	END

SELECT [Status], Params, MessageID, APK 
FROM #TEMP_Errors


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
