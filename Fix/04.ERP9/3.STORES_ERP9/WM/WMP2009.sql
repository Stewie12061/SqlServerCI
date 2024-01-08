IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load lưới 1: kế thừa đơn phiếu bảo hành/sửa chữa(WMF2009)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Hoàng Long, Date: 02/11/2023
----Updated by: Viết Toàn, Date: 07/11/2023: Lấy thêm cột APK
----Modified by Hương Nhung on 28/12/2023: Chỉnh sửa: Kế thừa TK có, TK nợ (Customize NKC)
----Modified by Hương Nhung on 05/01/2024: Bổ sung Accountname
-- <Example>
---- 
/*-- <Example>
	WMP2009 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsDate = 0, @FromDate = '2017-12-01 08:00:05.813', 
	@ToDate = '2017-12-30 08:00:05.813', @FromMonth = 1, @FromYear = 2017, @ToMonth = 12, @ToYear = 2017, @ObjectID = 'TGDD', @APK  = ''
	
	WMP2009 @DivisionID, @UserID, @PageNumber, @PageSize, @IsDate, @FromDate, @ToDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @ObjectID, @APK
----*/

CREATE PROCEDURE [dbo].[WMP2009]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsDate TINYINT, ---- 0: Radiobutton từ ngày có check
					  ---- 1: Radiobutton từ kỳ có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @ObjectID VARCHAR(50), 
	 @VoucherID VARCHAR(50),
	 @InventoryID VARCHAR(50), 
	 @APK VARCHAR(50)  ----- Addnew truyền ''
)
AS 
	DECLARE @sSQL NVARCHAR(MAX) = N'', 
			@SWhere NVARCHAR(MAX) = N'',
			@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + N' SOT2190.DivisionID = '''+@DivisionID+''' '

IF ISNULL(@ObjectID,N'')<>N''
	SET @SWhere=@SWhere+' AND ISNULL(SOT2190.ObjectID, '''') = '''+@ObjectID+''' '

IF ISNULL(@VoucherID,N'')<>N''
	SET @SWhere=@SWhere+' AND ISNULL(SOT2190.VoucherID, '''') = '''+@VoucherID+''' '

IF ISNULL(@InventoryID,N'')<>N''
	SET @SWhere=@SWhere+' AND ISNULL(SOT2191.InventoryID, '''') = '''+@InventoryID+''' '

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND SOT2190.TranMonth + SOT2190.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, SOT2190.VoucherDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, SOT2190.VoucherDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, SOT2190.VoucherDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
END 

IF @APK=''
BEGIN
SET @sSQL = N' --APK
SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT SOT2191.APK, SOT2190.APK AS APKMaster, SOT2190.DivisionID, SOT2190.VoucherID , SOT2190.VoucherNo, SOT2190.VoucherDate,SOT2190.Address, SOT2190.ObjectType as ObjectID, AT1202.ObjectName AS ObjectName, SOT2190.Phone,SOT2190.Address2,SOT2191.InventoryID,AT1302.InventoryName,SOT2191.Long as S01ID,SOT2191.Weight as S02ID,SOT2191.High as S03ID,SOT2191.Color as S04ID, AT1302.UnitID, AT1304.UnitName,SOT2191.Quantity,SOT2190.Description,
	AT1302.AccountID as CreditAccountID, AT1302.PrimeCostAccountID as DebitAccountID, AT1005.AccountName AS DebitAccountName, A05.AccountName AS CreditAccountName
	FROM SOT2190 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (SOT2190.DivisionID, ''@@@'') AND SOT2190.ObjectType = AT1202.ObjectID
	LEFT JOIN SOT2191 WITH (NOLOCK) ON SOT2190.DivisionID  = SOT2191.DivisionID AND SOT2190.VoucherID  = SOT2191.VoucherID 
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID  = AT1302.DivisionID AND AT1302.InventoryID  = SOT2191.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.DivisionID in (SOT2190.DivisionID,''@@@'') and AT1302.AccountId = AT1005.AccountID
    LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN (SOT2190.DivisionID, ''@@@'') AND AT1302.PrimeCostAccountID = A05.AccountID
	WHERE '+@sWhere+'
	GROUP BY  SOT2191.APK, SOT2190.APK ,SOT2190.DivisionID, SOT2190.VoucherID , SOT2190.VoucherNo, SOT2190.VoucherDate, SOT2190.ObjectID, AT1202.ObjectName,SOT2190.Address,SOT2190.ObjectType, SOT2190.Phone,SOT2190.Address2,SOT2191.InventoryID,AT1302.InventoryName,SOT2191.Long,SOT2191.Weight,SOT2191.High,SOT2191.Color,AT1302.UnitID,AT1304.UnitName,SOT2191.Quantity,SOT2190.Description
	,AT1302.AccountID, AT1302.PrimeCostAccountID, AT1005.AccountName, A05.AccountName
)Temp 
ORDER BY VoucherNo
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY		
'
END
ELSE
BEGIN
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT SOT2191.APK, SOT2190.APK AS APKMaster, SOT2190.DivisionID, SOT2190.VoucherID , SOT2190.VoucherNo, SOT2190.VoucherDate,SOT2190.Address, SOT2190.ObjectType as ObjectID, AT1202.ObjectName AS ObjectName, SOT2190.Phone,SOT2190.Address2,SOT2191.InventoryID,AT1302.InventoryName,SOT2191.Long as S01ID,SOT2191.Weight as S02ID,SOT2191.High as S03ID,SOT2191.Color as S04ID, AT1302.UnitID, AT1304.UnitName,SOT2191.Quantity,SOT2190.Description,
	AT1302.AccountID as CreditAccountID, AT1302.PrimeCostAccountID as DebitAccountID, AT1005.AccountName AS DebitAccountName, A05.AccountName AS CreditAccountName
	FROM SOT2190 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (SOT2190.DivisionID, ''@@@'') AND SOT2190.ObjectType = AT1202.ObjectID
	LEFT JOIN SOT2191 WITH (NOLOCK) ON SOT2190.DivisionID  = SOT2191.DivisionID AND SOT2190.VoucherID  = SOT2191.VoucherID 
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID  = AT1302.DivisionID AND AT1302.InventoryID  = SOT2191.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
		LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.DivisionID in (SOT2190.DivisionID,''@@@'') and AT1302.AccountId = AT1005.AccountID
    LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN (SOT2190.DivisionID, ''@@@'') AND AT1302.PrimeCostAccountID = A05.AccountID
	WHERE '+@sWhere+'
	GROUP BY SOT2191.APK, SOT2190.APK ,SOT2190.DivisionID, SOT2190.VoucherID , SOT2190.VoucherNo, SOT2190.VoucherDate, SOT2190.ObjectID, AT1202.ObjectName,SOT2190.Address,SOT2190.ObjectType, SOT2190.Phone,SOT2190.Address2,SOT2191.InventoryID,AT1302.InventoryName,SOT2191.Long,SOT2191.Weight,SOT2191.High,SOT2191.Color,AT1302.UnitID,AT1304.UnitName,SOT2191.Quantity,SOT2190.Description
	,AT1302.AccountID, AT1302.PrimeCostAccountID, AT1005.AccountName, A05.AccountName
)Temp 
ORDER BY VoucherNo
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
END

PRINT @sSQL
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO