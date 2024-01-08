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
SET @Language = 'en-US' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2033';

SET @LanguageValue = N'Project Code';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of project';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCOrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PLU';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCModel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manufacturer';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCMadeby', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commodities';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCInvenType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Origin';
EXEC ERP9AddLanguage @ModuleID, 'POF2033.ASCMadeIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment header';
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

