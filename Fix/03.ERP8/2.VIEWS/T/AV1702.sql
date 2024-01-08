/****** Object: View [dbo].[AV1702] Script Date: 12/16/2010 14:52:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

---- Created BY Thuy Tuyen and Van Nhan, Date 13/12/2006
---- Purpose: View Chet nham xac dinh nhung khoan Doanh thu ung truoc va chi phi tra truoc chua duoc xac dinh (khai bao )de phan bo
---- Edit BY: Dang Le Bao Quynh; Date: 23/04/2007
---- Purpose: Xac dinh lai cach thuc loc cac chung tu khai bao phan bo
---- Modified on 14/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK), thay In bằng EXISTS
ALTER VIEW [dbo].[AV1702] AS 

SELECT 
VoucherID,
VoucherNo,
VoucherDate,
VDescription, 
DebitAccountID AS AccountID,
TranMonth, 
TranYear, 
DivisionID,
SUM(ConvertedAmount) AS ConvertedAmount,
MAX(Ana01ID) as Ana01ID,
MAX(Ana02ID) as Ana02ID,
MAX(Ana03ID) as Ana03ID,
MAX(Ana04ID) as Ana04ID,
MAX(Ana05ID) as Ana05ID,
MAX(Ana06ID) as Ana06ID,
MAX(Ana07ID) as Ana07ID,
MAX(Ana08ID) as Ana08ID,
MAX(Ana09ID) as Ana09ID,
MAX(Ana10ID) as Ana10ID,
'D' AS D_C
FROM AT9000 WITH (NOLOCK)
WHERE  EXISTS (SELECT TOP 1 1 FROM AT0006 WITH (NOLOCK) WHERE D_C = 'D' AND AT9000.DebitAccountID = AccountID AND DivisionID = AT9000.DivisionID)
GROUP BY VoucherID, VoucherNo, VoucherDate, VDescription, TranMonth, TranYear, DivisionID, DebitAccountID

UNION ALL

SELECT 
VoucherID,
VoucherNo,
VoucherDate,
VDescription, 
CreditAccountID AS AccountID,
TranMonth, 
TranYear, 
DivisionID,
SUM(ConvertedAmount) AS ConvertedAmount,
MAX(Ana01ID) as Ana01ID,
MAX(Ana02ID) as Ana02ID,
MAX(Ana03ID) as Ana03ID,
MAX(Ana04ID) as Ana04ID,
MAX(Ana05ID) as Ana05ID,
MAX(Ana06ID) as Ana06ID,
MAX(Ana07ID) as Ana07ID,
MAX(Ana08ID) as Ana08ID,
MAX(Ana09ID) as Ana09ID,
MAX(Ana10ID) as Ana10ID,
'C' AS D_C
FROM AT9000 WITH (NOLOCK)
WHERE  EXISTS (SELECT TOP 1 1 FROM AT0006 WHERE D_C = 'C' AND AT9000.CreditAccountID = AccountID AND DivisionID = AT9000.DivisionID)
GROUP BY VoucherID, VoucherNo, VoucherDate, VDescription, TranMonth, TranYear, DivisionID, CreditAccountID

GO


