IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP20001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP20001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Form POF2000 Danh muc đơn hàng mua
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 28/07/2017
---- Modifier by Như Hàn on 21/12/2018: Bổ sung lọc theo tình trạng đã lên tiến độ hay chưa lên tiến độ
---- Modify on 07/08/2019 by Bảo Toàn - Cập nhật phân quyền
---- Modify on 19/11/2021 by Văn Tài  - Bổ sung checkbox kiểm tra đã xuất hóa đơn ở T.
---  Modify on 25/11/2021 by Văn Tài  - Fix lỗi kiểm tra cờ Xuất hóa đơn từ T.
---  Modify on 28/12/2021 by Văn Tài  - Fix lỗi kiểm tra DivisionID.
---  Modify on 17/01/2022 by Kiều Nga  - Fix Lỗi không hiển thị tình trạng đã xuất hóa đơn cho đơn hàng mua.
---  Modify on 15/04/2022 by Hoài Bảo  - Cập nhật điều kiện search theo ngày, theo kỳ
---  Modify on 11/08/2022 by Nhật Quang  - Cập nhật thêm InventoryID 
---  Modify on 13/12/2022 by Đức Tuyên  - Cập nhật điều kiện cho InventoryID
---  Modify on 10/01/2023 by Hoài Thanh - Bổ sung luồng load dữ liệu từ dashboard
---  Modify on 15/02/2023 by Hoài Bảo - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
---  Modify on 20/04/2023 by Đức Tuyên - Đơn hàng mua load chậm.
---  Modify on 30/06/2023 by Nhật Thanh- Convert OrderDate kiểu datetime để order by
-- <Example>
/* 
EXEC POP20001 'MS','','','','','','','', '','', 1, '2015-01-01', '2017-12-30', '04/2017'',''05/2017' ,'NV01',1,20
*/
----
CREATE PROCEDURE POP20001 ( 
        @DivisionID VARCHAR(50) = '',  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',  --Chọn trong DropdownChecklist DivisionID
        @VoucherNo  NVARCHAR(250) = '',
		@ObjectID  NVARCHAR(250) = '',
		@CurrencyID  NVARCHAR(250) = '',
		@VoucherTypeID  NVARCHAR(250) = '',
		@PurchaseManID  NVARCHAR(250) = '',
		@EmployeeID  NVARCHAR(250) = '',
		@OrderStatus  NVARCHAR(250) = '',
		@ContractNo  NVARCHAR(250) = '',
		@BillOfLadingNo  NVARCHAR(250) = '',
		@InvoiceNo  NVARCHAR(250) = '',
		@InventoryID NVARCHAR(50) = '',
		@InventoryName NVARCHAR(250) = '',
		@DepartureDate DATETIME = NULL,
		@ArrivalDate DATETIME = NULL,
		@IsDate TINYINT = 0,--0: theo ngày, 1: Theo kỳ
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@Period NVARCHAR(4000) = '', --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@ReceivingStatus INT = 0,
		@ConditionOpportunityID NVARCHAR(MAX) = '',
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@IsReceived INT = 0, --1: lấy các đơn hàng đã nhận
		@StatusIDList NVARCHAR(MAX) = NULL,
		@InventoryTypeIDList NVARCHAR(MAX) = NULL,
		@InventoryIDList NVARCHAR(MAX) = NULL,
		@ObjectIDList NVARCHAR(MAX) = NULL,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
		@sWhereDashboard NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @sWhere=''
SET @OrderBy = 'M.DivisionID, M.OrderDate DESC, M.VoucherNo DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
--Check Para DivisionIDList null then get DivisionID 
IF @DivisionIDList IS NULL or @DivisionIDList = ''
	SET @sWhere = @sWhere + ' OT3001.DivisionID = '''+ @DivisionID+''''
Else
	BEGIN
		SET @sWhere = @sWhere + ' OT3001.DivisionID IN ('''+@DivisionIDList+''')'
		SET @sWhereDashboard = @sWhereDashboard + ' OT3001.DivisionID IN ('''+@DivisionIDList+''')'
	END

IF @IsDate = 0 
	BEGIN
		--SET @sWhere = @sWhere + ' 
		--AND CONVERT(VARCHAR(10),OT3001.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (OT3001.OrderDate >= ''' + @FromDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (OT3001.OrderDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (OT3001.OrderDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
IF @IsDate = 1 AND ISNULL(@Period, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' 
			AND (CASE WHEN OT3001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT3001.TranMonth)))+''/''+ltrim(Rtrim(str(OT3001.TranYear))) 
			ELSE rtrim(ltrim(str(OT3001.TranMonth)))+''/''+ltrim(Rtrim(str(OT3001.TranYear))) END) in ('''+@Period +''')'
		SET @sWhereDashboard = @sWhereDashboard + ' 
			AND (CASE WHEN OT3001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT3001.TranMonth)))+''/''+ltrim(Rtrim(str(OT3001.TranYear))) 
			ELSE rtrim(ltrim(str(OT3001.TranMonth)))+''/''+ltrim(Rtrim(str(OT3001.TranYear))) END) in ('''+@Period +''')'
	END
