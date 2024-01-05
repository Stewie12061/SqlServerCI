IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2125]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2125]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel danh mục Định mức sản phẩm MF2120 - ERP9
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Lê Hoàng on 09/06/2021
---- Modified by Lê Hoàng on 29/06/2021 : kiểm tra thêm điều kiện khi sử dụng quy cách
---- Modified by Trọng Phúc 08/08/2023: lỗi hiển thị chi tiết khi import dữ liệu
-- <Example>

CREATE PROCEDURE MP2125
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@ImportTransTypeID VARCHAR(50),
	@XML XML
) 
AS
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

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('Number').value('.','INT') AS Number,
		X.Data.query('InheritID').value('.','INT') AS InheritID,
		X.Data.query('InventoryTypeID').value('.','INT') AS InventoryTypeID,
		X.Data.query('ProductID').value('.','NVARCHAR(250)') AS ProductID,
		X.Data.query('CreateBOMVersion').value('.','VARCHAR(50)') AS CreateBOMVersion,
		(CASE WHEN X.Data.query('ObjectID').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('ObjectID').value('.', 'VARCHAR(50)') END) AS ObjectID,
		(CASE WHEN X.Data.query('StartDate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('StartDate').value('.', 'VARCHAR(50)') END) AS StartDate,
		(CASE WHEN X.Data.query('EndDate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(VARCHAR(50), NULL)
			  ELSE X.Data.query('EndDate').value('.', 'VARCHAR(50)') END) AS EndDate,
		X.Data.query('RoutingID').value('.','NVARCHAR(50)') AS RoutingID,
		X.Data.query('Description').value('.','NVARCHAR(MAX)') AS Description,
		X.Data.query('NodeTypeID').value('.','NVARCHAR(50)') AS NodeTypeID,
		X.Data.query('NodeChild').value('.','NVARCHAR(50)') AS NodeChild,
		(CASE WHEN X.Data.query('NodeParent').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('NodeParent').value('.', 'NVARCHAR(50)') END) AS NodeParent,
		X.Data.query('DisplayName').value('.','NVARCHAR(50)') AS DisplayName,
		X.Data.query('DictatesID').value('.','NVARCHAR(50)') AS DictatesID,
		X.Data.query('OutsourceID').value('.','NVARCHAR(50)') AS OutsourceID,
		X.Data.query('PhaseID').value('.','NVARCHAR(50)') AS PhaseID,
		(CASE WHEN X.Data.query('S01ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S01ID').value('.', 'NVARCHAR(50)') END) AS S01ID,
		(CASE WHEN X.Data.query('S02ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S02ID').value('.', 'NVARCHAR(50)') END) AS S02ID,
		(CASE WHEN X.Data.query('S03ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S03ID').value('.', 'NVARCHAR(50)') END) AS S03ID,
		(CASE WHEN X.Data.query('S04ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S04ID').value('.', 'NVARCHAR(50)') END) AS S04ID,
		(CASE WHEN X.Data.query('S05ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S05ID').value('.', 'NVARCHAR(50)') END) AS S05ID,
		(CASE WHEN X.Data.query('S06ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S06ID').value('.', 'NVARCHAR(50)') END) AS S06ID,
		(CASE WHEN X.Data.query('S07ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S07ID').value('.', 'NVARCHAR(50)') END) AS S07ID,
		(CASE WHEN X.Data.query('S08ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S08ID').value('.', 'NVARCHAR(50)') END) AS S08ID,
		(CASE WHEN X.Data.query('S09ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S09ID').value('.', 'NVARCHAR(50)') END) AS S09ID,
		(CASE WHEN X.Data.query('S10ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S10ID').value('.', 'NVARCHAR(50)') END) AS S10ID,
		(CASE WHEN X.Data.query('S11ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S11ID').value('.', 'NVARCHAR(50)') END) AS S11ID,
		(CASE WHEN X.Data.query('S12ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S12ID').value('.', 'NVARCHAR(50)') END) AS S12ID,
		(CASE WHEN X.Data.query('S13ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S13ID').value('.', 'NVARCHAR(50)') END) AS S13ID,
		(CASE WHEN X.Data.query('S14ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S14ID').value('.', 'NVARCHAR(50)') END) AS S14ID,
		(CASE WHEN X.Data.query('S15ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S15ID').value('.', 'NVARCHAR(50)') END) AS S15ID,
		(CASE WHEN X.Data.query('S16ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S16ID').value('.', 'NVARCHAR(50)') END) AS S16ID,
		(CASE WHEN X.Data.query('S17ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S17ID').value('.', 'NVARCHAR(50)') END) AS S17ID,
		(CASE WHEN X.Data.query('S18ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S18ID').value('.', 'NVARCHAR(50)') END) AS S18ID,
		(CASE WHEN X.Data.query('S19ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S19ID').value('.', 'NVARCHAR(50)') END) AS S19ID,
		(CASE WHEN X.Data.query('S20ID').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('S20ID').value('.', 'NVARCHAR(50)') END) AS S20ID,
		X.Data.query('QuantitativeType').value('.','NVARCHAR(50)') AS QuantitativeType,
		(CASE WHEN X.Data.query('QuantitativeValue').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('QuantitativeValue').value('.', 'DECIMAL(28,8)') END) AS QuantitativeValue,
		(CASE WHEN X.Data.query('LossValue').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('LossValue').value('.', 'DECIMAL(28,8)') END) AS LossValue,
		X.Data.query('MaterialGroupID').value('.','NVARCHAR(50)') AS MaterialGroupID,
		X.Data.query('MaterialID').value('.','NVARCHAR(50)') AS MaterialID,
		(CASE WHEN X.Data.query('MaterialConstant').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28,8), NULL)
			  ELSE X.Data.query('MaterialConstant').value('.', 'DECIMAL(28,8)') END) AS MaterialConstant
INTO #MP2125
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row],DivisionID,Number,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,
RoutingID,Description,NodeTypeID,NodeChild,NodeParent,DisplayName,DictatesID,OutsourceID,PhaseID,
S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID,
QuantitativeType,QuantitativeValue,LossValue,MaterialGroupID,MaterialID,MaterialConstant)
SELECT Row, DivisionID, Number, InheritID, InventoryTypeID, ProductID, CreateBOMVersion,ObjectID,StartDate,EndDate,
RoutingID,Description,NodeTypeID,NodeChild,NodeParent,DisplayName,DictatesID,OutsourceID,PhaseID,
S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID,
QuantitativeType,QuantitativeValue,LossValue,MaterialGroupID,MaterialID,MaterialConstant
FROM #MP2125

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu có đồng nhất hay không
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',
@Module = 'ASOFT-M', @ColID = 'Number', @Param1 = 'DivisionID,Number,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description'

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

