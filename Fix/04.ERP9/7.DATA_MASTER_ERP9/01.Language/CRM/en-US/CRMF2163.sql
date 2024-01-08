-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2163- OO
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2163';

SET @LanguageValue = N'Choose Require Supported';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline Request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2163.ContactName', @FormID, @LanguageValue, @Language;

