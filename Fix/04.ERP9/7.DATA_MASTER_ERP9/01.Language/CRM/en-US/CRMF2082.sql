-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2082- CRM
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
SET @FormID = 'CRMF2082';

SET @LanguageValue = N'Request view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recording time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feeback';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify UserID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.FieldAPKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.FieldAPKOpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RelatedToName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Keyword information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ThongTinYeuCau', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Management Issues';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feedback';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.NoiDungPhanHoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tasks';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabOOT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request content';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2082.NoiDungYeuCau', @FormID,@LanguageValue, @Language, NULL

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.StatusID', @FormID, @LanguageValue, @Language;


