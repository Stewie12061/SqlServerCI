DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'ja-JP';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1302'
---------------------------------------------------------------

SET @LanguageValue  = N'在庫ノルムの詳細の表示'
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'定格型コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'標準型名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最低限';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最大';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'注文レベルのリセット';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'シェアード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'表示されない';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'造物主';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ノルム コード情報';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ThongTinMaDinhMuc',  @FormID, @LanguageValue, @Language;