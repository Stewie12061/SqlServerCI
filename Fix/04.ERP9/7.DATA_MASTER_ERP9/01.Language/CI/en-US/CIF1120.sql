-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1120- CI
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
SET @FormID = 'CIF1120';

SET @LanguageValue = N'List of divisions';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.ParentDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.DivisionNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.VATNO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.AddressE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.District', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/city';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.City', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Logo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period start month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.BeginMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period start year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.BeginYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounted money';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.BaseCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.PeriodNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.QuantityDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit cost decimals';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.UnitCostDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal conversion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.ConvertedDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent to Decimal';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.PercentDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.Industry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fiscal year beginning date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.FiscalBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The person signing the declaration';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxreturnPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Provincial level tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxDepartID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Managing Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.ManagingUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID of the managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.ManagingUnitTaxNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.IsUseTaxAgent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Office address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentDistrict', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/city';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent contract reference number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate reference number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.TaxAgentCertificate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1120.LastModifyDate', @FormID, @LanguageValue, @Language;

