IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2052_DATE]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2052_DATE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Danh sách đơn hàng sắp đến ngày nhận theo qui cách sản phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example>
-- POP2052_Date 'DTI', 'HUULOI'
-- </Example>
----Created by Trọng Kiên on 05/12/2019


CREATE PROCEDURE [dbo].[POP2052_Date] 
@DivisionID varchar(50),
@TxtSearch NVARCHAR(MAX),
@RecieveDayDate VARCHAR(50),
@UserID varchar(50),
@PageNumber int,
@PageSize int
								
AS
Declare @sSQL1 as nvarchar(4000),
	@sSQL2 as nvarchar(4000),
	@sSQL3 AS NVARCHAR(MAX),
	@sSQL4 AS NVARCHAR(MAX) = '',
	@sWhere NVARCHAR(MAX) = '',
	@CustomizeIndex INT = -1

SET @CustomizeIndex = (SELECT CustomerName FROM CustomerIndex)

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'WHERE (VoucherNo LIKE N''%' + @TxtSearch + '%'')'

SET @sSQL3 = ''

Set @sSQL1 =N' 
    CREATE TABLE #temp (POrderID Nvarchar(50) ,Date Datetime);
	INSERT INTO #temp
	EXEC POP0019_Date ''' + @DivisionID + ''','''','''+ @RecieveDayDate+ ''','''+ @UserID+ '''

	Select DISTINCT OT3001.APK, OT3001.POrderID,OT3001.VoucherTypeID, 
	OT3001.VoucherNo, OT3001.DivisionID, OT3001.TranMonth, OT3001.TranYear,
	OT3001.OrderDate, OT3001.ContractNo, OT3001.ContractDate, 
	AT1301.InventoryTypeID, AT1301.InventoryTypeName,  OT3001.CurrencyID, AT1004.CurrencyName, 	
	OT3001.ExchangeRate,  OT3001.PaymentID, OT3001.ObjectID,  isnull(OT3001.ObjectName,  AT1202.ObjectName ) as ObjectName, 
	isnull(OT3001.VatNo, AT1202.VatNo)  as VatNo, 	isnull( OT3001.Address, AT1202.Address)  as Address,
	ReceivedAddress, OT3001.ClassifyID, ClassifyName,
	OT3001.EmployeeID,  AT1103.FullName,  OT3001.Transport, IsUpdateName, IsCustomer, IsSupplier,
	ConvertedAmount = (Select Sum(isnull(ConvertedAmount,0)- isnull(DiscountConvertedAmount,0))  From OT3002 Where OT3002.POrderID = OT3001.POrderID),
	OriginalAmount = (Select Sum(isnull(OriginalAmount,0)- isnull(DiscountOriginalAmount,0))  From OT3002 Where OT3002.POrderID = OT3001.POrderID),
	VATOriginalAmount = (Select Sum(isnull(VATOriginalAmount,0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID),
	VATConvertedAmount = (Select Sum(isnull(VATConvertedAmount,0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID),
	DiscountConvertedAmount = (Select Sum(isnull(DiscountConvertedAmount,0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID),
	OT3001.Notes, OT3001.Disabled, 
	AT0099.Description as OrderStatus, OV1001.Description as OrderStatusName, OV1001.EDescription as EOrderStatusName,
	OT3001.OrderType,  OV1002.Description as OrderTypeName,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
	OT3001.CreateUserID, OT3001.CreateDate, 
	OT3001.LastModifyUserID, OT3001.LastModifyDate
	INTO #TempPOP0019'

SET @sSQL3 = @sSQL3 + '
	AND OT3001.POrderID in (select DISTINCT POrderID from #temp) 
	Order by OT3001.VoucherNo
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
	
	SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, COUNT(*) OVER () AS TotalRow, * FROM #TempPOP0019 '+ @sWhere +'
	DROP TABLE #TempPOP0019'

IF (@CustomizeIndex = 117) --- Customize Mai Thư
BEGIN
    SET @sSQL2 = N' FROM OT3001 WITH (NOLOCK)
						LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT3001.ObjectID
						INNER JOIN OT3003_MT WITH (NOLOCK) ON OT3003_MT.POrderID = OT3001.POrderID AND OT3003_MT.DivisionID = OT3001.DivisionID
						LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT3001.InventoryTypeID
						INNER JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT3001.CurrencyID
						LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT3001.EmployeeID
						LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT3001.ClassifyID and OT1001.TypeID = ''SO'' AND OT1001.DivisionID = OT3001.DivisionID
						LEFT JOIN OV1001 ON OV1001.OrderStatus = OT3001.OrderStatus AND OV1001.TypeID = ''SO'' AND OV1001.DivisionID = OT3001.DivisionID
						LEFT JOIN OV1002 ON OV1002.OrderType = OT3001.OrderType AND OV1002.TypeID =''SO'' AND OV1002.DivisionID = OT3001.DivisionID
						LEFT JOIN AT0099 WITH (NOLOCK) ON CONVERT(VARCHAR, OT3001.OrderStatus) = AT0099.ID AND AT0099.CodeMaster = ''AT00000003''
					WHERE  OT3001.DivisionID = ''' + @DivisionID + ''' '
END
ELSE
BEGIN
    SET @sSQL2 = N' FROM OT3001 WITH (NOLOCK)
						LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT3001.ObjectID
						INNER JOIN OT3003 WITH (NOLOCK) ON OT3003.POrderID = OT3001.POrderID AND OT3003.DivisionID = OT3001.DivisionID
						LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT3001.InventoryTypeID
						INNER JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT3001.CurrencyID
						LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT3001.EmployeeID
						LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT3001.ClassifyID and OT1001.TypeID = ''SO'' AND OT1001.DivisionID = OT3001.DivisionID
						LEFT JOIN OV1001 ON OV1001.OrderStatus = OT3001.OrderStatus AND OV1001.TypeID = ''SO'' AND OV1001.DivisionID = OT3001.DivisionID
						LEFT JOIN OV1002 ON OV1002.OrderType = OT3001.OrderType AND OV1002.TypeID =''SO'' AND OV1002.DivisionID = OT3001.DivisionID
						LEFT JOIN AT0099 WITH (NOLOCK) ON CONVERT(VARCHAR, OT3001.OrderStatus) = AT0099.ID AND AT0099.CodeMaster = ''AT00000003''
					WHERE  OT3001.DivisionID = ''' + @DivisionID + ''' '
END

EXEC (@sSQL1 + ' ' + @sSQL2 + ' ' + @sSQL3)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
