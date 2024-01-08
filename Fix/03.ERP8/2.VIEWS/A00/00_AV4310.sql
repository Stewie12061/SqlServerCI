IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV4310]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV4310]

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/****** Object:  View [dbo].[AV0301]    Script Date: 08/12/2013 11:17:06 ******/
---- Modified by Văn Tài on 03/08/2020: Script phụ để hỗ trợ chạy all fix bằng tools không báo lỗi view thiếu cột.
---- Target: View được tạo từ các store khác,

CREATE VIEW AV4310 --AP7101
	AS 
		SELECT 'MK' AS DivisionID,
       BatchID,
       TransactionTypeID,
       AccountID,
       CorAccountID,
       D_C,
       DebitAccountID,
       CreditAccountID,
       CASE
           WHEN TransactionTypeID = 'T98' THEN
               DATEADD(hh, 1, VoucherDate)
           ELSE
               VoucherDate
       END AS VoucherDate,
       VoucherTypeID,
       VoucherNo,
       InvoiceDate,
       InvoiceNo,
       Serial,
       ConvertedAmount AS ConvertedAmount,
       OriginalAmount AS OriginalAmount,
       OSignAmount AS OSignAmount,
       SignAmount AS SignAmount,
       CurrencyID,
       ExchangeRate,
       TranMonth,
       TranYear,
       TranMonth + TranYear * 100 AS Period,
       CreateUserID,
       VDescription,
       BDescription,
       TDescription,
       ObjectID,
       VATObjectID,
       VATNo,
       VATObjectName,
       Object_Address,
       VATTypeID,
       VATGroupID,
       AccountID AS LinkAccountID,
       AV5000.Orders,
       AV5000.SenderReceiver,
       AV5000.Ana01ID,
       AV5000.Ana02ID,
       AV5000.Ana03ID,
       AV5000.Ana04ID,
       AV5000.Ana05ID,
       AV5000.Ana06ID,
       AV5000.Ana07ID,
       AV5000.Ana08ID,
       AV5000.Ana09ID,
       AV5000.Ana10ID,
       AV5000.AnaName01,
       AV5000.AnaName02,
       AV5000.AnaName03,
       AV5000.AnaName04,
       AV5000.AnaName05,
       AV5000.AnaName06,
       AV5000.AnaName07,
       AV5000.AnaName08,
       AV5000.AnaName09,
       AV5000.AnaName10,
       AV5000.VoucherID,
       AV5000.TableID,
       AV5000.Status,
       AV5000.RefNo01,
       AV5000.RefNo02,
       AV5000.SRDivisionName,
       AV5000.SRAddress,
       AV5000.IsWithhodingTax,
       '' AS CreditObjectID,
       '' AS DebitObjectName
	FROM AV5000
	WHERE DivisionID LIKE 'MK'
			AND
			(
				AccountID LIKE '0000000%'
				OR AccountID LIKE '9111110%'
				OR
				(
					AccountID >= '0000000'
					AND AccountID <= '9111110'
				)
			)
			AND 1 = 1
			AND TranYear * 100 + TranMonth <= '    202005';
		
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
