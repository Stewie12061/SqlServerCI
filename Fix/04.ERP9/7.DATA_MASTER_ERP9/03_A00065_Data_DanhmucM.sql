-- <Summary>
---- Template import data:
-- <History>
---- Created on 09/06/2021 by Phạm Lê Hoàng: Thêm dữ liệu danh mục Định mức sản phẩm
---- Modified on ... by ...
---- <Example>
	
	----------------------- Danh mục Mẫu Định mức sản phẩm ----------------------- 
DELETE FROM A01065 WHERE ImportTemplateID = 'Apportion'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Apportion')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Apportion', N'Danh mục Định mức sản phẩm', 'Apportion', 'Data', N'A', 9, N'C:\IMPORTS', N'MF2120.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'Apportion'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, 
N'DivisionID', N'Đơn vị', N'DivisionID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, 
N'Number', N'Số thứ tự Bộ ĐM', N'Number', N'', 100, 50, 1, N'INT', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, 
N'InheritID', N'Loại kế thừa', N'Inherit ID', N'', 100, 50, 1, N'INT', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, 
N'InventoryTypeID', N'Loại sản phẩm', N'Inventory type', N'', 100, 50, 1, N'INT', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, 
N'ProductID', N'Sản phẩm kế thừa', N'Product ID', N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, 
N'CreateBOMVersion', N'Tạo BOM version', N'CreateBOMVersion', N'', 100, 50, 1, N'INT', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, 
N'ObjectID', N'Khách hàng', N'Object ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1202'', @Param2 = ''ObjectID'', @SQLFilter = ''TL.Disabled =  0 AND (TL.IsCustomer=1 OR TL.IsUpdateName=1) ''', 0, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, 
N'StartDate', N'Thời gian bắt đầu', N'Start date', N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, 
N'EndDate', N'Thời gian kết thúc', N'End date', N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, 
N'RoutingID', N'Qui trình sản xuất', N'Routing ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''MT2130'', @Param2 = ''RoutingID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, 
N'Description', N'Diễn giải', N'Description', N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, 
N'NodeTypeID', N'Phân loại', N'NodeTypeID', N'', 100, 50, 1, N'INT', N'{CheckValueInTableList} @Param1 = ''MT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''StuctureType'''' ''', 1, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, 
N'NodeChild', N'Mã sản phẩm', N'NodeChild', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1302'', @Param2 = ''InventoryID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, 
N'NodeParent', N'Mã sản phẩm cha', N'NodeParent', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1302'', @Param2 = ''InventoryID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, 
N'DisplayName', N'Tên hiển thị', N'DisplayName', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''MT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''DisplayName'''' ''', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, 
N'DictatesID', N'Có lập lệnh', N'DictatesID', N'', 100, 50, 1, N'INT', N'{CheckValueInTableList} @Param1 = ''MT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Dictates'''' ''', 1, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, 
N'OutsourceID', N'Gia công', N'OutsourceID', N'', 100, 50, 1, N'INT', N'{CheckValueInTableList} @Param1 = ''MT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Outsource'''' ''', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, 
N'PhaseID', N'Lệnh sản xuất', N'PhaseID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0126'', @Param2 = ''PhaseID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, 
N'S01ID', N'Quy cách 01', N'S01ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S01'''' ''', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, 
N'S02ID', N'Quy cách 02', N'S02ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S02'''' ''', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, 
N'S03ID', N'Quy cách 03', N'S03ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S03'''' ''', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, 
N'S04ID', N'Quy cách 04', N'S04ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S04'''' ''', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, 
N'S05ID', N'Quy cách 05', N'S05ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S05'''' ''', 0, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, 
N'S06ID', N'Quy cách 06', N'S06ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S06'''' ''', 0, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, 
N'S07ID', N'Quy cách 07', N'S07ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S07'''' ''', 0, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, 
N'S08ID', N'Quy cách 08', N'S08ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S08'''' ''', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, 
N'S09ID', N'Quy cách 09', N'S09ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S09'''' ''', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, 
N'S10ID', N'Quy cách 10', N'S10ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S10'''' ''', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, 
N'S11ID', N'Quy cách 11', N'S11ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S11'''' ''', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 29, 
N'S12ID', N'Quy cách 12', N'S12ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S12'''' ''', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 30, 
N'S13ID', N'Quy cách 13', N'S13ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S13'''' ''', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 31, 
N'S14ID', N'Quy cách 14', N'S14ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S14'''' ''', 0, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 32, 
N'S15ID', N'Quy cách 15', N'S15ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S15'''' ''', 0, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 33, 
N'S16ID', N'Quy cách 16', N'S16ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S16'''' ''', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 34, 
N'S17ID', N'Quy cách 17', N'S17ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S17'''' ''', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 35, 
N'S18ID', N'Quy cách 18', N'S18ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S18'''' ''', 0, N'AI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 36, 
N'S19ID', N'Quy cách 19', N'S19ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S19'''' ''', 0, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 37, 
N'S20ID', N'Quy cách 20', N'S20ID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0128'', @Param2 = ''StandardID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StandardTypeID = ''''S20'''' ''', 0, N'AK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 38, 
N'QuantitativeType', N'Loại định lượng', N'QuantitativeType', N'', 100, 50, 1, N'INT', N'{CheckValueInTableList} @Param1 = ''MT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''QuantitativeType'''' ''', 1, N'AL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 39, 
N'QuantitativeValue', N'Định lượng', N'QuantitativeValue', N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 40, 
N'LossValue', N'Hao hụt', N'LossValue', N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 41, 
N'MaterialGroupID', N'Nhóm nguyên liệu', N'MaterialGroupID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''MT0006'', @Param2 = ''MaterialGroupID'', @SQLFilter = ''TL.Disabled = 0''', 0, N'AO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 42, 
N'MaterialID', N'Nguyên liệu thay thế', N'MaterialID', N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''MT0007'', @Param2 = ''MaterialID'', @SQLFilter = ''''', 0, N'AP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Apportion', N'Danh mục Định mức sản phẩm', N'Apportion of product', N'MF2120', N'MF2120.xlsx', 
N'EXEC MP2125 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 43, 
N'MaterialConstant', N'Hệ số', N'MaterialConstant', N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AQ')