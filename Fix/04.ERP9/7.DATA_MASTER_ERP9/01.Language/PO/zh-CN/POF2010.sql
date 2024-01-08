-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2010- PO
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
SET @FormID = 'POF2010';

SET @LanguageValue = N'費用信息';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增加了自动序列号，发票号';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提單代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱數量';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.QuantityContainer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'拖拉一個集裝箱的費用 ';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.CostTowing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'拖拉集裝箱的費用 ';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.CostAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'起重一個集裝箱的費用';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContLiftingCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'起重集裝箱的費用';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContLiftingCostsAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降低一個集裝箱的費用';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContUnloadingCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'降低集裝箱的費用';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContUnloadingCostsAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他費用1';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本1';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts1Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他費用2';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本2';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts2Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他費用3';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本3';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts3Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本內容';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DescriptionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.POrderID', @FormID, @LanguageValue, @Language;

