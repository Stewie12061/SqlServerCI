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


SET @Language = 'zh-CN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1087'

SET @LanguageValue  = N'更新了合約類型定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分配'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'合約類型'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.ContractTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'合約類型名稱'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.ContractTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'殘障人士'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'上次修改日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最後修改使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'幾個月'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Months',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'是警告'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.IsWarning',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'警告日'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.WarningDays',  @FormID, @LanguageValue, @Language;
