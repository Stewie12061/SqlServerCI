-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1061- OO
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
SET @FormID = 'OOF1061';

SET @LanguageValue = N'Task Sample Update';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Execution time (hour)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block type ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskBlockTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TargetTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TargetTypeName.CB', @FormID, @LanguageValue, @Language;