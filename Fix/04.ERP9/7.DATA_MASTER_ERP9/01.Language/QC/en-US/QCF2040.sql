-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2040- QC
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
SET @FormID = 'QCF2040';

SET @LanguageValue = N'Machine operating parameters';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.DeleteFlg', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.CreateDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.CreateUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.ShiftID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.LastModifyDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.DepartmentID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.DepartmentName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.DepartmentName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.MachineID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.InventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2040.VoucherDate.CB', @FormID, @LanguageValue, @Language;
