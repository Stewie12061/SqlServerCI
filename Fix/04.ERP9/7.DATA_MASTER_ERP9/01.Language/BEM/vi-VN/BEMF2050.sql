-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2050 - BEM
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
SET @FormID = 'BEMF2050';

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng năm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày check in';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày check out';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi phát hành chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục dịch nội dung chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu dịch chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.WorkProposal', @FormID, @LanguageValue, @Language;

