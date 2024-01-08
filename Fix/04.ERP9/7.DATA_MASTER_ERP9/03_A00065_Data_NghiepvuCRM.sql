-- <Summary>
---- Template import data: nghiệp vụ module CRM
-- <History>
---- Create on 10/03/2020 by Đình Ly
---- Modified on 12/08/2020 by Trọng Kiên: Thêm dữ liệu danh mục khách hàng
---- Modified on 25/08/2020 by Trọng Kiên: Thêm dữ liệu danh mục cơ hội
---- Modified on 26/08/2020 by Trọng Kiên: Thêm dữ liệu danh mục Liên hệ
---- Modified on 26/08/2020 by Trọng Kiên: Thêm dữ liệu danh mục Chiến dịch
---- Modified on 02/11/2020 by Trọng Kiên: Bỏ bắt buộc nhập LeadMobile của Đầu mối
---- Modified on ... by ...
---- <Example>


----------------------- Nghiệp vụ đầu mối ----------------------- 
  
DELETE FROM A00065 WHERE ImportTransTypeID = N'Lead'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'LeadID', N'Mã đầu mối', N'LeadID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'A')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'CampaignID', N'Mã chiến dịch', N'CampaignID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT20401'', @Param2 = ''CampaignID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) =  0''', 1, N'B')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'LeadName', N'Tên đầu mối', N'LeadName', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 1, N'C')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'LeadTypeID', N'Loại đầu mối', N'LeadTypeID', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'{CheckValueInTableList} @Param1 = ''CRMT10201'', @Param2 = ''LeadTypeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'D')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'AssignedToUserID', N'Người phụ trách', N'AssignedToUserID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1103'', @Param2 = ''EmployeeID'', @SQLFilter = ''''', 1, N'E')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'Address', N'Địa chỉ', N'Address', 
    N'', 10, 250, 0, N'NVARCHAR(250)', N'', 0, N'F')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'LeadMobile', N'Di động', N'LeadMobile', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'G')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'LeadTel', N'Điện thoại bàn', N'LeadTel', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'H')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'Email', N'Email', N'Email', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'I')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'JobID', N'Nghề nghiệp', N'JobID', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'J')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'TitleID', N'Chức vụ', N'TitleID', 
    N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'K')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'LeadStatusID', N'Tình trạng đầu mối', N'LeadStatusID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT10401'', @Param2 = ''StageID'', @SQLFilter = ''TL.StageType IN (0,2) AND ISNULL(TL.Disabled, 0) = 0''', 0, N'L')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'CompanyName', N'Tên công ty', N'CompanyName', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'M')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BirthDate', N'Ngày sinh', N'BirthDate', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'Hobbies', N'Sở thích', N'Hobbies', 
    N'', 100, 250, 0, N'NVARCHAR(50)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'Website', N'Website', N'Website', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'Description', N'Diễn giải', N'Description', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'IsCommon', N'Dùng chung', N'IsCommon', 
    N'', 100, 50, 1, N'INT', N'', 0, N'R')

