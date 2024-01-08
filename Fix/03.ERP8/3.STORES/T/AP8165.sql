IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[AP8165]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[AP8165];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO



-- <Summary>
----    Thực hiện đẩy dữ liệu import excel bộ định mức vào db
-- <Param>
---- 
-- <Return>
---- 
---- 
-- <History>
---- Create  on 21/12/2020 by Đức Thông
---- Updated on 12/01/2021 by Đức Thông [FL] 2020/12/IS/0312: Fix lỗi insert thiếu DivisionID, sinh guild cho ApportionProductID
---- Updated on 13/01/2021 by Đức Thông [FL] 2020/12/IS/0312: Fix lỗi insert sai DivisionID vào bảng tạm
---- Updated on 30/06/2021 by Nhựt Trường: Bổ sung hàm ISNULL() ở một số trường kiểu số.
---- Updated on 06/07/2021 by Nhựt Trường: Bổ sung Distinct khi select dữ liệu đẩy vào bảng bảng Master.
---- Modified on 11/02/2023 by Đức Tuyên : Điều chỉnh thành store AP8165
-- <Example>
CREATE PROCEDURE AP8165
(
    @DivisionID AS NVARCHAR(50),
    @UserID AS NVARCHAR(50),
    @ImportTemplateID AS NVARCHAR(50) = NULL, -- ERP8
    @XML AS XML
)
AS
DECLARE @cCURSOR AS CURSOR,
        @sSQL AS VARCHAR(1000);

DECLARE @ColID AS NVARCHAR(50),
        @ColSQLDataType AS NVARCHAR(50);

