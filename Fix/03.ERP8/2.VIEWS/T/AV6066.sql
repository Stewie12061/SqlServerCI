IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV6066]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV6066]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by Nguyen Van Nhan, Date 11/11/2005
---- Purpose: Dung de truy van Phieu ban hang theo bo
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE VIEW [dbo].[AV6066] as
Select  AT9000.DivisionID, TranMonth, TranYear,
	VoucherID, BatchID,	  
	VoucherDate,VoucherNo, Serial, InvoiceNo,
	VoucherTypeID,
	VATTypeID, InvoiceDate,
	VDescription,
	BDescription,
	AT9000.CurrencyID,
	ExchangeRate,
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,
	Sum(Isnull(ConvertedAmount,0)) as ConvertedAmount,
	AT9000.ObjectID,
	(Case when AT1202.IsUpdateName = 0 then AT1202.ObjectName else VATObjectName End) as  ObjectName,
	DueDate,
	OrderID,
	isnull(IsStock,0) as IsStock, 	
	Sum ( Case when TransactionTypeID ='T14' then ConvertedAmount else 0 end ) as TaxAmount,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,	AT9000.CreateUserID
	
From AT9000 WITH(NOLOCK) inner join AT1202 WITH(NOLOCK) on AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
Where TransactionTypeID in ('T04', 'T14') and TableID in ('MT1603' , 'AT1326')

Group by  AT9000.DivisionID, TranMonth, TranYear,
	VoucherID, BatchID,	  
	VoucherDate,VoucherNo, Serial, InvoiceNo,
	VoucherTypeID, VATTypeID, InvoiceDate,
	VDescription,
	BDescription,
	AT9000.CurrencyID,
	ExchangeRate,	
	AT9000.ObjectID,
	ObjectName,
	DueDate,
	OrderID,AT1202.IsUpdateName, VATObjectName,
	isnull(IsStock,0),
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, AT9000.CreateUserID

GO