IF Isnull(@VoucherNo, '') != '' 
	SET @sWhere = @sWhere + ' 
	AND ISNULL(OT3001.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
IF Isnull(@ObjectID, '') != ''
	SET @sWhere = @sWhere + ' 
	AND (ISNULL(OT3001.ObjectID, '''') LIKE N''%'+@ObjectID+'%''  or ISNULL(OT3001.ObjectName, '''') LIKE N''%'+@ObjectID+'%'')'
IF Isnull(@VoucherTypeID, '') != '' 
	SET @sWhere = @sWhere + ' 
	AND ISNULL(OT3001.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
IF Isnull(@CurrencyID, '') != '' 
	SET @sWhere = @sWhere + ' 
	AND ISNULL(OT3001.CurrencyID, '''') LIKE N''%'+@CurrencyID+'%'' '
IF Isnull(@EmployeeID, '') != '' 
	SET @sWhere = @sWhere + ' 
	AND (ISNULL(OT3001.EmployeeID, '''') LIKE N''%'+@EmployeeID+'%''  or ISNULL(A03.FullName, '''') LIKE N''%'+@EmployeeID+'%'')' 
IF Isnull(@PurchaseManID, '') != '' 
	SET @sWhere = @sWhere + ' 
	AND (ISNULL(OT3001.PurchaseManID, '''') LIKE N''%'+@PurchaseManID+'%''  or ISNULL(A103.FullName, '''') LIKE N''%'+@PurchaseManID+'%'')' 
IF Isnull(@OrderStatus, '') != ''
	SET @sWhere = @sWhere + ' 
	AND ISNULL(OT3001.OrderStatus, '''') LIKE N''%'+@OrderStatus+'%'' '
IF Isnull(@ContractNo, '') != ''
	SET @sWhere = @sWhere + ' 
	AND ISNULL(OT3001.ContractNo, '''') LIKE N''%'+@ContractNo+'%'' '
IF Isnull(@ReceivingStatus,'') <> ''
	SET @sWhere = @sWhere + ' 
	AND ISNULL(OT3001.ReceivingStatus,0) ='+STR(@ReceivingStatus)+''
IF Isnull(@ConditionOpportunityID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(OT3001.CreateUserID,'''') in (N'''+@ConditionOpportunityID+''' )'
		SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(OT3001.CreateUserID,'''') in (N'''+@ConditionOpportunityID+''' )'
	END
	
IF Isnull(@BillOfLadingNo, '') != '' 
	SET @sWhere = @sWhere + ' AND ISNULL(O37.BillOfLadingNo, '''') LIKE N''%'+@BillOfLadingNo+'%'' '

IF Isnull(@InvoiceNo, '') != '' 
	SET @sWhere = @sWhere + ' AND ISNULL(O37.InvoiceNo, '''') LIKE N''%'+@InvoiceNo+'%'' '

IF Isnull(@InventoryName, '') != '' 
	SET @sWhere = @sWhere + ' AND ISNULL(A13.InventoryName, '''') LIKE N''%'+@InventoryName+'%'' '

if ISNULL(CONVERT(VARCHAR(10),@DepartureDate,101), '') != ''
	SET @sWhere = @sWhere + ' and CONVERT(VARCHAR(10),O37.DepartureDate,101) = N'''+CONVERT(VARCHAR(10),@DepartureDate,101)+''''
	
if ISNULL(CONVERT(VARCHAR(10),@ArrivalDate,101), '') != ''
	SET @sWhere = @sWhere + ' and CONVERT(VARCHAR(10),O37.ArrivalDate,101) = N'''+CONVERT(VARCHAR(10),@ArrivalDate,101)+''''

IF Isnull(@InventoryID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(O32.InventoryID, '''') LIKE N''%'+@InventoryID+'%'' '

IF Isnull(@StatusIDList, '') != ''
	SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(OT3001.OrderStatus, '''') IN ('''+@StatusIDList+''') '

IF Isnull(@InventoryIDList, '') != ''
	SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(O32.InventoryID, '''') IN ('''+@InventoryIDList+''') '

IF Isnull(@InventoryTypeIDList, '') != ''
	SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(A13.InventoryTypeID, '''') IN ('''+@InventoryTypeIDList+''') '

IF Isnull(@ObjectIDList, '') != ''
	SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(OT3001.ObjectID, '''') IN ('''+@ObjectIDList+''') '

IF @Type = 6
	BEGIN
		IF @IsReceived = 1
			SET @sWhereDashboard = @sWhereDashboard + ' AND OT3001.OrderStatus = ''1'' '
		SET @sWhere1 = 'WHERE '+@sWhereDashboard+' '
	END
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sWhere1 = 
		CASE
			WHEN @RelTable = 'AT2006' THEN 'LEFT JOIN AT2007 C1 WITH (NOLOCK) ON C1.InheritTransactionID = O32.TransactionID AND C1.InheritTableID = ''OT3001''
											INNER JOIN ' +@RelTable+ ' C2 WITH (NOLOCK) ON C2.VoucherID = C1.VoucherID 
									  WHERE C2.APK = ''' +@RelAPK+ ''' AND OT3001.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
			ELSE 'WHERE '+@sWhere+' '
		END
	END
	ELSE
		SET @sWhere1 = 'WHERE '+@sWhere+' '
END
		
SET @sSQL = '
	---#IsExportOrderA---
	SELECT distinct 1 as IsExportOrder ,OT02.POrderID, AT90.DivisionID 
	INTO #IsExportOrderA
	FROM  AT9000 AT90 WITH (NOLOCK)
	INNER JOIN OT3002 OT02  With (NOLOCK) ON OT02.DivisionID = AT90.DivisionID 
										AND OT02.POrderID = AT90.OrderID
	WHERE AT90.TransactionTypeID = ''T03''

	---#IsExportOrderB---
	SELECT DISTINCT 1 as IsExportOrder ,OT02.POrderID, AT90.DivisionID 
	INTO #IsExportOrderB
	FROM  AT9000 AT90 WITH (NOLOCK)
			INNER JOIN AT2007 AT07  With (NOLOCK) ON AT07.DivisionID = AT90.DivisionID 
												AND AT07.VoucherID = AT90.WOrderID
			INNER JOIN OT3002 OT02  With (NOLOCK) ON OT02.DivisionID = AT90.DivisionID 
												AND OT02.POrderID = AT07.InheritVoucherID
	WHERE AT90.TransactionTypeID = ''T03''

	---OT3001---
	SELECT distinct OT3001.APK, OT3001.DivisionID
	, OT3001.POrderID, OT3001.VoucherTypeID, OT3001.VoucherNo
	, convert(datetime, OT3001.OrderDate, 103) as OrderDate
	, OT3001.ObjectID, ISNULL(OT3001.ObjectName, A12.ObjectName) as ObjectName , OT3001.CurrencyID
	, OT3001.ReceivedAddress, OT3001.Notes, OT3001.Disabled, OT3001.OrderStatus, AT0099.Description as OrderStatusName
	, OT3001.CreateDate, OT3001.CreateUserID, OT3001.LastModifyUserID, OT3001.LastModifyDate, OT3001.TranMonth, OT3001.TranYear, A03.FullName EmployeeID
	, A103.FullName PurchaseManID, OT3001.ContractNo,  OT3001.IsConfirm, AT01.Description as IsConfirmName, OT3001.DescriptionConfirm
	,ISNULL(A.IsExportOrder,B.IsExportOrder) AS IsExportOrder
	, Sum(O32.ConvertedAmount) + sum(O32.VATConvertedAmount) AS TotalAmount
	Into #TemOT3001
	FROM OT3001 With (NOLOCK) 
				Left join AT1103 A03 With (NOLOCK) on A03.DivisionID IN (''@@@'', OT3001.DivisionID) AND OT3001.EmployeeID = A03.EmployeeID
				Left join AT1103 A103 With (NOLOCK) on A103.DivisionID IN (''@@@'', OT3001.DivisionID) AND OT3001.PurchaseManID = A103.EmployeeID
				Left join AT0099 With (NOLOCK) on Convert(varchar, OT3001.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003''
				Left join AT0099 AT01 With (NOLOCK) on Convert(varchar, OT3001.IsConfirm) = AT01.ID and AT01.CodeMaster = ''AT00000039''
				Left join AT1202 A12 WITH (NOLOCK) on A12.DivisionID IN (''@@@'', OT3001.DivisionID) AND OT3001.ObjectID = A12.ObjectID
				Left join OT3002 O32 WITH (NOLOCK) on O32.DivisionID IN (''@@@'', OT3001.DivisionID) AND OT3001.POrderID = O32.POrderID
				inner join AT1302 A13 WITH (NOLOCK) on A13.DivisionID IN (''@@@'', OT3001.DivisionID) AND O32.InventoryID = A13.InventoryID
				Left join OT3007 O37 WITH (NOLOCK) on OT3001.POrderID = O37.POrderID
				Left join #IsExportOrderA A ON A.DivisionID = OT3001.DivisionID AND A.POrderID = OT3001.POrderID
				Left join #IsExportOrderB B ON  B.DivisionID = OT3001.DivisionID AND B.POrderID = OT3001.POrderID

	'+@sWhere1+'
	Group by OT3001.APK, OT3001.DivisionID
	, OT3001.POrderID, OT3001.VoucherTypeID, OT3001.VoucherNo
	, convert(datetime, OT3001.OrderDate, 103) 
	, OT3001.ObjectID, ISNULL(OT3001.ObjectName, A12.ObjectName), OT3001.CurrencyID
	, OT3001.ReceivedAddress, OT3001.Notes, OT3001.Disabled, OT3001.OrderStatus, AT0099.Description
	, OT3001.CreateDate, OT3001.CreateUserID, OT3001.LastModifyUserID, OT3001.LastModifyDate, OT3001.TranMonth, OT3001.TranYear, A03.FullName
	, A103.FullName , OT3001.ContractNo,  OT3001.IsConfirm, AT01.Description , OT3001.DescriptionConfirm
	,ISNULL(A.IsExportOrder,B.IsExportOrder)

	Declare @Count int
	Select @Count = Count(OrderStatus) From  #TemOT3001

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID
	, M.POrderID, M.VoucherTypeID, M.VoucherNo
	, M.OrderDate
	, M.ObjectID, M.ObjectName , M.CurrencyID
	, M.ReceivedAddress, M.Notes, M.Disabled, M.OrderStatus, M.OrderStatusName
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.EmployeeID
	, M.PurchaseManID, M.ContractNo,  M.IsConfirm, M.IsConfirmName, M.DescriptionConfirm
	, ISNULL(M.IsExportOrder, 0) AS IsExportOrder, M.TotalAmount
	From  #TemOT3001 M
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--PRINT (@sSQL)
EXEC (@sSQL)



--print (@sWhere)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
