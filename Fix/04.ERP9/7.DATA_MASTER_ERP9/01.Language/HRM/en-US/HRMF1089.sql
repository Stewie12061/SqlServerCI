-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1089- HRM
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
SET @FormID = 'HRMF1089'

SET @LanguageValue  = N'Update the definition of disciplinary action'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DivisionID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'FormID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.FormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'FormName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.FormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Level',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsReward'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.IsReward',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsNotReward'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.IsNotReward',  @FormID, @LanguageValue, @Language;
