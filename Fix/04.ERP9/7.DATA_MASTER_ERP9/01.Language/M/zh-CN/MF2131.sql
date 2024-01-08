-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2131- M
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
SET @FormID = 'MF2131';

SET @LanguageValue = N'生產流程之更新';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工藝計量單位';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程時間';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingTime', @FormID, @LanguageValue, @Language;

