IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created BY Như Hàn
---- Created date 07/12/2018
----Modify  on 07/08/2019 by Bảo Toàn - Cập nhật phân quyền
----Modify	on 13/02/2023 by Hoài Bảo - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
----Modify	on 08/03/2023 by Hoài Bảo - Bổ sung nghiệp vụ truy vấn ngược từ Báo giá nhà cung cấp
----Modify	on 06/09/2023 by Hoàng Long - [2023/09/TA/0001] - GREE- Cải tiến chức năng gán người theo dõi YCMH - Bổ sung nghiệp vụ Người theo dõi thấy được yêu cầu mua hàng tại danh mục YCMH
---- Purpose: Danh mục yêu cầu mua hàng
/********************************************
EXEC POP2035 'AIC', 'AIC'',''AIN', '', '', 0, '11/2018', '', '', 'VND', 1 , '', 1, 25
EXEC POP2035 @DivisionID, @DivisionList, @FromDate, @ToDate, @IsDate, @Period, @VoucherNo, @VoucherTypeID, @CurrencyID, @OrderStatus, @PriorityID, @PageNumber, @PageSize

'********************************************/
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[POP2035]
    @DivisionID VARCHAR(50) = '',  --Biến môi trường
	@DivisionList NVARCHAR(MAX) = '',  --Chọn
	@FromDate DATETIME = NULL,
	@ToDate	DATETIME = NULL,
	@IsDate INT = 0,
	@Period NVARCHAR(4000) = '',
	@VoucherNo  VARCHAR(50) = '',
	@VoucherTypeID  VARCHAR(10) = '',
	@CurrencyID  VARCHAR(50) = '',
	@OrderStatus  VARCHAR(5) = '',
	@PriorityID VARCHAR(5) = '',
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@LanguageID VARCHAR(50) = 'vi-VN',
	@ConditionPurchaseRequestID NVARCHAR(MAX) = '',
	@UserID  VARCHAR(50) = '',
	@RelAPK NVARCHAR(250) = '',
	@RelTable NVARCHAR(250) = ''

AS

DECLARE @sSQL NVARCHAR (MAX)= N'',
		@sWhere NVARCHAR(MAX)= N'',
		@sJoin NVARCHAR(MAX)= N'',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@A NVARCHAR(50),
		@CustomerIndex INT
		SET @A= N'Tất cả' 

SET @CustomerIndex = (SELECT CustomerName FROM CustomerIndex)

SET @OrderBy = 'O01.DivisionID, O01.OrderDate DESC, O01.VoucherNo DESC'
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> '' 
	SET @sWhere = @sWhere + ' AND O01.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' AND O01.DivisionID = '''+@DivisionID+''''

IF @IsDate = 1 
BEGIN
IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),O01.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
END
IF @IsDate = 0 
BEGIN
IF ISNULL(@Period,'')<>''
SET @sWhere = @sWhere + ' AND (CASE WHEN O01.TranMonth <10 THEN ''0''+rtrim(ltrim(str(O01.TranMonth)))+''/''+ltrim(Rtrim(str(O01.TranYear))) 
				ELSE rtrim(ltrim(str(O01.TranMonth)))+''/''+ltrim(Rtrim(str(O01.TranYear))) END) in ('''+@Period +''')'
END
IF Isnull(@VoucherNo,'') <> '' 
		SET @sWhere = @sWhere + ' AND ISNULL(O01.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
IF Isnull(@VoucherTypeID, '') <> '' 
		SET @sWhere = @sWhere + ' AND ISNULL(O01.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
IF Isnull(@CurrencyID, '') <> '' 
		SET @sWhere = @sWhere + ' AND ISNULL(O01.CurrencyID, '''') LIKE N''%'+@CurrencyID+'%'' '
IF Isnull(@OrderStatus, '') <> ''
		SET @sWhere = @sWhere + ' AND ISNULL(O01.OrderStatus, '''') LIKE N''%'+@OrderStatus+'%'' '
