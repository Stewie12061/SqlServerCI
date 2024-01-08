------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF1001 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF1001';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ShopName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DisabledEvent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EventBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EventEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.GeneralInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CommodityInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên thuộc event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EmployeesOfEventTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.BillingInformation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo cột giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PriceColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cột giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo bảng giá chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo bảng giá gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PackagePriceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsPackage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo bảng giá khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PromotePriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi tặng hàng theo hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PromoteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kho chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ComWarehouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Selected' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người dùng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người dùng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.TaxDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.TaxCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PayDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PayCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CostDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CoseCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nhập';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu hàng bán trả lại';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu kiểm kê kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nhật ký';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị xuất trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu chệnh lệch';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị vận chuyển nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu vận chuyển nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType11' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType12' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu số dư hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType13' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType14' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị chi';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType16' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType17' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType18' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType19' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bút toán tổng hợp';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType20' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsPromote' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsPromote' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsPromote' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.FromDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ToDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PackagePriceID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PackagePriceName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.BeginDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EndDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.WareHouseName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khoản có';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CostCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tài khoản thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DebitInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tài khoản trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PayBillInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tài khoản hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DebitInfor2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tài khoản chi phí';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CostBillInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi tặng hàng theo hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.InvoicePromotionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsInvoicePromotionID' , @FormID, @LanguageValue, @Language;