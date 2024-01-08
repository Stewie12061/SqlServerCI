-- <Summary>
---- Template import data: nghiệp vụ module EDM
-- <History>
---- Create on 24/8/2019 by Hồng Thảo
---- Modified on ... by ...
---- <Example>



DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 91


BEGIN 
---- Nghiệp vụ thông tin tư vấn 
DELETE FROM A00065 WHERE ImportTransTypeID = N'Consultancy'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'VoucherNo', N'Số tư vấn', N'VoucherNo', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'VoucherDate', N'Ngày tư vấn', N'VoucherDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'ResultID', N'Kết quả tư vấn', N'ResultID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''ConsultancyResult'''' ''', 1, N'C')

---- ĐÌnh Hòa [02/04/2021] - Bổ sung đồng bộ một số thông tin
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'AdmissionDate', N'Ngày nhập học', N'AdmissionDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'D')	

--INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
--	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
--VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ResultID', N'Biểu phí', N'FeeID', 
--	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'E')
---- ĐÌnh Hòa [02/04/2021]



INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'Amount', N'Số tiền', N'Amount', 
	N'', 50, 20, 1, N'DECIMAL(28,8)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'DateFrom', N'Từ ngày ', N'DateFrom', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'DateTo', N'Đến ngày', N'DateTo', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'OldCustomer', N'Phụ huynh cũ/mới', N'OldCustomer', 
	N'', 50, 30, 0, N'TINYINT', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Disabled'''' ''', 0, N'I')

---- ĐÌnh Hòa [02/04/2021] - Bổ sung đồng bộ một số thông tin
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'SType01ID', N'Mã phân loại 1', N'SType01ID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'SType02ID', N'Mã phân loại 2', N'SType02ID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'SType03ID', N'Mã phân loại 3', N'SType03ID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'L')
---- ĐÌnh Hòa [02/04/2021]

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'ParentID', N'Mã phụ huynh', N'ParentID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'ParentName', N'Tên phụ huynh', N'ParentName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'Prefix', N'Xưng hô ', N'Prefix', 
	N'', 50, 30, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''AT00000002'''' AND TL.ID IN (''''1'''',''''2'''')  ''', 1, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'ParentDateBirth', N'Ngày sinh phụ huynh', N'ParentDateBirth', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'Telephone', N'Số điện thoại', N'Telephone', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'Address', N'Địa chỉ nhà', N'Address', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'Email', N'Email', N'Email', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'S')

---- ĐÌnh Hòa [02/04/2021] - Bổ sung đồng bộ một số thông tin
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'SType01IDS', N'Mã phân loại 1', N'SType01IDS', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'SType02IDS', N'Mã phân loại 2', N'SType02IDS', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'SType03IDS', N'Mã phân loại 3', N'SType03IDS', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'V')
---- ĐÌnh Hòa [02/04/2021]

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'StudentID', N'Mã học sinh ', N'StudentID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'StudentName', N'Tên học sinh ', N'StudentName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 1, N'X')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'StudentDateBirth', N'Ngày sinh học sinh ', N'StudentDateBirth', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 1, N'Y')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'Sex', N'Giới tính', N'Sex', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Sex'''' ''', 0, N'Z')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Consultancy', N'Thông tin tư vấn học sinh', N'Consultancy', N'EDMF2000', N'Import_Excel_ThongTinTuVanHocSinh.xls', N' EXEC EDMP2005 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, N'Information', N'Thông tin học sinh ', N'Information', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'AA')



	
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Consultancy')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Consultancy', N'Thông tin tư vấn học sinh', 'Consultancy', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_ThongTinTuVanHocSinh.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END




-----------------------Nghiệp vụ hồ sơ học sinh 
  
