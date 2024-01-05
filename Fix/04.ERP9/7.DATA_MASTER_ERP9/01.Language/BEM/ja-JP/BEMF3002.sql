-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF3002 - BEM
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
SET @FormID = 'BEMF3002';

SET @LanguageValue = N'国コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.ReportView.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張報告';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.ToDate', @FormID, @LanguageValue, @Language;
