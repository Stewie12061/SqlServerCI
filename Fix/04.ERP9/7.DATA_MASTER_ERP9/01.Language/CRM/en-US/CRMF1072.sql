-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1072- CRM
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
SET @FormID = 'CRMF1072';

SET @LanguageValue = N'Business line view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business line ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common law';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1072.TabCRMT00003', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Business line information';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1072.ThongTinLinhVucKinhDoanh', @FormID, @LanguageValue , @Language;