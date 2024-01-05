-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2031 - BEM
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
SET @FormID = 'BEMF2031';

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công ty đối tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm đến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công ty đối tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.PartnerCompanies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung công việc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkProposal', @FormID, @LanguageValue, @Language;

