IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra Sửa/Xóa các màn hình nghiệp vụ phân hệ POP
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 03/07/2018
----Edit by Tra Giang on 05/12/2018: Kiểm tra đã được kế thừa không cho phép xóa/ sửa.
/*-- <Example>
	POP2017 @DivisionID='AT',@UserID='ASOFTADMIN',@TranMonth=6,@TranYear=2018,@VoucherNo='123456',@VoucherNoList='123456',@Mode=0
	exec POP2017 @DivisionID=N'VF',@UserID=N'ASOFTADMIN',@TranMonth=1, @TranYear=2018,@APK=N'D54AAB34-9C6E-41E4-BEA2-25637A017F22',@APKList=N'D54AAB34-9C6E-41E4-BEA2-25637A017F22',@Mode=0

	EXEC POP2017 @DivisionID, @UserID, @TranMonth, @TranYear, @APK, @APKList, @Mode
----*/


CREATE PROCEDURE POP2017
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @VoucherNo VARCHAR(50),
  @VoucherNoList VARCHAR(MAX),
  @Mode TINYINT --0: Edit, 1: Delete
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
			@Params VARCHAR(MAX) = ''''

	SELECT @DelDivisionID = DivisionID, @DelVoucherNo = LeadTimeID, @DelTranMonth = TranMonth, @DelTranYear = TranYear
	FROM POT2013 WITH (NOLOCK)
	WHERE LeadTimeID = '''+@VoucherNo+'''

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
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM POT2017 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND LeadTimeID = '''+@VoucherNo+''') ---Kiểm tra đã được kế hoạch mua hàng kế thừa chưa
	BEGIN
		SET @Params = @DelVoucherNo
		SET @MessageID = ''00ML000052''
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
	
	CREATE TABLE #POP2013_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

	SELECT APK, DivisionID, LeadTimeID as VoucherNo, TranMonth, TranYear
	INTO #POP2013_POT2013
	FROM POT2013 WITH (NOLOCK) WHERE LeadTimeID IN ('''+@VoucherNoList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #POP2013_POT2013 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #POP2013_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000050''
		FROM #POP2013_POT2013
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #POP2013_POT2013 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #POP2013_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000137''
		FROM #POP2013_POT2013
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'

	END
		ELSE
	IF EXISTS (	SELECT TOP 1 1 
				FROM POT2017 WITH(NOLOCK) 
				INNER JOIN #POP2013_POT2013 ON POT2017.DivisionID = #POP2013_POT2013.DivisionID AND POT2017.LeadTimeID = #POP2013_POT2013.VoucherNo) ---Ki?m tra dã du?c k? ho?ch mua hàng k? th?a chua
	BEGIN
		INSERT INTO #POP2013_Errors (VoucherNo, APK, MessageID)
		SELECT 	LeadTimeID, #POP2013_POT2013.APK, ''00ML000052''
		FROM POT2017 WITH(NOLOCK) 
		INNER JOIN #POP2013_POT2013 ON POT2017.DivisionID = #POP2013_POT2013.DivisionID AND POT2017.LeadTimeID = #POP2013_POT2013.VoucherNo									
	END
	DELETE T1 
	FROM POT2013 T1 INNER JOIN #POP2013_POT2013 T2 ON T1.LeadTimeID = T2.VoucherNo	
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2013_Errors T3 WITH (NOLOCK) WHERE T1.LeadTimeID = T3.VoucherNo)

	DELETE T1 
	FROM POT2014 T1 INNER JOIN #POP2013_POT2013 T2 ON T1.LeadTimeID = T2.VoucherNo		
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2013_Errors T3 WITH(NOLOCK) WHERE T1.LeadTimeID = T3.VoucherNo)

							
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
				SELECT '', '' + VoucherNo 
				FROM #POP2013_Errors T2 WITH(NOLOCK) 
				WHERE  T1.APK = T2.APK
				FOR XML PATH ('''')), 1, 1, ''''
				) AS Params
	FROM #POP2013_Errors T1
	ORDER BY MessageID

	'
END

PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
