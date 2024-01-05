
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2050 
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
SET @FormID = 'QCF2050';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranMonth';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranYear';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine chief';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName01.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC Employee';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName02.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machinist';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName03.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse filler';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName04.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName05.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production supervisor';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName06.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of Material import slip';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.Title', @FormID, @LanguageValue, @Language;

