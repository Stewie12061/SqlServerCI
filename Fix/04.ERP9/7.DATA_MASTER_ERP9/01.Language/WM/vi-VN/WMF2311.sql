-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2311- WM
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
SET @ModuleID = N'WM'
SET @FormID = 'WMF2311'

SET @LanguageValue = N'Cập nhật phiếu tháo dỡ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 1';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ref01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 2';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ref02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ định mức';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho nhập';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ImWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho nhập';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ImWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thủ kho';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ImStoreManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thủ kho';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ExStoreManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.CrebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho xuất';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ExWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ nhập';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ReVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.SourceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn sử dụng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.LimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ không định khoản sổ cái';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.IsLedger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 6';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 7';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 8';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 9';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.WareHouseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.WareHouseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ApportionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ApportionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã TK';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên TK';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thủ kho';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thủ kho';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thêm nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2311.ChooseInventoryList', @FormID, @LanguageValue, @Language;



