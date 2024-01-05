------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF9003 - CRM 
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
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF9003';
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Chọn bộ định mức (KIT)';
EXEC ERP9AddLanguage @ModuleID, 'SOF9003.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã combo';
EXEC ERP9AddLanguage @ModuleID, 'SOF9003.KITID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên combo';
EXEC ERP9AddLanguage @ModuleID, 'SOF9003.KITName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'SOF9003.InventoryGiftID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'SOF9003.InventoryGiftName' , @FormID, @LanguageValue, @Language;