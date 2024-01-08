-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2030- CRM
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
SET @FormID = 'CRMF2030';

SET @LanguageValue = N'Lead category';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.JobID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead state';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadSourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gender';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.GenderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of birth';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.MaritalStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BankAccountNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue bank name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BankIssueName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NotesPrivate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hobbies';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Hobbies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of establishment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CompanyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NumOfEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.OwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.EnterpriseDefinedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NotesCompany', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.VATCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.ConvertOwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead state';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.TableREL2', @FormID, @LanguageValue, @Language;

