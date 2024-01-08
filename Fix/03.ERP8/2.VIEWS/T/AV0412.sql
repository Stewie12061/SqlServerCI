IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0412]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0412]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--View chet
--Purpose: giai tru cong no phai tra
-- last edit : Thuy Tuyen , them cac truong O Code, date 15/07/2009
--- Modify on 15/05/2016 by Bảo Anh: Bổ sung DivisionID khi Left join AT1202
---- Modified on 14/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 07/03/2017 by Bảo Thy: Bỏ group by CreditObjectID
---- Modified on 16/05/2017 by Bảo Thy: Bổ sung Ana01ID -> Ana10ID (SGPT)
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified on 21/06/2017 by Phương Thảo: Sửa lại lấy Max mã phân tích
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhựt Trường on 06/10/2023: [2023/10/IS/0069] - MEIKO, lấy tổng tiền theo phiếu.

CREATE VIEW [dbo].[AV0412] as 
SELECT Distinct '' As GiveUpID, VoucherID, BatchID,  TableID, AT9000.DivisionID,TranMonth,TranYear,
	(Case when TransactionTypeID ='T99' then  AT9000.CreditObjectID else AT9000.ObjectID end) As ObjectID , 
	CreditAccountID, AT1005.AccountName as CreditAccountName,
	AT9000.CurrencyID, CurrencyIDCN,
	(Case when TransactionTypeID ='T99' then  B.ObjectName  else AT1202.ObjectName   end)  as  ObjectName,
	--Sum(isnull(OriginalAmount,0)) as OriginalAmount,Sum(isnull(ConvertedAmount,0)) as ConvertedAmount, 
	--Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,
	(SELECT Sum(isnull(OriginalAmount,0)) FROM AT9000 T09 WITH(NOLOCK) WHERE T09.DivisionID = AT9000.DivisionID AND T09.VoucherID = AT9000.VoucherID) as OriginalAmount,
	(SELECT Sum(isnull(ConvertedAmount,0)) FROM AT9000 T09 WITH(NOLOCK) WHERE T09.DivisionID = AT9000.DivisionID AND T09.VoucherID = AT9000.VoucherID) as ConvertedAmount,
	(SELECT Sum(isnull(OriginalAmountCN,0)) FROM AT9000 T09 WITH(NOLOCK) WHERE T09.DivisionID = AT9000.DivisionID AND T09.VoucherID = AT9000.VoucherID) as OriginalAmountCN,
	ExchangeRate, ExchangeRateCN,
	VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,
	VDescription, VDescription as BDescription,	0 as Status,
	AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate,
	(Case when TransactionTypeID ='T99' then  B.O01ID else AT1202.O01ID end) as O01ID,
	(Case when TransactionTypeID ='T99' then  B.O02ID else AT1202.O02ID end) as O02ID,
	(Case when TransactionTypeID ='T99' then  B.O03ID else AT1202.O03ID end) as O03ID,
	(Case when TransactionTypeID ='T99' then  B.O04ID else AT1202.O04ID end) as O04ID,
	(Case when TransactionTypeID ='T99' then  B.O05ID else AT1202.O05ID end) as O05ID,
	T01.AnaName as O01Name, T02.AnaName as O02Name,T03.AnaName as O03Name,T04.AnaName as O04Name,T05.AnaName as O05Name,
	MAX(AT9000.Ana01ID) AS Ana01ID, MAX(AT9000.Ana02ID) AS Ana02ID, MAX(AT9000.Ana03ID) AS Ana03ID, MAX(AT9000.Ana04ID) AS Ana04ID, MAX(AT9000.Ana05ID) AS Ana05ID,
	MAX(AT9000.Ana06ID) AS Ana06ID, MAX(AT9000.Ana07ID) AS Ana07ID, MAX(AT9000.Ana08ID) AS Ana08ID, MAX(AT9000.Ana09ID) AS Ana09ID, MAX(AT9000.Ana10ID) AS Ana10ID

FROM AT9000   WITH (NOLOCK)	Left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
left join AT1202  B WITH (NOLOCK) on B.DivisionID IN (AT9000.DivisionID, '@@@') AND B.ObjectID = AT9000.CreditObjectID
Full join AT1005 WITH (NOLOCK) on AT1005.AccountID = AT9000.CreditAccountID

Left Join AT1015  T01 WITH (NOLOCK) on T01.AnaID =  (Case when TransactionTypeID ='T99' then  B.O01ID else AT1202.O01ID end)  and T01.AnaTypeID = 'O01'
Left Join AT1015  T02 WITH (NOLOCK) on T02.AnaID =  (Case when TransactionTypeID ='T99' then  B.O02ID else AT1202.O02ID end)  and T02.AnaTypeID = 'O02'
Left Join AT1015  T03 WITH (NOLOCK) on T03.AnaID =  (Case when TransactionTypeID ='T99' then  B.O03ID else AT1202.O03ID end) and T03.AnaTypeID = 'O03'
Left Join AT1015  T04 WITH (NOLOCK) on T04.AnaID =  (Case when TransactionTypeID ='T99' then  B.O04ID else AT1202.O04ID end) and T04.AnaTypeID = 'O04'
Left Join AT1015  T05 WITH (NOLOCK) on T05.AnaID =  (Case when TransactionTypeID ='T99' then  B.O05ID else AT1202.O05ID end)  and T05.AnaTypeID = 'O05'
		
WHERE  EXISTS (Select TOP 1 1 From AT1005 WITH (NOLOCK) Where AccountID = AT9000.CreditAccountID and GroupID ='G04' and  IsObject =1)
Group by VoucherID,BatchID,  TableID,AT9000.DivisionID,TranMonth,TranYear,
	---AT9000.ObjectID, 
	CreditAccountID, AT1005.AccountName, AT9000.CurrencyID, CurrencyIDCN, ExchangeRate,ExchangeRateCN,
	(Case when TransactionTypeID ='T99' then  AT9000.CreditObjectID else AT9000.ObjectID end),
	(Case when TransactionTypeID ='T99' then  B.ObjectName  else AT1202.ObjectName  end),
	--CreditObjectID,  
	VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,
	VDescription, ---Status,
	AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate,
	 (Case when TransactionTypeID ='T99' then  B.O01ID else AT1202.O01ID end),
	 (Case when TransactionTypeID ='T99' then  B.O02ID else AT1202.O02ID end),
	 (Case when TransactionTypeID ='T99' then  B.O03ID else AT1202.O03ID end),
	 (Case when TransactionTypeID ='T99' then  B.O04ID else AT1202.O04ID end),
	 (Case when TransactionTypeID ='T99' then  B.O05ID else AT1202.O05ID end),
	T01.AnaName , T02.AnaName ,T03.AnaName ,T04.AnaName ,T05.AnaName


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

