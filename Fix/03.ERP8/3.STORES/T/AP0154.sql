IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0154]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0154]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- AP0154
-- <Summary>
---- Stored load màn hình danh mục hóa đơn điện tử hủy bỏ
---- Created on 23/08/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 21/02/2019 by Kim Thư on Cho hiện hóa đơn chiết khấu ở cả 2 tab (T64)
---- Modified on 25/03/2019 by Kim Thư on Bổ sung cột BranchID (chi nhánh phát hành)
---- Modified on 01/07/2019 by Kim Thư: Sửa hiển thị hóa đơn chiết khấu. Nếu Hóa đơn có nhiều dòng, trong đó có dòng chiết khấu thì ko hiện dòng chiết khấu.
----									Nếu Hóa đơn chỉ có dòng chiết khấu (ko có T04, T14, T24, T34, T25, T35) thì cho hiện.
---- Modified on 20/03/2020 by Văn Minh: Bổ sung thêm trường hợp hóa đơn gốc bị điều chỉnh.
---- Modified on 21/10/2020 by Hoài Phong: bổ sung cột để phân biệt HDBH theo bộ [Types]
---- Modified on 08/12/2020 by Đức Thông: (FEIYUEH) Sắp xếp danh sách theo ngày hóa đơn -> Số hóa đơn ->  số chứng từ
---- Modified on 21/05/2021 by Xuân Nguyên: 2021/05/IS/0066 - Fix lỗi Hóa đơn thành tiền bị sai ( chưa trừ chiết khấu)
---- Modified on 21/01/2022 by Xuân Nguyên: [2022/01/IS/0182] - Bổ sung ISNULL cho điều kiện InvoiceCode
---- Modified on 18/03/2022 by Xuân Nguyên : Bổ sung cột CancelReason (Lý do hủy)
---- Modified on 18/03/2022 by Xuân Nguyên : Gán lại tên bảng cho cột CancelReason (Lý do hủy)
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- EXEC AP0154 @DivisionID = 'SC',@UserID='ASOFTADMIN', @FromDate = '', @ToDate = '', @ObjectID = '', @InvoiceCode = '', @Mode = 0

CREATE PROCEDURE [dbo].[AP0154]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@FromDate AS DATETIME,	
	@ToDate AS DATETIME,		
	@ObjectID AS NVARCHAR(50),	
	@InvoiceCode AS NVARCHAR(50),
	@Mode AS TINYINT --0:Tab chưa phát hành, 1: Tab đã phát hành	
AS
	
		
DECLARE @sSQL1 AS NVARCHAR(MAX) = '',
		@sSQL2 AS NVARCHAR(MAX) = '',
		@sSQL3 AS NVARCHAR(MAX) = '',
		@sSQL4 AS NVARCHAR(MAX) = '',
		@sSQL5 AS NVARCHAR(MAX) = '',
		@sSQL6 AS NVARCHAR(MAX) = ''


