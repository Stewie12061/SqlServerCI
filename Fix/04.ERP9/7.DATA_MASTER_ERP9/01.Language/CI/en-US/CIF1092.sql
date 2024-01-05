------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1092 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1092'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1092';

EXEC ERP9AddLanguage @ModuleID, N'CIF1092.Title', @FormID, N'View details type of object increase automatically', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.S', @FormID, N'Classification code', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.SName', @FormID, N'Classification name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.STypeID', @FormID, N'Classification', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.TypeID', @FormID, N'Type of object', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.Disabled', @FormID, N'Disabled', @LanguageID, NULL

EXEC ERP9AddLanguage @ModuleID, N'CIF1092.LastModifyDate', @FormID, N'Last modify date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.LastModifyUserID', @FormID, N'Last modify user', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.CreateDate', @FormID, N'Create date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.CreateUserID', @FormID, N'Create user', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1092.ThongMaPhanTich', @FormID, N'Information classification code', @LanguageID, NULL
