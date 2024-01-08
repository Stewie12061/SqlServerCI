                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0044 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:29:22 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0044' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0044' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0044.Title', N'POSF0044', N'Update card type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.DiscountRate', N'POSF0044', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.ToScore', N'POSF0044', N'To source', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.DivisionID', N'POSF0044', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.Disabled', N'POSF0044', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.TypeNo', N'POSF0044', N'Card type ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.TypeName', N'POSF0044', N'Card type name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0044.FromScore', N'POSF0044', N'From source', N'en-US', NULL

