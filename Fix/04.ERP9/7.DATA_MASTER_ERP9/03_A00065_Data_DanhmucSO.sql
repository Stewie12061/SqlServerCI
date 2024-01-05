-- <Summary>
---- Template import data: danh mục module SO
-- <History>
---- Create on 21/11/2019 by DungDV
---- Modified on 23/02/2022 by Minh Hiếu 	Update: Thêm Nghiệp vụ mẫu Đơn hàng bán
---- Modified on 16/02/2023 by Viết Toàn 	Update: Loại bỏ kiểm tra tên khách hàng khi hiển thị màn hình import, thêm mã phân tích và tham số
---- Modified on 13/06/2023 by Văn Tài		Update: [2023/06/IS/0006] - Mang phần import Kế hoạch bán hàng vào chuẩn.
---- Modified on 15/12/2023 by Hoàng Long	Update: [2023/12/TA/0125] - Import master data DCard,TCard.
---- <Example>

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF (1=1)
BEGIN 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Danh mục định mức - EDMF1010
DELETE FROM A00065 WHERE ImportTransTypeID = N'PlanSaleList'


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherNo', N'Số chừng từ ', N'VoucherNo', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng,	ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'VoucherDate', N'Ngày chứng từ', N'VoucherDate', 
	N'dd/mm/yyyy', 80, 80, 0, N'VARCHAR(10)', N'{CheckValidPeriod} @Module = ''ASOFT-OP''', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'ObjectID', N'Mã đối tượng', N'ObjectID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Type', N'Phân loại', N'Type', 
	N'', 50, 30, 1, N'TINYINT', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'YearPlan', N'Kế hoạch năm', N'YearPlan', 
	N'', 50, 50, 0, N'INT', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'InventoryID', N'Mã hàng', N'InventoryID', 
	N'', 80, 80, 0, N'VARCHAR(50)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'UnitPrice', N'Đơn giá', N'UnitPrice', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'S01ID', N'Quy cách 1', N'S01ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'S02ID', N'Quy cách 2', N'S02ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'S03ID', N'Quy cách 3', N'S03ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'S04ID', N'Quy cách 4', N'S04ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'S05ID', N'Quy cách 5', N'S05ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'S06ID', N'Quy cách 6', N'S06ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'S07ID', N'Quy cách 7', N'S07ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'S08ID', N'Quy cách 8', N'S08ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'S09ID', N'Quy cách 9', N'S09ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'S10ID', N'Quy cách 10', N'S10ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'S11ID', N'Quy cách 11', N'S11ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'S12ID', N'Quy cách 12', N'S12ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'S13ID', N'Quy cách 13', N'S13ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'S14ID', N'Quy cách 14', N'S14ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'U')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'S15ID', N'Quy cách 15', N'S15ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'V')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'S16ID', N'Quy cách 16', N'S16ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'S17ID', N'Quy cách 17', N'S17ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'X')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'S18ID', N'Quy cách 18', N'S18ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'Y')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'S19ID', N'Quy cách 19', N'S19ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'Z')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, N'S20ID', N'Quy cách 20', N'S20ID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'AA')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 29, N'Quantity1', N'Tháng 1', N'Quantity1', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 30, N'Quantity2', N'Tháng 2', N'Quantity2', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 31, N'Quantity3', N'Tháng 3', N'Quantity3', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 32, N'Quantity4', N'Tháng 4', N'Quantity4', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 33, N'Quantity5', N'Tháng 5', N'Quantity5', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 34, N'Quantity6', N'Tháng 6', N'Quantity6', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 35, N'Quantity7', N'Tháng 7', N'Quantity7', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 36, N'Quantity8', N'Tháng 8', N'Quantity8', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 37, N'Quantity9', N'Tháng 9', N'Quantity9', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 38, N'Quantity10', N'Tháng 10', N'Quantity10', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 39, N'Quantity11', N'Tháng 11', N'Quantity11', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 40, N'Quantity12', N'Tháng 12', N'Quantity12', 
	N'', 50, 50, 0, N'DECIMAL(28, 8)', N'', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PlanSaleList', N'Danh mục kế hoạch bán hàng', N'Salesplan', N'SOF2070', N'Import_Excel_VoucherIDList.xlsx', N' EXEC SOP2074 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 41, N'Note', N'Diễn giải', N'Note', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 0, N'U')

