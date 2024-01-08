DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'ja-JP';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1301'
---------------------------------------------------------------

SET @LanguageValue  = N'在庫ノルムの更新'
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'定格型コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'標準型名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最低限';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最大';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'注文レベルのリセット';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'シェアード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'表示されない';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'造物主';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyUserID',  @FormID, @LanguageValue, @Language;