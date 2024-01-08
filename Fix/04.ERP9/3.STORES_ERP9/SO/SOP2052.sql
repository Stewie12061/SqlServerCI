IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Danh sách đơn hàng giao trễ theo qui cách sản phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example>
-- SOP2052 'DTI', 'HUULOI'
-- </Example>
----Created by Kiều Nga on 05/12/2019
----Modified by Trọng Kiên on 08/12/2020: Bổ sung Customize Mai Thư trỏ về bảng OT2003_MT

CREATE PROCEDURE [dbo].[SOP2052] 
@DivisionID varchar(50),
@UserID varchar(50),
@PageNumber int,
@PageSize int
								
AS
Declare @sSQL1 as nvarchar(4000),
	@sSQL2 as nvarchar(4000),
	@sSQL3 AS NVARCHAR(MAX),
	@sSQL4 AS NVARCHAR(MAX) = '',
	@CustomizeIndex INT = -1

SET @CustomizeIndex = (SELECT CustomerName FROM CustomerIndex)

IF (@CustomizeIndex = 117) --- Customize Mai Thư
BEGIN
    SET @sSQL2 = N' FROM OT2001 WITH (NOLOCK)
						LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
						INNER JOIN OT2003_MT WITH (NOLOCK) ON OT2003_MT.SOrderID = OT2001.SOrderID AND OT2003_MT.DivisionID = OT2001.DivisionID
						LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
						INNER JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT2001.CurrencyID
						LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
						LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT2001.ClassifyID and OT1001.TypeID = ''SO'' AND OT1001.DivisionID = OT2001.DivisionID
						LEFT JOIN OV1001 ON OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = ''SO'' AND OV1001.DivisionID = OT2001.DivisionID
						LEFT JOIN OV1002 ON OV1002.OrderType = OT2001.OrderType AND OV1002.TypeID =''SO'' AND OV1002.DivisionID = OT2001.DivisionID
						LEFT JOIN AT0099 WITH (NOLOCK) ON CONVERT(VARCHAR, OT2001.OrderStatus) = AT0099.ID AND AT0099.CodeMaster = ''AT00000003''
					WHERE  OT2001.DivisionID = ''' + @DivisionID + ''' '
END
ELSE
BEGIN
    SET @sSQL2 = N' FROM OT2001 WITH (NOLOCK)
						LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
						INNER JOIN OT2003 WITH (NOLOCK) ON OT2003.SOrderID = OT2001.SOrderID AND OT2003.DivisionID = OT2001.DivisionID
						LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
						INNER JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT2001.CurrencyID
						LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
						LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT2001.ClassifyID and OT1001.TypeID = ''SO'' AND OT1001.DivisionID = OT2001.DivisionID
						LEFT JOIN OV1001 ON OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = ''SO'' AND OV1001.DivisionID = OT2001.DivisionID
						LEFT JOIN OV1002 ON OV1002.OrderType = OT2001.OrderType AND OV1002.TypeID =''SO'' AND OV1002.DivisionID = OT2001.DivisionID
						LEFT JOIN AT0099 WITH (NOLOCK) ON CONVERT(VARCHAR, OT2001.OrderStatus) = AT0099.ID AND AT0099.CodeMaster = ''AT00000003''
					WHERE  OT2001.DivisionID = ''' + @DivisionID + ''' '
END

SET @sSQL3 = ''

Set @sSQL1 =N' 
    CREATE TABLE #temp (SOrderID Nvarchar(50) ,Date Datetime);
	INSERT INTO #temp
	EXEC OP0019 ''' + @DivisionID + ''','''',''' + @UserID + '''

	Select DISTINCT OT2001.SOrderID,OT2001.VoucherTypeID, 
	OT2001.VoucherNo, OT2001.DivisionID, OT2001.TranMonth, OT2001.TranYear,
	OT2001.OrderDate, OT2001.ContractNo, OT2001.ContractDate, 
	AT1301.InventoryTypeID, AT1301.InventoryTypeName,  OT2001.CurrencyID, AT1004.CurrencyName, 	
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
	AT0099.Description as OrderStatus, OV1001.Description as OrderStatusName, OV1001.EDescription as EOrderStatusName,
	QuotationID,
	OT2001.OrderType,  OV1002.Description as OrderTypeName,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
	OT2001.CreateUserID, OT2001.CreateDate, 
	OT2001.LastModifyUserID, OT2001.LastModifyDate
	INTO #TempSOP0019'

SET @sSQL3 = @sSQL3 + '
	AND OT2001.SOrderID in (select DISTINCT SOrderID from #temp) 
	Order by OT2001.VoucherNo
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
	
	SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, COUNT(*) OVER () AS TotalRow, * FROM #TempSOP0019
	DROP TABLE #TempSOP0019'

EXEC (@sSQL1+@sSQL2+@sSQL3)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
