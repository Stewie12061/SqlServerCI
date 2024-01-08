
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00166 - CRM 
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF00166';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn hàng khuyến mãi theo hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.Title' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.InventoryName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.UnitName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Hàng tặng';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.IsGift' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.Quantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mặt hàng khuyến mãi mặc định';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.RefInventoryID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Chọn hàng khuyến mãi thay thế khác';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.Order' , @FormID, @LanguageValue, @Language;
