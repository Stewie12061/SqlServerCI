IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2151]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
----Kiểm tra xóa sửa dự trù chi phí
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Create by>: Trọng Kiên
----<Update by>: Kiều Nga, Date: 01/06/2021
----<Update by>: Đức Tuyên, Date: 31/03/2023 Dự trù đã được lên kế hoạch không thể sửa xóa
---- <Example>
---	exec MP2151 @DivisionID=N'MT',@APK=N'',@APKList=N'29cad19c-4b4f-468d-9371-cb38607ccf06',@Mode=1 

CREATE PROCEDURE [dbo].[MP2151] (
	@DivisionID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@APK VARCHAR(50),
	@APKList NVARCHAR(MAX),
	@Mode TINYINT
	)
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)

	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50), 
				@DelTranMonth INT, 
				@DelTranYear INT,
				@DelStatus INT, 
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = Month(VoucherDate), @DelTranYear = Year(VoucherDate)
		FROM OT2201 WITH (NOLOCK)
		WHERE Convert(Nvarchar(50),APK) = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		ELSE 
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		ELSE IF EXISTS (SELECT TOP 1 1 FROM OT2201 T1 WITH (NOLOCK) INNER JOIN OOT9000 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APK WHERE T1.Status = 1 AND T1.ApproveLevel <> 0  AND Convert(Nvarchar(50),T1.APK) = '''+@APK+''')
		BEGIN 
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WFML000169''
			Goto EndMess
		END
		-- Dự trù đã được lên kế hoạch không thể Sửa/xóa
		ELSE IF EXISTS (SELECT TOP 1 1 FROM MT2141 MT41 WITH (NOLOCK) 
							LEFT JOIN (SELECT APK FROM OT2202 OT02 WITH (NOLOCK)
											WHERE OT02.DivisionID = '''+@DivisionID+''' 
													AND  CONVERT(VARCHAR(50), OT02.APKMaster) = '''+@APK+'''
										) TempOT02 ON  CONVERT(VARCHAR(50), MT41.InheritTransactionID) = CONVERT(VARCHAR(50), TempOT02.APK) 
														AND MT41.InheritTransactionID IS NOT NULL
							LEFT JOIN MT2140 MT40 WITH (NOLOCK) ON CONVERT(VARCHAR(50), MT40.APK) = CONVERT(VARCHAR(50), MT41.APKMaster)	
						WHERE  MT41.DivisionID = '''+@DivisionID+'''
								AND MT40.DeleteFlg <> 1
								AND TempOT02.APK IS NOT NULL)
		BEGIN 
			SET @Params = @DelVoucherNo
			SET @MessageID = ''MFML000350''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params
		WHERE ISNULL(@Params, '''') <> ''''
		'
		PRINT (@sSQL)
		EXEC (@sSQL)
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
	SET @sSQL = '
	CREATE TABLE #MP2151_Errors (APK Varchar(50),APKMaster_9000 Varchar(50),VoucherNo Varchar(50), MessageID Varchar(50),StatusID int)		

	SELECT APK,APKMaster_9000,DivisionID,VoucherNo,StatusID,TranMonth,TranYear,ApproveLevel
	INTO #MP2151_OT2201
	FROM OT2201 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #MP2151_OT2201 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #MP2151_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''00ML000050''
		FROM #MP2151_OT2201
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE IF EXISTS (SELECT TOP 1 1 FROM #MP2151_OT2201 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #MP2151_Errors (APK,VoucherNo,MessageID,APKMaster_9000)
		SELECT 	APK,VoucherNo,''00ML000137'',APKMaster_9000
		FROM #MP2151_OT2201
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
	END
	ELSE IF EXISTS (SELECT TOP 1 1 FROM #MP2151_OT2201 OT01
						LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON OT01.StatusID = O1.ID AND O1.CodeMaster =''Status'' AND ISNULL(O1.Disabled, 0)= 0
						WHERE StatusID = 1 AND ApproveLevel <> 0
					)
	BEGIN 
		INSERT INTO #MP2151_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''00ML000117''
		FROM #MP2151_OT2201
		WHERE StatusID = 1
	END
	-- Dự trù đã được lên kế hoạch không thể xóa
	ELSE IF EXISTS (SELECT TOP 1 1 FROM MT2141 MT41 WITH (NOLOCK) 
						LEFT JOIN (SELECT APK FROM OT2202 OT02 WITH (NOLOCK)
										WHERE OT02.DivisionID = '''+@DivisionID+''' 
												AND  CONVERT(VARCHAR(50), OT02.APKMaster) IN ('''+@APKList+''')
									) TempOT02 ON  CONVERT(VARCHAR(50), MT41.InheritTransactionID) = CONVERT(VARCHAR(50), TempOT02.APK)
													AND MT41.InheritTransactionID IS NOT NULL
						LEFT JOIN MT2140 MT40 WITH (NOLOCK) ON CONVERT(VARCHAR(50), MT40.APK) = CONVERT(VARCHAR(50), MT41.APKMaster)	
					WHERE  MT41.DivisionID = '''+@DivisionID+'''
							AND MT40.DeleteFlg <> 1
							AND TempOT02.APK IS NOT NULL)
	BEGIN 
		INSERT INTO #MP2151_Errors (APK,VoucherNo,MessageID)
		SELECT 	APK,VoucherNo,''MFML0000012''
		FROM #MP2151_OT2201
		WHERE StatusID = 1
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #MP2151_Errors)
	BEGIN
		UPDATE OOT9001 SET DeleteFlag = 1  FROM OOT9001 T1 INNER JOIN #MP2151_OT2201 T2 ON T1.APKMaster = T2.APKMaster_9000	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2151_Errors T3 WITH (NOLOCK) WHERE T2.APK = T3.APK)

	    UPDATE OOT9000 SET DeleteFlag = 1 FROM OOT9000 T1 INNER JOIN #MP2151_OT2201 T2 ON T1.APK = T2.APKMaster_9000	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2151_Errors T3 WITH (NOLOCK) WHERE T2.APK = T3.APK)

		UPDATE OT2201 SET DeleteFlg = 1 FROM OT2201 T1 INNER JOIN #MP2151_OT2201 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2151_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

		UPDATE OT2202 SET DeleteFlg = 1 FROM OT2202 T1 INNER JOIN #MP2151_OT2201 T2 ON T1.APKMaster = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #MP2151_Errors T3 WITH (NOLOCK) WHERE T1.APKMaster = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #MP2151_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #MP2151_Errors T1
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
