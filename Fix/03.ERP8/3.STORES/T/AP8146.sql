IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8146]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8146]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý Import kết quả sản xuất (thành phẩm/bán thành phẩm)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/01/2016 by Phương Thảo
---- Modified on 28/01/2016  by : 
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 15/12/2023 by Nhựt Trường: 2023/12/IS/0185, Set giá trị 0 cho các cột tiền bảng dữ liệu master.
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8146]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50) NULL,
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	Orders INT,
	VoucherID NVARCHAR(50),
	TransactionID NVARCHAR(50)--,	
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL1 NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL1 = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL1)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL
	INNER JOIN	A01066 TLD
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum
	
OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
-- select * from  A00065 where ImportTransTypeID = 'PManufactureResult' order by OrderNum

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,				
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		X.Data.query('Type').value('.', 'Int') AS Type,
		X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'DATETIME') AS VoucherDate,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,		
		X.Data.query('PeriodID').value('.', 'NVARCHAR(50)') AS PeriodID,	
		X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID,
		X.Data.query('TransferPeriodID').value('.', 'NVARCHAR(50)') AS TransferPeriodID,	
		X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
		X.Data.query('TeamID').value('.', 'NVARCHAR(50)') AS TeamID,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,	
		X.Data.query('ProductID').value('.', 'NVARCHAR(50)') AS ProductID,
		X.Data.query('SemiProductID').value('.', 'NVARCHAR(50)') AS SemiProductID,
		X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
		X.Data.query('Quantity').value('.', 'DECIMAL(28,8)') AS Quantity,
		X.Data.query('Price').value('.', 'DECIMAL(28,8)') AS Price,
		X.Data.query('OriginalAmount').value('.', 'DECIMAL(28,8)') AS OriginalAmount,
		X.Data.query('SourceNo').value('.', 'NVARCHAR(50)') AS SourceNo,
		X.Data.query('LimitDate').value('.', 'DATETIME') AS LimitDate,
		X.Data.query('DebitAccountID').value('.', 'NVARCHAR(50)') AS DebitAccountID,
		X.Data.query('CreditAccountID').value('.', 'NVARCHAR(50)') AS CreditAccountID,			
		X.Data.query('HRMEmployeeID').value('.', 'NVARCHAR(50)') AS HRMEmployeeID,		
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,				
		X.Data.query('Ana01ID').value('.', 'NVARCHAR(50)') AS Ana01ID,
		X.Data.query('Ana02ID').value('.', 'NVARCHAR(50)') AS Ana02ID,
		X.Data.query('Ana03ID').value('.', 'NVARCHAR(50)') AS Ana03ID,
		X.Data.query('Ana04ID').value('.', 'NVARCHAR(50)') AS Ana04ID,
		X.Data.query('Ana05ID').value('.', 'NVARCHAR(50)') AS Ana05ID,
		X.Data.query('Ana06ID').value('.', 'NVARCHAR(50)') AS Ana06ID,
		X.Data.query('Ana07ID').value('.', 'NVARCHAR(50)') AS Ana07ID,
		X.Data.query('Ana08ID').value('.', 'NVARCHAR(50)') AS Ana08ID,
		X.Data.query('Ana09ID').value('.', 'NVARCHAR(50)') AS Ana09ID,
		X.Data.query('Ana10ID').value('.', 'NVARCHAR(50)') AS Ana10ID
INTO	#AP8146	
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (
		Row,
		DivisionID,
		Period,
		VoucherTypeID,
		Type,
		VoucherNo,
		VoucherDate,
		EmployeeID,
		PeriodID,
		WareHouseID,
		TransferPeriodID,
		DepartmentID,
		TeamID,
		ObjectID,
		Description,
		ProductID,
		SemiProductID,
		UnitID,
		Quantity,
		Price,
		OriginalAmount,
		SourceNo,
		LimitDate,
		DebitAccountID,
		CreditAccountID,
		HRMEmployeeID,
		Notes,
		Ana01ID,
		Ana02ID,
		Ana03ID,
		Ana04ID,
		Ana05ID,
		Ana06ID,
		Ana07ID,
		Ana08ID,
		Ana09ID,
		Ana10ID 	)
SELECT	Row,
		DivisionID,
		Period,
		VoucherTypeID,
		ISNULL(Type,0) AS Type,
		VoucherNo,
		VoucherDate,
		EmployeeID,
		PeriodID,
		WareHouseID,
		TransferPeriodID,
		DepartmentID,
		TeamID,
		ObjectID,
		Description,
		ProductID,
		SemiProductID,
		UnitID,
		Quantity,
		Price,
		OriginalAmount,
		SourceNo,
		LimitDate,
		DebitAccountID,
		CreditAccountID,
		HRMEmployeeID,
		Notes,
		Ana01ID,
		Ana02ID,
		Ana03ID,
		Ana04ID,
		Ana05ID,
		Ana06ID,
		Ana07ID,
		Ana08ID,
		Ana09ID,
		Ana10ID 
FROM #AP8146


---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-M', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,PeriodID, WareHouseID, DepartmentID, TeamID, ObjectID, TransferPeriodID, EmployeeID, Description'

EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-M', @ColID = 'WareHouseID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'Type = 0'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-M', @ColID = 'TransferPeriodID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'Type = 1'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-M', @ColID = 'ProductID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'Type = 0'
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckObligatoryInput', @Module = 'ASOFT-M', @ColID = 'SemiProductID', @Param1 = '',@Param2 =  '',@Param3 = '',@Param4 = '', @Param5 = '', @ObligeCheck = 0, @SQLWhere = 'Type = 1'

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			OriginalAmount = ROUND(OriginalAmount, A.ConvertedDecimals),			
			Quantity = ROUND(DT.Quantity, A.QuantityDecimals),	
			Price = ROUND(DT.Price, A.UnitCostDecimals),	
			VoucherDate = CASE WHEN VoucherDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(50), VoucherDate, 101)) END,
			LimitDate = CASE WHEN LimitDate IS NOT NULL THEN CONVERT(datetime, CONVERT(varchar(50), LimitDate, 101)) END
FROM		#Data DT
LEFT JOIN	AT1101 A ON A.DivisionID = DT.DivisionID
			
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT



-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@VoucherNo AS NVARCHAR(50),
		@Period AS NVARCHAR(50),
		@VoucherGroup AS NVARCHAR(50)

DECLARE	@TransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@CurrencyID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50)		

SET @cKey = CURSOR FOR
	SELECT	Row, VoucherNo, Period
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT (@VoucherGroup)
	PRINT (@VoucherNo)
	SET @Period = RIGHT(@Period, 4)
	IF @VoucherGroup IS NULL OR @VoucherGroup <> (@VoucherNo + '#' + @Period)
	BEGIN
		SET @Orders = 0
		EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @VoucherID OUTPUT, @TableName = 'MT0810', @StringKey1 = 'MP', @StringKey2 = @Period, @OutputLen = 16
		SET @VoucherGroup = (@VoucherNo + '#' + @Period)
	END
	SET @Orders = @Orders + 1
	EXEC AP0002 @DivisionID = @DivisionID, @NewKey = @TransID OUTPUT, @TableName = 'MT1001', @StringKey1 = 'MQ', @StringKey2 = @Period, @OutputLen = 16
	INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID) VALUES (@Row, @Orders, @VoucherID, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @VoucherNo, @Period
END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.VoucherID = K.VoucherID ,
			DT.TransactionID = K.TransactionID			
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row

--drop constraint 
SET @SQL1 = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Keys_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Keys_PK +'
			END
			IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
			END
			'
EXEC(@SQL1)


-- Cập nhật Loại tiền
SET @CurrencyID = (SELECT TOP 1 BaseCurrencyID FROM AT1101 WHERE DivisionID = @DivisionID)
				
-- Kiểm tra trùng số chứng từ
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo', @ColID = 'VoucherNo', @Param2 = 'MT0810', @Param3 = 'VoucherNo'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT



-- Đẩy dữ liệu vào bảng master
INSERT INTO MT0810(
      DivisionID, VoucherID, PeriodID, TranMonth, TranYear, CurrencyID, ExchangeRate, VoucherNo, 
      DepartmentID, TransferPeriodID, OriginalAmount, ConvertedAmount, VoucherDate,
      EmployeeID, Description, 
	  CreateDate, CreateUserID, LastModifyUserID, LastModifyDate,
      ResultTypeID, InventoryTypeID, Disabled, VoucherTypeID,
      IsPrice, Status, IsDistribute,  -- 0
      WareHouseID, IsWareHouse, TeamID, ObjectID, IsTransfer
      )

SELECT	DISTINCT		
		DivisionID, VoucherID, PeriodID, LEFT(Period, 2),	RIGHT(Period, 4),		@CurrencyID,		1,
		VoucherNo, DepartmentID, TransferPeriodID, 0, 0, VoucherDate,
		EmployeeID, Description, 
		GETDATE(), @UserID, @UserID, GETDATE(),
		'R01', '%', 0, VoucherTypeID,
		0, 0, 0,  -- 0
		WareHouseID, CASE WHEN Type = 0 THEN 1 ELSE 0 END AS IsWareHouse, TeamID, ObjectID, CASE WHEN Type = 0 THEN 0 ELSE 1 END AS IsTransfer
FROM	#Data


 INSERT INTO MT1001(
      DivisionID, TransactionID, VoucherID, TranMonth,
      TranYear, Quantity, UnitID, Price,
      OriginalAmount, ConvertedAmount, Status, IsRepair,      
      Note, ProductID, DebitAccountID, CreditAccountID,
      SourceNo, LimitDate, Orders,
      Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
	  Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
      ProductID1, --OTransactionID, MTransactionID, 
      -- ConvertedQuantity, ConvertedPrice, 
	  ConvertedUnitID, HRMEmployeeID      
      ) 
SELECT  
	  DivisionID, TransactionID, VoucherID, 
	  LEFT(Period, 2),	RIGHT(Period, 4), Quantity, UnitID, Price,
      OriginalAmount, OriginalAmount, 0, 0, Notes, 
	  CASE WHEN Type = 0 THEN ProductID ELSE SemiProductID END, 
	  DebitAccountID, CreditAccountID,
      SourceNo, LimitDate, 
	  ROW_NUMBER() over (partition by TransactionID order by TransactionID) AS Orders,
      Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
	  Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
      CASE WHEN Type = 0 THEN '' ELSE ProductID END ProductID1, --OTransactionID, MTransactionID, 
      -- ConvertedQuantity, ConvertedPrice, 
	  UnitID, HRMEmployeeID 
FROM  #Data

LB_RESULT:
SELECT * FROM #Data



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

