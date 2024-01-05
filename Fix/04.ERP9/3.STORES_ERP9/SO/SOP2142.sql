IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2142]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2142]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa phương án kinh doanh
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Kiều Nga, Date: 11/08/2021
---- <Example>
---- exec SOP2142 @DivisionID=N'AS',@TableName=N'OT2101',@QuotationIDList=N'0690c35d-20ab-47c0-a7c7-294d0dcb0f38',@QuotationID=NULL,@Mode=1,@UserID=N'VU'

CREATE PROCEDURE SOP2142
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @TranMonth INT,
		  @TranYear INT,
		  @VoucherIDList NVARCHAR(MAX) = '', 
		  @VoucherID VARCHAR(50) = '',
		  @Mode tinyint                 --1: Xóa
		) 
AS 

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

	SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
	FROM SOT2140 WITH (NOLOCK)
	WHERE APK = '''+@VoucherID+'''

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

	EndMess:
	SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params
	WHERE ISNULL(@Params, '''') <> ''''
	'
END
ELSE
IF @Mode = 1 ---Xóa
BEGIN
	SET @sSQL = N'
	
	CREATE TABLE #SOP2142_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

	SELECT APK,DivisionID, VoucherNo, TranMonth, TranYear
	INTO #SOP2142_SOT2140
	FROM SOT2140 WITH (NOLOCK) WHERE APK IN ('''+@VoucherIDList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2142_SOT2140 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #SOP2142_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000050''
		FROM #SOP2142_SOT2140
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2142_SOT2140 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #SOP2142_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000137''
		FROM #SOP2142_SOT2140
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'

	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2142_Errors)
	BEGIN
		UPDATE T1 SET DeleteFlag = 1 FROM SOT2140 T1 INNER JOIN #SOP2142_SOT2140 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2142_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

		UPDATE T1 SET DeleteFlag = 1 FROM SOT2141 T1 INNER JOIN #SOP2142_SOT2140 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2142_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #SOP2142_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #SOP2142_Errors T1
			ORDER BY MessageID
	END
	'
END

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
