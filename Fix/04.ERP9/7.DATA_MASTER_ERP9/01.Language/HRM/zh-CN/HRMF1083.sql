-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1083- HRM
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
SET @FormID = 'HRMF1083'

SET @LanguageValue  = N'更新了利用率定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'部門編號'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'係數'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.CoefficientID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'欄位名'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.FieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'係數名稱'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.CoefficientName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'標題'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'用來'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'是常數'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.IsConstant',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'常數值'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.ValueOfConstant',  @FormID, @LanguageValue, @Language;
