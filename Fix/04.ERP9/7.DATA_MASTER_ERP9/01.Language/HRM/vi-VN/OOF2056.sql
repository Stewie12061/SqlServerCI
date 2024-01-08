-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2056 - HRM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
    - Tiếng Việt: vi-VN 
    - Tiếng Anh: en-US 
    - Tiếng Nhật: ja-JP
    - Tiếng Trung: zh-CN
*/

SET @Language = 'vi-VN' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2056';

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ApprovePersonNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trang thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ApprovePersonStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankAccountNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.BankName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản trung gian';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.MediumAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phương thức';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phương thức';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.Title', @FormID, @LanguageValue, @Language;

