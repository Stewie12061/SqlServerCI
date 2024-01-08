IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV3037]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV3037]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Tao view load master man hinh truy van but toan nhap khau
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- Dates: 30/06/2008
--- Thuy Tuyen

CREATE VIEW [dbo].[AV3037]
AS

SELECT 
T9.VoucherNo AS BHVoucherNo,
AT9000.VoucherID,
AT9000.VoucherNO, 
AT9000.VoucherDate,
AT9000.TRanMonth, 
AT9000.TranYear, 
AT9000.VoucherTypeID, 
AT9000.BDescription, 
AT9000.DivisionID,
SUM(ConvertedAmount) AS ConvertedAmount, 
SUM(OriginalAmount) AS OriginalAmount, 
AT9000.VATTypeID, 
AT9000.InvoiceDate,
AT9000.Serial, 
AT9000.InvoiceNo,
AT9000.ObjectID, 
AT1202.ObjectNAme, 
AT9000.CurrencyID, 
AT9000.EXchangerate,
AT9000.CreateUserID
FROM AT9000 
LEFT JOIN AT1202 ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
INNER JOIN (SELECT DISTINCT VoucherID, VoucherNO, DivisionID FROM AT9000 WHERE AT9000.TransactionTypeID IN ('T03') AND AT9000.TableID = 'AT9000' ) AS T9
    ON T9.DivisionID = AT9000.DivisionID AND T9.VoucherID = AT9000.VoucherID 
WHERE AT9000.TransactionTypeID IN ('T33') AND AT9000.TableID = 'AT9000' 
GROUP BY 
T9.VoucherNo, AT9000.VoucherID,AT9000.VoucherNO, AT9000.VoucherDate,
AT9000.VoucherTypeID,AT9000.BDescription,AT9000.TRanMonth, AT9000.TranYear, 
AT9000.Serial, AT9000.VoucherTypeID, AT9000.InvoiceNo,AT9000.ObjectID, AT1202.ObjectNAme, AT9000.CurrencyID
, AT9000.EXchangerate, AT9000.DivisionID, AT9000. VATTypeID, AT9000.InvoiceDate, AT9000.CreateUserID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

