
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2261 - WM
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
SET @FormID = 'WMF2261';

SET @LanguageValue = N'Cập nhật số dư hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hạch toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.LimitDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.WareHouseName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.ConvertedUnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.ConvertedUnitName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.Operator.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.FormulaDes.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.DebitAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2261.ChooseInventoryList' , @FormID, @LanguageValue, @Language;