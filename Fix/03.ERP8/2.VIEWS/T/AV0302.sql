IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0302]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created By Nguyen Van Nhan, 12/05/2005  
----- Purpose group cac phat sinh trong view AV0303 theo hoa don  
----- SELECT * FROM AV0302 WHERE BatchID = 'AB20110000000054'  
----- SELECT * FROM AV0312 WHERE BatchID = 'AB20110000000054'  
----- SELECT * FROM AT0303 WHERE CreditBatchID = 'AB20110000000054'  
---- Modified on 13/02/2012 by Le Thi Thu Hien : Bo sung them JOIN DivisionID  
---- Modified on 28/02/2012 by Le Thi Thu Hien : B? sung 5 kho?n m?c  
---- Modified on 10/07/2015 by Phuong Thao : Khong ket theo so tien giai tru (bi sai trong TH giai tru nhieu lan)
---- Modified on 14/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 23/06/2017: Bổ sung trường DebitBankAccountID, CreditBankAccountID 
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 08/10/2020: Bổ sung điều kiện Bút toán doanh thu hàng bán bị trả lại có nhiều nhóm thế (T90.TransactionTypeID IN ('T34') and IsMultiTax = 1)
---- Modified by Huỳnh Thử on 19/03/2021: Bỏ + VaTOriginalAmount Sai cho trường hợp khách sử dụng nhiều nhóm thuế. Tiền bị dư lên khoảng VAT này.
---- Modified by Nhựt Trường on 23/04/2021: Bổ sung trường ExchangeRateNew.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

  
CREATE VIEW [dbo].[AV0302] AS   
  
SELECT   T9.ExchangeRateNew, '' AS GiveUpID,   
  T9.VoucherID AS VoucherID,  
  T9.CreditAccountID,   
  T9.BatchID,    
  T9.TableID,  T9.DivisionID,T9.TranMonth, T9.TranYear,  
  T9.ObjectID, A.ObjectName,    
  T9.CurrencyID, T9.CurrencyIDCN,  
  ExchangeRate, ExchangeRateCN,  
  VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,  
  VDescription, VDescription AS BDescription,   
  T9.PaymentID, T9.DueDays, T9.DueDate,      
  ISNULL(T3.GivedOriginalAmount, 0) AS GivedOriginalAmount,    
  ISNULL(T3.GivedConvertedAmount,0) AS GivedConvertedAmount,  
  (isnull(T9.OriginalAmount,0)) AS OriginalAmount, STATUS,   
  (isnull(T9.OriginalAmountCN,0)) AS OriginalAmountCN,  
  (isnull(T9.ConvertedAmount,0)) AS ConvertedAmount,   
  T9.Ana01ID, T9.AnaName01,   
  T9.Ana02ID, T9.AnaName02,
  T9.Ana03ID, T9.AnaName03,   
  T9.Ana04ID, T9.AnaName04,  
  T9.Ana05ID, T9.AnaName05,
  T9.DebitBankAccountID, T9.CreditBankAccountID
FROM  
(
	SELECT	ExchangeRateCN AS ExchangeRateNew, '' AS GiveUpID, VoucherID AS VoucherID,  
			CreditAccountID, BatchID, TableID, DivisionID,TranMonth, TranYear,  
			ObjectID, ObjectName, CurrencyID, CurrencyIDCN,  
			ExchangeRate, ExchangeRateCN,  VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,  
			VDescription, VDescription AS BDescription,   
			PaymentID, DueDays,DueDate, sum(isnull(OriginalAmount,0)) AS OriginalAmount, STATUS,   
			sum(isnull(OriginalAmountCN,0)) AS OriginalAmountCN,  
			sum(isnull(ConvertedAmount,0)) AS ConvertedAmount,   
			max(Ana01ID) as Ana01ID, max(AnaName01) as AnaName01,   
			max(Ana02ID) as Ana02ID, max(AnaName02) as AnaName02, 
			max(Ana03ID) as Ana03ID, max(AnaName03) as AnaName03,   
			max(Ana04ID) as Ana04ID, max(AnaName04) as AnaName04,  
			max(Ana05ID) as Ana05ID, max(AnaName05) as AnaName05,
			DebitBankAccountID, CreditBankAccountID 
	From AV0312
	Group by    VoucherID, CreditAccountID,   BatchID,  TableID,  DivisionID,TranMonth, TranYear,  
				ObjectID, ObjectName,CurrencyID, CurrencyIDCN,  ExchangeRate, ExchangeRateCN,  
				VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,  
				VDescription, PaymentID, DueDays, DueDate,  STATUS , DebitBankAccountID, CreditBankAccountID
	  ) T9   