--DÒNG NÀY BỔ SUNG DỮ LIỆU MẶC ĐỊNH KHI MỞ MÀN HÌNH IMPORT
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'PlanSaleList')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('PlanSaleList', N'Danh mục kế hoạch bán hàng', 'PlanSaleList', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_VoucherIDList.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

END

delete A00065 where ImportTransTypeID = 'SalesOrders' 
	----------------------- Nghiệp vụ mẫu Đơn hàng bán ----------------------- 
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'SalesOrders')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('SalesOrders', N'Đơn hàng bán', 'SalesOrders', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DonHangBan.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

BEGIN 
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N' EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'A')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 2, N'VoucherNo', N'Phiếu số', N'VoucherNo', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'B')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 3, N'OrderDate', N'Ngày đơn hàng', N'OrderDate', 
	N'', 80, 50, 2, N'datetime', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 4, N'ContractNo', N'Số hợp đồng', N'ContractNo', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 5, N'ContractDate', N'Ngày ký hợp đồng', N'ContractDate', 
	N'', 80, 50, 2, N'datetime', N'', 1, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 6, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 7, N'ExchangeRate', N'Tỷ giá', N'ExchangeRate', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 1, N'G')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 8, N'OrderStatus', N'Tình trạng đơn hàng', N'OrderStatus', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 9, N'ShipDate', N'Ngày giao hàng', N'ShipDate', 
	N'', 80, 50, 2, N'datetime', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 10, N'ClassifyID', N'Phân loại đơn hàng', N'ClassifyID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 11, N'InventoryTypeID', N'Loại mặt hàng', N'InventoryTypeID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 12, N'ObjectID', N'Khách hàng', N'ObjectID', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 1, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 13, N'Contact', N'Người liên hệ', N'Contact', 
	N'', 110, 50, 0, N'nvarchar(100)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 14, N'DeliveryAddress', N'Địa chỉ giao hàng', N'DeliveryAddress', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 15, N'Transport', N'Phương thức vận chuyển', N'Transport', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 16, N'PriceListID', N'Bảng giá', N'PriceListID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 17, N'DueDate', N'Ngày đáo hạn', N'DueDate', 
	N'', 80, 50, 2, N'datetime', N'', 1, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 18, N'PaymentID', N'Phương thức thanh toán', N'PaymentID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 19, N'PaymentTermID', N'Điều khoản thanh toán', N'PaymentTermID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 20, N'Notes', N'Ghi chú', N'Notes', 
	N'', 110, 50, 0, N'nvarchar(500)', N'', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 21, N'ApprovePerson01', N'Người duyệt', N'ApprovePerson01', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 22, N'EmployeeID', N'Người theo dõi', N'EmployeeID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 23, N'SalesManID', N'Người bán hàng', N'SalesManID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 24, N'InventoryID', N'Mã hàng', N'InventoryID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 25, N'BarCode', N'BarCode', N'BarCode', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 26, N'OrderQuantity', N'Số lượng', N'OrderQuantity', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 27, N'UnitID', N'Đơn vị tính', N'UnitID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 28, N'SalePrice', N'Đơn giá', N'SalePrice', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 29, N'VATPercent', N'% Thuế VAT', N'VATPercent', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 30, N'VATOriginalAmount', N'Thuế VAT', N'VATOriginalAmount', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 31, N'VATGroupID', N'Nhóm thuế', N'VATGroupID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AE')

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrders', N'Đơn hàng bán', N'SalesOrders', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20007 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 32, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 50, 0, N'nvarchar(500)', N'', 0, N'AF')

END

delete A00065 where ImportTransTypeID = N'SalesOrdersERP9'

	----------------------- Nghiệp vụ mẫu Đơn hàng bán ERP9 ----------------------- 
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'SalesOrdersERP9')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('SalesOrdersERP9', N'Đơn hàng bán', 'SalesOrdersERP9', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DonHangBan.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N' EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'VoucherTypeID', N'Loại chứng từ', N'VoucherTypeID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 2, N'VoucherNo', N'Phiếu số', N'VoucherNo', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'B')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 3, N'OrderDate', N'Ngày đơn hàng', N'OrderDate', 
	N'', 80, 50, 2, N'datetime', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 4, N'ContractNo', N'Số hợp đồng', N'ContractNo', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 5, N'ContractDate', N'Ngày ký hợp đồng', N'ContractDate', 
	N'', 80, 50, 2, N'datetime', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 6, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 7, N'ExchangeRate', N'Tỷ giá', N'ExchangeRate', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 1, N'G')


INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 8, N'OrderStatus', N'Tình trạng đơn hàng', N'OrderStatus', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 9, N'ShipDate', N'Ngày giao hàng', N'ShipDate', 
	N'', 80, 50, 2, N'datetime', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 10, N'ClassifyID', N'Phân loại đơn hàng', N'ClassifyID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 11, N'InventoryTypeID', N'Loại mặt hàng', N'InventoryTypeID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 12, N'ObjectID', N'Khách hàng', N'ObjectID', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 1, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 12, N'ObjectName', N'Khách hàng', N'ObjectName', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 13, N'Contact', N'Người liên hệ', N'Contact', 
	N'', 110, 50, 0, N'nvarchar(100)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 14, N'DeliveryAddress', N'Địa chỉ giao hàng', N'DeliveryAddress', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 15, N'Transport', N'Phương thức vận chuyển', N'Transport', 
	N'', 110, 50, 0, N'nvarchar(250)', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 16, N'PriceListID', N'Bảng giá', N'PriceListID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 17, N'DueDate', N'Ngày đáo hạn', N'DueDate', 
	N'', 80, 50, 2, N'datetime', N'', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 18, N'PaymentID', N'Phương thức thanh toán', N'PaymentID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 19, N'PaymentTermID', N'Điều khoản thanh toán', N'PaymentTermID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 20, N'Notes', N'Ghi chú', N'Notes', 
	N'', 110, 50, 0, N'nvarchar(500)', N'', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 21, N'ApprovePerson01', N'Người duyệt', N'ApprovePerson01', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 22, N'EmployeeID', N'Người theo dõi', N'EmployeeID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 23, N'SalesManID', N'Người bán hàng', N'SalesManID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 24, N'InventoryID', N'Mã hàng', N'InventoryID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 25, N'BarCode', N'BarCode', N'BarCode', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 26, N'OrderQuantity', N'Số lượng', N'OrderQuantity', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 27, N'UnitID', N'Đơn vị tính', N'UnitID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 28, N'SalePrice', N'Đơn giá', N'SalePrice', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 29, N'VATPercent', N'% Thuế VAT', N'VATPercent', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 30, N'VATOriginalAmount', N'Thuế VAT', N'VATOriginalAmount', 
	N'', 80, 50, 1, N'decimal(28, 8)', N'', 0, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 31, N'VATGroupID', N'Nhóm thuế', N'VATGroupID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 32, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 50, 0, N'nvarchar(500)', N'', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 33, N'Ana01ID', N'Mã phân tích 01', N'Ana01ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 34, N'Ana02ID', N'Mã phân tích 02', N'Ana02ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 35, N'Ana03ID', N'Mã phân tích 03', N'Ana03ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 36, N'Ana04ID', N'Mã phân tích 04', N'Ana04ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 37, N'Ana05ID', N'Mã phân tích 05', N'Ana05ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 38, N'Ana06ID', N'Mã phân tích 06', N'Ana06ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 39, N'Ana07ID', N'Mã phân tích 07', N'Ana07ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 40, N'Ana08ID', N'Mã phân tích 08', N'Ana08ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 41, N'Ana09ID', N'Mã phân tích 09', N'Ana09ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 42, N'Ana10ID', N'Mã phân tích 10', N'Ana10ID', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AQ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 44, N'nvarchar01', N'Tham số 01', N'nvarchar01', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AR')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 45, N'nvarchar02', N'Tham số 02', N'nvarchar02', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AS')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 46, N'nvarchar03', N'Tham số 03', N'nvarchar03', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AT')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 47, N'nvarchar04', N'Tham số 04', N'nvarchar04', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AU')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 48, N'nvarchar05', N'Tham số 05', N'nvarchar05', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AV')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SalesOrdersERP9', N'Đơn hàng bán', N'SalesOrdersERP9', N'SOF2000', N'Import_Excel_DonHangBan.xlsx', N'EXEC SOP20009 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 49, N'nvarchar06', N'Tham số 06', N'nvarchar06', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AW')

