IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7414]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7414]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[AV7414]    Script Date: 30/06/2021 ******/
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

 CREATE VIEW AV7414 -- Được tạo từ Store AP7414, fix ban đầu để chạy tools
 AS  
		SELECT 	AV4202.ObjectID, 
			AV4202.AccountID , 
			'VND' AS CurrencyID,
			AV4202.DivisionID,
			AT1202.ObjectName,
			AT1005.AccountName, AT1005.AccountNameE,
			Sum(ConvertedAmount) AS OpeningConvertedAmount,
			Sum(OriginalAmountCN) AS OpeningOriginalAmount
			--Sum(OriginalAmount) AS OpeningOriginalAmount
		FROM AV4202 INNER JOIN AT1202 ON AT1202.DivisionID IN (AV4202.DivisionID, '@@@') AND AT1202.ObjectID = AV4202.ObjectID
				INNER JOIN AT1005 ON AT1005.AccountID = AV4202.AccountID
		WHERE  AV4202.DivisionID LIKE '' AND
			(AV4202.TranMonth + 100 * AV4202.TranYear <     202106 OR (AV4202.TranMonth + 100 * AV4202.TranYear =     202106  AND AV4202.TransactionTypeID ='T00' )) AND
			(AV4202.ObjectID BETWEEN '' AND '') AND
			(AV4202.AccountID BETWEEN '' AND '' ) AND
			AV4202.CurrencyIDCN like 'VND'	AND 1=1
		GROUP BY AV4202.ObjectID,  AV4202.AccountID ,AV4202.DivisionID,AT1202.ObjectName,AT1005.AccountName, AT1005.AccountNameE ,  AV4202.CurrencyIDCN 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