LEFT JOIN 
	(SELECT	sum(isnull(T03.ConvertedAmount,0)) AS GivedConvertedAmount,  
						sum(isnull(T03.OriginalAmount,0)) AS GivedOriginalAmount,  
						T03.ObjectID, T03.CreditVoucherID,T03.CreditBatchID, T03.CreditTableID,
						T03.AccountID,  T03.DivisionID    
				FROM	AT0303 T03  WITH (NOLOCK) 
				Group by	T03.ObjectID, T03.CreditVoucherID,T03.CreditBatchID,T03.AccountID,  
							T03.DivisionID , T03.CreditTableID   
	)T3  
	ON  T3.ObjectID = T9.ObjectID  and  
	   T3.CreditVoucherID = T9.VoucherID AND  
	   T3.CreditBatchID = T9.BatchID AND  
	   T3.CreditTableID = T9.TableID AND 
	   T3.AccountID = T9.CreditAccountID AND  
	   T3.DivisionID = T9.DivisionID  	    
INNER JOIN AT1005   WITH (NOLOCK) 
	ON   AT1005.AccountID = T9.CreditAccountID and  
	AT1005.GroupID='G03'  
LEFT JOIN AT1202 A  WITH (NOLOCK)  
	ON  A.DivisionID IN (T3.DivisionID, '@@@') AND A.ObjectID =  T9.ObjectID  
     
inner join (select Isnull(Max(IsMultiTax),0) as IsMultiTax, DivisionID, VoucherID, MAX(transactiontypeID) as TransactionTypeID 
			from AT9000  WITH (NOLOCK) Group by DivisionID, VoucherID) T90   ON T9.DivisionID = T90.DivisionID and T9.VoucherID = T90.VoucherID  
Where (T90.TransactionTypeID IN ('T24', 'T34', 'T99') and IsMultiTax=0 OR (T90.TransactionTypeID IN ('T34') and IsMultiTax = 1)) -- Bút toán doanh thu hàng bán bị trả lại có nhiều nhóm thế ) 
    
union all  

SELECT	  T9.ExchangeRateNew, '' AS GiveUpID,   
		  T9.VoucherID AS VoucherID,  
		  T9.CreditAccountID,   
		  T9.BatchID,    
		  T9.TableID,  T9.DivisionID,T9.TranMonth, T9.TranYear,  
		  T9.ObjectID, A.ObjectName,    
		  T9.CurrencyID, T9.CurrencyIDCN,  
		  ExchangeRate, ExchangeRateCN,  
		  VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,  
		  VDescription, VDescription AS BDescription,   
		  T9.PaymentID, T9.DueDays, T9.DueDate,      
		  ISNULL(T3.GivedOriginalAmount, 0) AS GivedOriginalAmount,    
		  ISNULL(T3.GivedConvertedAmount,0) AS GivedConvertedAmount,  
		  (isnull(T9.OriginalAmount,0)) AS OriginalAmount, STATUS,   
		  (isnull(T9.OriginalAmountCN,0)) AS OriginalAmountCN,  
		  (isnull(T9.ConvertedAmount,0)) AS ConvertedAmount,   
		  T9.Ana01ID, T9.AnaName01,   
		  T9.Ana02ID, T9.AnaName02,
		  T9.Ana03ID, T9.AnaName03,   
		  T9.Ana04ID, T9.AnaName04,  
		  T9.Ana05ID, T9.AnaName05,
		  T9.DebitBankAccountID, T9.CreditBankAccountID
