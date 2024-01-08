-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1087- HRM
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


SET @Language = 'en-US';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1087'

SET @LanguageValue  = N'Updated contract type definitions'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DivisionID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ContractTypeID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.ContractTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ContractTypeName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.ContractTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Months'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Months',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsWarning'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.IsWarning',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'WarningDays'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.WarningDays',  @FormID, @LanguageValue, @Language;
