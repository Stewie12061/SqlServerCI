
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2252 - WM
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
SET @FormID = 'WMF2252';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết điều chỉnh kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin điều chỉnh kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.ThongTinDieuChinh' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết điều chỉnh kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.ChiTietDieuChinh' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.RefNo01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.RefNo02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.KindVoucherID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giảm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Decrease' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tăng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Increase' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.DebitAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.WMT2252_DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.AdjustQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.AdjustUnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.AdjutsOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chỉnh giảm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.AdjustDown' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chỉnh tăng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.AdjustUp' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.CreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.CreditAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Notes.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.Attacth.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.LastModifyUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2252.LastModifyUserName' , @FormID, @LanguageValue, @Language;