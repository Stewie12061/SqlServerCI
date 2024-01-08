IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8137_EXV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8137_EXV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Import Excel Bảng giá bán [Customize Index: 151 - EXEDY]
-- <History>
---- Created on 05/10/2022 by Nguyễn Văn Tài
---- Modified on 14/03/2023 by Viết Toàn: Bổ sung các sột các cột quy cách S01ID-S20ID

/*
 AP8137_EXV @DivisionID = 'EXV', @UserID = 'ASOFTADMIN', @ImportTemplateID = '', @@XML = ''
 */
 
CREATE PROCEDURE AP8137_EXV
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(250),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@CustomerName INT
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)

IF (ISNULL(@ImportTemplateID, '') = '')
BEGIN
	--SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)
	SET @ImportTemplateID = 'SalesAndPurchasePrice_EXV'
END
		
print (@ImportTemplateID)
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	[Row] INT NOT NULL,
	Orders INT,
	DetailID NVARCHAR(50),
	ImportMessage NVARCHAR(MAX) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,	
	Orders INT,
	ID NVARCHAR(50),
	DetailID NVARCHAR(50),
	InventoryID NVARCHAR(50),
	UnitID NVARCHAR(50)--,
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		BTL.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL
	--INNER JOIN	A01066 TLD
	--		ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID
			--AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	BTL.OrderNum

--SET @cCURSOR = CURSOR STATIC FOR
--	SELECT		TLD.ColID,
--				BTL.ColSQLDataType
--	FROM		A01065 TL
--	INNER JOIN	A01066 TLD
--			ON	TL.ImportTemplateID = TLD.ImportTemplateID
--	INNER JOIN	A00065 BTL
--			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
--	WHERE		TL.ImportTemplateID = @ImportTemplateID
--	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%'
	THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType

	print(@sSQL)
