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
SET @Language = 'zh-CN' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2004';

SET @LanguageValue = N'更新收貨計劃進度';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交付計劃模板';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.FormPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃步驟';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃收貨日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanReceivingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃金額';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.AmountPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際收貨日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.ReceivingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際金額';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.APK', @FormID, @LanguageValue, @Language;

