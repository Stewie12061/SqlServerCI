
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2241 - WM
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
SET @FormID = 'WMF2241';


SET @LanguageValue = N'Cập nhật phiếu kiểm kê hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.DebitAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.AdjustQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.AdjustUnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.AdjutsOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.EmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2241.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;