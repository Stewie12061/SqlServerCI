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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF3003';

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.SupplierID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment list report';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3003.SupplierName', @FormID, @LanguageValue, @Language;