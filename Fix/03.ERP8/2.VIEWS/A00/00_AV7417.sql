IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7417]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7417]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[AV7417]    Script Date: 30/06/2021 ******/
 ---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

 CREATE VIEW AV7417 --Created by AP7417, fix ban đầu để chạy tools
 AS  
		SELECT 		'' AS DivisionID,
					AV4202.ObjectID,
					AV4202.AccountID, 		
					'%' AS CurrencyIDCN,
					AT1202.ObjectName AS ObjectName,
					AT1005.AccountName AS AccountName,
					SUM(ISNULL(AV4202.OriginalAmountCN,0)) AS OpeningOriginalAmount,
					Sum(ConvertedAmount) AS OpeningConvertedAmount--,
					--Sum(OriginalAmount) AS OpeningOriginalAmount,NULL Ana01ID,NULL Ana02ID,NULL Ana03ID,NULL Ana04ID,NULL Ana05ID, NULL Ana06ID, NULL Ana07ID, NULL Ana08ID, NULL Ana09ID, NULL Ana10ID 
		FROM		AV4202	 
		INNER JOIN	AT1202  WITH (NOLOCK) 
			ON		AT1202.DivisionID IN (AV4202.DivisionID, '@@@') AND AT1202.ObjectID = AV4202.ObjectID
		INNER JOIN	AT1005  WITH (NOLOCK) 
			ON		AT1005.AccountID = AV4202.AccountID
		WHERE		 AV4202.DivisionID LIKE '%' AND
					(AV4202.TranMonth + 100 * AV4202.TranYear <     202105 or (AV4202.TranMonth + 100 * AV4202.TranYear =     202105 AND AV4202.TransactionTypeID ='')) AND
					(AV4202.ObjectID BETWEEN '' AND '') AND
					AV4202.CurrencyIDCN like '%'	AND 1=1 AND (AV4202.AccountID BETWEEN  '' AND '') GROUP BY AV4202.ObjectID, AV4202.AccountID, AT1202.ObjectName, AT1005.AccountName 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
