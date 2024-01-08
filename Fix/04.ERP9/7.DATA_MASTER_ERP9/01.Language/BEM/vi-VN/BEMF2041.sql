-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2041 - BEM
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
SET @FormID = 'BEMF2041';

SET @LanguageValue = N'Cập nhật báo cáo công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkResults', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.SubsectionName', @FormID, @LanguageValue, @Language;

