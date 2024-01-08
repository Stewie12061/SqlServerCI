-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000- CRM
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
SET @FormID = 'CRMF1000';

SET @LanguageValue = N'聯繫代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稱呼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓和中間名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫人姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'移動';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作為客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室電子郵箱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機構電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區/公社代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生地';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開戶在';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DistrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.FromToDate', @FormID, @LanguageValue, @Language;

