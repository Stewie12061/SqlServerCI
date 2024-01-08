-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1040- CRM
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
SET @FormID = 'CRMF1040';

SET @LanguageValue = N'List of sale stages';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.StageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order NO';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.StageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.IsSystem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.StageTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1040.LastModifyUserName', @FormID, @LanguageValue, @Language;