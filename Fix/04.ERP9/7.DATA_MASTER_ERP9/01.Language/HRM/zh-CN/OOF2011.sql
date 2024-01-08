-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2011- HRM
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
SET @FormID = 'OOF2011';

SET @LanguageValue = N'更新請假單';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請假單代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'堵塞';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工段名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Description', @FormID, @LanguageValue, @Language;

