-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2081- CRM
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
SET @FormID = 'CRMF2081';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'確認時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'反饋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求內容';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發行版本';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FieldAPKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FieldAPKOpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RelatedToName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FromToDate', @FormID, @LanguageValue, @Language;

