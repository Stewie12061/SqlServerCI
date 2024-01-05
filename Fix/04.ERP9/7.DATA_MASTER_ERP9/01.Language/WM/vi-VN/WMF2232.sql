
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2232 - WM
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
SET @FormID = 'WMF2232';


SET @LanguageValue = N'Xem chi tiết chuyển kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chuyển kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.ThongTinChuyenKho' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.RefNo01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.RefNo02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.OrderID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.ImWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.ExWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hạch toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.ChiTietChuyenKho',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.SourceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.LimitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.DebitAccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.CreditAccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2232.DivisionID' , @FormID, @LanguageValue, @Language;