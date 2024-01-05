IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2092]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2092]
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
---- <Example>
---- exec SOP2092 @DivisionID=N'AS',@TableName=N'OT2101',@QuotationIDList=N'0690c35d-20ab-47c0-a7c7-294d0dcb0f38',@QuotationID=NULL,@Mode=1,@UserID=N'VU'

CREATE PROCEDURE SOP2092
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

	SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear,@DelStatus = Status
	FROM OT2006 WITH (NOLOCK)
	WHERE VoucherID = '''+@VoucherID+'''

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
	IF @DelStatus = 1 -- Kiểm tra phiếu đã được duyệt
	BEGIN
		SET @Params = @DelVoucherNo
		SET @MessageID = ''SOFML000022''
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
	
	CREATE TABLE #SOP2092_Errors (VoucherID Varchar(50),VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

	SELECT APK,VoucherID, DivisionID, VoucherNo, TranMonth, TranYear, Status, APKMaster_9000
	INTO #SOP2092_OT2006
	FROM OT2006 WITH (NOLOCK) WHERE VoucherID IN ('''+@VoucherIDList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2092_OT2006 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #SOP2092_Errors (VoucherID,VoucherNo, APK, MessageID)
		SELECT 	VoucherID,VoucherNo, APK, ''00ML000050''
		FROM #SOP2092_OT2006
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2092_OT2006 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #SOP2092_Errors (VoucherID,VoucherNo, APK, MessageID)
		SELECT 	VoucherID,VoucherNo, APK, ''00ML000137''
		FROM #SOP2092_OT2006
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'

	END
	ELSE IF EXISTS (SELECT TOP 1 1 FROM #SOP2092_OT2006 WHERE Status = 1)
	BEGIN 
		INSERT INTO #SOP2092_Errors (VoucherID,VoucherNo, APK, MessageID)
		SELECT 	VoucherID,VoucherNo, APK, ''00ML000117''
		FROM #SOP2092_OT2006
		WHERE Status = 1
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2092_Errors)
	BEGIN
	    DELETE T1 FROM OOT9001 T1 INNER JOIN #SOP2092_OT2006 T2 ON T1.APKMaster = T2.APKMaster_9000	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2092_Errors T3 WITH (NOLOCK) WHERE T2.VoucherID = T3.VoucherID)

	    DELETE T1 FROM OOT9000 T1 INNER JOIN #SOP2092_OT2006 T2 ON T1.APK = T2.APKMaster_9000	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2092_Errors T3 WITH (NOLOCK) WHERE T2.VoucherID = T3.VoucherID)

		DELETE T1 FROM OT2006 T1 INNER JOIN #SOP2092_OT2006 T2 ON T1.VoucherID = T2.VoucherID	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2092_Errors T3 WITH (NOLOCK) WHERE T1.VoucherID = T3.VoucherID)

		DELETE T1  FROM OT2007 T1 INNER JOIN #SOP2092_OT2006 T2 ON T1.VoucherID = T2.VoucherID		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2092_Errors T3 WITH(NOLOCK) WHERE T1.VoucherID = T3.VoucherID)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #SOP2092_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #SOP2092_Errors T1
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
