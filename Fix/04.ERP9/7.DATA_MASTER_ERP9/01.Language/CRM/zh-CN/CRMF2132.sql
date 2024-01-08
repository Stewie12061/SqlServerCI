-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2132- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2132';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.APKCRMT2120', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取消許可證';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CancellationRecords', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'個人資料 ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ProfileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'個人資料名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ProfileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ChooseProfile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.FieldContractNo', @FormID, @LanguageValue, @Language;

