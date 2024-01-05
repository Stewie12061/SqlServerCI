IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2055]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)         
DROP PROCEDURE [DBO].[QCP2055]
GO
/****** Object:  StoredProcedure [dbo].[QCT2055]    Script Date: 12/4/2020 7:55:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- <Summary>
---- Import Excel nghệp vụ NVL
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by nhttai 2/12/2020
---- Modified by on
-- <Example>

CREATE PROCEDURE [dbo].[QCP2055]
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
			  ELSE X.Data.query('VoucherDate').value('.', 'DATETIME') END) AS VoucherDate,--VoucherDate
        X.Data.query('Notes').value('.','NVARCHAR(MAX)') AS Notes,
        X.Data.query('DeleteVoucher').value('.','INT') AS DeleteVoucher,
        X.Data.query('VoucherShiftNo').value('.','NVARCHAR(250)') AS VoucherShiftNo,
        X.Data.query('BatchNo').value('.','NVARCHAR(250)') AS BatchNo,
        X.Data.query('MaterialID').value('.','NVARCHAR(250)') AS MaterialID,
        X.Data.query('BatchMaterialNo').value('.','NVARCHAR(250)') AS BatchMaterialNo,
        X.Data.query('NotesMaterial').value('.','NVARCHAR(250)') AS NotesMaterial,
        X.Data.query('DeleteMaterial').value('.','INT') AS DeleteMaterial,        
        X.Data.query('StandardID').value('.','NVARCHAR(50)') AS StandardID,
        X.Data.query('Value').value('.','NVARCHAR(50)') AS Value
INTO #QCP2055
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

 INSERT INTO #Data ([Row],  DivisionID, VoucherTypeID, VoucherNo, VoucherDate, Notes, DeleteVoucher, VoucherShiftNo, BatchNo, MaterialID, BatchMaterialNo,NotesMaterial,DeleteMaterial,StandardID,Value)
 SELECT [Row], DivisionID, VoucherTypeID, VoucherNo, VoucherDate, Notes, DeleteVoucher, VoucherShiftNo, BatchNo, MaterialID, BatchMaterialNo,NotesMaterial,DeleteMaterial,StandardID,Value
 FROM #QCP2055
--SELECT * from #Data

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-QC', @ColID = 'VoucherNo', 
@Param1 = 'VoucherNo, VoucherTypeID, DivisionID, VoucherDate, Notes, DeleteVoucher'

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @VoucherNo VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT VoucherNo FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @VoucherNo

WHILE @@FETCH_STATUS = 0
BEGIN

    ---- Kiểm tra trùng mã chứng từ
    IF EXISTS (SELECT TOP  1 1 FROM QCT2010 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo)
    BEGIN
        UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-QCFML000008,',
                ErrorColumn = ErrorColumn + @ColName1 + ','
    END

    FETCH NEXT FROM @Cur INTO @VoucherNo
END

CLOSE @Cur

------ BEGIN - Xử lý tăng số chứng từ tự động

--SELECT DISTINCT VoucherNo, VoucherNo AS NewVoucherNo
--INTO #VoucherData
--FROM #QCP2055
--ORDER BY VoucherNo

------ Xử lý GROUP BY các dữ liệu detail có cùng cặp số RingiNo và Số hóa đơn
--SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS [Row], DivisionID, VoucherNo, NULL AS Orders, 
--CONVERT(VARCHAR(50), NULL) AS APK, NULL AS ErrorMessage, NULL AS ErrorColumn
--INTO #DataGroupBy
--FROM #Data
--GROUP BY DivisionID, VoucherNo

--WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
--BEGIN
--    SELECT @VoucherNo = VoucherNo FROM #VoucherData
--	-- Tạo APKMaster_9000 mới cho phiếu DNTT
--	SET @APKMaster_9000 = NEWID()
	
--	EXEC GetVoucherNo @DivisionID, 'QC', 'BEMT0000', 'ProposalVoucher', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
--	-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
--	UPDATE #DataGroupBy SET ID = @NewVoucherNo, APKMaster_9000 = @APKMaster_9000 WHERE ID = @VoucherNo
--	-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
--	UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

--    DELETE #VoucherData WHERE VoucherNo = @VoucherNo
--END
------ END - Xử lý tăng số chứng từ tự động


DECLARE @ColumnName_Standard_1 VARCHAR(50),
        @ColName_Standard_1 NVARCHAR(50),
        @Cur_Standard CURSOR,
        @MaterialID VARCHAR(50),
        @StandardID VARCHAR(50)

SELECT TOP 1 @ColumnName_Standard_1 = DataCol, @ColName_Standard_1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'StandardID'

SET @Cur_Standard = CURSOR SCROLL KEYSET FOR
SELECT MaterialID,StandardID FROM #Data

OPEN @Cur_Standard
FETCH NEXT FROM @Cur_Standard INTO @MaterialID, @StandardID

WHILE @@FETCH_STATUS = 0
BEGIN

    ---- Kiểm tra tiêu chuẩn có được khai báo trong nguyên vật liệu
    IF NOT EXISTS (select QCT1000.APK, QCT1000.StandardID, QCT1000.StandardName, QCT1000.IsDefault
        from QCT1000 QCT1000 
        INNER JOIN QCT1020 QCT1020 ON QCT1020.InventoryID =@MaterialID 
        INNER JOIN dbo.QCT1021 QCT1021 ON QCT1020.APK =QCT1021.APKMaster AND QCT1000.StandardID = QCT1021.StandardID
        where  QCT1000.TypeID = N'BOM'  AND QCT1000.StandardID = @StandardID)
    BEGIN
        UPDATE #Data 
        SET ErrorMessage = ErrorMessage + @ColumnName_Standard_1 + LTRIM(RTRIM(STR([Row]))) +'-QCFML000009,',
                ErrorColumn = ErrorColumn + @ColName_Standard_1 + ','
    END

    FETCH NEXT FROM @Cur_Standard INTO  @MaterialID, @StandardID
END

CLOSE @Cur_Standard

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
    BatchNo NVARCHAR(50) DEFAULT (''),
    MaterialID NVARCHAR(50) DEFAULT ('')
   
)

INSERT INTO #VoucherShift (APK, VoucherNo, APKDetail, InventoryID, BatchNo,MaterialID)
 select QCT2000.APK, QCT2000.VoucherNo, QCT2001.APK as APKDetail, QCT2001.InventoryID, QCT2001.BatchNo ,DataVoucherShift.MaterialID from QCT2000 QCT2000 
inner join QCT2001 QCT2001 on QCT2000.APK =  QCT2001.APKMaster
inner join (select DISTINCT DivisionID,VoucherShiftNo,BatchNo, MaterialID from  #Data) DataVoucherShift on DataVoucherShift.VoucherShiftNo =  QCT2000.VoucherNo and DataVoucherShift.BatchNo = QCT2001.BatchNo
where DataVoucherShift.DivisionID = QCT2000.DivisionID and QCT2000.DeleteFlg =0 and QCT2001.DeleteFlg=0 

--select * from #VoucherShift



INSERT INTO QCT2010(APK, DivisionID, VoucherTypeID, VoucherNo, VoucherDate, TranMonth, TranYear, VoucherType, Notes, APKMaster, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
OUTPUT INSERTED.APK,INSERTED.VoucherNo INTO @OutputVoucherNoAPK(APK, VoucherNo)
select NEWID() as APK, DataVoucher.*
from 
(
    SELECT DISTINCT DivisionID, VoucherTypeID, VoucherNo,  NULLIF(VoucherDate, '') as VoucherDate, MONTH(GETDATE()) as TranMonth, YEAR(GETDATE()) as TranYear, '2' as VoucherType,Notes, null as APKMaster, DeleteVoucher as DeleteFlg, @UserID as CreateUserID, GETDATE() as CreateDate, @UserID as LastModifyUserID, GETDATE() as LastModifyDate
    FROM #Data
) as DataVoucher


--select * from @OutputVoucherNoAPK

-- Insert dữ liệu vào bảng Detail (QCT2011)
IF @@ROWCOUNT >0
Begin

INSERT INTO QCT2011( APK,  DivisionID, APKMaster, MaterialID, BatchID, UnitID,RefAPKMaster,RefAPKDetail,Description,DeleteFlg,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Orders)
OUTPUT INSERTED.APK,INSERTED.MaterialID,INSERTED.BatchID INTO @OutputMaterialAPK(APK,MaterialID, BatchNo)
SELECT NEWID() as APK , DataQCT2011.* From
    (select DISTINCT DivisionID,DataOut.APK as APKMaster, DataIN.MaterialID, BatchMaterialNo as BatchID, null as UnitID,VoucherShift.APK as RefAPKMaster,VoucherShift.APKDetail as RefAPKDetail,NotesMaterial as Description,DeleteMaterial as DeleteFlg, @UserID as CreateUserID, GETDATE() as CreateDate, @UserID as LastModifyUserID, GETDATE() as LastModifyDate, Row
    FROM #Data DataIN
    join @OutputVoucherNoAPK DataOut on DataOut.VoucherNo = DataIN.VoucherNo
    join #VoucherShift VoucherShift on VoucherShift.MaterialID = DataIN.MaterialID
    where DataIN.MaterialID !='' and  DataIN.MaterialID is not null and  DataIN.BatchMaterialNo !='' and  DataIN.BatchMaterialNo is not null) DataQCT2011
    
    -- Insert dữ liệu vào bảng Detail (QCT2002)
    --SELECT * from @OutputMaterialAPK
    IF @@ROWCOUNT >0
    Begin
    INSERT INTO QCT2002( APK,  DivisionID, APKMaster, StandardID, StandardValue, DeleteFlg,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
    SELECT NEWID() as APK , DataQCT2002.* From
    (select DISTINCT DivisionID, OutputMaterialAPK.APK as APKMaster, StandardID, Value, '0' as DeleteFlg, @UserID as CreateUserID, GETDATE() as CreateDate, @UserID as LastModifyUserID, GETDATE() as LastModifyDate
    FROM #Data DataIN
    join @OutputMaterialAPK OutputMaterialAPK on OutputMaterialAPK.MaterialID = DataIN.MaterialID and OutputMaterialAPK.BatchNo = DataIN.BatchMaterialNo
    where DataIN.StandardID !='' and  DataIN.StandardID is not null and  DataIN.Value !='' and  DataIN.Value is not null) DataQCT2002
    End
End



UPDATE AT4444 
SET LastKey = (SELECT SUBSTRING(MAX(MachineID), 4, 8) FROM CIT1150)
WHERE TableName = 'QCT2010' AND KEYSTRING = 'MCV'   

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

