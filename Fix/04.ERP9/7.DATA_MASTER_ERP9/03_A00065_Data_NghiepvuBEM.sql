-- <Summary>
---- Template import data: Nghiệp vụ moduel BEM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 02/06/2020 by Thái Đình Ly
-- <Example>

----------------------- Nghiệp vụ Đề nghị thanh toán - BEMF2000 ----------------------- 

-- Insert dữ liệu Master vào bảng A01065
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'PaymentRequest')
BEGIN
	-- Param insert
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol,
	StartRow, DataFolder, DefaultFileName, [Disabled], CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	-- Values insert
	VALUES ('PaymentRequest', N'Đề nghị thanh toán', 'PaymentRequest', 'Data', N'A',
	10, N'C:\IMPORTS', N'BEMT2000.xlsx', 0, 'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

-- Insert dữ liệu Detail vào bảng A00065
DELETE FROM A00065 WHERE ImportTransTypeID = N'PaymentRequest'
BEGIN
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'Period', N'Kỳ', N'Period', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidPeriod} @Module = ''ASOFT-BEM''', 1, N'B4')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'ID', N'Số chứng từ', N'ID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'TypeID', N'Loại đề nghị', N'TypeID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''BEMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster = ''''ProposalTypeID'''' AND ISNULL(TL.Disabled, 0) =  0''', 1, N'B')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'VoucherDate', N'Ngày chứng từ', N'VoucherDate', 
		N'', 100, 50, 2, N'DATETIME', N'', 1, N'C')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'DepartmentID', N'Bộ phận', N'DepartmentID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'D')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'PhoneNumber', N'Điện thoại', N'PhoneNumber', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'E')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'ApplicantID', N'Người đề nghị', N'ApplicantID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1103'', @Param2 = ''EmployeeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'F')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'MethodPay', N'Phương thức thanh toán', N'MethodPay', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1205'', @Param2 = ''PaymentID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 0, N'G')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'AdvanceUserID', N'Đối tượng tạm ứng tiền', N'AdvanceUserID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1202'', @Param2 = ''ObjectID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'H')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'PaymentTermID', N'Điều khoản thanh toán', N'PaymentTermID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1208'', @Param2 = ''PaymentTermID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 0, N'I')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'Deadline', N'Hạn cuối', N'Deadline', 
		N'', 100, 50, 2, N'DATETIME', N'', 0, N'J')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'FCT', N'FCT', N'FCT', 
		N'', 100, 50, 1, N'INT', N'{CheckValueInTableList} @Param1 = ''AT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster = ''''AT00000004'''' AND ISNULL(TL.Disabled, 0) =  0''', 0, N'K')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'ApproveStatus01', N'Tình trạng duyệt 01', N'ApproveStatus01', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''OOT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster = ''''Status'''' AND ISNULL(TL.Disabled, 0) =  0''', 1, N'L')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'ApprovePerson01', N'Người duyệt 01', N'ApprovePerson01', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1103'', @Param2 = ''EmployeeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'M')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'ApprovePerson02', N'Người duyệt 02', N'ApprovePerson02', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1103'', @Param2 = ''EmployeeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'N')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'CostAnaID', N'Mã chi phí', N'CostAnaID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1011'', @Param2 = ''AnaID'', @SQLFilter = ''AnaTypeID = ''''A08'''' AND ISNULL(TL.Disabled, 0) =  0''', 0, N'O')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'DepartmentAnaID', N'Mã phòng ban', N'DepartmentAnaID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1011'', @Param2 = ''AnaID'', @SQLFilter = ''AnaTypeID = ''''A04'''' AND ISNULL(TL.Disabled, 0) =  0''', 0, N'P')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'Description', N'Nội dung', N'Description', 
		N'', 250, 50, 0, N'NVARCHAR(MAX)', N'', 0, N'Q')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'RingiNo', N'Số RingiNo', N'RingiNo', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'R')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'InvoiceNo', N'Số hóa đơn', N'InvoiceNo', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'S')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'InvoiceDate', N'Ngày hóa đơn', N'InvoiceDate', 
		N'', 100, 50, 2, N'DATETIME', N'', 0, N'T')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'RequestAmount', N'Số tiền yêu cầu', N'RequestAmount', 
		N'', 100, 30, 1, N'DECIMAL(28,8)', N'', 1, N'U')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'CurrencyID', N'Loại tiền', N'CurrencyID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1004'', @Param2 = ''CurrencyID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'V')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'PaymentExchangeRate', N'Tỉ giá thanh toán', N'PaymentExchangeRate', 
		N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 1, N'W')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'BankAccountID', N'Số tài khoản ngân hàng chi', N'BankAccountID', 
		N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1016'', @Param2 = ''BankAccountNo'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 0, N'X')
	INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
		InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
	VALUES (N'PaymentRequest', N'Đề nghị thanh toán', N'PaymentRequest', N'BEMF2000', N'BEMT2000.xlsx', N'EXEC BEMP20001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'BankAccountName', N'Tên ngân hàng chi', N'BankAccountName', 
		N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'Y')
END
 