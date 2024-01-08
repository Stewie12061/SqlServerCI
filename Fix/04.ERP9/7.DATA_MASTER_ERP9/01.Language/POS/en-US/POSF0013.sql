                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0013 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:09:56 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0013' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0013' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0013.Title', N'POSF0013', N'Payment forms list', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0013.DivisionIDFilter', N'POSF0013', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0013.IsCommonFilter', N'POSF0013', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0013.DisabledFilter', N'POSF0013', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0013.PaymentIDFilter', N'POSF0013', N'Payment form ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0013.PaymentNameFilter', N'POSF0013', N'Payment name', N'en-US', NULL

