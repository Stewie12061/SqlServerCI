-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2020 - BEM
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
SET @FormID = 'BEMF2020';

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đất nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp bậc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp bậc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đi cùng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục phiếu thanh toán đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TypeBSTrip', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2020.VoucherNo', @FormID, @LanguageValue, @Language;

