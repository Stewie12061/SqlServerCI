                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0043 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:28:55 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0043' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0043' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0043.DiscountRate', N'POSF0043', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.Title', N'POSF0043', N'Card type category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.ToScore', N'POSF0043', N'To source', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.DivisionID', N'POSF0043', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.Disabled', N'POSF0043', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.TypeNo', N'POSF0043', N'Card type ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.TypeName', N'POSF0043', N'Card type name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.FromScore', N'POSF0043', N'From source', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0043.IsCommon', N'POSF0043', N'Common', N'en-US', NULL

