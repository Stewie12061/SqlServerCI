IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0629]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0629]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Xử lý Import Danh mục bộ định mức theo quy cách 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/01/2019 by Tra Giang 
---- Modified on 30/09/2022 by Văn Tài:	Điều chỉnh import nhiều bộ định mức và mã thành phẩm.
-- <Example>
---- 
CREATE PROCEDURE [DBO].[MP0629]
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
	Row INT,
	Orders INT,
	ImportMessage NVARCHAR(500) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT,
	Orders INT,
	CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

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
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END   

-- ALTER #Data bổ sung cột TransactionID
ALTER TABLE #Data ADD TransactionID VARCHAR(50) NULL

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
	X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
	X.Data.query('ApportionID').value('.', 'NVARCHAR(50)') AS ApportionID,
	X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
	X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') AS InventoryTypeID,
	X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
	X.Data.query('IsBOM').value('.', 'NVARCHAR(50)') AS IsBOM,  
	X.Data.query('ProductID').value('.', 'NVARCHAR(50)') AS ProductID,
	X.Data.query('UnitID').value('.', 'NVARCHAR(50)') AS UnitID,
	X.Data.query('ProductQuantity').value('.', 'NVARCHAR(50)') AS ProductQuantity,
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
	X.Data.query('MaterialID').value('.', 'NVARCHAR(50)') AS MaterialID,
	X.Data.query('MaterialUnitID').value('.', 'NVARCHAR(50)') AS MaterialUnitID,
	X.Data.query('MaterialQuantity').value('.', 'NVARCHAR(50)') AS MaterialQuantity,
	X.Data.query('MaterialPrice').value('.', 'NVARCHAR(50)') AS MaterialPrice,
	X.Data.query('RateWastage').value('.', 'NVARCHAR(50)') AS RateWastage,
	X.Data.query('DS01ID').value('.', 'NVARCHAR(50)') AS DS01ID,
	X.Data.query('DS02ID').value('.', 'NVARCHAR(50)') AS DS02ID,
	X.Data.query('DS03ID').value('.', 'NVARCHAR(50)') AS DS03ID,
	X.Data.query('DS04ID').value('.', 'NVARCHAR(50)') AS DS04ID,
	X.Data.query('DS05ID').value('.', 'NVARCHAR(50)') AS DS05ID,
	X.Data.query('DS06ID').value('.', 'NVARCHAR(50)') AS DS06ID,
	X.Data.query('DS07ID').value('.', 'NVARCHAR(50)') AS DS07ID,
	X.Data.query('DS08ID').value('.', 'NVARCHAR(50)') AS DS08ID,
	X.Data.query('DS09ID').value('.', 'NVARCHAR(50)') AS DS09ID,
	X.Data.query('DS10ID').value('.', 'NVARCHAR(50)') AS DS10ID,
	X.Data.query('DS11ID').value('.', 'NVARCHAR(50)') AS DS11ID,
	X.Data.query('DS12ID').value('.', 'NVARCHAR(50)') AS DS12ID,
	X.Data.query('DS13ID').value('.', 'NVARCHAR(50)') AS DS13ID,
	X.Data.query('DS14ID').value('.', 'NVARCHAR(50)') AS DS14ID,
	X.Data.query('DS15ID').value('.', 'NVARCHAR(50)') AS DS15ID,
	X.Data.query('DS16ID').value('.', 'NVARCHAR(50)') AS DS16ID,
	X.Data.query('DS17ID').value('.', 'NVARCHAR(50)') AS DS17ID,
	X.Data.query('DS18ID').value('.', 'NVARCHAR(50)') AS DS18ID,
	X.Data.query('DS19ID').value('.', 'NVARCHAR(50)') AS DS19ID,
	X.Data.query('DS20ID').value('.', 'NVARCHAR(50)') AS DS20ID

INTO	#MP0629
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (
		Row,
	DivisionID,
	ApportionID,
	ObjectID,
	InventoryTypeID,
	Description,
	IsBOM,
	ProductID,
	UnitID,
	ProductQuantity,
	S01ID,
	S02ID,
	S03ID,
	S04ID,
	S05ID,
	S06ID,
	S07ID,
	S08ID,
	S09ID,
	S10ID,
	S11ID,
	S12ID,
	S13ID,
	S14ID,
	S15ID,
	S16ID,
	S17ID,
	S18ID,
	S19ID,
	S20ID,
	MaterialID,
	MaterialUnitID,
	MaterialQuantity,
	MaterialPrice,
	RateWastage,
	DS01ID,
	DS02ID,
	DS03ID,
	DS04ID,
	DS05ID,
	DS06ID,
	DS07ID,
	DS08ID,
	DS09ID,
	DS10ID,
	DS11ID,
	DS12ID,
	DS13ID,
	DS14ID,
	DS15ID,
	DS16ID,
	DS17ID,
	DS18ID,
	DS19ID,
	DS20ID)
	
