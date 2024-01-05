-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2004 - BEM
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
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2004';

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phương thức';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phương thức';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền còn lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số RingiNo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màn hình kế thừa đề nghị tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DescriptionMaster', @FormID, @LanguageValue, @Language;