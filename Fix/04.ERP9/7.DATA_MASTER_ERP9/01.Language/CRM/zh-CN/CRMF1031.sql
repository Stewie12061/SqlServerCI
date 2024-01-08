-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1031- CRM
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
SET @FormID = 'CRMF1031';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收電子郵件組代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件組名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.LastModifyDate', @FormID, @LanguageValue, @Language;

