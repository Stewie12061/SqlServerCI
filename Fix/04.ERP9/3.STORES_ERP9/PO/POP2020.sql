IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra Sửa/Xóa đơn đặt hàng phân hệ POP
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 03/07/2018
----Edit by Tra Giang on 05/12/2018: Bổ sung check đã được kế thừa không cho phép sửa/xóa.
/*-- <Example>
	POP2017 @DivisionID='AT',@UserID='ASOFTADMIN',@TranMonth=6,@TranYear=2018,@VoucherNo='123456',@VoucherNoList='123456',@Mode=0
	exec POP2017 @DivisionID=N'VF',@UserID=N'ASOFTADMIN',@TranMonth=1, @TranYear=2018,@APK=N'D54AAB34-9C6E-41E4-BEA2-25637A017F22',@APKList=N'D54AAB34-9C6E-41E4-BEA2-25637A017F22',@Mode=0

	EXEC POP2017 @DivisionID, @UserID, @TranMonth, @TranYear, @APK, @APKList, @Mode
----*/


CREATE PROCEDURE POP2020
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APK VARCHAR(50),
  @APKList VARCHAR(MAX),
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

	SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
	FROM POT2015 WITH (NOLOCK)
	WHERE APK = '''+@APK+'''

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
	IF EXISTS (SELECT TOP 1 1 FROM POT2018 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND InheritVoucherID = '''+@APK+''') 
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
	
	CREATE TABLE #POP2015_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

	SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
	INTO #POP2015_POT2015
	FROM POT2015 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #POP2015_POT2015 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #POP2015_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000050''
		FROM #POP2015_POT2015
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #POP2015_POT2015 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
	BEGIN 
		INSERT INTO #POP2015_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, APK, ''00ML000137''
		FROM #POP2015_POT2015
		WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'

	END
	ELSE
	IF EXISTS (	SELECT TOP 1 1 				FROM POT2018 WITH(NOLOCK) 
				INNER JOIN #POP2015_POT2015 ON POT2018.DivisionID = #POP2015_POT2015.DivisionID AND POT2018.InheritVoucherID = #POP2015_POT2015.APK) 
	BEGIN
		INSERT INTO #POP2015_Errors (VoucherNo, APK, MessageID)
		SELECT 	VoucherNo, InheritVoucherID, ''00ML000052''
		FROM POT2018 WITH(NOLOCK) 
		INNER JOIN #POP2015_POT2015 ON POT2018.DivisionID = #POP2015_POT2015.DivisionID AND POT2018.InheritVoucherID = #POP2015_POT2015.APK									
	END
	
	DELETE T1 
	FROM POT2015 T1 INNER JOIN #POP2015_POT2015 T2 ON T1.APK = T2.APK	
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2015_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

	DELETE T1 
	FROM POT2014 T1 INNER JOIN #POP2015_POT2015 T2 ON T1.APK = T2.APK		
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2015_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

							
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
				SELECT '', '' + VoucherNo 
				FROM #POP2015_Errors T2 WITH(NOLOCK) 
				WHERE  T1.APK = T2.APK
				FOR XML PATH ('''')), 1, 1, ''''
				) AS Params
	FROM #POP2015_Errors T1
	ORDER BY MessageID

	'
END

--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
