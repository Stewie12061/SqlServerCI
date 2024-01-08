-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1510- CI
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
SET @FormID = 'CIF1510';

SET @LanguageValue = N'促銷條款定义清单';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工具代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用具工具名称';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工具類型程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工具類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計量單位名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.IsDisable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.LastModifyDate', @FormID, @LanguageValue, @Language;

