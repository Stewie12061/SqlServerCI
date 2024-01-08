IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Nguyen Quoc Huy
---- Date 02/03/2009
---- Purpose: Loc ra cac Debit Note len truy van
--22/04/2009, 
-- Last Edit Tuyen,sua  view OV9011 giong view OV911, date: 13/11/2009,16/11/2009
-- Edit: Thuy Tuyen, date 27/11/2009. cai thien toc do.. yeu cau 1 debit not chi ke thua cho mot hoa don
--- Edit:Thuy Tuyen, date 03/03/2009, cai thien toc do tim kiem theo ngay (Master)
--- Edit:Thuy Tuyen, date 08/04/2010, xu ly Isnull cho O03ID
---- Modified on 31/05/2016 by B?o Thy: B? sung WITH (NOLOCK)
---- Modify on 26/04/2017 by B?o Anh: S?a danh m?c dùng chung (b? k?t theo DivisionID)
---- Modified by Kim Thu on 08/05/2019: S?a store load master debit note tr? th?ng d? li?u, không dùng view.
---- Modified by Kim Thu on 26/06/2019: B? sung di?u ki?n gi?, b? join ET2002 d? tránh l?p dòng. B? sung TradeName.
---- Modified by Van Minh on 14/11/2019: B? sung Order By cho Detail theo truong Orders 
---- Modified by Van Minh on 19/12/2019: Tách chu?i tránh tru?ng h?p vu?t quá ký t? cho phép - B? sung thêm di?u ki?n tìm ki?m OT2002
---- Modified by Hu?nh Th? on 24/03/2020: L?y thêm tru?ng InvoiceDate
---- Modified by Huỳnh Thử on 24/03/2020: L?y thêm tru?ng OT2001.Notes,OT2001.CurrencyID3
---- Modified by Huỳnh Thử on 26/05/2020: Sắp xếp Ngày hóa đơn(OrderDate), Số chứng từ (VoucherNo) 
---- Modified by Huỳnh Thử on 16/06/2020: Bỏ Join AT9000 -Select Top 1 để cải thiện tốc độ
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhựt Trường on 17/05/2021: Bổ sung trường OrderStatus, OrderStatusName khi Tra ra thong tin Detail.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

/********************************************
'* Edited by: [GS] [Thành Nguyên] [04/08/2010]
'********************************************/
-- EXEC OP9011 @DivisionID = 'SB', @FromTranMonth=3, @FromTranYear=2019, @ToTranMonth=3, @ToTranYear=2019, @FromDate='2019-05-08', @ToDate='2019-05-08', @IsDate=0,
--				@ObjectID='266741014', @OrderStatus=3, @VoucherTypeID='%', @SOrderID=''

CREATE PROCEDURE [dbo].[OP9011] 
			@DivisionID nvarchar(50),
			@FromTranMonth as int,
			@FromTranYear as int, 
			@ToTranMonth as int,
			@ToTranYear as INT,
			@FromDate AS DATETIME,
			@ToDate AS DATETIME,
			@IsDate TINYINT,
			@ObjectID VARCHAR(50),
			@OrderStatus VARCHAR(50),
			@VoucherTypeID VARCHAR(50),
			@SOrderID VARCHAR(MAX),
			@ConditionVT NVARCHAR(MAX) = '',
			@IsUsedConditionVT NVARCHAR(MAX) = '',
			@Language NVARCHAR(10) = 'vi-VN'
				
 AS
Declare @sSQL nvarchar(MAX)='', @sSQL1 nvarchar(MAX)='', @sSQL2 nvarchar(MAX)='', @sSQLWHERE nvarchar(MAX)='', 
		@sSQLFROM nvarchar(MAX) = '', @sSQLConditionFilter nvarchar(MAX) = '', @sSQLGroupBY nvarchar(MAX) = '', @sSQL2_2 nvarchar(MAX) = ''
	
IF @IsDate=0
	SET @sSQLWHERE= 'And OT2001.TranMonth+100*OT2001.TranYear between '+ str(@FromTranMonth)+'+100*'+str(@FromTranYear)+'  and  '+str(@ToTranMonth)+' + 100*'+str(@ToTranYear)
