-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2030- QC
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
SET @FormID = 'QCF2030';

SET @LanguageValue = N'Machine technical parameters';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.DeleteFlg', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.CreateDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.CreateUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.ShiftID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last edited date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.LastModifyDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last editor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.DepartmentID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.DepartmentName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.DepartmentName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.MachineID.CB', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2030.VoucherDate.CB', @FormID, @LanguageValue, @Language;
