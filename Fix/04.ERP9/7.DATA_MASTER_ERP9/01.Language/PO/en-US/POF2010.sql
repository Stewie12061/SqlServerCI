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
SET @Language = 'en-US' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2010';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some bills';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bill of lading code';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of containers';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.QuantityContainer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Towing cost 1 Cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.CostTowing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost of towing Cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.CostAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lifting cost 1 Cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContLiftingCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost of lifting Cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContLiftingCostsAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lower cost 1 Cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContUnloadingCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost of lowering Cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContUnloadingCostsAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other costs 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Make money 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts1Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other expenses 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Make money 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts2Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other expenses 3';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Make money 3';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts3Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost content';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DescriptionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2010.POrderID', @FormID, @LanguageValue, @Language;

