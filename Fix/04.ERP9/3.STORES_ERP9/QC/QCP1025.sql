IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP1025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].QCP1025
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Import Excel danh mục định nghĩa tiêu chuẩn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Cao Thanh Thi 3/12/2020
---- Modified by Le Hoang on 17/02/2021 : chinh sua lai cau thong bao loi, vi neu 1000 dòng đều lỗi (vd có 1 cột ko tồn tại mã) thì lỗi trên UI
---- Modified by Le Hoang on 12/03/2021 : select top 200 dữ liệu nếu lỗi >= 900 dòng
---- Modified by on
-- <Example>

CREATE PROCEDURE QCP1025
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
	APKMaster uniqueidentifier DEFAULT NULL,
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
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('Notes').value('.','NVARCHAR(250)') AS Notes,
		X.Data.query('Notes01').value('.','NVARCHAR(250)') AS Notes01,
		X.Data.query('Notes02').value('.','NVARCHAR(250)') AS Notes02,
		X.Data.query('Notes03').value('.','NVARCHAR(250)') AS Notes03,
		X.Data.query('Disabled').value('.','INT') AS Disabled,
		X.Data.query('IsCommon').value('.','INT') AS IsCommon,
		X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID,
		X.Data.query('SRange01').value('.','NVARCHAR(250)') AS SRange01,
		X.Data.query('SRange02').value('.','NVARCHAR(250)') AS SRange02,
		X.Data.query('SRange03').value('.','NVARCHAR(250)') AS SRange03,
		X.Data.query('SRange04').value('.','NVARCHAR(250)') AS SRange04,
		X.Data.query('SRange05').value('.','NVARCHAR(250)') AS SRange05,
		X.Data.query('DisabledStandard').value('.','INT') AS DisabledStandard
INTO #QCP1025
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

 INSERT INTO #Data ([Row],  DivisionID, InventoryID, Notes, Notes01, Notes02, Notes03, Disabled, IsCommon, StandardID, SRange01, SRange02, SRange03, SRange04, SRange05, DisabledStandard)
 SELECT [Row], DivisionID, InventoryID, Notes, Notes01, Notes02, Notes03, Disabled, IsCommon, StandardID, SRange01, SRange02, SRange03, SRange04, SRange05, DisabledStandard
 FROM #QCP1025
--SELECT * from #Data

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-QC', @ColID = 'InventoryID', @Param1 = 'InventoryID, DivisionID, Notes, Notes01, Notes02, Notes03, Disabled, IsCommon'

---- Kiểm tra dữ liệu detail
DECLARE @ColumnNameStandard VARCHAR(50), @ColNameStandard NVARCHAR(50),
		@ColumnName1 VARCHAR(50), @ColName1 NVARCHAR(50),
		@ColumnName2 VARCHAR(50), @ColName2 NVARCHAR(50),
		@ColumnName3 VARCHAR(50), @ColName3 NVARCHAR(50),
		@ColumnName4 VARCHAR(50), @ColName4 NVARCHAR(50),
		@ColumnName5 VARCHAR(50), @ColName5 NVARCHAR(50),
		@ColumnName6 VARCHAR(50), @ColName6 NVARCHAR(50),
		@Cur CURSOR,
		@CurStandard CURSOR,
		@InventoryID VARCHAR(50),
		@StandardID VARCHAR(50),
		@SRange01 VARCHAR(50), @SRange02 VARCHAR(50), @SRange03 VARCHAR(50), @SRange04 VARCHAR(50), @SRange05 VARCHAR(50)

CREATE TABLE #ExistsError
(
	InventoryID NVARCHAR(50),
	StandardID NVARCHAR(50),
	ErrorMessage NVARCHAR(50)
) 

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'

SELECT TOP 1 @ColumnName2 = DataCol, @ColName2 = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SRange01'
SELECT TOP 1 @ColumnName3 = DataCol, @ColName3 = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SRange02'
SELECT TOP 1 @ColumnName4 = DataCol, @ColName4 = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SRange03'
SELECT TOP 1 @ColumnName5 = DataCol, @ColName5 = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SRange04'
SELECT TOP 1 @ColumnName6 = DataCol, @ColName6 = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SRange05'

SELECT TOP 1 @ColumnNameStandard = DataCol, @ColNameStandard = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'StandardID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT InventoryID, StandardID, SRange01, SRange02, SRange03, SRange04, SRange05 FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @InventoryID, @StandardID, @SRange01, @SRange02, @SRange03, @SRange04, @SRange05

