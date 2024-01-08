IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OP0157]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0157]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---- Created by Tiểu Mai on 04/01/2016
---- Purpose: Load danh sách duyệt đơn hàng mua cấp 1.
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 15/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 
--- EXEC [OP0157] 'AS','ASOFTADMIN','%',1,2013,12,2015,0,1,'2016-01-28 23:00:58.977','2016-01-28 23:00:58.977',0,'%',0,'((''''))', '((0 = 0))','((''''))', '((0 = 0))'


CREATE PROCEDURE [dbo].[OP0157]   
			@DivisionID VARCHAR(50),
			@UserID VARCHAR(50),
			@ObjectID VARCHAR(50),
			@FromMonth  INT,
			@FromYear INT,
			@ToMonth INT,
			@ToYear INT,
			@IsCheck TINYINT,
			@IsPeriod TINYINT = 0,
			@FromDate DATETIME = '',
			@ToDate DATETIME = '',
			@Status TINYINT = 0,
			@VoucherTypeID NVARCHAR(50) = '',
			@IsPrinted TINYINT = 0,
			@ConditionVT NVARCHAR(MAX),
			@IsUsedConditionVT NVARCHAR(20),
			@ConditionOB NVARCHAR(MAX),
			@IsUsedConditionOB NVARCHAR(20)
 AS
Declare @sSQL1 as NVARCHAR(MAX),
		@sSQL2 as NVARCHAR(MAX),
		@sWhere as NVARCHAR(500)
If @IsCheck  = 1
	Set @sWhere = ''
Else
	Set @sWhere = ' and  OT3001.IsConfirm = 0 '

IF @IsPrinted IS NOT NULL AND @IsPrinted = 1
BEGIN
	SET @sWHERE = @sWHERE + N' AND ISNULL(OT3001.IsPrinted, 0) = 1 '
END

IF @IsPrinted IS NOT NULL AND @IsPrinted = 2 
BEGIN
	SET @sWHERE = @sWHERE + N' AND ISNULL(OT3001.IsPrinted, 0) = 0 '
END

IF @ObjectID IS NOT NULL AND @ObjectID <> '' AND @ObjectID <> '%'
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT3001.ObjectID = '''+@ObjectID+'''	'
END

IF @Status IS NOT NULL
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT3001.OrderStatus = ' + STR(@Status) + ' '
END

IF @VoucherTypeID IS NOT NULL AND @VoucherTypeID <> '' AND @VoucherTypeID <> '%'
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT3001.VoucherTypeID = '''+@VoucherTypeID+''' '
END

IF @IsPeriod = 1
SET @sWhere = @sWhere +	'
	AND OT3001.TranMonth + OT3001.TranYear * 100 BETWEEN '+str(@FromMonth)+' + '+str(@Fromyear)+' *100 and  '+str(@ToMonth)+' + '+str(@Toyear)+' *100 '
