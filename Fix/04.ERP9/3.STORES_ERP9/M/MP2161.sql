IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----<Summary>
----Kiểm tra xóa lệnh
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Create by>: Đức Tuyên, Date: 03/04/2023 Kiểm tra xóa lệnh
---- <Example>
---	EXEC MP2161 @DivisionID=N'EXV',@TableID=N'MT2160',@APK=NULL,@APKList=N'879ae6a7-1213-4c54-13e8-41cc24e1f4c8',@Mode=1,@IsDisable=0,@UserID=N'ASOFTADMIN' 

CREATE PROCEDURE [dbo].[MP2161] (
	@DivisionID VARCHAR(50),
	@TranMonth INT =0,
	@TranYear INT =0,
	@TableID VARCHAR(50) = '',
	@APK VARCHAR(50),
	@APKList NVARCHAR(MAX),
	@UserID VARCHAR(50),
	@IsDisable INT = 0,
	@Mode TINYINT
	)
AS 

DECLARE
	@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)
	, @sSQL NVARCHAR(MAX)

IF(@CustomerIndex = 117) -- Khách hàng MAITHU
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = ''
		PRINT (@sSQL)
		EXEC (@sSQL)
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
	SET @sSQL = '
	CREATE TABLE #MP2161_Errors (APK Varchar(50),VoucherNo Varchar(50), MessageID Varchar(50),Status int)		

	SELECT APK,DivisionID,VoucherNo,OrderStatus,TranMonth,TranYear
	INTO #MP2161_MT2160
	FROM MT2160 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #MP2161_MT2160 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #MP2161_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''00ML000050''
		FROM #MP2161_MT2160
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	-- Lệnh đã được kế thừa không thể xóa
	ELSE IF EXISTS (SELECT TOP 1 1 FROM MT2211 MT11 WITH (NOLOCK) 
						LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster	
						INNER JOIN (SELECT MT60.VoucherNo FROM MT2160 MT60 WITH (NOLOCK)
										WHERE MT60.DivisionID = '''+@DivisionID+''' 
												AND APK IN ('''+@APKList+''')
									) TempMT60 ON  MT11.ProductionOrder = TempMT60.VoucherNo
													AND TempMT60.VoucherNo IS NOT NULL
					WHERE  MT11.DivisionID = '''+@DivisionID+'''
							AND MT10.DeleteFlg <> 1
							AND MT11.ProductionOrder IS NOT NULL)
	BEGIN 
		INSERT INTO #MP2161_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''MFML0000012''
		FROM #MP2161_MT2160
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #MP2161_Errors)
	BEGIN

		UPDATE MT2160 SET DeleteFlg = 1 FROM MT2160 T1 INNER JOIN #MP2161_MT2160 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2161_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

		UPDATE MT2161 SET DeleteFlg = 1 FROM MT2161 T1 INNER JOIN #MP2161_MT2160 T2 ON T1.APKMaster = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2161_Errors T3 WITH (NOLOCK) WHERE T1.APKMaster = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #MP2161_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #MP2161_Errors T1
			ORDER BY MessageID
	END
	'
	PRINT (@sSQL)
	EXEC (@sSQL)

	END
END

ELSE
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = ''
		PRINT (@sSQL)
		EXEC (@sSQL)
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
	SET @sSQL = '
	CREATE TABLE #MP2161_Errors (APK Varchar(50),VoucherNo Varchar(50), MessageID Varchar(50),Status int)		

	SELECT APK,DivisionID,VoucherNo,StatusID,TranMonth,TranYear
	INTO #MP2161_MT2160
	FROM MT2160 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #MP2161_MT2160 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #MP2161_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''00ML000050''
		FROM #MP2161_MT2160
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	-- Lệnh đã được kế thừa không thể xóa
	ELSE IF EXISTS (SELECT TOP 1 1 FROM MT2211 MT11 WITH (NOLOCK) 
						LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster	
						INNER JOIN (SELECT MT60.VoucherNo FROM MT2160 MT60 WITH (NOLOCK)
										WHERE MT60.DivisionID = '''+@DivisionID+''' 
												AND APK IN ('''+@APKList+''')
									) TempMT60 ON  MT11.ProductionOrder = TempMT60.VoucherNo
													AND TempMT60.VoucherNo IS NOT NULL
					WHERE  MT11.DivisionID = '''+@DivisionID+'''
							AND MT10.DeleteFlg <> 1
							AND MT11.ProductionOrder IS NOT NULL)
	BEGIN 
		INSERT INTO #MP2161_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''MFML0000012''
		FROM #MP2161_MT2160
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #MP2161_Errors)
	BEGIN

		UPDATE MT2160 SET DeleteFlg = 1 FROM MT2160 T1 INNER JOIN #MP2161_MT2160 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2161_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

		UPDATE MT2161 SET DeleteFlg = 1 FROM MT2161 T1 INNER JOIN #MP2161_MT2160 T2 ON T1.APKMaster = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2161_Errors T3 WITH (NOLOCK) WHERE T1.APKMaster = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #MP2161_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #MP2161_Errors T1
			ORDER BY MessageID
	END
	'
	PRINT (@sSQL)
	EXEC (@sSQL)

	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
