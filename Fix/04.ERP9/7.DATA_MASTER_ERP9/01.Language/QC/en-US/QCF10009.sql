-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10009- QC
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
SET @FormID = 'QCF10009';

SET @LanguageValue = N'Choose Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The date of the vote';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.VoucherDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.ShiftID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.MachineName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.MachineID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine chief';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee01', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.DepartmentID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC staff';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee02', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.DepartmentName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mechanic';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse assistant';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packaging worker';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervising producer';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.BatchNo', @FormID, @LanguageValue, @Language;

