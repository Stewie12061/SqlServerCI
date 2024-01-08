-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1001- CI
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
SET @FormID = 'CIF1001';

SET @LanguageValue = N'部門之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應付賬戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.PayableAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'個人所得稅賬戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.PITAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tk管理薪資成本';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.ManagerExpAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附組織結構圖';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.IsOrganizationDiagram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1001.DivisionID', @FormID, @LanguageValue, @Language;

