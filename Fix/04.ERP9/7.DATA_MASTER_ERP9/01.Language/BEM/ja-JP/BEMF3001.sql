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

SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF3001';

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'従業員コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'従業員';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請書の報告';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3001.TypeID', @FormID, @LanguageValue, @Language;
