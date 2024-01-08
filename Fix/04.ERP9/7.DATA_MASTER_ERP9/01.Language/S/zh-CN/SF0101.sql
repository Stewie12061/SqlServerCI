-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0101- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0101';

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件檔名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LastModifyDate', @FormID, @LanguageValue, @Language;

