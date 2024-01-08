IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2074]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2074]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel danh mục kế hoạch bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by DungDV on 21/11/2019
---- Modified by on 08/05/2020 Kiều Nga cập nhật tăng tự động mã kế hoạch bán hàng
---- Modified by on 13/06/2023 Văn Tài	- [2023/06/IS/0006] Fix lỗi import và thông báo trùng.
-- <Example>
/* 
 EXEC SOP2074 'NN', 'SUPPORT', '','PlanSaleList'
 */
 
CREATE PROCEDURE SOP2074
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
	VoucherDate1 DATETIME,
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	[APKMaster] UNIQUEIDENTIFIER NULL,
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
	--PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
CLOSE @cCURSOR

--select * from #Data return

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'NVARCHAR(50)') AS VoucherDate, 
		X.Data.query('ObjectID').value('.', 'VARCHAR(50)') AS ObjectID,	
		X.Data.query('Type').value('.', 'TINYINT') AS [Type],
		X.Data.query('YearPlan').value('.', 'INT') AS YearPlan,
		X.Data.query('InventoryID').value('.', 'VARCHAR(50)') AS InventoryID,
		X.Data.query('UnitPrice').value('.', 'DECIMAL(28, 8)') AS UnitPrice,
		X.Data.query('S01ID').value('.', 'VARCHAR(50)') AS S01ID,
		X.Data.query('S02ID').value('.', 'VARCHAR(50)') AS S02ID,
		X.Data.query('S03ID').value('.', 'VARCHAR(50)') AS S03ID,
		X.Data.query('S04ID').value('.', 'VARCHAR(50)') AS S04ID,
		X.Data.query('S05ID').value('.', 'VARCHAR(50)') AS S05ID,
		X.Data.query('S06ID').value('.', 'VARCHAR(50)') AS S06ID,
		X.Data.query('S07ID').value('.', 'VARCHAR(50)') AS S07ID,
		X.Data.query('S08ID').value('.', 'VARCHAR(50)') AS S08ID,
		X.Data.query('S09ID').value('.', 'VARCHAR(50)') AS S09ID,
		X.Data.query('S10ID').value('.', 'VARCHAR(50)') AS S10ID,
		X.Data.query('S11ID').value('.', 'VARCHAR(50)') AS S11ID,
		X.Data.query('S12ID').value('.', 'VARCHAR(50)') AS S12ID,
		X.Data.query('S13ID').value('.', 'VARCHAR(50)') AS S13ID,
		X.Data.query('S14ID').value('.', 'VARCHAR(50)') AS S14ID,
		X.Data.query('S15ID').value('.', 'VARCHAR(50)') AS S15ID,
		X.Data.query('S16ID').value('.', 'VARCHAR(50)') AS S16ID,
		X.Data.query('S17ID').value('.', 'VARCHAR(50)') AS S17ID,
		X.Data.query('S18ID').value('.', 'VARCHAR(50)') AS S18ID,
		X.Data.query('S19ID').value('.', 'VARCHAR(50)') AS S19ID,
		X.Data.query('S20ID').value('.', 'VARCHAR(50)') AS S20ID,
		X.Data.query('Quantity1').value('.', 'DECIMAL(28, 8)') AS Quantity1,
		X.Data.query('Quantity2').value('.', 'DECIMAL(28, 8)') AS Quantity2,
		X.Data.query('Quantity3').value('.', 'DECIMAL(28, 8)') AS Quantity3,
		X.Data.query('Quantity4').value('.', 'DECIMAL(28, 8)') AS Quantity4,
		X.Data.query('Quantity5').value('.', 'DECIMAL(28, 8)') AS Quantity5,
		X.Data.query('Quantity6').value('.', 'DECIMAL(28, 8)') AS Quantity6,
		X.Data.query('Quantity7').value('.', 'DECIMAL(28, 8)') AS Quantity7,
		X.Data.query('Quantity8').value('.', 'DECIMAL(28, 8)') AS Quantity8,
		X.Data.query('Quantity9').value('.', 'DECIMAL(28, 8)') AS Quantity9,
		X.Data.query('Quantity10').value('.', 'DECIMAL(28, 8)') AS Quantity10,
		X.Data.query('Quantity11').value('.', 'DECIMAL(28, 8)') AS Quantity11,
		X.Data.query('Quantity12').value('.', 'DECIMAL(28, 8)') AS Quantity12,
		X.Data.query('Note').value('.', 'NVARCHAR(250)') AS Note,			
		IDENTITY(int, 1, 1) AS Orders			
