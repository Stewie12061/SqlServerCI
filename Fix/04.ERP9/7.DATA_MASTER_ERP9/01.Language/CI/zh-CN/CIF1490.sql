-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1490- CI
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
SET @FormID = 'CIF1490';

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼之设立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品群（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域訂單';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.OrdersArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼類型的名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaTypeName', @FormID, @LanguageValue, @Language;

