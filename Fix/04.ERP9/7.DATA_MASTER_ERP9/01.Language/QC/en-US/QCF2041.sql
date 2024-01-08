-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2041- QC
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'QC';
SET @FormID = 'QCF2041';

SET @LanguageValue = N'Machine operating parameters';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DeleteFlg', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.CreateDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.CreateUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ShiftID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.LastModifyDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.MachineID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DepartmentName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'PLU';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.InventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherDate.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.InventoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.InventoryName.CB', @FormID, @LanguageValue, @Language
;
SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.BatchNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory info';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.TabQCT2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.APKInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.StandardUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.StandardValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.UnitName.CB', @FormID, @LanguageValue, @Language;
