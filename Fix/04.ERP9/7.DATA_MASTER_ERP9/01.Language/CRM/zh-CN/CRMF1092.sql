-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1092- CRM
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
SET @FormID = 'CRMF1092';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持詞典代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'響應時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'反饋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'響應時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1092.TimeFeedbackName', @FormID, @LanguageValue, @Language;

