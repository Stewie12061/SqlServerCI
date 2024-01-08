-- <Summary>
---- Template import data: phiếu nguyên vật liệu
-- <History>
---- Create on 8/12/2020 by Nguyễn Hoàng Tấn Tài: Thêm dữ liệu danh mục Mẫu nghiệp vụ NVL
---- Modified on 03/06/2021 by Lê Hoàng : Bỏ bắt buộc nhập Ghi chú nguyên vật liệu
---- Modified on ... by ...
---- <Example>
	
	----------------------- Danh mục Mẫu nghiệp vụ NVL ----------------------- 

DELETE FROM A00065 WHERE ImportTransTypeID = N'Material'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'', N'DivisionID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1007'', @Param2 = ''VoucherTypeID'', @SQLFilter = '' ISNULL(TL.Disabled, 0) = 0 ''', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'VoucherNo', N'Số chứng từ', N'VoucherNo', N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherDate', N'Ngày lập', N'VoucherDate', N'', 100, 50, 2, N'DATETIME', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Notes', N'Ghi chú', N'Notes', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DeleteVoucher', N'Xóa', N'DeleteVoucher', N'', 100, 50, 1, N'INT', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherShiftNo', N'Số phiếu nhập đầu ca*', N'VoucherShiftNo', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2000'', @Param2 = ''VoucherNo'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'BatchNo', N'Số bacth Hàng hóa', N'BatchNo', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2001'', @Param2 = ''BatchNo'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MaterialID', N'Mã NVL', N'MaterialID', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2001'', @Param2 = ''InventoryID'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'BatchMaterialNo', N'Số bacth NVL', N'BatchMaterialNo', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2001'', @Param2 = ''BatchNo'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'NotesMaterial', N'Ghi chú', N'NotesMaterial', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DeleteMaterial', N'Xóa', N'DeleteMaterial', N'', 100, 50, 1, N'INT', N'', 0, N'K')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'StandardID', N'Tiêu chuẩn', N'StandardID', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT1000'', @Param2 = ''StandardID'', @SQLFilter = ''''', 1, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Material', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Value', N'Giá trị tiêu chuẩn', N'Value', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'M')

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Material')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Material', N'Mẫu nghiệp vụ NVL', 'Material', 'Data', N'A', 10, N'C:\IMPORTS', N'QCT2050.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'MaterialVNP'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'', N'DivisionID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1007'', @Param2 = ''VoucherTypeID'', @SQLFilter = '' ISNULL(TL.Disabled, 0) = 0 ''', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'VoucherNo', N'Số chứng từ', N'VoucherNo', N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherDate', N'Ngày lập', N'VoucherDate', N'', 100, 50, 2, N'DATETIME', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Notes', N'Ghi chú', N'Notes', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DeleteVoucher', N'Xóa', N'DeleteVoucher', N'', 100, 50, 1, N'INT', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherShiftNo', N'Số phiếu nhập đầu ca*', N'VoucherShiftNo', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2000'', @Param2 = ''VoucherNo'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'BatchNo', N'Số bacth Hàng hóa', N'BatchNo', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2001'', @Param2 = ''BatchNo'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MaterialID', N'Mã NVL', N'MaterialID', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2001'', @Param2 = ''InventoryID'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'BatchMaterialNo', N'Số bacth NVL', N'BatchMaterialNo', N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT2001'', @Param2 = ''BatchNo'', @SQLFilter = '' ISNULL(TL.DeleteFlg, 0) = 0''', 1, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'NotesMaterial', N'Ghi chú', N'NotesMaterial', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'BeginQuantity', N'Ghi nhận khối lượng tồn', N'BeginQuantity', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'DebitQuantity', N'Ghi nhận khối lượng nhập', N'DebitQuantity', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'CreditQuantity', N'Ghi nhận khối lượng tiêu hao', N'CreditQuantity', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'RevokeQuantity', N'Ghi nhận khối lượng xé bỏ', N'RevokeQuantity', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'ReturnQuantity', N'Ghi nhận khối lượng trả', N'ReturnQuantity', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialVNP', N'Mẫu nghiệp vụ NVL', N'Material', N'QCF2050', N'QCT2050_VNP.xlsx', N'EXEC QCP2055_VNP @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'EndQuantity', N'Ghi nhận khối lượng tồn cuối', N'EndQuantity', N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'P')

DELETE FROM A01065 WHERE ImportTemplateID = N'MaterialVNP'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'MaterialVNP')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('MaterialVNP', N'Mẫu nghiệp vụ NVL', 'MaterialVNP', 'Data', N'A', 10, N'C:\IMPORTS', N'QCT2050_VNP.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END