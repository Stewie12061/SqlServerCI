-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1088- HRM
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
SET @FormID = 'HRMF1088'

SET @LanguageValue  = N'Update the definition of reasons for leaving'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DivisionID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'QuitJobID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.QuitJobID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'QuitJobName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.QuitJobName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TypeID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.TypeID',  @FormID, @LanguageValue, @Language;
