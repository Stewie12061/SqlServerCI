-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2153';

SET @LanguageValue = N'Chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh nhận';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.StudentIDReceiver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh nhận';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.StudentNameReceiver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.PaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.AmountTransfer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chuyển nhượng theo tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.IsTransferMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tháng chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.MonthReserve', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2153.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;