ELSE
	SET @sSQLWHERE= 'And OT2001.OrderDate between '''+ convert(VARCHAR(10),@FromDate,121)+' 00:00:00'' AND '''+ convert(VARCHAR(10),@ToDate,121)+' 23:59:59'' '

----- Buoc  1 .1: Tra ra thong tin Master View OV9111 ( De load truy van)
  -- tao view lay so tien, so haon don  da lap hoa don, 
IF ISNULL(@SOrderID,'')=''
BEGIN
	SET @sSQL = 
	'
	Select 
		DivisionID,
		Sum( isnull (OriginalAmount,0)) as  VATInvoiceAmount, OrderID, invoiceNo, InvoiceDate
	INTO #OP9011A
	From AT9000 WITH (NOLOCK)
	WHERE DivisionID IN (''@@@'','''+@DivisionID+''')
	AND TransactionTypeID IN (''T04'',''T14'')
	Group by DivisionID,  OrderID, InvoiceNo, InvoiceDate
	Order by OrderID'

	Set @sSQL1 =' 
	Select  
			OT2001.DivisionID,
			OT2001.SOrderID, 
			OT2001.VoucherTypeID, 
			OT2001.VoucherNo, 
			OT2001.TranMonth,
			OT2001.TranYear,
			isnull(OT2001.OrderDate,'''') as OrderDate, 	 
			OT2001.ObjectID,  
			isnull(OT2001.ObjectName, AT1202.ObjectName)   as ObjectName, 
			isnull(OT2001.VatNo, AT1202.VatNo)  as VatNo, 
			isnull( OT2001.Address, AT1202.Address)  as Address,
			OT2001.ClassifyID,
			(Select Sum(isnull(ConvertedAmount,0)- isnull(DiscountConvertedAmount,0)- isnull(CommissionCAmount,0) +
			isnull(VATConvertedAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID) AS ConvertedAmount,
			(Select Sum(isnull(OriginalAmount,0)- isnull(DiscountOriginalAmount,0) - isnull(CommissionOAmount, 0) +
			isnull(VAToriginalAmount, 0)) From OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID) AS OriginalAmount, 
			OT2001.OrderStatus, 
			CASE WHEN OT2001.OrderType <> 1 THEN CASE WHEN '''+@Language+''' = ''vi-VN'' THEN OV1001.Description ELSE OV1001.EDescription END ELSE CASE WHEN '''+@Language+''' = ''vi-VN'' THEN OV1001_2.Description ELSE OV1001_2.EDescription END END as OrderStatusName, 
			AT1202.VatNo,
			AT1202.Address,
			QuotationID,
			OT2001.OrderType,  
			OV1002.Description as OrderTypeName,
			Ana01ID, 
			Ana02ID, 
			OT1002_1.AnaName as Ana01Name, 
			OT1002_2.AnaName as Ana02Name, 
			AT1202.O03ID, 
			ShipDate, 
	'
	set @sSQL2 =
	N'		OT2001.DueDate, 
			OT2001.PaymentTermID,
			OT2001.contact,
			OT2001.VATObjectID,
			 isnull(OT2001.VATObjectName,T02.ObjectName) as  VATObjectName,
			OT2001.IsInherit,  AT1202.Tel,  AT1202.Contactor, AT1202.Email,
			OV9011a.invoiceNo as VATInvoiceNo,
			OV9011a.InvoiceDate,
			OV9011a. VATInvoiceAmount,
			AT1202.O02ID, ISNULL(AT1202.O03ID,'''') AS O03ID , 
			ISNULL(AT1202.O03ID,'''')  O03Name , AT1202.TradeName,
			OT2001.Notes,
			OT2001.CurrencyID
	From OT2001  WITH (NOLOCK)
			left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
			left join AT1202 T02 WITH (NOLOCK) on T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
			left join OT1101 OV1001 WITH (NOLOCK)  on OV1001.DivisionID IN (OT2001.DivisionID,''@@@'') AND OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = ''SO''
			left join OT1101 OV1001_2 WITH (NOLOCK)  on OV1001_2.DivisionID IN (OT2001.DivisionID,''@@@'') AND OV1001_2.OrderStatus = OT2001.OrderStatus AND OV1001_2.TypeID = ''MO''
			left join OV1002 WITH (NOLOCK) on OV1002.OrderType = OT2001.OrderType and OV1002.TypeID =''SO''
			left join OT1002 OT1002_1 WITH (NOLOCK) on OT1002_1.AnaID = OT2001.Ana01ID and OT1002_1.AnaTypeID = ''S01''
			left join OT1002 OT1002_2 WITH (NOLOCK) on OT1002_2.AnaID = OT2001.Ana02ID and OT1002_2.AnaTypeID = ''S02''
			Left Join #OP9011A OV9011a WITH (NOLOCK) on OV9011a.DivisionID = OT2001.DivisionID AND OV9011a.OrderID = OT2001.SOrderID	
	Where  OT2001.DivisionID = N''' + @DivisionID + ''' 
			' + @sSQLWHERE + '
			AND OT2001.ObjectID LIKE '''+@ObjectID+'''
			AND OT2001.OrderStatus LIKE '''+@OrderStatus+'''
			AND OT2001.VoucherTypeID LIKE '''+@VoucherTypeID+'''
			AND	(Isnull(OT2001.VoucherTypeID,''#'')  in ' + @ConditionVT + ' OR ' + @IsUsedConditionVT + ')
	'
SET @sSQL2_2 = '
	GROUP BY OT2001.DivisionID,
			OT2001.SOrderID, 
			OT2001.VoucherTypeID, 
			OT2001.VoucherNo, 
			OT2001.OrderDate,
			OT2001.TranMonth,
			OT2001.TranYear, 	 
			OT2001.ObjectID,  
			OT2001.ObjectName, AT1202.ObjectName, 
			OT2001.VatNo, AT1202.VatNo, 
			OT2001.Address, AT1202.Address,
			OT2001.ClassifyID, 			  
			OT2001.OrderStatus, 
			OV1001.Description,OV1001.EDescription, OV1001_2.Description ,OV1001_2.EDescription, 
			AT1202.VatNo,
			AT1202.Address,
			QuotationID,
			OT2001.OrderType,  
			OV1002.Description,
			Ana01ID, 
			Ana02ID, 
			OT1002_1.AnaName, 
			OT1002_2.AnaName, 
			AT1202.O03ID, 
			ShipDate,OT2001.DueDate, 
			OT2001.PaymentTermID,
			OT2001.contact,
			OT2001.VATObjectID,
			OT2001.VATObjectName,T02.ObjectName,
			OT2001.IsInherit,  AT1202.Tel,  AT1202.Contactor, AT1202.Email,
			OV9011a.invoiceNo,
			OV9011a.InvoiceDate,
			OV9011a. VATInvoiceAmount,
			AT1202.O02ID, AT1202.O03ID, 
			AT1202.O03ID , AT1202.TradeName, 
			OT2001.Notes,
			OT2001.CurrencyID
		ORDER BY OrderDate, VoucherNo
			'

END
ELSE
BEGIN
---- Buoc  2 : Tra ra thong tin Detail View OV9012
Set @sSQL1= '
Select 	OT2002.DivisionID,
		OT2002.SOrderID, 
		OrderDate,   
		OT2001.InventoryTypeID, 
		IsStocked,
		OT2001.ClassifyID,
		OT2001.CurrencyID,
		OT2002.InventoryID, 
		case when isnull(OT2002.InventoryCommonName, '''') = '''' then AT1302.InventoryName else OT2002.InventoryCommonName end as 	InventoryName, 		 
		OT2002.OrderQuantity, 
		SalePrice, 
		OT2001.CurrencyID,
		OT2001.ObjectID,
		T04.ObjectName,
		OT2001.Ana02ID,
		T04.Email,
		T05.AnaName,
		OT2002.ConvertedAmount, 
		OT2002.OriginalAmount, 
		OT2002.VATConvertedAmount, 
		OT2002.VATOriginalAmount,
		OT2001.OrderStatus, 
		CASE WHEN OT2001.OrderType <> 1 THEN CASE WHEN '''+@Language+''' = ''vi-VN'' THEN OV1001.Description ELSE OV1001.EDescription END ELSE CASE WHEN '''+@Language+''' = ''vi-VN'' THEN OV1001_2.Description ELSE OV1001_2.EDescription END END as OrderStatusName,
		OT2002.VATPercent,   
		OT2001.ExchangeRate,
		OT2002.AdjustQuantity, 
		Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
		Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
		Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
		Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,
		Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
		Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,		
'
set @sSQL2 = 
N'		OT2002.Date01, OT2002.Date02, OT2002.Date03, OT2002.Date04, OT2002.Date05, 
		OT2002.LinkNo, 
		OT2002.EndDate, 
		OT2002.Orders, 
		OT2002.Description, 
		OT2002.RefInfor,
		OT2002.Notes01, OT2002.Notes02,OT2002.Notes03,OT2002.Notes04,
		OT2001.Ana01ID, 
		OT2001.Ana02ID, 
		T02.AnaName as AnaName02,
		OT2002.Ana03ID,
		T03.AnaName as AnaName03,
		OT2002.Ana04ID, 
		OT2001.VoucherNo,
		OT2002.Ana05ID,
		OT2002.Finish,
		OT2002.ObjectID01, OT2002.RefName01, OT2002.ObjectName01, OT2002.ObjectAddress01, OT2002.ObjectCity01, OT2002.ObjectState01, OT2002.ObjectCntry01, OT2002.ObjectZip01, 
		OT2002.ObjectID02, OT2002.RefName02, OT2002.ObjectName02, OT2002.ObjectAddress02, OT2002.ObjectCity02, OT2002.ObjectState02, OT2002.ObjectCntry02, OT2002.ObjectZip02, 
		OT2002.VATGroupID,
		OT2002.SourceNo,
		OT2002.Cal01,OT2002.cal02,OT2002.Cal03,OT2002.Cal04,OT2002.Cal05,OT2002.Aut, OT2002.Cut,
		OT2002.OrigLocn, OT2002.DestLocn, OT2002.SvType, OT2002.SvAbbrew, 
		OT2002.SurDesc1, OT2002.SurDesc2, OT2002.SurDesc3, OT2002.SurDesc4, 
		OT2002.SurDesc5, OT2002.SurDesc6, OT2002.SurDesc7, OT2002.SurDesc8
		, (select top 1 InvoiceNo from AT9000 with (Nolock) where  OrderID = OT2001.SOrderID and AT9000.DivisionID = OT2001.DivisionID) AS VATInvoiceNo
		, (select top 1 CONVERT(NVARCHAR(50), InvoiceDate,103) from AT9000 with (Nolock) where  OrderID = OT2001.SOrderID and AT9000.DivisionID = OT2001.DivisionID) AS InvoiceDate
		
		'

		--- B? sung thêm di?u ki?n khi l?c ---
		SET @sSQLConditionFilter = 'OT2001.SOrderID = ('+@SOrderID+')'
		IF CHARINDEX(',',@SOrderID) > 0
		BEGIN
			SET @sSQLConditionFilter = 'OT2001.SOrderID IN ('+@SOrderID+')'
		END

SET @sSQLFROM = '
				From OT2002 WITH (NOLOCK) 
				left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
				inner join OT2001 WITH (NOLOCK) on OT2001.SOrderID = OT2002.SOrderID
				left join OT1101 OV1001 WITH (NOLOCK)  on OV1001.DivisionID IN (OT2001.DivisionID,''@@@'') AND OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = ''SO''
				left join OT1101 OV1001_2 WITH (NOLOCK)  on OV1001_2.DivisionID IN (OT2001.DivisionID,''@@@'') AND OV1001_2.OrderStatus = OT2001.OrderStatus AND OV1001_2.TypeID = ''MO''	
				Left Join AT1011 T02 WITH (NOLOCK) on T02.AnaID = OT2002.Ana02ID
				Left Join AT1011 T03 WITH (NOLOCK) on T03.AnaID = OT2002.Ana03ID 
				LEFT JOIN AT1202 T04 WITH (NOLOCK) on T04.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T04.ObjectID = OT2001.ObjectID
				LEFT JOIN OT1002 T05 WITH (NOLOCK) on T05.AnaID = OT2001.Ana01ID
				WHERE OT2002.DivisionID IN (''@@@'','''+@DivisionID+''')
				AND ' + @sSQLConditionFilter + '	
				'
SET @sSQLGroupBY = '
	GROUP BY OT2002.DivisionID,
		OT2002.SOrderID, 
		OrderDate,   
		OT2001.ClassifyID,
		OT2001.CurrencyID,
		OT2001.InventoryTypeID, 
		IsStocked,
		OT2002.InventoryID, 
		AT1302.InventoryName ,OT2002.InventoryCommonName , 		 
		OT2002.OrderQuantity, 
		SalePrice, 
		OT2001.Ana02ID,
		OT2002.Notes01, OT2002.Notes02,OT2002.Notes03,OT2002.Notes04,
		OT2001.ObjectID,
		T04.ObjectName,
		OT2001.VoucherNo,
		T04.Email,
		OT2002.ConvertedAmount, 
		OT2002.OriginalAmount, 
		T05.AnaName,
		OT2002.VATConvertedAmount, 
		OT2002.VATOriginalAmount, 
		OT2002.VATPercent,   
		OT2001.ExchangeRate,
		OT2002.AdjustQuantity, 
		Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
		Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
		Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
		Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,
		Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
		Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,
		OT2002.Date01, OT2002.Date02, OT2002.Date03, OT2002.Date04, OT2002.Date05, 
		OT2002.LinkNo, 	OT2002.EndDate, OT2002.Orders, 	OT2002.Description, 
		OT2002.RefInfor,
		OT2001.Ana01ID, 
		OT2001.Ana02ID, 
		T02.AnaName,
		OT2002.Ana03ID,
		T03.AnaName,
		OT2002.Ana04ID, 
		OT2002.Ana05ID,
		OT2001.OrderStatus, 
		OT2001.OrderType,
		OV1001.Description,OV1001.EDescription, OV1001_2.Description ,OV1001_2.EDescription,
		OT2002.Finish,
		OT2002.ObjectID01, OT2002.RefName01, OT2002.ObjectName01, OT2002.ObjectAddress01, OT2002.ObjectCity01, OT2002.ObjectState01, OT2002.ObjectCntry01, OT2002.ObjectZip01, 
		OT2002.ObjectID02, OT2002.RefName02, OT2002.ObjectName02, OT2002.ObjectAddress02, OT2002.ObjectCity02, OT2002.ObjectState02, OT2002.ObjectCntry02, OT2002.ObjectZip02, 
		OT2002.VATGroupID,
		OT2002.SourceNo,
		OT2002.Cal01,OT2002.cal02,OT2002.Cal03,OT2002.Cal04,OT2002.Cal05,OT2002.Aut, OT2002.Cut,
		OT2002.OrigLocn, OT2002.DestLocn, OT2002.SvType, OT2002.SvAbbrew, 
		OT2002.SurDesc1, OT2002.SurDesc2, OT2002.SurDesc3, OT2002.SurDesc4, 
		OT2002.SurDesc5, OT2002.SurDesc6, OT2002.SurDesc7, OT2002.SurDesc8,
		OT2001.SOrderID,OT2001.DivisionID
	
		ORDER BY OT2002.Orders ASC'

END

--print @sSQL
--print @sSQL1
--print @sSQL2
--print @sSQL2_2
--print @sSQLFROM
--PRINT @sSQLGroupBY

EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL2_2 + @sSQLFROM + @sSQLGroupBY)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
