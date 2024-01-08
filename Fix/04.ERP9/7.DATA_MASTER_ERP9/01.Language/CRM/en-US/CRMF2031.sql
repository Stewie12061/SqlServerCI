-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2031- CRM
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
SET @FormID = 'CRMF2031';

SET @LanguageValue = N'Update lead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Prefix';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.JobID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead state';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadSourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gender';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.GenderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of birth';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birth place';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.MaritalStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BankAccountNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue bank name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BankIssueName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.NotesPrivate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hobbies';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Hobbies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of establishment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CompanyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.NumOfEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.OwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.EnterpriseDefinedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.NotesCompany', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.VATCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ConvertOwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead state';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead type ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.StageID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.StageName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessLinesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessLinesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign Code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Locate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Dinhvi', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Company information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThongTinCongTy',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Personal information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThongTinCaNhan',  @FormID, @LanguageValue, @Language;

