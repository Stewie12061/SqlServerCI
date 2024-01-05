-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF1002 - BEM
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
SET @FormID = 'BEMF1002';

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'非表示';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共通';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.ThongTinLoaiphi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金類の詳細';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.Title', @FormID, @LanguageValue, @Language;