INTO #SOT2070
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

print ('A')

INSERT INTO #Data (APKMaster, [Row], Orders, DivisionID, VoucherNo, VoucherDate, ObjectID, [Type], YearPlan,InventoryID,UnitPrice,Quantity1 , Quantity2, Quantity3, Quantity4, Quantity5, Quantity6, Quantity7, Quantity8, Quantity9, Quantity10, Quantity11, Quantity12, Note,S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,VoucherDate1)
SELECT NEWID() AS APKMaster, [Row], Orders, DivisionID, VoucherNo, FORMAT(CONVERT(DATETIME, VoucherDate, 104), 'MM/yyyy')
					, ObjectID
					, [Type]
					, YearPlan
					, InventoryID
					, CASE WHEN LEN(UnitPrice) > 0 THEN  UnitPrice ELSE 0 END AS UnitPrice
					, CASE WHEN LEN(Quantity1) > 0 THEN  Quantity1 ELSE 0 END AS Quantity1
					, CASE WHEN LEN(Quantity2) > 0 THEN  Quantity2 ELSE 0 END AS Quantity2
					, CASE WHEN LEN(Quantity3) > 0 THEN  Quantity3 ELSE 0 END AS Quantity3
					, CASE WHEN LEN(Quantity4) > 0 THEN  Quantity4 ELSE 0 END AS Quantity4
					, CASE WHEN LEN(Quantity5) > 0 THEN  Quantity5 ELSE 0 END AS Quantity5
					, CASE WHEN LEN(Quantity6) > 0 THEN  Quantity6 ELSE 0 END AS Quantity6
					, CASE WHEN LEN(Quantity7) > 0 THEN  Quantity7 ELSE 0 END AS Quantity7
					, CASE WHEN LEN(Quantity8) > 0 THEN  Quantity8 ELSE 0 END AS Quantity8
					, CASE WHEN LEN(Quantity9) > 0 THEN  Quantity9 ELSE 0 END AS Quantity9
					, CASE WHEN LEN(Quantity10) > 0 THEN Quantity10 ELSE 0 END AS Quantity10
					, CASE WHEN LEN(Quantity11) > 0 THEN  Quantity11 ELSE 0 END AS Quantity11
					, CASE WHEN LEN(Quantity12) > 0 THEN  Quantity12 ELSE 0 END AS Quantity12
					, Note
					, S01ID
					, S02ID
					, S03ID
					, S04ID
					, S05ID
					, S06ID
					, S07ID
					, S08ID
					, S09ID
					, S10ID
					, S11ID
					, S12ID
					, S13ID
					, S14ID
					, S15ID
					, S16ID
					, S17ID
					, S18ID
					, S19ID
					, S20ID
					, CASE WHEN ISNULL(VoucherDate,'') ='' THEN NULL ELSE CONVERT(DATETIME, VoucherDate, 104) END
FROM #SOT2070
--select * from #Data return
---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID


