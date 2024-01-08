-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF1012- WM
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
SET @FormID = 'WMF1012';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse location code';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LocationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name1';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.Level1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name2';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.Level2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name3';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.Level3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name4';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.Level4ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum quantity';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.QuantityMax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Current quantity in stock';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LevelName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LevelName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LevelName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.LevelName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF1012.InventoryName', @FormID, @LanguageValue, @Language;

