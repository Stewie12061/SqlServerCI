IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Như Hàn
---- Created Date 05/11/2018
---- Purpose: Kiểm tra trước khi xóa, và update lại DeleteFlag = 1 (kế hoạch thu/chi)
---- Modified on 05/11/2018 by Bảo Anh: Bổ sung kiểm tra kế hoạch đã kế thừa lập thu/chi thực tế
/*
	FNP2009 'AS','482131B8-DF4C-4AD7-AF28-6586B6B6B520','<Data><APK>482131B8-DF4C-4AD7-AF28-6586B6B6B520</APK></Data>',1,''
*/

CREATE PROCEDURE [dbo].[FNP2009] 	
				@DivisionID VARCHAR(50),
				@APK VARCHAR(50), --Trường hợp sửa
				@APKList XML, --Trường hợp xóa
				@Mode TINYINT, --0: Sửa, 1: Xóa
				@UserID NVARCHAR(50)

AS


CREATE TABLE #FNT2000 (APK VARCHAR(50))
INSERT INTO #FNT2000 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

CREATE TABLE #FNP2009_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

IF @Mode = 1
	BEGIN 
		SELECT APK, DivisionID, VoucherNo, Status
		INTO #FNP2009
		FROM FNT2000 WITH (NOLOCK) WHERE APK IN (SELECT APK FROM #FNT2000)

		--- Kiểm tra phiếu đã duyệt
		IF EXISTS (SELECT TOP 1 1 FROM #FNP2009 WHERE DivisionID = @DivisionID AND Status = 1)
			BEGIN
				INSERT INTO #FNP2009_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, VoucherNo AS Params,'00ML000117'AS MessageID, APK
				FROM #FNP2009 WHERE Status = 1
			END

		--- Kiểm tra phiếu đã kế thừa lập phiếu thu/chi ở module T
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ISNULL(InheritTableID,'') = 'FNT2000'
					AND InheritVoucherID in (SELECT APK FROM #FNT2000))
			BEGIN
				INSERT INTO #FNP2009_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, #FNP2009.VoucherNo AS Params,'00ML000179'AS MessageID, #FNP2009.APK
				FROM #FNP2009
				INNER JOIN AT9000 WITH (NOLOCK) ON #FNP2009.DivisionID = AT9000.DivisionID AND #FNP2009.APK = AT9000.InheritVoucherID
			END
		
		--- Kiểm tra phiếu đã kế thừa lập kết quả thu/chi thực tế ở module FN
		IF EXISTS (SELECT TOP 1 1 FROM FNT2011 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ISNULL(InheritTableID,'') = 'FNT2000'
					AND InheritAPKMaster in (SELECT APK FROM #FNT2000))
			BEGIN
				INSERT INTO #FNP2009_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, #FNP2009.VoucherNo AS Params,'00ML000179'AS MessageID, #FNP2009.APK
				FROM #FNP2009
				INNER JOIN FNT2011 WITH (NOLOCK) ON #FNP2009.DivisionID = FNT2011.DivisionID AND #FNP2009.APK = FNT2011.InheritAPKMaster
			END

		--SELECT 	DISTINCT 1 AS Status, MessageID, STUFF ((	
		--SELECT ',' + Params FROM #FNP2009_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('')), 1, 1, '') AS Params 
		--FROM #FNP2009_Errors T1 ORDER BY MessageID

		UPDATE T1 SET DeleteFlag = 1
		FROM FNT2000 T1 INNER JOIN #FNP2009 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP2009_Errors T3 WHERE T1.APK = T3.APK)
		
		UPDATE T1 SET DeleteFlag = 1
		FROM FNT2001 T1 INNER JOIN #FNP2009 T2 ON T1.APKMaster = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP2009_Errors T3 WHERE T1.APK = T3.APK)

		UPDATE T9
		SET InheritTableID = NULL, InheritTransactionID = NULL,  InheritVoucherID = NULL
		FROM AT9000 T9
		INNER JOIN FNT2001 FT21 WITH (NOLOCK) ON T9.InheritTransactionID = FT21.APK AND T9.InheritVoucherID = FT21.APKMaster

		--UPDATE T1 SET DeleteFlag = 1
		--FROM OOT9000 T0 
		--INNER JOIN FNT2000 T1 ON T0.APK = T1.APKMaster
		--INNER JOIN #FNP2009 T2 ON T1.APK = T2.APK
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP2009_Errors T3 WHERE T1.APK = T3.APK)

		--UPDATE T1 SET DeleteFlag = 1
		--FROM OOT9001 T0
		--INNER JOIN FNT2000 T1 ON T0.APKMaster = T1.APKMaster
		--INNER JOIN #FNP2009 T2 ON T1.APK = T2.APK
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #FNP2009_Errors T3 WHERE T1.APK = T3.APK)

	END
IF @Mode = 0
	BEGIN
		--- Kiểm tra phiếu đã duyệt
		IF EXISTS (SELECT TOP 1 1 FROM FNT2001 WITH (NOLOCK) WHERE APKMaster = @APK AND Status = 1)
			BEGIN
				INSERT INTO #FNP2009_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, (SELECT VoucherNo FROM FNT2000 WITH (NOLOCK) WHERE APK = @APK) AS Params,'00ML000117'AS MessageID, @APK
			END

		--- Kiểm tra phiếu đã kế thừa lập phiếu thu/chi ở module T
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ISNULL(InheritTableID,'') = 'FNT2000'
					AND InheritVoucherID = @APK)
			BEGIN
				INSERT INTO #FNP2009_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, (SELECT VoucherNo FROM FNT2000 WITH (NOLOCK) WHERE APK = @APK) AS Params,'00ML000179'AS MessageID, @APK
			END

		--- Kiểm tra phiếu đã kế thừa lập kết quả thu/chi thực tế ở module FN
		IF EXISTS (SELECT TOP 1 1 FROM FNT2011 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ISNULL(InheritTableID,'') = 'FNT2000'
					AND InheritAPKMaster = @APK)
			BEGIN
				INSERT INTO #FNP2009_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, (SELECT VoucherNo FROM FNT2000 WITH (NOLOCK) WHERE APK = @APK),'00ML000179'AS MessageID, @APK
			END
	END

SELECT * FROM #FNP2009_Errors



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

