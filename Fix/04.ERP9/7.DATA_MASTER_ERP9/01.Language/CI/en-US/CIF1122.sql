-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1122- CI
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
SET @FormID = 'CIF1122';

SET @LanguageValue = N'Division view';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ParentDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.VATNO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.AddressE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.District', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.City', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logos';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Logo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The month the accounting period begins';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BeginMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The year the accounting period begins';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BeginYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year end date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pre-planning';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BaseCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of accounting periods';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.PeriodNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.QuantityDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd number of unit prices';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.UnitCostDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd number converted';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ConvertedDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Odd number of percent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.PercentDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Industry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fiscal year start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.FiscalBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person signing the declaration';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxreturnPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department-level tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Management tax agency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxDepartID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ManagingUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code of the managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ManagingUnitTaxNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.IsUseTaxAgent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Office address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentDistrict', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent contract number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day contract';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of certificates';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentCertificate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinDaiLyThue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinNopThue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinDonVi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.StatusID' , @FormID, @LanguageValue, @Language;