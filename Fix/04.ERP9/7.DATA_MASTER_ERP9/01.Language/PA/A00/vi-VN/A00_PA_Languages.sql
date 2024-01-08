                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ A00 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 2:57:53 PM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'A00' and Module = N'00'
-- SELECT * FROM A00001 WHERE FormID = 'A00' and Module = N'00' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'00', N'A00.PAT10101', N'A00', N'Năng lực', N'vi-VN', NULL
EXEC ERP9AddLanguage N'00', N'A00.PAT10102', N'A00', N'Năng lực tiêu chuẩn', N'vi-VN', NULL
EXEC ERP9AddLanguage N'00', N'A00.PAT10002', N'A00', N'Từ điển năng lực tiêu chuẩn', N'vi-VN', NULL