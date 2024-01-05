------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF3016 - SO
--            Ngày tạo                                    Người tạo
--            01/09/2020								  Đình Hoà
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF3016';

EXEC ERP9AddLanguage @ModuleID, N'SOF3016.Title', @FormID, N'Report Receiving Situation', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF3016.Ana01Name', @FormID, N'Voucher No', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF3016.OrderDate', @FormID, N'Order Date', @LanguageID, NULL
