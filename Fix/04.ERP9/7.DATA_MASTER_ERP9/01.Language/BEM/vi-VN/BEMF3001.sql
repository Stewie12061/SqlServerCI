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

SET @Language = 'vi-VN'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF3001';

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo DNTU/DNTT/DNTTTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.EmployeeName', @FormID, @LanguageValue, @Language;