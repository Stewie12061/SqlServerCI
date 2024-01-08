
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2242 - WM
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
SET @FormID = 'WMF2242';


SET @LanguageValue = N'Xem chi tiết kiểm kê hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.ThongTinKiemKe' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết phiếu kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.ChiTietKiemKe' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.DebitAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.AdjustQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.AdjustUnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.AdjutsOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.WareHouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.Notes.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.Attacth.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2242.LastModifyUserName' , @FormID, @LanguageValue, @Language;