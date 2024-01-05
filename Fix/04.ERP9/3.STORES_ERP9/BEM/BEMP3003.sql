IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Báo cáo payment list
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Trọng Kiên	Date 24/06/2020
---- Modified by: Tấn Thành	Date 31/07/2020
---- Modified by: Vĩnh Tâm	Date 12/12/2020: Load field Tên chi nhánh ngân hàng
---- Modified by: Vĩnh Tâm	Date 23/12/2020: Bổ sung load field TotalPayment, thay đổi cách JOIN dữ liệu với bảng AT9000
---- Modified by: Vĩnh Tâm	Date 21/01/2021: Thay đổi bảng lấy các field Thông tin ngân hàng
-- <Example>
---- 
/*-- <Example>
	EXEC BEMP3003 @DivisionID=N'MK',@FromDatePeriodControl='',@ToDatePeriodControl='',@CheckListPeriodControl='12/2020'',''11/2020'',''10/2020',@SupplierCode=null,@BankAccountID=null,@IsPeriod=1
----*/

CREATE PROCEDURE [dbo].[BEMP3003]
(
	@DivisionID VARCHAR(50),
	@FromDatePeriodControl DATETIME = NULL,
	@ToDatePeriodControl DATETIME = NULL,
	@CheckListPeriodControl VARCHAR(200) = NULL,
	@IsPeriod VARCHAR(1) = NULL,
	@SupplierCode NVARCHAR(MAX),
	@BankAccountID NVARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere_AT9000 NVARCHAR(MAX),
		@sSQLSubTable NVARCHAR(MAX),
		@FromDateText NVARCHAR(50),
		@ToDateText NVARCHAR(50),
		@OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'M.SupplierCode, M.VoucherNo, M.CurrencyID'
SET @sWhere = N''
SET @sWhere_AT9000 = N''

-- Lọc theo Kỳ hoặc ngày của báo cáo.
IF @IsPeriod = '0'
BEGIN
	--PRINT('NGÀY')
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDatePeriodControl, 111)
	SET @ToDateText = CONVERT(NVARCHAR(10), @ToDatePeriodControl, 111) + ' 23:59:59'
	SET @sWhere = '(B1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
	SET @sWhere_AT9000 = '(A5.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
END
ELSE IF @IsPeriod = '1' AND ISNULL(@CheckListPeriodControl, '') != ''
BEGIN
	--PRINT('KỲ')
	SET @sWhere = 'RIGHT(CONCAT(''0'', B1.TranMonth,''/'', B1.TranYear), 7) IN ( ''' + @CheckListPeriodControl + ''') '
	SET @sWhere_AT9000 = 'RIGHT(CONCAT(''0'', A5.TranMonth,''/'', A5.TranYear), 7) IN ( ''' + @CheckListPeriodControl + ''') '
END
ELSE
BEGIN
	SET @sWhere = '1 = 1'
	SET @sWhere_AT9000 = '1 = 1'
END

IF ISNULL(@DivisionID, '') != ''
BEGIN
	SET @sWhere = @sWhere + ' AND B1.DivisionID IN (''' + @DivisionID + ''') '
	SET @sWhere_AT9000 = @sWhere_AT9000 + ' AND A5.DivisionID IN (''' + @DivisionID + ''') '
END

IF ISNULL(@SupplierCode, '') != ''
	SET @sWhere = @sWhere + ' AND B1.AdvanceUserID IN (''' + REPLACE(@SupplierCode, ',', ''',''') + ''') '

IF ISNULL(@BankAccountID, '') != ''
	SET @sWhere = @sWhere + ' AND A3.BankAccountNo IN (''' + @BankAccountID + ''') '

-- Lấy loại phiếu chi, chi ngân hàng
SET @sWhere_AT9000 = @sWhere_AT9000 + ' AND A5.TransactionTypeID IN (''T02'',''T22'') '

SET @sSQLSubTable = N'

SELECT DISTINCT A5.DivisionID, A5.VoucherNo, A5.ReVoucherID, A5.VoucherDate
INTO #AT9000_3003
FROM AT9000 A5 WITH (NOLOCK)
WHERE ' + @sWhere_AT9000 + '
'

SET @sSQL = N'SELECT B1.APK
				, B1.DivisionID
				, B1.AdvanceUserID AS SupplierCode
				, A1.ObjectName AS SupplierName
				, A1.BankAccountNo
				, A1.ObjectName AS BeneficiaryName
				, A1.BankName
				, A1.Note1 AS BankBranch
				, A2.CurrencyName AS Currency
				, B2.InvoiceNo
				, B2.Description
				, B2.SpendAmount AS DetailAmount
				, B2.SpendAmount AS TotalPayment
				, B2.Description Memo
				, B1.VoucherNo
				, B1.Deadline DateOfPayment
				, B1.CurrencyID
			INTO #TempBEMT2010
			FROM BEMT2000 B1 WITH (NOLOCK)
				LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON O1.DivisionID = B1.DivisionID AND O1.APK = B1.APK
				LEFT JOIN BEMT2001 B2 WITH (NOLOCK) ON B2.DivisionID = B1.DivisionID AND B2.APKMaster = B1.APK
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.DivisionID = B1.DivisionID AND A1.ObjectID = B1.AdvanceUserID
				LEFT JOIN AT1004 A2 WITH (NOLOCK) ON A2.DivisionID = B1.DivisionID AND A2.CurrencyID = B2.CurrencyID
				LEFT JOIN AT1016 A3 WITH (NOLOCK) ON A3.DivisionID = B1.DivisionID AND A3.BankAccountID = B2.BankAccountID
				LEFT JOIN AT9010 A4 WITH (NOLOCK) ON A4.DivisionID = B1.DivisionID AND A4.InheritTransactionID = B2.APK AND A4.InheritTableID = ''BEMT2001'' AND A4.TransactionTypeID IN (''T02'', ''T22'')
				LEFT JOIN #AT9000_3003 A5 WITH (NOLOCK) ON A5.DivisionID = B1.DivisionID AND A5.ReVoucherID = A4.VoucherID

			WHERE ' + @sWhere + '
			
			DECLARE @count INT
			SELECT @count = COUNT(*) FROM #TempBEMT2010

			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
				, M.APK
				, M.DivisionID
				, FORMAT(CONVERT(DATE, M.DateOfPayment), ''dd-MM-yyyy'') AS DateOfPayment
				, M.SupplierCode
				, IIF(ISNULL(M.SupplierName, '''') != '''', M.SupplierName, M.SupplierCode) AS SupplierName
				, M.BankAccountNo
				, IIF(ISNULL(M.BeneficiaryName, '''') != '''', M.BeneficiaryName, M.SupplierCode) AS BeneficiaryName
				, M.BankName
				, M.BankBranch
				, M.Currency
				, M.InvoiceNo
				, M.Description
				, M.DetailAmount
				, M.TotalPayment
				, M.Memo
				, M.CurrencyID
				, M.VoucherNo
			FROM #TempBEMT2010 M
			ORDER BY ' + @OrderBy + ''
EXEC (@sSQLSubTable +  @sSQL)
PRINT (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
