IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0370]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0370]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load danh sách phiếu tạm chi tại màn hình duyệt cấp 2 (ANGEL)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tieu Mai on 27/01/2016
---- Modified by Kim Thư on 28/03/2019: Sửa định dạng ngày tháng để lọc đúng điều kiện ngày
-- <Example>
/*
	exec AP0370 'ANG', 'ASOFTADMIN', '2017-01-02 00:00:00.000', '2017-07-27 00:00:00.000', 1, 2017, 7, 2017, 0, 'C0', '%', '1', 1, 0
	
	select * from AT9010
	
	select * from AT1015 where AnaTypeID like 'O05'
	
	select * from AT1202 where O05ID like 'C%'
	
*/
CREATE PROCEDURE AP0370
(
	@DivisionID		VARCHAR(50),
	@UserID			VARCHAR(50),
	@FromDate		DATETIME,
	@ToDate			DATETIME,
	@FromMonth		INT,
	@FromYear		INT,
	@ToMonth		INT,
	@ToYear			INT,
	@IsDate			TINYINT,
	@GroupObjectID	NVARCHAR(50),
	@ObjectID		NVARCHAR(50),
	@StatusID		NVARCHAR(5),
	@IsConfirm		TINYINT,
	@IsCast			TINYINT		---- 0: ALL
								---- 1: Tiền mặt
								---- 2: Chuyển khoản
	
)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)
		
