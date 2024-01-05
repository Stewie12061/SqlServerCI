------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0006 - CRM 
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
SET @FormID = 'SOF0006';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0006.SOF0006Title' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0006.InventoryTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0006.InventoryTypeName' , @FormID, @LanguageValue, @Language;


 