-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2031- QC
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
SET @FormID = 'QCF2031';

SET @LanguageValue = N'Machine technical parameters';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.TitlePK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document month';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Five documents';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production shifts';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Entry form at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.DeleteFlg', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.CreateDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.CreateUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.ShiftID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.LastModifyDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.MachineID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.DepartmentName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.VoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard value';
EXEC ERP9AddLanguage @ModuleID, 'QCF2031.StandardValue', @FormID, @LanguageValue, @Language;

