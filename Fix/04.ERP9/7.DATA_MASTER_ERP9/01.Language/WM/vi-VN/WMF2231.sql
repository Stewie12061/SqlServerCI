
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2231 - WM
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
SET @FormID = 'WMF2231';


SET @LanguageValue = N'Cập nhật chuyển kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.OrderID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ImWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ExWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hạch toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.RefNo01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.RefNo02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ConvertedUnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.SourceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chứng từ nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ReVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.LimitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tồn cuối';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ActEndQty',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.OrderID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.OrderDate.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Notes.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ObjectID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ObjectName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người lập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người lập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.AccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.AccountName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ConvertedUnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ConvertedUnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Operator.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải công thức';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.FormulaDes.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.StandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ChooseInventoryList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherNo.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.DebitAccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.CreditAccountName',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ReSourceNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ReVoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.UnitPrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ReQuantity.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.DeQuantity.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ReVoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn cuối (ĐVT chuẩn)';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EndQuantity.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.LimitDate.CB', @FormID, @LanguageValue, @Language;
