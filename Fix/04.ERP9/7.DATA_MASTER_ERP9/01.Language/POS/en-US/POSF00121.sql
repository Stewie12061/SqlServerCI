                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00121 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:09:08 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00121' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00121' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00121.PromoteRate', N'POSF00121', N'% Promotion', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.ToQuantity', N'POSF00121', N'To quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.UnitID', N'POSF00121', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.Title', N'POSF00121', N'Promotion inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.PromoteType', N'POSF00121', N'Promotion type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.PromoteID', N'POSF00121', N'Promotion inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.FromDate', N'POSF00121', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.ToDate', N'POSF00121', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.PromoteQuantity', N'POSF00121', N'Promotion quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.PromoteName', N'POSF00121', N'Promotion name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00121.FormQuantity', N'POSF00121', N'From quantity', N'en-US', NULL

