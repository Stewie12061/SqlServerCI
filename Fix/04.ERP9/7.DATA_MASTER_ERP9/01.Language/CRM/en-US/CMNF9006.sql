------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000 - CRM
--            Ngày tạo                                    Người tạo
--            07/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CMNF9006'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = '00';
SET @FormID = 'CMNF9006';

EXEC ERP9AddLanguage @ModuleID, N'CMNF9006.Title', @FormID, N'Attach', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9006.AttachName', @FormID, N'Attach name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9006.CreateDate', @FormID, N'Create date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9006.CreateUserID', @FormID, N'Create user', @LanguageID, NULL