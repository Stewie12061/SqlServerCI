-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2052- CRM
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
SET @FormID = 'CRMF2052';

SET @LanguageValue = N'Opportunity view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExpectAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for ending';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CauseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In-charge person ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected end date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExpectedCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Probability of success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action added to calendar';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsAddCalendar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for ending';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CauseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Key word';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SalesTagID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOT2101', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCMNT90051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT10001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mission';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT90041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT90051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tasks';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOOT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Quote';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT20801', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOOT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ThongTinCoHoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT2181', @FormID, @LanguageValue, @Language;

