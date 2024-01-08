-- <Summary>
---- Template import data: danh mục module OO
-- <History>
---- Create on 26/08/2020 by Trọng Kiên: Thêm dữ liệu danh mục mẫu công việc
---- Modified on ... by ...
---- <Example>
	
	----------------------- Danh mục mẫu công việc ----------------------- 

DELETE FROM A00065 WHERE ImportTransTypeID = N'TaskSample'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'TaskSampleID', N'Mã mẫu công việc', N'TaskSampleID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'TaskSampleName', N'Tên mẫu công việc', N'TaskSampleName', 
	N'', 100, 50, 0, N'NVARCHAR(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'TaskTypeID', N'Loại công việc', N'TaskTypeID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''OOT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster= ''''OOF1060.TaskType'''' AND ISNULL(TL.Disabled, 0) = 0''', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'TargetTypeID', N'Loại chỉ tiêu', N'TargetTypeID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'PriorityID', N'Độ ưu tiên', N'PriorityID', 
	N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster= ''''CRMT00000006'''' AND ISNULL(TL.Disabled, 0) = 0''', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ExecutionTime', N'Thời gian thực hiện (giờ)', N'ExecutionTime', 
	N'', 100, 50, 1, N'DECIMAL(5,2)', N'', 1, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'Description', N'Mô tả', N'Description', 
	N'', 100, 50, 0, N'NVARCHAR(MAX)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'TaskSample', N'Mẫu công việc', N'TaskSample', N'OOF1060', N'OOT1060.xlsx', N'EXEC OOP1065 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'IsCommon', N'Dùng chung', N'IsCommon', 
	N'', 100, 50, 1, N'INT', N'', 0, N'H')

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'TaskSample')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('TaskSample', N'Mẫu công việc', 'TaskSample', 'Data', N'A', 10, N'C:\IMPORTS', N'OOT1060.xlsx', 0,
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END