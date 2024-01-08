---Create by Thị Phượng Date 30/05/2017_ Danh mục khách hàng
---Modified on 27/5/2019 by Hồng Thảo: Xóa file import cho khách hàng CBD vì không dùng 
---Modified on 18/08/2022 by Hoài Bảo: Comment import data khách hàng cho trường hợp chuẩn vì đã import ở file 03_A00065_Data_NghiepvuCRM
DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 103
BEGIN 
DELETE A00065 WHERE ImportTransTypeID = 'ListObject'
END 

--ELSE 

--BEGIN 

--DELETE A00065 WHERE ImportTransTypeID = 'ListObject'

--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',1, 'DivisionID', N'Đơn vị', 'DivisionID', 'VARCHAR(50)', 1, 'A',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',2, 'AccountID', N'Mã khách hàng', 'AccountID', 'VARCHAR(50)', 1, 'B',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',3, 'AccountName', N'Tên khách hàng', 'AccountName', 'NVARCHAR(250)', 1, 'C',500, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',4, 'AssignedToUserID', N'Người phụ trách', 'AssignedToUserID', 'VARCHAR(50)', 1, 'D',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',5, 'Address', N'Địa chỉ', 'Address', 'NVARCHAR(150)', 0, 'E',150, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',6, 'Tel', N'Di động', 'Tel', 'NVARCHAR(150)', 1, 'F',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',7, 'Email', N'Email', 'Email', 'NVARCHAR(150)', 0, 'G',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',8, 'Fax', N'Fax', 'Fax', 'NVARCHAR(150)', 0, 'H',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',9, 'Website', N'Website', 'Website', 'NVARCHAR(500)', 0, 'I',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',10, 'BirthDate', N'Ngày sinh', 'BirthDate', 'Datetime', 0, 'J',100, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',11, 'DeliveryAddress', N'Địa chỉ giao hàng', 'DeliveryAddress', 'NVARCHAR(150)', 0, 'K',150, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',12, 'DepartmentName', N'Địa chỉ thanh toán', 'DepartmentName', 'NVARCHAR(150)', 0, 'L',150, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',13, 'Description', N'Diễn giải', 'Description', 'NVARCHAR(Max)', 0, 'M',500, '') 
--INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('ListObject',N'Danh mục khách hàng','ListObject','EXEC CRMP10103 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','CRMF1010', 'CRMT10101',14, 'IsCommon', N'Dùng chung', 'IsCommon', 'Tinyint', 0, 'N',100, '') 
																																																																																			

--IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'ListObject')
--exec sp_executesql N'
--      INSERT INTO A01065(
--      ImportTemplateID,
--      ImportTemplateName,
--      ImportTransTypeID,
--      DefaultSheet,
--      AnchorCol,
--      StartRow,
--      DataFolder,
--      DefaultFileName,
--      Disabled,
--      CreateUserID,
--      CreateDate,
--      LastModifyUserID,
--      LastModifyDate
--      ) VALUES (
--      @ImportTemplateID,
--      @ImportTemplateName,
--      @ImportTransTypeID,
--      @DefaultSheet,
--      @AnchorCol,
--      @StartRow,
--      @DataFolder,
--      @DefaultFileName,
--      @Disabled,
--      ''ASOFTADMIN'',
--      GETDATE(),
--      ''ASOFTADMIN'',
--      GETDATE()
--      )
--    ',N'@ImportTemplateID nvarchar(50),@ImportTemplateName nvarchar(50),@ImportTransTypeID nvarchar(50),@DefaultSheet nvarchar(4),@AnchorCol nvarchar(1),@StartRow int,@DataFolder nvarchar(10),@DefaultFileName nvarchar(50),@Disabled tinyint',@ImportTemplateID=N'ListObject',@ImportTemplateName=N'Danh mục khách hàng',@ImportTransTypeID=N'ListObject',@DefaultSheet=N'Data',@AnchorCol=N'A',@StartRow=8,@DataFolder=N'C:\IMPORTS',@DefaultFileName=N'CRMT10101',@Disabled=0

--END 