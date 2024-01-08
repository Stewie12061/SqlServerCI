------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1090 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1090'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1090';

EXEC ERP9AddLanguage @ModuleID, N'CIF1090.Title', @FormID, N'Type of object increase automatically', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.S', @FormID, N'Classification code', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.SName', @FormID, N'Classification name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.STypeID', @FormID, N'Classification', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeID', @FormID, N'Type of object', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeName.CB', @FormID, N'Type name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeID.CB', @FormID, N'Type ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeName.CB', @FormID, N'Type name', @LanguageID, NULL