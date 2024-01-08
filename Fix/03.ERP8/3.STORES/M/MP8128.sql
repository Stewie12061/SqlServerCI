IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8128]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8128]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xử lý Import dữ liệu bộ hệ số theo sản phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 02/06/2021 by Lê Hoàng
---- Modified on ... by ...: ...
-- <Example>
---- 
CREATE PROCEDURE [DBO].[MP8128]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@sAPKMaster AS NVARCHAR(50) = CONVERT(NVARCHAR(50),NEWID())
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	APKMaster NVARCHAR(50),
	APKDetail NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT ('')
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	APK NVARCHAR(50)--,	
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

	
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('CoefficientID').value('.', 'NVARCHAR(50)') AS CoefficientID,
		X.Data.query('CoefficientName').value('.', 'NVARCHAR(250)') AS CoefficientName,
		X.Data.query('CoType').value('.', 'INT') AS CoType,
		X.Data.query('RefNo').value('.', 'NVARCHAR(50)') AS RefNo,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('InventoryTypeID').value('.', 'NVARCHAR(50)') AS InventoryTypeID,
		X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
		X.Data.query('CoValue').value('.', 'DECIMAL(28,8)') AS CoValue,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
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
		X.Data.query('S20ID').value('.', 'NVARCHAR(50)') AS S20ID
INTO	#MP8128		
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (
		APKMaster, APKDetail, Row,			DivisionID,			CoefficientID,
		CoefficientName,			CoType,	
		RefNo,		Description,
		EmployeeID,	InventoryTypeID, InventoryID,CoValue,Notes,
		S01ID,		S02ID,			S03ID,		S04ID,		S05ID,
		S06ID,		S07ID,			S08ID,		S09ID,		S10ID,
		S11ID,		S12ID,			S13ID,		S14ID,		S15ID,
		S16ID,		S17ID,			S18ID,		S19ID,		S20ID
)	
SELECT @sAPKMaster, CONVERT(NVARCHAR(50),NEWID()) APKDetail, * FROM #MP8128		 

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

-- Kiểm tra trùng mã
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateInTable', @ColID = 'CoefficientID', @Param1 = 'MT1604', @Param2 = 'CoefficientID'

-- Kiểm tra dữ liệu đồng nhất
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'CoefficientID', @Param1 = 'CoefficientID,CoefficientName,CoType,RefNo,Description,EmployeeID,InventoryTypeID'

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			CoValue = ROUND(CoValue, CUR.PercentDecimal)
FROM		#Data DT
INNER JOIN	MT0000 CUR ON CUR.DivisionID IN (DT.DivisionID,'@@@')

-- Cập nhật thông tin hóa đơn và tài khoản	

--drop constraint 
--SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
--			BEGIN
--				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Keys_PK+''' AND xtype = ''PK'')
--					ALTER TABLE #Keys DROP CONSTRAINT ' + @Keys_PK +'
--			END
--			IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
--			BEGIN
--				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
--					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
--			END
--			'
--EXEC(@SQL)

-- Đẩy dữ liệu vào bảng
INSERT INTO MT1604
(
APK, DivisionID, CoefficientID, CoefficientName, Description, InventoryTypeID,	
EmployeeID, CoType, CreateUserID, CreateDate, LastModifyUserID,	
LastModifyDate,	Disabled, RefNo
)
SELECT DISTINCT APKMaster, DivisionID, CoefficientID, CoefficientName, Description, InventoryTypeID,	
EmployeeID, CoType, @UserID, GETDATE(), @UserID, GETDATE(), 0, RefNo
FROM #Data

--- MT1605
INSERT INTO MT1605
(
DivisionID, DeCoefficientID, CoefficientID, InventoryID, CoValue, Notes
)
SELECT DivisionID, APKDetail, CoefficientID, InventoryID, CoValue, Notes
FROM #Data

--- MT8899
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	INSERT INTO MT8899 (DivisionID, TableID, VoucherID, TransactionID,
	      S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
	      S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
	SELECT DivisionID, 'MT1605', CoefficientID, APKDetail,
		   S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
	       S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	FROM #Data
END

LB_RESULT:
SELECT * FROM #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
