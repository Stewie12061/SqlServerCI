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


SET @Language = 'zh-CN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1089'

SET @LanguageValue  = N'更新紀律處分的定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分配'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'程式碼'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.FormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'姓名'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.FormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'解釋'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'等級'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Level',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'殘障人士'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'上次修改日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最後修改使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'獎金'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.IsReward',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'紀律'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.IsNotReward',  @FormID, @LanguageValue, @Language;
