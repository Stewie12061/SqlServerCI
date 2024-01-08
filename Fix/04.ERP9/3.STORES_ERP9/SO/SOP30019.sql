IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Created by: Trọng Kiên, date:  02/12/2020
---Purpose: In báo cáo tổng hợp tình hình thanh toán

---Modified by: Văn Tài	, date:  10/02/2022: Sửa cách tính thông tin chênh lệch.
---Modified by: Văn Tài , date: 08/04/2022: Bổ sung phân quyền xem đơn hàng VNA.
---Modified by: Anh Đô  , date: 20/10/2022: Chỉnh sửa điều kiện lọc
---Modified by: Anh Đô  , date: 13/01/2023: Select thêm thêm Tình trạng đơn hàng
---LƯU Ý: KHI CHỈNH SỬA PHẦN NÀY TRÊN ERP9 THÌ PHẢI SỬA STORED OP3064
-- EXEC SOP30019 'MK',0,2,2016,2,2016,'2016-02-01','2016-02-14','vd05','vd05',0

CREATE PROCEDURE [dbo].[SOP30019] 
				@DivisionID nvarchar(50),
				@DivisionIDList NVARCHAR(MAX),
				@IsDate tinyint,
				@PeriodIDList nvarchar(2000),
				@FromDate datetime,
				@ToDate datetime,
				@ObjectID NVARCHAR(MAX),
				@OrderStatus nvarchar(50),	
				@ConditionSOrderID  NVARCHAR (MAX) = '', -- Phân quyền xem phiếu báo giá.	
				@FromObjectID nvarchar(50) = '',
				@ToObjectID nvarchar(50) = ''
AS

