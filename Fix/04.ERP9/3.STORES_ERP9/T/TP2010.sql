IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- Created Đức Tuyên 19/09/2022
---- Purpose: Danh sách Đề nghị thu/chi
/********************************************
---- <Example> ---- 
exec TP2010 @DivisionID=N'EXV',@DivisionList=N'',@LanguageID=N'vi-VN',@FromDate='2022-09-30 00:00:00',@ToDate='2022-09-30 00:00:00',@IsDate=1,@Period=N'',@VoucherNo=N'',@VoucherTypeID=N'',@CurrencyID=N'',@Status=N'',@PriorityID=N'',@PageNumber=1,@PageSize=25,@ConditionPurchaseRequestID=N'ADMIN'',''ASOFTADMIN'',''TEST01'',''TEST02'',''UNASSIGNED'
'********************************************/

CREATE PROCEDURE [dbo].[TP2010]
    @DivisionID VARCHAR(50),  --Biến môi trường
	@DivisionList NVARCHAR(max),  --Chọn
	@FromDate DATETIME,
	@ToDate	DATETIME,
	@IsDate INT,
	@Period NVARCHAR(4000),
	@VoucherNo  VARCHAR(50),
	@VoucherTypeID  VARCHAR(10),
	@CurrencyID  VARCHAR(50),
	@Status  VARCHAR(5),
	@PriorityID VARCHAR(5),
	@PageNumber INT,
	@PageSize INT,
	@LanguageID VARCHAR(50),
	@ConditionPurchaseRequestID nvarchar(max)


AS

DECLARE @sSQL NVARCHAR (MAX)= N'',
		@sWhere NVARCHAR(MAX)= N'',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@A NVARCHAR(50)
		SET @A= N'Tất cả'

SET @OrderBy = 'AT10.VoucherNo DESC'
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> '' 
	SET @sWhere = @sWhere + ' AND AT10.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' AND AT10.DivisionID = '''+@DivisionID+''''

IF @IsDate = 1 
BEGIN
IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),AT10.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
END
IF @IsDate = 0 
BEGIN
IF ISNULL(@Period,'')<>''
SET @sWhere = @sWhere + ' AND (CASE WHEN AT10.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT10.TranMonth)))+''/''+ltrim(Rtrim(str(AT10.TranYear))) 
				ELSE rtrim(ltrim(str(AT10.TranMonth)))+''/''+ltrim(Rtrim(str(AT10.TranYear))) END) in ('''+@Period +''')'
END
IF Isnull(@VoucherNo,'') <> '' 
		SET @sWhere = @sWhere + ' AND ISNULL(AT10.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
IF Isnull(@VoucherTypeID, '') <> '' 
		SET @sWhere = @sWhere + ' AND ISNULL(AT10.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
IF Isnull(@CurrencyID, '') <> '' 
		SET @sWhere = @sWhere + ' AND ISNULL(AT10.CurrencyID, '''') LIKE N''%'+@CurrencyID+'%'' '
IF Isnull(@Status, '') <> ''
		SET @sWhere = @sWhere + ' AND AT10.Status ='+@Status
IF Isnull(@PriorityID, '') <> ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT10.PriorityID, '''') LIKE N''%'+@PriorityID+'%'' '
IF Isnull(@ConditionPurchaseRequestID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(AT10.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' )'

SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow
	,AT10.APK
	,AT10.DivisionID
	,AT10.VoucherID
	,AT10.VoucherTypeID
	,AT10.VoucherNo
	,AT10.VoucherDate
	,AT10.CreateDate
	,AT10.CurrencyID
	,T4.CurrencyName
	,AT10.ExchangeRate
	, CASE WHEN (AT10.TransactionTypeID = ''T21'') 
											THEN AT10.DebitBankAccountID
										WHEN (AT10.TransactionTypeID = ''T22'') 
											THEN AT10.CreditBankAccountID
										ELSE NULL
									 END
								  AS BankAccountIDM
	,AT10.SenderReceiver
	,AT10.CreditAccountID
	,AT10.DebitAccountID
	,AT10.VDescription
	,AT10.Status as Status
	, OT92.Description AS StatusName
	,AT10.TranMonth
	,AT10.TranYear
	,AT10.EmployeeID
	,AT10.PaymentID
	,AT10.DueDate
FROM AT9010 AT10 WITH (NOLOCK)
	LEFT JOIN AT1004 T4 WITH (NOLOCK) ON T4.CurrencyID = AT10.CurrencyID
	LEFT JOIN OOT0099 OT92 WITH (NOLOCK) ON OT92.CodeMaster = N''Status'' AND OT92.ID = AT10.Status
WHERE ISNULL(AT10.DeleteFlag,0) = 0 AND AT10.Orders = 0 
'+@sWhere+'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
