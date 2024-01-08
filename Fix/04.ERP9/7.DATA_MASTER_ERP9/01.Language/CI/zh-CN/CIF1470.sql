-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1470- CI
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
SET @FormID = 'CIF1470';

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'語言代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價目表名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'根據匯率計算價格';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsTaxIncluded', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsSetBonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.PriceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.MasterDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsTaxIncludedTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsPlanPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsPurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsInheritCost', @FormID, @LanguageValue, @Language;

