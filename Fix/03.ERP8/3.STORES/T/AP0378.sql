IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0378]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0378]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Do nguon luoi hoa don ban hang sau khi ke thua DebitNote tra ve
-- <Param>
----
-- <Return>
---- 
-- <Reference> ASOFT-T/
---- Ban hang/ Hoa don ban hang/Ke thua DebitNote (Customize Panalpina - CustomerIndex = 83)
-- <History>
---- Create on 20/09/2017 by Trương Ngọc Phương Thảo
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- EXEC AP0378 'EM','ASOFTADMIN','DK/01/2017/0004'

CREATE PROCEDURE AP0378
(
	@DivisionID varchar(50),
	@UserID varchar(50),			
	@StrTransactionID varchar(8000)
)
AS
SET NOCOUNT ON

DECLARE @sSQL01 NVarchar(4000),
		@sSQL11 Varchar(8000),
        @sSQL02 NVarchar(4000),
		@sSQL03 NVarchar(4000),
		@BaseCurrencyID Varchar(20),
		@ConvertedDecimal Int 

SET @StrTransactionID = 	REPLACE(@StrTransactionID, ',', ''',''')

SELECT  @BaseCurrencyID = ISNULL(BaseCurrencyID,'VND'),
		@ConvertedDecimal = ISNULL(ConvertedDecimals,0)
FROM AT1101
WHERE DivisionID = @DivisionID


