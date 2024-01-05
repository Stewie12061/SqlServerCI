-- <Summary>
---- Template import data: Nghiệp vụ phân hệ ERP9
-- <History>
---- Create on 11/06/2021 by Lê Hoàng: Thêm dữ liệu Nghiệp vụ mẫu Đơn hàng mua
-----Create on 17/12/2021 by Minh Hiếu: Thêm dữ liệu Nghiệp vụ phiếu báo giá
-----Create on 24/02/2023 by Nhật Quang: Thêm dữ liệu Nghiệp vụ yêu cầu mua hàng
---- Modified on 24/03/2023 by Viết Toàn: bổ sung dữ liệu Nghiệp vụ mẫu Đơn hàng mua
---- <Example>
	--SELECT * FROM A00065 WHERE ImportTransTypeID = N'SupplierQuotes'
	----------------------- Nghiệp vụ mẫu Đơn hàng mua ----------------------- 
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'PurchaseOrder')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('PurchaseOrder', N'Đơn hàng mua', 'PurchaseOrder', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DonHangMua.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'PurchaseOrder'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'Period', N'Kì kế toán', N'Period', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'B4')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'B5')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'PurchaseNo', N'Số đơn hàng', N'PurchaseNo', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'PurchaseDate', N'Ngày đơn hàng', N'PurchaseDate', 
N'', 80, 50, 2, N'DATETIME', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ContractNo', N'Số hợp đồng', N'ContractNo', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ContractDate', N'Ngày ký HĐ', N'ContractDate', 
N'', 80, 50, 2, N'DATETIME', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'ExchangeRate', N'Tỷ giá', N'ExchangeRate', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'ClassifyID', N'Phân loại đơn hàng', N'ClassifyID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'Status', N'Tình trạng', N'Status', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'MasterShipDate', N'Ngày giao hàng', N'MasterShipDate', 
N'', 80, 50, 2, N'DATETIME', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'InventoryTypeID', N'Loại mặt hàng', N'InventoryTypeID', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'EmployeeID', N'Người theo dõi', N'EmployeeID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'Description', N'Diễn giải', N'Description', 
N'', 150, 250, 0, N'varchar(250)', N'', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'ObjectID', N'Nhà cung cấp', N'ObjectID', 
N'', 150, 250, 0, N'varchar(250)', N'', 1, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'TaxID', N'Mã số thuế', N'TaxID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'DueDate', N'Ngày đáo hạn', N'DueDate', 
N'', 80, 50, 2, N'DATETIME', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'OrderAddress', N'Địa chỉ', N'OrderAddress', 
N'', 150, 250, 0, N'varchar(250)', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'ReceivedAddress', N'Địa chỉ nhận hàng', N'ReceivedAddress', 
N'', 150, 250, 0, N'varchar(250)', N'', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'Transport', N'Phương tiện vận chuyển', N'Transport', 
N'', 150, 250, 0, N'varchar(250)', N'', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'PaymentTermID', N'Đ/K thanh toán', N'PaymentTermID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'Varchar01', N'Tên Đ/K thanh toán', N'Varchar01', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'PaymentID', N'Phương thức thanh toán', N'PaymentID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'Varchar02', N'Tên phương thức thanh toán', N'Varchar02', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'POAna01ID', N'Mã phân tích đơn hàng 01', N'POAna01ID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'POAna02ID', N'Mã phân tích đơn hàng 02', N'POAna02ID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, N'POAna03ID', N'Mã phân tích đơn hàng 03', N'POAna03ID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'Y')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 29, N'POAna04ID', N'Mã phân tích đơn hàng 04', N'POAna04ID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 30, N'POAna05ID', N'Mã phân tích đơn hàng 05', N'POAna05ID', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 31, N'BarCode', N'Mã vạch', N'BarCode', 
N'', 80, 50, 0, N'varchar(50)', N'', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 32, N'InventoryID', N'Mã hàng', N'InventoryID', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 33, N'UnitID', N'Đơn vị tính', N'UnitID', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 34, N'ConvertedQuantity', N'Số lượng', N'ConvertedQuantity', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 1, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 35, N'ConvertedSaleprice', N'Đơn giá', N'ConvertedSaleprice', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 1, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 36, N'OrderQuantity', N'Số lượng (ĐVT chuẩn)', N'OrderQuantity', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 1, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 37, N'PurchasePrice', N'Đơn giá (ĐVT chuẩn)', N'PurchasePrice', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 1, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 38, N'OriginalAmount', N'Nguyên tệ', N'OriginalAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 1, N'AI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 39, N'ConvertedAmount', N'Quy đổi', N'ConvertedAmount', 
N'', 80, 50, 1, N'INT', N'', 1, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 40, N'DiscountPercent', N'% Chiết khấu', N'DiscountPercent', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 41, N'DiscountOriginalAmount', N'Chiết khấu nguyên tệ', N'DiscountOriginalAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 42, N'DiscountConvertedAmount', N'Chiết khấu', N'DiscountConvertedAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 43, N'VATPercent', N'%Thuế GTGT', N'VATPercent', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 44, N'VATOriginalAmount', N'Thuế GTGT nguyên tệ', N'VATOriginalAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 45, N'VATConvertedAmount', N'Thuế GTGT', N'VATConvertedAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 46, N'ImTaxPercent', N'%Thuế nhập khẩu', N'ImTaxPercent', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AQ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 47, N'ImTaxOriginalAmount', N'Thuế nhập khẩu nguyên tệ', N'ImTaxOriginalAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AR')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 48, N'ImTaxConvertedAmount', N'Thuế nhập khẩu', N'ImTaxConvertedAmount', 
N'', 80, 50, 1, N'decimal(28,8)', N'', 0, N'AS')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 49, N'IsPicking', N'Giữ chỗ', N'IsPicking', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AT')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 50, N'WareHouseID', N'Kho giữ chỗ', N'WareHouseID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AU')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 51, N'Finish', N'Hoàn tất', N'Finish', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AV')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 52, N'Ana01ID', N'Dự án / Ngành', N'Ana01ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AW')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 53, N'Ana02ID', N'Phí / Loại Chi Phí', N'Ana02ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AX')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 54, N'Ana03ID', N'Bộ Phận / Phòng Ban', N'Ana03ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AY')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 55, N'Ana04ID', N'Nhân Viên', N'Ana04ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AZ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 56, N'Ana05ID', N'KUV/HĐồng', N'Ana05ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'BA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 57, N'Ana06ID', N'Mã phân tích 6', N'Ana06ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'BB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 58, N'Ana07ID', N'Mã phân tích 7', N'Ana07ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'BC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 59, N'Ana08ID', N'Mã phân tích 8', N'Ana08ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'BD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 60, N'Ana09ID', N'Mã phân tích 9', N'Ana09ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'BE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 61, N'Ana10ID', N'Mã phân tích 10', N'Ana10ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'BF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 62, N'Notes', N'Ghi chú 1', N'Notes', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BG')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 63, N'Notes01', N'Ghi chú 2', N'Notes01', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 64, N'Notes02', N'Ghi chú 3', N'Notes02', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 65, N'Notes03', N'Ghi chú 4', N'Notes03', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 66, N'Notes04', N'Ghi chú 5', N'Notes04', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 67, N'Notes05', N'Ghi chú 6', N'Notes05', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 68, N'Notes06', N'Ghi chú 7', N'Notes06', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 69, N'Notes07', N'Ghi chú 8', N'Notes07', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 70, N'Notes08', N'Ghi chú 9', N'Notes08', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 71, N'Notes09', N'Ghi chú 10', N'Notes09', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 72, N'DetailShipDate', N'Ngày giao hàng (Detail)', N'DetailShipDate', 
N'', 80, 50, 2, N'DATETIME', N'', 0, N'BQ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 73, N'StrParameter01', N'Tham số 01', N'StrParameter01', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BR')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 74, N'StrParameter02', N'Tham số 02', N'StrParameter02', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BS')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 75, N'StrParameter03', N'Tham số 03', N'StrParameter03', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BT')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 76, N'StrParameter04', N'Tham số 04', N'StrParameter04', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BU')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 77, N'StrParameter05', N'Tham số 05', N'StrParameter05', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BV')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 78, N'StrParameter06', N'Tham số 06', N'StrParameter06', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BW')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 79, N'StrParameter07', N'Tham số 07', N'StrParameter07', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BX')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 80, N'StrParameter08', N'Tham số 08', N'StrParameter08', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BY')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 81, N'StrParameter09', N'Tham số 09', N'StrParameter09', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'BZ')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 82, N'StrParameter10', N'Tham số 10', N'StrParameter10', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 83, N'StrParameter11', N'Tham số 11', N'StrParameter11', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 84, N'StrParameter12', N'Tham số 12', N'StrParameter12', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 85, N'StrParameter13', N'Tham số 13', N'StrParameter13', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 86, N'StrParameter14', N'Tham số 14', N'StrParameter14', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 87, N'StrParameter15', N'Tham số 15', N'StrParameter15', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 88, N'StrParameter16', N'Tham số 16', N'StrParameter16', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 89, N'StrParameter17', N'Tham số 17', N'StrParameter17', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 90, N'StrParameter18', N'Tham số 18', N'StrParameter18', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 91, N'StrParameter19', N'Tham số 19', N'StrParameter19', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 92, N'StrParameter20', N'Tham số 20', N'StrParameter20', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 93, N'nvarchar01', N'Tham số TT 01', N'nvarchar01', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 94, N'nvarchar02', N'Tham số TT 02', N'nvarchar02', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 95, N'nvarchar03', N'Tham số TT 03', N'nvarchar03', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 96, N'nvarchar04', N'Tham số TT 04', N'nvarchar04', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 97, N'nvarchar05', N'Tham số TT 05', N'nvarchar05', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 98, N'nvarchar06', N'Tham số TT 06', N'nvarchar06', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CQ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 99, N'nvarchar07', N'Tham số TT 07', N'nvarchar07', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CR')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 100, N'nvarchar08', N'Tham số TT 08', N'nvarchar08', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CS')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 101, N'nvarchar09', N'Tham số TT 09', N'nvarchar09', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CT')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 102, N'nvarchar10', N'Tham số TT 10', N'nvarchar10', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CU')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 103, N'nvarchar11', N'Tham số TT 11', N'nvarchar11', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CV')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 104, N'nvarchar12', N'Tham số TT 12', N'nvarchar12', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CW')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 105, N'nvarchar13', N'Tham số TT 13', N'nvarchar13', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CX')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 106, N'nvarchar14', N'Tham số TT 14', N'nvarchar14', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CY')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 107, N'nvarchar15', N'Tham số TT 15', N'nvarchar15', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'CZ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 108, N'nvarchar16', N'Tham số TT 16', N'nvarchar16', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'DA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 109, N'nvarchar17', N'Tham số TT 17', N'nvarchar17', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'DB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 110, N'nvarchar18', N'Tham số TT 18', N'nvarchar18', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'DC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 111, N'nvarchar19', N'Tham số TT 19', N'nvarchar19', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'DD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 112, N'nvarchar20', N'Tham số TT 20', N'nvarchar20', 
N'', 150, 250, 0, N'nvarchar(250)', N'', 0, N'DE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 113, N'S01ID', N'Quy cách 01', N'S01ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 114, N'S02ID', N'Quy cách 02', N'S02ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 115, N'S03ID', N'Quy cách 03', N'S03ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 116, N'S04ID', N'Quy cách 04', N'S04ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 117, N'S05ID', N'Quy cách 05', N'S05ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 118, N'S06ID', N'Quy cách 06', N'S06ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 119, N'S07ID', N'Quy cách 07', N'S07ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 120, N'S08ID', N'Quy cách 08', N'S08ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 121, N'S09ID', N'Quy cách 09', N'S09ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 122, N'S10ID', N'Quy cách 10', N'S10ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 123, N'S11ID', N'Quy cách 11', N'S11ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 124, N'S12ID', N'Quy cách 12', N'S12ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DQ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 125, N'S13ID', N'Quy cách 13', N'S13ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DR')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 126, N'S14ID', N'Quy cách 14', N'S14ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DS')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 127, N'S15ID', N'Quy cách 15', N'S15ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DT')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 128, N'S16ID', N'Quy cách 16', N'S16ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DU')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 129, N'S17ID', N'Quy cách 17', N'S17ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DV')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 130, N'S18ID', N'Quy cách 18', N'S18ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DW')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 131, N'S19ID', N'Quy cách 19', N'S19ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DX')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 132, N'S20ID', N'Quy cách 20', N'S20ID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DY')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 133, N'RequestID', N'Số yêu cầu mua hàng', N'RequestID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'DZ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 134, N'ApprovePerson01', N'Người duyệt 01', N'ApprovePerson01', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 135, N'ApprovePerson02', N'Người duyệt 02', N'ApprovePerson02', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 136, N'ApprovePerson03', N'Người duyệt 03', N'ApprovePerson03', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 137, N'ApprovePerson04', N'Người duyệt 04', N'ApprovePerson04', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'ED')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 138, N'ApprovePerson05', N'Người duyệt 05', N'ApprovePerson05', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 139, N'ApprovePerson06', N'Người duyệt 06', N'ApprovePerson06', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 140, N'ApprovePerson07', N'Người duyệt 07', N'ApprovePerson07', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 141, N'ApprovePerson08', N'Người duyệt 08', N'ApprovePerson08',  
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 142, N'ApprovePerson09', N'Người duyệt 09', N'ApprovePerson09', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PurchaseOrder', N'Đơn hàng mua', N'PurchaseOrder', N'POF2000', N'Import_Excel_DonHangMua.xlsx', N'EXEC AP8122 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 143, N'ApprovePerson10', N'Người duyệt 10', N'ApprovePerson10',  
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'EJ')

