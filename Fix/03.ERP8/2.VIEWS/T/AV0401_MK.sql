IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0401_MK]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0401_MK]
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
---- Modified by Huỳnh Thử on 17/08/2020: Merge Code: MEKIO và MTE
---- Modified by Văn Tài   on 27/01/2021: Bổ sung lấy cột InheritTableID.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE VIEW [dbo].[AV0401_MK] 
as 
SELECT  '' As GiveUpID
			, VoucherID
			, BatchID
			, TableID
			, AT9000.DivisionID
			, TranMonth
			, TranYear
			, AT9000.ObjectID
			, DebitAccountID
			, AT9000.CurrencyID
			, AT9000.CurrencyIDCN
			, AT1202.ObjectName
			, SUM(ISNULL(OriginalAmount, 0)) as OriginalAmount
			, SUM(ISNULL(ConvertedAmount, 0)) as ConvertedAmount
			, Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN
			, GivedOriginalAmount = isnull((Select Sum(isnull(OriginalAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0)
									-
									isnull((Select Sum(isnull(OriginalAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
													ObjectID = AT9000.ObjectID and
													CreditVoucherID = AT9000.VoucherID and
													CreditBatchID = AT9000.BatchID and
													CreditTableID = At9000.TableID and
													AccountID = AT9000.DebitAccountID and
													CurrencyID = AT9000.CurrencyIDCN),0)
			, GivedConvertedAmount = isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0)
									-
									isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
												ObjectID = AT9000.ObjectID and
												CreditVoucherID = AT9000.VoucherID and
												CreditBatchID = AT9000.BatchID and
												CreditTableID = At9000.TableID and
												AccountID = AT9000.DebitAccountID and
												CurrencyID = AT9000.CurrencyIDCN),0)
			, AT9000.ExchangeRate AS ExchangeRate
			, ISNULL(AT9000.ExchangeRateCN, AT9000.ExchangeRate) AS ExchangeRateCN
			, VoucherTypeID
			, VoucherNo
			, VoucherDate
			, InvoiceDate
			, InvoiceNo
			, Serial
			, Max(VDescription) AS VDescription
			, Max(VDescription) as BDescription
			, Status
			, AT9000.PaymentID
			, AT9000.DueDays
			, AT9000.DueDate
			, Max(Ana01ID) AS Ana01ID
			, AT9000.DebitBankAccountID
			, AT9000.CreditBankAccountID
			, AT9000.InheritTableID
FROM AT9000 
LEFT JOIN AT1202 on AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
LEFT JOIN AT1004 on AT1004.CurrencyID = AT9000.CurrencyID
WHERE DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G04' and  IsObject = 1)
Group by VoucherID
		, BatchID
		, TableID
		, AT9000.DivisionID
		, TranMonth
		, TranYear
		, AT9000.ObjectID
		, DebitAccountID
		, AT9000.CurrencyID
		, AT9000.CurrencyIDCN
		, AT1202.ObjectName
		, AT1004.Operator
		, CASE WHEN Isnull(PaymentExchangeRate,0) <> 0 THEN  PaymentExchangeRate ELSE AT9000.ExchangeRate END
		, CASE WHEN Isnull(PaymentExchangeRate,0) <> 0 THEN  PaymentExchangeRate ELSE ISNULL(AT9000.ExchangeRateCN,AT9000.ExchangeRate) END
		, AT9000.ExchangeRate
		, AT9000.ExchangeRateCN
		, VoucherTypeID
		, VoucherNo
		, VoucherDate
		, InvoiceDate
		, InvoiceNo
		, Serial
		, Status
		, AT9000.PaymentID
		, AT9000.DueDays
		, AT9000.DueDate
		, AT9000.DebitBankAccountID
		, AT9000.CreditBankAccountID
		, AT9000.InheritTableID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