DELETE FROM A00065 WHERE ImportTransTypeID = N'StudentRecord'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'StudentID', N'Mã học sinh', N'StudentID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'StudentName', N'Tên học sinh', N'StudentName', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'PlaceOfBirth', N'Nơi sinh học sinh', N'PlaceOfBirth', 
	N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'NationalityID', N'Quốc tịch học sinh', N'NationalityID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1001'', @Param2 = ''CountryID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'NationID', N'Dân tộc học sinh', N'NationID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1001'', @Param2 = ''EthnicID'', @SQLFilter = ''TL.Disabled =  0  ''', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'FatherID', N'Mã phụ huynh bố', N'FatherID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1202'', @Param2 = ''ObjectID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'FatherName', N'Tên phụ huynh bố ', N'FatherName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'FatherDateOfBirth', N'Ngày sinh phụ huynh bố', N'FatherDateOfBirth', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'FatherPlaceOfBirth', N'Nơi sinh phụ huynh bố ', N'FatherPlaceOfBirth', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'FatherNationalityID', N'Quốc tịch phụ huynh bố', N'FatherNationalityID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1001'', @Param2 = ''CountryID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'FatherNationID', N'Dân tộc phụ huynh bố', N'FatherNationID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1001'', @Param2 = ''EthnicID'', @SQLFilter = ''TL.Disabled =  0  ''', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'FatherJob', N'Nghề nghiệp phụ huynh bố', N'FatherJob', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'FatherOffice', N'Nơi làm việc phụ huynh bố', N'FatherOffice', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'FatherPhone', N'Điện thoại nhà PH bố', N'FatherPhone', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'FatherMobiphone', N'Điện thoại di động bố', N'FatherMobiphone', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'FatherEmail', N'Email phụ huynh bố ', N'FatherEmail', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'MotherID', N'Mã phụ huynh mẹ', N'MotherID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1202'', @Param2 = ''ObjectID'', @SQLFilter = ''TL.Disabled =  0  ''', 0, N'Q')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'MotherName', N'Tên phụ huynh mẹ', N'MotherName', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'R')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'MotherDateOfBirth', N'Ngày sinh phụ huynh mẹ', N'MotherDateOfBirth', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'S')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'MotherPlaceOfBirth', N'Nơi sinh phụ huynh mẹ', N'MotherPlaceOfBirth', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'T')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 22, N'MotherNationalityID', N'Quốc tịch phụ huynh mẹ', N'MotherNationalityID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1001'', @Param2 = ''CountryID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'U')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 23, N'MotherNationID', N'Dân tộc phụ huynh mẹ', N'MotherNationID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1001'', @Param2 = ''EthnicID'', @SQLFilter = ''TL.Disabled =  0  ''', 0, N'V')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 24, N'MotherJob', N'Nghề nghiệp phụ huynh mẹ', N'MotherJob', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'W')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 25, N'MotherOffice', N'Nơi làm việc phụ huynh mẹ', N'MotherOffice', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'X')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 26, N'MotherPhone', N'Điện thoại nhà PH mẹ', N'MotherPhone', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'Y')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 27, N'MotherMobiphone', N'Điện thoại di động mẹ', N'MotherMobiphone', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'Z')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'StudentRecord', N'Hồ sơ học sinh', N'StudentRecord', N'EDMF2010', N'Import_Excel_HoSoHocSinh.xls', N' EXEC EDMP2027 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 28, N'MotherEmail', N'Email phụ huynh mẹ', N'MotherEmail', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'AA')










IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'StudentRecord')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('StudentRecord', N'Hồ sơ học sinh', 'StudentRecord', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_HoSoHocSinh.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END







-----------------------Nghiệp vụ Lịch năm học

DELETE FROM A00065 WHERE ImportTransTypeID = N'YearlySchedule'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'YearlyScheduleID', N'Mã lịch học', N'YearlyScheduleID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'DateSchedule', N'Ngày lịch học', N'DateSchedule', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'TermID', N'Năm học ', N'TermID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1040'', @Param2 = ''SchoolYearID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'FromDate', N'Từ ngày', N'FromDate', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ToDate', N'Đến ngày', N'ToDate', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'ActivityTypeID', N'Loại hoạt động', N'ActivityTypeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1060'', @Param2 = ''ActivityTypeID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'ActivityID', N'Hoạt động', N'ActivityID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'YearlySchedule', N'Lịch năm học ', N'YearlySchedule', N'EDMF2091', N'Import_Excel_LichNamHoc.xls', N' EXEC EDMP2093 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'Contents', N'Nội dung hoạt động', N'Contents', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'I')



IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'YearlySchedule')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('YearlySchedule', N'Lịch năm học', 'YearlySchedule', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_LichNamHoc.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END







-----------------------Nghiệp vụ thời khóa biểu năm học

DELETE FROM A00065 WHERE ImportTransTypeID = N'DailySchedule'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'DailyScheduleID', N'Mã lịch học', N'DailyScheduleID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'DateSchedule', N'Ngày lịch học', N'DateSchedule', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'TermID', N'Năm học', N'TermID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1040'', @Param2 = ''SchoolYearID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'GradeID', N'Khối', N'GradeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1000'', @Param2 = ''GradeID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ClassID', N'Lớp', N'ClassID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1020'', @Param2 = ''ClassID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'Description', N'Diễn giải', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(250)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'FromHour', N'Từ giờ', N'FromHour', 
	N'', 50, 50, 0, N'VARCHAR(25)', N'', 1, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'ToHour', N'Đến giờ', N'ToHour', 
	N'', 50, 50, 0, N'VARCHAR(25)', N'', 1, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'Monday', N'Thứ 2', N'Monday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'Tuesday', N'Thứ 3', N'Tuesday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'Wednesday', N'Thứ 4', N'Wednesday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'Thursday', N'Thứ 5', N'Thursday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'Friday', N'Thứ 6', N'Friday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'Saturday', N'Thứ 7', N'Saturday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'DailySchedule', N'Thời khóa biểu năm học', N'DailySchedule', N'EDMF2100', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', N' EXEC EDMP2106 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'Sunday', N'Chủ nhật', N'Sunday', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'O')








IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'DailySchedule')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('DailySchedule', N'Thời khóa biểu năm học', 'DailySchedule', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_ThoiKhoaBieuNamHoc.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END





-----------------------Nghiệp vụ chương trình học tháng

DELETE FROM A00065 WHERE ImportTransTypeID = N'Programmonth'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Đơn  vị ', N'DivisionID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'ProgrammonthID', N'Mã chương trình', N'ProgrammonthID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'TermID', N'Năm', N'TermID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1040'', @Param2 = ''SchoolYearID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'TranMonth', N'Tháng', N'TranMonth', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'VoucherDate', N'Ngày', N'VoucherDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 1, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'GradeID', N'Khối ', N'GradeID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1000'', @Param2 = ''GradeID'', @SQLFilter = ''TL.Disabled =  0 ''', 1, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ClassID', N'Lớp', N'ClassID', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''EDMT1020'', @Param2 = ''ClassID'', @SQLFilter = ''TL.Disabled =  0 ''', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'Notes', N'Nội dung', N'Notes', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'Week', N'Tuần', N'Week', 
	N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'FromDate', N'Từ ngày', N'FromDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'ToDate', N'Đến ngày', N'ToDate', 
	N'dd/MM/yyyyy', 50, 30, 2, N'DATETIME', N'', 0, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'Topic', N'Chủ  đề', N'Topic', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
	InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Programmonth', N'Chương trình học tháng', N'Programmonth', N'EDMF2121', N'Import_Excel_ChuongTrinhHocThang.xls', N' EXEC EDMP2126 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'Description', N'Hoạt động', N'Description', 
	N'', 110, 250, 0, N'NVARCHAR(MAX)', N'', 0, N'L')



IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Programmonth')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES ('Programmonth', N'Chương trình học tháng', 'Programmonth', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_ChuongTrinhHocThang.xls', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

END




