
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00165 - CRM 
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
SET @FormID = 'POSF00165';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Xem nhanh tồn kho';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.Title' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.InventoryName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã kho';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.WareHouseID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tên kho';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.WareHouseName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số lượng hàng tồn';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.EndQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Hàng đi đường(đến)';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.PQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Hàng đi đường(đi)';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.SQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Toàn hệ thống';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.IsAllWarehouse' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Màu sắc';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.Color' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Size';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.Size' , @FormID, @LanguageValue, @Language;
