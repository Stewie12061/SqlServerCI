-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2243- WM
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
SET @FormID = 'WMF2243';

SET @LanguageValue = N'產品盤點';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Inventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'時間資訊';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.VarChar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'盤點時期';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'盤點日期';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.DateTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.ListInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.TranYear', @FormID, @LanguageValue, @Language;