FROM (
SELECT      ExchangeRateCN AS ExchangeRateNew, '' AS GiveUpID, VoucherID AS VoucherID,  
			CreditAccountID, BatchID, TableID, DivisionID,TranMonth, TranYear,  
			ObjectID, ObjectName, CurrencyID, CurrencyIDCN,  
			ExchangeRate, ExchangeRateCN,  VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,  
			VDescription, VDescription AS BDescription,   
			PaymentID, DueDays,DueDate, STATUS,   
			--SUM(isnull(OriginalAmount,0)+isnull(VaTOriginalAmount,0)) AS OriginalAmount,   
			--sum(isnull(OriginalAmountCN,0)+isnull(VaTOriginalAmount,0)) AS OriginalAmountCN,  
			SUM(isnull(OriginalAmount,0)) AS OriginalAmount,   
			sum(isnull(OriginalAmountCN,0)) AS OriginalAmountCN,
			sum(isnull(ConvertedAmount,0)+isnull(VatConvertedAmount,0)) AS ConvertedAmount,  
			max(Ana01ID) as Ana01ID, max(AnaName01) as AnaName01,   
			max(Ana02ID) as Ana02ID, max(AnaName02) as AnaName02, 
			max(Ana03ID) as Ana03ID, max(AnaName03) as AnaName03,   
			max(Ana04ID) as Ana04ID, max(AnaName04) as AnaName04,  
			max(Ana05ID) as Ana05ID, max(AnaName05) as AnaName05,
			DebitBankAccountID, CreditBankAccountID 
FROM  AV0312 
Group by    VoucherID, CreditAccountID,   BatchID,  TableID,  DivisionID,TranMonth, TranYear,  
				ObjectID, ObjectName,CurrencyID, CurrencyIDCN,  ExchangeRate, ExchangeRateCN,  
				VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,  
				VDescription, PaymentID, DueDays, DueDate,  STATUS, DebitBankAccountID, CreditBankAccountID   
) T9   
LEFT JOIN (SELECT	SUM((isnull(T03.ConvertedAmount,0)) )AS GivedConvertedAmount,  
					SUM((isnull(T03.OriginalAmount,0))) AS GivedOriginalAmount,  
					T03.ObjectID, T03.CreditVoucherID,T03.CreditBatchID, T03.CreditTableID,
					T03.AccountID,  T03.DivisionID    
			FROM AT0303 T03    WITH (NOLOCK) 
			Group by	T03.ObjectID, T03.CreditVoucherID,T03.CreditBatchID,T03.AccountID,  
						T03.DivisionID , T03.CreditTableID
			)T3  
				ON  T3.ObjectID = T9.ObjectID  and  
				T3.CreditVoucherID = T9.VoucherID AND  
				T3.CreditBatchID = T9.BatchID AND  
				T3.CreditTableID = T9.TableID AND
				T3.AccountID = T9.CreditAccountID AND  
				T3.DivisionID = T9.DivisionID  	   
INNER JOIN AT1005    WITH (NOLOCK)
				ON AT1005.AccountID = T9.CreditAccountID and  
				AT1005.GroupID='G03'  
LEFT JOIN AT1202 A    WITH (NOLOCK)
				ON  A.DivisionID IN (T3.DivisionID, '@@@') AND A.ObjectID =  T9.ObjectID        
inner join (select Isnull(Max(IsMultiTax),0) as IsMultiTax, DivisionID, VoucherID, MAX(transactiontypeID) as TransactionTypeID 
			from AT9000 WITH (NOLOCK)  Group by DivisionID, VoucherID) T90  ON T9.DivisionID = T90.DivisionID and T9.VoucherID = T90.VoucherID  
WHERE  (IsMultiTax =1 and  T90.TransactionTypeID not IN ('T34')) or (T90.TransactionTypeID not IN ('T24','T34', 'T99') and IsMultiTax=0)  

  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