IF @Mode = 0
BEGIN
	SET @sSQL1 = N'	
		-- Hóa đơn gốc chưa bị thay thế, điều chỉnh
		SELECT  TOP 100 PERCENT AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
		(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')) AS VATConvertedAmount, 
		CASE WHEN EXISTS ( select Top 1 1 from AT9000 AT90 where TransactionTypeID = ''T64'' and AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID  )Then SUM(ConvertedAmount)-(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')) 
			ELSE SUM(ConvertedAmount) End AS AfterConvertedAmount,
		CASE WHEN EXISTS ( select Top 1 1 from AT9000 AT90 where TransactionTypeID = ''T64'' and AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID  ) THEN (SELECT SUM(ConvertedAmount)  - (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64''))FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'') )
			 ELSE  (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'') ) END AS ConvertedAmount, 
		AT9000.BDescription AS Description, AT35A.EInvoiceType, AV0028.EInvoiceTypeName,
		CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
			 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID, AT9000.CreateUserID, AT35A.BranchID,
			 CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]  	
		,AT9000.CancelReason  	 
		FROM AT9000 WITH (NOLOCK)
		INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType = 0 AND ISNULL(AT35A.IsCancel, 0) = 0
		LEFT JOIN AT1035 AT35B WITH (NOLOCK) ON AT35B.DivisionID = AT35A.DivisionID AND AT35B.InheritVoucherID = AT35A.VoucherID AND AT35B.EInvoiceType IN (1,2) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		LEFT JOIN AV0028 ON AV0028.EInvoiceType = AT35A.EInvoiceType	
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND AT9000.IsEInvoice = 1
		AND AT9000.EInvoiceStatus = 1
		AND AT35B.DivisionID IS NULL 
		AND AT9000.ObjectID LIKE ''' + @ObjectID + '''
		AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
		AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35A.EInvoiceType, AV0028.EInvoiceTypeName, AT9000.TransactionTypeID, AT9000.CreateUserID, AT35A.BranchID,AT9000.TableID,AT9000.CancelReason '
	
	SET @sSQL2 = N'	
		-- Hóa đơn chiết khấu gốc chưa bị thay thế, điều chỉnh
		UNION ALL
		SELECT  TOP 100 PERCENT AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
		0 AS VATConvertedAmount, SUM(ConvertedAmount) AS ConvertedAmount, SUM(ConvertedAmount) AS AfterConvertedAmount,
		AT9000.BDescription AS Description, AT35A.EInvoiceType, AV0028.EInvoiceTypeName,
		CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
			 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID, AT9000.CreateUserID, AT35A.BranchID,
			 CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]  ,AT9000.CancelReason	 
		FROM AT9000 WITH (NOLOCK)
		INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType = 0 AND ISNULL(AT35A.IsCancel, 0) = 0
		LEFT JOIN AT1035 AT35B WITH (NOLOCK) ON AT35B.DivisionID = AT35A.DivisionID AND AT35B.InheritVoucherID = AT35A.VoucherID AND AT35B.EInvoiceType IN (1,2) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		LEFT JOIN AV0028 ON AV0028.EInvoiceType = AT35A.EInvoiceType	
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND AT9000.TransactionTypeID IN (''T64'')
		AND NOT EXISTS (SELECT TOP 1 1 FROM AT9000 A1 WITH (NOLOCK) WHERE A1.VoucherID = AT9000.VoucherID AND A1.TransactionTypeID in (''T04'',''T14'',''T24'',''T34'',''T25'',''T35''))
		AND AT9000.IsEInvoice = 1
		AND AT9000.EInvoiceStatus = 1
		AND AT35B.DivisionID IS NULL 
		AND AT9000.ObjectID LIKE ''' + @ObjectID + '''
		AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
		AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
		GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
		AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35A.EInvoiceType, AV0028.EInvoiceTypeName, AT9000.TransactionTypeID, AT9000.CreateUserID, AT35A.BranchID,AT9000.TableID,AT9000.CancelReason
	'

	SET @sSQL3 = '		
		-- Hóa đơn gốc thay thế, điều chỉnh sau cùng
		UNION ALL
		SELECT * FROM (
			SELECT  TOP 100 PERCENT AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
			AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
			(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')) AS VATConvertedAmount, 
		CASE WHEN EXISTS ( select Top 1 1 from AT9000 AT90 where TransactionTypeID = ''T64'' and AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID  )Then SUM(ConvertedAmount)-(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')) 
			ELSE SUM(ConvertedAmount) End AS AfterConvertedAmount,
		CASE WHEN EXISTS ( select Top 1 1 from AT9000 AT90 where TransactionTypeID = ''T64'' and AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID  ) THEN (SELECT SUM(ConvertedAmount)  - (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64''))FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'') )
			 ELSE  (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'') ) END AS ConvertedAmount, 
		AT9000.BDescription AS Description, AT35A.EInvoiceType, AV0028.EInvoiceTypeName,
			CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
				 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID, AT9000.CreateUserID, AT35A.BranchID,
				 CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types],AT9000.CancelReason    	 
			FROM AT9000 WITH (NOLOCK)
			INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType IN (1,2) AND ISNULL(AT35A.IsCancel, 0) = 0
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
			LEFT JOIN AV0028 ON AV0028.EInvoiceType = AT35A.EInvoiceType	
			WHERE AT9000.DivisionID = ''' + @DivisionID + '''
			AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
			AND AT9000.IsEInvoice = 1
			AND AT9000.EInvoiceStatus = 1
			AND AT35A.IsLastEInvoice = 1
			AND AT9000.ObjectID LIKE ''' + @ObjectID + '''
			AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
			AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
			GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
			AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35A.EInvoiceType, AV0028.EInvoiceTypeName, AT9000.TransactionTypeID, AT9000.CreateUserID , AT35A.BranchID,AT9000.TableID ,AT9000.CancelReason
			ORDER BY AT9000.InvoiceNo DESC
		)X'		

	SET @sSQL4 = N'
		-- Hóa đơn chiết khấu gốc thay thế, điều chỉnh sau cùng
		UNION ALL
		SELECT * FROM (
			SELECT  TOP 100 PERCENT AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
			AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
			0 AS VATConvertedAmount, SUM(ConvertedAmount) AS ConvertedAmount, SUM(ConvertedAmount) AS AfterConvertedAmount,
			AT9000.BDescription AS Description, AT35A.EInvoiceType, AV0028.EInvoiceTypeName,
			CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
				 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID, AT9000.CreateUserID, AT35A.BranchID,
				 CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]  ,AT9000.CancelReason  	 
			FROM AT9000 WITH (NOLOCK)
			INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType IN (1,2) AND ISNULL(AT35A.IsCancel, 0) = 0
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
			LEFT JOIN AV0028 ON AV0028.EInvoiceType = AT35A.EInvoiceType	
			WHERE AT9000.DivisionID = ''' + @DivisionID + '''
			AND AT9000.TransactionTypeID IN (''T64'')
			AND NOT EXISTS (SELECT TOP 1 1 FROM AT9000 A1 WITH (NOLOCK) WHERE A1.VoucherID = AT9000.VoucherID AND A1.TransactionTypeID in (''T04'',''T14'',''T24'',''T34'',''T25'',''T35''))
			AND AT9000.IsEInvoice = 1
			AND AT9000.EInvoiceStatus = 1
			AND AT35A.IsLastEInvoice = 1
			AND AT9000.ObjectID LIKE ''' + @ObjectID + '''
			AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
			AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
			GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
			AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35A.EInvoiceType, AV0028.EInvoiceTypeName, AT9000.TransactionTypeID, AT9000.CreateUserID , AT35A.BranchID,AT9000.TableID ,AT9000.CancelReason
			ORDER BY AT9000.InvoiceNo DESC	
		)Y
	'
	
	SET @sSQL5 = N'
		-- Hóa đơn gốc bị diều chỉnh
		UNION ALL

		SELECT * FROM (
			SELECT  TOP 100 PERCENT AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID AS AT9000VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
			AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID,
			(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')) AS VATConvertedAmount, 
		CASE WHEN EXISTS ( select Top 1 1 from AT9000 AT90 where TransactionTypeID = ''T64'' and AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID  )Then SUM(ConvertedAmount)-(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')) 
			ELSE SUM(ConvertedAmount) End AS AfterConvertedAmount,
		CASE WHEN EXISTS ( select Top 1 1 from AT9000 AT90 where TransactionTypeID = ''T64'' and AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID  ) THEN (SELECT SUM(ConvertedAmount)  - (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64''))FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'') )
			 ELSE  (SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'',''T14'',''T34'',''T35'') ) END AS ConvertedAmount, 
		AT9000.BDescription AS Description, AT35A.EInvoiceType, AV0028.EInvoiceTypeName,
			CASE WHEN AT9000.TransactionTypeID = ''T04'' THEN 1
				 WHEN AT9000.TransactionTypeID = ''T24'' THEN 2 ELSE 3 END AS FormTypeID, AT9000.CreateUserID, AT35A.BranchID,
				 CASE WHEN AT9000.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types] ,AT9000.CancelReason   	 
			FROM AT9000 WITH (NOLOCK)
			INNER JOIN AT1035 AT35A WITH (NOLOCK) ON AT35A.DivisionID = AT9000.DivisionID AND AT35A.AT9000VoucherID = AT9000.VoucherID AND AT35A.EInvoiceType IN (0) AND ISNULL(AT35A.IsCancel, 0) = 0
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
			LEFT JOIN AV0028 ON AV0028.EInvoiceType = AT35A.EInvoiceType	
			WHERE AT9000.DivisionID = ''' + @DivisionID + '''
			AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
			AND AT9000.IsEInvoice = 1
			AND AT9000.EInvoiceStatus = 1
			AND AT35A.IsLastEInvoice = 0
			AND AT9000.ObjectID LIKE ''' + @ObjectID + '''
			AND ISNULL(AT9000.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
			AND AT9000.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
			GROUP BY AT9000.Fkey, AT9000.DivisionID, AT9000.VoucherTypeID, AT35A.VoucherID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VoucherDate, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.Serial, AT9000.InvoiceCode, AT9000.InvoiceSign, 
			AT9000.ObjectID, AT1202.ObjectName, AT9000.CurrencyID, AT9000.BDescription, AT35A.EInvoiceType, AV0028.EInvoiceTypeName, AT9000.TransactionTypeID, AT9000.CreateUserID , AT35A.BranchID,AT9000.TableID ,AT9000.CancelReason
			ORDER BY AT9000.InvoiceNo DESC
		)Z
	'