---- Kiểm tra tồn tại ProductID
DECLARE @cCURCHECK CURSOR,
		@ck_Number INT,
        @ck_DivisionID NVARCHAR(50),
		@ck_InheritID INT,
		@ck_NodeTypeID INT,
		@ck_NodeID NVARCHAR(50),
		@ck_ColumnName NVARCHAR(50),
		@ck_ColName NVARCHAR(50)

DECLARE @Order INT = 0
SET @cCURCHECK = CURSOR STATIC FOR
	SELECT DivisionID,Number,InheritID,InventoryTypeID,ProductID
	FROM #Data
	GROUP BY DivisionID,Number,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description
OPEN @cCURCHECK
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURCHECK INTO @ck_DivisionID,@ck_Number,@ck_InheritID,@ck_NodeTypeID,@ck_NodeID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@ck_InheritID = 0)
	BEGIN
		--bom version  MT2122
		IF NOT EXISTS (SELECT TOP 1 1 FROM MT2122 WITH(NOLOCK) WHERE DivisionID = @ck_DivisionID AND NodeTypeID = @ck_NodeTypeID AND NodeID = @ck_NodeID)
		BEGIN
			SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProductID'
			UPDATE	#Data 
			SET	ErrorMessage = @ck_ColumnName + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = @ck_ColName+','
			WHERE Number = @ck_Number AND ProductID = @ck_NodeID
		END
	END
	ELSE IF (@ck_InheritID = 1)
	BEGIN
		--cấu trúc sản phẩm  MT2110
		IF NOT EXISTS (SELECT TOP 1 1 FROM MT2110 WITH(NOLOCK) WHERE DivisionID = @ck_DivisionID AND NodeTypeID = @ck_NodeTypeID AND NodeID = @ck_NodeID)
		BEGIN
			SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProductID'
			UPDATE	#Data 
			SET	ErrorMessage = @ck_ColumnName + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = @ck_ColName+','
			WHERE Number = @ck_Number AND ProductID = @ck_NodeID
		END
	END
	FETCH NEXT FROM @cCURCHECK INTO @ck_DivisionID,@ck_Number,@ck_InheritID,@ck_NodeTypeID,@ck_NodeID
END
CLOSE @cCURCHECK

---- Kiểm tra tồn tại MaterialID trong MaterialGroupID
DECLARE @ck_MaterialGroupID NVARCHAR(50),
        @ck_MaterialID NVARCHAR(50)
SET @Order = 0
SET @cCURCHECK = CURSOR STATIC FOR
	SELECT DivisionID,Row,MaterialGroupID,MaterialID
	FROM #Data
