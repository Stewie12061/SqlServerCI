-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1091- CRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1091';

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach File';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update support dictionary ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support Dictionary ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feedback deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feedback';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feedback deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.TimeFeedbackName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.KindID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1091.KindName.CB', @FormID, @LanguageValue, @Language;