SET @sSQL01 = 
N'
SELECT	T1.InvoiceDate, T1.CustomerID AS ObjectID, ISNULL(T4.ObjectName,T1.CustomerName) AS ObjectName, 
		Convert(Varchar(2000),'''') AS VDescription,  Convert(Varchar(2000),'''') AS BDescription, Convert(Varchar(2000),'''') AS TDescription,
		'''+@BaseCurrencyID+''' AS CurrencyID, 1 AS ExchangeRate, ISNULL(T4.VATNo,'''') AS TaxCode, Convert(Varchar(50),'''') AS VATTypeID, Convert(Decimal(28,8),0) AS VATOriginalAmount, 
		Convert(Decimal(28,8),0) AS VATConvertedAmount, T1.TaxCode AS VATType,
		T1.ChargeLineID AS InventoryID, T2.UnitID, ISNULL(T2.InventoryName,T1.ChargeLineName) AS InventoryName, 1 AS Quantity, T1.Amount_Local AS UnitPrice, 
		ROUND(T1.Amount_Local,T3.ConvertedDecimals) AS OriginalAmount, 
		ROUND(T1.Amount_Local,T3.ConvertedDecimals) AS ConvertedAmount,
		T1.TransactionID, HAWBNumber, AWBNumber, PACustomerRef, TrafficType, InvoiceNote, 
		Convert(Varchar(2000),'''') AS StrHAWBNumber, Convert(Varchar(2000),'''') AS StrAWBNumber, Convert(Varchar(2000),'''') AS StrPACustomerRef,
		Convert(Decimal(28,8),0) AS TotalAmount, ''1311'' AS DebitAccountID, ''5111'' AS CreditAccountID, T1.ReMark
INTO #AP0378_AT0300
FROM AT0300 T1
LEFT JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ChargeLineID = T2.InventoryID
LEFT JOIN AT1101 T3 ON T1.HouseID = T3.DivisionID
LEFT JOIN AT1202 T4 ON T4.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T1.CustomerID = T4.ObjectID
'

SET @sSQL11 = '
WHERE T1.HouseID = '''+@DivisionID+''' AND Convert(Varchar(50),T1.TransactionID) in (N''' + @StrTransactionID + ''') 
AND T1.Status = 0 
ORDER BY T1.InvoiceDate, T1.InvoiceNote, T1.ChargeLineID
'

SET @sSQL02 = N'

UPDATE #AP0378_AT0300
SET #AP0378_AT0300.TrafficType = T2.TrafficType
FROM 
(SELECT MAX(TrafficType) AS TrafficType FROM #AP0378_AT0300) T2

UPDATE #AP0378_AT0300 
SET	#AP0378_AT0300.VDescription = #AP0378_AT0300.TrafficType+''/''+T2.StrInvoiceNote
FROM 
(
	SELECT	SUBSTRING(
						( SELECT InvoiceNote + ''+ ''
						FROM
						(SELECT DISTINCT InvoiceNote
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						--WHERE A.TransactionID = B.TransactionID 
						) A
						ORDER BY  A.InvoiceNote
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT InvoiceNote + ''+ ''
						FROM
						(SELECT DISTINCT InvoiceNote
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						--WHERE  A.TransactionID = B.TransactionID 
						) A
						ORDER BY  A.InvoiceNote
								FOR XML PATH ('''')
								)) - 1
					) AS StrInvoiceNote
	FROM	#AP0378_AT0300 B WITH (NOLOCK)	
) T2

UPDATE #AP0378_AT0300 
SET	#AP0378_AT0300.StrHAWBNumber = T2.StrHAWBNumber
FROM 
(
	SELECT	SUBSTRING(
						( SELECT HAWBNumber + ''+ ''
						FROM
						(SELECT DISTINCT HAWBNumber
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						WHERE HAWBNumber NOT IN (''#'',''Result'') 
						-- AND A.TransactionID = B.TransactionID 
						) A
						ORDER BY  A.HAWBNumber
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT HAWBNumber + ''+ ''
						FROM
						(SELECT DISTINCT HAWBNumber
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						WHERE  HAWBNumber NOT IN (''#'',''Result'')
						-- AND A.TransactionID = B.TransactionID 
						
						) A
						ORDER BY  A.HAWBNumber
								FOR XML PATH ('''')
								)) - 1
					) AS StrHAWBNumber
	FROM	#AP0378_AT0300 B WITH (NOLOCK)	
) T2


UPDATE #AP0378_AT0300 
SET	#AP0378_AT0300.StrAWBNumber = T2.StrAWBNumber
FROM 
(
	SELECT	SUBSTRING(
						( SELECT AWBNumber + ''+ ''
						FROM
						(SELECT DISTINCT AWBNumber
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						WHERE AWBNumber NOT IN (''#'',''Result'') 
						--AND A.TransactionID = B.TransactionID 						
						) A
						ORDER BY  A.AWBNumber
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT AWBNumber + ''+ ''
						FROM
						(SELECT DISTINCT AWBNumber
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						WHERE  AWBNumber NOT IN (''#'',''Result'') 
						--AND A.TransactionID = B.TransactionID
						) A
						ORDER BY  A.AWBNumber
								FOR XML PATH ('''')
								)) - 1
					) AS StrAWBNumber
	FROM	#AP0378_AT0300 B WITH (NOLOCK)	
) T2 
'

SET @sSQL03 = N'

UPDATE #AP0378_AT0300 
SET	#AP0378_AT0300.StrPACustomerRef = T2.StrPACustomerRef
FROM 
(
	SELECT	SUBSTRING(
						( SELECT PACustomerRef + ''+ ''
						FROM
						(SELECT DISTINCT PACustomerRef
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						WHERE PACustomerRef NOT IN (''#'',''Result'') 
						--AND A.TransactionID = B.TransactionID 
						) A
						ORDER BY  A.PACustomerRef
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT PACustomerRef + ''+ ''
						FROM
						(SELECT DISTINCT PACustomerRef
						FROM #AP0378_AT0300 A WITH (NOLOCK)
						WHERE  PACustomerRef NOT IN (''#'',''Result'')
						-- AND A.TransactionID = B.TransactionID 
						) A
						ORDER BY  A.PACustomerRef
								FOR XML PATH ('''')
								)) - 1
					) AS StrPACustomerRef
	FROM	#AP0378_AT0300 B WITH (NOLOCK)	
) T2 

UPDATE #AP0378_AT0300
SET #AP0378_AT0300.BDescription = CASE WHEN ISNULL(StrHAWBNumber,'''')  = '''' 
									THEN StrPACustomerRef ELSE 
										CASE WHEN ISNULL(StrPACustomerRef,'''')  = '''' THEN StrHAWBNumber 
									ELSE StrHAWBNumber +'' / ''+ StrPACustomerRef END 
								  END
WHERE TrafficType = ''AIR'' 

UPDATE #AP0378_AT0300
SET #AP0378_AT0300.BDescription = CASE WHEN ISNULL(StrAWBNumber,'''')  = '''' 
									THEN StrPACustomerRef ELSE 
										CASE WHEN ISNULL(StrPACustomerRef,'''')  = '''' THEN StrAWBNumber
									ELSE StrAWBNumber +'' / ''+ StrPACustomerRef END 
								  END
WHERE TrafficType = ''SEA'' 

UPDATE #AP0378_AT0300
SET #AP0378_AT0300.TDescription = CASE WHEN (ISNULL(HAWBNumber,'''')  = '''' OR ISNULL(HAWBNumber,'''') in (''#'',''Result''))
									THEN PACustomerRef ELSE 
										CASE WHEN (ISNULL(PACustomerRef,'''')  = '''' OR ISNULL(PACustomerRef,'''') in (''#'',''Result'')) THEN HAWBNumber 
									ELSE HAWBNumber +'' / ''+ PACustomerRef END 
								  END
WHERE TrafficType = ''AIR'' 

UPDATE #AP0378_AT0300
SET #AP0378_AT0300.TDescription = CASE WHEN (ISNULL(AWBNumber,'''')  = '''' OR ISNULL(AWBNumber,'''') in (''#'',''Result'')) 
									THEN PACustomerRef ELSE 
										CASE WHEN (ISNULL(PACustomerRef,'''')  = '''' OR ISNULL(PACustomerRef,'''') in (''#'',''Result''))  THEN AWBNumber
									ELSE AWBNumber +'' / ''+ PACustomerRef END 
								  END
WHERE TrafficType = ''SEA'' 


UPDATE #AP0378_AT0300
SET #AP0378_AT0300.VATType = T2.VATType
FROM 
(SELECT MAX(VATType) AS VATType FROM #AP0378_AT0300) T2

UPDATE #AP0378_AT0300
SET VATTypeID = CASE VATType WHEN ''2'' THEN ''T10'' WHEN ''3'' THEN ''T00'' ELSE ''TS0'' END

UPDATE #AP0378_AT0300
SET #AP0378_AT0300.TotalAmount = T2.OriginalAmount
FROM (SELECT Sum(OriginalAmount) AS OriginalAmount FROM #AP0378_AT0300 ) T2

UPDATE #AP0378_AT0300
SET VATOriginalAmount =  CASE VATType WHEN ''2'' THEN Round(TotalAmount*0.1,'+STR(@ConvertedDecimal)+') ELSE 0 END,
	VATConvertedAmount =  CASE VATType WHEN ''2'' THEN Round(TotalAmount*0.1,'+STR(@ConvertedDecimal)+') ELSE 0 END

SELECT * FROM #AP0378_AT0300 ORDER BY InvoiceDate, InvoiceNote, InventoryID
'
--Print @sSQL01
--Print @sSQL02
--Print @sSQL03

EXEC (@sSQL01+@sSQL11+@sSQL02+@sSQL03)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
