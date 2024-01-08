------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000 - CRM
--            Ngày tạo                                    Người tạo
--            23/02/2021								  Đình Hòa
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @LanguageID = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CMNF9004';

EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.Title', @FormID, N'Select Object', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.DivisionID', @FormID, N'Division', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.ObjectTypeID', @FormID, N'Object Type', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.ObjectID', @FormID, N'Object ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.ObjectName', @FormID, N'Object Name', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.Address', @FormID, N'Address', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.Tel', @FormID, N'Tel', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.Email', @FormID, N'Email', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.VATNo', @FormID, N'VAT No', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.Fax', @FormID, N'Fax', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'CMNF9004.Contactor', @FormID, N'Contactor', @LanguageID, NULL