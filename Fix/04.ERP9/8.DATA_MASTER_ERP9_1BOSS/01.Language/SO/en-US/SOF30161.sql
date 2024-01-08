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
SET @FormID = 'SOF30161';

EXEC ERP9AddLanguage @ModuleID, N'SOF30161.Title', @FormID, N'Selecting the orders', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF30161.VoucherNo', @FormID, N'Voucher No', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF30161.OrderDate', @FormID, N'Order Date', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF30161.ObjectID', @FormID, N'Object ID', @LanguageID, NULL
EXEC ERP9AddLanguage @ModuleID, N'SOF30161.ObjectName', @FormID, N'Object Name', @LanguageID, NULL