----------------------------------Nghiệp vụ phiếu báo giá----------------------------------
DELETE FROM A00065 WHERE ImportTransTypeID = N'SupplierQuotes'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'SupplierQuotes')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('SupplierQuotes', N'Báo giá nhà cung cấp', 'SupplierQuotes', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_BaoGiaNCC.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
N'', 80, 50, 1, N'varchar(50)', N'', 1, N'B3')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear , @XML = @XML', 2, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', 
N'', 80, 50, 0, N'varchar(50)', N'', 1, N'A')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear , @XML = @XML', 3, N'VoucherNo', N'Phiếu số', N'VoucherNo', 
N'', 80, 50, 1, N'VARCHAR(50)', N'', 1, N'B')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 4, N'VoucherDate', N'Ngày yêu cầu', N'VoucherDate', 
N'', 80, 50, 2, N'DATETIME', N'', 1, N'C')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 5, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'D')



INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 6, N'ObjectID', N'Nhà cung cấp', N'ObjectID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'E')




INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 7, N'OverDate', N'Ngày hết hạn', N'OverDate', 
N'', 80, 50, 2, N'DATETIME', N'', 0, N'F')




INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 8, N'EmployeeID', N'Người lập', N'EmployeeID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'G')




INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 9, N'ExchangeRate', N'Tỷ giá', N'ExchangeRate', 
N'', 80, 50, 1, N'int', N'', 1, N'H')




INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 10, N'Description', N'Diễn giải', N'Description', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'I')




INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 11, N'InventoryID', N'Mã hàng', N'InventoryID', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'J')




INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 12, N'TechnicalSpecifications', N'Thông số kỹ thuật', N'TechnicalSpecifications', 
N'', 80, 50, 0, N'nvarchar(max)', N'', 0, N'K')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 13, N'Quantity', N'Số lượng', N'Quantity', 
N'', 80, 50, 1, N'int', N'', 1, N'L')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 14, N'UnitPrice', N'Đơn giá', N'UnitPrice', 
N'', 80, 50, 1, N'int', N'', 1, N'M')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 15, N'RequestPrice', N'Giá yêu cầu', N'RequestPrice', 
N'', 80, 50, 1, N'int', N'', 1, N'N')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 16, N'Notes', N'Ghi chú', N'Notes', 
N'', 80, 50, 0, N'nvarchar(500)', N'', 0, N'O')



INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SupplierQuotes', N'Báo giá nhà cung cấp', N'SupplierQuotes', N'POF2040', N'Import_Excel_BaoGiaNCC.xls', N'EXEC POP20041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 17, N'ApprovePersonID01', N'Người duyệt', N'ApprovePersonID01', 
N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'P')



---------- Begin Add - Nhật Quang on 23/02/2023: 

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'OrderRequestPO')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('OrderRequestPO', N'Yêu cầu mua hàng', 'OrderRequestPO', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_YeuCauMuaHang.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'OrderRequestPO'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'Division', 
	N'', 50, 50, 0, N'NVARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID,  @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'Period', N'Period', N'Kỳ kế toán', 
	N'', 80, 7, 0, N'VARCHAR(10)', N'{CheckValidPeriod} @Module = ''ASOFT-OP''', 1, N'B4')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID,  @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'VoucherTypeID', N'Loại chứng từ', N'Voucher Type', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValidVoucherType} @ObligeCheck = 1, @SQLFilter = ''''', 1, N'B5')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID,  @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'RequestNo', N'Phiếu yêu cầu mua hàng', N'Request No', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID,  @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'RequestDate', N'Ngày phiếu yêu cầu', N'Request Date', 
	N'dd/mm/yyyy', 80, 10, 2, N'DATETIME', N'{CheckValidVoucherDate}', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID,  @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ContractNo', N'Số hợp đồng', N'Contract No', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ContractDate', N'Ngày ký HĐ', N'Contract Date', 
	N'dd/mm/yyyy', 80, 10, 2, N'DATETIME', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 8, N'CurrencyID', N'Loại tiền', N'Currency', 
	N'', 50, 50, 0, N'NVARCHAR(50)', N'{CheckValidCurrency} @ObligeCheck = 1', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 9, N'ExchangeRate', N'Tỷ giá', N'Exchange Rate', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 10, N'ClassifyID', N'Phân loại đơn hàng', N'Classify', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 11, N'Status', N'Tình trạng', N'Status', 
	N'', 50, 1, 1, N'TINYINT', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 12, N'MasterShipDate', N'Ngày giao hàng', N'Ship Date', 
	N'dd/mm/yyyy', 80, 10, 2, N'DATETIME', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 13, N'InventoryTypeID', N'Loại mặt hàng', N'Inventory Type', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 1, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 14, N'EmployeeID', N'Người theo dõi', N'Employee', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 15, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 16, N'DueDate', N'Ngày đáo hạn', N'Due Date', 
	N'', 80, 10, 2, N'DATETIME', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 17, N'OrderAddress', N'Địa chỉ', N'OrderAddress', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 18, N'ReceivedAddress', N'Địa chỉ nhận hàng', N'Received Address', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 19, N'Transport', N'Phương tiện vận chuyển', N'Transport', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 20, N'PaymentID', N'Phương thức thanh toán', N'Payment', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 21, N'POAna01ID', N'Mã phân tích đơn hàng 01', N'R', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''OT1002'', @Param2 = ''AnaID'',  @SQLFilter = ''TL.Disabled =  0 AND TL.AnaTypeID = ''''P01''''''', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 22, N'POAna02ID', N'Mã phân tích đơn hàng 02', N'S', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''OT1002'', @Param2 = ''AnaID'',  @SQLFilter = ''TL.Disabled =  0 AND TL.AnaTypeID = ''''P02''''''', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 23, N'POAna03ID', N'Mã phân tích đơn hàng 03', N'T', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''OT1002'', @Param2 = ''AnaID'',  @SQLFilter = ''TL.Disabled =  0 AND TL.AnaTypeID = ''''P03''''''', 0, N'U')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 24, N'POAna04ID', N'Mã phân tích đơn hàng 04', N'U', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''OT1002'', @Param2 = ''AnaID'',  @SQLFilter = ''TL.Disabled =  0 AND TL.AnaTypeID = ''''P04''''''', 0, N'V')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 25, N'POAna05ID', N'Mã phân tích đơn hàng 05', N'V', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''OT1002'', @Param2 = ''AnaID'',  @SQLFilter = ''TL.Disabled =  0 AND TL.AnaTypeID = ''''P05''''''', 0, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 26, N'InventoryID', N'Mã hàng', N'Inventory', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''AT1302'', @Param2 = ''InventoryID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 27, N'UnitID', N'Đơn vị tính', N'Unit', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''AT1304'', @Param2 = ''UnitID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'X')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 28, N'ConvertedQuantity', N'Số lượng', N'Quantity', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 1, N'Y')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 29, N'ConvertedSaleprice', N'Đơn giá', N'Price', 
	N'', 80, 10, 1, N'DECIMAL(28,8)', N'', 1, N'Z')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 30, N'OrderQuantity', N'Số lượng (ĐVT chuẩn)', N'Order Quantity', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 1, N'AA')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 31, N'RequestPrice', N'Đơn giá (ĐVT chuẩn)', N'Request Price', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 1, N'AB')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 32, N'OriginalAmount', N'Nguyên tệ', N'Original Amount', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 1, N'AC')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 33, N'ConvertedAmount', N'Quy đổi', N'Converted Amount', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 1, N'AD')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 34, N'VATPercent', N'%Thuế GTGT', N'VAT Percent', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 0, N'AE')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 35, N'VATOriginalAmount', N'Thuế GTGT nguyên tệ', N'VAT Original Amount', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 0, N'AF')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 36, N'VATConvertedAmount', N'Thuế GTGT', N'VAT Converted Amount', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 0, N'AG')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 37, N'DetailDescription', N'Diễn giải chi tiết', N'Detail Description', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'AH')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 38, N'Ana01ID', N'Khoản mục 1', N'Ana01ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AI')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 39, N'Ana02ID', N'Khoản mục 2', N'Ana02ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AJ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 40, N'Ana03ID', N'Khoản mục 3', N'Ana03ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AK')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 41, N'Ana04ID', N'Khoản mục 4', N'Ana04ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AL')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 42, N'Ana05ID', N'Khoản mục 5', N'Ana05ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AM')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 43, N'Ana06ID', N'Khoản mục 6', N'Ana06ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AN')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 44, N'Ana07ID', N'Khoản mục 7', N'Ana07ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AO')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 45, N'Ana08ID', N'Khoản mục 8', N'Ana08ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AP')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 46, N'Ana09ID', N'Khoản mục 9', N'Ana09ID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'AQ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 47, N'Ana10ID', N'Khoản mục 10', N'Ana10ID', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'AR')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 48, N'Notes', N'Ghi chú 1', N'Notes', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'AS')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 49, N'Notes01', N'Ghi chú 2', N'Notes01', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'AT')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 50, N'Notes02', N'Ghi chú 3', N'Notes02', 
	N'', 110, 50, 0, N'NVARCHAR(250)', N'', 0, N'AU')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 51, N'S01ID', N'Quy cách 01', N'S01ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'AV')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 52, N'S02ID', N'Quy cách 02', N'S02ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'AW')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 53, N'S03ID', N'Quy cách 03', N'S03ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'AX')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 54, N'S04ID', N'Quy cách 04', N'S04ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'AY')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 55, N'S05ID', N'Quy cách 05', N'S05ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'AZ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 56, N'S06ID', N'Quy cách 06', N'S06ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BA')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 57, N'S07ID', N'Quy cách 07', N'S07ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BB')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 58, N'S08ID', N'Quy cách 08', N'S08ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BC')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 59, N'S09ID', N'Quy cách 09', N'S09ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BD')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 60, N'S10ID', N'Quy cách 10', N'S10ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BE')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 61, N'S11ID', N'Quy cách 11', N'S11ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BF')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 62, N'S12ID', N'Quy cách 12', N'S12ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BG')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 63, N'S13ID', N'Quy cách 13', N'S13ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BH')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 64, N'S14ID', N'Quy cách 14', N'S14ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BI')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 65, N'S15ID', N'Quy cách 15', N'S15ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BJ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 66, N'S16ID', N'Quy cách 16', N'S16ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BK')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 67, N'S17ID', N'Quy cách 17', N'S17ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BL')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 68, N'S18ID', N'Quy cách 18', N'S18ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BM')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 69, N'S19ID', N'Quy cách 19', N'S19ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BN')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 70, N'S20ID', N'Quy cách 20', N'S20ID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BO')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 71, N'PriorityID', N'Độ ưu tiên', N'PriorityID', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BP')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 72, N'ApprovePerson01', N'Người duyệt 01', N'ApprovePerson01', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BQ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 73, N'ApprovePerson02', N'Người duyệt 02', N'ApprovePerson02', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BR')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 74, N'ApprovePerson03', N'Người duyệt 03', N'ApprovePerson03', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BS')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 75, N'ApprovePerson04', N'Người duyệt 04', N'ApprovePerson04', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BT')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 76, N'ApprovePerson05', N'Người duyệt 05', N'ApprovePerson05', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BU')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 77, N'ApprovePerson06', N'Người duyệt 06', N'ApprovePerson06', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BV')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 78, N'ApprovePerson07', N'Người duyệt 07', N'ApprovePerson07', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BW')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 79, N'ApprovePerson08', N'Người duyệt 08', N'ApprovePerson08', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BX')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 80, N'ApprovePerson09', N'Người duyệt 09', N'ApprovePerson09', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BY')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'OrderRequestPO', N'Yêu cầu mua hàng', N'Order Request PO', N'POF2030', N'Import_Excel_YeuCauMuaHang.xls', N'EXEC POP30022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID =  @ImportTransTypeID, @XML = @XML', 81, N'ApprovePerson10', N'Người duyệt 10', N'ApprovePerson10', 
	N'', 110, 50, 0, N'NVARCHAR(50)', N'', 0, N'BZ')
---------- End Add - Nhật Quang on 23/02/2023: 