-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2052 - BEM
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
SET @FormID = 'BEMF2052';

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng năm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày check in';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày check out';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi phí khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi phát hành chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết Phiếu dịch nội dung chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu dịch chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Description', @FormID, @LanguageValue, @Language;

