-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2032 - BEM
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
SET @FormID = 'BEMF2032';

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công ty đối tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm đến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công ty đối tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.PartnerCompanies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến Ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung công việc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Description', @FormID, @LanguageValue, @Language;

