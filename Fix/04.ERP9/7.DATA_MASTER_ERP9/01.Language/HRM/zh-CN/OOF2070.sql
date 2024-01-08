-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2070- HRM
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
SET @FormID = 'OOF2070';

SET @LanguageValue = N'換班申請單';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換班單代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'堵塞';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'堵塞';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2070.Description', @FormID, @LanguageValue, @Language;

