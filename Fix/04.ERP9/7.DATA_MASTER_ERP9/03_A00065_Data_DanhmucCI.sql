-- <Summary>
---- Template import data: danh mục module CI
-- <History>
---- Create on 26/08/2020 by Trọng Kiên: Thêm dữ liệu danh mục Mẫu danh mục máy
---- Modified on 17/02/2023 by Hoài Bảo: Bổ sung import cột nhà phân phối Danh mục đối tượng
---- Modified on 10/03/2023 by Viết Toàn: Bổ sung import các cột của của bảng giá bán
---- Modified on 20/03/2023 by Viết Toàn: Bổ sung import các cột của của bảng giá bán (HIPC)
---- Modified on 17/08/2023	by Viết Toàn: Bổ sung dữ liệu import nguồn lực
---- <Example>

DECLARE @CustomerName INT = (SELECT CustomerName FROM CustomerIndex)
	
	----------------------- Danh mục Mẫu danh mục máy ----------------------- 

DELETE FROM A00065 WHERE ImportTransTypeID = N'Machine'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'MachineID', N'Mã máy', N'MachineID', N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MachineName', N'Tên máy', N'MachineName', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MachineNameE', N'Tên máy(Eng)', N'MachineNameE', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'DepartmentID', N'Phân xưởng', N'DepartmentID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1102'', @Param2 = ''DepartmentID'', @SQLFilter = '' ISNULL(TL.Disabled, 0) = 0''', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Model', N'Mẫu', N'Model', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Year', N'Năm', N'Year', N'', 100, 50, 1, N'INT', N'', 0, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'StartDate', N'Ngày hình thành', N'StartDate', N'', 100, 50, 1, N'DATETIME', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Notes', N'Ghi chú', N'Notes', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Disabled', N'Không hiển thị', N'Disabled', N'', 100, 50, 1, N'INT', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'StandardID', N'Mã thông số', N'StandardID', N'', 100, 50, 1, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''QCT1000'', @Param2 = ''StandardID'', @SQLFilter = ''ISNULL(TL.Disabled,0) =  0 AND TL.TypeID = ''''TECH'''' ''', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'NotesStandard', N'Ghi chú thông số', N'NotesStandard', N'', 100, 50, 1, N'NVARCHAR(MAX)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Machine', N'Mẫu danh mục máy', N'Machine', N'CIF1370', N'CIT1150.xlsx', N'EXEC CIP1155 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DisabledStandard', N'Không hiển thị thông số', N'DisabledStandard', N'', 100, 50, 1, N'INT', N'', 0, N'L')

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Machine')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Machine', N'Mẫu danh mục máy', 'Machine', 'Data', N'A', 10, N'C:\IMPORTS', N'CIT1150.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'Inventory'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Inventory', N'Danh mục mặt hàng', N'Inventory', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'D3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'Barcode', N'Mã vạch', N'Barcode', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'InventoryID', N'Mã hàng *', N'InventoryID', N'', 80, 50, 0, N'nvarchar(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'InventoryName', N'Tên hàng *', N'InventoryName', N'', 80, 250, 0, N'nvarchar(250)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'InventoryTypeID', N'Loại mặt hàng *', N'InventoryTypeID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1301'', @Param2 = ''InventoryTypeID''', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'UnitID', N'Đơn vị tính *', N'UnitID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1304'', @Param2 = ''UnitID''', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'AccountID', N'Tài khoản tồn kho mặc định *', N'AccountID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1005'', @Param2 = ''AccountID'', @SQLFilter = '' IsNotShow = 0 AND Disabled = 0 ''', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'SalesAccountID', N'Tài khoản doanh thu mặc định', N'SalesAccountID', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'PrimeCostAccountID', N'Tài khoản giá vốn', N'PrimeCostAccountID', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'PurchaseAccountID', N'Tài khoản mua hàng', N'PurchaseAccountID', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'RefInventoryID', N'Mã tham chiếu', N'RefInventoryID', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'VATGroupID', N'Nhóm thuế', N'VATGroupID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1010'', @Param2 = ''VATGroupID''', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'VATPercent', N'Tỷ lệ (%)', N'VATPercent', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'VATImGroupID', N'Nhóm thuế nhập khẩu', N'VATImGroupID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1010'', @Param2 = ''VATGroupID''', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'VATImPercent', N'Tỷ lệ (%)', N'VATImPercent', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'MethodID', N'Phương pháp tính giá xuất kho', N'MethodID', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'IsStocked', N'Quản lý tồn kho', N'IsStocked', N'', 80, 50, 1, N'INT', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'IsDiscount', N'Chiết khấu', N'IsDiscount', N'', 80, 50, 1, N'INT', N'', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'IsSource', N'Quản lý mặt hàng theo lô', N'IsSource', N'', 80, 50, 1, N'INT', N'', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'IsLimitDate', N'Quản lý mặt hàng theo ngày hết hạn', N'IsLimitDate', N'', 80, 50, 1, N'INT', N'', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'Specification', N'Đặc tính kỹ thuật', N'Specification', N'', 80, 50, 0, N'nvarchar(250)', N'', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'SalePrice01', N'Giá bán 01', N'SalePrice01', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'U')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'SalePrice02', N'Giá bán 02', N'SalePrice02', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'V')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'SalePrice03', N'Giá bán 03', N'SalePrice03', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'SalePrice04', N'Giá bán 04', N'SalePrice04', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'X')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'SalePrice05', N'Giá bán 05', N'SalePrice05', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Y')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'RecievedPrice', N'Giá nhập mặc định', N'RecievedPrice', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Z')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, N'DeliveryPrice', N'Giá xuất mặc định', N'DeliveryPrice', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AA')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 29, N'S1', N'Phân loại 1', N'S1', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AB')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 30, N'S2', N'Phân loại 2', N'S2', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AC')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 31, N'S3', N'Phân loại 3', N'S3', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AD')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 32, N'PurchasePrice01', N'Giá mua 01', N'PurchasePrice01', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AE')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 33, N'PurchasePrice02', N'Giá mua 02', N'PurchasePrice02', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AF')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 34, N'PurchasePrice03', N'Giá mua 03', N'PurchasePrice03', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AG')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 35, N'PurchasePrice04', N'Giá mua 04', N'PurchasePrice04', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AH')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 36, N'PurchasePrice05', N'Giá mua 05', N'PurchasePrice05', N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AI')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 37, N'I01ID', N'Mã phân tích 01', N'I01ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I01'''' ''', 0, N'AJ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 38, N'I02ID', N'Mã phân tích 02', N'I02ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I02'''' ''', 0, N'AK')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 39, N'I03ID', N'Mã phân tích 03', N'I03ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I03'''' ''', 0, N'AL')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 40, N'I04ID', N'Mã phân tích 04', N'I04ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I04'''' ''', 0, N'AM')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 41, N'I05ID', N'Mã phân tích 05', N'I05ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I05'''' ''', 0, N'AN')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 42, N'I06ID', N'Mã phân tích 06', N'I06ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I06'''' ''', 0, N'AO')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 43, N'I07ID', N'Mã phân tích 07', N'I07ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I07'''' ''', 0, N'AP')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 44, N'I08ID', N'Mã phân tích 08', N'I08ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I08'''' ''', 0, N'AQ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 45, N'I09ID', N'Mã phân tích 09', N'I09ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I09'''' ''', 0, N'AR')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 46, N'I10ID', N'Mã phân tích 10', N'I10ID', N'', 80, 50, 0, N'nvarchar(50)', N'{CheckValueInTableList} @Param1 = ''AT1015'', @Param2 = ''AnaID'', @SQLFilter = ''TL.AnaTypeID = ''''I10'''' ''', 0, N'AS')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 47, N'Varchar01', N'Tham số 01', N'Varchar01', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AT')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 48, N'Varchar02', N'Tham số 02', N'Varchar02', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AU')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 49, N'Varchar03', N'Tham số 03', N'Varchar03', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AV')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 50, N'Varchar04', N'Tham số 04', N'Varchar04', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AW')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 51, N'Varchar05', N'Tham số 05', N'Varchar05', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AX')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 52, N'Varchar06', N'Tham số 06', N'Varchar06', N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AY')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 53, N'Notes01', N'Ghi chú 1', N'Notes01', N'', 80, 50, 0, N'nvarchar(250)', N'', 0, N'AZ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 54, N'Notes02', N'Ghi chú 2', N'Notes02', N'', 80, 50, 0, N'nvarchar(250)', N'', 0, N'BA')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 55, N'Notes03', N'Ghi chú 3', N'Notes03', N'', 80, 50, 0, N'nvarchar(250)', N'', 0, N'BB')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 56, N'Notes04', N'Ghi chú 4', N'Notes04', N'', 80, 50, 0, N'nvarchar(250)', N'', 0, N'BC')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 57, N'Notes05', N'Ghi chú 5', N'Notes05', N'', 80, 50, 0, N'nvarchar(250)', N'', 0, N'BD')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 58, N'Disabled', N'Không hiển thị *', N'Disabled', N'', 80, 50, 1, N'INT', N'', 0, N'BE')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 59, N'IsCommon', N'Dùng chung *', N'IsCommon', N'', 80, 50, 1, N'INT', N'', 0, N'BF')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 60, N'G05AccountID', N'Danh sách tài khoản tồn kho', N'G05AccountID', N'', 80, 50, 0, N'varchar(MAX)', N'', 0, N'BG')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 61, N'G07AccountID', N'Danh sách tài khoản doanh thu', N'G07AccountID', N'', 80, 50, 0, N'varchar(MAX)', N'', 0, N'BH')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 62, N'ProductTypeID', N'Phân loại sản xuất ', N'ProductTypeID', N'', 80, 50, 1, N'INT', N'', 0, N'BI')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)VALUES (N'Inventory', N'Danh mục mặt hàng', N'List of inventory ', N'CIF1170', N'AT1302_VNP.xlsx', N'EXEC CIP11706 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 63, N'IsVIP', N'Phế phẩm', N'IsVIP', N'', 80, 50, 1, N'INT', N'', 0, N'BJ')

