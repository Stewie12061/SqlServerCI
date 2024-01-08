IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP0377]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0377]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Do nguon luoi ke thua DebitNote
-- <Param>
---- @Mode = 0: Grid 1, = 1: Grid2
-- <Return>
---- 
-- <Reference> ASOFT-T/
---- Ban hang/ Hoa don ban hang/Ke thua DebitNote (Customize Panalpina - CustomerIndex = 83)
-- <History>
---- Create on 20/09/2017 by Trương Ngọc Phương Thảo
---- Modified on  by  : 
-- <Example>
---- EXEC AP0377 'EM', 'ASOFTADMIN', '2017-09-01', '2017-09-30', '%', '', 1
---- EXEC AP0377 '604', 'ASOFTADMIN', '2017-09-01', '2017-09-30', '%', '', 0
CREATE PROCEDURE AP0377	
(
	@DivisionID varchar(50),
	@UserID varchar(50),		
	@FromDate datetime,	
	@ToDate datetime,
	@CustomerID varchar(50),
	@InvoiceNote varchar(4000),	
	@Mode int =1
)
AS
SET NOCOUNT ON

DECLARE @sSQL01 NVarchar(4000)

SET @InvoiceNote = 	REPLACE(@InvoiceNote, ',', ''',''')

IF (@Mode = 0) -- Grid 1
BEGIN
	SET @sSQL01 = 
	'
	SELECT	T1.InvoiceNote+''-''+Convert(Varchar(50),T1.InvoiceDate,112) AS VoucherID,
			T1.InvoiceDate,
			MAX(T1.InvoiceType) InvoiceType,
			MAX(T1.TrafficType) TrafficType,		
			MAX(T1.FileRef) FileRef,
			T1.InvoiceNote,
			MAX(T1.HAWBNumber) HAWBNumber,
			MAX(T1.AWBNumber) AWBNumber,
			MAX(T1.ETD) ETD,
			MAX(T1.CustomerID) CustomerID,
			MAX(T1.CustomerName) CustomerName,
			MAX(T1.ProjectID) ProjectID, 
			MAX(T1.ProjectName) ProjectName,
			MAX(T1.PACustomerRef) PACustomerRef,
			SUM(T1.Amount_Document) as TotalAmountDocument,
			SUM(T1.Amount_Local) as TotalAmountLocal,
			SUM(T1.Amount_Target) as TotalAmountTarget,
			MAX(T2.AnaName) AS ReMark
	FROM AT0300 T1 WITH(NOLOCK)
	LEFT JOIN AT1011 T2 WITH(NOLOCK) ON T1.ReMark = T2.AnaID AND T2.AnaTypeID = ''A01''
	WHERE T1.HouseID = '''+@DivisionID+''' AND T1.CustomerID LIKE '''+@CustomerID+'''
		  AND T1.InvoiceDate BETWEEN '''+Convert(Varchar(20),@FromDate,101)+''' AND '''+Convert(Varchar(20),@ToDate,101)+'''
		  AND T1.Status = 0
		  AND ISNULL(T1.ReMark,'''') <> ''CR''
		  AND ISNULL(T1.Notes,'''') = ''''
	GROUP BY T1.InvoiceDate, T1.InvoiceNote 
	ORDER BY T1.InvoiceDate, T1.InvoiceNote
	'
END
ELSE
IF(@Mode = 1) -- Grid 2
BEGIN
	SET @sSQL01 = 
	'
	SELECT	*
	FROM AT0300
	WHERE HouseID = '''+@DivisionID+''' AND InvoiceNote+''-''+Convert(Varchar(50),InvoiceDate,112) in (N''' + @InvoiceNote + ''') 
	AND ChargeLineID <> ''#''
	AND Status = 0
	ORDER BY InvoiceDate, InvoiceNote, ChargeLineID

	'
END

EXEC (@sSQL01)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