WHILE @@FETCH_STATUS = 0
BEGIN

	---- Kiểm tra trùng mã Mặt hàng
	IF EXISTS (SELECT TOP  1 1 FROM QCT1020 JOIN QCT1021 ON QCT1020.APK = QCT1021.APKMaster WHERE LTRIM(RTRIM(InventoryID)) = LTRIM(RTRIM(@InventoryID)) AND LTRIM(RTRIM(StandardID)) = LTRIM(RTRIM(@StandardID))  )
	BEGIN
		UPDATE #Data 
		SET	ErrorMessage = ErrorMessage + @ColumnNameStandard + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
				ErrorColumn = ErrorColumn + @ColNameStandard + ','
		WHERE LTRIM(RTRIM(InventoryID)) = LTRIM(RTRIM(@InventoryID)) AND LTRIM(RTRIM(StandardID)) = LTRIM(RTRIM(@StandardID))
	END
	ELSE
	BEGIN
		UPDATE #Data SET APKMaster = (SELECT TOP 1 APK FROM QCT1020 WITH (NOLOCK) WHERE TRIM(InventoryID) = TRIM(@InventoryID))
		WHERE LTRIM(RTRIM(InventoryID)) = LTRIM(RTRIM(@InventoryID))
	END

	--cần kiểm tra các tiêu chí cho StandardID là tiêu chuẩn ngoại quan Type = 'APPE' 
	IF EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @StandardID AND TypeID = 'APPE')
	BEGIN
		PRINT @StandardID
		----1. Các mã ở SRang01->SRange05 phải tồn tại trong Danh mục tiêu chuẩn 
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange01 AND TypeID = 'APPE') AND ISNULL(@SRange01,'') <> ''
		BEGIN
			print '@SRange01'
			--IF NOT EXISTS (SELECT TOP 1 1 FROM #ExistsError WITH(NOLOCK) WHERE StandardID = @SRange01)
			--BEGIN
			--	INSERT INTO #ExistsError(InventoryID, StandardID, ErrorMessage) VALUES (@InventoryID, @SRange01, '00ML000152')
			--END
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName2 + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = ErrorColumn + @ColName2 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange01 = @SRange01
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange02 AND TypeID = 'APPE') AND ISNULL(@SRange02,'') <> ''
		BEGIN
			--IF NOT EXISTS (SELECT TOP 1 1 FROM #ExistsError WITH(NOLOCK) WHERE StandardID = @SRange02)
			--BEGIN
			--	INSERT INTO #ExistsError(InventoryID, StandardID, ErrorMessage) VALUES (@InventoryID, @SRange02, '00ML000152')
			--END
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName3 + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = ErrorColumn + @ColName3 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange02 = @SRange02
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange03 AND TypeID = 'APPE') AND ISNULL(@SRange03,'') <> ''
		BEGIN
			--IF NOT EXISTS (SELECT TOP 1 1 FROM #ExistsError WITH(NOLOCK) WHERE StandardID = @SRange03)
			--BEGIN
			--	INSERT INTO #ExistsError(InventoryID, StandardID, ErrorMessage) VALUES (@InventoryID, @SRange03, '00ML000152')
			--END
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName4 + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = ErrorColumn + @ColName4 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange03 = @SRange03
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange04 AND TypeID = 'APPE') AND ISNULL(@SRange04,'') <> ''
		BEGIN
			--IF NOT EXISTS (SELECT TOP 1 1 FROM #ExistsError WITH(NOLOCK) WHERE StandardID = @SRange04)
			--BEGIN
			--	INSERT INTO #ExistsError(InventoryID, StandardID, ErrorMessage) VALUES (@InventoryID, @SRange04, '00ML000152')
			--END
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName5 + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = ErrorColumn + @ColName5 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange04 = @SRange04
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange05 AND TypeID = 'APPE') AND ISNULL(@SRange05,'') <> ''
		BEGIN
			--IF NOT EXISTS (SELECT TOP 1 1 FROM #ExistsError WITH(NOLOCK) WHERE StandardID = @SRange05)
			--BEGIN
			--	INSERT INTO #ExistsError(InventoryID, StandardID, ErrorMessage) VALUES (@InventoryID, @SRange05, '00ML000152')
			--END
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName6 + LTRIM(RTRIM(STR([Row]))) +'-00ML000152,',
				ErrorColumn = ErrorColumn + @ColName6 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange05 = @SRange05
		END
		----2. Các mã ở SRang01->SRange05 nếu có thì phải là con của StandardID
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange01 AND TypeID = 'APPE' 
		AND CONCAT(',',ParentID,',') LIKE CONCAT('%,',@StandardID,',%')) AND ISNULL(@SRange01,'') <> ''
		BEGIN
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName2 + LTRIM(RTRIM(STR([Row]))) + ':' + @SRange01 + '-QCFML000010,',
				ErrorColumn = ErrorColumn + @ColName2 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange02 = @SRange02
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange02 AND TypeID = 'APPE' 
		AND CONCAT(',',ParentID,',') LIKE CONCAT('%,',@StandardID,',%')) AND ISNULL(@SRange02,'') <> ''
		BEGIN
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName3 + LTRIM(RTRIM(STR([Row]))) + ':' + @SRange02 + '-QCFML000010,',
				ErrorColumn = ErrorColumn + @ColName3 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange02 = @SRange02
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange03 AND TypeID = 'APPE' 
		AND CONCAT(',',ParentID,',') LIKE CONCAT('%,',@StandardID,',%')) AND ISNULL(@SRange03,'') <> ''
		BEGIN
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName4 + LTRIM(RTRIM(STR([Row]))) + ':' + @SRange03 + '-QCFML000010,',
				ErrorColumn = ErrorColumn + @ColName4 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange02 = @SRange02
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange04 AND TypeID = 'APPE' 
		AND CONCAT(',',ParentID,',') LIKE CONCAT('%,',@StandardID,',%')) AND ISNULL(@SRange04,'') <> ''
		BEGIN
			UPDATE #Data 
			SET	ErrorMessage = ErrorMessage + @ColumnName5 + LTRIM(RTRIM(STR([Row]))) + ':' + @SRange04 + '-QCFML000010,',
				ErrorColumn = ErrorColumn + @ColName5 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange02 = @SRange02
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM QCT1000 WITH(NOLOCK) WHERE StandardID = @SRange05 AND TypeID = 'APPE' 
		AND CONCAT(',',ParentID,',') LIKE CONCAT('%,',@StandardID,',%')) AND ISNULL(@SRange05,'') <> ''
		BEGIN
			UPDATE #Data
			SET	ErrorMessage = ErrorMessage + @ColumnName6 + LTRIM(RTRIM(STR([Row]))) + ':' + @SRange05 + '-QCFML000010,',
				ErrorColumn = ErrorColumn + @ColName6 + ','
			WHERE InventoryID = @InventoryID AND StandardID = @StandardID AND SRange02 = @SRange02
		END
	END

	FETCH NEXT FROM @Cur INTO @InventoryID, @StandardID, @SRange01, @SRange02, @SRange03, @SRange04, @SRange05
