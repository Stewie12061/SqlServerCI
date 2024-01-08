------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000 - CRM
--            Ngày tạo                                    Người tạo
--            2/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF9020'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9020';

EXEC ERP9AddLanguage @ModuleID, N'CRMF9020.Title', @FormID, N'Select Serminar - Thematic', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9020.OrderNo', @FormID, N'Order No', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9020.ID', @FormID, N'Code', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9020.Description', @FormID, N'Description', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMF9020.DescriptionE', @FormID, N'Description(Eng)', @LanguageID, NULL




