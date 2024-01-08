IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8162]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8162]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý Import dữ liệu Khai báo Công cụ dụng cụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 04/08/2020 by Phạm Lê Hoàng
---- Modified on 17/11/2020 by Lê Hoàng : Chỉnh sửa TRIM không chạy được SQL2014
---- Modified on 26/05/2022 by Xuân Nguyên : Bổ sung import Residualvalue
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8162]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(MAX)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@ExchangeRate AS DECIMAL(28,8),
		@i int, @n int,
		@InvoiceDate Datetime, -- @InvoiceNo NVarchar(50),
		@CurrencyID NVarchar(50), 
		@Method Tinyint

DECLARE @Operator AS INT, @ERDecimal AS INT
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT (''),
	VoucherID NVARCHAR(50),
	SerialNo NVARCHAR(50)
)


-- Tạo khóa chính cho table #Data 
DECLARE @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			'

EXEC(@SQL)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL WITH (NOLOCK)
	INNER JOIN	A01066 TLD WITH (NOLOCK)
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL WITH (NOLOCK)
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
	
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,--DivisionID
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,--Period
		X.Data.query('ToolID').value('.', 'NVARCHAR(50)') AS ToolID,
		X.Data.query('ToolName').value('.', 'NVARCHAR(250)') AS ToolName,
		(CASE WHEN X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') END) AS VoucherNo,--VoucherNo
		(CASE WHEN X.Data.query('InventoryID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('InventoryID').value('.', 'VARCHAR(50)') END) AS InventoryID,--InventoryID
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,--DebitAccountID
		(CASE WHEN X.Data.query('ConvertedAmount').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ConvertedAmount').value('.', 'DECIMAL(28,8)') END) AS ConvertedAmount,--ConvertedAmount
		(CASE WHEN X.Data.query('ActualQuantity').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ActualQuantity').value('.', 'DECIMAL(28,8)') END) AS ActualQuantity,--ActualQuantity
		X.Data.query('ObjectID').value('.', 'VARCHAR(50)') AS ObjectID,--ObjectID
		X.Data.query('MethodID').value('.', 'TINYINT') AS MethodID,--MethodID
		X.Data.query('IsInherit').value('.', 'TINYINT') AS IsInherit,--IsInherit
		(CASE WHEN X.Data.query('Periods').value('.', 'VARCHAR(50)') = '' THEN CONVERT(INT, NULL)
			  ELSE X.Data.query('Periods').value('.', 'INT') END) AS Periods,--Periods
		(CASE WHEN X.Data.query('ApportionRate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ApportionRate').value('.', 'DECIMAL(28,8)') END) AS ApportionRate,--ApportionRate
		(CASE WHEN X.Data.query('ApportionAmount').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ApportionAmount').value('.', 'DECIMAL(28,8)') END) AS ApportionAmount,--ApportionAmount
		(CASE WHEN X.Data.query('Description').value('.', 'NVARCHAR(250)') = '' THEN CONVERT(NVARCHAR(250), NULL)
			  ELSE X.Data.query('Description').value('.', 'NVARCHAR(250)') END) AS Description,--Description
		(CASE WHEN X.Data.query('DepPeriod').value('.', 'VARCHAR(50)') = '' THEN CONVERT(INT, NULL)
			  ELSE X.Data.query('DepPeriod').value('.', 'INT') END) AS DepPeriod,--DepPeriod
		(CASE WHEN X.Data.query('BeginMonth').value('.', 'VARCHAR(50)') = '' THEN CONVERT(INT, NULL)
			  ELSE X.Data.query('BeginMonth').value('.', 'INT') END) AS BeginMonth,--BeginMonth
		(CASE WHEN X.Data.query('BeginYear').value('.', 'VARCHAR(50)') = '' THEN CONVERT(INT, NULL)
			  ELSE X.Data.query('BeginYear').value('.', 'INT') END) AS BeginYear,--BeginYear
		(CASE WHEN X.Data.query('EstablishDate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DATETIME, NULL)
			  ELSE X.Data.query('EstablishDate').value('.', 'DATETIME') END) AS EstablishDate,--EstablishDate
		(CASE WHEN X.Data.query('ParentVoucherID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('ParentVoucherID').value('.', 'VARCHAR(50)') END) AS ParentVoucherID,--ParentVoucherID
		(CASE WHEN X.Data.query('Ana01ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana01ID').value('.', 'VARCHAR(50)') END) AS Ana01ID,--Ana01ID
		(CASE WHEN X.Data.query('Ana02ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana02ID').value('.', 'VARCHAR(50)') END) AS Ana02ID,--Ana02ID
		(CASE WHEN X.Data.query('Ana03ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana03ID').value('.', 'VARCHAR(50)') END) AS Ana03ID,--Ana03ID
		(CASE WHEN X.Data.query('Ana04ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana04ID').value('.', 'VARCHAR(50)') END) AS Ana04ID,--Ana04ID
		(CASE WHEN X.Data.query('Ana05ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana05ID').value('.', 'VARCHAR(50)') END) AS Ana05ID,--Ana05ID
		(CASE WHEN X.Data.query('Ana06ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana06ID').value('.', 'VARCHAR(50)') END) AS Ana06ID,--Ana06ID
		(CASE WHEN X.Data.query('Ana07ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana07ID').value('.', 'VARCHAR(50)') END) AS Ana07ID,--Ana07ID
		(CASE WHEN X.Data.query('Ana08ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana08ID').value('.', 'VARCHAR(50)') END) AS Ana08ID,--Ana08ID
		(CASE WHEN X.Data.query('Ana09ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana09ID').value('.', 'VARCHAR(50)') END) AS Ana09ID,--Ana09ID
		(CASE WHEN X.Data.query('Ana10ID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('Ana10ID').value('.', 'VARCHAR(50)') END) AS Ana10ID,--Ana10ID

		(CASE WHEN X.Data.query('Parameter01').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter01').value('.', 'NVARCHAR(50)') END) AS Parameter01,--Parameter01
		(CASE WHEN X.Data.query('Parameter02').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter02').value('.', 'NVARCHAR(50)') END) AS Parameter02,--Parameter02
		(CASE WHEN X.Data.query('Parameter03').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter03').value('.', 'NVARCHAR(50)') END) AS Parameter03,--Parameter03
		(CASE WHEN X.Data.query('Parameter04').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter04').value('.', 'NVARCHAR(50)') END) AS Parameter04,--Parameter04
		(CASE WHEN X.Data.query('Parameter05').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter05').value('.', 'NVARCHAR(50)') END) AS Parameter05,--Parameter05
		(CASE WHEN X.Data.query('Parameter06').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter06').value('.', 'NVARCHAR(50)') END) AS Parameter06,--Parameter06
		(CASE WHEN X.Data.query('Parameter07').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter07').value('.', 'NVARCHAR(50)') END) AS Parameter07,--Parameter07
		(CASE WHEN X.Data.query('Parameter08').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter08').value('.', 'NVARCHAR(50)') END) AS Parameter08,--Parameter08
		(CASE WHEN X.Data.query('Parameter09').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter09').value('.', 'NVARCHAR(50)') END) AS Parameter09,--Parameter09
		(CASE WHEN X.Data.query('Parameter10').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter10').value('.', 'NVARCHAR(50)') END) AS Parameter10,--Parameter10

		(CASE WHEN X.Data.query('Parameter11').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter11').value('.', 'NVARCHAR(50)') END) AS Parameter11,--Parameter11
		(CASE WHEN X.Data.query('Parameter12').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter12').value('.', 'NVARCHAR(50)') END) AS Parameter12,--Parameter12
		(CASE WHEN X.Data.query('Parameter13').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter13').value('.', 'NVARCHAR(50)') END) AS Parameter13,--Parameter13
		(CASE WHEN X.Data.query('Parameter14').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter14').value('.', 'NVARCHAR(50)') END) AS Parameter14,--Parameter14
		(CASE WHEN X.Data.query('Parameter15').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter15').value('.', 'NVARCHAR(50)') END) AS Parameter15,--Parameter15
		(CASE WHEN X.Data.query('Parameter16').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter16').value('.', 'NVARCHAR(50)') END) AS Parameter16,--Parameter16
		(CASE WHEN X.Data.query('Parameter17').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter17').value('.', 'NVARCHAR(50)') END) AS Parameter17,--Parameter17
		(CASE WHEN X.Data.query('Parameter18').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter18').value('.', 'NVARCHAR(50)') END) AS Parameter18,--Parameter18
		(CASE WHEN X.Data.query('Parameter19').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter19').value('.', 'NVARCHAR(50)') END) AS Parameter19,--Parameter19
		(CASE WHEN X.Data.query('Parameter20').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('Parameter20').value('.', 'NVARCHAR(50)') END) AS Parameter20,--Parameter20
		(CASE WHEN X.Data.query('ResidualValue').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('ResidualValue').value('.', 'DECIMAL(28,8)') END) AS ResidualValue--ActualQuantity
INTO	#AP8162
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (
		Row,DivisionID,Period,ToolID,ToolName,VoucherNo,InventoryID,CreditAccountID,DebitAccountID,		
		ConvertedAmount,ActualQuantity,ObjectID,MethodID,IsInherit,Periods,ApportionRate,ApportionAmount,
		Description,DepPeriod,BeginMonth,BeginYear,EstablishDate,ParentVoucherID,
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
		Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
		ResidualValue)	
SELECT	Row,DivisionID,Period,ToolID,ToolName,VoucherNo,InventoryID,CreditAccountID,DebitAccountID,		
		ConvertedAmount,ActualQuantity,ObjectID,MethodID,IsInherit,Periods,ApportionRate,ApportionAmount,
		Description,DepPeriod,BeginMonth,BeginYear,EstablishDate,ParentVoucherID,
		Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
		Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
		Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
		ResidualValue
FROM	#AP8162

-- Cập nhật giá trị của VoucherID căn cứ vào VoucherNo để kiểm đối tượng có hợp lệ
--UPDATE		DT
--SET			DT.VoucherID = AV02.VoucherID
--FROM		#Data DT
--INNER JOIN	AV1702 AV02
--		ON	AV02.VoucherNo = DT.VoucherNo AND AV02.DivisionID = DT.DivisionID
--			AND AV02.D_C = 'D' AND AV02.VoucherID IN (SELECT AV01.VoucherID FROM AV1701 AV01 WHERE AV01.D_C = 'D' AND AV01.DivisionID = DT.DivisionID)
--			AND AV02.TranMonth + AV02.TranYear * 100 <= (CASE WHEN ISNUMERIC(LEFT(DT.Period, 2)) = 1 AND ISNUMERIC(RIGHT(DT.Period, 4)) = 1 THEN LEFT(DT.Period, 2) + RIGHT(DT.Period, 4) * 100 ELSE 0 END)			 

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidObject', @ColID = 'ObjectID', @Param1 = '', @Param2 = '', @Param3 = '', @Param4 = '', @Param5 = '',@ObligeCheck = 1, @SQLWhere = ''
---- Kiểm tra dữ liệu không đồng nhất tại phần phiếu
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ToolID', @Param1 = 'ToolName,IsInherit,CreditAccountID,DebitAccountID,ApportionRate,MethodID,ObjectID,Periods,ApportionAmount,Description,DepPeriod,BeginMonth,BeginYear,EstablishDate,ParentVoucherID'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ToolID', @Param1 = 'Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ToolID', @Param1 = 'Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20'
---- Kiểm tra nếu IsInherit = 1 thì phải chọn danh sách chứng từ kế thừa

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai


-- Sinh khóa
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@InvoiceNo AS NVARCHAR(50),
		@Serial AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@ObjectID AS NVARCHAR(50), 
		@OVoucherGroup AS NVARCHAR(50),
		@OInvoiceGroup AS NVARCHAR(250)

DECLARE	@VoucherID AS NVARCHAR(50),
		@BatchID AS NVARCHAR(50),
		@TransID AS NVARCHAR(50)			


-- Cập nhật khóa
SELECT	@DivisionID AS DivisionID, NEWID() AS VoucherID, #Data.ToolID INTO #TempKey
FROM	#Data                                                                                                                                     
GROUP BY #Data.ToolID

--drop constraint 


-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateTool', @ColID = 'ToolID', @Param1 = 'ToolID'

--BEGIN TRAN

--SELECT	NEWID(),@DivisionID,R01.VoucherID,
--		#Data.ToolID,ToolName,VoucherNo,NULL,CreditAccountID,DebitAccountID,
--		ApportionAmount,ApportionRate,MethodID,ActualQuantity,Periods,ConvertedAmount,BeginMonth,BeginYear,
--		Description,
--		--CASE WHEN IsInherit = 1 THEN ReVoucherID ELSE NULL END, 
--		--CASE WHEN IsInherit = 1 THEN ReTransactionID ELSE NULL END,
--		ObjectID,0,0,DepPeriod,ParentVoucherID,
--		EstablishDate,0,Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
--		Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
--		Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
--		@UserID, GETDATE(),	@UserID, GETDATE()
--FROM	#Data  
--LEFT JOIN #TempKey R01 ON R01.ToolID = #Data.ToolID

--nếu có kế thừa thì insert dữ liệu vào AT1633
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE IsInherit = 1)
BEGIN
	--tạo bảng chứng từ để lấy ReVoucherID, ReTransactionID kế thừa
	SELECT AT9000.DivisionID, VoucherID, TransactionID, LTRIM(RTRIM(VoucherNo)) VoucherNo, VoucherDate, AT9000.InventoryID, ConvertedAmount, TDescription,DebitAccountID,CreditAccountID,  InventoryName, Quantity, AT9000.TransactionTypeID, IsEdit = CONVERT(TINYINT, 0),Serial, InvoiceNo, InvoiceDate, AT9000.ObjectID    
	INTO #AV1631
	FROM AT9000 WITH(NOLOCK)   
	LEFT JOIN AT1302 WITH(NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
	WHERE AT9000.DivisionID = @DivisionID AND DebitAccountID IN (SELECT AccountID FROM AT1005 WITH(NOLOCK)
														   WHERE Disabled = 0 AND IsNotShow = 0 AND GroupID = 'G06'
														   AND DivisionID IN (@DivisionID, '@@@'))
		AND AT9000.TransactionTypeID IN ('T03','T06','T99')  
		AND VoucherID NOT IN (SELECT VoucherID 
							  FROM AT1703 WITH (NOLOCK) 
							  INNER JOIN AT1704 WITH (NOLOCK) ON AT1703.JobID = AT1704.JobID   
							  WHERE AT1704.Status = 1 AND  AT1703.DivisionID = @DivisionID)
  
	SELECT Convert(TINYINT, 0) AS Choose,
		AV1631.DivisionID,  
		AV1631.VoucherID, 
		AV1631.InventoryID, 
		AV1631.InventoryName,  
		AV1631.Quantity, 
		AV1631.TransactionID,   
		AV1631.VoucherNo,   
		AV1631.TransactionTypeID,   
		AV1631.DebitAccountID,    
		AV1631.CreditAccountID,
		(AV1631.ConvertedAmount - (ISNULL(A.ConvertedAmount,0))) as ConvertedAmount,
		AV1631.IsEdit, 
		AV1631.ObjectID INTO #TempVoucher
	FROM #AV1631 AV1631 
	LEFT JOIN  (SELECT ISNULL(SUM(ISNULL(ConvertedAmount, 0)), 0) AS ConvertedAmount, ReTransactionID, DivisionID   
				FROM AT1633 WITH (NOLOCK)
				GROUP BY ReTransactionID, DivisionID) A ON A.ReTransactionID = AV1631.TransactionID AND A.DivisionID = AV1631.DivisionID  
	GROUP BY  
		AV1631.DivisionID,AV1631.VoucherID,AV1631.TransactionID,AV1631.VoucherNo,AV1631.VoucherDate,AV1631.TransactionTypeID,
		AV1631.TDescription,AV1631.DebitAccountID,AV1631.CreditAccountID,AV1631.ConvertedAmount,AV1631.IsEdit,
		AV1631.InventoryID,AV1631.InventoryName,AV1631.Quantity,Serial,InvoiceNo,InvoiceDate,AV1631.ObjectID,A.ConvertedAmount
	HAVING (AV1631.ConvertedAmount - (ISNULL(A.ConvertedAmount,0)))  > 0 
	ORDER BY VoucherNo

	SELECT @DivisionID DivisionID, R02.VoucherID, R00.ToolID, R01.VoucherID ReVoucherID, MAX(R01.TransactionID) ReTransactionID, R01.DebitAccountID, R01.ConvertedAmount 
	INTO #TempInherit
	FROM #Data R00
	LEFT JOIN #TempKey R02 ON R02.ToolID = R00.ToolID
	LEFT JOIN #TempVoucher R01 ON R01.DivisionID = @DivisionID AND R01.VoucherNo = R00.VoucherNo AND R01.InventoryID = R00.InventoryID AND R01.ConvertedAmount = R00.ConvertedAmount
	WHERE IsInherit = 1
	GROUP BY R01.VoucherID, R01.VoucherNo, R01.InventoryID, R01.DebitAccountID, R01.ConvertedAmount, R02.VoucherID, R00.ToolID
END

IF OBJECT_ID('tempdb..#TempInherit') IS NOT NULL
BEGIN
	IF EXISTS(SELECT TOP 1 1 FROM #TempInherit WHERE ISNULL(ReVoucherID,'') = '')
	BEGIN
		UPDATE R00 SET ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000556 {0}=''D'''
		FROM #Data R00
		LEFT JOIN #TempInherit R02 ON R02.ToolID = R00.ToolID
		WHERE IsInherit = 1 AND R02.ReVoucherID IS NULL
	END
END

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Đẩy dữ liệu công cụ dụng cụ vào bảng AT1603
IF OBJECT_ID('tempdb..#TempInherit') IS NOT NULL
BEGIN

	SELECT R00.DivisionID, R00.VoucherID, R00.ToolID, R00.ReVoucherID, MAX(R00.ReTransactionID) ReTransactionID, R00.DebitAccountID
	INTO #TempInherit2
	FROM #TempInherit R00
	GROUP BY R00.DivisionID, R00.VoucherID, R00.ReVoucherID, R00.DebitAccountID, R00.ToolID

	INSERT INTO AT1603
	(
	APK,DivisionID,VoucherID,ToolID,ToolName,VoucherNo,SerialNo,CreditAccountID,DebitAccountID,
	ApportionAmount,ApportionRate,MethodID,ActualQuantity,Periods,ConvertedAmount,BeginMonth,BeginYear,
	Description,--ReVoucherID,ReTransactionID,
	ObjectID,IsUsed,UseStatus,DepPeriod,ParentVoucherID,
	EstablishDate,IsMultiAccount,Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
	Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
	Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
	CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,ResidualValue
	)
	SELECT	NEWID(),@DivisionID,R01.VoucherID,#Data.ToolID,ToolName,MAX(COALESCE(VoucherNo,'')),NULL,R02.DebitAccountID,#Data.DebitAccountID,
			ApportionAmount,ApportionRate,MethodID,SUM(COALESCE(ActualQuantity,0)),Periods,SUM(COALESCE(#Data.ConvertedAmount,0)),BeginMonth,BeginYear,
			Description,
			--CASE WHEN IsInherit = 1 THEN ReVoucherID ELSE NULL END, 
			--CASE WHEN IsInherit = 1 THEN ReTransactionID ELSE NULL END,
			ObjectID,0,0,DepPeriod,ParentVoucherID,
			EstablishDate,0,Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
			Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
			Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
			@UserID, GETDATE(),	@UserID, GETDATE(),SUM(COALESCE(ResidualValue,0))
	FROM	#Data   
	LEFT JOIN #TempKey R01 ON R01.ToolID = #Data.ToolID
	LEFT JOIN #TempInherit2 R02 ON R02.ToolID = #Data.ToolID
	GROUP BY R01.VoucherID, #Data.ToolID, ToolName, IsInherit, #Data.DebitAccountID, R02.DebitAccountID, ApportionRate, MethodID, ObjectID, Periods,		ApportionAmount, Description, DepPeriod, BeginMonth, BeginYear, EstablishDate, ParentVoucherID, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID,	Ana07ID, Ana08ID, Ana09ID, Ana10ID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06, Parameter07, Parameter08, Parameter09,   Parameter10, Parameter11, Parameter12, Parameter13, Parameter14, Parameter15, Parameter16, Parameter17, Parameter18, Parameter19, Parameter20    
END
ELSE
BEGIN
	INSERT INTO AT1603
	(
	APK,DivisionID,VoucherID,ToolID,ToolName,VoucherNo,SerialNo,CreditAccountID,DebitAccountID,
	ApportionAmount,ApportionRate,MethodID,ActualQuantity,Periods,ConvertedAmount,BeginMonth,BeginYear,
	Description,ObjectID,IsUsed,UseStatus,DepPeriod,ParentVoucherID,
	EstablishDate,IsMultiAccount,Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
	Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
	Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
	CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,ResidualValue
	)
	SELECT	NEWID(),@DivisionID,R01.VoucherID,#Data.ToolID,ToolName,MAX(COALESCE(VoucherNo,'')),NULL,CreditAccountID,DebitAccountID,
			ApportionAmount,ApportionRate,MethodID,SUM(COALESCE(ActualQuantity,0)),Periods,SUM(COALESCE(#Data.ConvertedAmount,0)),BeginMonth,BeginYear,
			Description,
			ObjectID,0,0,DepPeriod,ParentVoucherID,
			EstablishDate,0,Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
			Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,
			Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
			@UserID, GETDATE(),	@UserID, GETDATE(), SUM(COALESCE(ResidualValue,0))
	FROM	#Data   
	LEFT JOIN #TempKey R01 ON R01.ToolID = #Data.ToolID
	GROUP BY R01.VoucherID, #Data.ToolID, ToolName, IsInherit, CreditAccountID, DebitAccountID, ApportionRate, MethodID, ObjectID, Periods, ApportionAmount,	Description, DepPeriod, BeginMonth, BeginYear, EstablishDate, ParentVoucherID, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID,	   Ana09ID, Ana10ID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06, Parameter07, Parameter08, Parameter09, Parameter10,		Parameter11, Parameter12, Parameter13, Parameter14, Parameter15, Parameter16, Parameter17, Parameter18, Parameter19, Parameter20   
END
--- insert dữ liệu lưu vết kế thừa vào AT1633
IF OBJECT_ID('tempdb..#TempInherit') IS NOT NULL
BEGIN
	INSERT INTO AT1633 (DivisionID, VoucherID, ReVoucherID, RetransactionID, ConvertedAmount)
	SELECT @DivisionID, VoucherID, ReVoucherID, ReTransactionID, ConvertedAmount
	FROM #TempInherit R00
END
--ROLLBACK TRAN

LB_RESULT:
SELECT * FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

