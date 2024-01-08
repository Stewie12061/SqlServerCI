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


SET @Language = 'en-US';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1083'

SET @LanguageValue  = N'Update the definition of management expenditures'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DivisionID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CoefficientID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.CoefficientID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'FieldName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.FieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CoefficientName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.CoefficientName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Caption'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsUsed'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsConstant'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.IsConstant',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ValueOfConstant'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.ValueOfConstant',  @FormID, @LanguageValue, @Language;
