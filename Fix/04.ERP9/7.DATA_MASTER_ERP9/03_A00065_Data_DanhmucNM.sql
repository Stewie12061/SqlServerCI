-- <Summary>
---- Template import data: danh mục module NM
-- <History>
---- Create on 25/08/2018 by Trà Giang 
---- Modified on ... by ...
---- <Example>

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 91
BEGIN

---- Danh mục định mức dinh dưỡng

DELETE FROM A00065 WHERE ImportTransTypeID = N'QuotaNutritionType'

	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'QuotaNutritionID', N'Mã định mức', N'QuotaNutritionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'QuotaNutritionName', N'Tên định mức', N'QuotaNutritionName', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'MenuTypeID', N'Nhóm thực đơn', N'MenuTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 50, 0, N'TINYINT', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'SystemID', N'Thành phần dinh dưỡng', N'SystemID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'QuotaStandard', N'Định mức chuẩn', N'QuotaStandard', 
	N'', 50, 30, 1, N'DECIMAL(28,8)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'MinRatio', N'Tỷ lệ đạt thấp nhất', N'MinRatio', 
	N'', 50, 30, 1, N'DECIMAL(28,8)', N'', 1, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaNutritionType', N'Danh mục định mức', N'QuotaNutritionType', N'NMF1030', N'Import_Excel_DanhmucDinhMucDinhDuong', N' EXEC NMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'MaxRatio', N'Tỷ lệ đạt cao nhất', N'MaxRatio', 
	N'', 50, 30, 1, N'DECIMAL(28,8)', N'', 1, N'I')


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'QuotaNutritionType')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('QuotaNutritionType', N'Danh mục định mức', 'QuotaNutritionType', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhmucDinhMucDinhDuong.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


	----Danh mục nhóm thực phẩm
	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'MaterialsType')
BEGIN
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialsType', N'Danh mục nhóm thực phẩm', N'MaterialsType', N'NMF1000', N'Import_Excel_DanhMucNhomThucPham.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialsType', N'Danh mục nhóm thực phẩm', N'MaterialsType', N'NMF1000', N'Import_Excel_DanhMucNhomThucPham.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'MaterialsTypeID', N'Mã nhóm thực phẩm', N'MaterialsTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialsType', N'Danh mục nhóm thực phẩm', N'MaterialsType', N'NMF1000', N'Import_Excel_DanhMucNhomThucPham.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MaterialsTypeName', N'Tên nhóm thực phẩm', N'MaterialsTypeName', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialsType', N'Danh mục nhóm thực phẩm', N'MaterialsType', N'NMF1000', N'Import_Excel_DanhMucNhomThucPham.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 50, 0, N'VARCHAR(250)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MaterialsType', N'Danh mục nhóm thực phẩm', N'MaterialsType', N'NMF1000', N'Import_Excel_DanhMucNhomThucPham.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 50, 0, N'TINYINT', N'', 1, N'D')
	END
	IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'MaterialsType')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('MaterialsType', N'Danh mục nhóm thực phẩm', 'MaterialsType', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhMucNhomThucPham.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END
	---- Danh mục thực phẩm
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Materials')
BEGIN
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'MaterialsID', N'Mã thực phẩm', N'MaterialsID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MaterialsTypeID', N'Nhóm thực phẩm', N'MaterialsTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1000'', @Param2 = ''GradeID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'Description', N'Ghi chú ', N'Description', 
	N'', 110, 50, 0, N'VARCHAR(250)', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'MPT01', N'Mã phân tích 01', N'MPT01', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'MPT02', N'Mã phân tích 02', N'MPT02', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'MPT03', N'Mã phân tích 03', N'MPT03', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'MPT04', N'Mã phân tích 04', N'MPT04', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'MPT05', N'Mã phân tích 05', N'MPT05', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'MPT06', N'Mã phân tích 06', N'MPT06', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'MPT07', N'Mã phân tích 07', N'MPT07', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'MPT08', N'Mã phân tích 08', N'MPT08', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'MPT09', N'Mã phân tích 09', N'MPT09', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'MPT10', N'Mã phân tích 10', N'MPT10', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'MPT11', N'Mã phân tích 11', N'MPT11', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'MPT12', N'Mã phân tích 12', N'MPT12', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'MPT13', N'Mã phân tích 13', N'MPT13', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'MPT14', N'Mã phân tích 14', N'MPT14', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'MPT15', N'Mã phân tích 15', N'MPT15', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'MPT16', N'Mã phân tích 16', N'MPT16', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'MPT17', N'Mã phân tích 17', N'MPT17', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'MPT18', N'Mã phân tích 18', N'MPT18', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'MPT19', N'Mã phân tích 19', N'MPT19', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'U')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Materials', N'Danh mục thực phẩm', N'Materials', N'NMF1010', N'Import_Excel_DanhmucThucPham.xls', N' EXEC NMP1012 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'MPT20', N'Mã phân tích 20', N'MPT20', 
	N'', 50, 30, 0, N'DECIMAL(28,8)', N'', 0, N'V')


	
