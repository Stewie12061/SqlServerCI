-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1461- CI
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
SET @FormID = 'CIF1461';

SET @LanguageValue = N'售價目表（售完）之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'語言代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價目表名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶群';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'根據匯率計算價格';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅後價格表';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsTaxIncluded', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'人員傭率之設立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsSetBonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.PriceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.MasterDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsTaxIncludedTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承價目表代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'计划价格表';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsPlanPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'採購價格表';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsPurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsInheritCost', @FormID, @LanguageValue, @Language;

