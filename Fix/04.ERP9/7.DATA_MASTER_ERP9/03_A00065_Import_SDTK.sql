---Create by Thị Phượng Date 30/05/2017_ Phiếu số dư tồn kho
---Modified on 27/5/2019 by Hồng Thảo: Xóa file import cho khách hàng CBD vì không dùng 

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 103
BEGIN 
DELETE A00065 WHERE ImportTransTypeID = 'InventoryBalance'
END 
ELSE 

BEGIN 
DELETE A00065 WHERE ImportTransTypeID = 'InventoryBalance'

INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',1, 'DivisionID', N'Đơn vị', 'DivisionID', 'VARCHAR(50)', 1, 'A',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',2, 'ShopID', N'Mã cửa hàng', 'ShopID', 'VARCHAR(50)', 1, 'B',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',3, 'WareHouseID', N'Mã kho cửa hàng', 'WareHouseID', 'VARCHAR(50)', 1, 'C',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',4, 'InventoryID', N'Mã mặt hàng', 'InventoryID', 'VARCHAR(50)', 1, 'D',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',5, 'InventoryName', N'Tên mặt hàng', 'InventoryName', 'NVARCHAR(250)', 1, 'E',150, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',6, 'UnitID', N'Mã đơn vị tính', 'UnitID', 'VARCHAR(50)', 1, 'F',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',7, 'Quantity', N'Số lượng', 'Quantity', 'INT', 1, 'G',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',8, 'UnitPrice', N'Đơn giá', 'UnitPrice', 'Decimal(28,8)', 0, 'H',100, '') 
INSERT INTO A00065 (ImportTransTypeID, ImportTransTypeName, ImportTransTypeNameEng, ExecSQL, ScreenID, TemplateFileName,OrderNum, ColID, ColName, ColNameEng, ColSQLDataType, IsObligated, DataCol, ColWidth, InputMask) VALUES ('InventoryBalance',N'Phiếu số dư tồn kho','InventoryBalance','EXEC POSP00381 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML','POSF0054', 'POST0038',9, 'Description', N'Diễn giải', 'Description', 'NVARCHAR(500)', 0, 'I',100, '') 
																																																																																			
IF NOT EXISTS (SELECT TOP 1 1 FROM A01065 WHERE ImportTemplateID = 'InventoryBalance')
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
    ',N'@ImportTemplateID nvarchar(50),@ImportTemplateName nvarchar(50),@ImportTransTypeID nvarchar(50),@DefaultSheet nvarchar(4),@AnchorCol nvarchar(1),@StartRow int,@DataFolder nvarchar(10),@DefaultFileName nvarchar(50),@Disabled tinyint',@ImportTemplateID=N'InventoryBalance',@ImportTemplateName=N'Phiếu số dư tồn kho',@ImportTransTypeID=N'InventoryBalance',@DefaultSheet=N'Data',@AnchorCol=N'A',@StartRow=8,@DataFolder=N'C:\IMPORTS',@DefaultFileName=N'POST0038',@Disabled=0

END 