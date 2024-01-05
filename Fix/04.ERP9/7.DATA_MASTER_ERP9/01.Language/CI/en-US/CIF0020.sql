                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF0020 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:16:29 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF0020' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF0020' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF0020.Email', N'CIF0020', N'Email address', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Fax', N'CIF0020', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Director', N'CIF0020', N'Manager', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Logo', N'CIF0020', N'Company logo', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.IsPriceControl', N'CIF0020', N'Price control', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.CountryID', N'CIF0020', N'Country', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Tel', N'CIF0020', N'Mobile fone', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.PeriodNum', N'CIF0020', N'Number of accounting periods', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.UnitCostDecimals', N'CIF0020', N'Unit price decimal', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.PercentDecimal', N'CIF0020', N'Percent decimal', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.ConvertedDecimals', N'CIF0020', N'Converted decimal', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.QuantityDecimals', N'CIF0020', N'Quantity decimal', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.BankAccountID', N'CIF0020', N'Account bank', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.CompanyName', N'CIF0020', N'Company name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.ShortName', N'CIF0020', N'Short name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Title', N'CIF0020', N'Company info setting', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Tab01', N'CIF0020', N'Company info', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Tab02', N'CIF0020', N'Other info', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.BaseCurrencyID', N'CIF0020', N'Money accounted', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.CityID', N'CIF0020', N'City', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.Address', N'CIF0020', N'Headquarters', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.CommissionManageRate', N'CIF0020', N'Commission manage rate', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF0020.CommissionEmployeeRate', N'CIF0020', N'Commission employee rate', N'en-US', NULL

