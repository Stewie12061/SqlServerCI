-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1330- CI
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1330';

SET @LanguageValue = N'对象自動代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'新建自动代码';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsAutomatic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分类 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分类 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分类 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'显示格式';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小数位数分隔';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重置自增指数';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsSeparator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小数长度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.APK', @FormID, @LanguageValue, @Language;

