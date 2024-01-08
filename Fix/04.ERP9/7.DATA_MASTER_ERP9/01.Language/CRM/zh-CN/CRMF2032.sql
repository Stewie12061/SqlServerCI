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
SET @Language = 'zh-CN'  
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2032';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.JobID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadSourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.GenderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生地';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'婚姻狀況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.MaritalStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BankAccountNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開戶在';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BankIssueName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NotesPrivate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'興趣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Hobbies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CompanyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'網站';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工人數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NumOfEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.OwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.EnterpriseDefinedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NotesCompany', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.VATCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ConvertOwnerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.FromToDate', @FormID, @LanguageValue, @Language;

