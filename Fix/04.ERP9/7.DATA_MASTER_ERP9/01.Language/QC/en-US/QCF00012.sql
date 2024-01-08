-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF00012- QC
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
SET @FormID = 'QCF00012';

SET @LanguageValue = N'Choose first shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of manufacture';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop name';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.ShiftName.CB', @FormID, @LanguageValue, @Language;

