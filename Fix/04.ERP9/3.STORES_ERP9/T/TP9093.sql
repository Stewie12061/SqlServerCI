IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9093]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9093]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----<Summary>
---- Kiểm tra kỳ ngân sách đã được duyệt chưa, có khác đơn vị không trước khi sửa/xóa
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 29/10/2018
---- Modified by ... on ...:
----<Example>
/*
	EXEC TP9093 'BS',1, '359B3973-3E52-4C92-85CB-2B603A6D3F93', '<Data><APK>359B3973-3E52-4C92-85CB-2B603A6D3F93</APK></Data>'
	EXEC TP9093 @DivisionID, @Mode, @APK, @APKList
*/
CREATE PROCEDURE [dbo].[TP9093] 	
(
	@DivisionID VARCHAR(50),
	@Mode		TINYINT, --0 sửa, 1 xóa
	@APK	NVARCHAR(500), -- Trường hợp xóa
	@APKList XML --Trường hợp xóa
	
)
AS

CREATE TABLE #TT2100 (APK VARCHAR(50))
INSERT INTO #TT2100 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

CREATE TABLE #TT2100_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))


IF @Mode = 1
	BEGIN
		BEGIN 
			SELECT APK, DivisionID, VoucherNo, Status
			INTO #TT2100APK
			FROM TT2100 WITH (NOLOCK) WHERE APK IN (SELECT APK FROM #TT2100)
		END

		IF EXISTS (SELECT TOP 1 1 FROM #TT2100APK WHERE DivisionID != @DivisionID)
			BEGIN
				INSERT INTO #TT2100_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params,'00ML000050'AS MessageID, APK
				FROM #TT2100APK WHERE DivisionID != @DivisionID
			END

		IF EXISTS (SELECT TOP 1 1 FROM #TT2100APK WHERE DivisionID = @DivisionID AND Status = 1)
			BEGIN
				INSERT INTO #TT2100_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params,'MFML000293'AS MessageID, APK
				FROM #TT2100APK WHERE Status = 1
			END
		
		IF EXISTS (SELECT TOP 1 1 
					FROM #TT2100APK T1
					INNER JOIN AT9000 T2 WITH(NOLOCK)ON T2.DivisionID = T1.DivisionID AND T2.InheritVoucherID = CONVERT(VARCHAR(50),T1.APK)
					WHERE T1.DivisionID = @DivisionID
							)
			BEGIN
				INSERT INTO #TT2100_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params,'MFML000293'AS MessageID, APK
				FROM #TT2100APK WHERE Status = 1
			END	

			UPDATE T1 SET DeleteFlag = 1
			FROM TT2100 T1 INNER JOIN #TT2100APK T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TT2100_Errors T3 WHERE T1.APK = T3.APK)
		
			UPDATE T1 SET DeleteFlag = 1
			FROM TT2101 T1 INNER JOIN #TT2100APK T2 ON T1.APKMaster = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TT2100_Errors T3 WHERE T1.APK = T3.APK)

	END
IF @Mode = 0
	BEGIN
		--- Kiểm tra khác đơn vị
		IF EXISTS (SELECT TOP 1 1 FROM TT2100 WITH (NOLOCK) WHERE APK = @APK AND DivisionID != @DivisionID)
			BEGIN
				INSERT INTO #TT2100_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, (SELECT VoucherNo FROM TT2100 WITH (NOLOCK) WHERE APK = @APK) AS Params,'00ML000050'AS MessageID, @APK
			END

		--- Kiểm tra phiếu đã duyệt
		IF EXISTS (SELECT TOP 1 1 FROM TT2100 WITH (NOLOCK) WHERE APK = @APK AND Status = 1 AND DivisionID = @DivisionID)
			BEGIN
				INSERT INTO #TT2100_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, (SELECT VoucherNo FROM TT2100 WITH (NOLOCK) WHERE APK = @APK) AS Params,'MFML000293'AS MessageID, @APK
			END

		IF EXISTS (SELECT TOP 1 1 
					FROM TT2100 T1
					INNER JOIN AT9000 T2 WITH(NOLOCK)ON T2.DivisionID = T1.DivisionID AND T2.InheritVoucherID = CONVERT(VARCHAR(50), T1.APK)
					WHERE T1.DivisionID = @DivisionID AND CONVERT(VARCHAR(50),T1.APK) = @APK
							)
			BEGIN
				INSERT INTO #TT2100_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, (SELECT VoucherNo FROM TT2100 WITH (NOLOCK) WHERE APK = @APK) AS Params,'MFML000293'AS MessageID, @APK
			END
	END

SELECT Status, Params, MessageID, APK FROM #TT2100_Errors

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

