-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1072- HRM
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
SET @FormID = 'HRMF1072';

SET @LanguageValue  = N'Labor contract'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SignDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.SignDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SignPersonID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.SignPersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'WorkAddress';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.WorkAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'WorkTime';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.WorkTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IssueTool';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.IssueTool' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conveyance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Conveyance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PayForm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.PayForm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RestRegulation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.RestRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ContractTypeID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.ContractTypeID' , @FormID, @LanguageValue, @Language;