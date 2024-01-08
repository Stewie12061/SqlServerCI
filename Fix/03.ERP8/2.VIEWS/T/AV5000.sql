IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV5000]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV5000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- Edit by: Dang Le Bao Quynh; Date: 26/11/2009
-- Purpose: Lay gia tri ObjectName cho truong Object_Address
---- Modified on 13/09/2011 by Le Thi Thu Hien : bo sung Orders
---- Modified on 30/03/2012 by Le Thi Thu Hien : Bổ sung AT9000.SenderReceiver 
---- Modified on 03/08/2012 by Thiên Huỳnh : Bổ sung Khoản mục
---- Modified on 25/10/2012 by Bao Anh : Bổ sung Status
---- Modified on 23/01/2013 by Bao Anh : Bổ sung RefNo01, RefNo02
---- Modified on 19/03/2015 by Trần Quốc Tuấn : Bổ sung SRDivisionName,SRAddress
---- Modified on 15/06/2016 by Kim Vũ: Bổ sung lấy IsWithhodingTax
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Tiểu Mai on 07/08/2018: Bổ sung quy cách hàng hóa
---- Modified by Bảo Anh on 28/10/2018: Bổ sung WITH (NOLOCK)
---- Modified by Tra Giang on 13/03/2019: Bổ sung DivisionName ( Customize BLuesky = 91) 
---- Modified by Hồng Thảo on 11/6/2019: Bổ sung trường RefNo01 từ AT9000 (Customize CBD = 103) 
---- Modified by Lê Hoàng on 24/12/2019: Bổ sung trường BankAccount vì VNF muốn phân biệt tiền quỹ và thu chi tiền mặt / ngân hàng (Customize VNF = 107) 
---- Modified by Lê Hoàng on 28/07/2020: Bổ sung trường CorBankAccountID cho các Tài khoản đối ứng là tài khoản ngân hàng (Customize THL = 122)
---- Modified by Trọng Kiên on 22/10/2020: Fix lỗi Ambiguous InvoiceNo, Serial
---- Modified by Đức Thông on 23/03/2021: [MEIKO] 2021/03/IS/0190: Bổ sung merge code
---- Modified by Nhật Thanh on 13/10/2021: Bổ sung division khi join bảng at1202
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đức Duy on 20/02/2023: [2023/03/IS/0273] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục mã phân tích nghiệp vụ - AT1011.
---- Modified by Đình Định on 29/12/2023: Bổ sung điều kiện WOrderID, WTransactionID phiếu mua hàng kế thừa nhập kho.

CREATE VIEW [dbo].[AV5000] --view chet in so cai
AS

