-- <Summary>
---- Template import data: danh mục module EDM
-- <History>
---- Create on 25/08/2018 by Hồng Thảo 
---- Modified on ... by ...
---- <Example>

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 91


BEGIN 
---- Danh mục khối
DELETE FROM A00065 WHERE ImportTransTypeID = N'Grade'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Grade', N'Danh mục khối', N'Grade', N'EMDF1000', N'Import_Excel_Danhmuckhoi.xls', N' EXEC EDMP1003 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Grade', N'Danh mục khối', N'Grade', N'EMDF1000', N'Import_Excel_Danhmuckhoi.xls', N' EXEC EDMP1003 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'LevelID', N'Cấp', N'Level', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Level'''' ''', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Grade', N'Danh mục khối', N'Grade', N'EMDF1000', N'Import_Excel_Danhmuckhoi.xls', N' EXEC EDMP1003 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'GradeID', N'Mã khối', N'GradeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Grade', N'Danh mục khối', N'Grade', N'EMDF1000', N'Import_Excel_Danhmuckhoi.xls', N' EXEC EDMP1003 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'GradeName', N'Tên khối', N'GradeName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Grade', N'Danh mục khối', N'Grade', N'EMDF1000', N'Import_Excel_Danhmuckhoi.xls', N' EXEC EDMP1003 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Notes', N'Ghi chú', N'Notes', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Grade', N'Danh mục khối', N'Grade', N'EMDF1000', N'Import_Excel_Danhmuckhoi.xls', N' EXEC EDMP1003 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'E')

	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Grade')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Grade', N'Danh mục khối', 'Grade', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmuckhoi.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Danh mục định mức - EDMF1010
