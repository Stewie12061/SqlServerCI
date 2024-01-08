-- <Summary>
---- Template import data: danh mục định nghĩa tiêu chuẩn
-- <History>
---- Create on 01/12/2020 by Cao Thanh Thi: Thêm dữ liệu danh mục tiêu chuẩn
---- Create on 03/12/2020 by Cao Thanh Thi: Thêm dữ liệu danh mục định nghĩa tiêu chuẩn
---- Modified on ... by ...
---- <Example>
	
	----------------------- Danh mục ... ----------------------- 

------ Danh mục Tiêu chuẩn ------
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Standard')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Standard', N'Tiêu chuẩn', 'Standard', 'Data', N'A', 10, N'C:\IMPORTS', N'QCT1000.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'Standard'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'StandardID', N'Mã Tiêu chuẩn', N'StandardID', N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'StandardName', N'Tên Tiêu chuẩn', N'StandardName', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'StandardNameE', N'Tên tiêu chuẩn (English)', N'StandardNameE', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, 
OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'UnitID', N'Đơn vị tính', N'UnitID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1304'', @Param2 = ''UnitID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'Description', N'Diễn giải', N'Description', N'', 100, 50, 0, N'NVARCHAR(max)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'TypeID', N'Loại tiêu chuẩn', N'TypeID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Standard'''' ''', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'ParentID', N'Tiêu chuẩn cha', N'ParentID', N'', 100, 50, 0, N'VARCHAR(MAX)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DataType', N'Loại dữ liệu', N'DataType', N'', 100, 50, 1, N'int', N'{CheckValueInTableList} @Param1 = ''QCT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''DataType'''' ''', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'Disabled', N'Không hiển thị', N'Disabled', N'', 100, 50, 1, N'int', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'IsCommon', N'Dùng chung', N'IsCommon', N'', 100, 50, 1, N'int', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'IsDefault', N'Mặc định trường', N'IsDefault', N'', 100, 50, 1, N'int', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Standard', N'Tiêu chuẩn', N'Standard', N'QCF1000', N'QCT1000.xlsx', N'EXEC QCP1005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'IsVisible', N'Mặc định giá trị', N'IsVisible', N'', 100, 50, 1, N'int', N'', 0, N'L')

------ Danh mục định nghĩa tiêu chuẩn ------
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ListSpec')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('ListSpec', N'Định nghĩa tiêu chuẩn', 'ListSpec', 'Data', N'A', 10, N'C:\IMPORTS', N'QCT1020.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'ListSpec'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'InventoryID', N'Mã mặt hàng', N'InventoryID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1302'', @Param2 = ''InventoryID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Notes', N'Ghi chú', N'Notes', N'', 100, 50, 0, N'NVARCHAR(MAX)', N'', 0, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'Notes01', N'Ghu chú 01', N'Notes01', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Notes02', N'Ghi chú 02', N'Notes02', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'Notes03', N'Ghi chú 03', N'Notes03', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'Disabled', N'Không hiển thị', N'Disabled', N'', 100, 50, 1, N'int', N'', 0, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'IsCommon', N'Dùng chung', N'IsCommon', N'', 100, 50, 1, N'int', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'StandardID', N'Mã tiêu chuẩn', N'StandardID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT1000'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'SRange01', N'Ngưỡng dưới', N'LSL', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'SRange02', N'Nhỏ nhất', N'Min', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'SRange03', N'Mục tiêu', N'Target', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'SRange04', N'Lớn nhất', N'Max', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'SRange05', N'Ngưỡng trên', N'USL', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ListSpec', N'Định nghĩa tiêu chuẩn', N'ListSpec', N'QCF1020', N'QCT1020.xlsx', N'EXEC QCP1025 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'DisabledStandard', N'Không hiển thị', N'DisabledStandard', N'', 100, 50, 1, N'int', N'', 0, N'N')


