-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1042- CRM
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
SET @FormID = 'CRMF1042';

SET @LanguageValue = N'Sales stage view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order NO';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.IsSystem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1042.TabCRMT00003', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Sales stage information';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1042.ThongTinGiaiDoan', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Stage type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.LastModifyUserName', @FormID, @LanguageValue, @Language;