SELECT Row,
	DivisionID,
	ApportionID,
	ObjectID,
	InventoryTypeID,
	Description,
	IsBOM,
	ProductID,
	UnitID,
	CASE WHEN ISNULL(ProductQuantity,'') = '' THEN NULL ELSE CAST(ProductQuantity AS DECIMAL(28,8)) END ProductQuantity,
	S01ID,
	S02ID,
	S03ID,
	S04ID,
	S05ID,
	S06ID,
	S07ID,
	S08ID,
	S09ID,
	S10ID,
	S11ID,
	S12ID,
	S13ID,
	S14ID,
	S15ID,
	S16ID,
	S17ID,
	S18ID,
	S19ID,
	S20ID,
	MaterialID,
	MaterialUnitID,
	CASE WHEN ISNULL(MaterialQuantity,'') = '' THEN NULL ELSE CAST(MaterialQuantity AS DECIMAL(28,8)) END MaterialQuantity,
	CASE WHEN ISNULL(RateWastage,'') = '' THEN NULL ELSE CAST(RateWastage AS DECIMAL(28,8)) END RateWastage,
	CASE WHEN ISNULL(MaterialPrice,'') = '' THEN NULL ELSE CAST(MaterialPrice AS DECIMAL(28,8)) END MaterialPrice,
	DS01ID,
	DS02ID,
	DS03ID,
	DS04ID,
	DS05ID,
	DS06ID,
	DS07ID,
	DS08ID,
	DS09ID,
	DS10ID,
	DS11ID,
	DS12ID,
	DS13ID,
	DS14ID,
	DS15ID,
	DS16ID,
	DS17ID,
	DS18ID,
	DS19ID,
	DS20ID
			
FROM #MP0629

-- Kiểm tra check code mặc định


--EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

-- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-M', @ColID = 'ApportionID',
 @Param1 = 'DivisionID,	ApportionID,ObjectID,InventoryTypeID,Description,S01ID,S02ID,S03ID,S04ID,
	S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID'



-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

	
-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@ApportionID AS NVARCHAR(50)
		

DECLARE	@TransID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50),
		@CurrencyID AS NVARCHAR(50),
		@ReVoucherID AS NVARCHAR(50)	

SET @cKey = CURSOR FOR
	SELECT	Row, ApportionID
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @ApportionID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	BEGIN
		SET @Orders = 0
		
	END
	SET @Orders = @Orders + 1
	
	SET @TransID = NEWID()

	--INSERT INTO #Keys (Row, Orders, VoucherID, TransactionID) VALUES (@Row, @Orders, @VoucherID, @TransID)				
	FETCH NEXT FROM @cKey INTO @Row, @ApportionID--, @Period
END	
CLOSE @cKey

