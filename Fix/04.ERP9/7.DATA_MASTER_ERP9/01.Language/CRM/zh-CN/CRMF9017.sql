-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9017- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9017';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.LastModifyDate', @FormID, @LanguageValue, @Language;

