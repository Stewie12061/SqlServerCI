-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF9004- BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF9004';

SET @LanguageValue = N'住所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メールアドレス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O01ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O02ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O03ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O04ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O05ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'オブジェクトタイプ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象選択';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT No';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ウェブサイト';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Website', @FormID, @LanguageValue, @Language;
