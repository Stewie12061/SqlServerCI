-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2040 - BEM
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
SET @FormID = 'BEMF2040';

SET @LanguageValue = N'Danh mục báo cáo công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMT2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkResults', @FormID, @LanguageValue, @Language;

