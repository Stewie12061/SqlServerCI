-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2192- M
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
SET @FormID = 'MF2192';

SET @LanguageValue = N'Mã thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.BoxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.BoxName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết đóng gói thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.ChiTietDongGoiThanhPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết phụ liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.ChiTietPhuLieu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phụ liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.ComponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phụ liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.ComponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.ComponentQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt (Giấy SX)';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.CutM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cắt (Giấy sóng)';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.CutWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng gói thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.DongGoiThanhPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tờ';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ (Giấy  SX)';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.SizeM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khổ (Giấy sóng)';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.SizeWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghép khổ';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.TransplantSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách vô hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.WayInside', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kích thước thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.BoxSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2192.StatusID', @FormID, @LanguageValue, @Language;