END
ELSE
BEGIN
	SET @sSQL1 = N'
	-- Lấy hóa đơn bị hủy
	SELECT VoucherID AS AT9000VoucherID, AT9000VoucherNo AS VoucherNo, InvoiceCode, InvoiceSign, Serial, InvoiceNo, InvoiceDate, AT1035.ObjectID, AT1202.ObjectName,
	AT1035.Description, AT1035.VATConvertedAmount, 
	(SELECT SUM(ConvertedAmount) FROM AT1036 WITH (NOLOCK) WHERE AT1036.DivisionID = AT1035.DivisionID AND AT1036.VoucherID = AT1035.VoucherID) AS ConvertedAmount,
	(SELECT SUM(ConvertedAmount) FROM AT1036 WITH (NOLOCK) WHERE AT1036.DivisionID = AT1035.DivisionID AND AT1036.VoucherID = AT1035.VoucherID) + AT1035.VATConvertedAmount AS AfterConvertedAmount, 
	AT1035.CreateUserID, AT1035.CreateDate, CancelDate, AT1035.BranchID ,
	CASE WHEN AT1035.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types]  ,AT1035.CancelReason
	FROM AT1035 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT1035.ObjectID
	WHERE AT1035.DivisionID = ''' + @DivisionID + '''
	AND AT1035.ObjectID LIKE ''' + @ObjectID + '''
	AND ISNULL(AT1035.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
	AND AT1035.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
	AND AT1035.InvoiceNo <> ''0000000''		
	AND ISNULL(AT1035.IsCancel, 0) = 1'	
	
	SET @sSQL2 = N'
	-- Lấy hóa đơn đã bị thay thế
	UNION ALL	
	SELECT AT35A.VoucherID AS AT9000VoucherID, AT35A.AT9000VoucherNo AS VoucherNo, AT35A.InvoiceCode, AT35A.InvoiceSign, AT35A.Serial, AT35A.InvoiceNo, AT35A.InvoiceDate, 
	AT35A.ObjectID, AT1202.ObjectName, AT35A.Description, AT35A.VATConvertedAmount, 
	(SELECT SUM(ConvertedAmount) FROM AT1036 WITH (NOLOCK) WHERE AT1036.DivisionID = AT35A.DivisionID AND AT1036.VoucherID = AT35A.VoucherID) AS ConvertedAmount,
	(SELECT SUM(ConvertedAmount) FROM AT1036 WITH (NOLOCK) WHERE AT1036.DivisionID = AT35A.DivisionID AND AT1036.VoucherID = AT35A.VoucherID) + AT35A.VATConvertedAmount AS AfterConvertedAmount, 
	AT35A.CreateUserID, AT35A.CreateDate, AT35B.InvoiceDate AS CancelDate, AT35A.BranchID ,
	CASE WHEN AT35A.TableID = ''AT9000'' THEN N''Hóa đơn bán hàng'' ELSE N''Hóa đơn theo bộ'' END AS [Types] ,AT35A.CancelReason
	FROM AT1035 AT35A WITH (NOLOCK)
	INNER JOIN AT1035 AT35B WITH (NOLOCK) ON AT35B.DivisionID = AT35A.DivisionID AND AT35B.InheritVoucherID = AT35A.VoucherID AND AT35B.EInvoiceType = 2
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT35A.ObjectID
	WHERE AT35A.DivisionID = ''' + @DivisionID + '''
	AND AT35A.ObjectID LIKE ''' + @ObjectID + '''
	AND ISNULL(AT35A.InvoiceCode,'''') LIKE ''' + @InvoiceCode + '''
	AND AT35A.InvoiceDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
	AND AT35A.InvoiceNo <> ''0000000''	
	AND ISNULL(AT35A.IsCancel, 0) = 0
	ORDER BY CancelDate DESC'	
END	  	
SET @sSQL6 = ' ORDER BY InvoiceDate, InvoiceNo, VoucherNo'

PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
PRINT @sSQL4
PRINT @sSQL4
PRINT @sSQL5
IF @Mode = 0
	EXEC (@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5 + @sSQL6)
ELSE
	EXEC (@sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO