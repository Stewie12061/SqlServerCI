-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1422- CI
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
SET @FormID = 'CIF1422';

SET @LanguageValue = N'商品規格詳細';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參數名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'规格类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.StandardTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1422.Notes', @FormID, @LanguageValue, @Language;