OPEN @cCURCHECK
FETCH NEXT FROM @cCURCHECK INTO @ck_DivisionID,@ck_Number,@ck_MaterialGroupID,@ck_MaterialID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT * FROM MT0007 WITH(NOLOCK) WHERE DivisionID IN (@ck_DivisionID,'@@@') AND MaterialGroupID = @ck_MaterialGroupID AND MaterialID = @ck_MaterialID) AND
	   ISNULL(@ck_NodeID,'') <> ''
	BEGIN
		SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'MaterialID'
		UPDATE	#Data 
		SET	ErrorMessage = @ck_ColumnName + LTRIM(RTRIM(STR([Row]))) +'-EDMFML000072,',
			ErrorColumn = @ck_ColName+','
		WHERE Row = @ck_Number
	END
	FETCH NEXT FROM @cCURCHECK INTO @ck_DivisionID,@ck_Number,@ck_MaterialGroupID,@ck_MaterialID
END
CLOSE @cCURCHECK


---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND ISNULL(IsSpecificate,0) = 0)
BEGIN
	SELECT InheritID, ProductID, COUNT(Number) CountN INTO #TempCheckExists FROM (
	SELECT InheritID, ProductID, Number FROM #Data 
	WHERE InheritID = 1
	GROUP BY Number, InheritID, ProductID) A
	GROUP BY InheritID, ProductID

	---- Kiểm tra tồn tại trùng InheritID = 1 , ProductID trong cùng file import
	SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProductID'
	UPDATE #Data 
	SET ErrorMessage = ErrorMessage + @ck_ColumnName + '-ASML000088,',
		ErrorColumn = ErrorColumn + @ck_ColName + ','
	FROM #Data R00
	INNER JOIN (SELECT InheritID, ProductID FROM #TempCheckExists 
			    WHERE InheritID = 1 AND CountN > 1) R01 ON R01.InheritID = R00.InheritID AND R01.ProductID = R00.ProductID
	
	---- Kiểm tra tồn tại trùng InheritID = 1 , ProductID trong database
	SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProductID'
	UPDATE #Data 
	SET ErrorMessage = ErrorMessage + @ck_ColumnName + '-ASML000088,',
		ErrorColumn = ErrorColumn + @ck_ColName + ','
	FROM #Data R00
	INNER JOIN (SELECT InheritID, NodeID FROM MT2120 WITH(NOLOCK)
			    WHERE InheritID = 1
			    GROUP BY InheritID, NodeID) R01 ON R01.InheritID = R00.InheritID AND R01.NodeID = R00.ProductID
