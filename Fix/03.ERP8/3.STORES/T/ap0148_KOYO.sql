IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0148_KOYO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0148_KOYO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- AP0148
-- <Summary>
---- Stored đổ nguồn màn hình danh mục hóa đơn điện tử
---- Created on 16/08/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 08/03/2021 by Huỳnh Thử
---- Modified on 08/06/2022 by Nhật Thanh: Kiểm tra ISNULL
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

---- EXEC AP0148 @DivisionID = 'SC',@UserID='ASOFTADMIN',@FromDate='2017-10-01 00:00:00',@ToDate='2017-10-31 00:00:00',@ObjectID='%',@InvoiceCode='01GTKT',@Mode=0, @Serial = '%'

CREATE PROCEDURE [dbo].[AP0148_KOYO]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@FromDate AS DATETIME,	
	@ToDate AS DATETIME,		
	@ObjectID AS NVARCHAR(50),	
	@InvoiceCode AS NVARCHAR(50),
	@Mode AS TINYINT, --0:Tab chưa phát hành, 2: Tab đã phát hành,
	@Serial AS NVARCHAR(250)
AS
		
DECLARE @sSQL AS NVARCHAR(MAX) = '', @sSQL1 AS NVARCHAR(MAX) = '', @CustomerName as int

SET @CustomerName = (SELECT Customername FROM CustomerIndex)
IF @Mode = 0
BEGIN
	SET @sSQL = N'     
	SELECT * FROM (
		SELECT TOP 100 PERCENT CONVERT(bit,0) AS Choose, AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
		(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')) AS VATConvertedAmount, 
		SUM(ConvertedAmount) AS ConvertedAmount, (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'')) AS AfterConvertedAmount,
		BDescription AS Description,
		CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
			 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID,
		AT9000.InvoiceNo, 1 AS Status, AT9000.InvoiceDate, AT9000.InvoiceGuid,	  	
		AT9000.BranchID,
		CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND AT9000.IsEInvoice = 1
		AND ISNULL(AT9000.EInvoiceStatus, 0) = 0
		AND ISNULL(AT9000.EInvoiceType, 0) = 0
		AND ISNULL(AT9000.ObjectID,'''') LIKE ''' + @ObjectID + '''
		AND ISNULL(InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
		AND ISNULL(Serial,'''') LIKE '''+@Serial+'''
		AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.Serial, AT9000.InvoiceCode, 
		AT9000.InvoiceSign, AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT9000.TransactionTypeID, AT9000.InvoiceNo, 
		AT9000.InvoiceDate, AT9000.InvoiceGuid,
		AT9000.BranchID, AT9000.TableID
		--ORDER BY AT9000.VoucherDate DESC

		UNION ALL

		SELECT  TOP 100 PERCENT CONVERT(bit,0) AS Choose, AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
		0 AS VATConvertedAmount, SUM(ConvertedAmount) AS ConvertedAmount, SUM(ConvertedAmount) AS AfterConvertedAmount,
		BDescription AS Description,
		CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
			 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID,
		AT9000.InvoiceNo, 1 AS Status, AT9000.InvoiceDate, AT9000.InvoiceGuid,
		AT9000.BranchID,
		CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND AT9000.TransactionTypeID IN (''T64'')
		AND NOT EXISTS (SELECT TOP 1 1 FROM AT9000 A1 WITH (NOLOCK) WHERE A1.VoucherID = AT9000.VoucherID AND A1.TransactionTypeID in (''T04'',''T14'',''T24'',''T34'',''T25'',''T35''))
		AND AT9000.IsEInvoice = 1
		AND ISNULL(AT9000.EInvoiceStatus, 0) = 0
		AND ISNULL(AT9000.EInvoiceType, 0) = 0
		AND AT9000.ObjectID LIKE ''' + @ObjectID + '''
		AND InvoiceCode LIKE ''' + @InvoiceCode + '''
		AND Serial LIKE '''+@Serial+'''
		AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.Serial, AT9000.InvoiceCode, 
		AT9000.InvoiceSign, AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT9000.TransactionTypeID, AT9000.InvoiceNo, 
		AT9000.InvoiceDate, AT9000.InvoiceGuid,
		AT9000.BranchID, AT9000.TableID 
		
	'
	SET @sSQL1 = N' 	
		UNION ALL
	
		SELECT TOP 100 PERCENT CONVERT(bit,0) AS Choose, NULL AS Fkey, A35.DivisionID, A35.AT9000VoucherNo, A35.VoucherDate, A35.VoucherTypeID, A35.VoucherID, A35.AT9000VoucherID, A35.Serial,
		A35.InvoiceCode, A35.InvoiceSign, A35.ObjectID, A02.ObjectName, A35.CurrencyID, A35.VATConvertedAmount, SUM(A90.ConvertedAmount) AS ConvertedAmount, 
		(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = A35.DivisionID AND AT90.VoucherID = A35.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'',''T64'')) AS AfterConvertedAmount,
		A90.BDescription AS Description,
		CASE WHEN A90.TransactionTypeID = ''T04'' THEN 1
			 WHEN A90.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID ,
		A35.InvoiceNo, 1 AS Status, A35.InvoiceDate, A35.InvoiceGuid,
		A35.BranchID,
		CASE WHEN A90.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]
		FROM AT1035 A35 WITH (NOLOCK) INNER JOIN AT9000 A90 WITH (NOLOCK) ON A35.VoucherID = A90.VoucherID AND A90.TransactionTypeID IN (''T04'',''T25'',''T24'') 
									AND A90.EInvoiceStatus = 1 AND A90.IsEInvoice = 1
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A35.ObjectID
		WHERE A35.DivisionID = ''' + @DivisionID + '''
			AND A35.InvoiceNo=''00000000''
			AND ISNULL(A90.ObjectID,'''') LIKE ''' + @ObjectID + '''
		AND ISNULL(A90.Serial,'''') LIKE '''+@Serial+'''
			AND A35.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY A35.DivisionID, A35.AT9000VoucherNo, A35.VoucherDate, A35.VoucherTypeID, A35.VoucherID, A35.AT9000VoucherID, A35.Serial,A35.InvoiceCode, A35.InvoiceSign, A35.ObjectID, A02.ObjectName, A35.CurrencyID, A35.VATConvertedAmount, 
		A90.BDescription, A90.TransactionTypeID, A35.InvoiceNo, 
		A35.InvoiceDate, A35.InvoiceGuid, A35.BranchID, 
		A90.TableID
		--ORDER BY A35.VoucherDate DESC
	) X
	ORDER BY '+CASE WHEN @CustomerName = 61 THEN ' X.InvoiceDate, X.InvoiceNo, X.VoucherNo' ELSE ' X.VoucherDate DESC' END  +''  	
END
ELSE
BEGIN
	SET @sSQL = N'  
	SELECT * FROM (   
		SELECT  TOP 100 PERCENT AT9000.Fkey, AT35A.VoucherID, AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
		(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')) AS VATConvertedAmount, 
		SUM(ConvertedAmount) AS ConvertedAmount, (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'')) AS AfterConvertedAmount,
		AT9000.BDescription AS Description, (CASE WHEN AT35A.IsCancel = 1 THEN 3 ELSE ISNULL(AT35B.EInvoiceType, 0) END) AS EInvoiceStatus, AV0027.EInvoiceStatusName,
		CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
			 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID,
		AT35A.InvoicePublishDate, AT9000.InvoiceGuid,
		AT9000.BranchID	, 
		CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]
		FROM AT9000 WITH (NOLOCK)
		INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType = 0 AND ISNULL(AT35A.InvoiceNo,0) <> ''00000000''
		LEFT JOIN 
		(
			SELECT DivisionID, InheritVoucherID, EInvoiceType
			FROM AT1035 WITH (NOLOCK)
			WHERE IsLastEInvoice = 1
			AND EInvoiceType <> 0 
			GROUP BY DivisionID, InheritVoucherID, EInvoiceType	
		) AT35B ON AT35B.DivisionID = AT35A.DivisionID AND AT35B.InheritVoucherID = AT35A.VoucherID AND AT35B.EInvoiceType <> 0  
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		LEFT JOIN AV0027 ON AV0027.EInvoiceStatus = CASE WHEN AT35A.IsCancel = 1 THEN 3 ELSE ISNULL(AT35B.EInvoiceType, 0) END
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND AT9000.IsEInvoice = 1
		AND ISNULL(AT9000.EInvoiceStatus, 0) = 1
		AND ISNULL(AT9000.ObjectID,'''') LIKE ''' + @ObjectID + '''
		AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
		AND ISNULL(AT9000.Serial,'''') LIKE '''+@Serial+'''
		AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY AT9000.Fkey, AT35A.VoucherID, AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35B.EInvoiceType, AT35A.IsCancel, AV0027.EInvoiceStatusName, AT9000.TransactionTypeID, 
		AT35A.InvoicePublishDate, AT9000.InvoiceGuid, AT9000.BranchID,AT9000.TableID
	'

	SET @sSQL1 = N'
	  
		UNION ALL
	
		SELECT  TOP 100 PERCENT AT9000.Fkey, AT35A.VoucherID, AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
		0 AS VATConvertedAmount, SUM(ConvertedAmount) AS ConvertedAmount, SUM(ConvertedAmount) AS AfterConvertedAmount,
		AT9000.BDescription AS Description, (CASE WHEN AT35A.IsCancel = 1 THEN 3 ELSE ISNULL(AT35B.EInvoiceType, 0) END) AS EInvoiceStatus, AV0027.EInvoiceStatusName,
		CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
			 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID,
		AT35A.InvoicePublishDate, AT9000.InvoiceGuid,
		AT9000.BranchID,
		CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]	 
		FROM AT9000 WITH (NOLOCK)
		INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType = 0 AND ISNULL(AT35A.InvoiceNo,0) <> ''00000000''
		LEFT JOIN 
		(
			SELECT DivisionID, InheritVoucherID, EInvoiceType
			FROM AT1035 WITH (NOLOCK)
			WHERE IsLastEInvoice = 1
			AND EInvoiceType <> 0 
			GROUP BY DivisionID, InheritVoucherID, EInvoiceType	
		) AT35B ON AT35B.DivisionID = AT35A.DivisionID AND AT35B.InheritVoucherID = AT35A.VoucherID AND AT35B.EInvoiceType <> 0  
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		LEFT JOIN AV0027 ON AV0027.EInvoiceStatus = CASE WHEN AT35A.IsCancel = 1 THEN 3 ELSE ISNULL(AT35B.EInvoiceType, 0) END
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND AT9000.TransactionTypeID IN (''T64'')
		AND NOT EXISTS (SELECT TOP 1 1 FROM AT9000 A1 WITH (NOLOCK) WHERE A1.VoucherID = AT9000.VoucherID AND A1.TransactionTypeID in (''T04'',''T14'',''T24'',''T34'',''T25'',''T35''))
		AND AT9000.IsEInvoice = 1
		AND ISNULL(AT9000.EInvoiceStatus, 0) = 1
		AND ISNULL(AT9000.ObjectID,'''') LIKE ''' + @ObjectID + '''
		AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
		AND ISNULL(AT9000.Serial,'''') LIKE '''+@Serial+'''
		AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY AT9000.Fkey, AT35A.VoucherID, AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35B.EInvoiceType, AT35A.IsCancel, AV0027.EInvoiceStatusName, AT9000.TransactionTypeID, 
		AT35A.InvoicePublishDate, AT9000.InvoiceGuid, AT9000.BranchID, 
		AT9000.TableID
	) X 
	ORDER BY X.InvoiceDate, X.InvoiceNo, X.VoucherNo' 
	 		
END	


PRINT @sSQL
PRINT @sSQL1
EXEC (@sSQL+@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
