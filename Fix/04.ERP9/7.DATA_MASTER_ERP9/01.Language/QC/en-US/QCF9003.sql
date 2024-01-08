-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF9003- QC
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
SET @Language = 'en-US'; 
SET @ModuleID = 'QC';
SET @FormID = 'QCF9003';

SET @LanguageValue = N'Choose Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The date of the vote';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.ShiftID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.MachineName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.MachineID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine chief';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee01', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packaging worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervising producer';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.BatchNo', @FormID, @LanguageValue, @Language;

