IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[FP0053]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[FP0053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tra ra man hinh khi ke thua but toan chi phi tu ASOFT T sang FA 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> ASOFT-FA/ Tai san co dinh/ Thay doi nguyen gia
---- Ke thua but toan chi phi - FF0052
-- <History>
-- <Example>
-- Create by Phương Thảo on 10/03/2016
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 22/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 01/10/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- >> Example: EXEC FP0053 'GS', 2, 2016, 2, 2016, '2016-03-10 00:00:00', '2016-03-10 00:00:00', 0, '', ''


CREATE PROCEDURE [dbo].[FP0053] 
    @DivisionID NVARCHAR(50),
    @FromMonth INT,
    @FromYear INT,
    @ToMonth INT,
    @ToYear INT, 
    @FromDate DATETIME,
    @ToDate DATETIME,
    @Period TINYINT, -- 0 theo ky, 1 theo ngày       
	@AssetID NVarchar(50),
    @RevaluateID NVARCHAR(50)-- Thêm mới: '', Sửa: AssetID chon edit
    
AS

DECLARE 
@sSQL NVARCHAR(4000),
@sSQL1 NVARCHAR(4000),
@sSQL2 NVARCHAR(4000),
@sSQLWhere NVARCHAR(4000),
@TaskID NVarchar(50)

--SELECT @TaskID = Ana01ID
--FROM AT1533
--WHERE AssetID = @AssetID


If(@Period = 0)
	Set @sSQLWhere =   'AND AT9000.TranMonth + AT9000.TranYear * 100 BETWEEN ' + CAST(@FromMonth + @FromYear * 100 AS VARCHAR(20)) + ' AND ' + CAST(@ToMonth + @ToYear * 100 AS VARCHAR(20))+''
Else
	Set @sSQLWhere = 'AND AT9000.VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 21) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 21) + ''''


SET @sSQL ='
SELECT Convert(TinyInt, 0) As IsSelected, AT9000.DivisionID,
		AT9000.VoucherNo,    AT9000.VoucherDate,    AT9000.VDescription,   AT9000.VoucherTypeID,     
      AT9000.Serial,	    AT9000.InvoiceNo,      AT9000.InvoiceDate,    AT9000.DueDate,
      AT9000.CurrencyID,    AT9000.ExchangeRate,   AT9000.OriginalAmount, AT9000.ConvertedAmount,
      AT9000.DebitAccountID, AT9000.CreditAccountID, AT9000.VATTypeID, AT9000.VATGroupID, AT9000.ObjectID, AT1202.ObjectName,
      AT9000.CreditObjectID, AT1202C.ObjectName AS CreditObjectName, AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
      AT9000.Ana06ID,  AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,  AT9000.OrderID,
      AT9000.PeriodID, AT9000.BDescription,  AT9000.TDescription, AT9000.TransactionID, AT9000.VoucherID, 
	  AT9000.VATNo,    AT9000.ProductID,  MT1601.Description AS PeriodName, AT1302.InventoryName AS ProductName,
	  Convert(Decimal(28,8),0) AS EndOriginalAmount,
	  Convert(Decimal(28,8),0) AS EndConvertedAmount
INTO	#AP0053_AT9000
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT9000.DivisionID) AND AT9000.ProductID = AT1302.InventoryID
LEFT JOIN MT1601 WITH (NOLOCK) ON AT9000.DivisionID = MT1601.DivisionID AND AT9000.PeriodID = MT1601.PeriodID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID = AT1202.ObjectID
LEFT JOIN AT1202 AT1202C WITH (NOLOCK) ON AT1202C.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID = AT1202C.ObjectID
WHERE AT9000.DivisionID = '''+@DivisionID+''' and IsInheritFA = 1
AND NOT EXISTS (SELECT TOP 1 1 FROM AT1533 WITH (NOLOCK) WHERE AT9000.TransactionID = AT1533.ReTransactionID AND AT9000.DivisionID = AT1533.DivisionID)

' + @sSQLWhere

SET @sSQL1 ='
UPDATE T1
SET	T1.EndOriginalAmount = T1.OriginalAmount - ISNULL(A.AOriginalAmount,0),
	T1.EndConvertedAmount = T1.ConvertedAmount - ISNULL(A.AConvertedAmount,0)
FROM #AP0053_AT9000 T1
LEFT JOIN
(
	SELECT  ISNULL(SUM(ISNULL(OriginalAmount, 0)), 0) AS AOriginalAmount, 
			ISNULL(SUM(ISNULL(ConvertedAmount, 0)), 0) AS AConvertedAmount,
			ReTransactionID, DivisionID 
	FROM  AT1590  WITH (NOLOCK)
	WHERE VoucherID <> '''+@RevaluateID+'''	
	GROUP BY ReTransactionID, DivisionID
) AS A ON A.ReTransactionID = T1.TransactionID AND A.DivisionID = T1.DivisionID
'

IF(ISNULL(@RevaluateID,'') <> '')
BEGIN
	SET @sSQL1 = @sSQL1 + ' 
	UPDATE T1
	SET	T1.IsSelected = 1
	FROM #AP0053_AT9000 T1		
	INNER JOIN  AT1590 A WITH (NOLOCK) ON A.ReTransactionID = T1.TransactionID AND A.DivisionID = T1.DivisionID
	WHERE A.VoucherID = '''+@RevaluateID+'''
	
	'
END


SET @sSQL2 = '
SELECT	IsSelected, DivisionID,
		VoucherNo,    VoucherDate,    VDescription,   VoucherTypeID,     
		Serial,	    InvoiceNo,      InvoiceDate,    DueDate,
		CurrencyID,    ExchangeRate,   EndOriginalAmount AS OriginalAmount, EndConvertedAmount AS ConvertedAmount,
		DebitAccountID, CreditAccountID, VATTypeID, VATGroupID, ObjectID, ObjectName,
		CreditObjectID, CreditObjectName, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
		Ana06ID,  Ana07ID, Ana08ID, Ana09ID, Ana10ID,  OrderID,
		PeriodID, BDescription,  TDescription, TransactionID, VoucherID, 
		VATNo,    ProductID,  PeriodName, ProductName
FROM	#AP0053_AT9000
WHERE	EndOriginalAmount <> 0
'

--Print @sSQL
----Print @sSQLWhere
--Print @sSQL1
--Print @sSQL2
EXEC (@sSQL + @sSQL1+ @sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