print ('D')

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-SO', @ColID = 'VoucherNo', 
@Param1 = 'VoucherNo, VoucherDate,ObjectID,Type,YearPlan'
---- Kiểm tra dữ liệu MASTER 
DECLARE @ColumnName VARCHAR(50), 
		@ColName NVARCHAR(50), 		
		@Cur CURSOR, 
		@VoucherNo VARCHAR(50),
		@ColumnName1 VARCHAR(50), 
		@ColName1 NVARCHAR(50),
		@TYPE TINYINT,
		@ColumnName2 VARCHAR(50), 
		@ColName2 NVARCHAR(50),
		@YearPlan INT,
		@ColumnName3 VARCHAR(50), 
		@ColName3 NVARCHAR(50),
		@InventoryID VARCHAR(50),
		@ColumnNameObjectID VARCHAR(50), 
		@ColNameObjectID NVARCHAR(50),
		@ObjectID VARCHAR(50),
		--Quy Cach 1
		@ColumnNameS01 VARCHAR(50), 
		@ColNameS01 NVARCHAR(50),
		@S01ID VARCHAR(50),
		--Quy Cach 2
		@ColumnNameS02 VARCHAR(50), 
		@ColNameS02 NVARCHAR(50),
		@S02ID VARCHAR(50),
		--Quy Cach 3
		@ColumnNameS03 VARCHAR(50), 
		@ColNameS03 NVARCHAR(50),
		@S03ID VARCHAR(50),
		--Quy Cach 4
		@ColumnNameS04 VARCHAR(50), 
		@ColNameS04 NVARCHAR(50),
		@S04ID VARCHAR(50),
		--Quy Cach 5
		@ColumnNameS05 VARCHAR(50), 
		@ColNameS05 NVARCHAR(50),
		@S05ID VARCHAR(50),
		--Quy Cach 6
		@ColumnNameS06 VARCHAR(50), 
		@ColNameS06 NVARCHAR(50),
		@S06ID VARCHAR(50),
		--Quy Cach 7
		@ColumnNameS07 VARCHAR(50), 
		@ColNameS07 NVARCHAR(50),
		@S07ID VARCHAR(50),
		--Quy Cach 8
		@ColumnNameS08 VARCHAR(50), 
		@ColNameS08 NVARCHAR(50),
		@S08ID VARCHAR(50),
		--Quy Cach 9
		@ColumnNameS09 VARCHAR(50), 
		@ColNameS09 NVARCHAR(50),
		@S09ID VARCHAR(50),
		--Quy Cach 10
		@ColumnNameS10 VARCHAR(50), 
		@ColNameS10 NVARCHAR(50),
		@S10ID VARCHAR(50),
		--Quy Cach 11
		@ColumnNameS11 VARCHAR(50), 
		@ColNameS11 NVARCHAR(50),
		@S11ID VARCHAR(50),
		--Quy Cach 12
		@ColumnNameS12 VARCHAR(50), 
		@ColNameS12 NVARCHAR(50),
		@S12ID VARCHAR(50),
		--Quy Cach 13
		@ColumnNameS13 VARCHAR(50), 
		@ColNameS13 NVARCHAR(50),
		@S13ID VARCHAR(50),
		--Quy Cach 14
		@ColumnNameS14 VARCHAR(50), 
		@ColNameS14 NVARCHAR(50),
		@S14ID VARCHAR(50),
		--Quy Cach 15
		@ColumnNameS15 VARCHAR(50), 
		@ColNameS15 NVARCHAR(50),
		@S15ID VARCHAR(50),
		--Quy Cach 16
		@ColumnNameS16 VARCHAR(50), 
		@ColNameS16 NVARCHAR(50),
		@S16ID VARCHAR(50),
		--Quy Cach 17
		@ColumnNameS17 VARCHAR(50), 
		@ColNameS17 NVARCHAR(50),
		@S17ID VARCHAR(50),
		--Quy Cach 18
		@ColumnNameS18 VARCHAR(50), 
		@ColNameS18 NVARCHAR(50),
		@S18ID VARCHAR(50),
		--Quy Cach 19
		@ColumnNameS19 VARCHAR(50), 
		@ColNameS19 NVARCHAR(50),
		@S19ID VARCHAR(50),
		--Quy Cach 20
		@ColumnNameS20 VARCHAR(50), 
		@ColNameS20 NVARCHAR(50),
		@S20ID VARCHAR(50)

