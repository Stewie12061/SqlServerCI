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
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF0000';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'System Settings';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.SOF0000Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.CurrencyID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Inventory Type';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.InventoryTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Voucher Type Title';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.VoucherTypeTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.VoucherTypeID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Voucher Type Name';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.VoucherTypeName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Settings';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0000.Settings' , @FormID, @LanguageValue, @Language;

 