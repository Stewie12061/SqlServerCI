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


SET @Language = 'zh-CN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1088'

SET @LanguageValue  = N'更新離職原因定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分配'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'辭職'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.QuitJobID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'退出工作名稱'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.QuitJobName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'殘障人士'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'上次修改日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最後修改使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'類型'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.TypeID',  @FormID, @LanguageValue, @Language;
