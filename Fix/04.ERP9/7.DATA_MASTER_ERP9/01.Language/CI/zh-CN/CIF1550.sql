-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1550- CI
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
SET @FormID = 'CIF1550';

SET @LanguageValue = N'預計成本價一覽表';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'語言代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價目表名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.IsDisabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1550.LastModifyUserID', @FormID, @LanguageValue, @Language;

