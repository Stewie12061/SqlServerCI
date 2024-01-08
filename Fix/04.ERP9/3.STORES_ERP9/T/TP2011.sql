IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Master phiếu Đề nghị thu/chi 9.0
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đức Tuyên on: 24/08/2022
-- <Example>
/*
*/

CREATE PROCEDURE TP2011
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50) ='',
	@APKMaster_9000 VARCHAR(50) = '',
	@APK VARCHAR(50) = '',
	@APKList NVARCHAR(MAX) = NULL,
	@TableID VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@IsDisable INT = 0,
	@Mode TINYINT, --0: Edit, 1: Delete
	@FormID VARCHAR(50) =''
)
AS

CREATE TABLE #TP2012_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

DECLARE @Ssql Nvarchar(max), 
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = '',
		@VoucherNo VARCHAR(50) = ''


IF @Mode = 1 --Kiểm tra và xóa phiếu
	BEGIN
	SET @APKList = ''+ REPLACE(@APKList, ''',''', ',') +'';
	SET @Ssql = '

		SELECT [Value]
		INTO #TP2011APK
		FROM StringSplit ('''+@APKList+''', '','' )
		WHERE LEN([Value]) > 10

		IF EXISTS(SELECT TOP 1 1 FROM AT9010 AT10 WITH (NOLOCK) INNER JOIN #TP2011APK TP201 ON TP201.Value = AT10.APK
			 WHERE AT10.Orders = 0 AND (AT10.CreateUserID = '''+@UserID+''' OR AT10.EmployeeID = '''+@UserID+'''))	
			BEGIN
			-- Đơn đã được duyệt không thể sửa xóa.
			INSERT INTO #TP2012_Errors (Status, Params, MessageID, APK)
			SELECT 1 AS Status, AT10.VoucherNo AS Params,''00ML000117'' AS MessageID, AT10.APK AS APK 

			--SELECT 1 AS Status, ''00ML000117'' AS MessageID, AT10.VoucherNo AS Params
			--INTO #TP2011
			FROM AT9010 AT10 WITH (NOLOCK)
			INNER JOIN #TP2011APK TP201 ON TP201.Value = AT10.APK
			WHERE ISNULL(AT10.Status, 0) = 1
				AND EXISTS (SELECT TOP 1 1 FROM AT9010 WITH (NOLOCK) WHERE AT9010.VoucherID = AT10.VoucherID)
			END
		ELSE
		BEGIN
			INSERT INTO #TP2012_Errors (Status, Params, MessageID, APK)
			SELECT 1 AS Status, '''+@UserID+''' AS Params,''TFML000118'' AS MessageID, ''APK'' AS APK 
		END

		IF NOT EXISTS (SELECT TOP 1 1 FROM #TP2012_Errors)

		BEGIN
			--UPDATE OT90
			--SET OT90.DeleteFlag = 1
			DELETE OT90
			FROM OOT9000 OT90 
			INNER JOIN AT9010 AT10 WITH (NOLOCK) ON AT10.DivisionID = OT90.DivisionID AND AT10.VoucherNo = OT90.ID
			INNER JOIN #TP2011APK TP201 ON TP201.Value = AT10.APK
			
			DELETE OT03
			FROM OOT9003 OT03
			INNER JOIN OOT9002 OT02 ON OT02.APK = OT03.APKMaster
			INNER JOIN #TP2011APK TP201 ON TP201.Value =  CAST(OT02.APKMaster AS VARCHAR(50)) 

			DELETE OT02
			FROM OOT9002 OT02
			INNER JOIN #TP2011APK OT401 ON OT401.Value =  CAST(OT02.APKMaster AS VARCHAR(50)) 

			--UPDATE AT10
			--SET AT10.DeleteFlg = 1
			DELETE AT10
			FROM AT9010 AT10
			WHERE AT10.VoucherNo  IN (SELECT AT10.VoucherNo FROM AT9010 AT10 INNER JOIN #TP2011APK TP201 ON TP201.Value = AT10.APK)
		END

		SELECT * FROM #TP2012_Errors'
	END

IF @Mode = 2 --Load dữ liệu lưới Detail
BEGIN
	IF ISNULL(@Type, '') IN ('DNT','DNC')
	BEGIN
		SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),AT10.APKMaster_9000)= '''+@APKMaster_9000+''''
		SELECT @Level = MAX(ApproveLevel) FROM AT9010 WITH (NOLOCK) WHERE Orders = 0 AND APKMaster_9000 = @APKMaster_9000 AND DivisionID = @DivisionID
	END
	ELSE 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM OOT9001 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APKMaster) = @APK)
		--Lấy dữ liệu từ xem chi tiết duyệt
		BEGIN
			SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),AT10.APKMaster_9000)= '''+@APK+'''' 
			SELECT @Level = MAX(ApproveLevel) FROM AT9010 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),AT9010.APK) = @APK AND DivisionID = @DivisionID
		END
		ELSE 
		--Lấy dữ liệu từ chi tiết
		BEGIN
			SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),AT10.APK)= '''+@APK+'''' 
			SELECT @Level = MAX(ApproveLevel) FROM AT9010 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),AT9010.APK) = @APK AND DivisionID = @DivisionID
		END
		--SET @Swhere = @Swhere + 'AND AT10.APK = '''+@APK+''''
		--SELECT @Level = MAX(ApproveLevel) FROM AT9010 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),AT9010.APK) = @APK AND DivisionID = @DivisionID
	END
	--PRINT @Level
	--PRINT @Swhere
	
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s	+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
							HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID=OOT1.DivisionID OR ISNULL(HT14.DivisionID,'''') = ''@@@'') AND		HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END
	--Print @sSQLSL
	--Print @sSQLJon	
	
	SET @Ssql = N'
		SELECT Top 1
		AT10.APK,
		AT10.APKMaster_9000 AS APKMaster,
		AT10.APKMaster_9000,
		AT10.DivisionID,
		T01.DivisionName,
		AT10.VoucherID,
		AT10.VoucherNo,
		AT10.VoucherTypeID,
		CASE WHEN (AT10.TransactionTypeID = ''T01'' OR AT10.TransactionTypeID = ''T21'') 
							THEN ''DNT''
				WHEN (AT10.TransactionTypeID = ''T02'' OR AT10.TransactionTypeID = ''T22'') 
							THEN ''DNC''
				ELSE NULL
							END
				AS Mode,
		AT10.TransactionMode,
		T07.VoucherTypeName,
		AT10.VoucherDate,
		AT10.RefNo01,
		AT10.RefNo02,
		AT10.CurrencyID,
		T04.CurrencyName,
		AT10.ExchangeRate,
		AT10.CreateUserID +''_''+ A12.FullName as CreateUserID,
		AT10.CreateDate,
		AT10.LastModifyUserID +''_''+ A13.FullName as LastModifyUserID,
		AT10.LastModifyDate,
		AT10.TranMonth,
		AT10.TranYear,
		AT10.EmployeeID,
		AT10.SenderReceiver,
		AT10.SRDivisionName,
		AT10.SRAddress,
		CASE WHEN (AT10.TransactionTypeID = ''T21'') 
							THEN AT10.DebitBankAccountID
				WHEN (AT10.TransactionTypeID = ''T22'') 
							THEN AT10.CreditBankAccountID
				ELSE NULL
							END
				AS BankAccountNameM,
		A16.BankAccountID AS BankAccountIDM,
		AT10.DebitAccountID,
		AT10.CreditAccountID,
		AT10.VDescription,
		AT10.PaymentID,
		AT10.DueDate,
		AT10.Status,
		AT10.TransactionTypeID,
		AT10.Orders,
		T05.PaymentName,
		T13.FullName As EmployeeName,
		OOT91.Level AS ApprovingLevel,
		TO9.Description As StatusName,
		O02.ApproveLevel,
		AT10.Ana06ID,AT11.AnaName as Ana06Name
		'+@sSQLSL+'
	
		FROM AT9010 AT10 WITH (NOLOCK)
	
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON AT10.APKMaster_9000 = OOT90.APK
		LEFT JOIN OOT9001 OOT91 WITH (NOLOCK) ON OOT91.APKMaster = OOT90.APK AND OOT91.ApprovePersonID = '''+@UserID+'''
		LEFT JOIN (SELECT DISTINCT VoucherNo, ApproveLevel FROM AT9010 O02 WITH (NOLOCK)) O02 ON AT10.VoucherNo = O02.VoucherNo
		LEFT JOIN AT1101 T01 WITH (NOLOCK) ON AT10.DivisionID = T01.DivisionID
		LEFT JOIN AT1007 T07 WITH (NOLOCK) ON AT10.VoucherTypeID = T07.VoucherTypeID
		LEFT JOIN AT1004 T04 WITH (NOLOCK) ON AT10.CurrencyID = T04.CurrencyID
		LEFT JOIN AT1103 T13 WITH (NOLOCK) ON AT10.EmployeeID = T13.EmployeeID
		LEFT JOIN AT1205 T05 WITH (NOLOCK) ON AT10.PaymentID = T05.PaymentID
		LEFT JOIN OOT0099 TO9 WITH (NOLOCK) ON AT10.Status = TO9.ID AND TO9.CodeMaster = ''Status''
		LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = AT10.Ana06ID AND AT11.AnaTypeID = ''A06''
		LEFT JOIN AT1103 A12 WITH (NOLOCK) ON A12.EmployeeID = AT10.CreateUserID
	    LEFT JOIN AT1103 A13 WITH (NOLOCK) ON A13.EmployeeID = AT10.LastModifyUserID
		LEFT JOIN AT1016 A16 WITH (NOLOCK) ON A16.BankAccountNo = AT10.CreditBankAccountID OR A16.BankAccountNo = AT10.DebitBankAccountID
		'+@sSQLJon+'
		WHERE Orders = 0 AND AT10.DivisionID = '''+@DivisionID+''' '+@Swhere+''
	SET @Ssql = @Ssql + '
	ORDER BY AT10.VoucherNo'
