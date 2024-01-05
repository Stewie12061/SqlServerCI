IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
----Kiểm tra xóa đơn hàng điều chỉnh
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Kiều Nga, Date: 04/12/2019
----<Modify by>: Kiều Nga, Date: 06/05/2021 Fix lỗi chưa xóa dữ liệu duyệt
----<Modify by>: Kiều Nga, Date: 20/05/2021 Bổ sung kiểm tra đã duyệt phiếu
----<Modify by>: Văn Tài , Date: 23/03/2022 Loại bỏ kiểm tra kỳ kế toán cho SO, PO trên ERP 9.9.

---- <Example>
---- exec SOP2081 @DivisionID=N'AS',@TableName=N'OT2101',@QuotationIDList=N'0690c35d-20ab-47c0-a7c7-294d0dcb0f38',@QuotationID=NULL,@Mode=1,@UserID=N'VU'

CREATE PROCEDURE SOP2081
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @TranMonth INT,
		  @TranYear INT,
		  @APKList NVARCHAR(MAX) = '', 
		  @APK VARCHAR(50) = '',
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

	SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = Month(VoucherDate), @DelTranYear = Year(VoucherDate)
	FROM SOT2080 WITH (NOLOCK)
	WHERE Convert(Nvarchar(50),APK) = '''+@APK+'''

	IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
	BEGIN
		SET @Params = @DelVoucherNo
		SET @MessageID = ''00ML000050''
		Goto EndMess
	END
	--ELSE 
	--IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
	--BEGIN
	--	SET @Params = @DelVoucherNo
	--	SET @MessageID = ''00ML000137''
	--	Goto EndMess
	--END
	ELSE IF EXISTS (SELECT TOP 1 1 FROM SOT2080 T1 WITH (NOLOCK) INNER JOIN OOT9000 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APK WHERE T1.Status = 1 AND Convert(Nvarchar(50),T1.APK) = '''+@APK+''')
	BEGIN 
		SET @Params = @DelVoucherNo
		SET @MessageID = ''WFML000169''
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
	
	CREATE TABLE #SOP2081_Errors (APK Varchar(50),VoucherNo Varchar(50), MessageID Varchar(50),APKMaster_9000 Varchar(50))		

	SELECT APK,DivisionID,VoucherNo,Month(VoucherDate) as TranMonth,Year(VoucherDate) as TranYear, APKMaster_9000,Status
	INTO #SOP2081_SOT2080
	FROM SOT2080 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2081_SOT2080 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #SOP2081_Errors (APK,VoucherNo, MessageID,APKMaster_9000)
		SELECT 	VoucherID,VoucherNo,''00ML000050'',APKMaster_9000
		FROM #SOP2081_SOT2080
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2081_SOT2080 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #SOP2081_Errors (APK,VoucherNo,MessageID,APKMaster_9000)
		SELECT 	APK,VoucherNo,''00ML000137'',APKMaster_9000
		FROM #SOP2081_SOT2080
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
	END
	ELSE IF EXISTS (SELECT TOP 1 1 FROM #SOP2081_SOT2080 T1 WITH (NOLOCK) INNER JOIN OOT9000 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APK WHERE T1.Status = 1)
	BEGIN 
		INSERT INTO #SOP2081_Errors (APK,VoucherNo,MessageID,APKMaster_9000)
		SELECT 	T1.APK,T1.VoucherNo,''00ML000117'',T1.APKMaster_9000
		FROM #SOP2081_SOT2080 T1 WITH (NOLOCK)
		INNER JOIN OOT9000 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APK WHERE T1.Status = 1
	END
	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2081_Errors)
	BEGIN

		DELETE T1 FROM OOT9001 T1 INNER JOIN #SOP2081_SOT2080 T2 ON T1.APKMaster = T2.APKMaster_9000	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2081_Errors T3 WITH (NOLOCK) WHERE T2.APK = T3.APK)

	    DELETE T1 FROM OOT9000 T1 INNER JOIN #SOP2081_SOT2080 T2 ON T1.APK = T2.APKMaster_9000	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2081_Errors T3 WITH (NOLOCK) WHERE T2.APK = T3.APK)

		DELETE T1 FROM SOT2080 T1 INNER JOIN #SOP2081_SOT2080 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2081_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

		DELETE T1  FROM SOT2081 T1 INNER JOIN #SOP2081_SOT2080 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2081_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		DELETE T1  FROM SOT2082 T1 INNER JOIN #SOP2081_SOT2080 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2081_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #SOP2081_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #SOP2081_Errors T1
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
