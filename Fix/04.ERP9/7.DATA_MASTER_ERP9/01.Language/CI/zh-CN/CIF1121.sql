-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1121- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1121';

SET @LanguageValue = N'單位之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'家長單位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ParentDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位名稱（英）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅號';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.VATNO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.AddressE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/县';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.District', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.City', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Logo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計期間開始的月份';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計期間開始的年份';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年份開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年度結束日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'核算金額';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BaseCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計期間數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PeriodNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量奇數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.QuantityDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價奇數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.UnitCostDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算奇數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ConvertedDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'百分比奇數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PercentDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Industry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'財政年度開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.FiscalBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽署聲明的人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxreturnPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'局级稅務機關';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管理稅務機關';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管理單位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管理單位稅代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnitTaxNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務代理';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.IsUseTaxAgent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務代理人代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務代理名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'辦公室地址';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentDistrict', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務代理合約號';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同有效期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務代理人員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'證書號';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCertificate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.LastModifyDate', @FormID, @LanguageValue, @Language;