DELETE FROM A00065 WHERE ImportTransTypeID = N'QuotaList'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaList', N'Danh mục dinh muc', N'QuotaList', N'EDMF1010', N'Import_Excel_QuotaIDList.xlsx', N' EXEC EDMP1014 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaList', N'Danh mục dinh muc', N'QuotaList', N'EDMF1010', N'Import_Excel_QuotaIDList.xlsx', N' EXEC EDMP1014 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'QuotaID', N'Mã định mức', N'QuotaID123', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaList', N'Danh mục dinh muc', N'QuotaList', N'EDMF1010', N'Import_Excel_QuotaIDList.xlsx', N' EXEC EDMP1014 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'Description', N'Diễn giải', N'Description', 
	N'', 250, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaList', N'Danh mục dinh muc', N'QuotaList', N'EDMF1010', N'Import_Excel_QuotaIDList.xlsx', N' EXEC EDMP1014 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaList', N'Danh mục dinh muc', N'QuotaList', N'EDMF1010', N'Import_Excel_QuotaIDList.xlsx', N' EXEC EDMP1014 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'LevelID', N'Mã cấp', N'LevelID', 
	N'', 50, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Level'''' ''', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'QuotaList', N'Danh mục dinh muc', N'QuotaList', N'EDMF1010', N'Import_Excel_QuotaIDList.xlsx', N' EXEC EDMP1014 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'Quantity', N'Đinh mức HS/giáo viên, bảo mẫu', N'Quantity', 
	N'', 50, 50, 1, N'INT', N'', 1, N'E')


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'QuotaList')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('QuotaList', N'Danh mục định mức', 'QuotaList', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucdinhmuc.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Danh mục lớp
DELETE FROM A00065 WHERE ImportTransTypeID = N'Class'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'LevelID', N'Cấp', N'LevelID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Level''''''', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'GradeID', N'Khối', N'GradeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1000'', @Param2 = ''GradeID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'QuotaID', N'Định mức', N'QuotaID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1010'', @Param2 = ''QuotaID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'ClassID', N'Mã lớp', N'ClassID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ClassName', N'Tên lớp', N'ClassName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Class', N'Danh mục lớp', N'Class', N'EDMF1020', N'Import_Excel_Danhmuclop.xls', N' EXEC EDMP1023 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'F')




	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Class')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Class', N'Danh mục lớp', 'Class', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmuclop.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- Danh mục môn học
DELETE FROM A00065 WHERE ImportTransTypeID = N'Subject'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Subject', N'Danh mục môn học', N'Subject', N'EDMF1030', N'Import_Excel_Danhmucmonhoc.xls', N' EXEC EDMP1033 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Subject', N'Danh mục môn học', N'Subject', N'EDMF1030', N'Import_Excel_Danhmucmonhoc.xls', N' EXEC EDMP1033 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'SubjectID', N'Mã môn học', N'SubjectID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Subject', N'Danh mục môn học', N'Subject', N'EDMF1030', N'Import_Excel_Danhmucmonhoc.xls', N' EXEC EDMP1033 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'SubjectName', N'Tên môn học', N'SubjectName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Subject', N'Danh mục môn học', N'Subject', N'EDMF1030', N'Import_Excel_Danhmucmonhoc.xls', N' EXEC EDMP1033 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Notes', N'Ghi chú', N'Notes', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Subject', N'Danh mục môn học', N'Subject', N'EDMF1030', N'Import_Excel_Danhmucmonhoc.xls', N' EXEC EDMP1033 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'E')

	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Subject')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Subject', N'Danh mục môn học', 'Subject', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucmonhoc.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END




--- Danh mục năm học
DELETE FROM A00065 WHERE ImportTransTypeID = N'SchoolYear'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SchoolYear', N'Danh mục năm học', N'SchoolYear', N'EDMF1040', N'Import_Excel_Danhmucnamhoc.xls', N' EXEC EDMP1043 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SchoolYear', N'Danh mục năm học', N'SchoolYear', N'EDMF1040', N'Import_Excel_Danhmucnamhoc.xls', N' EXEC EDMP1043 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'SchoolYearID', N'Mã năm học', N'SchoolYearID', 
	N'', 120, 50, 0, N'VARCHAR(50)', N'`', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SchoolYear', N'Danh mục năm học', N'SchoolYear', N'EDMF1040', N'Import_Excel_Danhmucnamhoc.xls', N' EXEC EDMP1043 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'DateFrom', N'Từ ngày', N'DateFrom', 
	N'', 80, 250, 0, N'DATETIME', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SchoolYear', N'Danh mục năm học', N'SchoolYear', N'EDMF1040', N'Import_Excel_Danhmucnamhoc.xls', N' EXEC EDMP1043 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'DateTo', N'Đến ngày', N'DateTo', 
	N'', 80, 250, 0, N'DATETIME', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'SchoolYear', N'Danh mục năm học', N'SchoolYear', N'EDMF1040', N'Import_Excel_Danhmucnamhoc.xls', N' EXEC EDMP1043 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'E')

	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'SchoolYear')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('SchoolYear', N'Danh mục năm học', 'SchoolYear', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucnamhoc.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


---- Danh mục loại hình thu
DELETE FROM A00065 WHERE ImportTransTypeID = N'ReceiptTypeID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'AnaRevenueID', N'Khoản thu', N'AnaRevenueID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'TypeOfFee', N'Loại phí', N'TypeOfFee', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'Business', N'Nghiệp vụ', N'Business', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'AccountID', N'Tài khoản ', N'AccountID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1005'', @Param2 = ''AccountID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'Note', N'Ghi chú', N'Note', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'StudentStatus', N'Trạng thái học sinh', N'StudentStatus', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'IsObligatory', N'Bắt buộc', N'IsObligatory', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Iscommon', N'Dùng chung', N'Iscommon', 
	N'', 50, 30, 1, N'TINYINT', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Disabled'''' ''', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'IsReserve', N'Bảo lưu', N'IsReserve', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ReceiptTypeID', N'Danh mục loại hình thu', N'ReceiptType', N'EDMF1050', N'Import_Excel_Danhmucloaihinhthu.xls', N' EXEC EDMP1052 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'IsTransfer', N'Chuyển nhượng', N'IsTransfer', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'J')



IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ReceiptTypeID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('ReceiptTypeID', N'Danh mục loại hình thu', 'ReceiptTypeID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucloaihinhthu.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Danh mục loại hoạt động 
DELETE FROM A00065 WHERE ImportTransTypeID = N'ActivityTypeID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActivityTypeID', N'Danh mục loại hoạt động ', N'ActivityType', N'EDMF1060', N'Import_Excel_Danhmucloaihoatdong.xls', N' EXEC EDMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActivityTypeID', N'Danh mục loại hoạt động ', N'ActivityType', N'EDMF1060', N'Import_Excel_Danhmucloaihoatdong.xls', N' EXEC EDMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'ActivityTypeID', N'Mã loại hoạt động ', N'ActivityTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActivityTypeID', N'Danh mục loại hoạt động ', N'ActivityType', N'EDMF1060', N'Import_Excel_Danhmucloaihoatdong.xls', N' EXEC EDMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'ActivityTypeName', N'Tên loại hoạt động', N'ActivityTypeName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActivityTypeID', N'Danh mục loại hoạt động ', N'ActivityType', N'EDMF1060', N'Import_Excel_Danhmucloaihoatdong.xls', N' EXEC EDMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'IsCommon', N'Dùng chung ', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Disabled'''' ''', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActivityTypeID', N'Danh mục loại hoạt động ', N'ActivityType', N'EDMF1060', N'Import_Excel_Danhmucloaihoatdong.xls', N' EXEC EDMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'ActivityID', N'Mã hoạt động', N'ActivityID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ActivityTypeID', N'Danh mục loại hoạt động ', N'ActivityType', N'EDMF1060', N'Import_Excel_Danhmucloaihoatdong.xls', N' EXEC EDMP1062 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ActivityName', N'Tên hoạt động ', N'ActivityName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'E')



IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ActivityTypeID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('ActivityTypeID', N'Danh mục loại hoạt động', 'ActivityTypeID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucloaihoatdong.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Danh mục điều tra tâm lý 
DELETE FROM A00065 WHERE ImportTransTypeID = N'PsychologizeID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'PsychologizeType', N'Loại điều tra tâm lý ', N'PsychologizeType', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''PsychologizeType'''' ''', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'PsychologizeID', N'Mã điều tra tâm lý ', N'PsychologizeID', 
	N'', 110, 50, 0, N'VARCHAR(50)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'PsychologizeName', N'Tên điều tra tâm lý ', N'PsychologizeName', 
	N'', 50, 250, 0, N'NVARCHAR(250)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'PsychologizeGroup', N'Điều tra tâm lý cha ', N'PsychologizeGroup', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'Number', N'Số thứ tự', N'Number', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PsychologizeID', N'Danh mục điều tra tâm lý ', N'Psychologize', N'EDMF1070', N'Import_Excel_Danhmucdieutratamly.xls', N' EXEC EDMP1072 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'IsCommon', N'Dùng chung ', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Disabled'''' ''', 0, N'F')





IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'PsychologizeID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('PsychologizeID', N'Danh mục điều tra tâm lý', 'PsychologizeID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucdieutratamly.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Danh mục Feeling
DELETE FROM A00065 WHERE ImportTransTypeID = N'FeelingID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeelingID', N'Danh mục Feeling', N'Feeling', N'EDMF1080', N'Import_Excel_DanhmucFeeling.xls', N' EXEC EDMP1082 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeelingID', N'Danh mục Feeling', N'Feeling', N'EDMF1080', N'Import_Excel_DanhmucFeeling.xls', N' EXEC EDMP1082 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'FeelingID', N'Mã Feeling', N'FeelingID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeelingID', N'Danh mục Feeling', N'Feeling', N'EDMF1080', N'Import_Excel_DanhmucFeeling.xls', N' EXEC EDMP1082 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'FeelingName', N'Tên Feeling', N'FeelingName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeelingID', N'Danh mục Feeling', N'Feeling', N'EDMF1080', N'Import_Excel_DanhmucFeeling.xls', N' EXEC EDMP1082 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'IsCommon', N'Dùng chung ', N'IsCommon', 
	N'', 50, 30, 1, N'TINYINT', N'', 0, N'C')




	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'FeelingID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('FeelingID', N'Danh mục Feeling', 'FeelingID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DanhmucFeeling.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Danh mục Biểu phí
