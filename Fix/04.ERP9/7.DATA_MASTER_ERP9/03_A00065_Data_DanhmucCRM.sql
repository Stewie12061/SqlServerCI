-- <Summary>
---- Template import data: danh mục module CRM
-- <History>
---- Create on 11/03/2020 by Kiều Nga 
---- Modified on 24/07/2023 by Viết Toàn: Điều chỉnh độ rộng cột DeliveryAddress
---- <Example>

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 117 


BEGIN 
---- Yêu cầu khách hàng
DELETE FROM A00065 WHERE ImportTransTypeID = N'CustomerRequirements'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B4')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'VoucherNo', N'Số phiếu yêu cầu', N'VoucherNo', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'VoucherDate', N'Ngày yêu cầu', N'VoucherDate', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidPeriod} @Module = ''ASOFT-OP''', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'ObjectID', N'Khách hàng', N'ObjectID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'DeliveryAddress', N'Địa điểm giao hàng', N'DeliveryAddress', 
	N'', 80, 50, 0, N'VARCHAR(250)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'InventoryID', N'Sản phẩm', N'InventoryID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'PaperTypeID', N'Loại sản phẩm', N'PaperTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'MarketID', N'Mã market', N'MarketID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'ActualQuantity', N'Số lượng', N'ActualQuantity', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'ColorPrint01', N'Số màu in mặt 1', N'ColorPrint01', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'ColorPrint02', N'Số màu in mặt 2', N'ColorPrint02', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'Length', N'Kích thước dài', N'Length', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'Width', N'Kích thước rộng', N'Width', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'Height', N'Kích thước cao', N'Height', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'PrintSize', N'Khổ khổ in', N'PrintSize', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'CutSize', N'Cắt khổ in', N'CutSize', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'LengthPaper', N'Dài khổ giấy', N'LengthPaper', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'WithPaper', N'Dài khổ giấy', N'WithPaper', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'ProductQuality', N'Chất lượng sản phẩm', N'ProductQuality', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'TransportAmount', N'Phí vận chuyển', N'TransportAmount', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'InvenPrintSheet', N'Số SP / tờ in', N'InvenPrintSheet', 
	N'', 80, 50, 0, N'VARCHAR(25)', N'', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'InvenMold', N'Số SP / tờ khuôn', N'InvenMold', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'Pack', N'Đóng gói', N'Pack', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'OffsetPaper', N'Giấy OFFSET', N'OffsetPaper', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'PrintNumber', N'Cách in', N'PrintNumber', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'FilmDate', N'Ngày xuất phim', N'FilmDate', 
	N'', 80, 50, 0, N'DateTime', N'', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, N'LengthFilm', N'Dài khổ phim', N'LengthFilm', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 29, N'WidthFilm', N'Rộng khổ phim', N'WidthFilm', 
	N'', 80, 50, 1, N'DECIMAL(28,8)', N'', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 30, N'StatusFilm', N'Tình trạng phim', N'StatusFilm', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 31, N'StatusMold', N'Tình trạng khuôn', N'StatusMold', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AC')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 32, N'Structure1', N'Cấu trúc 01', N'Structure01', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 33, N'Structure2', N'Cấu trúc 02', N'Structure02', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 34, N'Structure3', N'Cấu trúc 03', N'Structure03', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 35, N'Structure4', N'Cấu trúc 04', N'Structure04', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 36, N'Structure5', N'Cấu trúc 05', N'Structure05', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 37, N'Structure6', N'Cấu trúc 06', N'Structure06', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 38, N'Structure7', N'Cấu trúc 07', N'Structure07', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 39, N'Structure8', N'Cấu trúc 08', N'Structure08', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 40, N'Structure9', N'Cấu trúc 09', N'Structure09', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'CustomerRequirements', N'Yêu cầu khách hàng', N'Customer Requirements', N'CRMF2100', N'Import_Excel_CustomerRequirements.xlsx', N' EXEC CRMP21002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 41, N'Structure10', N'Cấu trúc 10', N'Structure10', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AM')

