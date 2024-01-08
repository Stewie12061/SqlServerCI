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

SET @LanguageValue = N'Parent division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ParentDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.VATNO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.AddressE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.District', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/city';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.City', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Logo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period start month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BeginMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period start year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BeginYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounted money';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BaseCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.PeriodNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.QuantityDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit cost decimals';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.UnitCostDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decimal conversion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ConvertedDecimals', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent to Decimal';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.PercentDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Industry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fiscal year beginning date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.FiscalBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The person signing the declaration';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxreturnPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Provincial level tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax authority';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxDepartID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Managing Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ManagingUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID of the managing unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ManagingUnitTaxNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.IsUseTaxAgent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of tax agent';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentDistrict', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/city';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent contract reference number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax agent staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate reference number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentCertificate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
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