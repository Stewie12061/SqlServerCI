IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0434]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0434]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin phiếu thu chi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 28/04/2022 by Kiều Nga
----Modify on  22/12/2022 by Kiều Nga : Bổ sung lấy thêm các trường mpt
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*  

 EXEC AP0434 @DivisionID = 'CBD', @ContractNo = N'A1'',''B1'',''B2', @VoucherID = '4854C969-111A-41B7-AE4D-4B76310ADCE6',@IsDate= 0, @isType = '1',@FromMonth = 12,@FromYear = 2018,@ToMonth = 12,@ToYear = 2018

 AP0434 @DivisionID, @ContractNo , @VoucherID, @isType,@FromMonth,@FromYear,@ToMonth,@ToYear

*/
----
CREATE PROCEDURE AP0434 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR (50)
)
AS

SELECT * INTO #AP0434
FROM (
	SELECT 
	AT9000.DivisionID, 
	AT9000.VoucherID, 
	AT9000.DebitAccountID AS AccountID,
	AT9000.ObjectID,
	AT1202.ObjectName, 
	AT9000.Serial,
	AT9000.InvoiceNo,
	AT9000.InvoiceDate,
	AT9000.ConvertedAmount,
	AT9000.TransactionID,
	'D' AS D_C,
	AT9000.VDescription,
	AT9000.TDescription,
	AT9000.InheritTableID,
	AT9000.InheritVoucherID,
	T2.HandOverDate,
	T4.AdministrativeExpensesDate,
	T2.SignDate,
	CASE WHEN AT9000.InheritTableID = 'AT0420' then T4.ContractNo else T2.ContractNo end as ContractNo
	,AT9000.Ana01ID,AT9000.Ana02ID,AT9000.Ana03ID,AT9000.Ana04ID,AT9000.Ana05ID,AT9000.Ana06ID
	,AT9000.Ana07ID,AT9000.Ana08ID,AT9000.Ana09ID,AT9000.Ana10ID
	FROM AT9000 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
	LEFT JOIN CT0157 T1 WITH (NOLOCK) ON T1.ContractDetailID = AT9000.InheritVoucherID
	LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T2.APK = T1.APKMaster
	LEFT JOIN AT0420 T3 WITH (NOLOCK) ON T3.APK = AT9000.InheritVoucherID
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T4.DivisionID = T3.DivisionID AND T3.ContractNo = T4.ContractNo
	WHERE AT9000.DebitAccountID IN (SELECT AccountID FROM AT0006 WHERE D_C = 'D' AND DivisionID = AT9000.DivisionID)
	AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(VoucherID + TransactionID,'') FROM AT1703 WHERE D_C = 'D' AND DivisionID = AT9000.DivisionID)
	AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(ReVoucherID + ReTransactionID,'') FROM AT1603 WHERE DivisionID = AT9000.DivisionID)


	UNION ALL

	SELECT 
	AT9000.DivisionID, 
	AT9000.VoucherID, 
	AT9000.CreditAccountID AS AccountID,
	CASE WHEN AT9000.TransactionTypeID = 'T99' THEN AT9000.CreditObjectID ELSE AT9000.ObjectID END AS ObjectID, 
	AT1202.ObjectName,
	AT9000.Serial,
	AT9000.InvoiceNo,
	AT9000.InvoiceDate,
	AT9000.ConvertedAmount,
	AT9000.TransactionID,
	'C' AS D_C,
	AT9000.VDescription,
	AT9000.TDescription,
	AT9000.InheritTableID,
	AT9000.InheritVoucherID,
	T2.HandOverDate,
	T4.AdministrativeExpensesDate,
	T2.SignDate,
	CASE WHEN AT9000.InheritTableID = 'AT0420' then T4.ContractNo else T2.ContractNo end as ContractNo
	,AT9000.Ana01ID,AT9000.Ana02ID,AT9000.Ana03ID,AT9000.Ana04ID,AT9000.Ana05ID,AT9000.Ana06ID
	,AT9000.Ana07ID,AT9000.Ana08ID,AT9000.Ana09ID,AT9000.Ana10ID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
	LEFT JOIN CT0157 T1 WITH (NOLOCK) ON T1.ContractDetailID = AT9000.InheritVoucherID
	LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T2.APK = T1.APKMaster
	LEFT JOIN AT0420 T3 WITH (NOLOCK) ON T3.APK = AT9000.InheritVoucherID
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T4.DivisionID = T3.DivisionID AND T3.ContractNo = T4.ContractNo
	WHERE AT9000.CreditAccountID IN (SELECT AccountID FROM AT0006 WHERE D_C = 'C' AND DivisionID = AT9000.DivisionID)
	AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(VoucherID + TransactionID,'') FROM AT1703 WHERE D_C = 'C' AND DivisionID = AT9000.DivisionID)
	AND AT9000.VoucherID + AT9000.TransactionID NOT IN (SELECT ISNULL(ReVoucherID + ReTransactionID,'') FROM AT1603 WHERE DivisionID = AT9000.DivisionID)) as P

SELECT ObjectID,ObjectName,ConvertedAmount,AccountID,Serial,InvoiceNo,InvoiceDate,TransactionID,InheritTableID,InheritVoucherID
,HandOverDate,AdministrativeExpensesDate,SignDate,ContractNo,Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID
,Ana09ID,Ana10ID
FROM #AP0434
WHERE VoucherID = @VoucherID
AND DivisionID in (@DivisionID, '@@@')
ORDER BY ObjectID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
