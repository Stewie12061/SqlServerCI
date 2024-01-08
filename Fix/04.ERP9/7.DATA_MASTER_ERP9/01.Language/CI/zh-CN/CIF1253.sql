-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1253- CI
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
SET @FormID = 'CIF1253';

SET @LanguageValue = N'銷售價格表詳細資料（賣出）之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'語言代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建議零售價';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.RetailPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'批發價';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.WholesalePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最低價格';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.MinPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最高价';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.MaxPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 折扣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 降价1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降价 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 降价2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降价 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 降价3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降价 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 降价4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降价 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 降价5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降价 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DetailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 增值税';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅金额';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.VATAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總金額';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryName', @FormID, @LanguageValue, @Language;