----------------------------------------------------------- Danh mục Tài khoản kích hoạt -----------------------------------------------------------
DELETE FROM A01065 WHERE ImportTemplateID = 'ActiveAccount'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ActiveAccount')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('ActiveAccount', N'Mẫu danh mục tài khoản kích hoạt', 'ActiveAccount', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_TaiKhoanKichHoat.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

DELETE FROM A00065 WHERE ImportTransTypeID = N'ActiveAccount'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N' EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 1, N'AccountNo', N'Tài khoản kích hoạt', N'AccountNo', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 2, N'AccountName', N'Tên tài khoản kích hoạt', N'AccountName', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 3, N'Tel', N'SĐT đăng ký', N'Tel', 
	N'', 80, 50, 0, N'nvarchar(10)', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 4, N'Type', N'T-card', N'Type', 
	N'', 80, 50, 0, N'INT', N'', 1, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 5, N'AccountType', N'Loại tài khoản đăng ký', N'AccountType', 
	N'', 80, 50, 0, N'INT', N'', 1, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 6, N'CCCD', N'CCCD/CMND', N'CCCD', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 7, N'BirthDay', N'Ngày sinh', N'BirthDay', 
	N'', 80, 50, 0, N'Date', N'', 1, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 8, N'Address', N'Địa chỉ', N'Address', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 9, N'Province', N'Tỉnh thành', N'Province', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 10, N'District', N'Quận/Huyện', N'District', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 11, N'MstNumber', N'MST cá nhân', N'MstNumber', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 12, N'Region', N'Vùng', N'Region', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 13, N'AccountDate', N'Ngày mở tài khoản', N'AccountDate', 
	N'', 80, 50, 0, N'Date', N'', 1, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 14, N'Status', N'Trạng thái tài khoản', N'Status', 
	N'', 80, 50, 0, N'INT', N'', 1, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 15, N'CompanyName', N'Tên doanh nghiệp', N'CompanyName', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 16, N'Representative', N'Người đại diện', N'Representative', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 17, N'MstCompany', N'MST doanh nghiệp', N'MstCompany', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 18, N'ApartmentCompany', N'Số nhà', N'ApartmentCompany', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 19, N'RoadCompany', N'Đường', N'RoadCompany', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 20, N'WardCompany', N'Phường/Xã', N'WardCompany', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 21, N'DistrictCompany', N'Phường/Xã', N'DistrictCompany', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 22, N'ProvinceCompany', N'Tỉnh/TP', N'ProvinceCompany', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 23, N'ApartmentShop', N'Số nhà', N'ApartmentShop', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 24, N'RoadShop', N'Đường', N'RoadShop', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 25, N'WardShop', N'Phường/Xã', N'WardShop', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 26, N'DistrictShop', N'Quận/Huyện', N'DistrictShop', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 27, N'ProvinceShop', N'Tỉnh/TP', N'ProvinceShop', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 28, N'EmailShop', N'Địa chỉ email xuất HDĐT', N'EmailShop', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 1, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 29, N'TypeStore', N'Loại hình cửa hàng', N'TypeStore', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 30, N'AreaStore', N'Diện tích shop (m2)', N'AreaStore', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 31, N'TotalRevenue', N'TỔNG DOANH THU VND/NĂM', N'TotalRevenue', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 32, N'AirConditionerSales', N'DOANH SỐ ĐIỀU HÒA BỘ/NĂM', N'AirConditionerSales', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 33, N'CustomerClassification', N'XẾP LOẠI KHÁCH HÀNG BỘ/NĂM', N'CustomerClassification', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 34, N'FinancialCapacity', N'XẾP LOẠI KHÁCH HÀNG', N'FinancialCapacity', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 35, N'StrongSelling1', N'THƯƠNG HIỆU BÁN MẠNH NHẤT', N'StrongSelling1', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AI')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 36, N'StrongSelling2', N'THƯƠNG HIỆU BÁN MẠNH NHẤT 2', N'StrongSelling2', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AJ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 37, N'StrongSelling3', N'THƯƠNG HIỆU BÁN MẠNH NHẤT 3', N'StrongSelling3', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AK')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 38, N'ImportSource1', N'NGUỒN NHẬP HÀNG ĐIỀU HÒA 1', N'ImportSource1', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AL')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 39, N'ImportSource2', N'NGUỒN NHẬP HÀNG ĐIỀU HÒA 2', N'ImportSource2', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AM')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 40, N'ImportSource3', N'NGUỒN NHẬP HÀNG ĐIỀU HÒA 3', N'ImportSource3', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AN')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 41, N'SellGree', N'BÁN GREE', N'SellGree', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AO')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 42, N'GreeDisplay', N'TRƯNG BÀY GREE', N'GreeDisplay', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AP')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 43, N'SellingCapacity', N'NĂNG LỰC BÁN GREE (SL bộ/ năm)', N'SellingCapacity', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AQ')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActiveAccount', N'Danh mục tài khoản kích hoạt', N'ActiveAccount', N'SOF2200', N'Import_Excel_TaiKhoanKichHoat.xlsx', N'EXEC SOP22000 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @ImportTransTypeID = @ImportTransTypeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @XML = @XML', 44, N'ClassificationCustomer', N'XẾP LOẠI KHÁCH HÀNG GREE', N'ClassificationCustomer', 
	N'', 80, 50, 0, N'nvarchar(50)', N'', 0, N'AR')


