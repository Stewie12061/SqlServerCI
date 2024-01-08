-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1301- CI
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
SET @FormID = 'CIF1432';

SET @LanguageValue = N'庫存用量之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定量类代码';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最小额度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大额度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'再訂購之产品級別';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.APK', @FormID, @LanguageValue, @Language;

