IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP11706]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP11706]
GO
/****** Object:  StoredProcedure [dbo].[CIP11706]    Script Date: 12/4/2020 7:55:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- <Summary>
---- Import Excel Danh mục mặt hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Le Hoang 18/01/2021
---- Modified by Kiều Nga on 11/07/2023 [2023/07/IS/0072] Bổ sung giá trị mặc định cho cột ProductTypeID
-- <Example>

CREATE PROCEDURE [dbo].[CIP11706]
(
    @DivisionID VARCHAR(50),
    @UserID VARCHAR(50),
    @ImportTransTypeID VARCHAR(50),
    @XML XML
) 
AS
BEGIN
DECLARE @cCURSOR CURSOR,
        @sSQL NVARCHAR(MAX),
        @ColID VARCHAR(50), 
        @ColSQLDataType VARCHAR(50)
        
CREATE TABLE #Data
(
    [Row] INT,
    Orders INT,
    ErrorMessage NVARCHAR(MAX) DEFAULT (''),
    ErrorColumn NVARCHAR(MAX) DEFAULT (''),
    CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED
    (
        Row ASC
    ) ON [PRIMARY]
)

SET @cCURSOR = CURSOR STATIC FOR
    SELECT A00065.ColID, A00065.ColSQLDataType
    FROM A01065 WITH (NOLOCK)
    INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
    WHERE A01065.ImportTemplateID = @ImportTransTypeID
    ORDER BY A00065.OrderNum

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
CLOSE @cCURSOR


SELECT 
	X.Data.query('OrderNo').value('.', 'INT') AS [Row],
	X.Data.query('DivisionID').value('.', 'nvarchar(50)') AS DivisionID,
	X.Data.query('InventoryID').value('.', 'nvarchar(50)') AS InventoryID,
	X.Data.query('S1').value('.', 'nvarchar(50)') AS S1,
	X.Data.query('S2').value('.', 'nvarchar(50)') AS S2,
	X.Data.query('S3').value('.', 'nvarchar(50)') AS S3,
	X.Data.query('InventoryName').value('.', 'nvarchar(250)') AS InventoryName,
	X.Data.query('InventoryTypeID').value('.', 'nvarchar(50)') AS InventoryTypeID,
	X.Data.query('UnitID').value('.', 'nvarchar(50)') AS UnitID,
	X.Data.query('Varchar01').value('.', 'nvarchar(500)') AS Varchar01,
	X.Data.query('Varchar02').value('.', 'nvarchar(500)') AS Varchar02,
	X.Data.query('Varchar03').value('.', 'nvarchar(500)') AS Varchar03,
	X.Data.query('Varchar04').value('.', 'nvarchar(500)') AS Varchar04,
	X.Data.query('Varchar05').value('.', 'nvarchar(500)') AS Varchar05,
	(CASE WHEN X.Data.query('SalePrice01').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('SalePrice01').value('.', 'VARCHAR(MAX)') END) AS SalePrice01,
	(CASE WHEN X.Data.query('SalePrice02').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('SalePrice02').value('.', 'VARCHAR(MAX)') END) AS SalePrice02,
	(CASE WHEN X.Data.query('SalePrice03').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('SalePrice03').value('.', 'VARCHAR(MAX)') END) AS SalePrice03,
	(CASE WHEN X.Data.query('SalePrice04').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('SalePrice04').value('.', 'VARCHAR(MAX)') END) AS SalePrice04,
	(CASE WHEN X.Data.query('SalePrice05').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('SalePrice05').value('.', 'VARCHAR(MAX)') END) AS SalePrice05,
	(CASE WHEN X.Data.query('RecievedPrice').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('RecievedPrice').value('.', 'VARCHAR(MAX)') END) AS RecievedPrice,
	(CASE WHEN X.Data.query('DeliveryPrice').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('DeliveryPrice').value('.', 'VARCHAR(MAX)') END) AS DeliveryPrice,
	(CASE WHEN X.Data.query('Disabled').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('Disabled').value('.', 'VARCHAR(MAX)') END) AS Disabled,
	(CASE WHEN X.Data.query('MethodID').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('MethodID').value('.', 'VARCHAR(MAX)') END) AS MethodID,
	(CASE WHEN X.Data.query('IsSource').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('IsSource').value('.', 'VARCHAR(MAX)') END) AS IsSource,
	X.Data.query('AccountID').value('.', 'nvarchar(50)') AS AccountID,
	X.Data.query('SalesAccountID').value('.', 'nvarchar(50)') AS SalesAccountID,
	X.Data.query('PurchaseAccountID').value('.', 'nvarchar(50)') AS PurchaseAccountID,
	X.Data.query('PrimeCostAccountID').value('.', 'nvarchar(50)') AS PrimeCostAccountID,
	(CASE WHEN X.Data.query('IsLimitDate').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('IsLimitDate').value('.', 'VARCHAR(MAX)') END) AS IsLimitDate,
	(CASE WHEN X.Data.query('IsStocked').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('IsStocked').value('.', 'VARCHAR(MAX)') END) AS IsStocked,
	X.Data.query('VATGroupID').value('.', 'nvarchar(50)') AS VATGroupID,
	(CASE WHEN X.Data.query('VATPercent').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('VATPercent').value('.', 'VARCHAR(MAX)') END) AS VATPercent,
	(CASE WHEN X.Data.query('NormMethod').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('NormMethod').value('.', 'VARCHAR(MAX)') END) AS NormMethod,
	X.Data.query('I01ID').value('.', 'nvarchar(50)') AS I01ID,
	X.Data.query('I02ID').value('.', 'nvarchar(50)') AS I02ID,
	X.Data.query('I03ID').value('.', 'nvarchar(50)') AS I03ID,
	X.Data.query('I04ID').value('.', 'nvarchar(50)') AS I04ID,
	X.Data.query('I05ID').value('.', 'nvarchar(50)') AS I05ID,
	X.Data.query('Notes01').value('.', 'nvarchar(max)') AS Notes01,
	X.Data.query('Notes02').value('.', 'nvarchar(max)') AS Notes02,
	X.Data.query('Notes03').value('.', 'nvarchar(max)') AS Notes03,
	X.Data.query('RefInventoryID').value('.', 'nvarchar(50)') AS RefInventoryID,
	X.Data.query('Specification').value('.', 'nvarchar(max)') AS Specification,
	X.Data.query('VATImGroupID').value('.', 'nvarchar(50)') AS VATImGroupID,
	(CASE WHEN X.Data.query('VATImPercent').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('VATImPercent').value('.', 'VARCHAR(MAX)') END) AS VATImPercent,
	(CASE WHEN X.Data.query('PurchasePrice01').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('PurchasePrice01').value('.', 'VARCHAR(MAX)') END) AS PurchasePrice01,
	(CASE WHEN X.Data.query('PurchasePrice02').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('PurchasePrice02').value('.', 'VARCHAR(MAX)') END) AS PurchasePrice02,
	(CASE WHEN X.Data.query('PurchasePrice03').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('PurchasePrice03').value('.', 'VARCHAR(MAX)') END) AS PurchasePrice03,
	(CASE WHEN X.Data.query('PurchasePrice04').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('PurchasePrice04').value('.', 'VARCHAR(MAX)') END) AS PurchasePrice04,
	(CASE WHEN X.Data.query('PurchasePrice05').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(decimal(28, 8), NULL)
			  ELSE X.Data.query('PurchasePrice05').value('.', 'VARCHAR(MAX)') END) AS PurchasePrice05,
	X.Data.query('Barcode').value('.', 'nvarchar(50)') AS Barcode,
	(CASE WHEN X.Data.query('IsDiscount').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('IsDiscount').value('.', 'VARCHAR(MAX)') END) AS IsDiscount,
	(CASE WHEN X.Data.query('IsCommon').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('IsCommon').value('.', 'VARCHAR(MAX)') END) AS IsCommon,
	(CASE WHEN X.Data.query('ProductTypeID').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('ProductTypeID').value('.', 'VARCHAR(MAX)') END) AS ProductTypeID,
	X.Data.query('I06ID').value('.', 'nvarchar(50)') AS I06ID,
	X.Data.query('I07ID').value('.', 'nvarchar(50)') AS I07ID,
	X.Data.query('I08ID').value('.', 'nvarchar(50)') AS I08ID,
	X.Data.query('I09ID').value('.', 'nvarchar(50)') AS I09ID,
	X.Data.query('I10ID').value('.', 'nvarchar(50)') AS I10ID,
	X.Data.query('Notes04').value('.', 'nvarchar(max)') AS Notes04,
	X.Data.query('Notes05').value('.', 'nvarchar(max)') AS Notes05,
	X.Data.query('Varchar06').value('.', 'nvarchar(500)') AS Varchar06,
	X.Data.query('G05AccountID').value('.', 'varchar(MAX)') AS G05AccountID,
	X.Data.query('G07AccountID').value('.', 'varchar(MAX)') AS G07AccountID,
	(CASE WHEN X.Data.query('IsVIP').value('.', 'VARCHAR(MAX)') = '' THEN CONVERT(tinyint, NULL)
			  ELSE X.Data.query('IsVIP').value('.', 'VARCHAR(MAX)') END) AS IsVIP
INTO #CIP11706
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, --NormMethod,
Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID,
AccountID, SalesAccountID, PrimeCostAccountID, PurchaseAccountID, RefInventoryID,
VATGroupID, VATPercent, VATImGroupID, VATImPercent, MethodID,
IsStocked, IsDiscount, IsSource, IsLimitDate, Specification,
SalePrice01, SalePrice02, SalePrice03, SalePrice04, SalePrice05, RecievedPrice, DeliveryPrice,
S1, S2, S3, PurchasePrice01, PurchasePrice02, PurchasePrice03, PurchasePrice04, PurchasePrice05,
I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, Varchar06,
Notes01, Notes02, Notes03, Notes04, Notes05, Disabled, IsCommon, ProductTypeID, G05AccountID, G07AccountID, IsVIP)
SELECT [Row], DivisionID, --NormMethod,
Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID,
AccountID, SalesAccountID, PrimeCostAccountID, PurchaseAccountID, RefInventoryID,
VATGroupID, VATPercent, VATImGroupID, VATImPercent, MethodID,
IsStocked, IsDiscount, IsSource, IsLimitDate, Specification,
SalePrice01, SalePrice02, SalePrice03, SalePrice04, SalePrice05, RecievedPrice, DeliveryPrice,
S1, S2, S3, PurchasePrice01, PurchasePrice02, PurchasePrice03, PurchasePrice04, PurchasePrice05,
I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, Varchar06,
Notes01, Notes02, Notes03, Notes04, Notes05, Disabled, IsCommon, ProductTypeID, G05AccountID, G07AccountID, IsVIP
FROM #CIP11706

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @InventoryID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT InventoryID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @InventoryID

WHILE @@FETCH_STATUS = 0
BEGIN

    ---- Kiểm tra trùng mã chứng từ
    IF EXISTS (SELECT TOP  1 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = @InventoryID)
    BEGIN
        UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-CFML000058,',
                ErrorColumn = ErrorColumn + @ColName1 + ','
    END

    FETCH NEXT FROM @Cur INTO @InventoryID
END

CLOSE @Cur

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                            ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

DECLARE @OutputInventoryIDAPK TABLE (APK NVARCHAR(250),InventoryID NVARCHAR(250))

--INSERT AT1302
INSERT INTO AT1302
(
DivisionID, --NormMethod, 
CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID,
AccountID, SalesAccountID, PrimeCostAccountID, PurchaseAccountID, RefInventoryID,
VATGroupID, VATPercent, VATImGroupID, VATImPercent, MethodID,
IsStocked, IsDiscount, IsSource, IsLimitDate, Specification,
SalePrice01, SalePrice02, SalePrice03, SalePrice04, SalePrice05, RecievedPrice, DeliveryPrice,
S1, S2, S3, PurchasePrice01, PurchasePrice02, PurchasePrice03, PurchasePrice04, PurchasePrice05,
I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, Varchar06,
Notes01, Notes02, Notes03, Notes04, Notes05, Disabled, IsCommon, ProductTypeID, IsVIP
)
OUTPUT INSERTED.APK,INSERTED.InventoryID INTO @OutputInventoryIDAPK(APK, InventoryID)
SELECT DivisionID, --NormMethod, 
GETDATE(), @UserID, GETDATE(), @UserID,
Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID,
AccountID, SalesAccountID, PrimeCostAccountID, PurchaseAccountID, RefInventoryID,
VATGroupID, VATPercent, VATImGroupID, VATImPercent, CASE WHEN MethodID IS NULL THEN 4 ELSE MethodID END,
CASE WHEN IsStocked IS NULL THEN 0 ELSE IsStocked END IsStocked, 
CASE WHEN IsDiscount IS NULL THEN 0 ELSE IsDiscount END IsDiscount, 
CASE WHEN IsSource IS NULL THEN 0 ELSE IsSource END IsSource, 
CASE WHEN IsLimitDate IS NULL THEN 0 ELSE IsLimitDate END IsLimitDate, 
Specification,
SalePrice01, SalePrice02, SalePrice03, SalePrice04, SalePrice05, RecievedPrice, DeliveryPrice,
S1, S2, S3, PurchasePrice01, PurchasePrice02, PurchasePrice03, PurchasePrice04, PurchasePrice05,
I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, Varchar06,
Notes01, Notes02, Notes03, Notes04, Notes05, 
CASE WHEN Disabled IS NULL THEN 0 ELSE Disabled END Disabled, 
CASE WHEN IsCommon IS NULL THEN 0 ELSE IsCommon END IsCommon, 
(CASE WHEN ProductTypeID NOT IN (1,2,3) THEN 1 ELSE ProductTypeID END)
, IsVIP
FROM #Data

SELECT  InventoryID,        
        LTRIM(RTRIM(SUBSTRING(valueTable.G05AccountID, nums.n, charindex(N';', valueTable.G05AccountID + N';', nums.n) - nums.n))) AS [Value]
INTO #TempG05AccountID
FROM   (SELECT ROW_NUMBER() OVER(ORDER BY c) AS n FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS B) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS B) AS B) L3) AS nums 
INNER JOIN #Data AS valueTable ON nums.n <= CONVERT(int, LEN(valueTable.G05AccountID)) AND SUBSTRING(N';' + valueTable.G05AccountID, n, 1) = N';' 

SELECT  InventoryID,        
        LTRIM(RTRIM(SUBSTRING(valueTable.G07AccountID, nums.n, charindex(N';', valueTable.G07AccountID + N';', nums.n) - nums.n))) AS [Value]
INTO #TempG07AccountID
FROM   (SELECT ROW_NUMBER() OVER(ORDER BY c) AS n FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS B) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS A, (SELECT 1 AS c FROM (SELECT 1 AS c UNION ALL SELECT 1) AS A, (SELECT 1 AS c UNION ALL SELECT 1) AS B
) AS B) AS B) AS B) L3) AS nums 
INNER JOIN #Data AS valueTable ON nums.n <= CONVERT(int, LEN(valueTable.G07AccountID)) AND SUBSTRING(N';' + valueTable.G07AccountID, n, 1) = N';' 


--INSERT AT1312 'G05'
INSERT AT1312( DivisionID, InventoryID, AccountID, GroupID )
SELECT @DivisionID AS DivisionID, A.InventoryID AS InventoryID, A.Value AS AccountID, 'G05' AS GroupID
FROM #TempG05AccountID AS A
WHERE ISNULL(A.Value, '') <> ''

--INSERT AT1312 'G07'
INSERT AT1312( DivisionID, InventoryID, AccountID, GroupID )
SELECT @DivisionID AS DivisionID, A.InventoryID AS InventoryID, A.Value AS AccountID, 'G07' AS GroupID
FROM #TempG07AccountID AS A
WHERE ISNULL(A.Value, '') <> ''

--Lich su
INSERT INTO CIT00003(APK,DivisionID,HistoryID,Description,RelatedToID,RelatedToTypeID,CreateDate,CreateUserID,StatusID,ScreenID,TableID)
SELECT NEWID() AS APK, @DivisionID AS DivisionID, NULL AS HistoryID, 
'''A00.AddNew'' ''A00.AT1302''</br>''A00.AddNew'' ''A00.AT1302''</br>' AS Description, 
APK AS RelatedToID, 47 AS RelatedToTypeID, GETDATE() AS CreateDate, @UserID AS CreateUserID, 
1 AS StatusID, 'CIF1171' AS ScreenID, 'AT1302' AS TableID
FROM @OutputInventoryIDAPK

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

END