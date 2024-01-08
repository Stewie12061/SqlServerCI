-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2225- M
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'M';
SET @FormID = 'MF2225';

SET @LanguageValue = N'Chọn mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.InventoryName ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá nhập';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2225.IsStocked', @FormID, @LanguageValue, @Language;