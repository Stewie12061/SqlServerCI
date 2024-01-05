-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2020 
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
SET @FormID = 'QCF2020';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranMonth';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranYear';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List handling of defective items';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DepartmentName.CB', @FormID, @LanguageValue, @Language;
