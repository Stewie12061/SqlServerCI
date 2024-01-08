-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2021 - BEM
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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2021';

SET @LanguageValue = N'Advance currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BS trip proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.NoteFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rank ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rank';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The others';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update travel voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted Amount (VNĐ)';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ConvertedAmount2012', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Ana Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Ana Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaName.CB', @FormID, @LanguageValue, @Language;

------------------------ Modified by Tấn Thành on 09/09/2020 ---------------------------------------

SET @LanguageValue = N'Duration work';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DurationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working object';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ObjectTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.WorkPlaceTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvancePaymentTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalCostTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.PurposeTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher information';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval information';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ApprovalInformationTitle', @FormID, @LanguageValue, @Language;