SELECT AT9000.DivisionID,
       AT1101.DivisionName,
       ISNULL(AT9000.WOrderID,AT9000.VoucherID) AS VoucherID,
       AT9000.TableID,
       AT9000.BatchID,
       ISNULL(AT9000.WTransactionID,AT9000.TransactionID) AS TransactionID,
       CASE
           WHEN TransactionTypeID ='T14' THEN 'T04'
           ELSE TransactionTypeID
       END AS TransactionTypeID,
       DebitAccountID AS AccountID,
       isnull(CreditAccountID, '') AS CorAccountID,
       'D' AS D_C,
       DebitAccountID,
       isnull(CreditAccountID, '') AS CreditAccountID,
       AT9000.VoucherDate,
       AT9000.VoucherTypeID,
       AT9000.VoucherNo,
       InvoiceDate,
       isnull(AT9000.InvoiceNo, '') AS InvoiceNo,
       isnull(AT9000.Serial, '') AS Serial,
       AT9000.InventoryID,
       Quantity,
       ConvertedAmount,
       OriginalAmount,
       AT9000.CurrencyID,
       ExchangeRate,
       ConvertedAmount AS SignAmount,
       OriginalAmount AS OSignAmount, --ReportingAmount as SignReporting,
 AT9000.TranMonth,
 AT9000.TranYear,
 AT9000.CreateUserID,
 AT9000.CreateDate,
 VDescription,
 BDescription,
 TDescription,
 AT9000.ObjectID,
 AT9000.VATObjectID,
 AT9000.VATNo,
 AT9000.VATObjectName,
 AT1202.ObjectName AS Object_Address,
 VATTypeID,
 VATGroupID,
 Ana01ID,
 Ana02ID,
 Ana03ID,
 Ana04ID,
 Ana05ID,
 Ana06ID,
 Ana07ID,
 Ana08ID,
 Ana09ID,
 Ana10ID,
 T1.AnaName AS AnaName01,
 T2.AnaName AS AnaName02,
 T3.AnaName AS AnaName03,
 T4.AnaName AS AnaName04,
 T5.AnaName AS AnaName05,
 T6.AnaName AS AnaName06,
 T7.AnaName AS AnaName07,
 T8.AnaName AS AnaName08,
 T9.AnaName AS AnaName09,
 T10.AnaName AS AnaName10,
 ProductID,
 AT9000.Orders,
 AT9000.SenderReceiver,
 Isnull(AT9000.Status, 0) AS Status,
 AT2006.RefNo01,
 AT2006.RefNo02,
 AT9000.SRDivisionName,
 AT9000.SRAddress,
 ISNULL(AT9000.IsWithhodingTax, 0) AS IsWithhodingTax,
 AT9000.RefNo01 AS Note,
 A89.S01ID,
 A89.S02ID,
 A89.S03ID,
 A89.S04ID,
 A89.S05ID,
 A89.S06ID,
 A89.S07ID,
 A89.S08ID,
 A89.S09ID,
 A89.S10ID,
 A89.S11ID,
 A89.S12ID,
 A89.S13ID,
 A89.S14ID,
 A89.S15ID,
 A89.S16ID,
 A89.S17ID,
 A89.S18ID,
 A89.S19ID,
 A89.S20ID,
 DebitBankAccountID AS BankAccountID,
 CreditBankAccountID AS CorBankAccountID,
 AT9000.ObjectID AS DebitObjectID,
 AT1202.ObjectName as DebitObjectName, 
 AT9000.CreditObjectID,
 AT1202_C.ObjectName as CreditObjectName
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.ObjectID = AT1202.ObjectID
LEFT JOIN	AT1202 AT1202_C WITH (NOLOCK) ON AT1202_C.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.CreditObjectID = AT1202_C.ObjectID
LEFT JOIN AT2006 WITH (NOLOCK) ON AT9000.VoucherID= AT2006.VoucherID AND AT9000.DivisionID = AT2006.DivisionID
LEFT JOIN AT1011 T1 WITH (NOLOCK) ON T1.DivisionID IN (AT9000.DivisionID,'@@@') AND T1.AnaID = AT9000.Ana01ID
AND T1.AnaTypeID= 'A01'
LEFT JOIN AT1011 T2 WITH (NOLOCK) ON T2.DivisionID IN (AT9000.DivisionID,'@@@') AND T2.AnaID = AT9000.Ana02ID
AND T2.AnaTypeID= 'A02'
LEFT JOIN AT1011 T3 WITH (NOLOCK) ON T3.DivisionID IN (AT9000.DivisionID,'@@@') AND T3.AnaID = AT9000.Ana03ID
AND T3.AnaTypeID= 'A03'
LEFT JOIN AT1011 T4 WITH (NOLOCK) ON T4.DivisionID IN (AT9000.DivisionID,'@@@') AND T4.AnaID = AT9000.Ana04ID
AND T4.AnaTypeID= 'A04'
LEFT JOIN AT1011 T5 WITH (NOLOCK) ON T5.DivisionID IN (AT9000.DivisionID,'@@@') AND T5.AnaID = AT9000.Ana05ID
AND T5.AnaTypeID= 'A05'
LEFT JOIN AT1011 T6 WITH (NOLOCK) ON T6.DivisionID IN (AT9000.DivisionID,'@@@') AND T6.AnaID = AT9000.Ana06ID
AND T6.AnaTypeID= 'A06'
LEFT JOIN AT1011 T7 WITH (NOLOCK) ON T7.DivisionID IN (AT9000.DivisionID,'@@@') AND T7.AnaID = AT9000.Ana07ID
AND T7.AnaTypeID= 'A07'
LEFT JOIN AT1011 T8 WITH (NOLOCK) ON T8.DivisionID IN (AT9000.DivisionID,'@@@') AND T8.AnaID = AT9000.Ana08ID
AND T8.AnaTypeID= 'A08'
LEFT JOIN AT1011 T9 WITH (NOLOCK) ON T9.DivisionID IN (AT9000.DivisionID,'@@@') AND T9.AnaID = AT9000.Ana09ID
AND T9.AnaTypeID= 'A09'
LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.DivisionID IN (AT9000.DivisionID,'@@@') AND T10.AnaID = AT9000.Ana10ID
AND T10.AnaTypeID= 'A10'
LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID= AT9000.DivisionID
LEFT JOIN AT8899 A89 WITH (NOLOCK) ON AT9000.DivisionID = A89.DivisionID
AND AT9000.TransactionID = A89.TransactionID
AND AT9000.VoucherID = A89.VoucherID
AND A89.TableID = 'AT9000'
WHERE DebitAccountID IS NOT NULL
  AND DebitAccountID <> ''
