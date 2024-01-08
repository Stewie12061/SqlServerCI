IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0042
-- <Summary>
---- Stored đổ nguồn màn hình phân bổ chi phí theo nhiều cấp AF0353 (PACIFIC)
---- Created on 12/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0042 @DivisionID = 'PCF', @UserID = 'ASOFTADMIN', @VoucherID = '30fa7cfb-5bba-44e0-a9d2-737f361b7043'

CREATE PROCEDURE [DBO].[AP0042]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@VoucherID AS NVARCHAR(50)
) 
AS
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX)
		

SET @sSQL1 = '
SELECT AT9005.DivisionID, AT9005.TranMonth, AT9005.TranYear, AT9005.VoucherID, AT9005.VoucherNo,
AT9005.AllocationLevelID, AT9005.VoucherTypeID, AT9005.VoucherDate, AT9005.EmployeeID, AT9005.Description, AT9005.CurrencyID, AT9005.ExchangeRate,
AT9005.OriginalInheritVoucherID, AT9005.OriginalInheritVoucherDate, AT9005.InheritVoucherID, AT9005.InheritVoucherNo, 
AT9001.Orders, AT9001.MasterOrders, AT9001.TransactionID, AT9001.AllocationID, AV0022.AllocationLevelName, AT9001.AllocationType, AT9001.InheritTransactionID,
AT9001.Ana01ID, AT9001.Ana02ID, AT9001.Ana03ID, AT9001.Ana04ID, AT9001.Ana05ID, AT9001.Ana06ID, AT9001.Ana07ID, AT9001.Ana08ID, AT9001.Ana09ID, AT9001.Ana10ID, 
(CASE WHEN AT9001.AnaTypeID = ''A01'' THEN AT9001.Ana01ID 
	  WHEN AT9001.AnaTypeID = ''A02'' THEN AT9001.Ana02ID 
	  WHEN AT9001.AnaTypeID = ''A03'' THEN AT9001.Ana03ID 
	  WHEN AT9001.AnaTypeID = ''A04'' THEN AT9001.Ana04ID 
	  WHEN AT9001.AnaTypeID = ''A05'' THEN AT9001.Ana05ID 
	  WHEN AT9001.AnaTypeID = ''A06'' THEN AT9001.Ana06ID 
	  WHEN AT9001.AnaTypeID = ''A07'' THEN AT9001.Ana07ID 
	  WHEN AT9001.AnaTypeID = ''A08'' THEN AT9001.Ana08ID 
	  WHEN AT9001.AnaTypeID = ''A09'' THEN AT9001.Ana09ID ELSE AT9001.Ana10ID END) AS AnaID,   
AT9001.AnaTypeID, AT1011.AnaName, AT9001.DebitAccountID, AT9001.CreditAccountID, AT9001.OriginalAmount, AT9001.ConvertedAmount,
AT9001.BatchID, AT9001.Serial, AT9001.InvoiceNo, AT9001.InvoiceDate, AT9001.ObjectID, AT9001.InventoryID, AT9001.UnitID, AT9001.TransactionTypeID
FROM AT9005 WITH (NOLOCK)
INNER JOIN AT9001 WITH (NOLOCK) ON AT9005.DivisionID = AT9001.DivisionID AND AT9005.VoucherID = AT9001.VoucherID
LEFT JOIN AV0022 ON AT9005.DivisionID = AV0022.DivisionID AND AT9005.AllocationLevelID = AV0022.AllocationLevelID
LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.AnaTypeID = AT9001.AnaTypeID 
AND AT1011.AnaID = CASE WHEN AT9001.AnaTypeID = ''A01'' THEN AT9001.Ana01ID 
						WHEN AT9001.AnaTypeID = ''A02'' THEN AT9001.Ana02ID 
						WHEN AT9001.AnaTypeID = ''A03'' THEN AT9001.Ana03ID 
						WHEN AT9001.AnaTypeID = ''A04'' THEN AT9001.Ana04ID 
						WHEN AT9001.AnaTypeID = ''A05'' THEN AT9001.Ana05ID 
						WHEN AT9001.AnaTypeID = ''A06'' THEN AT9001.Ana06ID 
						WHEN AT9001.AnaTypeID = ''A07'' THEN AT9001.Ana07ID 
						WHEN AT9001.AnaTypeID = ''A08'' THEN AT9001.Ana08ID 
						WHEN AT9001.AnaTypeID = ''A09'' THEN AT9001.Ana09ID ELSE AT9001.Ana10ID END		
WHERE AT9005.DivisionID = ''' + @DivisionID + '''
AND AT9005.VoucherID = ''' + @VoucherID + '''
ORDER BY AT9001.Orders
'

