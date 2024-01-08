IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2016]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
--- Load Dữ liệu KẾ thừa DNCT khi xét duyệt hàng loạt phiếu DNCT
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Tấn Thành	Create on: 07/02/2020
---- Modified by: Vĩnh Tâm	on: 25/01/2021: Update câu query load dữ liệu khi có nhiều cấp duyệt
-- <Example>
--- EXEC BEMP2016 'MK', '41ED928D-AEB8-4D82-E404-F85C08C15D44'

CREATE PROCEDURE [dbo].[BEMP2016]
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR(MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJoin NVARCHAR(MAX) = '',
		@sSQLGetExchangeRate VARCHAR(MAX) = ''

SET @sWhere = 'B1.DivisionID = ''' + @DivisionID + ''' AND ''' + @APK + ''' IN (CONVERT(VARCHAR(50), B1.APK), CONVERT(VARCHAR(50), B1.APKMaster_9000)) '
SELECT @Level = MAX(Levels) FROM BEMT2010 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID

WHILE @i < = @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)

	SET @sSQLGetExchangeRate = '
	DECLARE @CurrencyID_Temp VARCHAR(50),
			@ExchangeRate DECIMAL(28, 8)
	SELECT @CurrencyID_Temp = B1.AdvanceCurrencyID
	FROM BEMT2010 B1 WITH (NOLOCK)
	WHERE ' + @sWhere + '

	IF (EXISTS (
		SELECT TOP 1 1 
		FROM AT1012 A WITH (NOLOCK)
		WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND FORMAT(ExchangeDate, ''yyyy-MM-dd 00:00:00:000'') = FORMAT(GETDATE(), ''yyyy-MM-dd 00:00:00:000'')))
		BEGIN
			SELECT TOP 1 @ExchangeRate = ExchangeRate
			FROM AT1012 A WITH (NOLOCK)
			WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND FORMAT(ExchangeDate, ''yyyy-MM-dd 00:00:00:000'') = FORMAT(GETDATE(), ''yyyy-MM-dd 00:00:00:000'')
		END
	ELSE IF (EXISTS (
		SELECT TOP 1 1
		FROM AT1012 A WITH (NOLOCK)
		WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND A.TranMonth = MONTH(GETDATE()) AND A.TranYear = YEAR(GETDATE())))
			BEGIN
				SELECT TOP 1 @ExchangeRate = ExchangeRate
				FROM AT1012 A WITH (NOLOCK)
				WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND A.TranMonth = MONTH(GETDATE()) AND A.TranYear = YEAR(GETDATE())
				ORDER BY ExchangeDate DESC
			END
	ELSE 
		BEGIN
			SELECT @ExchangeRate = ExchangeRate
			FROM AT1004 A WITH (NOLOCK)
			WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp
		END'

	SET @sSQLSL = @sSQLSL + ', ApprovePerson' + @s + 'ID, ApprovePerson' + @s + 'Name, ApprovePerson' + @s + 'Status, ApprovePerson' + @s + 'Note '

	SET @sSQLJoin = @sSQLJoin + '
		LEFT JOIN (
			SELECT ApprovePersonID ApprovePerson' + @s + 'ID, OOT1.APKMaster, OOT1.DivisionID, OOT1.Status AS ApprovePerson' + @s + 'Status,
				A1.FullName As ApprovePerson' + @s + 'Name, OOT1.Note AS ApprovePerson' + @s + 'Note
			FROM OOT9001 OOT1 WITH (NOLOCK)
				LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(OOT1.Status, 0) AND O99.CodeMaster = ''Status''
				INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = OOT1.DivisionID AND A1.EmployeeID = OOT1.ApprovePersonID
			WHERE OOT1.Level = ' + STR(@i) + '
		) APP' + @s + ' ON APP' + @s + '.DivisionID = OOT90.DivisionID AND APP' + @s + '.APKMaster = OOT90.APK'

	SET @i = @i + 1
END

SET @sSQL = @sSQLGetExchangeRate + '
	SELECT B1.APK, B1.VoucherNo, B1.VoucherDate, B1.AdvanceEstimate, B1.AdvanceCurrencyID, B1.DepartmentCharged
		, B1.Applicant, B1.AdvancePaymentUserID, B1.EndDate, B1.DepartmentID, @ExchangeRate AS ExchangeRate
		' + @sSQLSL + '
	 FROM BEMT2010 B1 WITH (NOLOCK)
	 	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON B1.APKMaster_9000 = OOT90.APK
	 	LEFT JOIN AT1004 A2 WITH (NOLOCK) ON A2.CurrencyID = B1.AdvanceCurrencyID AND A2.DivisionID = B1.DivisionID
		' + @sSQLJoin + '
	WHERE ' + @sWhere + ''

EXEC (@sSQL)
--PRINT (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