ELSE
	SET @sWhere = @sWhere + '
	AND CONVERT(varchar(10),OT3001.OrderDate,101) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,101)+''' AND '''+CONVERT (VARCHAR(10),@ToDate,101)+''' '
	

Set @sSQL1 =N' 
Select Distinct OT3001.POrderID, OT3001.VoucherTypeID, OT3001.VoucherNo, OT3001.DivisionID, OT3001.TranMonth, OT3001.TranYear,
		OrderDate, OT3001.InventoryTypeID, InventoryTypeName, OT3001.CurrencyID, CurrencyName, 	
		OT3001.ExchangeRate,  OT3001.PaymentID, 
		OT3001.ObjectID,  isnull(OT3001.ObjectName, AT1202.ObjectName)  as ObjectName, 
		isnull(OT3001.VatNo, AT1202.VatNo)  as VatNo,  isnull( OT3001.Address, AT1202.Address)  as Address,
		OT3001.ReceivedAddress, OT3001.ClassifyID, ClassifyName, OT3001.Transport,
		OT3001.EmployeeID,  AT1103.FullName,  IsSupplier, IsUpdateName, IsCustomer,
		ConvertedAmount = (Select Sum(isnull(ConvertedAmount,0)- isnull(DiscountConvertedAmount,0) + isnull(VATConvertedAmount, 0))  
		From OT3002 WITH (NOLOCK) Where OT3002.POrderID = OT3001.POrderID),
		OriginalAmount = (Select Sum(isnull(OriginalAmount,0)- isnull(DiscountOriginalAmount,0) + isnull(VATOriginalAmount, 0))  From OT3002 WITH (NOLOCK) Where OT3002.POrderID = OT3001.POrderID),
		OT3001.Notes, OT3001.Disabled, OT3001.OrderStatus, OV1001.Description as OrderStatusName, 
		OV1001.EDescription as EOrderStatusName, 
		OT3001.OrderType,  OV1002.Description as OrderTypeName, 
		OT3001.ContractNo, OT3001.ContractDate,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
		OT1002_1.AnaName as Ana01Name, OT1002_2.AnaName as Ana02Name, 
		OT1002_3.AnaName as Ana03Name, OT1002_4.AnaName as Ana04Name, OT1002_5.AnaName as Ana05Name, 
		OT3001.CreateUserID, OT3001.CreateDate,  
		OT3001.LastModifyUserID, OT3001.LastModifyDate, ShipDate, OT3001.DueDate,OT3001.RequestID,
		OT3001.varchar01, OT3001.varchar02, OT3001.varchar03, OT3001.varchar04, OT3001.varchar05,
		OT3001.varchar06, OT3001.varchar07, OT3001.varchar08, OT3001.varchar09, OT3001.varchar10,
		OT3001.varchar11, OT3001.varchar12, OT3001.varchar13, OT3001.varchar14, OT3001.varchar15,
		OT3001.varchar16, OT3001.varchar17, OT3001.varchar18, OT3001.varchar19, OT3001.varchar20,
		OT3001.PaymentTermID,
		OT3001.IsConfirm,

		OT1102.Description as  IsConfirmName,
		OT1102.EDescription as EIsConfirmName,
		OT3001.DescriptionConfirm,
		
		OT3001.IsConfirm01,
		OT3001.ConfDescription01,
		CASE WHEN ISNULL(OT3001.IsConfirm01,0) = 0 THEN N''Chưa chấp nhận''
		WHEN ISNULL(OT3001.IsConfirm01,0) = 1 THEN N''Xác nhận''
		WHEN ISNULL(OT3001.IsConfirm01,0) = 2 THEN N''Từ chối''
		END as  IsConfirmName01,
		O12.EDescription as EIsConfirmName01,
		OT3001.IsConfirm02,
		OT3001.ConfDescription02,
		CASE WHEN ISNULL(OT3001.IsConfirm02,0) = 0 THEN N''Chưa chấp nhận''
		WHEN ISNULL(OT3001.IsConfirm02,0) = 1 THEN N''Xác nhận''
		WHEN ISNULL(OT3001.IsConfirm02,0) = 2 THEN N''Từ chối''
		END as  IsConfirmName02,
		O13.EDescription as EIsConfirmName02'
	
Set @sSQL2 =N' 
From OT3001 WITH (NOLOCK) left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3001.ObjectID
		left join OT1002 OT1002_1 WITH (NOLOCK) on OT1002_1.AnaID = OT3001.Ana01ID and OT1002_1.AnaTypeID = ''P01'' And OT1002_1.DivisionID = OT3001.DivisionID
		left join OT1002 OT1002_2 WITH (NOLOCK) on OT1002_2.AnaID = OT3001.Ana02ID and OT1002_2.AnaTypeID = ''P02'' And OT1002_2.DivisionID = OT3001.DivisionID
		left join OT1002 OT1002_3 WITH (NOLOCK) on OT1002_3.AnaID = OT3001.Ana03ID and OT1002_3.AnaTypeID = ''P03'' And OT1002_3.DivisionID = OT3001.DivisionID
		left join OT1002 OT1002_4 WITH (NOLOCK) on OT1002_4.AnaID = OT3001.Ana04ID and OT1002_4.AnaTypeID = ''P04'' And OT1002_4.DivisionID = OT3001.DivisionID
		left join OT1002 OT1002_5 WITH (NOLOCK) on OT1002_5.AnaID = OT3001.Ana05ID and OT1002_5.AnaTypeID = ''P05''  And OT1002_5.DivisionID = OT3001.DivisionID
		left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT3001.InventoryTypeID
		inner join AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT3001.CurrencyID
		left join AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT3001.EmployeeID
		left join OT1001 WITH (NOLOCK) on OT1001.ClassifyID = OT3001.ClassifyID And OT1001.DivisionId = OT3001.DivisionId and OT1001.TypeID = ''PO''
		left join OV1001 on OV1001.OrderStatus = OT3001.OrderStatus and OV1001.DivisionId = OT3001.DivisionId And OV1001.TypeID= ''PO''
		left join OV1002 on OV1002.OrderType = OT3001.OrderType And OV1002.DivisionID = OT3001.DivisionID and OV1002.TypeID =''PO''
		left join OT1102 WITH (NOLOCK) on OT1102.Code = OT3001.IsConfirm And OT1102.DivisionID = OT3001.DivisionID and OT1102.TypeID = ''PO''
		left join OT1102 O12 WITH (NOLOCK) on O12.Code = OT3001.IsConfirm01 And O12.DivisionID = OT3001.DivisionID and O12.TypeID = ''PO''
		left join OT1102 O13 WITH (NOLOCK) on O13.Code = OT3001.IsConfirm02 And O13.DivisionID = OT3001.DivisionID and O13.TypeID = ''PO''
Where OT3001.ObjectID like '''+ @ObjectID+''' 
  and OT3001.DivisionID = '''+ @DivisionID+'''
  and (ISNULL(OT3001.VoucherTypeID, ''#'') IN ('+@ConditionVT+') OR '+@IsUsedConditionVT+')
  and (ISNULL(OT3001.ObjectID, ''#'') IN ('+@ConditionOB+') OR '+@IsUsedConditionOB+')
  and OT3001.POrderID  not in (select  Distinct  isnull(OrderID,'''')  from AT9000 WITH (NOLOCK) )--chi cac phieu chua ke thua sang  mua hang
  
'
EXEC (@sSQL1+@sSQL2+@sWhere)
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sWhere

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

