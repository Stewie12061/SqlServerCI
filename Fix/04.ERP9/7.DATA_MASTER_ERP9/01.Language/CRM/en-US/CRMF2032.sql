-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2032- CRM
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
SET @FormID = 'CRMF2032';

SET @LanguageValue = N'View lead details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.JobID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead state';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadSourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gender';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.GenderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of birth';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birth place';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.MaritalStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BankAccountNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue bank name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BankIssueName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NotesPrivate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hobbies';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Hobbies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of establishment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CompanyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of orders per employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NumOfEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.OwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.EnterpriseDefinedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NotesCompany', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.VATCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ConvertOwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead state';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned To UserName';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT20401', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Choose the person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.btnChooseAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT20501', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Locate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT20302', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trade Mark';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TradeMarkID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT10001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCMNT90051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mission';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT90041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personal information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThongTinCaNhan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThongTinChung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThongTinCongTy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabOOT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete the person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.btnDeleteAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Target';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ConversionTargetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.StatusDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serminar Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.SerminarName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thematic Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThematicName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of call history';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabOOT2180', @FormID, @LanguageValue, @Language;