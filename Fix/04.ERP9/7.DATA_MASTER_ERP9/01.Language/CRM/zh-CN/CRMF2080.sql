-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2080- CRM
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
SET @FormID = 'CRMF2080';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'主題';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發行版本';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.FieldAPKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.FieldAPKOpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RelatedToName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.FromToDate', @FormID, @LanguageValue, @Language;

