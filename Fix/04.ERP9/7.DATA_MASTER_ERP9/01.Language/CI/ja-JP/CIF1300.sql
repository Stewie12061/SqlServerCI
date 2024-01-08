DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'ja-JP';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1300'
---------------------------------------------------------------

SET @LanguageValue  = N'在庫ノルムタイプの一覧'
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'定格型コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'標準型名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最低限';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最大';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'注文レベルのリセット';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'シェアード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'表示されない';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'造物主';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.LastModifyUserID',  @FormID, @LanguageValue, @Language;