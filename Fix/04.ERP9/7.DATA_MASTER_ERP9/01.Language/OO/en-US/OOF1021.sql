-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1021- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1021';

SET @LanguageValue = N'Update working process';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step and Task of Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.TreeViewTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1021.TaskSampleName', @FormID, @LanguageValue, @Language;
