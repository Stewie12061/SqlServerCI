-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2004- PO
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
SET @FormID = 'POF2004';

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery plan template';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.FormPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planning step';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned delivery date';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanReceivingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.AmountPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual delivery date';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.ReceivingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.APK', @FormID, @LanguageValue, @Language;

