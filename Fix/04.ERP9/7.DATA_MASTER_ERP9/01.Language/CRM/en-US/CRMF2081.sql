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
SET @Language = 'en-US' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2081';

SET @LanguageValue = N'Update request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recording Time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feeback';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OpportunityID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FieldAPKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FieldAPKOpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RelatedToName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2181.TablePrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2181.TablePriceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.OpportunityID.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Opportunity';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.OpportunityName.CB', @FormID, @LanguageValue, @Language, NULL
