-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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
SET @FormID = 'HRMF1084'

SET @LanguageValue  = N'更新員工代碼分類定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分配'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.STypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分類代碼'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分類名稱'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.SName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'1. 分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.PhanLoai1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'2. 分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.PhanLoai2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'3. 分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.PhanLoai3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'上次修改日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最後修改使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1084.LastModifyUserID',  @FormID, @LanguageValue, @Language;
