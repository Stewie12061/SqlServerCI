-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1373-CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1373';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1373.Notes', @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;