DELETE A01065 WHERE ImportTemplateID = 'Inventory'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Inventory')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Inventory', N'Mẫu danh mục mặt hàng', 'Inventory', 'Data', N'A', 8, N'C:\IMPORTS', N'AT1302_VNP.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

----------------------------------------------------------- Danh mục Đối tượng -----------------------------------------------------------
DELETE FROM A01065 WHERE ImportTemplateID = 'Object'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Object')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Object', N'Mẫu danh mục đối tượng', 'Object', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhMucDoiTuong.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'Object'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 2, N'ObjectID', N'Mã đối tượng', N'ObjectID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckDuplicateData} @Param2 = ''AT1202'', @Param3=''ObjectID''', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 3, N'ObjectName', N'Tên đối tượng', N'ObjectName', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 4, N'S1', N'Phân loại 1', N'S1', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 5, N'S2', N'Phân loại 2', N'S2', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 6, N'S3', N'Phân loại 3', N'S3', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 7, N'ObjectTypeID', N'Mã loại đối tượng', N'ObjectTypeID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 8, N'Address', N'Địa chỉ', N'Address', 
	N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 9, N'Tel', N'Điện thoại', N'Tel', 
	N'', 100, 100, 0, N'NVARCHAR(100)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 10, N'VATNo', N'Mã số thuế', N'VATNo', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 11, N'Email', N'Email', N'Email', 
	N'', 100, 4000, 0, N'NVARCHAR(MAX)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 12, N'Fax', N'Fax', N'Fax', 
	N'', 100, 100, 0, N'NVARCHAR(100)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 13, N'Website', N'Website', N'Website', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 14, N'Contactor', N'Người liên hệ', N'Contactor', 
	N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 15, N'Phonenumber', N'Điện thoại liên hệ', N'Phonenumber', 
	N'', 100, 100, 0, N'NVARCHAR(100)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 16, N'IsCustomer', N'Khách hàng', N'IsCustomer', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 17, N'IsSupplier', N'Nhà cung cấp', N'IsSupplier', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 18, N'IsUpdateName', N'Vãng lai', N'IsUpdateName', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 19, N'IsDealer', N'Nhà phân phối', N'IsDealer', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 20, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 21, N'Disabled', N'Không hiển thị', N'Disabled', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 22, N'IsRePayment', N'Điều khoản bán hàng, phải thu', N'IsRePayment', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 23, N'ReCreditLimit', N'Hạn mức nợ cho phép', N'ReCreditLimit', 
	N'', 100, 250, 1, N'DECIMAL(28,8)', N'', 0, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 24, N'ReDueDays', N'Số ngày phải thanh toán', N'ReDueDays', 
	N'', 100, 100, 1, N'DECIMAL(28,8)', N'', 0, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 25, N'IsLockedOver', N'Khóa (Ngưng bán hàng)', N'IsLockedOver', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 26, N'ReDays', N'Hạn mức tuổi nợ', N'ReDays', 
	N'', 100, 100, 1, N'INT', N'', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 27, N'DeAddress', N'Địa chỉ giao hàng', N'DeAddress', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 28, N'IsPaPayment', N'Điều khoản mua hàng, phải trả', N'IsPaPayment', 
	N'', 100, 100, 1, N'TINYINT', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 29, N'PaCreditLimit', N'Hạn mức nợ cho phép', N'PaCreditLimit', 
	N'', 100, 250, 1, N'DECIMAL(28,8)', N'', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 30, N'PaDueDays', N'Số ngày phải thanh toán', N'PaDueDays', 
	N'', 100, 100, 1, N'DECIMAL(28,8)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 31, N'PaDiscountDays', N'Số ngày hưởng chiếc khấu', N'PaDiscountDays', 
	N'', 100, 100, 1, N'DECIMAL(28,8)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 32, N'PaDiscountPercent', N'Tỷ lệ hưởng chiếc khấu', N'PaDiscountPercent', 
	N'', 100, 100, 1, N'DECIMAL(28,8)', N'', 0, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 33, N'ReAddress', N'Địa chỉ nhận hàng', N'ReAddress', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 34, N'BankName', N'Ngân hàng', N'BankName', 
	N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 35, N'BankAccountNo', N'Số tài khoản', N'BankAccountNo', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 36, N'LicenseNo', N'Số giấy phép', N'LicenseNo', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'AI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 37, N'LegalCapital', N'Vốn điều lệ', N'LegalCapital', 
	N'', 250, 250, 1, N'DECIMAL(28,8)', N'', 0, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 38, N'Note', N'Ghi chú 1', N'Note', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'AK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Object', N'Mẫu danh mục đối tượng', N'Object', N'CIF1150', N'Import_Excel_DanhMucDoiTuong.xlsx', N'EXEC CIP11504 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 39, N'Note1', N'Ghi chú 2', N'Note1', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'AL')

	--------------------------------------------------------- Danh mục bảng giá bán -----------------------------------------------------------