END
-- Thêm dữ liệu vào bảng tạm
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('OrderNo').value('.', 'INT') AS OrderNo,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('ID').value('.', 'NVARCHAR(50)') AS ID,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description],
		--X.Data.query('FromDate').value('.', 'DATETIME') AS FromDate,
		--X.Data.query('ToDate').value('.', 'DATETIME') AS ToDate,
		--X.Data.query('FromDate').value('.', 'DATETIME') AS FromDate,
		--(CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate,
		CONVERT(DateTime, X.Data.query('FromDate').value('.','NVARCHAR(50)'), 103) AS FromDate,
		CONVERT(DateTime, X.Data.query('ToDate').value('.','NVARCHAR(50)'), 103) AS ToDate,
		(CASE WHEN X.Data.query('OID').value('.', 'NVARCHAR(50)') = '' THEN '%' ELSE X.Data.query('OID').value('.', 'NVARCHAR(50)') END) AS OID,
		(CASE WHEN X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') = '' THEN '%' ELSE X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') END) AS InventoryTypeID,
		X.Data.query('CurrencyID').value('.', 'NVARCHAR(50)') AS CurrencyID,
		X.Data.query('IsConvertedPrice').value('.', 'NVARCHAR(50)') AS IsConvertedPrice,
		X.Data.query('InheritID').value('.', 'NVARCHAR(50)') AS InheritID,
		X.Data.query('TypeID').value('.', 'TINYINT') AS TypeID,
		X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,		
		X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
		X.Data.query('UnitPrice').value('.', 'NVARCHAR(50)') AS UnitPrice,
		X.Data.query('MinPrice').value('.', 'NVARCHAR(50)') AS MinPrice,
		X.Data.query('MaxPrice').value('.', 'NVARCHAR(50)') AS MaxPrice,
		X.Data.query('ConvertedUnitPrice').value('.', 'NVARCHAR(50)') AS ConvertedUnitPrice,
		X.Data.query('ConvertedMinPrice').value('.', 'NVARCHAR(50)') AS ConvertedMinPrice,
		X.Data.query('ConvertedMaxPrice').value('.', 'NVARCHAR(50)') AS ConvertedMaxPrice,
		X.Data.query('DiscountPercent').value('.', 'NVARCHAR(50)') AS DiscountPercent,
		X.Data.query('DiscountAmount').value('.', 'NVARCHAR(50)') AS DiscountAmount,
		X.Data.query('SaleOffPercent01').value('.', 'NVARCHAR(50)') AS SaleOffPercent01,
		X.Data.query('SaleOffAmount01').value('.', 'NVARCHAR(50)') AS SaleOffAmount01,
		X.Data.query('SaleOffPercent02').value('.', 'NVARCHAR(50)') AS SaleOffPercent02,
		X.Data.query('SaleOffAmount02').value('.', 'NVARCHAR(50)') AS SaleOffAmount02,
		X.Data.query('SaleOffPercent03').value('.', 'NVARCHAR(50)') AS SaleOffPercent03,
		X.Data.query('SaleOffAmount03').value('.', 'NVARCHAR(50)') AS SaleOffAmount03,
		X.Data.query('SaleOffPercent04').value('.', 'NVARCHAR(50)') AS SaleOffPercent04,
		X.Data.query('SaleOffAmount04').value('.', 'NVARCHAR(50)') AS SaleOffAmount04,
		X.Data.query('SaleOffPercent05').value('.', 'NVARCHAR(50)') AS SaleOffPercent05,
		X.Data.query('SaleOffAmount05').value('.', 'NVARCHAR(50)') AS SaleOffAmount05,
		X.Data.query('S01ID').value('.', 'NVARCHAR(50)') AS S01ID,
		X.Data.query('S02ID').value('.', 'NVARCHAR(50)') AS S02ID,
		X.Data.query('S03ID').value('.', 'NVARCHAR(50)') AS S03ID,
		X.Data.query('S04ID').value('.', 'NVARCHAR(50)') AS S04ID,
		X.Data.query('S05ID').value('.', 'NVARCHAR(50)') AS S05ID,
		X.Data.query('S06ID').value('.', 'NVARCHAR(50)') AS S06ID,
		X.Data.query('S07ID').value('.', 'NVARCHAR(50)') AS S07ID,
		X.Data.query('S08ID').value('.', 'NVARCHAR(50)') AS S08ID,
		X.Data.query('S09ID').value('.', 'NVARCHAR(50)') AS S09ID,
		X.Data.query('S10ID').value('.', 'NVARCHAR(50)') AS S10ID,
		X.Data.query('S11ID').value('.', 'NVARCHAR(50)') AS S11ID,
		X.Data.query('S12ID').value('.', 'NVARCHAR(50)') AS S12ID,
		X.Data.query('S13ID').value('.', 'NVARCHAR(50)') AS S13ID,
		X.Data.query('S14ID').value('.', 'NVARCHAR(50)') AS S14ID,
		X.Data.query('S15ID').value('.', 'NVARCHAR(50)') AS S15ID,
		X.Data.query('S16ID').value('.', 'NVARCHAR(50)') AS S16ID,
		X.Data.query('S17ID').value('.', 'NVARCHAR(50)') AS S17ID,
		X.Data.query('S18ID').value('.', 'NVARCHAR(50)') AS S18ID,
		X.Data.query('S19ID').value('.', 'NVARCHAR(50)') AS S19ID,
		X.Data.query('S20ID').value('.', 'NVARCHAR(50)') AS S20ID,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
		X.Data.query('Notes01').value('.', 'NVARCHAR(250)') AS Notes01, 
		X.Data.query('Notes02').value('.', 'NVARCHAR(250)') AS Notes02
