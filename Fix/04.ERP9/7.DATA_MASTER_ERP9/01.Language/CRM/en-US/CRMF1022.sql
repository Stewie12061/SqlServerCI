-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1022- CRM
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
SET @FormID = 'CRMF1022';

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.LeadTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.LeadTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source information';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1022.ThongTinPhanLoaiDauMoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1022.LastModifyUserName', @FormID, @LanguageValue, @Language;