DELETE FROM A01065 WHERE ImportTemplateID = 'SalesAndPurchasePrice_EXV'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'SalesAndPurchasePrice_EXV')
	BEGIN
		INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
		[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
		VALUES ('SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', 'SalesAndPurchasePrice_EXV', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_BangGia.xlsx', 0,
		'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
	END


DELETE FROM A00065 WHERE ImportTransTypeID = N'SalesAndPurchasePrice_EXV'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'C3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 2, N'ID', N'Mã số', N'ID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 3, N'Description', N'Diễn giải', N'Description', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 4, N'FromDate', N'Từ ngày', N'FromDate', 
	N'', 100, 50, 0, N'DATETIME', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 5, N'ToDate', N'Đến ngày', N'ToDate', 
	N'', 100, 50, 0, N'DATETIME', N'', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 6, N'OID', N'Nhóm đối tượng', N'OID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 7, N'InventoryTypeID', N'Loại mặt hàng', N'InventoryTypeID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 8, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 9, N'IsConvertedPrice', N'Tính giá theo tiền quy đổi', N'IsConvertedPrice', 
	N'', 100, 50, 0, N'TINYINT', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 10, N'InheritID', N'Mã số kế thừa', N'InheritID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 11, N'TypeID', N'Loại bảng giá', N'TypeID', 
	N'', 150, 50, 0, N'TINYINT', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 12, N'InventoryID', N'Mã hàng', N'InventoryID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 1, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 13, N'UnitID', N'Đơn vị tính', N'UnitID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 1, N'L')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 14, N'ConvertedUnitPrice', N'Đơn giá', N'ConvertedUnitPrice', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'M')
		
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 15, N'ConvertedMinPrice', N'Giá tối thiểu', N'ConvertedMinPrice', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 16, N'ConvertedMaxPrice', N'Giá tối đa', N'ConvertedMaxPrice', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'O')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 17, N'UnitPrice', N'Đơn giá (ĐVT Chuẩn)', N'UnitPrice', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'P')

		
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 18, N'MinPrice', N'Giá tối thiểu (ĐVT Chuẩn)', N'MinPrice', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'Q')
			
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 19, N'MaxPrice', N'Giá tối đa (ĐVT Chuẩn)', N'MaxPrice', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'R')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 20, N'DiscountPercent', N'% Chiết khấu', N'DiscountPercent', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'S')
					
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 21, N'DiscountAmount', N'Chiết khấu', N'DiscountAmount', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'T')

						
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 22, N'SaleOffPercent01', N'% Giảm giá 1', N'SaleOffPercent01', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'U')
							
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 23, N'SaleOffAmount01', N'Giảm giá 1', N'SaleOffAmount01', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'V')
								
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 24, N'SaleOffPercent02', N'% Giảm giá 2', N'SaleOffPercent02', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'W')
									
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 25, N'SaleOffAmount02', N'Giảm giá 2', N'SaleOffAmount02', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'X')
								
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 26, N'SaleOffPercent03', N'% Giảm giá 3', N'SaleOffPercent03', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 27, N'SaleOffAmount03', N'Giảm giá 3', N'SaleOffAmount03', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 28, N'SaleOffPercent04', N'% Giảm giá 4', N'SaleOffPercent04', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'AA')
									
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 29, N'SaleOffAmount04', N'Giảm giá 4', N'SaleOffAmount04', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'AB')
								
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 30, N'SaleOffPercent05', N'% Giảm giá 5', N'SaleOffPercent05', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 31, N'SaleOffAmount05', N'Giảm giá 5', N'SaleOffAmount05', 
	N'', 150, 50, 0, N'DECIMAL(28,8)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 32, N'Notes', N'Ghi chú', N'Notes', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AE')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 33, N'Notes01', N'Ghi chú 1', N'Notes01', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AF')
		
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 34, N'Notes02', N'Ghi chú 2', N'Notes02', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AG')
			
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 35, N'S01ID', N'Quy cách 01', N'S01ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AH')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 36, N'S02ID', N'Quy cách 02', N'S02ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AI')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 37, N'S03ID', N'Quy cách 03', N'S03ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AJ')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 38, N'S04ID', N'Quy cách 04', N'S04ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AK')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 39, N'S05ID', N'Quy cách 05', N'S05ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AL')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 40, N'S06ID', N'Quy cách 06', N'S06ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AM')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 41, N'S07ID', N'Quy cách 07', N'S07ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AN')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 42, N'S08ID', N'Quy cách 08', N'S08ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AO')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 43, N'S09ID', N'Quy cách 09', N'S09ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AP')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 44, N'S10ID', N'Quy cách 10', N'S10ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AQ')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 45, N'S11ID', N'Quy cách 11', N'S11ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AR')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 46, N'S12ID', N'Quy cách 12', N'S12ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AS')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 47, N'S13ID', N'Quy cách 13', N'S13ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AT')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 48, N'S14ID', N'Quy cách 14', N'S14ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AU')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 49, N'S15ID', N'Quy cách 15', N'S15ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AV')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 50, N'S16ID', N'Quy cách 16', N'S16ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AW')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 51, N'S17ID', N'Quy cách 17', N'S17ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AX')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 52, N'S18ID', N'Quy cách 18', N'S18ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AY')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 53, N'S19ID', N'Quy cách 19', N'S19ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'AZ')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice_EXV', N'Mẫu danh mục bảng giá mua/ bán', N'SalesAndPurchasePrice_EXV', N'CIF1250', N'Import_Excel_BangGia.xlsx', N'EXEC AP8137_EXV @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 54, N'S20ID', N'Quy cách 20', N'S20ID', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 0, N'BA')



		--------------------------------------------------------- Danh mục bảng giá bán (HIPC) -----------------------------------------------------------

