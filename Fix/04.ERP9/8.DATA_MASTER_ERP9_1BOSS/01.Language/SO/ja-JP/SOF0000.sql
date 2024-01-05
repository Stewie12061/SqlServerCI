------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0000 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'ja-JP';
SET @ModuleID = 'SO';
SET @FormID = 'SOF0000';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Thiết lập hệ thống';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.SOF0000Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.CurrencyID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.InventoryTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Thông tin loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.VoucherTypeTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.VoucherTypeID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tên loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.VoucherTypeName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thiết lập';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.Settings' , @FormID, @LanguageValue, @Language;

 