SET @sSQL = N''
SET @sSQL1 = N''
SET @sWhere = N''

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + N' AND A91.TranMonth + A91.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+ STR(@ToMonth+@ToYear*100)
END
ELSE
BEGIN
	--SET @sWhere = @sWhere + N'AND CONVERT(NVARCHAR(10),A91.VoucherDate,101) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,101)+''' AND '''+ CONVERT(NVARCHAR(10),@ToDate,101) + ''''
	SET @sWhere = @sWhere + N'AND CONVERT(VARCHAR(10),A91.VoucherDate,21) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+ CONVERT(VARCHAR(10),@ToDate,21) + ''''
END

IF @IsCast = 1
BEGIN
	SET @sWhere =  @sWhere + N' AND A91.TransactionTypeID LIKE N''T02'' '
END
ELSE IF @IsCast = 2
BEGIN
	SET @sWhere =  @sWhere + N' AND A91.TransactionTypeID LIKE N''T22'' '
END
ELSE
	SET @sWhere =  @sWhere + N' AND A91.TransactionTypeID IN (''T02'', ''T22'') '

IF @IsConfirm = 0
BEGIN
	SET @sSQL = N'
	SELECT A91.ObjectID, A02.ObjectName, VoucherTypeID, VoucherID, VoucherNo, VoucherDate, A91.CurrencyID, ExchangeRate, CreditBankAccountID, CreditAccountID, 
		CASE WHEN [Status] = 1 THEN N''Chấp nhận'' ELSE N''Chưa chấp nhận'' END AS StatusName, 
		MAX(IsConfirm01) AS IsConfirm01, MAX(IsConfirm02) AS IsConfirm02, 
		CASE WHEN MAX(ISNULL(IsConfirm01,0)) = 0 THEN N''Chưa chấp nhận'' ELSE (CASE WHEN MAX(ISNULL(IsConfirm01,0)) = 1 THEN N''Chấp nhận'' ELSE N''Từ chối'' END) END AS IsConfirmName01,
		CASE WHEN MAX(ISNULL(IsConfirm02,0)) = 0 THEN N''Chưa chấp nhận'' ELSE (CASE WHEN MAX(ISNULL(IsConfirm02,0)) = 1 THEN N''Chấp nhận'' ELSE N''Từ chối'' END) END AS IsConfirmName02,
		MAX(DescriptionConfirm01) AS DescriptionConfirm01, MAX(DescriptionConfirm02) AS DescriptionConfirm02,
		SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount
	FROM AT9010 A91 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID = A91.DivisionID AND A02.ObjectID = A91.ObjectID
	WHERE A91.DivisionID = '''+@DivisionID+''' AND ISNULL(A02.O05ID,''%'') LIKE '''+@GroupObjectID+''' AND ISNULL(A91.ObjectID,''%'') LIKE '''+@ObjectID+'''
		'+ case when Isnull(@StatusID,'') <> '' then 'AND [Status] LIKE '''+@StatusID+''' ' ELSE '' END + ' AND ISNULL(A91.IsConfirm01,0) = 1 AND ISNULL(A91.IsConfirm02,0) = 0
		' + @sWhere +'
	GROUP BY A91.ObjectID, A02.ObjectName, VoucherTypeID, VoucherID, VoucherNo, VoucherDate, A91.CurrencyID, ExchangeRate, CreditBankAccountID, CreditAccountID, [Status] '
END
ELSE
BEGIN
	SET @sSQL = N'
	SELECT A91.ObjectID, A02.ObjectName, VoucherTypeID, VoucherID, VoucherNo, VoucherDate, A91.CurrencyID, ExchangeRate, CreditBankAccountID, CreditAccountID, 
		CASE WHEN [Status] = 1 THEN N''Chấp nhận'' ELSE N''Chưa chấp nhận'' END AS StatusName, 
		MAX(IsConfirm01) AS IsConfirm01, MAX(IsConfirm02) AS IsConfirm02, MAX(DescriptionConfirm01) AS DescriptionConfirm01, MAX(DescriptionConfirm02) AS DescriptionConfirm02,
		CASE WHEN MAX(ISNULL(IsConfirm01,0)) = 0 THEN N''Chưa chấp nhận'' ELSE (CASE WHEN MAX(ISNULL(IsConfirm01,0)) = 1 THEN N''Chấp nhận'' ELSE N''Từ chối'' END) END AS IsConfirmName01,
		CASE WHEN MAX(ISNULL(IsConfirm02,0)) = 0 THEN N''Chưa chấp nhận'' ELSE (CASE WHEN MAX(ISNULL(IsConfirm02,0)) = 1 THEN N''Chấp nhận'' ELSE N''Từ chối'' END) END AS IsConfirmName02,
		SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount
	FROM AT9010 A91 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID = A91.DivisionID AND A02.ObjectID = A91.ObjectID
	WHERE A91.DivisionID = '''+@DivisionID+''' AND ISNULL(A02.O05ID,''%'') LIKE '''+@GroupObjectID+''' AND ISNULL(A91.ObjectID,''%'') LIKE '''+@ObjectID+'''
		'+ case when Isnull(@StatusID,'') <> '' then 'AND [Status] LIKE '''+@StatusID+''' ' ELSE '' END + ' AND ISNULL(A91.IsConfirm01,0) = 1 AND ISNULL(A91.IsConfirm02,0) = 1
		' + @sWhere+'
	GROUP BY A91.ObjectID, A02.ObjectName, VoucherTypeID, VoucherID, VoucherNo, VoucherDate, A91.CurrencyID, ExchangeRate, CreditBankAccountID, CreditAccountID, [Status] 
	'
	SET @sSQL1 = N'	
	SELECT A91.TransactionTypeID, CASE WHEN (A91.TransactionTypeID = ''T22'' AND ISNULL(A91.CreditBankAccountID,'''') <> '''') THEN N''Chuyển khoản '' + LEFT(A91.CreditBankAccountID,3)
		ELSE N''Tiền mặt'' END AS AccountTypeName, 
	SUM(A91.OriginalAmount) AS OriginalAmount, SUM(A91.ConvertedAmount) AS ConvertedAmount
	 FROM AT9010 A91 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID = A91.DivisionID AND A02.ObjectID = A91.ObjectID
	WHERE A91.DivisionID = '''+@DivisionID+''' AND ISNULL(A02.O05ID,''%'') LIKE '''+@GroupObjectID+''' AND ISNULL(A91.ObjectID,''%'') LIKE '''+@ObjectID+'''
		'+ case when Isnull(@StatusID,'') <> '' then 'AND [Status] LIKE '''+@StatusID+''' ' ELSE '' END + ' AND ISNULL(A91.IsConfirm01,0) = 1 AND ISNULL(A91.IsConfirm02,0) = 1
		' + @sWhere+'
	GROUP BY A91.TransactionTypeID, A91.CreditBankAccountID
	'
END

--PRINT @sSQL
--PRINT @sSQL1
EXEC (@sSQL+@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

