IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV3064]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV3064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP2127
-- <Summary>
---- Đổ nguồn combo kết quả - Tạo script khởi tạo ban đầu cho trường hợp phát sinh thêm cột mới.
---- Created on 20/03/2023 by Văn Tài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- 

CREATE VIEW [dbo].[OV3064]
AS 

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
		case when isnull(OT2001.ObjectName, '') <> '' then OT2001.ObjectName else AT1202.ObjectName end as ObjectName,
		case when isnull(OT2001.VatNo, '') <> '' then OT2001.VATNo else  AT1202.VATNo end as VATNo,
		case when isnull(OT2001.Address, '') <> '' then OT2001.Address else AT1202.Address end as Address,
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
		(Select sum(T90.OriginalAmount) From AT9000 T90 WITH (NOLOCK) Where T90.DivisionID = 'VNA'
														and T90.TransactionTypeID in ('T01', 'T21')
														And T90.TVoucherID = AT9000.VoucherID) as ReceivedOriginalAmount,
		'' AS OrderStatusName2
From OT2001 WITH (NOLOCK) left join OV1001 on OV1001.OrderStatus = OT2001.OrderStatus and OV1001.DivisionID = OT2001.DivisionID and OV1001.TypeID= 'SO'
		left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2001.ObjectID
		left join AT1103 WITH (NOLOCK) on AT1103.FullName = OT2001.EmployeeID
		left join AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
		left join 
		(
			Select DivisionID, VoucherID, VoucherNo, VoucherDate,  OrderID, InvoiceNo, InvoiceDate, CurrencyID, 
				sum(isnull(OriginalAmount, 0)) as OriginalAmount,
				sum(isnull(ConvertedAmount, 0)) as ConvertedAmount
			From AT9000 WITH (NOLOCK) 
			Where  DivisionID = 'VNA' and 
					TransactionTypeID in ('T04', 'T14')
			Group by DivisionID, VoucherID, VoucherNo, VoucherDate, OrderID, InvoiceNo, InvoiceDate, CurrencyID		
		)	AT9000 on AT9000.OrderID = OT2001.SOrderID  and AT9000.DivisionID = OT2001.DivisionID
		LEFT JOIN AT0001 WITH (NOLOCK) ON AT0001.DivisionID = OT2001.DivisionID Where  (Case When  OT2001.TranMonth <10 then '0'+rtrim(ltrim(str(OT2001.TranMonth)))+'/'
										+ltrim(Rtrim(str(OT2001.TranYear))) Else rtrim(ltrim(str(OT2001.TranMonth)))+'/'
										+ltrim(Rtrim(str(OT2001.TranYear))) End) IN ('03/2022','02/2022','01/2022','12/2021','11/2021') AND ( 
											ISNULL(OT2001.EmployeeID, '') IN ('ADMIN','ASOFT','ASOFTADMIN','HCM-AM01','HCM-AM02','HCM-KD01','HCM-KD02','HCM-KD03','HCM-KD04','HCM-KD05','HCM-KD06','HCM-KD07','HCM-KD08','HCM-KD09','HCM-KD10','HCM-KD11','HCM-KT01','HCM-KT02','HCM-KT03','HCM-KT04','HCM-KT05','HCM-KT06','HCM-KT07','HCM-KT08','HCM-KT09','HCM-SEP01','HCM-SEP02','HCM-SEP03','HCM-XNK01','HCM-XNK02','HCM-XNK03','HCM-XNK04','HCM-XNK05','UNASSIGNED' ) 
											OR ISNULL(OT2001.SalesManID, '') IN ('ADMIN','ASOFT','ASOFTADMIN','HCM-AM01','HCM-AM02','HCM-KD01','HCM-KD02','HCM-KD03','HCM-KD04','HCM-KD05','HCM-KD06','HCM-KD07','HCM-KD08','HCM-KD09','HCM-KD10','HCM-KD11','HCM-KT01','HCM-KT02','HCM-KT03','HCM-KT04','HCM-KT05','HCM-KT06','HCM-KT07','HCM-KT08','HCM-KT09','HCM-SEP01','HCM-SEP02','HCM-SEP03','HCM-XNK01','HCM-XNK02','HCM-XNK03','HCM-XNK04','HCM-XNK05','UNASSIGNED' ) 
										)		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
