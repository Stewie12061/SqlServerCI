
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
SET @FormID = 'POSF0080';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Danh sách phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nộp tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.CashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Là tiền cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.IsDeposit' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.Amount' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.MemberIDOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái hủy';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.DeleteFlg' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0080.InheritVoucher' , @FormID, @LanguageValue, @Language;



------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;