END
ELSE
BEGIN
	SELECT InheritID,ProductID,S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
		   S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID,COUNT(Number) CountN 
	INTO #TempCheckExistsSP FROM (
	SELECT InheritID,ProductID,S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
		   S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID,Number FROM #Data 
	WHERE InheritID = 1
	GROUP BY Number,InheritID,ProductID,S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
		   S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID) A
	GROUP BY InheritID,ProductID,S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
		   S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID
	
	---- Kiểm tra tồn tại trùng InheritID = 1 , ProductID trong cùng file import (có quy cách)
	SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProductID'
	UPDATE #Data 
	SET ErrorMessage = ErrorMessage + @ck_ColumnName + '-ASML000088,',
		ErrorColumn = ErrorColumn + @ck_ColName + ','
	FROM #Data R00
	INNER JOIN (SELECT InheritID,ProductID,S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
		   S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID FROM #TempCheckExistsSP WHERE InheritID = 1 AND CountN > 1) R01 
		ON R01.InheritID = R00.InheritID AND R01.ProductID = R00.ProductID AND
		   ISNULL(R01.S01ID,'') = ISNULL(R00.S01ID,'') AND ISNULL(R01.S02ID,'') = ISNULL(R00.S02ID,'') AND ISNULL(R01.S03ID,'') = ISNULL(R00.S03ID,'') AND ISNULL(R01.S04ID,'') = ISNULL(R00.S04ID,'') AND 
		   ISNULL(R01.S05ID,'') = ISNULL(R00.S05ID,'') AND ISNULL(R01.S06ID,'') = ISNULL(R00.S06ID,'') AND ISNULL(R01.S07ID,'') = ISNULL(R00.S07ID,'') AND ISNULL(R01.S08ID,'') = ISNULL(R00.S08ID,'') AND 
		   ISNULL(R01.S09ID,'') = ISNULL(R00.S09ID,'') AND ISNULL(R01.S10ID,'') = ISNULL(R00.S10ID,'') AND ISNULL(R01.S11ID,'') = ISNULL(R00.S11ID,'') AND ISNULL(R01.S12ID,'') = ISNULL(R00.S12ID,'') AND 
		   ISNULL(R01.S13ID,'') = ISNULL(R00.S13ID,'') AND ISNULL(R01.S14ID,'') = ISNULL(R00.S14ID,'') AND ISNULL(R01.S15ID,'') = ISNULL(R00.S15ID,'') AND ISNULL(R01.S16ID,'') = ISNULL(R00.S16ID,'') AND 
		   ISNULL(R01.S17ID,'') = ISNULL(R00.S17ID,'') AND ISNULL(R01.S18ID,'') = ISNULL(R00.S18ID,'') AND ISNULL(R01.S19ID,'') = ISNULL(R00.S19ID,'') AND ISNULL(R01.S20ID,'') = ISNULL(R00.S20ID,'')  

	---- Kiểm tra tồn tại trùng InheritID = 1 , ProductID trong database (có quy cách)
	SELECT TOP 1 @ck_ColumnName = DataCol, @ck_ColName = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProductID'
	UPDATE #Data 
	SET ErrorMessage = ErrorMessage + @ck_ColumnName + '-ASML000088,',
		ErrorColumn = ErrorColumn + @ck_ColName + ','
	FROM #Data R00
	INNER JOIN (SELECT DISTINCT MT2120.InheritID, MT2121.NodeID, 
					MT8899.S01ID,MT8899.S02ID,MT8899.S03ID,MT8899.S04ID,MT8899.S05ID,
					MT8899.S06ID,MT8899.S07ID,MT8899.S08ID,MT8899.S09ID,MT8899.S10ID,
					MT8899.S11ID,MT8899.S12ID,MT8899.S13ID,MT8899.S14ID,MT8899.S15ID,
					MT8899.S16ID,MT8899.S17ID,MT8899.S18ID,MT8899.S19ID,MT8899.S20ID FROM MT2121 WITH(NOLOCK)
				LEFT JOIN MT2120 WITH(NOLOCK) ON MT2121.NodeID = MT2120.NodeID 
				LEFT JOIN MT8899 WITH(NOLOCK) ON MT8899.TableID = 'MT2121' AND MT8899.VoucherID = CONVERT(NVARCHAR(50),MT2121.APKMaster) AND MT8899.TransactionID = CONVERT(NVARCHAR(50),MT2121.APK)
				WHERE MT2120.NodeID IS NOT NULL AND MT2120.InheritID = 1
			    GROUP BY MT2120.InheritID, MT2121.NodeID, MT8899.S01ID,MT8899.S02ID,MT8899.S03ID,MT8899.S04ID,MT8899.S05ID,
					MT8899.S06ID,MT8899.S07ID,MT8899.S08ID,MT8899.S09ID,MT8899.S10ID,
					MT8899.S11ID,MT8899.S12ID,MT8899.S13ID,MT8899.S14ID,MT8899.S15ID,
					MT8899.S16ID,MT8899.S17ID,MT8899.S18ID,MT8899.S19ID,MT8899.S20ID) R01 
		ON R01.InheritID = R00.InheritID AND R01.NodeID = R00.ProductID AND
		   ISNULL(R01.S01ID,'') = ISNULL(R00.S01ID,'') AND ISNULL(R01.S02ID,'') = ISNULL(R00.S02ID,'') AND ISNULL(R01.S03ID,'') = ISNULL(R00.S03ID,'') AND ISNULL(R01.S04ID,'') = ISNULL(R00.S04ID,'') AND 
		   ISNULL(R01.S05ID,'') = ISNULL(R00.S05ID,'') AND ISNULL(R01.S06ID,'') = ISNULL(R00.S06ID,'') AND ISNULL(R01.S07ID,'') = ISNULL(R00.S07ID,'') AND ISNULL(R01.S08ID,'') = ISNULL(R00.S08ID,'') AND 
		   ISNULL(R01.S09ID,'') = ISNULL(R00.S09ID,'') AND ISNULL(R01.S10ID,'') = ISNULL(R00.S10ID,'') AND ISNULL(R01.S11ID,'') = ISNULL(R00.S11ID,'') AND ISNULL(R01.S12ID,'') = ISNULL(R00.S12ID,'') AND 
		   ISNULL(R01.S13ID,'') = ISNULL(R00.S13ID,'') AND ISNULL(R01.S14ID,'') = ISNULL(R00.S14ID,'') AND ISNULL(R01.S15ID,'') = ISNULL(R00.S15ID,'') AND ISNULL(R01.S16ID,'') = ISNULL(R00.S16ID,'') AND 
		   ISNULL(R01.S17ID,'') = ISNULL(R00.S17ID,'') AND ISNULL(R01.S18ID,'') = ISNULL(R00.S18ID,'') AND ISNULL(R01.S19ID,'') = ISNULL(R00.S19ID,'') AND ISNULL(R01.S20ID,'') = ISNULL(R00.S20ID,'')  
END

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

SELECT NEWID() APK,DivisionID,Number,InheritID,InventoryTypeID NodeTypeID,ProductID NodeID, '' NodeName, '' UnitID, CreateBOMVersion,
ObjectID,StartDate,EndDate,RoutingID,Description, 0 Version, NULL QuantityVersion,
@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
INTO #TempMaster
FROM #Data
GROUP BY DivisionID,Number,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description

DECLARE @cCURINSERT CURSOR,
		@in_Number INT,
		@in_APK NVARCHAR(50),
        @in_DivisionID NVARCHAR(50),
		@in_InheritID INT,
		@in_NodeTypeID INT,
		@in_NodeID NVARCHAR(50),
		@in_CreateBOMVersion INT,
		@in_ObjectID NVARCHAR(50),
		@in_StartDate VARCHAR(50),
		@in_EndDate VARCHAR(50),
		@in_RoutingID NVARCHAR(50),
		@in_Description NVARCHAR(250)

SET @Order = 0
SET @cCURINSERT = CURSOR STATIC FOR
	SELECT APK,DivisionID,Number,InheritID,NodeTypeID,NodeID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description
	FROM #TempMaster R01 WITH (NOLOCK)
OPEN @cCURINSERT
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURINSERT INTO @in_APK,@in_DivisionID,@in_Number,@in_InheritID,@in_NodeTypeID,@in_NodeID,@in_CreateBOMVersion,@in_ObjectID,@in_StartDate,@in_EndDate,@in_RoutingID,@in_Description
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT Row INTO #TempRowParent FROM #Data WHERE NodeParent = ProductID AND NodeParent = NodeChild
	
	DECLARE @Version INT = 0,
			@in_Version INT = 0
	SELECT @Version = COUNT(NodeID) FROM MT2122 WHERE DivisionID IN (@in_DivisionID,'@@@') AND NodeID = @in_NodeID

	IF (@in_CreateBOMVersion = 1 OR @Version = 0)
	BEGIN
		SET @in_Version = @Version
	END
	ELSE
	BEGIN
		SET @in_Version = 0
	END
	
	IF (@in_InheritID <> 0)
	BEGIN
		
		UPDATE #TempMaster SET Version = @in_Version WHERE APk = @in_APK

		INSERT INTO [dbo].[MT2120]
           ([APK],[DivisionID],[NodeTypeID],[NodeID],[NodeName],[InheritID],[UnitID],[ObjectID],[Description],[StartDate],[EndDate]
           ,[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate],[Version],[RoutingID],[QuantityVersion])
		SELECT APK,DivisionID,NodeTypeID,NodeID,NodeName,InheritID,UnitID,ObjectID,Description,CONVERT(DATETIME,StartDate,103) StartDate,CONVERT(DATETIME,EndDate,103) EndDate
			  ,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,Version,RoutingID,QuantityVersion
		FROM #TempMaster
		WHERE APK = @in_APK

		
		--Nếu InheritID = 1 thì lưu vào MT2120, MT2121
		SELECT CASE WHEN ISNULL(NodeParent,'') = '' THEN '00000000-0000-0000-0000-000000000000' ELSE NEWID() END APK, 
		DivisionID,InheritID,InventoryTypeID NodeTypeID,NodeTypeID NodeTypeIDDetail,NodeParent NodeID, 
		'' NodeName, '' UnitID, CreateBOMVersion,
		ObjectID,StartDate,EndDate,RoutingID,Description, @in_Version Version, NULL QuantityVersion,
		@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
		INTO #TempMT2120Parent
		FROM #Data 
		WHERE Number = @in_Number
		GROUP BY DivisionID,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description,NodeTypeID,NodeParent

		SELECT 
		CASE WHEN R00.NodeChild = R03.NodeID THEN R03.APK ELSE NEWID() END APK,
		CASE WHEN ISNULL(R00.NodeParent,'') = '' THEN R03.APK ELSE R02.APK END APKMaster,
		@in_APK APK_2120,R00.DivisionID,R00.NodeTypeID,R00.NodeChild NodeID,A32.InventoryName NodeName,R02.APK NodeParent,(R00.Row-9) NodeOrder,A32.UnitID UnitID,
		R00.QuantitativeType,R00.QuantitativeValue,R00.MaterialGroupID,R00.MaterialID,R00.MaterialConstant,R00.OutsourceID,
		R00.DictatesID,R00.PhaseID,R00.LossValue,R00.DisplayName,R00.Row,
		@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
		INTO #TempMT2121Detail
		FROM #Data R00
		LEFT JOIN #TempMT2120Parent R02 WITH(NOLOCK) ON R00.DivisionID = R02.DivisionID AND ISNULL(R00.NodeParent,'') = ISNULL(R02.NodeID,'')
		LEFT JOIN #TempMT2120Parent R03 WITH(NOLOCK) ON R00.DivisionID = R03.DivisionID AND R00.NodeChild = R03.NodeID
		LEFT JOIN AT1302 A32 WITH(NOLOCK) ON A32.DivisionID IN (R00.DivisionID,'@@@') AND A32.InventoryID = R00.NodeChild
		WHERE Number = @in_Number

		INSERT INTO [dbo].[MT2121]
           ([APK],[APKMaster],[APK_2120],[DivisionID],[NodeTypeID],[NodeID],[NodeName],[NodeParent],[NodeOrder],[UnitID]
           ,[QuantitativeTypeID],[QuantitativeValue],[MaterialGroupID],[MaterialID],[MaterialConstant],[OutsourceID],[DictatesID]
           ,[PhaseID],[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate],[LossValue],[DisplayName])
		SELECT APK,APKMaster,APK_2120,DivisionID,NodeTypeID,NodeID,NodeName,NodeParent,NodeOrder,UnitID
		      ,CASE WHEN NodeParent = '00000000-0000-0000-0000-000000000000' THEN NULL ELSE QuantitativeType END
			  ,QuantitativeValue,MaterialGroupID,MaterialID,MaterialConstant,OutsourceID
			  ,CASE WHEN NodeParent = '00000000-0000-0000-0000-000000000000' THEN NULL ELSE DictatesID END
			  ,PhaseID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,LossValue,DisplayName 
		FROM #TempMT2121Detail

		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @in_DivisionID AND IsSpecificate = 1)
		BEGIN
			INSERT INTO [dbo].[MT8899]
			   ([DivisionID],[TableID],[VoucherID],[TransactionID],[OTransactionID]
			   ,[S01ID],[S02ID],[S03ID],[S04ID],[S05ID],[S06ID],[S07ID],[S08ID],[S09ID],[S10ID]
			   ,[S11ID],[S12ID],[S13ID],[S14ID],[S15ID],[S16ID],[S17ID],[S18ID],[S19ID],[S20ID])
			SELECT R00.DivisionID,'MT2121' TableID,R02.APKMaster VoucherID,R02.APK TransactionID,NULL OTransactionID,
			R00.S01ID,R00.S02ID,R00.S03ID,R00.S04ID,R00.S05ID,R00.S06ID,R00.S07ID,R00.S08ID,R00.S09ID,R00.S10ID,
			R00.S11ID,R00.S12ID,R00.S13ID,R00.S14ID,R00.S15ID,R00.S16ID,R00.S17ID,R00.S18ID,R00.S19ID,R00.S20ID
			FROM #Data R00
			LEFT JOIN #TempMT2121Detail R02 WITH(NOLOCK) ON R00.DivisionID = R02.DivisionID AND R00.Row = R02.Row
			WHERE Number = @in_Number
		END
		INSERT INTO [dbo].[MT2122]
           ([APK],[DivisionID],[NodeTypeID],[NodeID],[NodeName],[InheritID],[UnitID],[ObjectID],[Description],[StartDate],[EndDate]
           ,[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate],[Version],[RoutingID])
		SELECT APK,DivisionID,NodeTypeID,NodeID,NodeName,InheritID,UnitID,ObjectID,Description,CONVERT(DATETIME,StartDate,103) StartDate,CONVERT(DATETIME,EndDate,103) EndDate
			  ,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,Version,RoutingID
		FROM #TempMaster
		WHERE APK = @in_APK
		SELECT CASE WHEN ISNULL(NodeParent,'') = '' THEN '00000000-0000-0000-0000-000000000000' ELSE NEWID() END APK, 
		DivisionID,InheritID,InventoryTypeID NodeTypeID,NodeTypeID NodeTypeIDDetail,NodeParent NodeID, 
		'' NodeName, '' UnitID, CreateBOMVersion,
		ObjectID,StartDate,EndDate,RoutingID,Description, @in_Version Version, 0 QuantityVersion,
		@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
		INTO #TempMT2122Parent
		FROM #Data 
		WHERE Number = @in_Number
		GROUP BY DivisionID,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description,NodeTypeID,NodeParent
		SELECT 
		CASE WHEN R00.NodeChild = R03.NodeID THEN R03.APK ELSE NEWID() END APK,
		CASE WHEN ISNULL(R00.NodeParent,'') = '' THEN R03.APK ELSE R02.APK END APKMaster,
		@in_APK APK_2120,R00.DivisionID,R00.NodeTypeID,R00.NodeChild NodeID,A32.InventoryName NodeName,R02.APK NodeParent,(R00.Row-9) NodeOrder,A32.UnitID UnitID,
		R00.QuantitativeType,R00.QuantitativeValue,R00.MaterialGroupID,R00.MaterialID,R00.MaterialConstant,R00.OutsourceID,
		R00.DictatesID,R00.PhaseID,R00.LossValue,R00.DisplayName,R00.Row,
		@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
		INTO #TempMT2123Detail
		FROM #Data R00
		LEFT JOIN #TempMT2122Parent R02 WITH(NOLOCK) ON R00.DivisionID = R02.DivisionID AND ISNULL(R00.NodeParent,'') = ISNULL(R02.NodeID,'')
		LEFT JOIN #TempMT2122Parent R03 WITH(NOLOCK) ON R00.DivisionID = R03.DivisionID AND R00.NodeChild = R03.NodeID
		LEFT JOIN AT1302 A32 WITH(NOLOCK) ON A32.DivisionID IN (R00.DivisionID,'@@@') AND A32.InventoryID = R00.NodeChild
		WHERE Number = @in_Number
		INSERT INTO [dbo].[MT2123]
           ([APK],[APKMaster],[APK_2120],[DivisionID],[NodeTypeID],[NodeID],[NodeName],[NodeParent],[NodeOrder],[UnitID]
           ,[QuantitativeTypeID],[QuantitativeValue],[MaterialGroupID],[MaterialID],[MaterialConstant],[OutsourceID],[DictatesID]
           ,[PhaseID],[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate],[LossValue],[DisplayName])
		SELECT APK,APKMaster,APK_2120,DivisionID,NodeTypeID,NodeID,NodeName,NodeParent,NodeOrder,UnitID
		      ,CASE WHEN NodeParent = '00000000-0000-0000-0000-000000000000' THEN NULL ELSE QuantitativeType END
			  ,QuantitativeValue,MaterialGroupID,MaterialID,MaterialConstant,OutsourceID
			  ,CASE WHEN NodeParent = '00000000-0000-0000-0000-000000000000' THEN NULL ELSE DictatesID END
			  ,PhaseID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,LossValue,DisplayName 
		FROM #TempMT2123Detail
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @in_DivisionID AND IsSpecificate = 1)
		BEGIN
			INSERT INTO [dbo].[MT8899]
			   ([DivisionID],[TableID],[VoucherID],[TransactionID],[OTransactionID]
			   ,[S01ID],[S02ID],[S03ID],[S04ID],[S05ID],[S06ID],[S07ID],[S08ID],[S09ID],[S10ID]
			   ,[S11ID],[S12ID],[S13ID],[S14ID],[S15ID],[S16ID],[S17ID],[S18ID],[S19ID],[S20ID])
			SELECT R00.DivisionID,'MT2123' TableID,R02.APKMaster VoucherID,R02.APK TransactionID,NULL OTransactionID,
			R00.S01ID,R00.S02ID,R00.S03ID,R00.S04ID,R00.S05ID,R00.S06ID,R00.S07ID,R00.S08ID,R00.S09ID,R00.S10ID,
			R00.S11ID,R00.S12ID,R00.S13ID,R00.S14ID,R00.S15ID,R00.S16ID,R00.S17ID,R00.S18ID,R00.S19ID,R00.S20ID
			FROM #Data R00
			LEFT JOIN #TempMT2123Detail R02 WITH(NOLOCK) ON R00.DivisionID = R02.DivisionID AND R00.Row = R02.Row
			WHERE Number = @in_Number
		END
    FETCH NEXT FROM @cCURINSERT INTO @in_APK,@in_DivisionID,@in_Number,@in_InheritID,@in_NodeTypeID,@in_NodeID,@in_CreateBOMVersion,@in_ObjectID,@in_StartDate,@in_EndDate,@in_RoutingID,@in_Description

	END
	ELSE IF (@in_InheritID = 0 AND (@in_CreateBOMVersion = 1 OR @Version = 0))
	BEGIN

		UPDATE #TempMaster SET Version = @in_Version WHERE APk = @in_APK

		INSERT INTO [dbo].[MT2122]
           ([APK],[DivisionID],[NodeTypeID],[NodeID],[NodeName],[InheritID],[UnitID],[ObjectID],[Description],[StartDate],[EndDate]
           ,[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate],[Version],[RoutingID])
		SELECT APK,DivisionID,NodeTypeID,NodeID,NodeName,InheritID,UnitID,ObjectID,Description,CONVERT(DATETIME,StartDate,103) StartDate,CONVERT(DATETIME,EndDate,103) EndDate
			  ,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,Version,RoutingID
		FROM #TempMaster
		WHERE APK = @in_APK

		--Nếu InheritID = 0 thì lưu vào MT2122, MT2123
		SELECT CASE WHEN ISNULL(NodeParent,'') = '' THEN '00000000-0000-0000-0000-000000000000' ELSE NEWID() END APK, 
		DivisionID,InheritID,InventoryTypeID NodeTypeID,NodeTypeID NodeTypeIDDetail,NodeParent NodeID, 
		'' NodeName, '' UnitID, CreateBOMVersion,
		ObjectID,StartDate,EndDate,RoutingID,Description, @in_Version Version, 0 QuantityVersion,
		@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
		INTO #TempMT2122_Parent
		FROM #Data 
		WHERE Number = @in_Number
		GROUP BY DivisionID,InheritID,InventoryTypeID,ProductID,CreateBOMVersion,ObjectID,StartDate,EndDate,RoutingID,Description,NodeTypeID,NodeParent

		SELECT 
		CASE WHEN R00.NodeChild = R03.NodeID THEN R03.APK ELSE NEWID() END APK,
		CASE WHEN ISNULL(R00.NodeParent,'') = '' THEN R03.APK ELSE R02.APK END APKMaster,
		@in_APK APK_2120,R00.DivisionID,R00.NodeTypeID,R00.NodeChild NodeID,A32.InventoryName NodeName,R02.APK NodeParent,(R00.Row-9) NodeOrder,A32.UnitID UnitID,
		R00.QuantitativeType,R00.QuantitativeValue,R00.MaterialGroupID,R00.MaterialID,R00.MaterialConstant,R00.OutsourceID,
		R00.DictatesID,R00.PhaseID,R00.LossValue,R00.DisplayName,R00.Row,
		@UserID CreateUserID, GETDATE() AS CreateDate, @UserID LastModifyUserID, GETDATE() AS LastModifyDate
		INTO #TempMT2123_Detail
		FROM #Data R00
		LEFT JOIN #TempMT2122_Parent R02 WITH(NOLOCK) ON R00.DivisionID = R02.DivisionID AND ISNULL(R00.NodeParent,'') = ISNULL(R02.NodeID,'')
		LEFT JOIN #TempMT2122_Parent R03 WITH(NOLOCK) ON R00.DivisionID = R03.DivisionID AND R00.NodeChild = R03.NodeID
		LEFT JOIN AT1302 A32 WITH(NOLOCK) ON A32.DivisionID IN (R00.DivisionID,'@@@') AND A32.InventoryID = R00.NodeChild
		WHERE Number = @in_Number

		INSERT INTO [dbo].[MT2123]
           ([APK],[APKMaster],[APK_2120],[DivisionID],[NodeTypeID],[NodeID],[NodeName],[NodeParent],[NodeOrder],[UnitID]
           ,[QuantitativeTypeID],[QuantitativeValue],[MaterialGroupID],[MaterialID],[MaterialConstant],[OutsourceID],[DictatesID]
           ,[PhaseID],[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate],[LossValue],[DisplayName])
		SELECT APK,APKMaster,APK_2120,DivisionID,NodeTypeID,NodeID,NodeName,NodeParent,NodeOrder,UnitID
		      ,CASE WHEN NodeParent = '00000000-0000-0000-0000-000000000000' THEN NULL ELSE QuantitativeType END
			  ,QuantitativeValue,MaterialGroupID,MaterialID,MaterialConstant,OutsourceID
			  ,CASE WHEN NodeParent = '00000000-0000-0000-0000-000000000000' THEN NULL ELSE DictatesID END
			  ,PhaseID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,LossValue,DisplayName 
		FROM #TempMT2123_Detail

		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @in_DivisionID AND IsSpecificate = 1)
		BEGIN
			INSERT INTO [dbo].[MT8899]
			   ([DivisionID],[TableID],[VoucherID],[TransactionID],[OTransactionID]
			   ,[S01ID],[S02ID],[S03ID],[S04ID],[S05ID],[S06ID],[S07ID],[S08ID],[S09ID],[S10ID]
			   ,[S11ID],[S12ID],[S13ID],[S14ID],[S15ID],[S16ID],[S17ID],[S18ID],[S19ID],[S20ID])
			SELECT R00.DivisionID,'MT2123' TableID,R02.APKMaster VoucherID,R02.APK TransactionID,NULL OTransactionID,
			R00.S01ID,R00.S02ID,R00.S03ID,R00.S04ID,R00.S05ID,R00.S06ID,R00.S07ID,R00.S08ID,R00.S09ID,R00.S10ID,
			R00.S11ID,R00.S12ID,R00.S13ID,R00.S14ID,R00.S15ID,R00.S16ID,R00.S17ID,R00.S18ID,R00.S19ID,R00.S20ID
			FROM #Data R00
			LEFT JOIN #TempMT2123_Detail R02 WITH(NOLOCK) ON R00.DivisionID = R02.DivisionID AND R00.Row = R02.Row
			WHERE Number = @in_Number
		END

	END
	FETCH NEXT FROM @cCURINSERT INTO @in_APK,@in_DivisionID,@in_Number,@in_InheritID,@in_NodeTypeID,@in_NodeID,@in_CreateBOMVersion,@in_ObjectID,@in_StartDate,@in_EndDate,@in_RoutingID,@in_Description
END
CLOSE @cCURINSERT


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
