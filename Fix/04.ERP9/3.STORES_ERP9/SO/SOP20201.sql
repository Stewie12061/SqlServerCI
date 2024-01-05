IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20201]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form SOP2020 Danh muc phiếu báo giá.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date: 23/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Hoài Bảo, Date 14/04/2022: Cập nhật điều kiện search theo ngày và theo kỳ
--- Modify by Tấn Lộc, Date 18/05/2022: Bổ sung thêm lấy dữ liệu cho trường Cơ hội
--- Modify by Hoài Bảo, Date 23/05/2022: Thay đổi lấy tình trạng phiếu báo giá từ bảng AT0099 -> CRMT0099, cập nhật điều kiện lọc Tình trạng phiếu theo QuotationStatus
--- Modify by Hoài Bảo, Date 07/07/2022: Bổ sung cột InheritOrder
--- Modify by Hoài Bảo, Date 13/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
----    EXEC SOP20201 'AS','','', 1, '2015-01-01', '2017-12-30', '05/2017'',''03/2017'',''04/2017' ,'NV01',N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' ,1,20,''

CREATE PROCEDURE SOP20201 ( 
  @DivisionID VARCHAR(50) = '',
  @DivisionIDList NVARCHAR(2000) = '',  
  @QuotationNo  NVARCHAR(250) = '',
  @ObjectID  NVARCHAR(250) = '',
  @VoucherTypeID  NVARCHAR(250) = '',
  @EmployeeID  NVARCHAR(250) = '',
  @Status  NVARCHAR(250) = '',
  @IsConfirm  NVARCHAR(250) = '',
  @IsDate TINYINT = 0,--0: theo ngày, 1: Theo kỳ
  @FromDate DATETIME = NULL,
  @ToDate DATETIME = NULL,
  @Period NVARCHAR(4000) = '',
  @UserID  VARCHAR(50) = '',
  @ConditionQuotationID NVARCHAR (MAX) = '',
  @PageNumber INT = 1,
  @PageSize INT = 25,
  @SearchWhere NVARCHAR(MAX) = NULL,
  @ClassifyID NVARCHAR(50) = NULL,
  @RelAPK NVARCHAR(250) = '',
  @RelTable NVARCHAR(250) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @sWhere = ' 1 = 1 '
SET @sJoin = ''
SET @TotalRow = ''
SET @OrderBy = 'OT2101.DivisionID, OT2101.CreateDate DESC, OT2101.QuotationNo'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF ISNULL(@SearchWhere,'') =''
BEGIN
	IF @IsDate = 0 
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (OT2101.QuotationDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (OT2101.QuotationDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (OT2101.QuotationDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END

	IF @IsDate = 1 AND ISNULL(@Period, '') != ''
		SET @sWhere = @sWhere + ' AND (CASE WHEN OT2101.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT2101.TranMonth)))+''/''+ltrim(Rtrim(str(OT2101.TranYear))) 
				ELSE rtrim(ltrim(str(OT2101.TranMonth)))+''/''+ltrim(Rtrim(str(OT2101.TranYear))) END) in ('''+@Period +''')'

	--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and OT2101.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'and OT2101.DivisionID IN ('''+@DivisionIDList+''')'
	IF ISNULL(@QuotationNo,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2101.QuotationNo, '''') LIKE N''%'+@QuotationNo+'%'' '

	IF ISNULL(@ObjectID,'') !='' 
		SET @sWhere = @sWhere + ' AND (ISNULL(OT2101.ObjectID, '''') LIKE N''%'+@ObjectID+'%''  or ISNULL(OT2101.ObjectName, '''') LIKE N''%'+@ObjectID+'%'')'

	IF ISNULL(@VoucherTypeID,'') !='' 
		SET @sWhere = @sWhere + ' AND ISNULL(OT2101.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '

	IF ISNULL(@EmployeeID, '') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(OT2101.EmployeeID, '''') LIKE N''%'+@EmployeeID+'%''  or ISNULL(A03.FullName, '''') LIKE N''%'+@EmployeeID+'%'')' 

	IF ISNULL(@IsConfirm,'') !=''	
		SET @sWhere = @sWhere + ' AND ISNULL(OT2101.Status, '''') LIKE N''%'+@IsConfirm+'%'' '

	IF ISNULL(@Status,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2101.QuotationStatus, '''') LIKE N''%'+@Status+'%'' '

	IF ISNULL(@ConditionQuotationID,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2101.EmployeeID, OT2101.CreateUserID) IN ('''+@ConditionQuotationID+''') '

	IF ISNULL(@ClassifyID,'') !=''
		SET @sWhere = @sWhere + ' AND OT2101.ClassifyID = '''+@ClassifyID+''' '
END

IF ISNULL(@SearchWhere,'') !=''
BEGIN
	SET  @sWhere='1 = 1'
END

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sJoin = 
	CASE
		WHEN @RelTable = 'CRMT20501_OT2101_REL' THEN 'INNER JOIN ' +@RelTable+ ' D1 ON D1.QuotationID = OT2101.APK '
		WHEN @RelTable = 'CRMT10101_OT2101_REL' THEN 'LEFT JOIN ' +@RelTable+ ' D1 ON D1.QuotationID = OT2101.QuotationID
													  LEFT JOIN POST0011 D2 ON D2.MemberID = OT2101.ObjectID '
		ELSE @sJoin
	END

	SET @sWhere = 
	CASE
		WHEN @RelTable = 'CRMT20501_OT2101_REL' THEN 'OT2101.DivisionID = ''' + @DivisionID + ''' AND D1.OpportunityID = ''' + @RelAPK + ''' '
		WHEN @RelTable = 'CRMT10101_OT2101_REL' THEN 'OT2101.DivisionID = ''' + @DivisionID + ''' AND (D1.AccountID = ''' + @RelAPK + ''' OR D2.APK = ''' + @RelAPK + ''') '
		ELSE @sWhere
	END
END

SET @sSQL = '
	SELECT OT2101.APK, OT2101.DivisionID
		, OT2101.QuotationID, OT2101.VoucherTypeID, OT2101.QuotationNo
		, OT2101.QuotationDate, OT2101.ObjectID, OT2101.Transport, OT2101.Attention1, OT2101.Attention2, OT2101.Dear
		, Case When OT2101.ObjectName is null then A01.ObjectName else OT2101.ObjectName end as ObjectName
		, OT2101.DeliveryAddress, OT2101.Disabled, B.Description as OrderStatus, B.Description as QuotationStatusName
		, OT2101.CreateDate, OT2101.CreateUserID, OT2101.LastModifyUserID, OT2101.LastModifyDate, OT2101.Ana01ID
		, OT2101.Ana02ID, OT2101.Ana03ID, OT2101.Ana04ID, OT2101.Ana05ID, OT2101.CurrencyID, OT2101.ExchangeRate
		, OT2101.InventoryTypeID, OT2101.TranMonth, OT2101.TranYear, OT2101.EmployeeID
		, OT2101.PaymentID, OT2101.Address, OT2101.OpportunityID, OT2101.EndDate, ISNULL(OT2101.IsSO, 0) as IsSO
		, OT2101.SalesManID,  OT2101.PaymentTermID, OT2101.Status as IsConfirm , A.Description as IsConfirmName, OT2101.DescriptionConfirm
		, OT2101.Varchar01, OT2101.Varchar02, OT2101.Varchar03, OT2101.Varchar04, OT2101.Varchar05, OT2101.Varchar06, OT2101.Varchar07, OT2101.Varchar08
		, OT2101.Varchar09, OT2101.Varchar10, OT2101.Varchar11, OT2101.Varchar12, OT2101.Varchar13, OT2101.Varchar14, OT2101.Varchar15
		, OT2101.Varchar16, OT2101.Varchar17, OT2101.Varchar18, OT2101.Varchar19, OT2101.Varchar20,  OT2101.PriceListID
		, OT2101.Ana06ID, OT2101.Ana07ID, OT2101.Ana08ID, OT2101.Ana09ID, OT2101.Ana10ID, OT2101.DeleteFlg
		, A03.FullName AS EmployeeName, OT2101.Description, C1.OpportunityName
		, STUFF(( SELECT '','' + x.InheritOrder
			FROM (
			SELECT DISTINCT (CONVERT(VARCHAR(50),OT01.APK) + ''_'' + OT01.VoucherNo) AS InheritOrder
			FROM OT2002 OT02 WITH (NOLOCK)
				INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT02.SOrderID = OT01.SOrderID
				INNER JOIN  OT2102 WITH (NOLOCK) ON OT2102.QuotationID = OT02.InheritVoucherID AND OT02.InheritTransactionID = OT2102.TransactionID
			WHERE OT2102.QuotationID = OT2101.QuotationID) x
			FOR XML PATH('''')), 1, 1, '''') AS InheritOrder
	INTO #TemOT2101
	FROM OT2101 With (NOLOCK) 
		LEFT JOIN AT1202 A01 With (NOLOCK) on OT2101.ObjectID = A01.ObjectID
		LEFT JOIN AT1103 A03 With (NOLOCK) on  OT2101.EmployeeID = A03.EmployeeID
		LEFT JOIN AT0099 With (NOLOCK) on Convert(varchar, OT2101.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003''
		LEFT JOIN CRMT0099 B With (NOLOCK) on Convert(varchar, OT2101.QuotationStatus) = B.ID and B.CodeMaster = ''CRMT00000015''
		LEFT JOIN OOT0099  A With (NOLOCK) on ISNULL(OT2101.Status,0) = A.ID and A.CodeMaster = ''Status'' and A.Disabled = 0
		LEFT JOIN CRMT20501 C1 WITH (NOLOCK) ON C1.OpportunityID = OT2101.OpportunityID '
		+@sJoin+
		'
	WHERE '+@sWhere+' and ISNULL(OT2101.DeleteFlg, 0) =0

	DECLARE @Count int
	SELECT @Count = Count(OrderStatus) From  #TemOT2101
	'+ISNULL(@SearchWhere,'')+''

SET	@sSQL1 =N'
	SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum, @Count AS TotalRow	
		,  OT2101.APK, OT2101.DivisionID, OT2101.QuotationID, OT2101.VoucherTypeID, OT2101.QuotationNo
		, convert(varchar(20), OT2101.QuotationDate, 103) as QuotationDate
		, OT2101.ObjectID, OT2101.Transport, OT2101.Attention1, OT2101.Attention2, OT2101.Dear, ObjectName
		, OT2101.DeliveryAddress, OT2101.Disabled, OrderStatus, QuotationStatusName
		, OT2101.CreateDate, OT2101.CreateUserID, OT2101.LastModifyUserID, OT2101.LastModifyDate, OT2101.Ana01ID
		, OT2101.Ana02ID, OT2101.Ana03ID, OT2101.Ana04ID, OT2101.Ana05ID, OT2101.CurrencyID, OT2101.ExchangeRate
		, OT2101.InventoryTypeID, OT2101.TranMonth, OT2101.TranYear, OT2101.EmployeeID
		, OT2101.PaymentID, OT2101.Address, OT2101.OpportunityID, OT2101.EndDate, IsSO
		, OT2101.SalesManID,  OT2101.PaymentTermID, OT2101.IsConfirm, IsConfirmName, OT2101.DescriptionConfirm, OT2101.Varchar01
		, OT2101.Varchar02, OT2101.Varchar03, OT2101.Varchar04, OT2101.Varchar05, OT2101.Varchar06, OT2101.Varchar07, OT2101.Varchar08
		, OT2101.Varchar09, OT2101.Varchar10, OT2101.Varchar11, OT2101.Varchar12, OT2101.Varchar13, OT2101.Varchar14, OT2101.Varchar15
		, OT2101.Varchar16, OT2101.Varchar17, OT2101.Varchar18, OT2101.Varchar19, OT2101.Varchar20, OT2101.PriceListID
		, OT2101.Ana06ID, OT2101.Ana07ID, OT2101.Ana08ID, OT2101.Ana09ID, OT2101.Ana10ID, OT2101.DeleteFlg
		, EmployeeName, OT2101.Description, OT2101.OpportunityName, OT2101.InheritOrder
	FROM #TemOT2101 OT2101
	'+ISNULL(@SearchWhere,'')+'
	Order BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1)
PRINT (@sSQL)
PRINT (@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