UNION ALL
SELECT AT9000.DivisionID,
       AT1101.DivisionName,
       ISNULL(AT9000.WOrderID,AT9000.VoucherID) AS VoucherID,
       AT9000.TableID,
       AT9000.BatchID,
       ISNULL(AT9000.WTransactionID,AT9000.TransactionID) AS TransactionID,
       CASE
           WHEN TransactionTypeID ='T14' THEN 'T04'
           ELSE TransactionTypeID
       END AS TransactionTypeID,
       CreditAccountID AS AccountID,
       isnull(DebitAccountID, '') AS CorAccountID,
       'C' AS D_C,
       isnull(DebitAccountID, '') AS DebitAccountID,
       CreditAccountID,
       AT9000.VoucherDate,
       AT9000.VoucherTypeID,
       AT9000.VoucherNo,
       InvoiceDate,
       isnull(AT9000.InvoiceNo, '') AS InvoiceNo,
       isnull(AT9000.Serial, '') AS Serial,
       AT9000.InventoryID,
       Quantity,
       ConvertedAmount,
       OriginalAmount,
       AT9000.CurrencyID,
       ExchangeRate,
       (ConvertedAmount)*-1 AS SignAmount,
       OriginalAmount*-1 AS OSignAmount,
       AT9000.TranMonth,
       AT9000.TranYear,
       AT9000.CreateUserID,
       AT9000.CreateDate,
       VDescription,
       BDescription,
       TDescription,
       AT9000.ObjectID,
       AT9000.VATObjectID,
       AT9000.VATNo,
       AT9000.VATObjectName,
       AT1202.ObjectName AS Object_Address,
       VATTypeID,
       VATGroupID,
       Ana01ID,
       Ana02ID,
       Ana03ID,
       Ana04ID,
       Ana05ID,
       Ana06ID,
       Ana07ID,
       Ana08ID,
       Ana09ID,
       Ana10ID,
       T1.AnaName AS AnaName01,
       T2.AnaName AS AnaName02,
       T3.AnaName AS AnaName03,
       T4.AnaName AS AnaName04,
       T5.AnaName AS AnaName05,
       T6.AnaName AS AnaName06,
       T7.AnaName AS AnaName07,
       T8.AnaName AS AnaName08,
       T9.AnaName AS AnaName09,
       T10.AnaName AS AnaName10,
       ProductID,
       AT9000.Orders,
       AT9000.SenderReceiver,
       Isnull(AT9000.Status, 0) AS Status,
       AT2006.RefNo01,
       AT2006.RefNo02,
       AT9000.SRDivisionName,
       AT9000.SRAddress,
       ISNULL(AT9000.IsWithhodingTax, 0) AS IsWithhodingTax,
       AT9000.RefNo01 AS Note,
       A89.S01ID,
       A89.S02ID,
       A89.S03ID,
       A89.S04ID,
       A89.S05ID,
       A89.S06ID,
       A89.S07ID,
       A89.S08ID,
       A89.S09ID,
       A89.S10ID,
       A89.S11ID,
       A89.S12ID,
       A89.S13ID,
       A89.S14ID,
       A89.S15ID,
       A89.S16ID,
       A89.S17ID,
       A89.S18ID,
       A89.S19ID,
       A89.S20ID,
       CreditBankAccountID AS BankAccountID,
       DebitBankAccountID AS CorBankAccountID,
	   AT9000.ObjectID AS DebitObjectID,
	   AT1202.ObjectName as DebitObjectName, 
	   AT9000.CreditObjectID,
	   AT1202_C.ObjectName as CreditObjectName
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.ObjectID = AT1202.ObjectID
LEFT JOIN AT1202 AT1202_C WITH (NOLOCK) ON AT1202_C.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.CreditObjectID = AT1202_C.ObjectID
LEFT JOIN AT2006 WITH (NOLOCK) ON AT9000.VoucherID= AT2006.VoucherID AND AT9000.DivisionID = AT2006.DivisionID
LEFT JOIN AT1011 T1 WITH (NOLOCK) ON T1.DivisionID IN (AT9000.DivisionID,'@@@') AND T1.AnaID = AT9000.Ana01ID
AND T1.AnaTypeID= 'A01'
LEFT JOIN AT1011 T2 WITH (NOLOCK) ON T2.DivisionID IN (AT9000.DivisionID,'@@@') AND T2.AnaID = AT9000.Ana02ID
AND T2.AnaTypeID= 'A02'
LEFT JOIN AT1011 T3 WITH (NOLOCK) ON T3.DivisionID IN (AT9000.DivisionID,'@@@') AND T3.AnaID = AT9000.Ana03ID
AND T3.AnaTypeID= 'A03'
LEFT JOIN AT1011 T4 WITH (NOLOCK) ON T4.DivisionID IN (AT9000.DivisionID,'@@@') AND T4.AnaID = AT9000.Ana04ID
AND T4.AnaTypeID= 'A04'
LEFT JOIN AT1011 T5 WITH (NOLOCK) ON T5.DivisionID IN (AT9000.DivisionID,'@@@') AND T5.AnaID = AT9000.Ana05ID
AND T5.AnaTypeID= 'A05'
LEFT JOIN AT1011 T6 WITH (NOLOCK) ON T6.DivisionID IN (AT9000.DivisionID,'@@@') AND T6.AnaID = AT9000.Ana06ID
AND T6.AnaTypeID= 'A06'
LEFT JOIN AT1011 T7 WITH (NOLOCK) ON T7.DivisionID IN (AT9000.DivisionID,'@@@') AND T7.AnaID = AT9000.Ana07ID
AND T7.AnaTypeID= 'A07'
LEFT JOIN AT1011 T8 WITH (NOLOCK) ON T8.DivisionID IN (AT9000.DivisionID,'@@@') AND T8.AnaID = AT9000.Ana08ID
AND T8.AnaTypeID= 'A08'
LEFT JOIN AT1011 T9 WITH (NOLOCK) ON T9.DivisionID IN (AT9000.DivisionID,'@@@') AND T9.AnaID = AT9000.Ana09ID
AND T9.AnaTypeID= 'A09'
LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.DivisionID IN (AT9000.DivisionID,'@@@') AND T10.AnaID = AT9000.Ana10ID
AND T10.AnaTypeID= 'A10'
LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID= AT9000.DivisionID
LEFT JOIN AT8899 A89 WITH (NOLOCK) ON AT9000.DivisionID = A89.DivisionID
AND AT9000.TransactionID = A89.TransactionID
AND AT9000.VoucherID = A89.VoucherID
AND A89.TableID = 'AT9000'
WHERE CreditAccountID IS NOT NULL
  AND CreditAccountID <> ''





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
