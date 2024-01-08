
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
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
SET @FormID = 'POSF0081';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Cập nhật phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nộp tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.CashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bán/đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherNoInherited' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ShopName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.InheritButton' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền phải thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.InheritDepositButton' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.DepositVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền phải thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberIDOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.MemberNameOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã HTTT';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PaymentName01.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên HTTT';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.PaymentName02.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Có kế thừa phiếu đặt cọc?';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.IsDeposit.POS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn từ phiếu yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.InheritServiceRequest' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0081.ServiceRequestVoucherNo' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;