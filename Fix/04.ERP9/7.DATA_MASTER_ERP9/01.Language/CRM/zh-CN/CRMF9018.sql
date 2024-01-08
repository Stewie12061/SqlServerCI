-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9018- CRM
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
SET @FormID = 'CRMF9018';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持詞典代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'響應時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'反饋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'響應時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.TimeFeedbackName', @FormID, @LanguageValue, @Language;

