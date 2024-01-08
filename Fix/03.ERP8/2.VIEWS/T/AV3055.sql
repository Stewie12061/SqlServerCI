IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV3055]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV3055]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Notes:	 View chet.
-- Purpose:	Dung de truy van phieu so du theo tai khoan.
--- Last Updated by Nguyen Van Nhan, Date 28/07/2004
--- Modified by Tiểu Mai on 05/12/2016: Bổ sung 10 tham số ở lưới
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Hải Long on 24/05/2017: ISNULL trường status
---- Modified by Nhựt Trường on 04/01/2021: Bổ sung thêm điều kiện DivisionID khi join bảng AT1103.
---- Modified by Kiều Nga on 24/02/2023: Bổ sung thêm trường DepartmentID

CREATE VIEW [dbo].[AV3055] as 
Select 	 VoucherID,	BatchID,	TransactionID,        TableID,
	 AT9000.DivisionID,           TranMonth ,  TranYear ,     AT9000.CurrencyID ,          AT9000.ObjectID,     ObjectName,
	 DebitAccountID ,     CreditAccountID,     ExchangeRate  ,       OriginalAmount ,
	 DebitBankAccountID, CreditBankAccountID, 	
     	 ConvertedAmount,                VoucherDate,                 InvoiceDate, DueDate, 
               VoucherTypeID,         VoucherNo,            Serial  ,             InvoiceNo,            
	 Orders, VDescription as Description,
	VDescription,BDescription ,TDescription,        
	TransactionTypeID,
	AT9000.EmployeeID,
	ISNULL(Status, 0) AS Status, IsAudit, AT9000.CreateDate, AT9000.CreateUserID, AT9000.LastModifyDate, AT9000.LastModifyUserID,
	D.IsObject as IsObjectD,
    C.IsObject as IsObjectC,
	E.FullName,
	AT9000.Ana01ID,
	AT9000.Ana02ID,
	AT9000.Ana03ID,
	AT9000.Ana04ID,
	AT9000.Ana05ID,
	AT9000.Ana06ID,
	AT9000.Ana07ID,
	AT9000.Ana08ID,
	AT9000.Ana09ID,
	AT9000.Ana10ID,
	AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05, 
	AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10,
	AT9000.DepartmentID
From AT9000 WITH (NOLOCK)	left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT9000.ObjectID
		left join AT1005 D WITH (NOLOCK) on D.AccountID = At9000.DebitAccountID
		Left join AT1005 C WITH (NOLOCK) on C.AccountID = At9000.CreditAccountID
		left join AT1103 E WITH (NOLOCK) on E.DivisionID IN (AT9000.DivisionID,'@@@') AND AT9000.EmployeeID=E.EmployeeID

Where  TransactionTypeID ='T00' and
	--TableID ='AT9000'	
	VoucherID not in (Select VoucherID From AT2017)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