CREATE TABLE #Data
(
    APK UNIQUEIDENTIFIER
        DEFAULT (NEWID()),
    Row INT,
    TransactionID NVARCHAR(50),
    ImportMessage NVARCHAR(500)
        DEFAULT (''),
    ErrorMessage NVARCHAR(MAX)
        DEFAULT (''),
    ErrorColumn NVARCHAR(MAX)
        DEFAULT (''),
    ObjectName NVARCHAR(250),
    Address NVARCHAR(250),
    InventoryCommonName NVARCHAR(250),
    CONSTRAINT [PK_#Data]
        PRIMARY KEY CLUSTERED (Row ASC) ON [PRIMARY]
);

CREATE TABLE #Keys
(
    Row INT,
    TransactionID NVARCHAR(50),
    CONSTRAINT [PK_#Keys]
        PRIMARY KEY CLUSTERED (Row ASC) ON [PRIMARY]
);

DECLARE @QuantityDecimal TINYINT
SELECT TOP 1 @QuantityDecimal = QuantityDecimal FROM MT0000 WHERE DivisionID = @DivisionID

SET @cCURSOR = CURSOR STATIC FOR
SELECT TLD.ColID,
       BTL.ColSQLDataType
FROM A01065 TL
    INNER JOIN A01066 TLD
        ON TL.ImportTemplateID = TLD.ImportTemplateID
    INNER JOIN A00065 BTL
        ON BTL.ImportTransTypeID = TL.ImportTransTypeID
           AND BTL.ColID = TLD.ColID
WHERE TL.ImportTemplateID = @ImportTemplateID
ORDER BY TLD.OrderNum;

OPEN @cCURSOR;
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR
INTO @ColID,
     @ColSQLDataType;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + ' NULL';
    --PRINT @sSQL
    IF 'OrderDate' = @ColID
        PRINT @ColSQLDataType;
    EXEC (@sSQL);
    FETCH NEXT FROM @cCURSOR
    INTO @ColID,
         @ColSQLDataType;
END;

CLOSE @cCURSOR;

---Lấy dữ liệu từ XML:
SELECT X.Data.query('Row').value('.', 'INT') AS Row,       
       X.Data.query('Period').value('.', 'NVARCHAR(50)') AS Period,
       X.Data.query('ApportionID').value('.', 'NVARCHAR(50)') AS ApportionID,
       X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') AS InventoryTypeID,
       X.Data.query('Disabled').value('.', 'TINYINT') AS Disabled,
       X.Data.query('ApportionIDOld').value('.', 'NVARCHAR(50)') AS ApportionIDOld,
       X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
       X.Data.query('IsBOM').value('.', 'TINYINT') AS IsBOM,
       X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
       X.Data.query('AdjustDate').value('.', 'DATETIME') AS AdjustDate,
       X.Data.query('ApportionProductID').value('.', 'NVARCHAR(50)') AS ApportionProductID,
       X.Data.query('MaterialID').value('.', 'NVARCHAR(50)') AS MaterialID,
       X.Data.query('ProductID').value('.', 'NVARCHAR(50)') AS ProductID,
       X.Data.query('MaterialTypeID').value('.', 'NVARCHAR(50)') AS MaterialTypeID,
       ISNULL(X.Data.query('Rate').value('.', 'DECIMAL(28,8)'), NULL) AS Rate,
       X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
       X.Data.query('ExpenseID').value('.', 'NVARCHAR(50)') AS ExpenseID,
       ISNULL(X.Data.query('DiminishPercent').value('.', 'DECIMAL(28,8)'),NULL) AS DiminishPercent,
       ISNULL(X.Data.query('MaterialAmount').value('.', 'DECIMAL(28,8)'),NULL) AS MaterialAmount,
       X.Data.query('ProductQuantity').value('.', 'DECIMAL(28,8)') AS ProductQuantity,
       X.Data.query('DetailUse').value('.', 'NVARCHAR(250)') AS DetailUse,
       X.Data.query('QuantityUnit').value('.', 'DECIMAL(28,8)') AS QuantityUnit,
       ISNULL(X.Data.query('ConvertedUnit').value('.', 'DECIMAL(28,8)'),NULL) AS ConvertedUnit,
       X.Data.query('MaterialQuantity').value('.', 'DECIMAL(28,8)') AS MaterialQuantity,
       X.Data.query('MaterialUnitID').value('.', 'NVARCHAR(50)') AS MaterialUnitID,
       ISNULL(X.Data.query('MaterialPrice').value('.', 'DECIMAL(28,8)'),NULL) AS MaterialPrice,
       X.Data.query('IsExtraMaterial').value('.', 'TINYINT') AS IsExtraMaterial,
       X.Data.query('MaterialGroupID').value('.', 'NVARCHAR(50)') AS MaterialGroupID,
       ISNULL(X.Data.query('RateWastage').value('.', 'DECIMAL(28,8)'),NULL) AS RateWastage,
       X.Data.query('MParameter01').value('.', 'NVARCHAR(1000)') AS MParameter01,
       X.Data.query('MParameter02').value('.', 'NVARCHAR(1000)') AS MParameter02,
       X.Data.query('MParameter03').value('.', 'NVARCHAR(1000)') AS MParameter03,
       X.Data.query('DParameter01').value('.', 'NVARCHAR(1000)') AS DParameter01,
       X.Data.query('DParameter02').value('.', 'NVARCHAR(1000)') AS DParameter02,
       X.Data.query('DParameter03').value('.', 'NVARCHAR(1000)') AS DParameter03,
       X.Data.query('WasteID').value('.', 'NVARCHAR(50)') AS WasteID,
       X.Data.query('PhaseID').value('.', 'VARCHAR(25)') AS PhaseID,
       ISNULL(X.Data.query('StandardMaterialPrice').value('.', 'DECIMAL(28,8)'),NULL) AS StandardMaterialPrice,
       X.Data.query('StandardMaterialQuantity').value('.', 'DECIMAL(28,8)') AS StandardMaterialQuantity,
       ISNULL(X.Data.query('StandardQuantityUnit').value('.', 'DECIMAL(28,8)'),NULL) AS StandardQuantityUnit,
       ISNULL(X.Data.query('Parameter01').value('.', 'DECIMAL(28,8)'),NULL) AS Parameter01,
       ISNULL(X.Data.query('Parameter02').value('.', 'DECIMAL(28,8)'),NULL) AS Parameter02,
       ISNULL(X.Data.query('Parameter03').value('.', 'DECIMAL(28,8)'),NULL) AS Parameter03,
       ISNULL(X.Data.query('Parameter04').value('.', 'DECIMAL(28,8)'),NULL) AS Parameter04,
       ISNULL(X.Data.query('Parameter05').value('.', 'DECIMAL(28,8)'),NULL) AS Parameter05,
	   @DivisionID AS DivisionID
INTO #AP8165
FROM @XML.nodes('//Data') AS X(Data);

-- Insert dữ liệu vào bảng tạm
INSERT INTO #Data
(
    Row,
    DivisionID,    
    ApportionID,
    InventoryTypeID,
    Disabled,
    ApportionIDOld,
    Description,
    IsBOM,
    EmployeeID,
    AdjustDate,
    ApportionProductID,
    MaterialID,
    ProductID,
    MaterialTypeID,
    Rate,
    UnitID,
    ExpenseID,
    DiminishPercent,
    MaterialAmount,
    ProductQuantity,
    DetailUse,
    QuantityUnit,
    ConvertedUnit,
    MaterialQuantity,
    MaterialUnitID,
    MaterialPrice,
    IsExtraMaterial,
    MaterialGroupID,
    RateWastage,
    MParameter01,
    MParameter02,
    MParameter03,
    DParameter01,
    DParameter02,
    DParameter03,
    WasteID,
    PhaseID,
    StandardMaterialPrice,
    StandardMaterialQuantity,
    StandardQuantityUnit,
    Parameter01,
    Parameter02,
    Parameter03,
    Parameter04,
    Parameter05
)
SELECT Row,       
       DivisionID,
       ApportionID,
       InventoryTypeID,
       Disabled,
       ApportionIDOld,
       Description,
       IsBOM,
       EmployeeID,
       AdjustDate,
       ApportionProductID,
       MaterialID,
       ProductID,
       MaterialTypeID,
       Rate,
       UnitID,
       ExpenseID,
       DiminishPercent,
       MaterialAmount,
       ProductQuantity,
       DetailUse,
       QuantityUnit,
       ConvertedUnit,
       MaterialQuantity,
       MaterialUnitID,
       MaterialPrice,
       IsExtraMaterial,
       MaterialGroupID,
       RateWastage,
       MParameter01,
       MParameter02,
       MParameter03,
       DParameter01,
       DParameter02,
       DParameter03,
       WasteID,
       PhaseID,
       StandardMaterialPrice,
       StandardMaterialQuantity,
       StandardQuantityUnit,
       Parameter01,
       Parameter02,
       Parameter03,
       Parameter04,
       Parameter05
FROM #AP8165;

UPDATE #Data SET ApportionProductID = NEWID()

---- Kiểm tra check code mặc định(Thiết lập trong dữ liệu ngầm)
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID;


-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
    GOTO LB_RESULT;


-- Đẩy dữ liệu vào bảng master
INSERT INTO MT1602
(
    DivisionID,
    ApportionID,
    InventoryTypeID,
    Disabled,
    ApportionIDOld,
    Description,
    IsBOM,
    EmployeeID,
    AdjustDate
)
SELECT DISTINCT DivisionID,
       ApportionID,
       InventoryTypeID,
       Disabled,
       ApportionIDOld,
       Description,
       IsBOM,
       EmployeeID,
       AdjustDate
FROM #Data;

-- Đẩy dữ liệu vào bảng Detail
INSERT INTO MT1603
(
    DivisionID,
	ApportionID,
	ApportionProductID,
    MaterialID,
    ProductID,
    MaterialTypeID,
    Rate,
    UnitID,
    ExpenseID,
    DiminishPercent,
    MaterialAmount,
    ProductQuantity,
    DetailUse,
    QuantityUnit,
    ConvertedUnit,
    MaterialQuantity,
    MaterialUnitID,
    MaterialPrice,
    IsExtraMaterial,
    MaterialGroupID,
    RateWastage,
    MParameter01,
    MParameter02,
    MParameter03,
    DParameter01,
    DParameter02,
    DParameter03,
    WasteID,
    PhaseID,
    StandardMaterialPrice,
    StandardMaterialQuantity,
    StandardQuantityUnit,
    Parameter01,
    Parameter02,
    Parameter03,
    Parameter04,
    Parameter05
)
SELECT 
	   DivisionID,
	   ApportionID,
	   ApportionProductID,
       MaterialID,
       ProductID,
       MaterialTypeID,
       Rate,
       UnitID,
       ExpenseID,
       DiminishPercent,
       MaterialAmount,
       ROUND(ProductQuantity,@QuantityDecimal),
       DetailUse,
       ROUND(QuantityUnit,@QuantityDecimal),
       ROUND(ConvertedUnit,@QuantityDecimal),
       ROUND(MaterialQuantity,@QuantityDecimal)y,
       MaterialUnitID,
       ROUND(MaterialPrice,@QuantityDecimal),
       IsExtraMaterial,
       MaterialGroupID,
       RateWastage,
       MParameter01,
       MParameter02,
       MParameter03,
       DParameter01,
       DParameter02,
       DParameter03,
       WasteID,
       PhaseID,
       ROUND(StandardMaterialPrice,@QuantityDecimal),
       ROUND(StandardMaterialQuantity,@QuantityDecimal),
       ROUND(StandardQuantityUnit,@QuantityDecimal),
       Parameter01,
       Parameter02,
       Parameter03,
       Parameter04,
       Parameter05
FROM #Data;


LB_RESULT:
SELECT *
FROM #Data;
GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO