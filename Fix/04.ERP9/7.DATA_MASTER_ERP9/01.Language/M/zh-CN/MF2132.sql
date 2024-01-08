-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2132- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2132';

SET @LanguageValue = N'詳細製作流程之查看';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工序計量單位';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總時間';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingTime', @FormID, @LanguageValue, @Language;