END

IF @Mode = 3 AND @FormID = 'AF2010' -- Kiểm tra phiếu đã duyệt
    BEGIN
	SET @Ssql = '
		IF EXISTS(SELECT TOP 1 1 FROM AT9010 AT10 WITH (NOLOCK)  
		WHERE AT10.Orders = 0 AND AT10.APK = '''+@APK+''' 
			AND AT10.DivisionID = '''+@DivisionID+''' 
			AND (AT10.CreateUserID = '''+@UserID+''' OR AT10.EmployeeID = '''+@UserID+'''))
		BEGIN
			DECLARE @VoucherNo VARCHAR(50)
			SELECT @VoucherNo = VoucherNo FROM AT9010 WHERE Orders = 0 AND APK = '''+@APK+'''

			--- Kiểm tra phiếu đã duyệt
			IF EXISTS(SELECT TOP 1 1 FROM AT9010 AT10 WITH (NOLOCK) 
						LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON AT10.APKMaster_9000 = O1.APK
						LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = '''+@DivisionID+'''
						WHERE AT10.Orders = 0 AND AT10.APK = '''+@APK+''' AND AT10.DivisionID = '''+@DivisionID+''' AND O2.[Status] = 1)
				BEGIN
					INSERT INTO #TP2012_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, @VoucherNo AS Params,''00ML000117'' AS MessageID, '''+@APK+''' AS APK
				END
		END
		ELSE
		BEGIN
			INSERT INTO #TP2012_Errors (Status, Params, MessageID, APK)
			SELECT 1 AS Status, '''+@UserID+''' AS Params,''TFML000118'' AS MessageID, '''+@APK+''' AS APK
		END
	SELECT * FROM #TP2012_Errors'
END

IF @Mode = 4 -- Kiểm tra quyền duyệt
BEGIN
	SET @Ssql = '
			DECLARE @VoucherNo VARCHAR(50)
			SELECT @VoucherNo = VoucherNo FROM AT9010 WHERE Orders = 0 AND APK = '''+@APK+'''

			--- Kiểm tra quyền duyệt
			IF NOT EXISTS(SELECT TOP 1 1 FROM AT9010 AT10 WITH (NOLOCK) 
						INNER JOIN OOT9000 O1 WITH (NOLOCK) ON AT10.APKMaster_9000 = O1.APK
						INNER JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = '''+@DivisionID+''' AND O2.ApprovePersonID = '''+@UserID+'''
						WHERE AT10.Orders = 0 AND AT10.APK = '''+@APK+''' AND AT10.DivisionID = '''+@DivisionID+''')
				BEGIN
					INSERT INTO #TP2012_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, @VoucherNo AS Params,''00ML000117'' AS MessageID, '''+@APK+''' AS APK
				END
	SELECT * FROM #TP2012_Errors'
END

PRINT @Ssql
EXEC (@Ssql)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
