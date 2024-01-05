DECLARE @ScreenID NVARCHAR(MAX)
DECLARE @ColumnName NVARCHAR(MAX)
DECLARE @IDLanguage NVARCHAR(MAX)
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ScreenID = N'QCF2011'

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Title'
SET @FormID = N'QCF2011'
SET @Text = N'Scale product weight'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.APK'
SET @FormID = N'QCF2011'
SET @Text = N''
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DivisionID'
SET @FormID = N'QCF2011'
SET @Text = N'Division'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherTypeID'
SET @FormID = N'QCF2011'
SET @Text = N'Voucher type'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Voucher_QCT2000'
SET @FormID = N'QCF2011'
SET @Text = N'Product quality voucher'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherNo'
SET @FormID = N'QCF2011'
SET @Text = N'Voucher no'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherDate'
SET @FormID = N'QCF2011'
SET @Text = N'Voucher date'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.TranMonth'
SET @FormID = N'QCF2011'
SET @Text = N'TranMonth'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.TranYear'
SET @FormID = N'QCF2011'
SET @Text = N'TranYear'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ManufacturingDate'
SET @FormID = N'QCF2011'
SET @Text = N'Manufacturing date'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftID'
SET @FormID = N'QCF2011'
SET @Text = N'Shift'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftName'
SET @FormID = N'QCF2011'
SET @Text = N'Shift'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineID'
SET @FormID = N'QCF2011'
SET @Text = N'Machine'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineName'
SET @FormID = N'QCF2011'
SET @Text = N'Machine'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DepartmentID'
SET @FormID = N'QCF2011'
SET @Text = N'Workshop'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DepartmentName'
SET @FormID = N'QCF2011'
SET @Text = N'Workshop'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Notes'
SET @FormID = N'QCF2011'
SET @Text = N'Notes'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.GrossWeight'
SET @FormID = N'QCF2011'
SET @Text = N'Gross weight'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.NetWeight'
SET @FormID = N'QCF2011'
SET @Text = N'Net weight'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherTypeID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Code'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherTypeName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Name'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Code'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Name'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Code'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Name'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherNo.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Voucher no'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherDate.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Voucher date'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DeleteFlg'
SET @FormID = N'QCF2011'
SET @Text = N''
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.CreateDate'
SET @FormID = N'QCF2011'
SET @Text = N'Create date'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.CreateUserID'
SET @FormID = N'QCF2011'
SET @Text = N'Create user'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.LastModifyUserID'
SET @FormID = N'QCF2011'
SET @Text = N'Last modify user'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.LastModifyDate'
SET @FormID = N'QCF2011'
SET @Text = N'Last modify date'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.InventoryID'
SET @FormID = N'QCF2011'
SET @Text = N'Inventory ID'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.InventoryName'
SET @FormID = N'QCF2011'
SET @Text = N'Inventory name'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.BatchNo'
SET @FormID = N'QCF2011'
SET @Text = N'Batch no'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Machine'
SET @FormID = N'QCF2011'
SET @Text = N'Machine'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.AutoScale'
SET @FormID = N'QCF2011'
SET @Text = N'Auto scale'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Choose'
SET @FormID = N'QCF2011'
SET @Text = N'Choose'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.OtherUnitID'
SET @FormID = N'QCF2011'
SET @Text = N'Other unit'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.OtherQuantity'
SET @FormID = N'QCF2011'
SET @Text = N'Other quantity'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