END

CLOSE @Cur


--SELECT * FROM #ExistsError
---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

DECLARE @QCT1020ID TABLE (APK uniqueidentifier, InventoryID VARCHAR(50))


-- Insert dữ liệu vào bảng Master (CIT1150)
INSERT INTO QCT1020(APK, DivisionID, InventoryID, Notes, Notes01, Notes02, Notes03, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
OUTPUT INSERTED.APK, INSERTED.InventoryID INTO @QCT1020ID(APK,InventoryID)
SELECT NEWID(), a.*, @UserID, GETDATE(), @UserID, GETDATE()
FROM (SELECT DISTINCT DivisionID, InventoryID, Notes, Notes01, Notes02, Notes03, Disabled, IsCommon
FROM #Data
WHERE ErrorMessage = '' AND APKMaster IS NULL) AS a

INSERT INTO QCT1021(DivisionID, APKMaster, StandardID, SRange01, SRange02, SRange03, SRange04, SRange05, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT DivisionID, b.APK, a.StandardID, a.SRange01, a.SRange02, a.SRange03, a.SRange04, a.SRange05, a.Disabled, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data AS a
JOIN @QCT1020ID AS b ON a.InventoryID = b.InventoryID
WHERE a.ErrorMessage = '' AND a.APKMaster IS NULL

INSERT INTO QCT1021(DivisionID, APKMaster, StandardID, SRange01, SRange02, SRange03, SRange04, SRange05, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT DivisionID, a.APKMaster, a.StandardID, a.SRange01, a.SRange02, a.SRange03, a.SRange04, a.SRange05, a.Disabled, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data AS a
WHERE a.ErrorMessage = '' AND a.APKMaster IS NOT NULL

-- Lưu lich su
INSERT INTO QCT00003(APK,DivisionID,HistoryID,Description,RelatedToID,RelatedToTypeID,CreateDate,CreateUserID,StatusID,ScreenID,TableID)
SELECT NEWID() AS APK, @DivisionID AS DivisionID, NULL AS HistoryID, 
'''A00.AddNew'' ''A00.QCT1020''</br>''A00.AddNew'' ''A00.QCT1021''</br>' AS Description, 
APK AS RelatedToID, 47 AS RelatedToTypeID, GETDATE() AS CreateDate, @UserID AS CreateUserID, 
1 AS StatusID, 'QCF1021' AS ScreenID, 'QCT1020' AS TableID
FROM @QCT1020ID

-- Lưu nguoi theo doi
INSERT INTO QCT9020(DivisionID,APKMaster,RelatedToID,TableID,FollowerID01,FollowerName01,TypeFollow,CreateDate,CreateUserID,RelatedToTypeID)
SELECT @DivisionID, A.APK, NULL, 'QCT1020', @UserID, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = @UserID), 0, GETDATE(), @UserID, 0
FROM @QCT1020ID A

--UPDATE AT4444 
--SET LastKey = (SELECT SUBSTRING(MAX(MachineID), 4, 8) FROM CIT1150)
--WHERE TableName = 'CIT1150' AND KEYSTRING = 'MCV' 	

LB_RESULT:
IF (SELECT COUNT(*) FROM #Data WHERE  ErrorColumn <> '') >= 900
BEGIN
	SELECT TOP 200 [Row], ErrorColumn, ErrorMessage FROM #Data
	WHERE  ErrorColumn <> ''
	ORDER BY [Row]
END
ELSE
BEGIN 
	SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
	WHERE  ErrorColumn <> ''
	ORDER BY [Row]
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