END


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Materials')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Materials', N'Danh mục thực phẩm', 'Materials', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhMucThucPham.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END
	---- Danh mục nhóm thực đơn
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'MenuType')
BEGIN
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MenuType', N'Danh mục nhóm thực đơn', N'MenuType', N'NMF1020', N'Import_Excel_DanhmucNhomThucDon.xls', N' EXEC NMP1022 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MenuType', N'Danh mục nhóm thực đơn', N'MenuType', N'NMF1020', N'Import_Excel_DanhmucNhomThucDon.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'MenuTypeID', N'Mã nhóm thực đơn', N'MenuTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MenuType', N'Danh mục nhóm thực đơn', N'MenuType', N'NMF1020', N'Import_Excel_DanhmucNhomThucDon.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MenuTypeName', N'Tên nhóm thực đơn', N'MenuTypeName', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MenuType', N'Danh mục nhóm thực đơn', N'MenuType', N'NMF1020', N'Import_Excel_DanhmucNhomThucDon.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'GradeLevelID', N'Khối', N'GradeLevelID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MenuType', N'Danh mục nhóm thực đơn', N'MenuType', N'NMF1020', N'Import_Excel_DanhmucNhomThucDon.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Description', N'Ghi chú', N'Description', 
	N'', 110, 50, 0, N'VARCHAR(250)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'MenuType', N'Danh mục nhóm thực đơn', N'MenuType', N'NMF1020', N'Import_Excel_DanhmucNhomThucDon.xls', N' EXEC NMP1002 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'IsCommon', N'Dùng chung ', N'IsCommon', 
	N'', 50, 30, 1, N'VARCHAR(250)', N'', 0, N'E')
END
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'MenuType')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('MenuType', N'Danh mục nhóm thực đơn', 'MenuType', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhmucNhomThucDon.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

	---- Danh mục loại món ăn
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'DishType')
BEGIN
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DishType', N'Danh mục  loại món ăn', N'DishType', N'NMF1040', N'Import_Excel_DanhmucLoaiMonAn.xls', N' EXEC NMP1042 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DishType', N'Danh mục  loại món ăn', N'DishType', N'NMF1040', N'Import_Excel_DanhmucLoaiMonAn.xls', N' EXEC NMP1042 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'DishTypeID', N'Mã loại món ăn', N'DishTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DishType', N'Danh mục  loại món ăn', N'DishType', N'NMF1040', N'Import_Excel_DanhmucLoaiMonAn.xls', N' EXEC NMP1042 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'DishTypeName', N'Tên loại món ăn', N'DishTypeName', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DishType', N'Danh mục  loại món ăn', N'DishType', N'NMF1040', N'Import_Excel_DanhmucLoaiMonAn.xls', N' EXEC NMP1042 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'Description', N'Ghi chú ', N'Description', 
	N'', 110, 50, 0, N'VARCHAR(250)', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DishType', N'Danh mục  loại món ăn', N'DishType', N'NMF1040', N'Import_Excel_DanhmucLoaiMonAn.xls', N' EXEC NMP1042 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 50, 1, N'TINYINT', N'', 0, N'D')
END
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'DishType')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('DishType', N'Danh mục  loại món ăn', 'DishType', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhmucLoaiMonAn.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END
---- Danh mục món ăn
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Dish')
BEGIN

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'DishID', N'Mã món ăn', N'DishID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'DishName', N'Tên món ăn', N'DishName', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'DishTypeID', N'Tên loại món ăn', N'DishTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1000'', @Param2 = ''GradeID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Description', N'Ghi chú ', N'Description', 
	N'', 110, 50, 0, N'VARCHAR(250)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 50, 1, N'TINYINT', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'MaterialsID', N'Nguyên liệu', N'MaterialsID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'UnitID', N'Đơn vị tính', N'UnitID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Mass', N'Khối lượng', N'Mass', 
	N'', 50, 50, 1, N' DECIMAL(28,8)', N'', 1, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Dish', N'Danh mục món ăn', N'Dish', N'NMF1050', N'Import_Excel_DanhmucMonAn.xls', N' EXEC NMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'ConvertedMass', N'Khối lượng quy đổi', N'ConvertedMass', 
	N'', 50, 50, 1, N' DECIMAL(28,8)', N'', 0, N'I')

	END
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Dish')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Dish', N'Danh mục món ăn', 'Dish', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhmucMonAn.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END
---- Danh mục bữa ăn
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Meal')
BEGIN
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Meal', N'Danh mục  bữa ăn', N'Meal', N'NMF1060', N'Import_Excel_DanhmucBuaAn.xls', N' EXEC NMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Meal', N'Danh mục  bữa ăn', N'Meal', N'NMF1060', N'Import_Excel_DanhmucBuaAn.xls', N' EXEC NMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'MealID', N'Mã bữa ăn', N'MealID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckIdenticalValues}', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Meal', N'Danh mục  bữa ăn', N'Meal', N'NMF1060', N'Import_Excel_DanhmucBuaAn.xls', N' EXEC NMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'MealName', N'Tên bữa ăn', N'MealName', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Meal', N'Danh mục  bữa ăn', N'Meal', N'NMF1060', N'Import_Excel_DanhmucBuaAn.xls', N' EXEC NMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'Description', N'Ghi chú ', N'Description', 
	N'', 110, 50, 0, N'VARCHAR(250)', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Meal', N'Danh mục  bữa ăn', N'Meal', N'NMF1060', N'Import_Excel_DanhmucBuaAn.xls', N' EXEC NMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 50, 1, N'TINYINT', N'', 0, N'D')

	END
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Meal')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Meal', N'Danh mục  bữa ăn', 'Meal', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhmucBuaAn.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

END
ELSE IF @CustomerName != 91
BEGIN 

BEGIN 
delete from A00065 WHERE ImportTransTypeID IN ('QuotaNutritionType','MaterialsType','Meal','Dish','DishType','MenuType','Materials')

delete from A01065 WHERE ImportTemplateID IN ('QuotaNutritionType','MaterialsType','Meal','Dish','DishType','MenuType','Materials')
END 

END 