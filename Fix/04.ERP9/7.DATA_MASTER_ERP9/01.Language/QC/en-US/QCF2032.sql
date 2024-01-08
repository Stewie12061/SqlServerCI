-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2032- QC
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
SET @FormID = 'QCF2032';

SET @LanguageValue = N'Machine technical parameters';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.APK', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Technical standard info';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.Detail', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.DepartmentName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.ShiftID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.VoucherDate.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.StandardID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.StandardName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2032.StandardValue', @FormID, @LanguageValue, @Language;

