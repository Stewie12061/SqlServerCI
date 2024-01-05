------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0001 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF0029';

SET @LanguageValue = N'Cập nhật thông tin chi tiết mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.ShipQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.UnitID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Giá xuất';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.SalePrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.DescriptionD' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'POSF0029.WarrantyCard' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;