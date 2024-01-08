-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF0011 - BEM
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
SET @FormID = 'BEMF0011';

SET @LanguageValue = N'アカウント番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アカウント名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.CostAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.CostAnaTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.DepartmentAnaTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析コードに従ってアカウントを設定します';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0011.Title', @FormID, @LanguageValue, @Language;