--VoucherNo
SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'
--Type
SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Type'
--YearPlan
SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'YearPlan'
--InventoryID
SELECT TOP 1 @ColumnName3 = DataCol, @ColName3 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
--ObjectID
SELECT TOP 1 @ColumnNameObjectID = DataCol, @ColNameObjectID = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ObjectID'
--Quy Cach 1
SELECT TOP 1 @ColumnNameS01 = DataCol, @ColNameS01 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S01ID'
--Quy Cach 2
SELECT TOP 1 @ColumnNameS02 = DataCol, @ColNameS02 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S02ID'
--Quy Cach 3
SELECT TOP 1 @ColumnNameS03 = DataCol, @ColNameS03 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S03ID'
--Quy Cach 4
SELECT TOP 1 @ColumnNameS04 = DataCol, @ColNameS04 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S04ID'
--Quy Cach 5
SELECT TOP 1 @ColumnNameS05 = DataCol, @ColNameS05 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S05ID'
--Quy Cach 6
SELECT TOP 1 @ColumnNameS06 = DataCol, @ColNameS06 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S06ID'
--Quy Cach 7
SELECT TOP 1 @ColumnNameS07 = DataCol, @ColNameS07 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S07ID'
--Quy Cach 8
SELECT TOP 1 @ColumnNameS08 = DataCol, @ColNameS08 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S08ID'
--Quy Cach 9
SELECT TOP 1 @ColumnNameS09 = DataCol, @ColNameS09 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S09ID'
--Quy Cach 10
SELECT TOP 1 @ColumnNameS10 = DataCol, @ColNameS10 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S10ID'
--Quy Cach 11
SELECT TOP 1 @ColumnNameS11 = DataCol, @ColNameS11 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S11ID'
--Quy Cach 12
SELECT TOP 1 @ColumnNameS12 = DataCol, @ColNameS12 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S12ID'
--Quy Cach 13
SELECT TOP 1 @ColumnNameS13 = DataCol, @ColNameS13 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S13ID'
--Quy Cach 14
SELECT TOP 1 @ColumnNameS14 = DataCol, @ColNameS14 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S14ID'
--Quy Cach 15
SELECT TOP 1 @ColumnNameS15 = DataCol, @ColNameS15 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S15ID'
--Quy Cach 16
SELECT TOP 1 @ColumnNameS16 = DataCol, @ColNameS16 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S16ID'
--Quy Cach 17
SELECT TOP 1 @ColumnNameS17 = DataCol, @ColNameS17 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S17ID'
--Quy Cach 18
SELECT TOP 1 @ColumnNameS18 = DataCol, @ColNameS18 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S18ID'
--Quy Cach 19
SELECT TOP 1 @ColumnNameS19 = DataCol, @ColNameS19 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S19ID'
--Quy Cach 20
SELECT TOP 1 @ColumnNameS20 = DataCol, @ColNameS20 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'S20ID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT VoucherNo,[Type],[YearPlan],InventoryID,ObjectID,S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @VoucherNo,@TYPE,@YearPlan,@InventoryID,@ObjectID,@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

