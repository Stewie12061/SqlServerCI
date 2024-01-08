
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2222- WM
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
SET @FormID = 'WMF2222';

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已準備好之數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.AvailableQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'選擇';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.ButtonChoose' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'展示';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.ButtonShow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LevelDetailID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LevelDetailName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立结转';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LocationID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置名稱';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.LocationName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'導入/導出 數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.OrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.QuantityMax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫位置之選擇';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫名稱';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.WarehouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'剩下数量';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.RemainQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF2222.TotalQuantity' , @FormID, @LanguageValue, @Language;

