-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2033- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2033';

SET @LanguageValue = N'從項目繼承采購申請';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'项目代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCOrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'普魯';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模型';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCModel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'製造商';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCMadeby', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCInvenType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原産地';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCMadeIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備標題';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCEquipment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCOrderDetail', @FormID, @LanguageValue, @Language;

