-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF3003 - BEM
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
SET @FormID = 'BEMF3003';

SET @LanguageValue = N'銀行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.BankAccoutID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.BankID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.SupplierCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.SupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払リスト報告';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払リスト報告';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.Tittle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.ToDate', @FormID, @LanguageValue, @Language;