-- [Đình Hòa] - [19/03/2021] - Bổ sung thêm các trường import Lead - START ADD
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'Prefix', N'Xưng hô', N'Prefix', 
    N'', 100, 50, 1, N'INT', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'TradeMarkID', N'Thương hiệu', N'TradeMarkID', 
    N'', 100, 50, 1, N'INT', N'', 0, N'T')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'GenderID', N'Giới tính', N'GenderID', 
    N'', 100, 50, 1, N'INT', N'', 0, N'U')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'PlaceOfBirth', N'Nơi sinh', N'PlaceOfBirth', 
    N'', 100, 250, 0, N'VARCHAR(50)', N'', 0, N'V')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'MaritalStatusID', N'Tình trạng hôn nhân', N'MaritalStatusID', 
    N'', 100, 50, 1, N'INT', N'', 0, N'W')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BankAccountNo01', N'Tài khoản ngân hàng', N'BankAccountNo01', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'X')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BankIssueName01', N'Mở tại ngân hàng', N'BankIssueName01', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'Y')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'NotesPrivate', N'Ghi chú(Cá Nhân)', N'NotesPrivate', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'Z')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'CompanyDate', N'Ngày thành lập', N'CompanyDate', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'AA')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BusinessMobile', N'Điện thoại (Công ty)', N'BusinessMobile', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AB')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BusinessFax', N'Fax', N'BusinessFax', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AC')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'NotesCompany', N'Ghi chú (Công ty)', N'NotesCompany', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AD')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'NumOfEmployee', N'Số lượng nhân viên', N'NumOfEmployee', 
    N'', 100, 50, 1, N'INT', N'', 0, N'AE')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'EnterpriseDefinedID', N'Ngành nghề kinh doanh', N'EnterpriseDefinedID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'AF')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'VATCode', N'Mã số thuế', N'VATCode', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AG')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BusinessEmail', N'Email (Công ty)', N'BusinessEmail', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AH')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Lead', N'Đầu mối', N'Lead', N'CRMF2031', N'CRMT20301.xlsx', N' EXEC CRMP2031 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'BusinessAddress', N'Địa chỉ (Công ty)', N'BusinessAddress', 
    N'', 100, 250, 0, N'NVARCHAR(250)', N'', 0, N'AI')

