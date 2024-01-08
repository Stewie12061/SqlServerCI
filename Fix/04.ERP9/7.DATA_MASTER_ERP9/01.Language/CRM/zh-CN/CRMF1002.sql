-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1002- CRM
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
SET @FormID = 'CRMF1002';

SET @LanguageValue = N'聯繫代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稱呼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓和中間名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫人姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'移動';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作為客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室電子郵箱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機構電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'坊/社機構';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣機構';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市機構';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公區號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'私家地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'坊/社私人住宅';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣私人住宅';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'私人住宅省/市';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'私家區域代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家私人住宅';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生地';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開戶在';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DistrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.FromToDate', @FormID, @LanguageValue, @Language;

