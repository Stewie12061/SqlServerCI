-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1421- CI
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
SET @FormID = 'CIF1421';

SET @LanguageValue = N'產品規格之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參數名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'规格类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.StandardTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1421.Notes', @FormID, @LanguageValue, @Language;