--DÒNG NÀY BỔ SUNG DỮ LIỆU MẶC ĐỊNH KHI MỞ MÀN HÌNH IMPORT
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'CustomerRequirements')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('CustomerRequirements', N'Yêu cầu khách hàng', 'CustomerRequirements', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_CustomerRequirements.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

---Yêu cầu từ khách hàng
DELETE FROM A00065 WHERE ImportTransTypeID = N'RequestFromCustomer'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'RequestCustomerID', N'Mã yêu cầu', N'RequestCustomerID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'RequestSubject', N'Chủ đề yêu cầu', N'RequestSubject', 
	N'', 80, 4000, 0, N'nvarchar(4000)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'RelatedToID', N'Khách hàng ', N'RelatedToID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'RequestStatus', N'Trạng thái ', N'RequestStatus', 
	N'', 80, 50, 1, N'int', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'PriorityID', N'Độ ưu tiên ', N'PriorityID', 
	N'', 80, 50, 1, N'int', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'RequestDescription', N'Nội dung', N'RequestDescription', 
	N'', 80, 4000, 0, N'nvarchar(4000)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'TimeRequest', N'Thời gian ghi nhận ', N'TimeRequest', 
	N'dd/mm/yyyy', 80, 50, 0, N'nvarchar(50)', N'', 1, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DeadlineRequest', N'Thời hạn xử lý', N'DeadlineRequest', 
	N'dd/mm/yyyy', 80, 50, 0, N'nvarchar(50)', N'', 1, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'AssignedToUserID', N'Người phụ trách', N'AssignedToUserID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'OpportunityID', N'Mã cơ hội ', N'OpportunityID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'FeedbackDescription', N'Phản hồi', N'FeedbackDescription', 
	N'', 80, 4000, 0, N'nvarchar(4000)', N'', 0, N'L')

--DÒNG NÀY BỔ SUNG DỮ LIỆU MẶC ĐỊNH KHI MỞ MÀN HÌNH IMPORT
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'RequestFromCustomer')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('RequestFromCustomer', N'Yêu cầu từ khách hàng', 'RequestFromCustomer', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_RequestFromCustomer.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

END

-- 30/11/2020 - [Tấn Lộc] - Bổ sung import danh sách người nhận mail
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'RecipientEmail')
BEGIN
	-- Param insert
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol,
	StartRow, DataFolder, DefaultFileName, [Disabled], CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	-- Values insert
	VALUES ('RecipientEmail', N'Người nhận email', 'RecipientEmail', 'Data', N'A',
	10, N'C:\IMPORTS', N'CRMT10302.xlsx', 0, 'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'RecipientEmail'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
	N'', 110, 250, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'GroupReceiverID', N'Mã nhóm nhận mail', N'GroupReceiverID', 
	N'', 110, 250, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT10301'', @Param2 = ''GroupReceiverID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Prefix', N'Xưng hô', N'Prefix', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'FirstName', N'Họ và tên đệm', N'FirstName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'LastName', N'Tên', N'LastName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ReceiverName', N'Tên người nhận mail', N'ReceiverName', 
	N'', 110, 4000, 0, N'NVARCHAR(MAX)', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'Email', N'Email', N'Email', 
	N'', 110, 4000, 0, N'NVARCHAR(MAX)', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'Address', N'Địa chỉ', N'Address', 
	N'', 110, 4000, 0, N'NVARCHAR(MAX)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RecipientEmail', N'Người nhận email', N'RecipientEmail', N'CRMF1030', N'CRMT10302.xlsx', N'EXEC CRMP10304 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Mobile', N'Điện thoại', N'Mobile', 
	N'', 110, 250, 0, N'VARCHAR(250)', N'', 0, N'H')

---Yêu cầu từ khách hàng
DELETE FROM A00065 WHERE ImportTransTypeID = N'RequestFromCustomer'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'RequestCustomerID', N'Mã yêu cầu', N'RequestCustomerID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'RequestSubject', N'Chủ đề yêu cầu', N'RequestSubject', 
	N'', 80, 4000, 0, N'nvarchar(4000)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'RelatedToID', N'Khách hàng ', N'RelatedToID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'RequestStatus', N'Trạng thái ', N'RequestStatus', 
	N'', 80, 50, 1, N'int', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'PriorityID', N'Độ ưu tiên ', N'PriorityID', 
	N'', 80, 50, 1, N'int', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'RequestDescription', N'Nội dung', N'RequestDescription', 
	N'', 80, 4000, 0, N'nvarchar(4000)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'TimeRequest', N'Thời gian ghi nhận ', N'TimeRequest', 
	N'dd/mm/yyyy', 80, 50, 0, N'nvarchar(50)', N'', 1, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DeadlineRequest', N'Thời hạn xử lý', N'DeadlineRequest', 
	N'dd/mm/yyyy', 80, 50, 0, N'nvarchar(50)', N'', 1, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'AssignedToUserID', N'Người phụ trách', N'AssignedToUserID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'OpportunityID', N'Mã cơ hội ', N'OpportunityID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'RequestFromCustomer', N'Yêu cầu từ khách hàng', N'RequestFromCustomer', N'CRMF2080', N'Import_Excel_RequestFromCustomer.xlsx', N'EXEC CRMP20804 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'FeedbackDescription', N'Phản hồi', N'FeedbackDescription', 
	N'', 80, 4000, 0, N'nvarchar(4000)', N'', 0, N'L')

--DÒNG NÀY BỔ SUNG DỮ LIỆU MẶC ĐỊNH KHI MỞ MÀN HÌNH IMPORT
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'RequestFromCustomer')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('RequestFromCustomer', N'Yêu cầu từ khách hàng', 'RequestFromCustomer', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_RequestFromCustomer.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END
