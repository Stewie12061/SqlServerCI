IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2162]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2162]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa huê hồng
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Kiều Nga, Date: 26/11/2020
---- Modify by: Kiều Nga, Date: 11/12/2020 : Fix lỗi Hoa hồng đã chuyển sang tính lương xong vẫn xóa đươc
---- <Example>
---- exec HRMP2162 @DivisionID=N'AS',@TableName=N'OT2101',@QuotationIDList=N'0690c35d-20ab-47c0-a7c7-294d0dcb0f38',@QuotationID=NULL,@Mode=1,@UserID=N'VU'

CREATE PROCEDURE HRMP2162
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
	FROM HRMT2160 WITH (NOLOCK)
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
	
	CREATE TABLE #HRMP2162_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

	SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear,EmployeeID
	INTO #HRMP2162_HRMT2160
	FROM HRMT2160 WITH (NOLOCK) WHERE APK IN ('''+@VoucherIDList+''')

	DECLARE @BeforeMonth INT = 0
	DECLARE @CurrentYear INT = 0

	SET @BeforeMonth = '+STR(@TranMonth + 1)+'
	SET @CurrentYear = '+STR(@TranYear)+'
	IF @BeforeMonth > 12 
	BEGIN
		SET  @BeforeMonth = @BeforeMonth - 12
		SET  @CurrentYear = @CurrentYear + 1 
	END

	PRINT @BeforeMonth
	PRINT @CurrentYear
	
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2162_HRMT2160 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #HRMP2162_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000050''
		FROM #HRMP2162_HRMT2160
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2162_HRMT2160 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #HRMP2162_Errors (VoucherNo, APK, MessageID)
		SELECT VoucherNo, APK, ''00ML000137''
		FROM #HRMP2162_HRMT2160
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
	END
	ELSE
	-- Kiểm tra đã chuyển sang tính lương không được xóa huê hồng
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2162_HRMT2160 T1 WITH (NOLOCK)
			   INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID AND T2.TranMonth = T1.TranMonth AND T2.TranYear = T1.TranYear
			   WHERE T2.IsInheritRevenueCoefficient = 1)
	BEGIN 
		INSERT INTO #HRMP2162_Errors (VoucherNo, APK, MessageID)
		SELECT T1.VoucherNo, T1.APK, ''HRMFML000042''
		FROM #HRMP2162_HRMT2160 T1 WITH (NOLOCK)
			   INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID AND T2.TranMonth = T1.TranMonth AND T2.TranYear = T1.TranYear
			   WHERE T2.IsInheritRevenueCoefficient = 1
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM HRMT2160 T1 WITH (NOLOCK) WHERE T1.TranMonth = @BeforeMonth AND T1.TranYear = @CurrentYear)
	BEGIN 
	    INSERT INTO #HRMP2162_Errors (VoucherNo, APK, MessageID)
		SELECT @BeforeMonth, ''00000000-0000-0000-0000-000000000000'', ''HRMFML000041''
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2162_Errors)
	BEGIN
		DELETE T1  FROM HRMT2160 T1 INNER JOIN #HRMP2162_HRMT2160 T2 ON T1.APK = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2162_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #HRMP2162_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #HRMP2162_Errors T1
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
