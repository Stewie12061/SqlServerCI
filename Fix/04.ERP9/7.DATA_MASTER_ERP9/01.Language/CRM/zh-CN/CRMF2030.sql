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
SET @Language = 'zh-CN'  
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2030';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.JobID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadSourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.GenderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'婚姻狀況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.MaritalStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BankAccountNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開戶在';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BankIssueName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NotesPrivate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'興趣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Hobbies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CompanyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'網站';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工人數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NumOfEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.OwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'企業類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.EnterpriseDefinedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NotesCompany', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.VATCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CT地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.ConvertOwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業聯繫來源名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.FromToDate', @FormID, @LanguageValue, @Language;

