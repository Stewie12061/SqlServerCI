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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1072';

SET @LanguageValue = N'设定默认劳动档案';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'签署日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.SignDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'签署人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.SignPersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作地点';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.WorkAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作时间';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.WorkTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分发工具';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.IssueTool' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交通工具';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Conveyance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'薪酬形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.PayForm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休息制度';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.RestRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注释';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同类型 ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.ContractTypeID' , @FormID, @LanguageValue, @Language;