----------------------------------------------------------- Danh mục chỉ tiêu doanh số nhân viên bán sỉ (Sale In) -----------------------------------------------------------
DELETE FROM A00065 WHERE ImportTransTypeID = N'EmployeeSalesTarget1'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 2, N'FromDate', N'Từ ngày ', N'FromDate', 
	N'mm/dd/yyyy', 80, 50, 0, N'DATE', N'{} @Module = ''ASOFT-OP''', 1, N'B4')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 3, N'ToDate', N'Đến ngày', N'ToDate', 
	N'mm/dd/yyyy', 80, 80, 0, N'DATE', N'{} @Module = ''ASOFT-OP''', 1, N'D4')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 4, N'TargetsID', N'Mã số', N'TargetsID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'B5')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 5, N'Description', N'Diễn giải', N'Description', 
	N'', 50, 50, 0, N'VARCHAR(250)', N'', 0, N'D5')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 6, N'ObjectID', N'Đối tượng', N'ObjectID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 1, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 7, N'EmployeeLevel', N'Cấp nhân viên', N'EmployeeLevel', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 8, N'EmployeeID', N'Mã nhân viên', N'EmployeeID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 9, N'DepartmentID', N'Phòng ban', N'DepartmentID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 10, N'TeamID', N'Tổ nhóm', N'TeamID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 11, N'InventoryTypeID', N'Mã nhóm hàng (MPT 8)', N'InventoryTypeID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 12, N'InventoryTypeID2', N'Mã nhóm hàng (MPT 4)', N'InventoryTypeID2', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 13, N'SalesMonth', N'Doanh số tháng', N'SalesMonth', 
	N'', 50, 50, 1, N'DECIMAL(28,8)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 14, N'SalesQuarter', N'Doanh số quý', N'SalesQuarter', 
	N'', 50, 50, 1, N'DECIMAL(28,8)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 15, N'SalesYear', N'Doanh số năm', N'SalesYear', 
	N'', 50, 50, 1, N'DECIMAL(28,8)', N'', 1, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng,	ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng,
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 16, N'S01', N'SA - PG', N'S01', 
	N'', 80, 80, 0, N'VARCHAR(50)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 17, N'S02', N'SUP', N'S02', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 18, N'S03', N'ASM', N'S03', 
	N'', 50, 30, 0,  N'VARCHAR(50)', N'', 0, N'M')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 19, N'S04', N'RSM', N'S04', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'EmployeeSalesTarget1', N'Chỉ tiêu doanh số nhân viên Sell In', N'EmployeeSalesTarget1', N'SOF1060', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', N'EXEC SOP10604 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 20, N'S05', N'SD', N'S05', 
	N'', 50, 50, 0,  N'VARCHAR(50)', N'', 0, N'O')


DELETE FROM A01065 WHERE ImportTransTypeID = N'EmployeeSalesTarget2'

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'EmployeeSalesTarget2')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('EmployeeSalesTarget2', N'Chỉ tiêu doanh số nhân viên Sell In', 'EmployeeSalesTarget1', 'Data', N'A', 10, N'D:\IMPORTS', N'Import_Excel_ChiTieuDoanhSoNV1.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END