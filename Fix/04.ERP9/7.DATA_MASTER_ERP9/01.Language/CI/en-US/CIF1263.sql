                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1263 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:22:02 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1263' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1263' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1263.DiscountPercent', N'CIF1263', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1263.Title', N'CIF1263', N'Update details discount by bill', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1263.ToValues', N'CIF1263', N'To value', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1263.Notes', N'CIF1263', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1263.DiscountAmount', N'CIF1263', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1263.FromValues', N'CIF1263', N'From values', N'en-US', NULL

