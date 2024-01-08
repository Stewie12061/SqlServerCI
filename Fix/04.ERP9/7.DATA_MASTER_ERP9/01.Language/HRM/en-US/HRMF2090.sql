-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2090- HRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2090';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training recommendation code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.ProposeAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsAll';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyUserID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritID1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritName';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InhertiI D2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritID2', @FormID, @LanguageValue, @Language;