-- [Đình Hòa] - [19/03/2021] -  END ADD

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Lead')
BEGIN
    INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
    [Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
    VALUES ('Lead', N'Đầu mối', 'Lead', 'Data', N'A', 10, N'C:\IMPORTS', N'CRMT20301.xlsx', 0,
    'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

----------------------- Nghiệp vụ khách hàng ----------------------- 

DELETE A00065 WHERE ImportTransTypeID = 'ListObject'

INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',1, 'DivisionID', N'Đơn vị', 'DivisionID', 'VARCHAR(50)', 1, 'A',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',2, 'MemberID', N'Mã khách hàng', 'MemberID', 'VARCHAR(50)', 0, 'B',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',3, 'MemberName', N'Tên khách hàng', 'MemberName', 'NVARCHAR(250)', 1, 'C',500, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',4, 'AssignedToUserID', N'Người phụ trách', 'AssignedToUserID', 'VARCHAR(50)', 1, 'D',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',5, 'Address', N'Địa chỉ', 'Address', 'NVARCHAR(150)', 0, 'E',150, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',6, 'Tel', N'Di động', 'Tel', 'NVARCHAR(150)', 1, 'F',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',7, 'Email', N'Email', 'Email', 'NVARCHAR(150)', 0, 'G',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',8, 'Fax', N'Fax', 'Fax', 'NVARCHAR(150)', 0, 'H',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',9, 'Website', N'Website', 'Website', 'NVARCHAR(500)', 0, 'I',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',10, 'Birthday', N'Ngày sinh', 'Birthday', 'DATETIME', 0, 'J',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',11, 'DeliveryAddress', N'Địa chỉ giao hàng', 'DeliveryAddress', 'NVARCHAR(150)', 0, 'K',150, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',12, 'DepartmentName', N'Địa chỉ thanh toán', 'DepartmentName', 'NVARCHAR(150)', 0, 'L',150, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',13, 'Description', N'Diễn giải', 'Description', 'NVARCHAR(Max)', 0, 'M',500, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',14, 'IsCommon', N'Dùng chung', 'IsCommon', 'Tinyint', 0, 'N',100, '') 
																																																																																			

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ListObject')
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
    ',N'@ImportTemplateID nvarchar(50),@ImportTemplateName nvarchar(50),@ImportTransTypeID nvarchar(50),@DefaultSheet nvarchar(4),@AnchorCol nvarchar(1),@StartRow int,@DataFolder nvarchar(10),@DefaultFileName nvarchar(50),@Disabled tinyint',@ImportTemplateID=N'ListObject',@ImportTemplateName=N'Danh mục khách hàng',@ImportTransTypeID=N'ListObject',@DefaultSheet=N'Data',@AnchorCol=N'A',@StartRow=8,@DataFolder=N'C:\IMPORTS',@DefaultFileName=N'CRMT10101',@Disabled=0

    ----------------------- Nghiệp vụ cơ hội ----------------------- 
  
DELETE FROM A00065 WHERE ImportTransTypeID = N'Opportunity'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'OpportunityID', N'Mã cơ hội', N'OpportunityID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 1, N'A')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'OpportunityName', N'Tên cơ hội', N'OpportunityName', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'', 1, N'B')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'StageID', N'Giai đoạn', N'StageID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT10401'', @Param2 = ''StageID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 1, N'C')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'CampaignID', N'Chiến dịch', N'CampaignID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT20401'', @Param2 = ''CampaignID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'D')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'AccountID', N'Khách hàng', N'AccountID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1202'', @Param2 = ''ObjectID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'E')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ExpectAmount', N'Giá trị', N'ExpectAmount', 
    N'', 100, 50, 1, N'DECIMAL(28)', N'', 0, N'F')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'PriorityID', N'Độ ưu tiên', N'PriorityID', 
    N'', 100, 50, 1, N'INT', N'{CheckValueInTableList} @Param1 = ''CRMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster= ''''CRMT00000006'''' AND ISNULL(TL.Disabled, 0) = 0''', 0, N'G')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'CauseID', N'Lý do kết thúc', N'CauseID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT10501'', @Param2 = ''CauseID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'H')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'Notes', N'Ghi chú', N'Notes', 
    N'', 100, 50, 0, N'VARCHAR(MAX)', N'', 0, N'I')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'AssignedToUserID', N'Người phụ trách', N'AssignedToUserID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1103'', @Param2 = ''EmployeeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 1, N'J')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'StartDate', N'Thời gian bắt đầu', N'StartDate', 
    N'', 100, 50, 2, N'VARCHAR(50)', N'', 0, N'K')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'ExpectedCloseDate', N'Thời gian kết thúc', N'ExpectedCloseDate', 
    N'', 100, 50, 2, N'VARCHAR(50)', N'', 0, N'L')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'Rate', N'Xác xuất thành công', N'Rate', 
    N'', 100, 50, 1, N'DECIMAL(28)', N'', 0, N'M')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'NextActionID', N'Hành động tiếp theo', N'NextActionID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT10801'', @Param2 = ''NextActionID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'N')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'NextActionDate', N'Ngày thực hiện tiếp theo', N'NextActionDate', 
    N'', 100, 50, 2, N'VARCHAR(50)', N'', 0, N'O')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'SourceID', N'Nguồn gốc', N'SourceID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT10201'', @Param2 = ''LeadTypeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'P')
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Opportunity', N'Cơ hội', N'Opportunity', N'CRMF2050', N'CRMT20501.xlsx', N'EXEC CRMP2051 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'IsCommon', N'Dùng chung', N'IsCommon', 
    N'', 100, 50, 1, N'INT', N'', 0, N'Q')


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Opportunity')
BEGIN
    INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
    [Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
    VALUES ('Opportunity', N'Cơ hội', 'Opportunity', 'Data', N'A', 10, N'C:\IMPORTS', N'CRMT20501.xlsx', 0,
    'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

    ----------------------- Nghiệp vụ liên hệ ----------------------- 
  
DELETE FROM A00065 WHERE ImportTransTypeID = N'Contact'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'Prefix', N'Xưng hô', N'Prefix', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'A')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'FirstName', N'Họ và tên đệm', N'FirstName', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'B')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'LastName', N'Tên', N'LastName', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'C')
	
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'ContactID', N'Mã liên hệ', N'ContactID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'D')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ContactName', N'Tên liên hệ', N'ContactName', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'', 1, N'E')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'Address', N'Địa chỉ', N'Address', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'F')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'HomeMobile', N'Di động', N'HomeMobile', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckIsNumeric} @Param1 = ''CRMT10001'', @Param2 = ''HomeMobile'', @SQLFilter = ''ISNUMERIC(DT.HomeMobile) = 0''', 1, N'G')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'HomeTel', N'Tel', N'HomeTel', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckIsNumeric} @Param1 = ''CRMT10001'', @Param2 = ''HomeTel'', @SQLFilter = ''ISNUMERIC(DT.HomeTel) = 0''', 0, N'H')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'HomeFax', N'Extent', N'HomeFax', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckIsNumeric} @Param1 = ''CRMT10001'', @Param2 = ''HomeFax'', @SQLFilter = ''ISNUMERIC(DT.HomeFax) = 0''', 0, N'I')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'HomeEmail', N'Email', N'HomeEmail', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'J')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'BusinessEmail', N'Email cơ quan', N'BusinessEmail', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'K')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'BusinessTel', N'Tel cơ quan', N'BusinessTel', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckIsNumeric} @Param1 = ''CRMT10001'', @Param2 = ''BusinessTel'', @SQLFilter = ''ISNUMERIC(DT.BusinessTel) = 0''', 0, N'L')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'BusinessFax', N'Fax cơ quan', N'BusinessFax', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckIsNumeric} @Param1 = ''CRMT10001'', @Param2 = ''BusinessFax'', @SQLFilter = ''ISNUMERIC(DT.BusinessFax) = 0''', 0, N'M')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'Title', N'Chức vụ', N'Title', 
    N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'N')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'DepartmentName', N'Phòng ban', N'DepartmentName', 
    N'', 100, 50, 0, N'NVARCHAR(50)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'AccountID', N'Mã khách hàng', N'AccountID', 
    N'', 100, 50, 2, N'VARCHAR(MAX)', N'', 1, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'BirthDate', N'Ngày sinh', N'BirthDate', 
    N'', 100, 50, 2, N'DATETIME', N'', 0, N'Q')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'Description', N'Diễn giải', N'Description', 
    N'', 100, 50, 0, N'NVARCHAR(MAX)', N'', 0, N'R')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Contact', N'Liên hệ', N'Contact', N'CRMF1000', N'CRMT10001.xlsx', N'EXEC CRMP1001 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'IsCommon', N'Dùng chung', N'IsCommon', 
    N'', 100, 50, 1, N'INT', N'', 0, N'S')

IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Contact')
BEGIN
    INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
    [Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
    VALUES ('Contact', N'Liên hệ', 'Contact', 'Data', N'A', 10, N'C:\IMPORTS', N'CRMT10001.xlsx', 0,
    'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END

    ----------------------- Nghiệp vụ chiến dịch ----------------------- 

DELETE FROM A00065 WHERE ImportTransTypeID = N'Campaign'

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 1, N'DivisionID', N'Mã đơn vị', N'DivisionID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValidDivision}', 1, N'B3')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 2, N'CampaignID', N'Mã chiến dịch', N'CampaignID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'', 0, N'A')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 3, N'CampaignName', N'Tên chiến dịch', N'CampaignName', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'', 1, N'B')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 4, N'AssignedToUserID', N'Người phụ trách', N'AssignedToUserID', 
    N'', 100, 50, 0, N'NVARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1103'', @Param2 = ''EmployeeID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 1, N'C')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 5, N'CampaignType', N'Loại chiến dịch', N'CampaignType', 
    N'', 100, 50, 1, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster= ''''CRMT00000011'''' AND ISNULL(TL.Disabled, 0) = 0''', 0, N'D')
	
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 6, N'ExpectOpenDate', N'Ngày bắt đầu chiến dịch', N'ExpectOpenDate', 
    N'', 100, 50, 2, N'DATETIME', N'', 1, N'E')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 7, N'ExpectCloseDate', N'Thời gian kết thúc', N'ExpectCloseDate', 
    N'', 100, 50, 2, N'DATETIME', N'', 1, N'F')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 8, N'PlaceDate', N'Ngày diễn ra', N'PlaceDate', 
    N'', 100, 50, 2, N'DATETIME', N'', 1, N'G')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 9, N'CampaignStatus', N'Tình trạng chiến dịch', N'CampaignStatus', 
    N'', 100, 50, 1, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster= ''''CRMT00000012'''' AND ISNULL(TL.Disabled, 0) = 0''', 0, N'H')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 10, N'InventoryID', N'Mã sản phẩm', N'InventoryID', 
    N'', 100, 50, 0, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''AT1302'', @Param2 = ''InventoryID'', @SQLFilter = ''ISNULL(TL.Disabled, 0) = 0''', 0, N'I')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 11, N'Sponsor', N'Nhà tài trợ', N'Sponsor', 
    N'', 100, 50, 0, N'NVARCHAR(250)', N'', 0, N'J')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 12, N'Description', N'Ghi chú', N'Description', 
    N'', 100, 50, 0, N'NVARCHAR(MAX)', N'', 0, N'K')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 13, N'BudgetCost', N'Ngân sách chiến dịch', N'BudgetCost', 
    N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'L')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 14, N'ExpectedRevenue', N'Doanh thu kỳ vọng', N'ExpectedRevenue', 
    N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'M')
	
INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 15, N'ExpectedSales', N'Số lượng bán hàng kỳ vọng', N'ExpectedSales', 
    N'', 100, 50, 1, N'INT', N'', 0, N'N')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 16, N'ExpectedROI', N'Hoàn vốn kỳ vọng', N'ExpectedROI', 
    N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'O')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 17, N'ActualCost', N'Chi phí chiến dịch', N'ActualCost', 
    N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'P')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 18, N'ExpectedResponse', N'Đáp ứng mong đợi', N'ExpectedResponse', 
    N'', 100, 50, 1, N'VARCHAR(50)', N'{CheckValueInTableList} @Param1 = ''CRMT0099'', @Param2 = ''ID'', @SQLFilter = ''TL.CodeMaster= ''''CRMT00000013'''' AND ISNULL(TL.Disabled, 0) = 0''', 0, N'Q')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 19, N'ActualSales', N'Số lượng bán hàng thực tế', N'ActualSales', 
    N'', 100, 50, 1, N'INT', N'', 0, N'R')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 20, N'ActualROI', N'Hoàn vốn thực tế', N'ActualROI', 
    N'', 100, 50, 1, N'DECIMAL(28,8)', N'', 0, N'S')

INSERT INTO A00065(ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ScreenID, TemplateFileName, ExecSQL, OrderNum, ColID, ColName, ColNameEng, 
    InputMask, ColWidth, ColLength, ColType, ColSQLDataType, CheckExpression, IsObligated, DataCol)
VALUES (N'Campaign', N'Chiến dịch', N'Campaign', N'CRMF2040', N'CRMT20401.xlsx', N'EXEC CRMP2041 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTransTypeID = @ImportTransTypeID, @XML = @XML', 21, N'IsCommon', N'Dùng chung', N'IsCommon', 
    N'', 100, 50, 1, N'INT', N'', 0, N'T')


IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'Campaign')
BEGIN
    INSERT INTO A01065(ImportTemplateID, ImportTemplateName, ImportTransTypeID, DefaultSheet, AnchorCol, StartRow, DataFolder, DefaultFileName, 
    [Disabled],CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
    VALUES ('Campaign', N'Chiến dịch', 'Campaign', 'Data', N'A', 10, N'C:\IMPORTS', N'CRMT20401.xlsx', 0,
    'ASOFTADMIN', GETDATE(), 'ASOFTADMIN', GETDATE())
END