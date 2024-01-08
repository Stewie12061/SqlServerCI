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
SET @FormID = 'HRMF1085'

SET @LanguageValue  = N'更新勞動合約代碼分類定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分配'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.STypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分類代碼'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分類名稱'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.SName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'1. 分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.PhanLoai1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'2. 分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.PhanLoai2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'3. 分類'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.PhanLoai3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'建立使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'上次修改日期'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'最後修改使用者'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1085.LastModifyUserID',  @FormID, @LanguageValue, @Language;
