-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1081- HRM
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
SET @FormID = 'HRMF1081'

SET @LanguageValue  = N'Update the definition of management expenditures'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DivisionID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TargetTypeID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.TargetTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TargetName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.TargetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Caption'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsUsed'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsUsed'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.IsUsed',  @FormID, @LanguageValue, @Language;
