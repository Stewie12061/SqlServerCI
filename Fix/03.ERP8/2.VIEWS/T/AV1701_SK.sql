IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1701_SK]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1701_SK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Kiều Nga on 22/12/2022: (customize SIKICO)
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/**********************************************
** Edited by: 
***********************************************/

CREATE VIEW [dbo].[AV1701_SK] AS 

SELECT 
AT9000.DivisionID, 
AT9000.VoucherID, 
AT9000.DebitAccountID AS AccountID,
AT9000.ObjectID,
AT1202.ObjectName, 
AT9000.Serial,
AT9000.InvoiceNo,
AT9000.InvoiceDate,
AT9000.ConvertedAmount,
AT9000.TransactionID,
'D' AS D_C,
AT9000.VDescription,
AT9000.TDescription

FROM AT9000
LEFT JOIN AT1202 ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID

WHERE AT9000.DebitAccountID IN (SELECT AccountID FROM AT0006 WHERE D_C = 'D' AND DivisionID = AT9000.DivisionID)
AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(VoucherID + TransactionID,'') FROM AT1703 WHERE D_C = 'D' AND DivisionID = AT9000.DivisionID)
AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(ReVoucherID + ReTransactionID,'') FROM AT1603 WHERE DivisionID = AT9000.DivisionID)
AND AT9000.TransactionTypeID IN ('T01','T02','T22','T21') AND AT9000.InheritTableID IN ('AT0420','CT0157') 


UNION ALL

SELECT 
AT9000.DivisionID, 
AT9000.VoucherID, 
AT9000.CreditAccountID AS AccountID,
CASE WHEN AT9000.TransactionTypeID = 'T99' THEN AT9000.CreditObjectID ELSE AT9000.ObjectID END AS ObjectID, 
AT1202.ObjectName,
AT9000.Serial,
AT9000.InvoiceNo,
AT9000.InvoiceDate,
AT9000.ConvertedAmount,
AT9000.TransactionID,
'C' AS D_C,
AT9000.VDescription,
AT9000.TDescription

FROM AT9000 
LEFT JOIN AT1202 ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND (CASE WHEN AT9000.TransactionTypeID = 'T99' THEN AT9000.CreditObjectID ELSE AT9000.ObjectID END = AT1202.ObjectID)

WHERE AT9000.CreditAccountID IN (SELECT AccountID FROM AT0006 WHERE D_C = 'C' AND DivisionID = AT9000.DivisionID)
AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(VoucherID + TransactionID,'') FROM AT1703 WHERE D_C = 'C' AND DivisionID = AT9000.DivisionID)
AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(ReVoucherID + ReTransactionID,'') FROM AT1603 WHERE DivisionID = AT9000.DivisionID)
AND AT9000.TransactionTypeID IN ('T01','T02','T22','T21') AND AT9000.InheritTableID IN ('AT0420','CT0157') 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