DELETE FROM A00065 WHERE ImportTransTypeID = N'FeeID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'FeeID', N'Mã biểu phí ', N'FeeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'FeeName', N'Tên biểu phí ', N'FeeName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'SchoolYearID', N'Năm học', N'SchoolYearID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1040'', @Param2 = ''SchoolYearID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'GradeID', N'Khối ', N'GradeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1000'', @Param2 = ''GradeID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'IsCommon', N'Dùng chung ', N'IsCommon', 
	N'', 50, 30, 0, N'TINYINT', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Disabled'''' ''', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ReceiptTypeID', N'Khoản phí', N'ReceiptTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1050'', @Param2 = ''ReceiptTypeID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'Amount', N'Tiền phí ', N'Amount', 
	N'', 50, 30, 1, N'DECIMAL(28,8)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'UnitID', N'Đơn vị tính ', N'UnitID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Time'''' ''', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'AmountOfDay', N'Ngày', N'AmountOfDay', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'AmountOfOneMonth', N'1 tháng', N'AmountOfOneMonth', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'AmountOfSixMonth ', N'6 tháng', N'AmountOfSixMonth ', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'AmountOfNineMonth', N'9 tháng', N'AmountOfNineMonth', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'AmountOfYear', N'1 năm', N'AmountOfYear', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'AmountsOfOneWay', N'1 chiều ', N'AmountsOfOneWay', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'FeeID', N'Danh mục biểu phí ', N'Fee', N'EDMF1090', N'Import_Excel_Danhmucbieuphi.xls', N' EXEC EDMP1092 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'AmountsOfTwoWay', N'2 chiều', N'AmountsOfTwoWay', 
	N'', 50, 30, 1, N'DECIMAL(28)', N'', 0, N'O')


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'FeeID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('FeeID', N'Danh mục biểu phí ', 'FeeID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_Danhmucbieuphi.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END



---- Danh mục Khuyến mãi
DELETE FROM A00065 WHERE ImportTransTypeID = N'PromotionID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'FromDate', N'Ngày áp dụng', N'FromDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'ToDate', N'Ngày kết thúc', N'ToDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'PromotionID', N'Mã Khuyến mãi', N'PromotionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'PromotionName', N'Tên khuyến mãi', N'PromotionName', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'PromotionType', N'Hình thức khuyến mãi', N'PromotionType', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'Value', N'Giá trị', N'Value', 
	N'', 80, 30, 1, N'DECIMAL(28,8)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'ReceiptTypeID', N'Khoản thu', N'ReceiptTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Quantity', N'Số lượng', N'Quantity', 
	N'', 80, 30, 1, N'DECIMAL(28,8)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'PromotionID', N'Khuyến mãi', N'PromotionID', N'EDMF1100', N'Import_Excel_KhuyenMai.xls', N' EXEC EDMP1101 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'I')





IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'PromotionID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('PromotionID', N'Khuyến mãi', 'PromotionID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_KhuyenMai.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END



---- Danh mục Đưa đón
DELETE FROM A00065 WHERE ImportTransTypeID = N'ShuttleID'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'ShuttleID', N'Mã đưa đón', N'ShuttleID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'PickupPlace', N'Điểm đón', N'PickupPlace', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'ArrivedPlace', N'Điểm đến', N'ArrivedPlace', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'ReceiptTypeID', N'Khoản mục phí', N'ReceiptTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'PromotionID', N'Khuyến mãi', N'PromotionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ShuttleID', N'Đưa đón', N'ShuttleID', N'EDMF1110', N'Import_Excel_DuaDon.xls', N' EXEC EDMP1114 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'StudentID', N'Học sinh', N'StudentID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'G')



IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ShuttleID')
BEGIN
INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
VALUES ('ShuttleID', N'Đưa đón', 'ShuttleID', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DuaDon.xls', 0, 
'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END





END 

ELSE IF @CustomerName != 91
BEGIN 

BEGIN 
delete from A00065 WHERE ImportTransTypeID IN ('Grade','QuotaList','Class','Subject','SchoolYear','ReceiptTypeID','ActivityTypeID','PsychologizeID','FeelingID','FeeID')

delete from A01065 WHERE ImportTemplateID IN ('Grade','QuotaList','Class','Subject','SchoolYear','ReceiptTypeID','ActivityTypeID','PsychologizeID','FeelingID','FeeID')
END 

END 