-- Kiểm tra not in list 
	IF NOT EXISTS (SELECT TOP  1 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = (SELECT TOP 1 ProductID from #Data))
	BEGIN
		UPDATE	#Data 
		SET	ImportMessage =  LTRIM(RTRIM(STR([Row]))) +'-ASML000089,'
				
	END 
	IF NOT EXISTS (SELECT TOP  1 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = (SELECT TOP 1 MaterialID from #Data))
	BEGIN
		UPDATE	#Data 
		SET	ImportMessage =  LTRIM(RTRIM(STR([Row]))) +'-ASML000089,'
				
	END 
--EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateOtherVoucherNo',
-- @ColID = 'ApportionID', @Param2 = 'MT0136', @Param3 = 'ApportionID'
-- Kiểm tra not in list
--EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'SpecificationsQuota', @CheckCode = 'CheckValueInList', @ColID = 'ProductID',@Param1='MT0136',@Param2='ProductID'
--EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'SpecificationsQuota', @CheckCode = 'CheckValueInList', @ColID = 'MaterialID',@Param1='MT0137',@Param2='MaterialID'

	-- Nếu có lỗi thì không đẩy dữ liệu vào
	IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
		GOTO LB_RESULT
	
	IF NOT EXISTS (SELECT  TOP 1 1 FROM MT0135 WHERE ApportionID = (SELECT TOP 1 ApportionID FROM #Data) ) 
	BEGIN 
	 --Đẩy dữ liệu vào bảng master

		INSERT INTO MT0135 ( DivisionID,ApportionID,ObjectID,InventoryTypeID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,Description,IsBOM)
		SELECT  DISTINCT DivisionID, ApportionID, ObjectID,InventoryTypeID, @UserID, GETDATE(), @UserID, GETDATE(),Description,IsBOM FROM #Data
	END

	-- Cập nhật TransactionID cho từng bộ dữ liệu giống nhau.
	BEGIN
		
		SELECT	DISTINCT 
			 DivisionID,  NEWID() AS TransactionID,  ApportionID, ProductID, UnitID,  ProductQuantity,
		      S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
		      S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		INTO #DataTranID
		FROM #Data 
		

		UPDATE T01
			SET T01.TransactionID = T02.TransactionID
		FROM #Data T01
		INNER JOIN #DataTranID T02 ON
				T01.DivisionID = T02.DivisionID
				AND T01.ApportionID = T02.ApportionID
				AND T01.ProductID = T02.ProductID
				AND T01.UnitID = T02.UnitID
				AND T01.ProductQuantity = T02.ProductQuantity
				AND ISNULL(T01.S01ID, '') = ISNULL(T02.S01ID, '')
				AND ISNULL(T01.S02ID, '') = ISNULL(T02.S02ID, '')
				AND ISNULL(T01.S03ID, '') = ISNULL(T02.S03ID, '')
				AND ISNULL(T01.S04ID, '') = ISNULL(T02.S04ID, '')
				AND ISNULL(T01.S05ID, '') = ISNULL(T02.S05ID, '')
				AND ISNULL(T01.S06ID, '') = ISNULL(T02.S06ID, '')
				AND ISNULL(T01.S07ID, '') = ISNULL(T02.S07ID, '')
				AND ISNULL(T01.S08ID, '') = ISNULL(T02.S08ID, '')
				AND ISNULL(T01.S09ID, '') = ISNULL(T02.S09ID, '')
				AND ISNULL(T01.S10ID, '') = ISNULL(T02.S10ID, '')
				AND ISNULL(T01.S11ID, '') = ISNULL(T02.S11ID, '')
				AND ISNULL(T01.S12ID, '') = ISNULL(T02.S12ID, '')
				AND ISNULL(T01.S13ID, '') = ISNULL(T02.S13ID, '')
				AND ISNULL(T01.S14ID, '') = ISNULL(T02.S14ID, '')
				AND ISNULL(T01.S15ID, '') = ISNULL(T02.S15ID, '')
				AND ISNULL(T01.S16ID, '') = ISNULL(T02.S16ID, '')
				AND ISNULL(T01.S17ID, '') = ISNULL(T02.S17ID, '')
				AND ISNULL(T01.S18ID, '') = ISNULL(T02.S18ID, '')
				AND ISNULL(T01.S19ID, '') = ISNULL(T02.S19ID, '')
				AND ISNULL(T01.S20ID, '') = ISNULL(T02.S20ID, '')
	END

	DECLARE @NewAPK1 UNIQUEIDENTIFIER, @NewAPK VARCHAR(50)
	SET @NewAPK1 = NEWID()
	SET @NewAPK = @NewAPK1
			INSERT INTO MT0136(
		      DivisionID, TransactionID, ApportionID,  ProductID, UnitID, ProductQuantity,
		      S01ID, S02ID, S03ID,S04ID, S05ID, S06ID, S07ID,S08ID, S09ID,S10ID,
		      S11ID, S12ID, S13ID,S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID   
		      ) 
		SELECT	DISTINCT 
			 DivisionID,  TransactionID,  ApportionID,   ProductID, UnitID,  ProductQuantity,
		      S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
		      S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID   
		FROM	#Data 
		-- Insert dữ liệu vào bảng thiết lập  
		
		INSERT INTO MT0137(DivisionID,TransactionID,ProductID,ReTransactionID,MaterialID,MaterialUnitID,MaterialQuantity,MaterialPrice,
		Description,DS01ID,DS02ID,DS03ID,DS04ID,DS05ID,DS06ID,DS07ID,DS08ID,DS09ID,DS10ID,DS11ID,DS12ID,DS13ID,DS14ID,DS15ID,DS16ID,DS17ID,DS18ID,DS19ID,DS20ID,ExpenseID
		)
		
		SELECT	 DISTINCT D.DivisionID,	newID(),D.ProductID,
				TransactionID,MaterialID,MaterialUnitID,MaterialQuantity,MaterialPrice,
		        Description,DS01ID,DS02ID,DS03ID,DS04ID,DS05ID,DS06ID,DS07ID,DS08ID,DS09ID,DS10ID,DS11ID,
				DS12ID,DS13ID,DS14ID,DS15ID,DS16ID,DS17ID,DS18ID,DS19ID,DS20ID,'COST001'
				
		FROM	#Data D


LB_RESULT:
SELECT * FROM #Data






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO