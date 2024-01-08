IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0380]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0380]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Do nguon báo cáo DebitNote
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> ASOFT-T/
---- báo cáo/báo cáo đặc thù/Báo cáo DebitNote
-- <History>
---- Create on 20/11/2017 by Trương Ngọc Phương Thảo
---- Modified on 18/12/2017 by Bảo Anh : Bổ sung cột Notes
-- <Example>
---- EXEC AP0380 '604', 'ASOFTADMIN', '2017-09-01', '2017-11-30', '000140', '605355'
CREATE PROCEDURE AP0380
(
	@DivisionID varchar(50),
	@UserID varchar(50),		
	@FromDate datetime,	
	@ToDate datetime,
	@FromCustomerID varchar(50),
	@ToCustomerID varchar(50)
)
AS
SET NOCOUNT ON

DECLARE @sSQL01 NVarchar(4000)

SET @sSQL01 = 
'
SELECT
TransactionID, HouseID, HouseName, TrafficType, TrafficDirection, InvoiceType,
InvoiceNote, InvoiceDate, FileRef, HAWBNumber, AWBNumber, ETD, CustomerID, CustomerName,
Amount_Document AS Amount_FOS, Amount_Local AS Amount_Local_FOS, ReMark AS ReMarkID, 
Convert(Nvarchar(250),'''') AS ReMark, Convert(Decimal(28,8),0) AS Amount_ERP,
Convert(Varchar(50),'''') AS InvoiceNo_ERP, Convert(Datetime,null) AS InvoiceDate_ERP,
T1.Notes
INTO #AP0380_AT0300
FROM AT0300 T1 WITH(NOLOCK)
WHERE HouseID = '''+@DivisionID+''' AND CustomerID BETWEEN '''+@FromCustomerID+''' AND '''+@ToCustomerID+'''
		AND InvoiceDate BETWEEN '''+Convert(Varchar(20),@FromDate,101)+''' AND '''+Convert(Varchar(20),@ToDate,101)+'''	

UPDATE T1
SET	T1.ReMark = T2.AnaName
FROM #AP0380_AT0300 T1
INNER JOIN AT1011 T2 ON T1.ReMarkID = T2.AnaID AND T2.AnaTypeID = ''A01''

UPDATE T1
SET	T1.Amount_ERP = T2.ConvertedAmount,
	T1.InvoiceNo_ERP = T2.InvoiceNo,
	T1.InvoiceDate_ERP = T2.InvoiceDate
FROM #AP0380_AT0300 T1
LEFT JOIN AT9000 T2 WITH(NOLOCK) ON T1.TransactionID = T2.InheritTransactionID AND T1.HouseID = T2.DivisionID

SELECT HouseID, HouseName, TrafficType, TrafficDirection, InvoiceType,
InvoiceNote, InvoiceDate, FileRef, HAWBNumber, AWBNumber, ETD, CustomerID, CustomerName,Notes,
SUM(Amount_FOS) AS Amount_FOS, SUM(Amount_ERP) AS Amount_ERP, SUM(Amount_Local_FOS) AS Amount_Local_FOS,
MAX(InvoiceNo_ERP) AS InvoiceNo_ERP, MAX(InvoiceDate_ERP) AS InvoiceDate_ERP,
MAX(ReMarkID) AS ReMarkID, MAX(ReMark) AS ReMark
FROM #AP0380_AT0300 
GROUP BY HouseID, HouseName, TrafficType, TrafficDirection, InvoiceType,
InvoiceNote, InvoiceDate, FileRef, HAWBNumber, AWBNumber, ETD, CustomerID, CustomerName,Notes
ORDER BY InvoiceDate, InvoiceNote
'
--print @sSQL01
EXEC (@sSQL01)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

