-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1041- CRM
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
SET @FormID = 'CRMF1041';

SET @LanguageValue = N'Update sales stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.StageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order NO';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.StageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.IsSystem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.StageTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1041.LastModifyUserName', @FormID, @LanguageValue, @Language;