IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2055_VNP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)         
DROP PROCEDURE [DBO].[QCP2055_VNP]
GO
/****** Object:  StoredProcedure [dbo].[QCT2055]    Script Date: 12/4/2020 7:55:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- <Summary>
---- Import Excel nghệp vụ NVL có cứng 6 cột Ghi nhận số lượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by nhttai 2/12/2020
---- Modified by Le Hoang on 22/06/2021 : Bỏ kiểm tra trùng số batch cùng mã nvl
---- Modified by on
-- <Example>

CREATE PROCEDURE [dbo].[QCP2055_VNP]
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

print 'before'
SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherTypeID').value('.','NVARCHAR(50)') AS VoucherTypeID,
        X.Data.query('VoucherNo').value('.','NVARCHAR(50)') AS VoucherNo,
        --X.Data.query('VoucherDate').value('.','DATETIME') AS VoucherDate,
		(CASE WHEN X.Data.query('VoucherDate').value('.', 'VARCHAR(50)') = '' THEN CONVERT(DATETIME, NULL)
			  ELSE X.Data.query('VoucherDate').value('.', 'DATETIME2') END) AS VoucherDate,--VoucherDate
        X.Data.query('Notes').value('.','NVARCHAR(MAX)') AS Notes,
        X.Data.query('DeleteVoucher').value('.','INT') AS DeleteVoucher,
        X.Data.query('VoucherShiftNo').value('.','NVARCHAR(250)') AS VoucherShiftNo,
        X.Data.query('BatchNo').value('.','NVARCHAR(250)') AS BatchNo,
        X.Data.query('MaterialID').value('.','NVARCHAR(250)') AS MaterialID,
        X.Data.query('BatchMaterialNo').value('.','NVARCHAR(250)') AS BatchMaterialNo,
        X.Data.query('NotesMaterial').value('.','NVARCHAR(250)') AS NotesMaterial,     
		(CASE WHEN X.Data.query('BeginQuantity').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('BeginQuantity').value('.', 'NVARCHAR(50)') END) AS BeginQuantity, 
		(CASE WHEN X.Data.query('DebitQuantity').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('DebitQuantity').value('.', 'NVARCHAR(50)') END) AS DebitQuantity, 
		(CASE WHEN X.Data.query('CreditQuantity').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('CreditQuantity').value('.', 'NVARCHAR(50)') END) AS CreditQuantity, 
		(CASE WHEN X.Data.query('RevokeQuantity').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('RevokeQuantity').value('.', 'NVARCHAR(50)') END) AS RevokeQuantity, 
		(CASE WHEN X.Data.query('ReturnQuantity').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('ReturnQuantity').value('.', 'NVARCHAR(50)') END) AS ReturnQuantity, 
		(CASE WHEN X.Data.query('EndQuantity').value('.', 'NVARCHAR(50)') = '' THEN CONVERT(NVARCHAR(50), NULL)
			  ELSE X.Data.query('EndQuantity').value('.', 'NVARCHAR(50)') END) AS EndQuantity
INTO #QCP2055_VNP
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

 INSERT INTO #Data ([Row],  DivisionID, VoucherTypeID, VoucherNo, VoucherDate, Notes, DeleteVoucher, VoucherShiftNo, BatchNo, 
 MaterialID, BatchMaterialNo,NotesMaterial, BeginQuantity,DebitQuantity,CreditQuantity,RevokeQuantity,ReturnQuantity,EndQuantity)
 SELECT [Row], DivisionID, VoucherTypeID, REPLACE(REPLACE(LTRIM(RTRIM(VoucherNo)),char(13)+char(10),''),CHAR(13),''),
  VoucherDate, Notes, DeleteVoucher, 
  REPLACE(REPLACE(LTRIM(RTRIM(VoucherShiftNo)),char(13)+char(10),''),CHAR(13),''), 
  REPLACE(REPLACE(LTRIM(RTRIM(BatchNo)),char(13)+char(10),''),CHAR(13),''), 
  REPLACE(REPLACE(LTRIM(RTRIM(MaterialID)),char(13)+char(10),''),CHAR(13),''), 
  REPLACE(REPLACE(LTRIM(RTRIM(BatchMaterialNo)),char(13)+char(10),''),CHAR(13),''),
  NotesMaterial,BeginQuantity,DebitQuantity,CreditQuantity,RevokeQuantity,ReturnQuantity,EndQuantity
 FROM #QCP2055_VNP

--SELECT * from #Data

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-QC', @ColID = 'VoucherNo', 
@Param1 = 'VoucherNo, VoucherTypeID, DivisionID, VoucherDate, Notes, DeleteVoucher'

---- Kiểm tra dữ liệu không đồng nhất tại phần chi tiết NVL 
--EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-QC', @ColID = 'MaterialID, BatchMaterialNo', 
--@Param1 = 'MaterialID, BatchMaterialNo, NotesMaterial'

	DECLARE @cList CURSOR
	DECLARE @Row INT
	DECLARE @bIsFirst TINYINT
	DECLARE @ColumnName VARCHAR(8000)
	DECLARE @MaterialID1 NVARCHAR(250)
	DECLARE @OLD__MaterialID NVARCHAR(250)
	DECLARE @BatchMaterialNo NVARCHAR(250)
	DECLARE @OLD__BatchMaterialNo NVARCHAR(250)
	DECLARE @NotesMaterial NVARCHAR(250)
	DECLARE @OLD__NotesMaterial NVARCHAR(250)
	DECLARE @BeginQuantity NVARCHAR(50)
	DECLARE @OLD__BeginQuantity NVARCHAR(50)
	DECLARE @DebitQuantity NVARCHAR(50)
	DECLARE @OLD__DebitQuantity NVARCHAR(50)
	DECLARE @CreditQuantity NVARCHAR(50)
	DECLARE @OLD__CreditQuantity NVARCHAR(50)
	DECLARE @RevokeQuantity NVARCHAR(50)
	DECLARE @OLD__RevokeQuantity NVARCHAR(50)
	DECLARE @ReturnQuantity NVARCHAR(50)
	DECLARE @OLD__ReturnQuantity NVARCHAR(50)
	DECLARE @EndQuantity NVARCHAR(50)
	DECLARE @OLD__EndQuantity NVARCHAR(50)
	
	SET @bIsFirst = 1	
	SET @cList = CURSOR FAST_FORWARD READ_ONLY FOR
		SELECT		Row, MaterialID, BatchMaterialNo, NotesMaterial, BeginQuantity, DebitQuantity, CreditQuantity, RevokeQuantity, ReturnQuantity, EndQuantity
		FROM		#DATA		
		ORDER BY	MaterialID, BatchMaterialNo, NotesMaterial, Row
	OPEN @cList
	FETCH NEXT FROM @cList INTO @Row, @MaterialID1,@BatchMaterialNo,@NotesMaterial,@BeginQuantity,@DebitQuantity,@CreditQuantity,@RevokeQuantity,@ReturnQuantity,@EndQuantity
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ColumnName = ''
		IF (@MaterialID1 = @OLD__MaterialID AND @BatchMaterialNo = @OLD__BatchMaterialNo) AND @bIsFirst = 0
			BEGIN
				--SET @ColumnName = @ColumnName + CASE WHEN @ColumnName = '' THEN '' ELSE ', ' END + 'DebitQuantity'
				IF @OLD__NotesMaterial <> @NotesMaterial
				BEGIN
					SET @ColumnName = 'NotesMaterial'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				IF @OLD__BeginQuantity <> @BeginQuantity
				BEGIN
					SET @ColumnName = 'BeginQuantity'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				IF @OLD__DebitQuantity <> @DebitQuantity
				BEGIN
					SET @ColumnName = 'DebitQuantity'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				IF @OLD__CreditQuantity <> @CreditQuantity
				BEGIN
					SET @ColumnName = 'CreditQuantity'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				IF @OLD__RevokeQuantity <> @RevokeQuantity
				BEGIN
					SET @ColumnName = 'RevokeQuantity'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				IF @OLD__ReturnQuantity <> @ReturnQuantity
				BEGIN
					SET @ColumnName = 'ReturnQuantity'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				IF @OLD__EndQuantity <> @EndQuantity
				BEGIN
					SET @ColumnName = 'EndQuantity'
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
							ErrorColumn = ErrorColumn + @ColumnName+','
					WHERE	(Row = @Row)
				END
				--IF @ColumnName <> ''
				--	UPDATE	#DATA 
				--	SET		ErrorMessage =  ErrorMessage + 'H' + LTRIM(RTRIM(STR([Row]))) +'-00ML000149,',				
				--			ErrorColumn = ErrorColumn + @ColumnName+','
				--	WHERE	(Row = @Row)
			END
		ELSE
			SELECT @OLD__MaterialID = @MaterialID1,@OLD__BatchMaterialNo = @BatchMaterialNo,@OLD__NotesMaterial = @NotesMaterial,
				   @OLD__BeginQuantity=@BeginQuantity,@OLD__DebitQuantity=@DebitQuantity,@OLD__CreditQuantity=@CreditQuantity,
				   @OLD__RevokeQuantity=@RevokeQuantity,@OLD__ReturnQuantity=@ReturnQuantity,@OLD__EndQuantity=@EndQuantity
		SET @bIsFirst = 0
			
		FETCH NEXT FROM @cList INTO @Row, @MaterialID1,@BatchMaterialNo,@NotesMaterial,@BeginQuantity,@DebitQuantity,@CreditQuantity,@RevokeQuantity,@ReturnQuantity,@EndQuantity
	END

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @VoucherNo VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT VoucherNo FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @VoucherNo

WHILE @@FETCH_STATUS = 0
BEGIN

    ---- Kiểm tra trùng mã chứng từ
    IF EXISTS (SELECT TOP 1 1 FROM QCT2010 WITH (NOLOCK) WHERE REPLACE(REPLACE(VoucherNo,char(13)+char(10),''),CHAR(13),'') 
				= REPLACE(REPLACE(LTRIM(RTRIM(@VoucherNo)),char(13)+char(10),''),CHAR(13),'') AND VoucherType = 2 AND DeleteFlg = 0
	)
    BEGIN
        UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-QCFML000008,',
                ErrorColumn = ErrorColumn + @ColName1 + ','
    END

    FETCH NEXT FROM @Cur INTO @VoucherNo
END

CLOSE @Cur

DECLARE @ColumnName_Standard_1 VARCHAR(50),
        @ColName_Standard_1 NVARCHAR(50),
		@Col_Key VARCHAR(50),
		@Col_Name NVARCHAR(250),
        @Cur_Standard CURSOR,
		@Cur_01 CURSOR,
		@Cur_02 CURSOR,
		@Cur_03 CURSOR,
        @MaterialID VARCHAR(50),
        @StandardID VARCHAR(50),
		@VoucherShiftNo VARCHAR(50),
        @BatchNo VARCHAR(50)

SELECT TOP 1 @ColumnName_Standard_1 = DataCol, @ColName_Standard_1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'StandardID'

--unpivot để kiểm tra nếu tiêu chuẩn ko được khai báo cho NVL thì ko được nhập giá trị thông số
select u.MaterialID, QCT1000.StandardID, u.Value
INTO #Data1
from (
		SELECT MaterialID, BeginQuantity, DebitQuantity, CreditQuantity, RevokeQuantity, ReturnQuantity, EndQuantity 
		FROM #Data
) s
unpivot
(
  Value
  for CodeMaster in (BeginQuantity, DebitQuantity, CreditQuantity, RevokeQuantity, ReturnQuantity, EndQuantity)
) u
left join QCT1000 WITH(NOLOCK) ON QCT1000.CalculateType = u.CodeMaster
where ISNULL(Value,'') != '' 

--Kiểm tra không tồn tại phiếu đầu ca, mặt hàng, số batch --AFML000554
SET @Cur_01 = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT VoucherShiftNo,BatchNo FROM #Data

OPEN @Cur_01
FETCH NEXT FROM @Cur_01 INTO @VoucherShiftNo, @BatchNo

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherShiftNo'
	IF NOT EXISTS (SELECT TOP 1 Q20.VoucherNo FROM QCT2000 Q20 WITH(NOLOCK) 
					WHERE Q20.DivisionID = @DivisionID AND Q20.VoucherNo = @VoucherShiftNo AND Q20.DeleteFlg = 0)
	BEGIN
		---Phiếu đầu ca {0} không tồn tại
		UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @Col_Key + LTRIM(RTRIM(STR([Row]))) +'-AFML000554,',
                ErrorColumn = ErrorColumn + @Col_Name + ','
		WHERE VoucherShiftNo = @VoucherShiftNo
	END
	ELSE
	BEGIN
		SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'BatchNo'
		IF NOT EXISTS (SELECT TOP 1 Q20.VoucherNo, Q21.BatchNo FROM QCT2001 Q21 WITH(NOLOCK) 
						LEFT JOIN QCT2000 Q20 WITH(NOLOCK) ON Q20.DivisionID = Q21.DivisionID AND Q20.APK = Q21.APKMaster
						WHERE Q20.DivisionID = @DivisionID AND Q20.VoucherNo = @VoucherShiftNo AND Q21.BatchNo = @BatchNo AND Q20.DeleteFlg = 0 AND Q21.DeleteFlg = 0)
		BEGIN
			---Số batch {0} không tồn tại
			UPDATE #Data 
		    SET ErrorMessage = ErrorMessage + @Col_Key + LTRIM(RTRIM(STR([Row]))) +'-AFML000554,',
		            ErrorColumn = ErrorColumn + @Col_Name + ','
			WHERE VoucherShiftNo = @VoucherShiftNo AND BatchNo = @BatchNo
		END
	END

    FETCH NEXT FROM @Cur_01 INTO  @VoucherShiftNo, @BatchNo
END

CLOSE @Cur_01

--Kiểm tra tồn tại mã NVl, số batch
SET @Cur_01 = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT MaterialID,BatchMaterialNo FROM #Data

OPEN @Cur_01
FETCH NEXT FROM @Cur_01 INTO @MaterialID, @BatchMaterialNo

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'BatchMaterialNo'
	IF NOT EXISTS (SELECT TOP 1 Q21.InventoryID, Q21.BatchNo FROM QCT2001 Q21 WITH(NOLOCK) 
					WHERE Q21.DivisionID = @DivisionID AND Q21.InventoryID = @MaterialID AND Q21.BatchNo = @BatchMaterialNo AND Q21.DeleteFlg = 0)
	BEGIN
		---NVL Số Batch {0} không tồn tại
		UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @Col_Key + LTRIM(RTRIM(STR([Row]))) + ' ' + @MaterialID +'-AFML000554,',
                ErrorColumn = ErrorColumn + @Col_Name + ','
		WHERE MaterialID = @MaterialID AND BatchMaterialNo = @BatchMaterialNo
	END

    FETCH NEXT FROM @Cur_01 INTO @MaterialID, @BatchMaterialNo
END

CLOSE @Cur_01

--Kiểm tra phiếu NVL này không cùng 1 mặt hàng
DECLARE @CountInv INT = 0
SELECT @CountInv = Count(*) FROM (
SELECT Q21.InventoryID, COUNT(Q21.InventoryID) CountInv FROM QCT2001 Q21 WITH(NOLOCK)
LEFT JOIN QCT2000 Q20 WITH(NOLOCK) ON Q20.DivisionID = Q21.DivisionID AND Q20.APK = Q21.APKMaster
INNER JOIN #Data R01 WITH(NOLOCK) ON R01.VoucherShiftNo = Q20.VoucherNo AND R01.BatchNo = Q21.BatchNo
GROUP BY Q21.InventoryID) A
IF @CountInv > 1
BEGIN
	SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherShiftNo'
	UPDATE #Data 
    SET ErrorMessage = ErrorMessage + @Col_Key + '-QCFML000021,',
		ErrorColumn = ErrorColumn + @Col_Name + ','
END

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
            ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''

        GOTO LB_RESULT
END

--Kiểm tra phiếu nhập đầu ca, mặt hàng, số batch đã kế thừa
SET @Cur_02 = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT VoucherShiftNo,BatchNo FROM #Data

OPEN @Cur_02
FETCH NEXT FROM @Cur_02 INTO @VoucherShiftNo, @BatchNo

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'BatchNo'

	IF EXISTS (SELECT DISTINCT TOP 1 Q20.VoucherNo, Q21.BatchNo FROM QCT2010 Q10 WITH(NOLOCK)
	LEFT JOIN QCT2011 Q11 WITH(NOLOCK) ON Q11.DivisionID = Q10.DivisionID AND Q11.APKMaster = Q10.APK
	LEFT JOIN QCT2001 Q21 WITH(NOLOCK) ON Q21.DivisionID = Q11.DivisionID AND Q21.APK = Q11.RefAPKDetail AND Q21.APKMaster = Q11.RefAPKMaster
	LEFT JOIN QCT2000 Q20 WITH(NOLOCK) ON Q20.DivisionID = Q21.DivisionID AND Q20.APK = Q21.APKMaster
	WHERE Q10.DivisionID = @DivisionID AND Q10.VoucherType = 2 AND Q20.VoucherNo IS NOT NULL AND Q20.VoucherNo = @VoucherShiftNo AND Q21.BatchNo = @BatchNo 
	AND Q10.DeleteFlg = 0 AND Q20.DeleteFlg = 0 AND Q21.DeleteFlg = 0)
	BEGIN
		---Phiếu nhập đầu ca, mặt hàng, số batch đã kế thừa
		UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @Col_Key + LTRIM(RTRIM(STR([Row]))) + ' ' + @BatchNo + '-QCFML000022,',
			ErrorColumn = ErrorColumn + @Col_Name + ','
		WHERE VoucherShiftNo = @VoucherShiftNo AND BatchNo = @BatchNo
	END

    FETCH NEXT FROM @Cur_02 INTO  @VoucherShiftNo, @BatchNo
END

CLOSE @Cur_02

--Kiểm tra mã NVL, số batch đã tạo ở phiếu NVL khác --00ML000157
--SET @Cur_03 = CURSOR SCROLL KEYSET FOR
--SELECT DISTINCT MaterialID,BatchMaterialNo FROM #Data

--OPEN @Cur_03
--FETCH NEXT FROM @Cur_03 INTO @MaterialID, @BatchMaterialNo

--WHILE @@FETCH_STATUS = 0
--BEGIN

--	SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'BatchMaterialNo'

--	IF EXISTS (SELECT DISTINCT Q11.MaterialID, Q11.BatchID FROM QCT2010 Q10 WITH(NOLOCK)
--	LEFT JOIN QCT2011 Q11 WITH(NOLOCK) ON Q11.DivisionID = Q10.DivisionID AND Q11.APKMaster = Q10.APK
--	WHERE Q10.DivisionID = @DivisionID AND Q10.VoucherType = 2 AND Q11.MaterialID = @MaterialID AND Q11.BatchID = @BatchMaterialNo AND Q10.DeleteFlg = 0 AND Q11.DeleteFlg = 0)
--	BEGIN
--		---mã NVL, số batch đã tạo ở phiếu NVL khác
--		UPDATE #Data 
--        SET ErrorMessage = ErrorMessage + @Col_Key + LTRIM(RTRIM(STR([Row]))) + ' ' + @MaterialID + '.' + @BatchMaterialNo +'-00ML000157,',
--			ErrorColumn = ErrorColumn + @Col_Name + ','
--		WHERE MaterialID = @MaterialID AND BatchMaterialNo = @BatchMaterialNo
--	END

--    FETCH NEXT FROM @Cur_03 INTO @MaterialID, @BatchMaterialNo
--END

--CLOSE @Cur_03

--Kiểm tra Phiếu nhập đầu ca ko thể ở 2 phiếu NVL

SET @Cur_03 = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT VoucherShiftNo FROM #Data

OPEN @Cur_03
FETCH NEXT FROM @Cur_03 INTO @VoucherShiftNo

WHILE @@FETCH_STATUS = 0
BEGIN

	DECLARE @CountVSN INT = 0
	SELECT @CountVSN = R01.CountVSN FROM (
	SELECT VoucherShiftNo, COUNT(VoucherShiftNo) CountVSN FROM(
	SELECT DISTINCT VoucherNo, VoucherShiftNo FROM #Data) R
	GROUP BY VoucherShiftNo) R01
	WHERE R01.VoucherShiftNo = @VoucherShiftNo
	
	IF @CountVSN > 1
	BEGIN
		SELECT TOP 1 @Col_Key = DataCol, @Col_Name = ColName FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherShiftNo'
		UPDATE #Data 
	    SET ErrorMessage = ErrorMessage + @Col_Key + '-QCFML000023,',
			ErrorColumn = ErrorColumn + @Col_Name + ','
		WHERE VoucherShiftNo = @VoucherShiftNo
	END

    FETCH NEXT FROM @Cur_03 INTO @VoucherShiftNo
END

CLOSE @Cur_03

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
            ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

-- Bảng out QCT2010
DECLARE @OutputVoucherNoAPK TABLE (APK NVARCHAR(250),VoucherNo NVARCHAR(250))
-- Bảng out QCT2011
DECLARE @OutputMaterialAPK TABLE (APK NVARCHAR(250),MaterialID NVARCHAR(250),BatchNo NVARCHAR(250))
-- Insert dữ liệu vào bảng Master (QCT2010)

CREATE TABLE #VoucherShift
(
    
    APK NVARCHAR(50) DEFAULT (''),
    VoucherNo NVARCHAR(50) DEFAULT (''),
    APKDetail NVARCHAR(50) DEFAULT (''),
    InventoryID NVARCHAR(50) DEFAULT (''),
    BatchNo NVARCHAR(50) DEFAULT ('')
   
)

INSERT INTO #VoucherShift (APK, VoucherNo, APKDetail, InventoryID, BatchNo)
 select QCT2000.APK, QCT2000.VoucherNo, QCT2001.APK as APKDetail, QCT2001.InventoryID, QCT2001.BatchNo from QCT2000 QCT2000 
inner join QCT2001 QCT2001 on QCT2000.APK =  QCT2001.APKMaster
inner join (select DISTINCT DivisionID,VoucherShiftNo,BatchNo from  #Data) DataVoucherShift on DataVoucherShift.VoucherShiftNo =  QCT2000.VoucherNo and DataVoucherShift.BatchNo = QCT2001.BatchNo
where DataVoucherShift.DivisionID = QCT2000.DivisionID and QCT2000.DeleteFlg =0 and QCT2001.DeleteFlg=0 

--select * from #VoucherShift

INSERT INTO QCT2010(APK, DivisionID, VoucherTypeID, VoucherNo, VoucherDate, TranMonth, TranYear, VoucherType, Notes, APKMaster, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
OUTPUT INSERTED.APK,INSERTED.VoucherNo INTO @OutputVoucherNoAPK(APK, VoucherNo)
select NEWID() as APK, DataVoucher.*
from 
(
    SELECT DISTINCT DivisionID, VoucherTypeID, VoucherNo,  NULLIF(VoucherDate, '') as VoucherDate, MONTH(GETDATE()) as TranMonth, YEAR(GETDATE()) as TranYear, '2' as VoucherType,Notes, null as APKMaster, @UserID as CreateUserID, GETDATE() as CreateDate, @UserID as LastModifyUserID, GETDATE() as LastModifyDate
    FROM #Data
) as DataVoucher

-- Insert dữ liệu vào bảng Detail (QCT2011)
IF @@ROWCOUNT >0
Begin

	INSERT INTO QCT2011( APK,  DivisionID, APKMaster, MaterialID, BatchID, UnitID,RefAPKMaster,RefAPKDetail,Description,DeleteFlg,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Orders)
	OUTPUT INSERTED.APK,INSERTED.MaterialID,INSERTED.BatchID INTO @OutputMaterialAPK(APK,MaterialID, BatchNo)
	SELECT NEWID() as APK , DataQCT2011.* From
    (select DISTINCT DataIN.DivisionID,DataOut.APK as APKMaster, DataIN.MaterialID, BatchMaterialNo as BatchID, AT1302.UnitID as UnitID,VoucherShift.APK as RefAPKMaster,VoucherShift.APKDetail as RefAPKDetail,NotesMaterial as Description,0 as DeleteFlg, @UserID as CreateUserID, GETDATE() as CreateDate, @UserID as LastModifyUserID, GETDATE() as LastModifyDate, DataIN.Row
    FROM #Data DataIN
    join @OutputVoucherNoAPK DataOut on DataOut.VoucherNo = DataIN.VoucherNo
    join #VoucherShift VoucherShift on VoucherShift.VoucherNo = DataIN.VoucherShiftNo 
	left join AT1302 WITH(NOLOCK) ON AT1302.InventoryID = DataIN.MaterialID
    where DataIN.MaterialID !='' and  DataIN.MaterialID is not null and  DataIN.BatchMaterialNo !='' and  DataIN.BatchMaterialNo is not null) DataQCT2011
    
    -- Insert dữ liệu vào bảng Detail (QCT2002)
    --SELECT * from @OutputMaterialAPK
    IF @@ROWCOUNT >0
    Begin
    INSERT INTO QCT2002( APK,  DivisionID, APKMaster, StandardID, StandardValue, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
    SELECT NEWID() as APK , DataQCT2002.* From
    (
	SELECT u.DivisionID, u.APKMaster, QCT1000.StandardID, u.Value, u.DeleteFlg, u.CreateUserID, u.CreateDate,
		   u.LastModifyUserID, u.LastModifyDate
	FROM (select DISTINCT DivisionID, OutputMaterialAPK.APK as APKMaster,
			BeginQuantity, DebitQuantity, CreditQuantity,
			RevokeQuantity, ReturnQuantity, EndQuantity, 
			'0' as DeleteFlg, @UserID as CreateUserID, GETDATE() as CreateDate, 
			@UserID as LastModifyUserID, GETDATE() as LastModifyDate
			FROM #Data DataIN
			join @OutputMaterialAPK OutputMaterialAPK on OutputMaterialAPK.MaterialID = DataIN.MaterialID and OutputMaterialAPK.BatchNo = DataIN.BatchMaterialNo) s
		 unpivot
		 (
		   Value
		   for CodeMaster in (BeginQuantity, DebitQuantity, CreditQuantity, RevokeQuantity, ReturnQuantity, EndQuantity)
		 ) u
	LEFT JOIN QCT1000 WITH(NOLOCK) ON QCT1000.CalculateType = u.CodeMaster
	) DataQCT2002
    End
End

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]