SET @sSQL2 = N'
SELECT ISNULL(TA.Orders, TB.Orders) AS Orders, AT9001.InheritTransactionID, AT9001.InheritVoucherID, AT9005.OriginalInheritVoucherID,
AT9001.AllocationID, AT9001.AllocationType, 
(CASE WHEN AT9001.AllocationType = 1 THEN N''Tỉ lệ''
      WHEN AT9001.AllocationType = 2 THEN N''Số lượng nhân viên''
      ELSE N''Giá trị ấn định'' END) as AllocationTypeName, 
ISNULL(TA.DebitAccountID, TB.DebitAccountID) AS DebitAccountID, ISNULL(TA.CreditAccountID, TB.CreditAccountID) AS CreditAccountID, 
ISNULL(TA.ConvertedAmount, TB.ConvertedAmount) AS ConvertedAmount,
(CASE WHEN TB.AnaTypeID = ''A01'' THEN TB.Ana01ID 
	  WHEN TB.AnaTypeID = ''A02'' THEN TB.Ana02ID 
	  WHEN TB.AnaTypeID = ''A03'' THEN TB.Ana03ID 
	  WHEN TB.AnaTypeID = ''A04'' THEN TB.Ana04ID 
	  WHEN TB.AnaTypeID = ''A05'' THEN TB.Ana05ID 
	  WHEN TB.AnaTypeID = ''A06'' THEN TB.Ana06ID 
	  WHEN TB.AnaTypeID = ''A07'' THEN TB.Ana07ID 
	  WHEN TB.AnaTypeID = ''A08'' THEN TB.Ana08ID 
	  WHEN TB.AnaTypeID = ''A09'' THEN TB.Ana09ID ELSE TB.Ana10ID END) AS AnaID, AT1011.AnaName   
FROM AT9001 WITH (NOLOCK)
INNER JOIN AT9005 WITH (NOLOCK) ON AT9005.DivisionID = AT9001.DivisionID AND AT9005.VoucherID = AT9001.VoucherID
LEFT JOIN AT9000 AS TA WITH (NOLOCK) ON TA.DivisionID = AT9001.DivisionID AND TA.VoucherID = AT9001.InheritVoucherID AND TA.TransactionID = AT9001.InheritTransactionID
LEFT JOIN AT9001 AS TB WITH (NOLOCK) ON TB.DivisionID = AT9001.DivisionID AND TB.VoucherID = AT9001.InheritVoucherID AND TB.TransactionID = AT9001.InheritTransactionID
LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.AnaTypeID = TB.AnaTypeID 
AND AT1011.AnaID = CASE WHEN TB.AnaTypeID = ''A01'' THEN TB.Ana01ID 
						WHEN TB.AnaTypeID = ''A02'' THEN TB.Ana02ID 
						WHEN TB.AnaTypeID = ''A03'' THEN TB.Ana03ID 
						WHEN TB.AnaTypeID = ''A04'' THEN TB.Ana04ID 
						WHEN TB.AnaTypeID = ''A05'' THEN TB.Ana05ID 
						WHEN TB.AnaTypeID = ''A06'' THEN TB.Ana06ID 
						WHEN TB.AnaTypeID = ''A07'' THEN TB.Ana07ID 
						WHEN TB.AnaTypeID = ''A08'' THEN TB.Ana08ID 
						WHEN TB.AnaTypeID = ''A09'' THEN TB.Ana09ID ELSE TB.Ana10ID END	
WHERE AT9001.DivisionID = ''' + @DivisionID + '''
AND AT9001.VoucherID = ''' + @VoucherID + '''
GROUP BY ISNULL(TA.Orders, TB.Orders), AT9001.InheritTransactionID, AT9001.InheritVoucherID, AT9005.OriginalInheritVoucherID,
AT9001.AllocationID, AT9001.AllocationType,  
ISNULL(TA.DebitAccountID, TB.DebitAccountID), ISNULL(TA.CreditAccountID, TB.CreditAccountID), ISNULL(TA.ConvertedAmount, TB.ConvertedAmount),
(CASE WHEN TB.AnaTypeID = ''A01'' THEN TB.Ana01ID 
	  WHEN TB.AnaTypeID = ''A02'' THEN TB.Ana02ID 
	  WHEN TB.AnaTypeID = ''A03'' THEN TB.Ana03ID 
	  WHEN TB.AnaTypeID = ''A04'' THEN TB.Ana04ID 
	  WHEN TB.AnaTypeID = ''A05'' THEN TB.Ana05ID 
	  WHEN TB.AnaTypeID = ''A06'' THEN TB.Ana06ID 
	  WHEN TB.AnaTypeID = ''A07'' THEN TB.Ana07ID 
	  WHEN TB.AnaTypeID = ''A08'' THEN TB.Ana08ID 
	  WHEN TB.AnaTypeID = ''A09'' THEN TB.Ana09ID ELSE TB.Ana10ID END), AT1011.AnaName  
ORDER BY ISNULL(TA.Orders, TB.Orders)
'

PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
