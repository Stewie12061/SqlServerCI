-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2182- M
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
SET @FormID = 'MF2182';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết yêu cầu đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.VoucherDate ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng dưới xưởng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.InventoryFactoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tem nhãn hiệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.BranchTem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Nest Code';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.NestCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ hàng/thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set/thùng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Total', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu hộp đựng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Colors', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng màu';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.NumberColor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Branch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cuối ship hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CancelDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.YeuCauDongGoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết yêu cầu đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.ChiTietYeuCauDongGoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2182.DinhKem', @FormID, @LanguageValue, @Language;

