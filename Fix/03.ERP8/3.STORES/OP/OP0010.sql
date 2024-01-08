IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai
---- Date 01/26/2016
---- Purpose: Lọc các đơn hàng bán sắp đến ngày giao hàng.
---- Modified by Tiểu Mai on 02/11/2016: tách chuỗi
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung with (nolock) và chỉnh sửa danh mục dùng chung
---- Modified on 17/11/2021 by Nhật Thanh: Bổ sung điều kiện division khi join bảng

CREATE PROCEDURE [dbo].[OP0010] @DivisionID nvarchar(50),
				@ListSOrderID NVARCHAR(MAX)
								
AS
Declare @sSQL1 as nvarchar(4000),
	@sSQL2 as nvarchar(4000),
	@sSQL3 AS NVARCHAR(MAX)

SET @sSQL3 = ''

Set @sSQL1 =N' 
Select 		OT2001.SOrderID, 	OT2001.VoucherTypeID, 
	VoucherNo, OT2001.DivisionID, OT2001.TranMonth, OT2001.TranYear,
	OrderDate, ContractNo, ContractDate, 
	OT2001.InventoryTypeID, InventoryTypeName,  OT2001.CurrencyID, CurrencyName, 	
	OT2001.ExchangeRate,  OT2001.PaymentID, OT2001.ObjectID,  isnull(OT2001.ObjectName,  AT1202.ObjectName ) as ObjectName, 
	isnull(OT2001.VatNo, AT1202.VatNo)  as VatNo, 	isnull( OT2001.Address, AT1202.Address)  as Address,
	DeliveryAddress, OT2001.ClassifyID, ClassifyName,
	OT2001.EmployeeID,  AT1103.FullName,  OT2001.Transport, IsUpdateName, IsCustomer, IsSupplier,
	ConvertedAmount = (Select Sum(isnull(ConvertedAmount,0)- isnull(DiscountConvertedAmount,0))  From OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
	OriginalAmount = (Select Sum(isnull(OriginalAmount,0)- isnull(DiscountOriginalAmount,0))  From OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
	VATOriginalAmount = (Select Sum(isnull(VATOriginalAmount,0)) From OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
	VATConvertedAmount = (Select Sum(isnull(VATConvertedAmount,0)) From OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
	DiscountConvertedAmount = (Select Sum(isnull(DiscountConvertedAmount,0)) From OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
	OT2001.Notes, OT2001.Disabled, 
	OT2001.OrderStatus, OV1001.Description as OrderStatusName, OV1001.EDescription as EOrderStatusName,
	QuotationID,
	OT2001.OrderType,  OV1002.Description as OrderTypeName,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
	OT2001.CreateUserID, OT2001.CreateDate, 
	OT2001.LastModifyUserID, OT2001.LastModifyDate'

Set @sSQL2 =N' 
From OT2001 WITH (NOLOCK)
	left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2001.ObjectID and AT1202.DivisionID IN (OT2001.DivisionID,''@@@'')
	inner join OT2003 WITH (NOLOCK) on OT2003.SOrderID = OT2001.SOrderID  and OT2003.DivisionID = OT2001.DivisionID
	left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT2001.InventoryTypeID and AT1301.DivisionID IN (OT2001.DivisionID,''@@@'')
	inner join AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT2001.CurrencyID and AT1004.DivisionID IN (OT2001.DivisionID,''@@@'')
	left join AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT2001.EmployeeIDand AT1103.DivisionID IN (OT2001.DivisionID,''@@@'')
	left join OT1001 WITH (NOLOCK) on OT1001.ClassifyID = OT2001.ClassifyID and OT1001.TypeID = ''SO'' and OT1001.DivisionID = OT2001.DivisionID
	left join OV1001 on OV1001.OrderStatus = OT2001.OrderStatus and OV1001.TypeID = ''SO'' and OV1001.DivisionID = OT2001.DivisionID
	left join OV1002 on OV1002.OrderType = OT2001.OrderType and OV1002.TypeID =''SO'' and OV1002.DivisionID = OT2001.DivisionID
Where  OT2001.DivisionID = ''' + @DivisionID + ''' '

SET @sSQL3 = @sSQL3 + '
	AND OT2001.SOrderID in ('''+@ListSOrderID+''') '

EXEC (@sSQL1+@sSQL2+@sSQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