DELETE FROM A01065 WHERE ImportTemplateID = 'SalesAndPurchasePrice'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'SalesAndPurchasePrice')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', 'SalesAndPurchasePrice', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_BangGia_HIP.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'SalesAndPurchasePrice'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 2, N'ID', N'Mã số', N'ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 3, N'Description', N'Diễn giải', N'Description', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 4, N'FromDate', N'Từ ngày', N'FromDate', 
	N'', 80, 50, 2, N'DATETIME', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 5, N'ToDate', N'Đến ngày', N'ToDate', 
	N'', 80, 50, 2, N'DATETIME', N'', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 6, N'OID', N'Nhóm đối tượng', N'OID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 7, N'InventoryTypeID', N'Loại mặt hàng', N'InventoryTypeID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 8, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 9, N'IsConvertedPrice', N'Tính giá theo tiền quy đổi', N'IsConvertedPrice', 
	N'', 100, 50, 0, N'TINYINT', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 10, N'InheritID', N'Mã số kế thừa', N'InheritID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 11, N'TypeID', N'Loại bảng giá', N'TypeID', 
	N'', 80, 50, 0, N'TINYINT', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 12, N'InventoryID', N'Mã hàng', N'InventoryID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 13, N'UnitID', N'Đơn vị tính', N'UnitID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'L')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 14, N'ConvertedUnitPrice', N'Đơn giá', N'ConvertedUnitPrice', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'M')
		
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 15, N'ConvertedMinPrice', N'Giá tối thiểu', N'ConvertedMinPrice', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 16, N'ConvertedMaxPrice', N'Giá tối đa', N'ConvertedMaxPrice', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'O')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 17, N'UnitPrice', N'Đơn giá (ĐVT Chuẩn)', N'UnitPrice', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'P')

		
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 18, N'MinPrice', N'Giá tối thiểu (ĐVT Chuẩn)', N'MinPrice', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Q')
			
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 19, N'MaxPrice', N'Giá tối đa (ĐVT Chuẩn)', N'MaxPrice', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'R')
				
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 20, N'DiscountPercent', N'% Chiết khấu', N'DiscountPercent', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'S')
					
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 21, N'DiscountAmount', N'Chiết khấu', N'DiscountAmount', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'T')

						
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 22, N'SaleOffPercent01', N'% Giảm giá 1', N'SaleOffPercent01', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'U')
							
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 23, N'SaleOffAmount01', N'Giảm giá 1', N'SaleOffAmount01', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'V')
								
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 24, N'SaleOffPercent02', N'% Giảm giá 2', N'SaleOffPercent02', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'W')
									
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 25, N'SaleOffAmount02', N'Giảm giá 2', N'SaleOffAmount02', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'X')
								
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 26, N'SaleOffPercent03', N'% Giảm giá 3', N'SaleOffPercent03', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 27, N'SaleOffAmount03', N'Giảm giá 3', N'SaleOffAmount03', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 28, N'SaleOffPercent04', N'% Giảm giá 4', N'SaleOffPercent04', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AA')
									
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 29, N'SaleOffAmount04', N'Giảm giá 4', N'SaleOffAmount04', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AB')
								
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 30, N'SaleOffPercent05', N'% Giảm giá 5', N'SaleOffPercent05', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 31, N'SaleOffAmount05', N'Giảm giá 5', N'SaleOffAmount05', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 32, N'Notes', N'Ghi chú', N'Notes', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AE')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 33, N'Notes01', N'Ghi chú 1', N'Notes01', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AF')
		
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 34, N'Notes02', N'Ghi chú 2', N'Notes02', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 35, N'IsInventoryToPrice', N'Mặt hàng theo bảng giá', N'IsInventoryToPrice', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 36, N'IsTaxIncluded', N'Bảng giá sau thuế', N'IsTaxIncluded', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AI')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 37, N'IsAppDisplay', N'Không hiển thị trên app', N'IsAppDisplay', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesAndPurchasePrice', N'Mẫu danh mục bảng giá bán', N'SalesAndPurchasePrice', N'CIF1250', N'Import_Excel_BangGia_HIP.xlsx', N'EXEC AP8137 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 38, N'IsGift', N'Hàng tặng', N'IsGift', 
	N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'AK')

	--------------------------------------------------------- Danh mục nguồn lực -----------------------------------------------------------
