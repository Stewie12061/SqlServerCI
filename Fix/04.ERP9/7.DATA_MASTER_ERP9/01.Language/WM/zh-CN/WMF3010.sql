-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF3010 - WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF3010';

SET @LanguageValue = N'按倉庫進出口報告';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告代碼';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.ReportID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告名稱';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.ReportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.ReportTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過濾條件';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'列印範本';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GetPathTemplate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務組';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2級組';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告組';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.IsGroup' , @FormID, @LanguageValue, @Language;