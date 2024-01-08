IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7415]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7415]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[AV7415]    Script Date: 30/06/2021 ******/
 ---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE VIEW AV7415 -- Được tạo từ Store AP7405, fix ban đầu để chạy tools
 AS 
			SELECT (ISNULL(AV7404.ObjectID, AV7414.ObjectID) + ISNULL(AV7404.AccountID, AV7414.AccountID)) AS GroupID,
				BatchID,VoucherID,TableID, Status,AV7404.DivisionID,TranMonth,TranYear, 
				Cast(ISNULL(AV7404.AccountID, AV7414.AccountID) AS char(20)) + 
				cast(ISNULL(AV7404.ObjectID, AV7414.ObjectID)  AS char(20)) + 
				cast(ISNULL(AV7404.CurrencyID,AV7414.CurrencyID) AS char(20)) + 
				cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
				Year(VoucherDate) * 10000 AS char(8)) + 
				cast(VoucherID AS char(20)) + 
				(Case when ISNULL(RPTransactionType,'') = '' then '' ELSE '' end) AS Orders,
				RPTransactionType,TransactionTypeID,
				ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS ObjectID,  
				ISNULL(AT1202.ObjectName,AV7414.ObjectName) AS ObjectName,
				AT1202.Address, AT1202.VATNo,
				DebitAccountID, CreditAccountID, 
				ISNULL(AV7404.AccountID, AV7414.AccountID) AS AccountID,
				ISNULL(AT1005.AccountName, AV7414.AccountName) AS AccountName,
				ISNULL(AT1005.AccountNameE, AV7414.AccountNameE) AS AccountNameE,
				VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate,Serial,VDescription, 
				ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,TDescription,
				AV7404.Ana01ID,	AV7404.Ana02ID, AV7404.Ana03ID,	AV7404.Ana04ID,	AV7404.Ana05ID,
				AV7404.Ana06ID,	AV7404.Ana07ID,	AV7404.Ana08ID,	AV7404.Ana09ID,	AV7404.Ana10ID,
				ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CurrencyID,ExchangeRate,AV7404.CreateDate,
				Sum(Case When ISNULL(RPTransactionType,'') = '' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS DebitOriginalAmount,
				Sum(Case When ISNULL(RPTransactionType,'') = '' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
				Sum(Case When ISNULL(RPTransactionType,'') = '' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
				Sum(Case When ISNULL(RPTransactionType,'') = '' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
				ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount,
				ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
				sum(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,
				sum(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
				cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
				cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
				Parameter01, Parameter02,Parameter03, Parameter04,Parameter05, Parameter06,Parameter07, Parameter08,
				Parameter09, Parameter10, AV7404.OrderID as OrderNo	
		FROM	AV7404 
		LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AV7404.DivisionID, '@@@') AND AT1202.ObjectID = AV7404.ObjectID
		FULL JOIN AV7414 on AV7414.ObjectID = AV7404.ObjectID AND AV7414.AccountID = AV7404.AccountID	AND AV7414.DivisionID = AV7404.DivisionID					
		LEFT JOIN AT1005 WITH (NOLOCK)  on AT1005.AccountID = AV7404.AccountID 
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) between '' AND '') 
				and (ISNULL(AV7404.AccountID, AV7414.AccountID) between '1418' AND '1418') AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) like 'VND'  AND 1=1
		GROUP BY AV7404.DivisionID,BatchID, VoucherID, TableID, Status, AV7404.DivisionID, TranMonth, TranYear, 
				RPTransactionType, TransactionTypeID, AV7404.ObjectID, AV7414.ObjectID,
				DebitAccountID, CreditAccountID, AV7404.AccountID, AV7414.AccountID, 
				VoucherTypeID, VoucherNo, VoucherDate,AV7414.OpeningOriginalAmount, AV7414.OpeningConvertedAmount,
				InvoiceNo, InvoiceDate, Serial, VDescription,  BDescription, TDescription, 
				AV7404.Ana01ID,	AV7404.Ana02ID, AV7404.Ana03ID,	AV7404.Ana04ID,	AV7404.Ana05ID,
				AV7404.Ana06ID,	AV7404.Ana07ID,	AV7404.Ana08ID,	AV7404.Ana09ID,	AV7404.Ana10ID,
				AV7404.CreateDate,AV7404.CurrencyID, AV7414.CurrencyID, ExchangeRate, AT1202.ObjectName, 
				AT1202.Address, AT1202.VATNo, 
				AV7414.ObjectName, AT1005.AccountName, AT1005.AccountNameE, AV7414.AccountName, AV7414.AccountNameE, Duedate,
				Parameter01, Parameter02,Parameter03, Parameter04,Parameter05, Parameter06,Parameter07, Parameter08,Parameter09, Parameter10, AV7404.OrderID
			UNION ALL
			SELECT (ISNULL( AV7414.ObjectID, '') + ISNULL( AV7414.AccountID, '')) AS GroupID,
					NULL AS BatchID,NULL AS VoucherID,NULL as TableID,NULL as Status,
					AV7414.DivisionID,
					NULL AS TranMonth,NULL AS TranYear, Cast(ISNULL(AV7414.AccountID , '') AS char(20)) + 
					cast(ISNULL(AV7414.ObjectID, '')  AS char(20)) + cast(ISNULL(AV7414.CurrencyID, '') AS char(20))  AS Orders,
					NULL AS RPTransactionType,NULL AS TransactionTypeID,
					ISNULL( AV7414.ObjectID,'') AS ObjectID,  ISNULL(AV7414.ObjectName , '') AS ObjectName,
					AT1202.Address, AT1202.VATNo,NULL AS DebitAccountID, NULL AS CreditAccountID, 
					ISNULL(AV7414.AccountID, '') AS AccountID,
					ISNULL(AV7414.AccountName, '' ) AS AccountName,
					ISNULL(AV7414.AccountNameE, '' ) AS AccountNameE,
					NULL AS VoucherTypeID,
					NULL AS VoucherNo,
					CONVERT(DATETIME, NULL) AS VoucherDate,
					NULL AS InvoiceNo,
					CONVERT(DATETIME, NULL) AS InvoiceDate,
					NULL AS Serial,
					NULL AS VDescription, 
					NULL AS BDescription,
					NULL AS TDescription,
					NULL AS Ana01ID, 		
					NULL AS Ana02ID,
					NULL AS Ana03ID,
					NULL AS Ana04ID,
					NULL AS Ana05ID,
					NULL AS Ana06ID,
					NULL AS Ana07ID,
					NULL AS Ana08ID,
					NULL AS Ana09ID,
					NULL AS Ana10ID,
					AV7414.CurrencyID AS CurrencyID,
					0 AS ExchangeRate,
					CONVERT(DATETIME, NULL)CreateDate,
					0 AS DebitOriginalAmount,
					0 AS CreditOriginalAmount,
					0 AS DebitConvertedAmount,
					0 AS CreditConvertedAmount,
					ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount,
					ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
					0 AS SignConvertedAmount,
					0 AS SignOriginalAmount,
					cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
					cast(0 as decimal(28,8)) AS ClosingConvertedAmount,
					CONVERT(DATETIME, NULL) AS Duedate,
					NULL as Parameter01, NULL as Parameter02,
					NULL as Parameter03, NULL as Parameter04,
					NULL as Parameter05, NULL as Parameter06,
					NULL as Parameter07, NULL as Parameter08,
					NULL as Parameter09, NULL as Parameter10, NULL as OrderNo
			FROM	AV7414 
			LEFT JOIN AT1202 ON AT1202.DivisionID IN (AV7414.DivisionID, '@@@') AND AT1202.ObjectID = AV7414.ObjectID
			WHERE	AV7414.ObjectID + AV7414.AccountID NOT IN ( SELECT DISTINCT ObjectID+AccountID FROM AV7404 )
			

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
