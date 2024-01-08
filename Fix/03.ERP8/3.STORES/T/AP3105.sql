IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by:  on: Huỳnh Thử
---- Created by:  on: Sửa ok
---- Modified by Nhựt Trường on 23/08/2021:  Customer Gotec - Lấy thêm phát sinh định khoản n331/c131, n331/c711,n153/c331 vào báo cáo đặc thù.
---- Modified by Nhựt Trường on 13/10/2021:  Customer Gotec - Lấy thêm trường PaidBalance (số dư đã thanh toán).
---- Modified by Xuân Nguyên on 04/05/2022:  Customer Gotec - Bổ sung điều kiện lọc theo ObjectID,ContractNo,Ana01ID.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
	 AP3105 'LTV', '', 'ADC/08/2014/0007'
*/

 CREATE PROCEDURE AP3105
(
	@DivisionID VARCHAR(50),
	@GroupAna VARCHAR(50),
	@FromDate  DATETIME,
	@Type VARCHAR(50), -- 0 mua, 1 bán,
	@IsPrint int = 0,
	@ObjectID VARCHAR(50),
	@ContractNo VARCHAR(50),
	@Ana01ID VARCHAR(50)
)
AS
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @sSQL NVARCHAR(MAX), @AnaID VARCHAR(50), @sSQL1 NVARCHAR(10) = '', @sSQL2 NVARCHAR(10) = '', @sqlUnionAll NVARCHAR(1000), @sqlGroupBy NVARCHAR(MAX) = '',@sqlWhere1 NVARCHAR(MAX)
-- Lấy mã phân tích hợp đồng

IF @Type = 0
SET @AnaID = ISNULL((SELECT TOP 1 ContractAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID),'')

IF @Type = 1
SET @AnaID = ISNULL((SELECT TOP 1 SalesContractAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID), '')

IF @AnaID = 'A01' SET @sSQL1 = 'Ana01ID'
IF @AnaID = 'A02' SET @sSQL1 = 'Ana02ID'
IF @AnaID = 'A03' SET @sSQL1 = 'Ana03ID'
IF @AnaID = 'A04' SET @sSQL1 = 'Ana04ID'
IF @AnaID = 'A05' SET @sSQL1 = 'Ana05ID'
IF @AnaID = 'A06' SET @sSQL1 = 'Ana06ID'
IF @AnaID = 'A07' SET @sSQL1 = 'Ana07ID'
IF @AnaID = 'A08' SET @sSQL1 = 'Ana08ID'
IF @AnaID = 'A09' SET @sSQL1 = 'Ana09ID'
IF @AnaID = 'A10' SET @sSQL1 = 'Ana10ID'
IF ISNULL(@AnaID, '') = ''    SET @sSQL1 = ''''''

IF @GroupAna = 'A01' SET @sSQL2 = 'Ana01ID'
IF @GroupAna = 'A02' SET @sSQL2 = 'Ana02ID'
IF @GroupAna = 'A03' SET @sSQL2 = 'Ana03ID'
IF @GroupAna = 'A04' SET @sSQL2 = 'Ana04ID'
IF @GroupAna = 'A05' SET @sSQL2 = 'Ana05ID'
IF @GroupAna = 'A06' SET @sSQL2 = 'Ana06ID'
IF @GroupAna = 'A07' SET @sSQL2 = 'Ana07ID'
IF @GroupAna = 'A08' SET @sSQL2 = 'Ana08ID'
IF @GroupAna = 'A09' SET @sSQL2 = 'Ana09ID'
IF @GroupAna = 'A10' SET @sSQL2 = 'Ana10ID'
IF ISNULL(@GroupAna, '') = ''    SET @sSQL2 = ''''''

SET @sqlUnionAll = ''
set @sqlWhere1 =''
IF @CustomerName = 140 set @sqlWhere1 ='
AND ISNULL(A90.ObjectID,'''') = '''+@ObjectID+'''
AND ISNULL(AT1020.ContractNo,'''') = '''+@ContractNo+'''
AND ISNULL(A90.Ana01ID,'''') = '''+@Ana01ID+''''
IF @Type = 0
BEGIN
    SET @sSQL = N'
SELECT A90.DivisionID,A90.'+@sSQL2+' AS MaDA, A90.'+@sSQL1+' MaHD,A90.ObjectID,  A90.ConvertedAmount, A90.CreditAccountID, A90.DebitAccountID, A90.TransactionTypeID
 INTO #TempAP3105 FROM AT9000 A90 WITH (NOLOCK)
LEFT JOIN AT1202  A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A90.ObjectID
INNER JOIN AT1020 WITH (NOLOCK) ON AT1020.DivisionID = A90.DivisionID AND AT1020.ContractNo = A90.'+@sSQL1+'
WHERE A90.DivisionID = '''+@DivisionID+'''
AND CONVERT(DATETIME,CONVERT(VARCHAR(10),A90.VoucherDate,101),101) <= '''+CONVERT(NVARCHAR(10), @FromDate ,101)+''' 


SELECT DivisionID,MaDA, MaHD,ObjectID, SUM(ConvertedAmount) AS ConvertedAmount 
INTO #Amount07 
FROM (
	-- Credit 111, 112
	SELECT DivisionID,MaDA, MaHD,ObjectID, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount FROM #TempAP3105 WHERE CreditAccountID LIKE ''111%'' OR CreditAccountID LIKE ''112%'' '+CASE WHEN @CustomerName = 140 /*Customer Gotec*/ THEN ' OR CreditAccountID LIKE ''3388%'' OR CreditAccountID LIKE ''131%'' ' END+'
	GROUP BY DivisionID,MaDA, MaHD,ObjectID
	UNION ALL	
	-- Credit 331 - Debit 111,112
	SELECT DivisionID,MaDA, MaHD,ObjectID, -ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount FROM #TempAP3105 WHERE CreditAccountID LIKE ''331'' and (DebitAccountID LIKE ''111%'' OR DebitAccountID LIKE ''112%'' )
	GROUP BY DivisionID,MaDA, MaHD,ObjectID
) A GROUP BY DivisionID,MaDA, MaHD,ObjectID


SELECT DivisionID,MaDA, MaHD,ObjectID, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount 
INTO #Amount08 
FROM (
	-- Credit 111, 112
	SELECT DivisionID,MaDA, MaHD,ObjectID, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount FROM #TempAP3105 WHERE DebitAccountID LIKE ''154%'' OR DebitAccountID LIKE ''242%'' OR DebitAccountID LIKE ''133%'' '+CASE WHEN @CustomerName = 140 /*Customer Gotec*/ THEN ' OR DebitAccountID LIKE ''153%'' ' END+'
	GROUP BY DivisionID,MaDA, MaHD,ObjectID
	UNION ALL	
   	SELECT DivisionID,MaDA, MaHD,ObjectID, -ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount FROM #TempAP3105 WHERE DebitAccountID LIKE ''331%'' AND (CreditAccountID LIKE ''154%'' OR CreditAccountID LIKE ''242%'' OR CreditAccountID LIKE ''133%'' '+CASE WHEN @CustomerName = 140 /*Customer Gotec*/ THEN ' OR CreditAccountID LIKE ''711%'' ' END+')
	GROUP BY DivisionID,MaDA, MaHD,ObjectID
) A GROUP BY DivisionID,MaDA, MaHD,ObjectID


SELECT ISNULL((A90.'+@sSQL2+' +'' - '' + A11.AnaName),''-'') AS Name,A02.ObjectName,ContractName AS ContractNo,Description AS ContractName,Category AS Description,Amount,
ISNULL((SELECT ISNULL(ConvertedAmount, 0) FROM #Amount07 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID),0) PaymentAmount,
ISNULL((SELECT ISNULL(ConvertedAmount, 0) FROM #Amount08 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID),0) InvoiceAmount,
--ISNULL((SELECT ISNULL(SUM(ConvertedAmount), 0) FROM #TempAP3105 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID AND TransactionTypeID In (''T03'',''T13'')),0) SettlementAmount,
ISNULL((SELECT ISNULL(ConvertedAmount, 0) FROM #Amount08 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID),0) SettlementAmount,
ISNULL(PaidBalance,0) AS PaidBalance

FROM AT9000 A90 WITH (NOLOCK)
LEFT JOIN AT1202  A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A90.ObjectID
LEFT JOIN AT0005  A05 WITH (NOLOCK) ON A05.DivisionID = A90.DivisionID AND  A05.TypeID = '''+@GroupAna+'''
INNER JOIN AT1020 WITH (NOLOCK) ON AT1020.DivisionID = A90.DivisionID AND AT1020.ContractNo = A90.'+@sSQL1+'
LEFT JOIN AT1021 WITH (NOLOCK) ON AT1021.DivisionID = AT1020.DivisionID AND AT1021.ContractID = AT1020.ContractID
INNER JOIN At1011 A11 WITH (NOLOCK) ON A11.DivisionID = A90.DivisionID AND A11.AnaTypeID = A05.TypeID and A11.AnaID = A90.'+@sSQL2+'
WHERE A90.DivisionID = '''+@DivisionID+'''
'+@sqlWhere1+'
AND CONVERT(DATETIME,CONVERT(VARCHAR(10),A90.VoucherDate,101),101) <= '''+CONVERT(NVARCHAR(10), @FromDate ,101)+'''
GROUP BY A90.DivisionID,A90.'+@sSQL2+',A90.'+@sSQL1+', A11.AnaName,A90.ObjectID,A02.ObjectName,ContractNo,ContractName,Description,Amount, Category, PaidBalance
'
IF @IsPrint <> 1 
SET @sqlUnionAll = N'
UNION ALL
SELECT '''' AS Name, ''''  ObjectName,'''' ContractNo,'''' ContractName,'''' Description, 0 Amount,
0 PaymentAmount,
0 InvoiceAmount,
0 SettlementAmount,
0 AS PaidBalance
'

END
ELSE
BEGIN
   SET @sSQL = N'
SELECT A90.DivisionID,A90.'+@sSQL2+' AS MaDA, A90.'+@sSQL1+' MaHD,A90.ObjectID,A90.InventoryID,  A90.ConvertedAmount, A90.CreditAccountID, A90.DebitAccountID, A90.TransactionTypeID
 INTO #TempAP3105 FROM AT9000 A90 WITH (NOLOCK)
LEFT JOIN AT1202  A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A90.ObjectID
INNER JOIN AT1020 WITH (NOLOCK) ON AT1020.DivisionID = A90.DivisionID AND AT1020.ContractNo = A90.'+@sSQL1+'
WHERE A90.DivisionID = '''+@DivisionID+'''
AND CONVERT(DATETIME,CONVERT(VARCHAR(10),A90.VoucherDate,101),101) <= '''+CONVERT(NVARCHAR(10), @FromDate ,101)+''' 
SELECT DivisionID,MaDA, MaHD,ObjectID, SUM(ConvertedAmount) AS ConvertedAmount 
INTO #Amount16
FROM (
	-- DebitAccountID 131
	SELECT DivisionID,MaDA, MaHD,ObjectID, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount FROM #TempAP3105 WHERE DebitAccountID LIKE ''131%'' 
	GROUP BY DivisionID,MaDA, MaHD,ObjectID
	UNION ALL	
	-- Debit 111,112
	SELECT DivisionID,MaDA, MaHD,ObjectID, -ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount FROM #TempAP3105 WHERE (DebitAccountID LIKE ''111%'' OR DebitAccountID LIKE ''112%'' )
	GROUP BY DivisionID,MaDA, MaHD,ObjectID
) A GROUP BY DivisionID,MaDA, MaHD,ObjectID

-- Credit 131
SELECT DivisionID,MaDA, MaHD,ObjectID, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount INTO #Amount17 FROM #TempAP3105 WHERE CreditAccountID LIKE ''131%'' 
GROUP BY DivisionID,MaDA, MaHD,ObjectID

-- DebitAccountID 131
SELECT DivisionID,MaDA, MaHD,ObjectID, ISNULL(SUM(ConvertedAmount), 0) AS ConvertedAmount INTO #Amount18 FROM #TempAP3105 WHERE DebitAccountID LIKE ''131%'' 
GROUP BY DivisionID,MaDA, MaHD,ObjectID


SELECT ISNULL((A90.'+@sSQL2+' +'' - '' + AT1011.AnaName), ''-'') AS Name,A02.ObjectName,A06.AnaID AS InventoryID,
ContractName AS ContractNo,ContractName,
Amount AS Amount05,
ISNULL(AT1011.Amount01 ,0) AS CAmount01, ISNULL(AT1011.Amount02 ,0) AS CAmount02, ISNULL(AT1011.Amount03  ,0) AS CAmount03, ISNULL(AT1011.Amount04 ,0) AS CAmount04, ISNULL(AT1011.Amount05 ,0) AS CAmount05,
ISNULL(AT1011.Amount06  ,0) AS CAmount06, ISNULL(AT1011.Amount07 ,0) AS CAmount07, ISNULL(AT1011.Amount08  ,0) AS CAmount08, ISNULL(AT1011.Amount09  ,0) AS CAmount09, ISNULL(AT1011.Amount10 ,0) AS CAmount10,
ISNULL((SELECT ISNULL(ConvertedAmount, 0) FROM #Amount16 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID),0) Amount16,
ISNULL((SELECT ISNULL(ConvertedAmount, 0) FROM #Amount17 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID),0) Amount17,
ISNULL((SELECT ISNULL(ConvertedAmount, 0) FROM #Amount18 WHERE DivisionID = A90.DivisionID AND MaDA = A90.'+@sSQL2+' AND MaHD = A90.'+@sSQL1+' AND ObjectID = A90.ObjectID),0) Amount18,
ISNULL(AT1021.PaidBalance,0) AS PaidBalance
FROM AT9000 A90 WITH (NOLOCK)
LEFT JOIN AT1202  A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A90.ObjectID
LEFT JOIN AT0005  A05 WITH (NOLOCK) ON A05.DivisionID = A90.DivisionID AND  A05.TypeID = '''+@GroupAna+'''
INNER JOIN AT1020 WITH (NOLOCK) ON AT1020.DivisionID = A90.DivisionID AND AT1020.ContractNo = A90.'+@sSQL1+'
LEFT JOIN AT1021 WITH (NOLOCK) ON AT1021.DivisionID = AT1020.DivisionID AND AT1021.ContractID = AT1020.ContractID
INNER JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = A90.DivisionID AND AT1011.AnaID = A90.'+@sSQL1+' AND AT1011.AnaTypeID ='''+@AnaID+'''
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON AT1011.DivisionID = A90.DivisionID AND A06.AnaID = A90.Ana06ID AND A06.AnaTypeID =''A06''

WHERE A90.DivisionID = '''+@DivisionID+''' --AND ISNULL(A90.InventoryID ,'''') <> ''''
AND CONVERT(DATETIME,CONVERT(VARCHAR(10),A90.VoucherDate,101),101) <= '''+CONVERT(NVARCHAR(10), @FromDate ,101)+''' 
AND A90.TransactionTypeID NOT IN (''T13'',''T14'',''T33'',''T34'',''T35'',''T43'',''T44'',''T94'',''T95'',''T96'',''T97'')
'+@sqlWhere1+''
SET @sqlGroupBy = '
GROUP BY A90.DivisionID,A90.'+@sSQL2+',A90.'+@sSQL1+', AT1011.AnaName,A90.ObjectID,A02.ObjectName, A06.AnaID,--A90.InventoryID,
ContractNo,ContractName,Amount,
AT1011.Amount01,
AT1011.Amount02,
AT1011.Amount03,
AT1011.Amount04,
AT1011.Amount05,
AT1011.Amount06,
AT1011.Amount07,
AT1011.Amount08,
AT1011.Amount09,
AT1011.Amount10,
AT1021.PaidBalance
'
IF @IsPrint <> 1 
SET @sqlUnionAll = N'
UNION ALL

SELECT '''' AS Name, ''''  ObjectName, '''' InventoryID,'''' ContractNo,'''' ContractName,
0 Amount05,
0 CAmount01,
0 CAmount02,
0 CAmount03,
0 CAmount04,
0 CAmount05,
0 CAmount06,
0 CAmount07,
0 CAmount08,
0 CAmount09,
0 CAmount10,
0 Amount16,
0 Amount17,
0 Amount18,
0 PaidBalance
   '

END

EXEC (@sSQL + @sqlGroupBy + @sqlUnionAll)
--PRINT(@sSQL)
--PRINT @sqlGroupBy
--PRINT @sqlUnionAll






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
