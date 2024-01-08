------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1091 - CRM
--            Ngày tạo                                    Người tạo
--            06/06/2017									Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1091'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1091';

EXEC ERP9AddLanguage @ModuleID, N'CIF1091.Title', @FormID, N'Update type of object increase automatically', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.S', @FormID, N'Classification code', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.SName', @FormID, N'Classification name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.STypeID', @FormID, N'Classification', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.IsCommon', @FormID, N'Common', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeID', @FormID, N'Type of object', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.Disabled', @FormID, N'Disabled', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeName.CB', @FormID, N'Type name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeID.CB', @FormID, N'Type ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeName.CB', @FormID, N'Type name', @LanguageID, NULL