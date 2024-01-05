-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2010- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2021';

SET @LanguageValue = N'Update Escalation';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Escalation (GSX)';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.EscalationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Escalation Status';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.EscalationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Escalation To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.EscalateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.RequoteNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.Orders.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EscalateTo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.EscalateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disposition';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2021.Disposition.CB', @FormID, @LanguageValue, @Language;


