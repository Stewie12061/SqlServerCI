-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2053- HRM
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2053';

SET @LanguageValue = N'批准外出申請單';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外出申請單代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'堵塞';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機構名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工段名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Description', @FormID, @LanguageValue, @Language;