IF @CustomerName = 161 -- customize INNOTEK
BEGIN
	DELETE FROM A01065 WHERE ImportTemplateID = 'Resource'

	IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Resource')
	BEGIN
		INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
		[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
		VALUES ('Resource', N'Mẫu danh mục nguồn lực', 'Resource', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_NguonLuc.xlsx', 0,
		'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
	END

	DELETE FROM A00065 WHERE ImportTransTypeID = N'Resource'

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
		N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 2, N'ResourceTypeID', N'Loại nguồn lực', N'ResourceTypeID', 
		N'', 150, 250, 0, N'NVARCHAR(50)', N'', 1, N'A')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 3, N'MachineID', N'Mã nguồn lực', N'MachineID', 
		N'', 150, 250, 0, N'NVARCHAR(50)', N'', 1, N'B')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 4, N'MachineName', N'Tên nguồn lực', N'MachineName', 
		N'', 150, 250, 0, N'NVARCHAR(250)', N'', 1, N'C')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 5, N'MachineNameE', N'Tên nguồn lực (ENG)', N'MachineNameE', 
		N'', 150, 250, 0, N'NVARCHAR(250)', N'', 0, N'D')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 6, N'UnitID', N'Đơn vị tính', N'UnitID', 
		N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'E')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 7, N'GoldLimit', N'Công suất/ DVT', N'GoldLimit', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'F')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 8, N'DepartmentID', N'Phòng ban', N'DepartmentID', 
		N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1102'', @Param2 = ''DepartmentID'', @SQLFilter = '' ISNULL(TL.Disabled, 0) = 0''', 0, N'G')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 9, N'MachineTypeID', N'Loại máy', N'MachineTypeID', 
		N'', 80, 250, 0, N'NVARCHAR(50)', N'', 0, N'H')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 10, N'Quantity', N'Số lượng  máy', N'Quantity', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'I')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 11, N'TimeLimit', N'Thời gian định mức', N'TimeLimit', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'J')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 12, N'WorkersLimit', N'Tổng số lao động', N'WorkersLimit', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'K')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 13, N'Efficiency', N'Hiệu suất', N'Efficiency', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'L')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 14, N'LinedUpTime', N'Thời gian xếp hàng', N'LinedUpTime', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'M')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 15, N'SettingTime', N'Thời gian thiết lập', N'SettingTime', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'N')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 16, N'WaittingTime', N'Thời gian đợi', N'WaittingTime', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'O')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 17, N'TransferTime', N'Thời gian di chuyển', N'TransferTime', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'P')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 18, N'MinTime', N'Thời gian tối thiểu', N'MinTime', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Q')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 19, N'MaxTime', N'Thời gian tối đa', N'MaxTime', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'R')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 20, N'Notes', N'Ghi chú', N'Notes', 
		N'', 80, 250, 0, N'NVARCHAR(250)', N'', 0, N'S')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 21, N'StartDate', N'Ngày hình thành', N'StartDate', 
		N'', 80, 250, 0, N'DATETIME', N'', 0, N'T')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 22, N'Year', N'Năm', N'Year', 
		N'', 80, 50, 0, N'NVARCHAR(100)', N'', 0, N'U')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 23, N'Model', N'Mẫu', N'Model', 
		N'', 80, 250, 0, N'NVARCHAR(250)', N'', 0, N'V')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 24, N'StandardID', N'Mã thông số kỹ thuật', N'StandardID', 
		N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''QCT1000'', @Param2 = ''StandardID''', 0, N'W')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 25, N'Notes01', N'Ghi chú', N'Notes01', 
		N'', 80, 250, 0, N'NVARCHAR(250)', N'', 0, N'X')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 26, N'Disabled', N'Không hiển thị', N'Disabled', 
		N'', 80, 50, 1, N'TINYINT', N'', 0, N'Y')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 27, N'InventoryID', N'Mã mặt hàng', N'InventoryID', 
		N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1302'', @Param2 = ''InventoryID''', 0, N'Z')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 28, N'Quantity01', N'Hiệu suất máy', N'Quantity01', 
		N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AA')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'Resource', N'Mẫu danh mục nguồn lực', N'Resource', N'CIF1370', N'Import_Excel_NguonLuc.xlsx', N'EXEC AP8169 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 29, N'Notes02', N'Ghi chú', N'Notes02', 
		N'', 80, 250, 0, N'NVARCHAR(250)', N'', 0, N'AB')
END