-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2030 - BEM
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
SET @FormID = 'BEMF2030';

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.Title', @FormID, @LanguageValue, @Language;

