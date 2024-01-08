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

SET @LanguageValue = N'Parent unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ParentDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.VATNO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.AddressE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.District', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.City', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logos';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Logo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The month the accounting period begins';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The year the accounting period begins';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year end date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pre-planning';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BaseCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of accounting periods';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PeriodNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.QuantityDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd number of unit prices';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.UnitCostDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd number converted';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ConvertedDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd number of percent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PercentDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Industry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fiscal year start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.FiscalBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person signing the declaration';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxreturnPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department-level tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Management tax agency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code of the managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnitTaxNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.IsUseTaxAgent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Office address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentDistrict', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent contract number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day contract';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of certificates';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCertificate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.LastModifyDate', @FormID, @LanguageValue, @Language;

