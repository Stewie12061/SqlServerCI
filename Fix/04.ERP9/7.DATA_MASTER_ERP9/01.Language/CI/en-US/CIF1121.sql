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
SET @Language = 'en-US' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1121';

SET @LanguageValue = N'Division update';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ParentDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.VATNO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.AddressE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.District', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/city';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.City', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Logo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period start month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period start year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounted money';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BaseCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PeriodNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.QuantityDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit cost decimals';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.UnitCostDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal conversion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ConvertedDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent to Decimal';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PercentDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Industry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fiscal year beginning date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.FiscalBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The person signing the declaration';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxreturnPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Provincial level tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Managing Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID of the managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnitTaxNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.IsUseTaxAgent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentDistrict', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/city';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent contract reference number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate reference number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCertificate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.LastModifyDate', @FormID, @LanguageValue, @Language;

