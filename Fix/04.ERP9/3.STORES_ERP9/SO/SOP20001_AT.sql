IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20001_AT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20001_AT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form SOF2000 Danh muc đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tra Giang on 28/02/2019:
----Modify by Trà Giang on 17/07/2019: Bổ sung thông tin tên điều khoản thanh toán, phương thức thanh toán, PL đơn hàng.
----Modified by
-- <Example>
----    EXEC SOP20001_AT 'ANG','AS'',''GS','','','','','','','', '' , 1, 5, '2015-01-01', '2016-12-30', '01/2015'',''02/2016'',''03/2016' ,'NV01',1,20
----
CREATE PROCEDURE SOP20001_AT ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@ObjectID  NVARCHAR(250),
		@VoucherTypeID  NVARCHAR(250),
		@OrderStatus  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@IsWholeSale NVARCHAR(250)
) 
AS 


DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = ' 1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'OT2001.DivisionID, OT2001.OrderDate, OT2001.VoucherNo'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	IF @IsDate = 0 
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),OT2001.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 1 
	SET @sWhere = @sWhere + ' AND (CASE WHEN OT2001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) 
				ELSE rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) END) in ('''+@Period +''')'

	IF @VoucherNo IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF @ObjectID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND (ISNULL(OT2001.ObjectID, '''') LIKE N''%'+@ObjectID+'%''  or ISNULL(OT2001.ObjectName, '''') LIKE N''%'+@ObjectID+'%'')'
	IF @VoucherTypeID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
	IF @OrderStatus is not null
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.OrderStatus, '''') LIKE N''%'+@OrderStatus+'%'' '
	IF @IsWholeSale is not null
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.IsWholeSale, '''') LIKE N''%'+@IsWholeSale+'%'' '
		
----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''		


IF EXISTS (SELECT TOP 1 1 FROM OT0001 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = OT2001.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+'''  AND AT0010.UserID = OT2001.CreateUserID '
		SET @sWhere = @sWhere + ' AND (OT2001.CreateUserID = AT0010.UserID OR  OT2001.CreateUserID = '''+@UserID+''') '		
END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	

SET @sSQL = '	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, OT2001.APK, OT2001.DivisionID
, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo
, convert(varchar(20), OT2001.OrderDate, 103) as OrderDate, OT2001.ContractNo, OT2001.ContractDate, OT2001.ClassifyID, OT2001.OrderType
, OT2001.ObjectID
, Case When OT2001.ObjectName is null then A01.ObjectName else OT2001.ObjectName end as ObjectName
, OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description as OrderStatusName, OT2001.QuotationID
, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.Ana01ID
, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID, OT2001.CurrencyID, OT2001.ExchangeRate
, OT2001.InventoryTypeID, OT2001.TranMonth, OT2001.TranYear, OT2001.EmployeeID, OT2001.Transport
, OT2001.PaymentID, OT2001.VatNo, OT2001.Address, OT2001.IsPeriod, OT2001.IsPlan, OT2001.DepartmentID
, OT2001.SalesManID, OT2001.ShipDate, OT2001.InheritSOrderID, OT2001.DueDate, OT2001.PaymentTermID, OT2001.FileType
, OT2001.Contact, OT2001.IsInherit, OT2001.IsConfirm, OT2001.DescriptionConfirm, OT2001.PeriodID, OT2001.Varchar01
, OT2001.Varchar02, OT2001.Varchar03, OT2001.Varchar04, OT2001.Varchar05, OT2001.Varchar06, OT2001.Varchar07, OT2001.Varchar08
, OT2001.Varchar09, OT2001.Varchar10, OT2001.Varchar11, OT2001.Varchar12, OT2001.Varchar13, OT2001.Varchar14, OT2001.Varchar15
, OT2001.Varchar16, OT2001.Varchar17, OT2001.Varchar18, OT2001.Varchar19, OT2001.Varchar20, OT2001.PriceListID, OT2001.SalesMan2ID
, OT2001.Ana06ID, OT2001.Ana07ID, OT2001.Ana08ID, OT2001.Ana09ID, OT2001.Ana10ID, OT2001.IsPrinted, OT2001.IsSalesCommission
, OT2001.OrderTypeID, OT2001.ImpactLevel, OT2001.IsConfirm01, OT2001.ConfDescription01, OT2001.IsConfirm02, OT2001.ConfDescription02
, OT2001.ConfirmDate, OT2001.ConfirmUserID
, OT2001.IsInvoice
, OT2001.DiscountSalesAmount, OT2001.DiscountPercentSOrder, OT2001.DiscountAmountSOrder
, OT2001.ShipAmount, OT2002.TotalAfterAmount, ISNULL(OT2002.TotalAfterAmount,0) - ISNULL(OT2001.ShipAmount,0) AS PayAmount, AT1208.PaymentTermName, AT1205.PaymentName, OT1001.ClassifyName
FROM OT2001 WITH (NOLOCK) 
LEFT JOIN AT1202 A01 WITH (NOLOCK) on OT2001.DivisionID = A01.DivisionID and OT2001.ObjectID = A01.ObjectID
LEFT JOIN AT1103 A03 WITH (NOLOCK) on OT2001.DivisionID = A03.DivisionID and OT2001.EmployeeID = A03.EmployeeID
LEFT JOIN AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = OT2001.PaymentTermID AND AT1208.DivisionID = OT2001.DivisionID
LEFT JOIN AT1205 WITH (NOLOCK) ON AT1205.PaymentID = OT2001.PaymentID AND AT1205.DivisionID = OT2001.DivisionID
LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT2001.ClassifyID AND AT1205.DivisionID = OT2001.DivisionID
LEFT JOIN AT0099 WITH (NOLOCK) on Convert(varchar, OT2001.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003'' ' +@sSQLPer + '
LEFT JOIN (SELECT OT2002.DivisionID, OT2002.SOrderID, SUM(Isnull(OT2002.OriginalAmount,0) - Isnull(OT2002.DiscountPercent,0)*Isnull(OT2002.OriginalAmount,0)/100 
			- Isnull(OT2002.DiscountSaleAmountDetail,0) + OT2002.VATOriginalAmount) AS TotalAfterAmount
           FROM OT2002 WITH (NOLOCK)
           GROUP BY OT2002.DivisionID, OT2002.SOrderID			
) OT2002 ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
WHERE OT2001.DivisionID = '''+@DivisionID+''' AND OrderType = 0 AND '+@sWhere+'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
--print (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
