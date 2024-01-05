-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2191- M
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
SET @FormID = 'MF2191';

SET @LanguageValue = N'Mã thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.BoxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.BoxName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.BoxSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phụ liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.ComponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phụ liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.ComponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.ComponentQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt (Giấy SX)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.CutM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt (Giấy sóng)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.CutWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tờ';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ (Giấy  SX)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.SizeM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ (Giấy sóng)';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.SizeWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.TabMT2191', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phụ liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.TabMT2192', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghép khổ';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.TransplantSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách vô hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.WayInside', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.BoxID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.BoxName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InheritVoucher.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2191.InheritVoucher_ID.CB', @FormID, @LanguageValue, @Language;