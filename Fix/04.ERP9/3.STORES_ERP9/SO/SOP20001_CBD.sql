IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'SOP20001_CBD') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE SOP20001_CBD
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
----Created by: Kiều Nga, Date: 14/12/2020
----Edit by : Đình Hòa 29/03/2021 : Load và lọc cột Đã thu tiền (IsCollectedMoney)
-- <Example>
/* 
EXEC SOP20001_CBD 'CAN','','','','','','','','', '','' , '', 1, '2015-01-01', '2017-12-30', '01/2017'',''09/2017' 
,'USER01',N'ASOFTADMIN'',''USER08',1,200, 0, N' where OrderDate between ''2016-11-07'' and ''2017-11-07'' '
*/
----
CREATE PROCEDURE SOP20001_CBD ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @VoucherNo  NVARCHAR(250),
		@AccountID  NVARCHAR(250),
		@VATAccountID  NVARCHAR(250),
		@VoucherTypeID  NVARCHAR(250),
		@RouteID  NVARCHAR(250),
		@DeliveryEmployeeID  NVARCHAR(250),
		@EmployeeID  NVARCHAR(250),
		@IsPrinted  NVARCHAR(250),
		@OrderStatus  NVARCHAR(250),
		@IsConfirmName nvarchar(50),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@ConditionSOrderID  NVARCHAR(Max), 
		@PageNumber INT,
		@PageSize INT,
		@IsHistory Int = 0,
		@SearchWhere NVARCHAR(Max) = NULL,
		@IsWholeSale TINYINT = 0, 
		@IsCollectedMoney VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

SET @sWhere='1 = 1'     
SET @OrderBy = ' M.CreateDate DESC, M.OrderDate, M.VoucherNo'   
IF isnull(@SearchWhere,'') =''
Begin
	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  AND CONVERT(VARCHAR(10),OT2001.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 1 
	SET @sWhere = @sWhere + ' AND (CASE WHEN OT2001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) 
				ELSE rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) END) in ('''+@Period +''')'
	--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and OT2001.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'and OT2001.DivisionID IN ('''+@DivisionIDList+''')'
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@AccountID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(OT2001.ObjectID, '''') LIKE N''%'+@AccountID+'%''  or ISNULL(OT2001.ObjectName, '''') LIKE N''%'+@AccountID+'%'')'
	IF Isnull(@VoucherTypeID, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
	IF Isnull(@EmployeeID, '') != '' 
		SET @sWhere = @sWhere + ' AND (ISNULL(OT2001.EmployeeID, '''') LIKE N''%'+@EmployeeID+'%''  or ISNULL(A03.FullName, '''') LIKE N''%'+@EmployeeID+'%'')' 
	IF Isnull(@OrderStatus, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.OrderStatus, '''') LIKE N''%'+@OrderStatus+'%'' '
	IF Isnull(@IsConfirmName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.IsConfirm, 0)='+@IsConfirmName
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.EmployeeID, OT2001.CreateUserID) in ('''+@ConditionSOrderID+''')'
	IF Isnull(@IsCollectedMoney, '') != ''
	BEGIN
		IF @IsCollectedMoney = '0'
			SET @sWhere = @sWhere + ' AND AT9000.OrderID IS NULL'
		ELSE
			SET @sWhere = @sWhere + ' AND AT9000.OrderID IS NOT NULL'
	END
End
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'
End

--Xét có thiết lập duyệt trên erp9
DECLARE @Levels NVARCHAR(50) ='0'
IF EXISTS (select top 1 Levels from  ST0010 where TypeID=N'DHB')
	SET @Levels = (select top 1 Levels from  ST0010 where TypeID=N'DHB')

SET @sSQL = '
SELECT OT2001.APK, OT2001.DivisionID
, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo
, OT2001.OrderDate
, OT2001.ObjectID, OT2001.ObjectName 
, OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description as OrderStatusName
, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.TranMonth, OT2001.TranYear, A03.FullName EmployeeID
, OT2001.SalesManID, OT2001.ShipDate,  Case when '+ isnull(@Levels,'0')+' >0 then OT2001.Status else OT2001.IsConfirm end AS IsConfirm, Case when '+ isnull(@Levels,'0')+' >0 then B.Description else AT01.Description end as IsConfirmName, OT2001.DescriptionConfirm
, OT2001.ConfirmDate, OT2001.ConfirmUserID
, OT2001.IsInvoice, Sum(A.ConvertedAmount + ISNULL(A.VATConvertedAmount,0)) as TotalAmount
, CASE WHEN AT9000.OrderID IS NOT NULL THEN 1 ELSE 0 END IsCollectedMoney
Into #TemOT2001
FROM OT2001 With (NOLOCK) 
Inner join OT2002 A  With (NOLOCK) ON A.DivisionID = OT2001.DivisionID and A.SOrderID =OT2001.SOrderID
			Left join AT1103 A03 With (NOLOCK) on OT2001.EmployeeID = A03.EmployeeID
			Left join AT0099 With (NOLOCK) on Convert(varchar, OT2001.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003''
			Left join AT0099 AT01 With (NOLOCK) on Convert(varchar, OT2001.IsConfirm) = AT01.ID and AT01.CodeMaster = ''AT00000039''
			Left join OOT0099  B With (NOLOCK) on isnull(OT2001.Status,0) = B.ID and B.CodeMaster = ''Status'' and B.Disabled = 0
			LEFT JOIN AT9000  WITH(NOLOCK) ON OT2001.SOrderID = AT9000.OrderID
	WHERE '+@sWhere+'
	Group by OT2001.APK, OT2001.DivisionID, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate
	, OT2001.ObjectID, OT2001.ObjectName , OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description
	, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.TranMonth, OT2001.TranYear, A03.FullName 
	, OT2001.SalesManID, OT2001.ShipDate,  Case when '+isnull(@Levels,'0')+' >0 then OT2001.Status else OT2001.IsConfirm end, Case when '+isnull(@Levels,'0')+' >0 then B.Description else AT01.Description end, OT2001.DescriptionConfirm
	, OT2001.ConfirmDate, OT2001.ConfirmUserID, OT2001.IsInvoice, AT9000.OrderID 

	Declare @Count int
	Select @Count = Count(OrderStatus) From  #TemOT2001
	'+Isnull(@SearchWhere,'')+'

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID, M.SOrderID, M.VoucherTypeID, M.VoucherNo
	, convert(varchar(20), M.OrderDate, 103) as OrderDate, M.ObjectID, M.ObjectName, M.DeliveryAddress, M.Notes, M.Disabled, M.OrderStatus, M.OrderStatusName
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.EmployeeID
	, M.SalesManID, M.ShipDate,  M.IsConfirm, M.IsConfirmName
	, M.DescriptionConfirm, M.ConfirmUserID, M.ConfirmDate, M.IsInvoice, M.TotalAmount, M.IsCollectedMoney
	From  #TemOT2001 M
	'+Isnull(@SearchWhere,'')+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
