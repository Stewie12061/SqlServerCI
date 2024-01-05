-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF3001 - BEM
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
SET @FormID = 'BEMF3001';

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal name';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Proposal Voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DivisionID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.EmployeeName', @FormID, @LanguageValue, @Language;