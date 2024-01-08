-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1261- CI
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
SET @FormID = 'CIF1261';

SET @LanguageValue = N'根據發票金額促銷活動之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'促銷代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'從價值';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.FromValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到的價值';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.ToValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 折扣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣合计';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.PromoteQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'促銷名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.PromoteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.PromotionTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'促銷類型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.Text', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.APKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象類型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1261.ObjectTypeID', @FormID, @LanguageValue, @Language;

