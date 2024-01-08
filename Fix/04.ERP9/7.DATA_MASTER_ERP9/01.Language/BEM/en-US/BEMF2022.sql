-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2022 - BEM
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
SET @FormID = 'BEMF2022';

SET @LanguageValue = N'Team ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The others';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail information';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information master';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ThongTinMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'See details travel voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee 5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson01Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BS trip proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance currency name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency 5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note Fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.NoteFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rank';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rank';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TypeBSTrip';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TypeBSTripName', @FormID, @LanguageValue, @Language;

------------------------ Modified by Tấn Thành on 09/09/2020 ---------------------------------------

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.PurposeWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.NoteTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;