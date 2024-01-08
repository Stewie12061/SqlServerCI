-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF1001 - BEM
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
SET @FormID = 'BEMF1001';

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'非表示';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共通';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種更新';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.Title', @FormID, @LanguageValue, @Language;
