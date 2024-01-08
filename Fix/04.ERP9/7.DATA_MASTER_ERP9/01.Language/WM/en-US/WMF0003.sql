-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF0003- WM
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
SET @Language = 'en-US' 
SET @ModuleID = 'WM';
SET @FormID = 'WMF0003';

SET @LanguageValue = N'Accounting period';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.FromInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From item';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.FromInventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate prices regardless of warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.AllWare', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.ToInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Go to the item';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.ToInventoryName', @FormID, @LanguageValue, @Language;

