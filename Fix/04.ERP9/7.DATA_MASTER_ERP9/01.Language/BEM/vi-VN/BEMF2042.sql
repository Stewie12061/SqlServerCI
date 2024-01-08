-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2042 - BEM
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
SET @FormID = 'BEMF2042';

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết báo cáo công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkResults', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ContentArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Description', @FormID, @LanguageValue, @Language;

