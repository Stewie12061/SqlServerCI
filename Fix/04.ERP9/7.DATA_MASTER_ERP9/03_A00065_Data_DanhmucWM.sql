-- <Summary>
---- Template import data: danh mục module WM
-- <History>
---- Create on 09/06/2022 by Hoài Bảo
---- Modified on 24/11/2022 by Hoài Bảo - Bổ sung cột DebitAccountID
---- Modified on ... by ...
---- <Example>

----------------------------------Danh mục số dư đầu hàng tồn kho----------------------------------
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'InventoryBalance_WM')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('InventoryBalance_WM', N'Số dư đầu hàng tồn kho', 'InventoryBalance_WM', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'InventoryBalance_WM'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 2, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 3, N'VoucherNo', N'Số chứng từ', N'VoucherNo', 
	N'', 150, 50, 0, N'NVARCHAR(50)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 4, N'VoucherDate', N'Ngày hạch toán', N'VoucherDate', 
	N'', 100, 50, 2, N'Datetime', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 5, N'WareHouseID', N'Kho nhập', N'WareHouseID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 6, N'ObjectID', N'Đối tượng', N'ObjectID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 7, N'EmployeeID', N'Người lập phiếu', N'EmployeeID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 8, N'Description', N'Ghi chú', N'Description', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 9, N'InventoryID', N'Mã hàng', N'InventoryID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 10, N'UnitID', N'Đơn vị tính', N'UnitID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 11, N'ActualQuantity', N'Số lượng nhập', N'ActualQuantity', 
	N'', 100, 250, 1, N'Decimal(28,8)', N'', 1, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 12, N'UnitPrice', N'Đơn giá', N'UnitPrice', 
	N'', 100, 250, 1, N'Decimal(28,8)', N'', 1, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 13, N'OriginalAmount', N'Thành tiền', N'OriginalAmount', 
	N'', 100, 250, 1, N'Decimal(28,8)', N'', 1, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 14, N'DebitAccountID', N'Tài khoản nợ', N'DebitAccountID', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 1, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 15, N'SourceNo', N'Lô nhập', N'SourceNo', 
	N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 16, N'LimitDate', N'Hạn sử dụng', N'LimitDate', 
	N'', 100, 50, 2, N'Datetime', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'InventoryBalance_WM', N'Số dư đầu hàng tồn kho', N'InventoryBalance_WM', N'WMF2260', N'Import_Excel_SoDuDauHangTonKho_WM.xlsx', N'EXEC WMP22603 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @ImportTransTypeID = @ImportTransTypeID, @ImportTemplateID = @ImportTemplateID, @XML = @XML', 17, N'Notes', N'Diễn giải', N'Notes', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'Q')