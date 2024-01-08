-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1492- CI
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
SET @FormID = 'CIF1492';

SET @LanguageValue = N'銷售訂單分析代碼詳細之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼之设立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品群（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.OrdersArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼類型的名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaTypeName', @FormID, @LanguageValue, @Language;