WHILE @@FETCH_STATUS = 0
BEGIN
	---- Kiểm tra trùng số chứng từ trong danh mục
	IF EXISTS (SELECT TOP  1 1 FROM dbo.SOT2070 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
				ErrorColumn = @ColName+','
	END 
	---- Kiểm tra tồn tại Type 
	IF EXISTS (SELECT TOP  1 1 FROM #Data WHERE [Type] NOT IN(0,1))
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-00ML000036,',
				ErrorColumn = @ColName1+','
	END 
	--Kiểm tra năm hợp lệ
	IF EXISTS (SELECT TOP  1 1 FROM #Data WHERE  CONVERT(INT,ISNULL(YearPlan,0)) NOT BETWEEN YEAR(GETDATE()) AND YEAR(GETDATE())+4)
	BEGIN
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName2 + LTRIM(RTRIM(STR([Row]))) +'-AFML000168,',
				ErrorColumn = @ColName2+','
	END
	--Kiểm tra tồn tại mã sản phẩm
	IF  ISNULL(@InventoryID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP  1 1 FROM AT1302(NOLOCK) WHERE InventoryID = @InventoryID)
		begin			
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnName3 + LTRIM(RTRIM(STR([Row]))) +'-00ML000070,',
				ErrorColumn = @ColName3+','
		WHERE InventoryID = @InventoryID
		end
	END
	--Kiểm tra tồn tại đối tượng
	IF  ISNULL(@ObjectID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP  1 1 FROM AT1202(NOLOCK) WHERE ObjectID = @ObjectID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameObjectID + LTRIM(RTRIM(STR([Row]))) +'-00ML000070,',
				ErrorColumn = @ColNameObjectID+','
		WHERE ObjectID = @ObjectID
		end
	END
	--Kiem tra ton tai Quy Cach 1
IF  ISNULL(@S01ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S01' AND StandardID = @S01ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS01 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS01+','
		end
	END
--Kiem tra ton tai Quy Cach 2
IF  ISNULL(@S02ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S02' AND StandardID = @S02ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS02 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS02+','
		end
	END
--Kiem tra ton tai Quy Cach 3
IF  ISNULL(@S03ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S03' AND StandardID = @S03ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS03 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS03+','
		end
	END
--Kiem tra ton tai Quy Cach 4
IF  ISNULL(@S04ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S04' AND StandardID = @S04ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS04 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS04+','
		end
	END
--Kiem tra ton tai Quy Cach 5
IF  ISNULL(@S05ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S05' AND StandardID = @S05ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS05 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS05+','
		end
	END
--Kiem tra ton tai Quy Cach 6
IF  ISNULL(@S06ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S06' AND StandardID = @S06ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS06 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS06+','
		end
	END
--Kiem tra ton tai Quy Cach 7
IF  ISNULL(@S07ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S07' AND StandardID = @S07ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS07 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS07+','
		end
	END
--Kiem tra ton tai Quy Cach 8
IF  ISNULL(@S08ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S08' AND StandardID = @S08ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS08 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS08+','
		end
	END
--Kiem tra ton tai Quy Cach 9
IF  ISNULL(@S09ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S09' AND StandardID = @S09ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS09 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS09+','
		end
	END
--Kiem tra ton tai Quy Cach 10
IF  ISNULL(@S10ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S10' AND StandardID = @S10ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS10 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS10+','
		end
	END
--Kiem tra ton tai Quy Cach 11
IF  ISNULL(@S11ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S11' AND StandardID = @S11ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS11 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS11+','
		end
	END
--Kiem tra ton tai Quy Cach 12
IF  ISNULL(@S12ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S12' AND StandardID = @S12ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS12 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS12+','
		end
	END
--Kiem tra ton tai Quy Cach 13
IF  ISNULL(@S13ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S13' AND StandardID = @S13ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS13 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS13+','
		end
	END
--Kiem tra ton tai Quy Cach 14
IF  ISNULL(@S14ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S14' AND StandardID = @S14ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS14 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS14+','
		end
	END
--Kiem tra ton tai Quy Cach 15
IF  ISNULL(@S15ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S15' AND StandardID = @S15ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS15 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS15+','
		end
	END
--Kiem tra ton tai Quy Cach 16
IF  ISNULL(@S16ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S16' AND StandardID = @S16ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS16 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS16+','
		end
	END
--Kiem tra ton tai Quy Cach 17
IF  ISNULL(@S17ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S17' AND StandardID = @S17ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS17 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS17+','
		end
	END
--Kiem tra ton tai Quy Cach 18
IF  ISNULL(@S18ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S18' AND StandardID = @S18ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS18 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS18+','
		end
	END
--Kiem tra ton tai Quy Cach 19
IF  ISNULL(@S19ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S19' AND StandardID = @S19ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS19 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS19+','
		end
	END
--Kiem tra ton tai Quy Cach 20
IF  ISNULL(@S20ID,'') !='' 
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM AT0128(NOLOCK) WHERE StandardTypeID='S20' AND StandardID = @S20ID)
		begin
		UPDATE	#Data 
		SET	ErrorMessage = @ColumnNameS20 + LTRIM(RTRIM(STR([Row]))) +'-00ML000180,',
				ErrorColumn = @ColNameS20+','
		end
	END

	FETCH NEXT FROM @Cur INTO @VoucherNo,@TYPE,@YearPlan,@InventoryID,@ObjectID,@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
END

Close @Cur


------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END


print ('B')

-- Đẩy dữ liệu vào danh mục 
INSERT INTO dbo.SOT2070 (APK, DivisionID, VoucherNo, VoucherDate, ObjectID, Type, YearPlan, CreateUserID, CreateDate, LastModifyDate, LastModifyUserID)

SELECT NEWID()AS APKMaster,D1.DivisionID,D1.VoucherNo,D1.VoucherDate,D1.ObjectID,D1.[Type],D1.YearPlan,D1.[CreateUserID],D1.CreateDate,D1.LastModifyDate,D1.LastModifyUserID
 FROM (SELECT DISTINCT DivisionID, VoucherNo, CASE WHEN ISNULL(VoucherDate1,'') ='' THEN NULL ELSE CONVERT(DATETIME, VoucherDate1, 104) END AS VoucherDate, ObjectID, [Type],YearPlan
		, @UserID AS [CreateUserID], GETDATE() AS CreateDate, GETDATE() AS LastModifyDate, @UserID AS LastModifyUserID
	FROM #Data ) AS D1
	
INSERT INTO dbo.SOT2071 (APK, APKMaster, DivisionID, InventoryID, InventoryName, UnitID, UnitPrice, Quantity1, Quantity2, Quantity3, Quantity4, Quantity5, Quantity6, Quantity7, Quantity8, Quantity9, Quantity10, Quantity11, Quantity12, Notes, CreateUserID, CreateDate, LastModifyDate, LastModifyUserID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)

SELECT NEWID() AS APK,T70.APK AS APKMaster, D.DivisionID, D.InventoryID, AT02.InventoryName,AT02.UnitID,UnitPrice,Quantity1 , Quantity2, Quantity3, Quantity4, Quantity5, Quantity6, Quantity7, Quantity8, Quantity9, Quantity10, Quantity11, Quantity12, Note, @UserID AS [CreateUserID], GETDATE() AS CreateDate, GETDATE() AS LastModifyDate, @UserID AS LastModifyUserID,D.S01ID, D.S02ID, D.S03ID, D.S04ID, D.S05ID, D.S06ID, D.S07ID, D.S08ID, D.S09ID, D.S10ID, D.S11ID, D.S12ID, D.S13ID, D.S14ID, D.S15ID, D.S16ID, D.S17ID, D.S18ID, D.S19ID, D.S20ID
	FROM #Data  AS D
	JOIN dbo.AT1302 AS AT02 ON AT02.InventoryID = D.InventoryID
	JOIN dbo.SOT2070 AS T70 ON T70.VoucherNo = D.VoucherNo

print ('C')

---------->Update mã tự động
	DECLARE @cPKey AS CURSOR
	DECLARE @Row AS INT,
		@StrDivisionID AS NVARCHAR(50),
		@VoucherTypeID AS NVARCHAR(50),
		@VoucherDate AS datetime,
		@TranMonth AS INT,
		@TranYear AS INT,
		@VoucherDeliveryProgress AS NVARCHAR(50)

	-- Lấy loại chứng từ
	SET @VoucherDeliveryProgress = (SELECT TOP 1 VoucherTypeID FROM AT1007 WITH (NOLOCK) 
	INNER JOIN SOT0002 WITH (NOLOCK) ON AT1007.DivisionID IN (SOT0002.DivisionID, '@@@')  AND AT1007.VoucherTypeID = SOT0002.VoucherSalesPlan 
	WHERE SOT0002.DivisionID = @DivisionID)

	SET @cPKey = CURSOR FOR
	SELECT top 1 T1.Orders, T1.DivisionID as StrDivisionID, @VoucherDeliveryProgress, T1.VoucherDate1, Month(VoucherDate1) as TranMonth, Year(VoucherDate1) as TranYear
	FROM	#Data T1
	ORDER BY  T1.Orders DESC
		
	OPEN @cPKey
	FETCH NEXT FROM @cPKey INTO @Row,@StrDivisionID, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear
	WHILE @@FETCH_STATUS = 0
	BEGIN
			DECLARE	@StringKey1 nvarchar(50), @StringKey2 nvarchar(50),@StringKey3 nvarchar(50), 
							@OutputLen int, @OutputOrder int,
							@Separated int, @Separator char(1),
							@Enabled1 tinyint, @Enabled2 tinyint, @Enabled3 tinyint,
							@S1 nvarchar(50), @S2 nvarchar(50),@S3 nvarchar(50),
							@S1Type tinyint, @S2Type tinyint,@S3Type tinyint,
							@KeyString AS NVARCHAR(50),
							@LastKey INT,
							@TableName NVARCHAR(50) ='SOT2070'

					Select	@Enabled1=Enabled1, @Enabled2=Enabled2, @Enabled3=Enabled3, @S1=S1, @S2=S2, @S3=S3, @S1Type=S1Type, @S2Type=S2Type, @S3Type=S3Type
							, @OutputLen = OutputLength, @OutputOrder= OutputOrder,@Separated= Separated,@Separator= Separator
					FROM	AT1007 WITH (NOLOCK)
					WHERE	DivisionID = @DivisionID AND VoucherTypeID = @VoucherTypeID 
						If @Enabled1 = 1
							Set @StringKey1 = Case @S1Type When 1 Then Case When STR(@TranMonth) <10 Then '0' + ltrim(STR(@TranMonth)) Else ltrim(STR(@TranMonth)) End
															When 2 Then ltrim(STR(@TranYear))
															When 3 Then @VoucherTypeID
															When 4 Then @StrDivisionID
															When 5 Then @S1 Else '' End
						Else Set @StringKey1 = ''
						If @Enabled2 = 1
							Set @StringKey2 = Case @S2Type When 1 Then Case When STR(@TranMonth) <10 Then '0' + ltrim(STR(@TranMonth)) Else ltrim(STR(@TranMonth)) End
															When 2 Then ltrim(STR(@TranYear))
															When 3 Then @VoucherTypeID
															When 4 Then @StrDivisionID
															When 5 Then @S2 Else '' End
						Else Set @StringKey2 = ''
						If @Enabled3 = 1
							Set @StringKey3 = Case @S3Type When 1 Then Case When STR(@TranMonth) <10 Then '0'+ ltrim(STR(@TranMonth)) Else @TranMonth End
															When 2 Then ltrim(STR(@TranYear))
															When 3 Then @VoucherTypeID
															When 4 Then @StrDivisionID
															When 5 Then @S3
															Else '' End 

			SET @KeyString = @StringKey1 + @StringKey2 + @StringKey3

			print @KeyString

			IF NOT EXISTS (SELECT TOP 1 1 FROM AT4444 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString)
			INSERT INTO AT4444 (DivisionID, TableName, KeyString, LastKey) SELECT @DivisionID, @TableName, @KeyString, 0
	
			UPDATE AT4444 SET @LastKey = LastKey + 1, LastKey = LastKey + @Row
			WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString
				
	FETCH NEXT FROM @cPKey INTO  @Row,@StrDivisionID, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear
	END	
	CLOSE @cPKey


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
