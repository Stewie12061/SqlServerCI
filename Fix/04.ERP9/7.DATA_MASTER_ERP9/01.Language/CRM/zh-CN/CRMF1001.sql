-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1001- CRM
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
SET @FormID = 'CRMF1001';

SET @LanguageValue = N'聯繫代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稱呼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓和中間名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫人姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'移動';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作為客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室電子郵箱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機構電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'坊/社';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'坊/社';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生地';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分配';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開戶在';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DistrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.FromToDate', @FormID, @LanguageValue, @Language;

