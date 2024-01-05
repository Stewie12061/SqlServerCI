-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2051 - BEM
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
SET @FormID = 'BEMF2051';

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng năm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày check in';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày check out';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi phát hành chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật dịch nội dung chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu dịch chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.WorkProposal', @FormID, @LanguageValue, @Language;

