---Created by Bảo Thy on 15/03/2018: Import đơn xin đổi ca
---Modified on 27/5/2019 by Hồng Thảo: Xóa file import cho khách hàng CBD vì không dùng 
DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 103
BEGIN 
DELETE A00065 WHERE ImportTransTypeID = 'ChangeShift'
END 
ELSE 

BEGIN 

DELETE A00065 WHERE ImportTransTypeID = 'ChangeShift'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'Division', 
	N'', 50, 50, 0, N'NVARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 2, N'Period', N'Kỳ kế toán', N'Period', 
	N'', 80, 7, 0, N'VARCHAR(10)', N'{CheckValidPeriod} @Module = ''ASOFT-HRM''', 1, N'B4')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 3, N'TypeID', N'Loại đơn đổi ca', N'TypeID', 
	N'', 80, 1, 1, N'TINYINT', N'', 1, N'B5')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 4, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 5, N'DepartmentID', N'Phòng ban', N'DepartmentID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1102'', @Param2 = ''DepartmentID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 6, N'TeamID', N'Tổ nhóm', N'TeamID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1101'', @Param2 = ''TeamID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 7, N'EmployeeID', N'Mã nhân viên', N'EmployeeID', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT2400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.TranYear = RIGHT(DT.Period, 4) AND TL.TranMonth = LEFT(DT.Period, 2)''', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 8, N'FullName', N'Tên nhân viên', N'FullName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 9, N'D01', N'1', N'1', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 10, N'D02', N'2', N'2', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 11, N'D03', N'3', N'3', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 12, N'D04', N'4', N'4', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 13, N'D05', N'5', N'5', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 14, N'D06', N'6', N'6', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 15, N'D07', N'7', N'7', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 16, N'D08', N'8', N'8', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 17, N'D09', N'9', N'9', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 18, N'D10', N'10', N'10', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 19, N'D11', N'11', N'11', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 20, N'D12', N'12', N'12', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 21, N'D13', N'13', N'13', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 22, N'D14', N'14', N'14', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 23, N'D15', N'15', N'15', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 24, N'D16', N'16', N'16', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'U')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 25, N'D17', N'17', N'17', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'V')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 26, N'D18', N'18', N'18', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 27, N'D19', N'19', N'19', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'X')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 28, N'D20', N'20', N'20', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'Y')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 29, N'D21', N'21', N'21', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'Z')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 30, N'D22', N'22', N'22', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AA')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 31, N'D23', N'23', N'23', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AB')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 32, N'D24', N'24', N'24', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AC')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 33, N'D25', N'25', N'25', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AD')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 34, N'D26', N'26', N'26', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AE')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 35, N'D27', N'27', N'27', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AF')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 36, N'D28', N'28', N'28', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AG')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 37, N'D29', N'29', N'29', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AH')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 38, N'D30', N'30', N'30', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AI')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 39, N'D31', N'31', N'31', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1020'', @Param2 = ''ShiftID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'AJ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 40, N'Note', N'Ghi chú', N'Note', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'AK')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 41, N'ApprovePersonID01', N'Người duyệt 01', N'ApprovePersonID01', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AL')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 42, N'ApprovePersonID02', N'Người duyệt 02', N'ApprovePersonID02', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AM')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 43, N'ApprovePersonID03', N'Người duyệt 03', N'ApprovePersonID03', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AN')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 44, N'ApprovePersonID04', N'Người duyệt 04', N'ApprovePersonID04', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AO')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 45, N'ApprovePersonID05', N'Người duyệt 05', N'ApprovePersonID05', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AP')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 46, N'ApprovePersonID06', N'Người duyệt 06', N'ApprovePersonID06', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AQ')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 47, N'ApprovePersonID07', N'Người duyệt 07', N'ApprovePersonID07', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AR')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 48, N'ApprovePersonID08', N'Người duyệt 08', N'ApprovePersonID08', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AS')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 49, N'ApprovePersonID09', N'Người duyệt 09', N'ApprovePersonID09', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AT')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'ChangeShift', N'Đơn xin đổi ca', N'ChangeShift', N'OOF2071', N'Import_Excel_DonXinDoiCa.xls', N'EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 50, N'ApprovePersonID10', N'Người duyệt 10', N'ApprovePersonID10', 
	N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HV1400'', @Param2 = ''EmployeeID'', @SQLFilter = ''TL.Disabled =  0 AND TL.StatusID NOT IN (3,9)''', 0, N'AU')



DELETE A01065 WHERE ImportTransTypeID = 'ChangeShift'
exec sp_executesql N'
      INSERT INTO A01065(
      ImportTemplateID,
      ImportTemplateName,
      ImportTransTypeID,
      DefaultSheet,
      AnchorCol,
      StartRow,
      DataFolder,
      DefaultFileName,
      Disabled,
      CreateUserID,
      CreateDate,
      LastModifyUserID,
      LastModifyDate
      ) VALUES (
      @ImportTemplateID,
      @ImportTemplateName,
      @ImportTransTypeID,
      @DefaultSheet,
      @AnchorCol,
      @StartRow,
      @DataFolder,
      @DefaultFileName,
      @Disabled,
      ''ASOFTADMIN'',
      GETDATE(),
      ''ASOFTADMIN'',
      GETDATE()
      )
    ',N'@ImportTemplateID nvarchar(50),@ImportTemplateName nvarchar(50),@ImportTransTypeID nvarchar(50),@DefaultSheet nvarchar(4),@AnchorCol nvarchar(1),@StartRow int,@DataFolder nvarchar(10),@DefaultFileName nvarchar(50),@Disabled tinyint',
	@ImportTemplateID=N'ChangeShift',@ImportTemplateName=N'Đơn xin đổi ca',@ImportTransTypeID=N'ChangeShift',@DefaultSheet=N'Data',@AnchorCol=N'A',@StartRow=10,@DataFolder=N'C:\IMPORTS',
	@DefaultFileName=N'Import_Excel_DonXinDoiCa',@Disabled=0

END 