IF Isnull(@PriorityID, '') <> ''
		SET @sWhere = @sWhere + ' AND ISNULL(O01.PriorityID, '''') LIKE N''%'+@PriorityID+'%'' '

IF @CustomerIndex = 162
BEGIN 
	IF Isnull(@ConditionPurchaseRequestID, '') != ''
		SET @sWhere = @sWhere + ' AND ( ISNULL(O01.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' )
		 OR ISNULL(O01.EmployeeID,'''') in (N'''+@ConditionPurchaseRequestID+''' ))'
END
ELSE
BEGIN
	IF Isnull(@ConditionPurchaseRequestID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O01.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' )'
END

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sJoin = 
	CASE
		WHEN @RelTable = 'CRMT20501' THEN 'LEFT JOIN OT3102 O02 WITH (NOLOCK) ON O01.ROrderID = O02.ROrderID AND O01.DivisionID = O02.DivisionID
										   LEFT JOIN ' +@RelTable+ ' O03 WITH (NOLOCK) ON O03.OpportunityID = O02.Ana02ID AND O03.DivisionID = O02.DivisionID'
		WHEN @RelTable = 'AT1020' THEN 'LEFT JOIN ' +@RelTable+ ' O02 WITH (NOLOCK) ON O02.ContractNo = O01.ContractNo'
		WHEN @RelTable = 'CRMT20801' THEN 'INNER JOIN ' +@RelTable+ ' O02 WITH (NOLOCK) ON O02.APK = O01.RequestID'
		WHEN @RelTable = 'POT2021' THEN 'LEFT JOIN OT3102 O02 WITH (NOLOCK) ON O01.ROrderID = O02.ROrderID AND O01.DivisionID = O02.DivisionID
										 INNER JOIN POT2022 O03 WITH (NOLOCK) ON O03.InheritAPKDetail = O02.APK AND O03.InheritTableID = ''OT3101''
										 INNER JOIN ' +@RelTable+ ' O04 WITH (NOLOCK) ON O04.APK = O03.APKMaster'
		ELSE @sJoin
	END

	SET @sWhere = 
	CASE
		WHEN @RelTable = 'CRMT20501' THEN ' AND O01.DivisionID = ''' + @DivisionID + ''' AND O03.APK = ''' + @RelAPK + ''' '
		WHEN @RelTable = 'AT1020' THEN ' AND O01.DivisionID = ''' + @DivisionID + ''' AND O02.APK = ''' + @RelAPK + ''' '
		WHEN @RelTable = 'CRMT20801' THEN ' AND O01.DivisionID = ''' + @DivisionID + ''' AND O02.APK = ''' + @RelAPK + ''' '
		WHEN @RelTable = 'POT2021' THEN ' AND O01.DivisionID = ''' + @DivisionID + ''' AND O04.APK = ''' + @RelAPK + ''' '
		ELSE @sWhere
	END
END

SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow,
O01.APK,
O01.DivisionID,
O01.ROrderID,
O01.VoucherTypeID,
O01.VoucherNo,
O01.OrderDate,
O01.InventoryTypeID As InventoryType,
CASE WHEN ISNULL(O01.InventoryTypeID,''%'') = ''%'' Then N'''+@A+''' ELSE T03.InventoryTypeName END As InventoryTypeID,
O01.CurrencyID,
T4.CurrencyName,
O01.ExchangeRate,
O01.ReceivedAddress,
O01.Description,
O01.Disabled,
O01.OrderStatus as OrderStatusID,
CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T99.[Description] ELSE T99.DescriptionE END AS OrderStatus,
--T99.Description as OrderStatusName,
O01.TranMonth,
O01.TranYear,
O01.EmployeeID,
O01.Transport,
O01.PaymentID,
O01.ShipDate,
O01.ContractNo,
O01.ContractDate,
O01.DueDate,
O01.PriorityID,
A.Description as Status
FROM OT3101 O01 WITH (NOLOCK)
LEFT JOIN AT1004 T4 WITH (NOLOCK) ON T4.CurrencyID = O01.CurrencyID
LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T99.ID = O01.OrderStatus AND CodeMaster = ''AT00000003'' AND T99.Disabled = 0
LEFT JOIN AT1301 T03 WITH (NOLOCK) ON O01.InventoryTypeID = T03.InventoryTypeID
LEFT JOIN OOT0099  A WITH (NOLOCK) on isnull(O01.Status,0) = A.ID and A.CodeMaster = ''Status'' and A.Disabled = 0 '
+@sJoin+
'
WHERE ISNULL(O01.DeleteFlag,0) = 0
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
