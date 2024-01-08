
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2251 - WM
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
SET @FormID = 'WMF2251';

SET @LanguageValue = N'Cập nhật điều chỉnh kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.RefNo01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.RefNo02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu kiêm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Inventory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tất cả';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.All' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tăng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Decrease' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giảm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Increase' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết phiếu kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.TabWMT2251' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.IsChoose' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.DebitAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.WMT2252_DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AdjustQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AdjustUnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AdjutsOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chỉnh tăng/giảm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.TabWMT2252' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chỉnh giảm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AdjustDown' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chỉnh tăng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AdjustUp' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.CreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.CreditAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người lập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người lập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.EmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.InventoryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.InventoryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.UnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.UnitName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.ConversionFactor.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tùy chọn điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.Option' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2251.EmployeeName' , @FormID, @LanguageValue, @Language;