INTO	#AP8137	
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data ( [Row], DivisionID, ID, [Description], FromDate, ToDate, OID, InventoryTypeID, CurrencyID, IsConvertedPrice
					,InheritID, TypeID, InventoryID, UnitID, UnitPrice, MinPrice, MaxPrice, ConvertedUnitPrice, ConvertedMinPrice
					,ConvertedMaxPrice,DiscountPercent, DiscountAmount, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02, SaleOffAmount02
					,SaleOffPercent03,SaleOffAmount03, SaleOffPercent04, SaleOffAmount04, SaleOffPercent05, SaleOffAmount05, Notes, Notes01
					,Notes02, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID
					,S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
SELECT
		CASE WHEN ISNULL([Row], 0) = 0 THEN OrderNo ELSE [Row] END,
		DivisionID, ID, [Description], FromDate, ToDate, OID, InventoryTypeID, CurrencyID, 
		CASE WHEN ISNULL(IsConvertedPrice,'') = '' THEN NULL ELSE CAST(IsConvertedPrice AS TINYINT) END IsConvertedPrice,     
		InheritID, ISNULL(TypeID,0), InventoryID, UnitID, 
		CASE WHEN ISNULL(UnitPrice,'') = '' THEN NULL ELSE CAST(UnitPrice AS DECIMAL(28,8)) END UnitPrice, 
		CASE WHEN ISNULL(MinPrice,'') = '' THEN NULL ELSE CAST(MinPrice AS DECIMAL(28,8)) END MinPrice, 
		CASE WHEN ISNULL(MaxPrice,'') = '' THEN NULL ELSE CAST(MaxPrice AS DECIMAL(28,8)) END MaxPrice,
		CASE WHEN ISNULL(ConvertedUnitPrice,'') = '' THEN NULL ELSE CAST(ConvertedUnitPrice AS DECIMAL(28,8)) END ConvertedUnitPrice,
		CASE WHEN ISNULL(ConvertedMinPrice,'') = '' THEN NULL ELSE CAST(ConvertedMinPrice AS DECIMAL(28,8)) END ConvertedMinPrice,
		CASE WHEN ISNULL(ConvertedMaxPrice,'') = '' THEN NULL ELSE CAST(ConvertedMaxPrice AS DECIMAL(28,8)) END ConvertedMaxPrice,
		CASE WHEN ISNULL(DiscountPercent,'') = '' THEN NULL ELSE CAST(DiscountPercent AS DECIMAL(28,8)) END DiscountPercent, 
		CASE WHEN ISNULL(DiscountAmount,'') = '' THEN NULL ELSE CAST(DiscountAmount AS DECIMAL(28,8)) END DiscountAmount, 
		CASE WHEN ISNULL(SaleOffPercent01,'') = '' THEN NULL ELSE CAST(SaleOffPercent01 AS DECIMAL(28,8)) END SaleOffPercent01, 
		CASE WHEN ISNULL(SaleOffAmount01,'') = '' THEN NULL ELSE CAST(SaleOffAmount01 AS DECIMAL(28,8)) END SaleOffAmount01, 
		CASE WHEN ISNULL(SaleOffPercent02,'') = '' THEN NULL ELSE CAST(SaleOffPercent02 AS DECIMAL(28,8)) END SaleOffPercent02, 
		CASE WHEN ISNULL(SaleOffAmount02,'') = '' THEN NULL ELSE CAST(SaleOffAmount02 AS DECIMAL(28,8)) END SaleOffAmount02, 
		CASE WHEN ISNULL(SaleOffPercent03,'') = '' THEN NULL ELSE CAST(SaleOffPercent03 AS DECIMAL(28,8)) END SaleOffPercent03, 
		CASE WHEN ISNULL(SaleOffAmount03,'') = '' THEN NULL ELSE CAST(SaleOffAmount03 AS DECIMAL(28,8)) END SaleOffAmount03, 
		CASE WHEN ISNULL(SaleOffPercent04,'') = '' THEN NULL ELSE CAST(SaleOffPercent04 AS DECIMAL(28,8)) END SaleOffPercent04, 
		CASE WHEN ISNULL(SaleOffAmount04,'') = '' THEN NULL ELSE CAST(SaleOffAmount04 AS DECIMAL(28,8)) END SaleOffAmount04, 
		CASE WHEN ISNULL(SaleOffPercent05,'') = '' THEN NULL ELSE CAST(SaleOffPercent05 AS DECIMAL(28,8)) END SaleOffPercent05, 
		CASE WHEN ISNULL(SaleOffAmount05,'') = '' THEN NULL ELSE CAST(SaleOffAmount05 AS DECIMAL(28,8)) END SaleOffAmount05, Notes, Notes01, Notes02 ,
		S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
FROM #AP8137
ORDER BY ID, InventoryID, UnitID

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID
----- Kiểm tra và lưu dữ liệu bảng giá bán
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ID', @Param1 = 'DivisionID, ID, [Description], FromDate, ToDate, OID, InventoryTypeID, CurrencyID, IsConvertedPrice, TypeID'

DECLARE @Cur CURSOR,
		@Row INT,
		@ID NVARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@OID NVARCHAR(50),
		@InventoryTypeID NVARCHAR(50),
		@InventoryID NVARCHAR(50),
		@UnitID NVARCHAR(50),
		@TestID NVARCHAR(50) = ''

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row], DivisionID, ID, FromDate, ToDate, OID, InventoryTypeID, InventoryID, UnitID
FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @ID, @FromDate, @ToDate, @OID, @InventoryTypeID, @InventoryID, @UnitID
WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra trùng dữ liệu bảng giá
	IF (SELECT COUNT(ID) FROM #Data 
	    WHERE DivisionID = @DivisionID 
		  AND ID = @ID 
		  AND InventoryID = @InventoryID 
		  AND UnitID = @UnitID) > 1
	BEGIN
		UPDATE DT SET 
		ImportMessage = ImportMessage + CASE WHEN ImportMessage != '' THEN '\n' ELSE '' END + 'ASML000088 {0}='''+CONVERT(VARCHAR,@Row)+''''
		FROM #Data DT
		WHERE DT.Row = @Row

	END	
---- Kiểm tra bảng giá đã tồn tại hay chưa
	IF EXISTS (SELECT TOP 1 1 FROM OT1301 WHERE DivisionID = @DivisionID AND ID = @ID)
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM OT1301 
		           WHERE DivisionID = @DivisionID AND ID = @ID AND 
		           (OID <> @OID OR InventoryTypeID <> @InventoryTypeID OR 
		            CONVERT(DATETIME,FromDate,112) <> CONVERT(DATETIME,@FromDate,112) OR 
		             CONVERT(DATETIME,ISNULL(ToDate,'9999-12-31 23:59:59.997'),112) <> CONVERT(DATETIME,ISNULL(@ToDate,'9999-12-31 23:59:59.997'),112)))
			BEGIN
				UPDATE DT SET 
				ImportMessage = ImportMessage + CASE WHEN ImportMessage != '' THEN '\n' ELSE '' END + 'OFML000008 {0}='''+CONVERT(NVARCHAR,@ID)+''''
				FROM #Data DT
				WHERE DT.Row = @Row
				
			END
		ELSE
			BEGIN
				UPDATE DT SET 
				ImportMessage = ImportMessage + CASE WHEN ImportMessage != '' THEN '\n' ELSE '' END + 'ASML000088 {0}='''+CONVERT(VARCHAR,@Row)+''''
				FROM #Data DT 
				WHERE DT.Row = @Row AND 
						EXISTS (SELECT TOP 1 1 FROM OT1302 
								WHERE OT1302.DivisionID = @DivisionID AND OT1302.ID = @ID AND OT1302.InventoryID = @InventoryID AND OT1302.UnitID = @UnitID)
			END

		--UPDATE DT SET 
		--		ImportMessage = ImportMessage + CASE WHEN ImportMessage != '' THEN '\n' ELSE '' END + 'OFML000008 {0}='''+CONVERT(NVARCHAR,@ID)+''''
		--		FROM #Data DT
		--		WHERE DT.Row = @Row
	END
	
FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @ID, @FromDate, @ToDate, @OID, @InventoryTypeID, @InventoryID, @UnitID
END
CLOSE @Cur	
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
begin
	print('ERROR!')
	GOTO LB_RESULT
end
--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai

UPDATE DT 
SET 
	FromDate = CASE WHEN DT.FromDate IS NOT NULL OR DT.FromDate != '' THEN CONVERT(DATETIME,DT.FromDate,114) END,
	ToDate = CASE WHEN DT.ToDate IS NOT NULL OR DT.ToDate != '' THEN CONVERT(DATETIME,DT.ToDate,114) ELSE NULL END,
	UnitPrice = ROUND(DT.UnitPrice,A.UnitCostDecimals),
	MinPrice = ROUND(DT.MinPrice,A.UnitCostDecimals),
	MaxPrice = ROUND(DT.MaxPrice,A.UnitCostDecimals),
	ConvertedUnitPrice = ROUND(DT.ConvertedUnitPrice,A.ConvertedDecimals),
	ConvertedMinPrice = ROUND(DT.ConvertedMinPrice,A.ConvertedDecimals),
	ConvertedMaxPrice = ROUND(DT.ConvertedMaxPrice,A.ConvertedDecimals),
	DiscountPercent = ROUND(DT.DiscountPercent,A.PercentDecimal),
	DiscountAmount = ROUND(DT.DiscountAmount,A.ConvertedDecimals),
	SaleOffPercent01 = ROUND(DT.SaleOffPercent01,A.PercentDecimal),
	SaleOffAmount01 = ROUND(DT.SaleOffAmount01,A.ConvertedDecimals),
	SaleOffPercent02 = ROUND(DT.SaleOffPercent02,A.PercentDecimal),
	SaleOffAmount02 = ROUND(DT.SaleOffAmount02,A.ConvertedDecimals),
	SaleOffPercent03 = ROUND(DT.SaleOffPercent03,A.PercentDecimal),
	SaleOffAmount03 = ROUND(DT.SaleOffAmount03,A.ConvertedDecimals),
	SaleOffPercent04 = ROUND(DT.SaleOffPercent04,A.PercentDecimal),
	SaleOffAmount04 = ROUND(DT.SaleOffAmount04,A.ConvertedDecimals),
	SaleOffPercent05 = ROUND(DT.SaleOffPercent05,A.PercentDecimal),
	SaleOffAmount05 = ROUND(DT.SaleOffAmount05,A.ConvertedDecimals),
	InheritID = CASE WHEN ISNULL(InheritID,'') != '' THEN DT.InheritID ELSE NULL END,
	Notes = CASE WHEN ISNULL(Notes,'') != '' THEN DT.Notes ELSE NULL END,
	Notes01 = CASE WHEN ISNULL(Notes01,'') != '' THEN DT.Notes01 ELSE NULL END,
	Notes02 = CASE WHEN ISNULL(Notes02,'') != '' THEN DT.Notes02 ELSE NULL END,
	S01ID = CASE WHEN ISNULL(S01ID,'') != '' THEN DT.S01ID ELSE NULL END,
	S02ID = CASE WHEN ISNULL(S02ID,'') != '' THEN DT.S02ID ELSE NULL END,
	S03ID = CASE WHEN ISNULL(S03ID,'') != '' THEN DT.S03ID ELSE NULL END,
	S04ID = CASE WHEN ISNULL(S04ID,'') != '' THEN DT.S04ID ELSE NULL END,
	S05ID = CASE WHEN ISNULL(S05ID,'') != '' THEN DT.S05ID ELSE NULL END,
	S06ID = CASE WHEN ISNULL(S06ID,'') != '' THEN DT.S06ID ELSE NULL END,
	S07ID = CASE WHEN ISNULL(S07ID,'') != '' THEN DT.S07ID ELSE NULL END,
	S08ID = CASE WHEN ISNULL(S08ID,'') != '' THEN DT.S08ID ELSE NULL END,
	S09ID = CASE WHEN ISNULL(S09ID,'') != '' THEN DT.S09ID ELSE NULL END,
	S10ID = CASE WHEN ISNULL(S10ID,'') != '' THEN DT.S10ID ELSE NULL END,
	S11ID = CASE WHEN ISNULL(S11ID,'') != '' THEN DT.S11ID ELSE NULL END,
	S12ID = CASE WHEN ISNULL(S12ID,'') != '' THEN DT.S12ID ELSE NULL END,
	S13ID = CASE WHEN ISNULL(S13ID,'') != '' THEN DT.S13ID ELSE NULL END,
	S14ID = CASE WHEN ISNULL(S14ID,'') != '' THEN DT.S14ID ELSE NULL END,
	S15ID = CASE WHEN ISNULL(S15ID,'') != '' THEN DT.S15ID ELSE NULL END,
	S16ID = CASE WHEN ISNULL(S16ID,'') != '' THEN DT.S16ID ELSE NULL END,
	S17ID = CASE WHEN ISNULL(S17ID,'') != '' THEN DT.S17ID ELSE NULL END,
	S18ID = CASE WHEN ISNULL(S18ID,'') != '' THEN DT.S18ID ELSE NULL END,
	S19ID = CASE WHEN ISNULL(S19ID,'') != '' THEN DT.S19ID ELSE NULL END,
	S20ID = CASE WHEN ISNULL(S20ID,'') != '' THEN DT.S20ID ELSE NULL END
FROM #Data DT
LEFT JOIN	AT1101 A ON A.DivisionID = DT.DivisionID

-- Sinh khoá
DECLARE @cKey AS CURSOR
DECLARE --@Row INT,
		@Orders INT,
	    @DetailID NVARCHAR(50)--,
	    --@ID NVARCHAR(50),
		--@InventoryID NVARCHAR(50),
		--@UnitID NVARCHAR(50),
	    --@TestID NVARCHAR(50)
SET @cKey = CURSOR SCROLL KEYSET FOR
			SELECT [Row], ID, InventoryID, UnitID
			FROM #Data
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @ID, @InventoryID, @UnitID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @TestID IS NULL OR @TestID != @ID
	BEGIN
		SET @Orders = 1
		SET @DetailID = NEWID()
		SET @TestID = @ID
	END
	ELSE 
	BEGIN
		SET @Orders = @Orders + 1
		SET @DetailID = NEWID()
	END
	INSERT INTO #Keys ([Row], Orders, ID, DetailID, InventoryID, UnitID)
	VALUES (@Row, @Orders, @ID, @DetailID, @InventoryID, @UnitID)
	FETCH NEXT FROM @cKey INTO @Row, @ID, @InventoryID, @UnitID
END
CLOSE @cKey
----- Cập nhật khoá 
UPDATE DT
SET
	DT.Orders = K.Orders,
	DT.DetailID = K.DetailID
FROM #Data DT
INNER JOIN #Keys K ON K.Row = DT.Row

UPDATE		DT
SET			Orders = K.Orders,
			DT.ID = K.ID ,
			DT.DetailID = K.DetailID			
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row

--drop constraint 
SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
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
EXEC(@SQL)

-- Insert Master
INSERT INTO	OT1301 (DivisionID, ID, [Description], FromDate, ToDate, OID,
					InventoryTypeID, [Disabled], CurrencyID, InheritID,
					IsConvertedPrice, TypeID, CreateUserID, CreateDate,
					LastModifyUserID, LastModifyDate)
SELECT DISTINCT DivisionID, ID, [Description], FromDate, ToDate, OID, InventoryTypeID, 0, 
				CurrencyID, InheritID, IsConvertedPrice, TypeID, @UserID, GETDATE(), @UserID, 
				GETDATE() 
FROM #Data DT 
WHERE DT.ID NOT IN (SELECT OT31.ID FROM OT1301 OT31 WHERE OT31.DivisionID = DT.DivisionID)

-- Insert Detail
INSERT INTO OT1302(DivisionID, ID, DetailID, InventoryID, UnitID, UnitPrice, MinPrice, MaxPrice, Orders 
				   , DiscountPercent, DiscountAmount, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02
				   , SaleOffAmount02, SaleOffPercent03, SaleOffAmount03, SaleOffPercent04, SaleOffAmount04
				   , SaleOffPercent05, SaleOffAmount05, ConvertedUnitPrice, ConvertedMinPrice, ConvertedMaxPrice
				   , Notes, Notes01, Notes02
				   --, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID
				   --, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
				   , RMRate, Packing, Transport, Insuarance, NetInvoice, RoyaltyPercent, RoyaltyRate, ExchangeRate
				   , IsEXD, IsEXDExchangeRate, IsEXT, IsEFM, IsOther)
SELECT  DivisionID, ID, DetailID, InventoryID, UnitID, UnitPrice, MinPrice, MaxPrice, Orders
		, DiscountPercent, DiscountAmount, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02
		, SaleOffAmount02, SaleOffPercent03, SaleOffAmount03, SaleOffPercent04, SaleOffAmount04
		, SaleOffPercent05, SaleOffAmount05, ConvertedUnitPrice, ConvertedMinPrice, ConvertedMaxPrice
		, Notes, Notes01, Notes02
		--, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID
		--, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		, S05ID AS RMRate, S06ID AS Packing, S07ID AS Transport, S08ID AS Insuarance, S09ID AS NetInvoice, S10ID AS RoyaltyPercent, S11ID AS RoyaltyRate, S12ID AS ExchangeRate
		, S13ID AS IsEXD, S14ID AS IsEXDExchangeRate, S15ID AS IsEXT, S16ID AS IsEFM, S17ID AS IsOther
FROM #Data DT

-----------------------------------------------------------------------------------------
LB_RESULT:
SELECT * FROM #Data
WHERE ImportMessage <> ''

GO
SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON
GO