DECLARE @sSQL nvarchar(MAX)='',
		@sSQL1 nvarchar(MAX)='',
		@sWhere NVARCHAR(max)='',
		@sSELECT nvarchar(max),
		@sGROUPBY nvarchar(max),
		@sSQL2 nvarchar(max),
		@sSQL3 nvarchar(MAX)='',
		@ToGiveUpDate NVARCHAR(20),
		@AmountOrder INT

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = ' OT2001.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = ' OT2001.DivisionID = N'''+@DivisionID+''''	

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN

		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,OT2001.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

	END
	ELSE
	BEGIN
		IF (ISNULL(@PeriodIDList, '')) != ''
		SET @sWhere = @sWhere + ' AND (Case When  OT2001.TranMonth <10 then ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''
										+ltrim(Rtrim(str(OT2001.TranYear))) Else rtrim(ltrim(str(OT2001.TranMonth)))+''/''
										+ltrim(Rtrim(str(OT2001.TranYear))) End) IN ('''+@PeriodIDList+''')'
	END
	
	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(OT2001.ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(OT2001.ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(OT2001.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''
	ELSE IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND IsNull(OT2001.ObjectID, '''') IN ((SELECT Value FROM [dbo].StringSplit('''+ @ObjectID +''', '','')))'

	--Search theo trạng thái
	IF ISNULL(@OrderStatus, '') != ''
		SET @sWhere = @sWhere + 'AND IsNull(OT2001.OrderStatus, '''') IN ('''+ @OrderStatus +''')' 

	IF @CustomerName = 147 -- Customize cho VNA
	BEGIN

		IF Isnull(@ConditionSOrderID,'')!=''
			SET @sWhere = @sWhere + ' AND ( 
											ISNULL(OT2001.EmployeeID, '''') IN ('''+@ConditionSOrderID+''' ) 
											OR ISNULL(OT2001.SalesManID, '''') IN ('''+@ConditionSOrderID+''' ) 
										)		'
	END

Set @sSQL = '
Select 	AT0001.CompanyName AS DivisionName,
        OT2001.DivisionID,
		OT2001.SOrderID, 
		OT2001.VoucherTypeID, 
		OT2001.VoucherNo as OrderNo, 
		OT2001.OrderDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate, 
		OT2001.ClassifyID, 
		OT2001.OrderType, 
		OT2001.ObjectID, 
		OT2001.DeliveryAddress, 
		OT2001.Notes, 		
		OT2001.OrderStatus, 
		OT2001.QuotationID, 
		OT2001.CurrencyID, 
		OT2001.ExchangeRate, 
		OT2001.EmployeeID, 
		AT1103.FullName,
		OT2001.Transport, 
		OT2001.PaymentID, 
		case when isnull(OT2001.ObjectName, '''') <> '''' then OT2001.ObjectName else AT1202.ObjectName end as ObjectName,
		case when isnull(OT2001.VatNo, '''') <> '''' then OT2001.VATNo else  AT1202.VATNo end as VATNo,
		case when isnull(OT2001.Address, '''') <> '''' then OT2001.Address else AT1202.Address end as Address,
		AT1202.Tel,
		AT1202.Fax,
		AT1202.Email,
		OT2001.IsPeriod, 
		OT2001.IsPlan, 
		OT2001.DepartmentID, 
		OT2001.SalesManID, 
		AT1103_2.FullName as SalesManName,
		OT2001.ShipDate, 
		OT2001.InheritSOrderID, 
		OT2001.DueDate, 
		OT2001.PaymentTermID, 
		OV1001.Description as OrderStatusName,
		OV1001.EDescription as EOrderStatusName,
		OriginalAmount = (Select sum(isnull(OriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		ConvertedAmount = (Select sum(isnull(ConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		VATOriginalAmount = (Select sum(isnull(VATOriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		VATConvertedAmount = (Select sum(isnull(VATConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		DiscountOriginalAmount = (Select sum(isnull(DiscountOriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		DiscountConvertedAmount = (Select sum(isnull(DiscountConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		CommissionCAmount = (Select sum(isnull(CommissionCAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		CommissionOAmount = (Select sum(isnull(CommissionOAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		AT9000.VoucherNo ,
		AT9000.VoucherDate,
		AT9000.InvoiceNo,
		AT9000.InvoiceDate,
		AT9000.CurrencyID as InvoiceCurrencyID,
		AT9000.OriginalAmount as InvoiceOriginalAmount,
		AT9000.ConvertedAmount as InvoiceConvertedAmount,
		A9.Description AS OrderStatusName2,
		'

IF @CustomerName = 36 --- AP SG Petrol
    Set @sSQL = @sSQL + '(Select sum(T90.OriginalAmount)
						From AT9000 T90 WITH (NOLOCK)
						INNER JOIN AT9000 HD WITH (NOLOCK) ON T90.DivisionID = HD.DivisionID AND T90.TVoucherID = HD.VoucherID AND HD.TransactionTypeID = ''T04'' 
						INNER JOIN AT2007 T07 WITH (NOLOCK) ON HD.DivisionID = T07.DivisionID AND HD.WOrderID = T07.VoucherID AND HD.WTransactionID = T07.TransactionID and T07.OrderID = OT2001.SOrderID
						Where T90.DivisionID = ''' + @DivisionID + '''
						and T90.TransactionTypeID in (''T01'', ''T21'')						
								) as ReceivedOriginalAmount'								
ELSE IF @CustomerName = 45 --- Karaben
	Set @sSQL = @sSQL + '(Select sum(OriginalAmount)
						From AT0303 WITH (NOLOCK)
						Where DivisionID = ''' + @DivisionID + ''' and DebitVoucherID = T90.VoucherID And CONVERT(NVARCHAR(20), GiveUpDate, 101) <= ''' + @ToGiveUpdate + '''
						) as ReceivedOriginalAmount'
ELSE
	Set @sSQL = @sSQL + '
		(Select sum(T90.OriginalAmount) From AT9000 T90 WITH (NOLOCK) Where T90.DivisionID = ''' + @DivisionID + '''
														and T90.TransactionTypeID in (''T01'', ''T21'')
														And T90.TVoucherID = AT9000.VoucherID) as ReceivedOriginalAmount'
														
IF @CustomerName IN (36,45) --- AP SG Petrol, Karaben
    Set @sSQL = @sSQL + ', T90.VoucherNo as PVoucherNo,
		T90.VoucherDate as PVoucherDate,
		T90.InvoiceNo as PInvoiceNo,
		T90.InvoiceDate as PInvoiceDate,
		T90.CurrencyID as PInvoiceCurrencyID,
		T90.OriginalAmount as PInvoiceOriginalAmount,
		T90.ConvertedAmount as PInvoiceConvertedAmount,
		T90.DueDate as InvoiceDueDate'

Set @sSQL1 = '														
From OT2001 WITH (NOLOCK) left join OV1001 on OV1001.OrderStatus = OT2001.OrderStatus and OV1001.DivisionID = OT2001.DivisionID and OV1001.TypeID= ''SO''
		left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2001.ObjectID
		left join AT1103 WITH (NOLOCK) on AT1103.FullName = OT2001.EmployeeID
		left join AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
		left join 
		(
			Select DivisionID, VoucherID, VoucherNo, VoucherDate,  OrderID, InvoiceNo, InvoiceDate, CurrencyID, 
				sum(isnull(OriginalAmount, 0)) as OriginalAmount,
				sum(isnull(ConvertedAmount, 0)) as ConvertedAmount
			From AT9000 WITH (NOLOCK) 
			Where  DivisionID = ''' + @DivisionID + ''' and 
					TransactionTypeID in (''T04'', ''T14'')
			Group by DivisionID, VoucherID, VoucherNo, VoucherDate, OrderID, InvoiceNo, InvoiceDate, CurrencyID		
		)	AT9000 on AT9000.OrderID = OT2001.SOrderID  and AT9000.DivisionID = OT2001.DivisionID
		LEFT JOIN AT0001 WITH (NOLOCK) ON AT0001.DivisionID = OT2001.DivisionID
		LEFT JOIN AT0099 A9 WITH (NOLOCK) ON A9.ID = OT2001.OrderStatus AND A9.CodeMaster = ''AT00000003'' AND ISNULL(A9.Disabled, 0) = 0
		'
		
IF @CustomerName IN (36,45) --- AP SG Petrol, Karaben
    BEGIN
	    Set @sSQL1 = @sSQL1 + '
		LEFT JOIN
		(
			Select AT2007.DivisionID, AT2007.VoucherID, AT2007.OrderID,
					sum(isnull(AT2007.OriginalAmount, 0)) as OriginalAmount,
					sum(isnull(AT2007.ConvertedAmount, 0)) as ConvertedAmount
			From AT2007 WITH (NOLOCK) Inner join AT2006 WITH (NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID
			Where AT2007.DivisionID = ''' + @DivisionID + ''' and AT2006.KindVoucherID = 2 And Isnull(AT2007.OrderID,'''') <> ''''
			Group by AT2007.DivisionID, AT2007.VoucherID, AT2007.OrderID
		) AT2007 on OT2001.DivisionID = AT2007.DivisionID And OT2001.SOrderID = AT2007.OrderID                  
	
		LEFT JOIN
		(
			Select DivisionID, VoucherID, VoucherNo, VoucherDate, DueDate, WOrderID, InvoiceNo, InvoiceDate, CurrencyID,
					sum(isnull(OriginalAmount, 0)) as OriginalAmount,
					sum(isnull(ConvertedAmount, 0)) as ConvertedAmount
			From AT9000 WITH (NOLOCK)
			Where DivisionID = ''' + @DivisionID + ''' and 
						TransactionTypeID in (''T04'', ''T14'')
			Group by DivisionID, VoucherID, VoucherNo, VoucherDate, DueDate, WOrderID, InvoiceNo, InvoiceDate, CurrencyID
		) T90 on AT2007.DivisionID = T90.DivisionID And AT2007.VoucherID = T90.WOrderID  	
		'
	END

Set @sSQL3 = ' Where ' + @sWhere

IF exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV3064')
	DROP VIEW OV3064

EXEC('Create view OV3064 --tao boi SOP30019 
		as ' + @sSQL + @sSQL1 + @sSQL3)
print @sSQL
print @sSQL1
print @sSQL3		
SELECT ROW_NUMBER() OVER (ORDER BY OrderNo) AS RowNum, DivisionID, SOrderID, VoucherTypeID, OrderNo, OrderDate, ContractNo, ContractDate, ClassifyID,
       OrderType, ObjectID, DeliveryAddress, Notes, OrderStatus, QuotationID, CurrencyID, ExchangeRate,
	   EmployeeID, FullName, Transport, PaymentID, ObjectName, VATNo, Address, Tel, Fax, Email, IsPeriod,
	   IsPlan, DepartmentID, SalesManID, SalesManName, ShipDate, InheritSOrderID, DueDate, PaymentTermID,
	   OrderStatusName, EOrderStatusName, OriginalAmount, ConvertedAmount, VATOriginalAmount, VATConvertedAmount,
	   DiscountOriginalAmount, DiscountConvertedAmount, CommissionCAmount, CommissionOAmount, VoucherNo, VoucherDate,
	   InvoiceNo, InvoiceDate, InvoiceCurrencyID, InvoiceOriginalAmount, InvoiceConvertedAmount, ReceivedOriginalAmount,
	   (ConvertedAmount + VATConvertedAmount - DiscountConvertedAmount - CommissionCAmount) AS SumConvertedAmount,
	   (CASE WHEN InvoiceConvertedAmount IS NULL THEN (ConvertedAmount + VATConvertedAmount - DiscountConvertedAmount - CommissionCAmount)
	         ELSE (ConvertedAmount + VATConvertedAmount - DiscountConvertedAmount - CommissionCAmount) - ISNULL(ReceivedOriginalAmount, 0) END) AS DifferenceAmount
			 , OrderStatusName2
INTO #TempSOP30019
FROM OV3064 
GROUP BY DivisionID, SOrderID, VoucherTypeID, OrderNo, OrderDate, ContractNo, ContractDate, ClassifyID,
         OrderType, ObjectID, DeliveryAddress, Notes, OrderStatus, QuotationID, CurrencyID, ExchangeRate,
		 EmployeeID, FullName, Transport, PaymentID, ObjectName, VATNo, Address, Tel, Fax, Email, IsPeriod,
		 IsPlan, DepartmentID, SalesManID, SalesManName, ShipDate, InheritSOrderID, DueDate, PaymentTermID,
		 OrderStatusName, EOrderStatusName, OriginalAmount, ConvertedAmount, VATOriginalAmount, VATConvertedAmount,
		 DiscountOriginalAmount, DiscountConvertedAmount, CommissionCAmount, CommissionOAmount, VoucherNo, VoucherDate,
		 InvoiceNo, InvoiceDate, InvoiceCurrencyID, InvoiceOriginalAmount, InvoiceConvertedAmount, ReceivedOriginalAmount, OrderStatusName2

SELECT * FROM #TempSOP30019
SELECT SUM(SumConvertedAmount) AS TotalSumConvertedAmount, SUM (DifferenceAmount) AS TotalDifferenceAmount FROM #TempSOP30019

--Phan Tuyen them vao in bao cao chi tiet tinh hinh thanh toan
Set @sSQL = '
Select 	OT2001.DivisionID,	
		OT2001.SOrderID, 
		OT2001.VoucherNo as OrderNo, 
		OT2001.OrderDate, 
		OT2001.ObjectID, 
		AT1202.ObjectName,
		OT2001.CurrencyID, 
		OT2001.ExchangeRate, 
		OriginalAmount = (Select sum(isnull(OriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		ConvertedAmount = (Select sum(isnull(ConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		VATOriginalAmount = (Select sum(isnull(VATOriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		VATConvertedAmount = (Select sum(isnull(VATConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		DiscountOriginalAmount = (Select sum(isnull(DiscountOriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		DiscountConvertedAmount = (Select sum(isnull(DiscountConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		CommissionCAmount = (Select sum(isnull(CommissionCAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		CommissionOAmount = (Select sum(isnull(CommissionOAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID),
		T90.VoucherNo ,
		T90.VoucherDate,
		T90.InvoiceNo,
		T90.InvoiceDate,
		T90.CurrencyID as InvoiceCurrencyID,
		T90.InventoryID,
		AT1302.InventoryName,
		T90.Quantity as ActualQuantity  ,
		T90.OriginalAmount as InvoiceOriginalAmount,
		T90.ConvertedAmount as InvoiceConvertedAmount,
		VATCoAmount =
		(
			(
				Select isnull(Sum(AT9000.ConvertedAmount),0) 
				From AT9000  WITH (NOLOCK)
				Where AT9000.InventoryID = T90.InventoryID and 
					AT9000.OrderID =T90.OrderID and 
					AT9000.VoucherNO = T90.VoucherNO 
					and AT9000.DivisionID = T90.DivisionID 
			)
			* 
			(
				Select isnull(VATRate,0) 
				From at1010 WITH (NOLOCK) 
				Where VATGroupID In 
				(	
					Select Top 1 VATGroupID 
					From AT9000  WITH (NOLOCK)
					Where AT9000.InventoryID = T90.InventoryID and 
						AT9000.OrderID =T90.OrderID and 
						AT9000.VoucherNO = T90.VoucherNO and 
						TransactiontypeID = ''T04''
						and AT9000.DivisionID = T90.DivisionID 
				)
			)/100
		),		
		PayOriginalAmount = (Select Isnull(Sum(OriginalAmount),0) From AT9000 WITH (NOLOCK) Where  CreditAccountID = AT1202.ReAccountID and  AT9000.OrderID = T90.OrderID and  AT9000.DivisionID = T90.DivisionID),
		PayCovertedAmount = (Select Isnull(Sum(ConvertedAmount),0) From AT9000 WITH (NOLOCK) Where CreditAccountID = AT1202.ReAccountID and  AT9000.OrderID = T90.OrderID and  AT9000.DivisionID = T90.DivisionID)
'
SET @sSQL2 = '
From OT2001 WITH (NOLOCK) left join OV1001 on OV1001.OrderStatus = OT2001.OrderStatus and OV1001.DivisionID = OT2001.DivisionID  and OV1001.TypeID= ''SO''
	left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2001.ObjectID
	left join AT1103 WITH (NOLOCK) on AT1103.FullName = OT2001.EmployeeID 
	left join AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	left join AT9000 T90 WITH (NOLOCK)  on T90.OrderID = OT2001.SOrderID  and T90.DivisionID = OT2001.DivisionID
	Left Join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', T90.DivisionID) AND AT1302.InventoryID = T90.InventoryID
			
Where '+ @sWhere+' AND OT2001.DivisionID like ''' + @DivisionID + ''' and 
	T90.InventoryID is not null and
	T90.OriginalAmount is not null '

IF exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV3065')
	DROP VIEW OV3065

EXEC('Create view OV3065 --tao boi SOP30019
		as ' + @sSQL + @sSQL2)
IF @CustomerName = 20 --- Sinolife
BEGIN
	Declare @ContractAnaTypeID nvarchar(50),
			@sTime as nvarchar(max)
	
	SET @ContractAnaTypeID = ISNULL((SELECT TOP 1 SalesContractAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID), 'A03')
	
	

	Set @sSQL = 'SELECT OT2001.ObjectID, AT1202.ObjectName,
						(CASE WHEN ''' + @ContractAnaTypeID + ''' = ''A01'' THEN OT2002.Ana01ID
						WHEN ''' + @ContractAnaTypeID + ''' = ''A02'' THEN OT2002.Ana02ID
						WHEN ''' + @ContractAnaTypeID + ''' = ''A03'' THEN OT2002.Ana03ID
						WHEN ''' + @ContractAnaTypeID + ''' = ''A04'' THEN OT2002.Ana04ID
						WHEN ''' + @ContractAnaTypeID + ''' = ''A05'' THEN OT2002.Ana05ID END) as ContractNo,
						OT2002.InventoryID, AT1020.Amount as ContractAmount,
						
						(Select sum(AT9000.ConvertedAmount) From AT9000 WITH (NOLOCK) Inner join AT1021 WITH (NOLOCK) On AT9000.DivisionID = AT1021.DivisionID And AT9000.ContractDetailID = AT1021.ContractDetailID
						Where AT9000.DivisionID = ''' + @DivisionID + ''' And AT1021.ContractID = AT1020.ContractID) as PaymentAmount,
						
						(Select sum(PaymentAmount) From AT1021 WITH (NOLOCK) Where AT1021.DivisionID = ''' + @DivisionID + ''' And AT1021.ContractID = AT1020.ContractID' + @sTime + '
						AND Isnull(AT1021.PaymentStatus,0) = 0) as InPaymentAmount
						 
						
				FROM OT2001 WITH (NOLOCK)
				INNER JOIN OT2002 WITH (NOLOCK) On OT2001.DivisionID = OT2002.DivisionID And OT2001.SOrderID = OT2002.SOrderID
				LEFT JOIN AT1202 WITH (NOLOCK) On OT2001.ObjectID = AT1202.ObjectID
				'
	
	IF @ContractAnaTypeID = 'A01'			
			Set @sSQL =	@sSQL +	'INNER JOIN AT1020 WITH (NOLOCK) On OT2002.DivisionID = AT1020.DivisionID And OT2002.Ana01ID = AT1020.ContractNo'
	IF @ContractAnaTypeID = 'A02'			
			Set @sSQL =	@sSQL +	'INNER JOIN AT1020 WITH (NOLOCK) On OT2002.DivisionID = AT1020.DivisionID And OT2002.Ana02ID = AT1020.ContractNo'
	IF @ContractAnaTypeID = 'A03'			
			Set @sSQL =	@sSQL +	'INNER JOIN AT1020 WITH (NOLOCK) On OT2002.DivisionID = AT1020.DivisionID And OT2002.Ana03ID = AT1020.ContractNo'
	IF @ContractAnaTypeID = 'A04'			
			Set @sSQL =	@sSQL +	'INNER JOIN AT1020 WITH (NOLOCK) On OT2002.DivisionID = AT1020.DivisionID And OT2002.Ana04ID = AT1020.ContractNo'
	IF @ContractAnaTypeID = 'A05'			
			Set @sSQL =	@sSQL +	'INNER JOIN AT1020 WITH (NOLOCK) On OT2002.DivisionID = AT1020.DivisionID And OT2002.Ana05ID = AT1020.ContractNo'
			
	Set @sSQL =	@sSQL +	' WHERE '+ @sWhere+ 'OT2001.DivisionID like ''' + @DivisionID + ''''

	EXEC(@sSQL)
	print @sSQL
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
