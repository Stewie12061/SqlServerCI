-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1302- CI
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
SET @FormID = 'CIF1302';

SET @LanguageValue = N'庫存额定詳細之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定量类代码';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最小额度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大额度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'再訂購之产品級別';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.APK', @FormID, @LanguageValue, @Language;

