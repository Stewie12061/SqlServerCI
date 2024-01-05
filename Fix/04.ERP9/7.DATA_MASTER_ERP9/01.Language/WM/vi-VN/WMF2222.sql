
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2222- WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2222';

SET @LanguageValue = N'SL hiện có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sẵn sàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.AvailableQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.ButtonChoose' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.ButtonShow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LevelDetailID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LevelDetailName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vị trí';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LocationID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vị trí';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LocationName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL nhập/xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.OrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL tối đa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.QuantityMax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn vị trí kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.WarehouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng còn lại';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.RemainQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.TotalQuantity' , @FormID, @LanguageValue, @Language;

