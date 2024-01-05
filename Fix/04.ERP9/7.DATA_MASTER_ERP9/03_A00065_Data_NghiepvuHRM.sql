-- <Summary>
---- Template import data: nghiệp vụ module HRM
-- <History>
---- Create on 11/07/2022 by Văn Tài
---- Modified on ... by ...
---- Modified on 01/11/2022 by Đức Tuyên bắt buộc nhập 'Mã Khối'(DepartmentID) khi import cho DXP và DXBSQT
---- Modified on 16/08/2023 by Phương Thảo bổ sung import : Hồ sơ ứng viên: Import_Excel_HoSoUngVien_ThongTinUngVien
---- <Example>

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex WITH (NOLOCK))

BEGIN 

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WITH (NOLOCK) WHERE ImportTemplateID = 'OnLeaveRequest')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES 
	('OnLeaveRequest', N'Đơn xin phép', 'OnLeaveRequest', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DonXinPhep.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

---- Nghiệp vụ Đơn xin phép
DELETE FROM A00065 WHERE ImportTransTypeID = N'OnLeaveRequest'

INSERT INTO A00065
	(
		ImportTransTypeID
		, ImportTransTypeName
		, ImportTransTypeNameEng
		, ScreenID
		, TemplateFileName
		, ExecSQL
		, OrderNum
		, ColID
		, ColName
		, ColNameEng
		, InputMask
		, ColWidth
		, ColLength
		, ColType
		, ColSQLDataType
		, CheckExpression
		, IsObligated
		, DataCol
	)
VALUES (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B4'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 2, N'Period', N'Kỳ kế toán', N'Period', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B5'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 4, N'OrderNo', N'Số thứ tự', N'OrderNo', N'', 80, 50, 0, N'INT', N'', 0, N'A'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 5, N'ID', N'Mã phiếu', N'ID', N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'B'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 6, N'Description', N'Diễn giải', N'Description', N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'C'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 7, N'DepartmentID', N'Mã khối', N'DepartmentID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'D'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 8, N'SectionID', N'Mã phòng', N'SectionID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'E'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 9, N'SubsectionID', N'Mã ban', N'SubsectionID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'F'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 10, N'ProcessID', N'Mã công đoạn', N'ProcessID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'G'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 11, N'EmployeeID', N'Mã nhân viên', N'EmployeeID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'H'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 12, N'AbsentTypeID', N'Loại phép', N'AbsentTypeID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'I'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 13, N'ShiftID', N'Mã ca', N'ShiftID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'J'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 14, N'LeaveFromDate', N'Nghỉ phép Từ ngày', N'LeaveFromDate', N'', 80, 50, 0, N'DATETIME', N'', 0, N'K'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 15, N'LeaveToDate', N'Nghỉ phép Đến ngày', N'LeaveToDate', N'', 80, 50, 0, N'DATETIME', N'', 0, N'L'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 16, N'TotalTime', N'Tổng giờ xin phép', N'TotalTime', N'', 80, 50, 0, N'DECIMAL(28, 2)', N'', 0, N'M'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 17, N'OffsetTime', N'OffsetTime', N'OffsetTime', N'', 80, 50, 0, N'DECIMAL(28, 2)', N'', 0, N'N'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 18, N'TimeAllowance', N'TimeAllowance', N'TimeAllowance', N'', 80, 50, 0, N'DECIMAL(28, 2)', N'', 0, N'O'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 19, N'IsNextDay', N'Ngày kế tiếp', N'IsNextDay', N'', 80, 50, 0, N'INT', N'', 0, N'P'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 20, N'Reason', N'Lý do', N'Reason', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'Q'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 21, N'ApproveLevel', N'Số cấp duyệt', N'ApproveLevel', N'', 80, 50, 0, N'INT', N'', 1, N'D4'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 22, N'ApprovePersonID01', N'Người duyệt 01', N'ApprovePersonID01', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'R'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 23, N'ApprovePersonID02', N'Người duyệt 02', N'ApprovePersonID02', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'S'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 24, N'ApprovePersonID03', N'Người duyệt 03', N'ApprovePersonID03', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'T'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 25, N'ApprovePersonID04', N'Người duyệt 04', N'ApprovePersonID04', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'U'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 26, N'ApprovePersonID05', N'Người duyệt 05', N'ApprovePersonID05', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'V'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 27, N'ApprovePersonID06', N'Người duyệt 06', N'ApprovePersonID06', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'W'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 28, N'ApprovePersonID07', N'Người duyệt 07', N'ApprovePersonID07', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'X'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 29, N'ApprovePersonID08', N'Người duyệt 08', N'ApprovePersonID08', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'Y'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 30, N'ApprovePersonID09', N'Người duyệt 09', N'ApprovePersonID09', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'Z'),
	   (N'OnLeaveRequest', N'Đơn xin phép', N'OnLeaveRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2066 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 31, N'ApprovePersonID10', N'Người duyệt 10', N'ApprovePersonID10', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'AA')
END



IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WITH (NOLOCK) WHERE ImportTemplateID = 'InOutRequest')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES 
	('InOutRequest', N'Đơn xin bổ sung quẹt thẻ', 'InOutRequest', 'Data', N'A', 10, N'C:\IMPORTS', N'Import_Excel_DonXinQuetThe.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

BEGIN

---- Nghiệp vụ Đơn xin bổ sung quẹt thẻ
DELETE FROM A00065 WHERE ImportTransTypeID = N'InOutRequest'

INSERT INTO A00065
	(
		ImportTransTypeID
		, ImportTransTypeName
		, ImportTransTypeNameEng
		, ScreenID
		, TemplateFileName
		, ExecSQL
		, OrderNum
		, ColID
		, ColName
		, ColNameEng
		, InputMask
		, ColWidth
		, ColLength
		, ColType
		, ColSQLDataType
		, CheckExpression
		, IsObligated
		, DataCol
	)
VALUES (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 1, N'DivisionID', N'Đơn vị', N'DivisionID', N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B4'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 2, N'Period', N'Kỳ kế toán', N'Period', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'B5'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 3, N'ApproveLevel', N'Số cấp duyệt', N'ApproveLevel', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'D4'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 4, N'OrderNo', N'Số thứ tự', N'OrderNo', N'', 80, 50, 0, N'INT', N'', 0, N'A'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 5, N'ID', N'Mã phiếu', N'ID', N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'B'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 6, N'Description', N'Diễn giải', N'Description', N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'C'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 7, N'DepartmentID', N'Mã khối', N'DepartmentID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'D'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 8, N'SectionID', N'Mã phòng', N'SectionID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'E'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 9, N'SubsectionID', N'Mã ban', N'SubsectionID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'F'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 10, N'ProcessID', N'Mã công đoạn', N'ProcessID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'G'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 11, N'EmployeeID', N'Mã nhân viên', N'EmployeeID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'H'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 12, N'Reason', N'Lý do', N'Reason', N'', 80, 50, 0, N'VARCHAR(50)', N'', 0, N'I'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 13, N'Date', N'Thời gian bổ sung/hủy quẹt thẻ', N'Date', N'', 80, 50, 0, N'DATETIME', N'', 0, N'J'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 14, N'InOut', N'Vào/Ra', N'InOut', N'', 80, 50, 0, N'TINYINT', N'', 0, N'K'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 15, N'Note', N'Ghi chú', N'Note', N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'L'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 16, N'ApprovePersonID01', N'Người duyệt 01', N'ApprovePersonID01', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'M'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 17, N'ApprovePersonID02', N'Người duyệt 02', N'ApprovePersonID02', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'N'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 18, N'ApprovePersonID03', N'Người duyệt 03', N'ApprovePersonID03', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'O'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 19, N'ApprovePersonID04', N'Người duyệt 04', N'ApprovePersonID04', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'P'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 20, N'ApprovePersonID05', N'Người duyệt 05', N'ApprovePersonID05', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'Q'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 21, N'ApprovePersonID06', N'Người duyệt 06', N'ApprovePersonID06', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'R'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 22, N'ApprovePersonID07', N'Người duyệt 07', N'ApprovePersonID07', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'S'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 23, N'ApprovePersonID08', N'Người duyệt 08', N'ApprovePersonID08', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'T'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 24, N'ApprovePersonID09', N'Người duyệt 09', N'ApprovePersonID09', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'U'),
	   (N'InOutRequest', N'Đơn xin bổ sung quẹt thẻ', N'InOutRequest', N'OOF2010', N'Import_Excel_DonXinPhep.xlsx', N' EXEC OOP2067 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,@Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML', 25, N'ApprovePersonID10', N'Người duyệt 10', N'ApprovePersonID10', N'', 80, 50, 0, N'NVARCHAR(500)', N'', 0, N'V')
END


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WITH (NOLOCK) WHERE ImportTemplateID = 'RecruitFileID')
BEGIN
	INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
	[Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	VALUES 
	('RecruitFileID', N'Hồ sơ ứng viên', 'RecruitFileID', 'Data', N'A', 8, N'C:\IMPORTS', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', 0, 
	'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END
BEGIN

---- Danh mục Hồ sơ ứng viên
DELETE FROM A00065 WHERE ImportTransTypeID = N'RecruitFileID'

INSERT INTO A00065
	(
		ImportTransTypeID
		, ImportTransTypeName
		, ImportTransTypeNameEng
		, ScreenID
		, TemplateFileName
		, ExecSQL
		, OrderNum
		, ColID
		, ColName
		, ColNameEng
		, InputMask
		, ColWidth
		, ColLength
		, ColType
		, ColSQLDataType
		, CheckExpression
		, IsObligated
		, DataCol
	)
VALUES (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 1, N'DivisionID', N'Đơn vị', N'Division', N'', 50, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3'),
	   (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 2, N'CandidateID', N'Mã ứng viên', N'CandidateID', N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'A'),
	   (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 3, N'LastName', N'Họ', N'LastName', N'', 50, 50, 0, N'VARCHAR(50)', N'', 1, N'B'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 4, N'MiddleName', N'Tên đệm', N'MiddleName', N'', 50, 50, 0, N'VARCHAR(50)', N'', 0, N'C'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 5, N'FirstName', N'Tên ứng viên', N'FirstName', N'', 80, 250, 0, N'VARCHAR(250)', N'', 1, N'D'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 6, N'Birthday', N'Ngày sinh', N'Birthday', N'', 80, 10, 2, N'VARCHAR(50)', N'', 1, N'E'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 7, N'BornPlace', N'Nơi sinh', N'BornPlace' ,N'', 80, 50, 0, N'VARCHAR(50)', N'', 1, N'F'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 8, N'NationalityID', N'Quốc tịch', N'Nationality' ,N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1001'', @Param2 = ''CountryID'', @SQLFilter = ''TL.Disabled =  0''', 1, N'G'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 9, N'EthnicID', N'Dân tộc', N'Ethnic' ,N'', 80, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1001'', @Param2 = ''EthnicID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'H'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 10, N'ReligionID', N'Tôn giáo', N'Religion' ,N'', 50, 50,	0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''HT1002'', @Param2 = ''ReligionID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'I'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 11, N'NativeCountry', N'Nguyên quán', N'NativeCountry' ,N'', 80, 1000, 0, N'NVARCHAR(1000)', N'',0, N'J'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 12, N'IdentifyCardNo', N'Số CMND', N'IdentifyCardNo' ,N'', 80, 250, 0, N'NVARCHAR(250)', N'', 0, N'K'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 13, N'IdentifyPlace',	N'Nơi cấp CMND', N'IdentifyPlace' ,N'', 80,	50,	0, N'VARCHAR(50)', N'', 0, N'L'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 14, N'IdentifyCity', N'Tỉnh/TP cấp CMND', N'IdentifyCity' ,N'', 80, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1002'', @Param2 = ''CityID'', @SQLFilter = ''TL.Disabled =  0''', 0, N'M'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 15, N'IdentifyDate', N'Ngày cấp CMND', N'IdentifyDate' ,N'', 80, 10, 0, N'VARCHAR(50)', N'', 0, N'N'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 16, N'Gender', N'Giới tính', N'Gender' ,N'', 80, 5, 0, N'VARCHAR(5)', N'{CheckValueInTableList} @Param1 = ''HT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.Disabled =  0 AND TL.CodeMaster = ''''Gender'''' ''', 1, N'O'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 17, N'IsSingle', N'Tình trạng gia đình', N'IsSingle' ,N'', 80, 10, 1, N'TINYINT', N'', 1, N'P'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 18, N'HealthStatus', N'Tình trạng sức khỏe', N'HealthStatus' ,N'', 80, 50, 0, N'NVARCHAR(250)', N'', 0, N'Q'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 19, N'Height', N'Chiều cao', N'Height' ,N'', 80, 50, 0, N'NVARCHAR(50)', N'', 0, N'R'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 20, N'Weight', N'Cân nặng', N'Weight' ,N'', 50, 50, 0, N'NVARCHAR(50)', N'', 0, N'S'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 21, N'PassportNo', N'Số hộ chiếu', N'PassportNo' ,N'', 80, 250, 2, N'NVARCHAR(250)', N'', 0, N'T'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 22, N'PassportDate', N'Ngày cấp hộ chiếu', N'PassportDate' ,N'', 80, 10, 2, N'VARCHAR(50)', N'', 0, N'U'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 23, N'PassportEnd', N'Ngày hết hạn hộ chiếu', N'PassportEnd' ,N'', 80, 10, 2, N'VARCHAR(50)', N'', 0, N'V'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 24, N'PermanentAddress', N'Địa chỉ thường chú', N'PermanentAddress' ,N'', 80, 100, 0, N'NVARCHAR(1000)', N'', 0, N'W'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 25, N'TemporaryAddress', N'Địa chỉ tạm chú', N'TemporaryAddress' ,N'', 80, 250, 0, N'NVARCHAR(1000)', N'', 0, N'X'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 26, N'PhoneNumber', N'Số điện thoại', N'PhoneNumber' ,N'', 80, 250, 0, N'NVARCHAR(250)', N'', 1, N'Y'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 27, N'Email',	N'Email', N'Email' ,N'', 80, 250, 0, N'NVARCHAR(250)', N'', 1, N'Z'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 28, N'Fax', N'Fax', N'Fax	' ,N'',	80, 250, 0, N'NVARCHAR(250)', N'', 1, N'AA'),
       (N'RecruitFileID', N'Hồ sơ ứng viên', N'RecruitFileID', N'HRMF1031', N'Import_Excel_HoSoUngVien_ThongTinUngVien.xlsx', N' EXEC HRMP1032 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML,@SType = 1', 29, N'Note', N'Ghi chú', N'Note' ,N'', 80, 250, 0, N'NVARCHAR(250)', N'', 0, N'AB')
END


