IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0401]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





------ Created By Nguyen Van Nhan, Sunday 09/11/2003.
----- Purpose Loc cac  hoa  don phat sinh No cong no phat tra
----- Cac truong nhan biet: VoucherID, BatchID,TableID,ObjectID,DebitAccountID,
--Quoc Huy, Date 07/01/2009
----Edit By Thien Huynh (13/02/2012): Nhom cac dong cung Hoa don (BatchID) thanh 1 dong, 
----khong nhom theo cac tieu chi khac (Khoan muc)
---- Modified by Phương Thảo on 20/01/2016: Không group theo Diễn giải chi tiết
---- Modified by Phương Thảo on 01/03/2016: Sửa cách trả dữ liệu ExchangeRate
---- Modified by Kim Vu on 12/05/2016: Sửa trường hợp ExchangeRateCN NULL thi lấy ExchangeRate
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Tiểu Mai on 29/06/2017: Bổ sung trường DebitBankAccountID, CreditBankAccountID 
---- Modified by Kim Thư on 27/05/2019: Lấy ExchangeRate và ExchangeRateCN không phụ thuộc PaymentExchangeRate
---- Modified by Nhựt Trường on 26/04/2021: Bổ sung trường  ExchangeRateNew.
---- Modified by Nhựt Trường on 10/05/2021: Sửa cách trả dữ liệu ExchangeRate.
---- Modified by Nhựt Trường on 28/05/2021: Bổ sung thêm điều kiện theo DivisionID khi join bảng.


CREATE VIEW [dbo].[AV0401] as 


SELECT  AT9000.ExchangeRate AS ExchangeRateNew,'' As GiveUpID, VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	AT9000.ObjectID, DebitAccountID, AT9000.CurrencyID, AT9000.CurrencyIDCN, AT1202.ObjectName,	
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount, 
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,
	GivedOriginalAmount = isnull((Select Sum(isnull(OriginalAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0)-
						isnull((Select Sum(isnull(OriginalAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										CreditVoucherID = AT9000.VoucherID and
										CreditBatchID = AT9000.BatchID and
										CreditTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0)
										,
	GivedConvertedAmount =isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0)-
							isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										CreditVoucherID = AT9000.VoucherID and
										CreditBatchID = AT9000.BatchID and
										CreditTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0),
										AT9000.ExchangeRate,
										ISNULL(AT9000.ExchangeRateCN, AT9000.ExchangeRate)  AS ExchangeRateCN,
	--CASE WHEN	AT1004.Operator = 0 THEN Sum(isnull(ConvertedAmount,1))/Sum(isnull(OriginalAmountCN,1)) ELSE Sum(isnull(OriginalAmountCN,1)) /Sum(isnull(ConvertedAmount,1)) END AS	ExchangeRate, 
	--CASE WHEN	AT1004.Operator = 0 THEN Sum(isnull(ConvertedAmount,1))/Sum(isnull(OriginalAmountCN,1)) ELSE Sum(isnull(OriginalAmountCN,1)) /Sum(isnull(ConvertedAmount,1)) END AS ExchangeRateCN, 
	--CASE WHEN Isnull(PaymentExchangeRate,0) <> 0 THEN  PaymentExchangeRate ELSE AT90.ExchangeRate END AS ExchangeRate,
	--CASE WHEN Isnull(PaymentExchangeRate,0) <> 0 THEN  PaymentExchangeRate ELSE ISNULL(AT90.ExchangeRateCN,AT90.ExchangeRate) END AS ExchangeRateCN,
	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	Max(VDescription) AS VDescription, Max(VDescription)  as BDescription, Status, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate, 
	Max(Ana01ID) As Ana01ID, AT9000.DebitBankAccountID, AT9000.CreditBankAccountID
FROM AT9000 
Left join AT1202 on AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
left join AT1004 on AT1004.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1004.CurrencyID = AT9000.CurrencyID
WHERE DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G04' and  IsObject =1)
Group by VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	AT9000.ObjectID, DebitAccountID, AT9000.CurrencyID, AT9000.CurrencyIDCN, AT1202.ObjectName,
	AT1004.Operator,
	AT9000.ExchangeRate, AT9000.ExchangeRateCN, 
	--CASE WHEN Isnull(PaymentExchangeRate,0) <> 0 THEN  PaymentExchangeRate ELSE AT90.ExchangeRate END,
	--CASE WHEN Isnull(PaymentExchangeRate,0) <> 0 THEN  PaymentExchangeRate ELSE ISNULL(AT90.ExchangeRateCN,AT90.ExchangeRate) END,
	VoucherTypeID, VoucherNo, VoucherDate,  
	 InvoiceDate, InvoiceNo, Serial,
	-- VDescription, 
	Status, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate, AT9000.DebitBankAccountID, AT9000.CreditBankAccountID




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

